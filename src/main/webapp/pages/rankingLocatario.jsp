<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="br.com.sharebike.model.*" %>
<%
    // Verificar se o usuário está logado
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
        return;
    }
    
    // Verificar se o usuário tem permissão para acessar o ranking
    if (!usuarioLogado.isPermissaoRank_user()) {
        response.sendRedirect(request.getContextPath() + "/UsuarioController?action=perfil");
        return;
    }
    
    // Recuperar dados do controller ou redirecionar para carregá-los
    Ranking rankingUsuarioLogado = (Ranking) request.getAttribute("rankingUsuarioLogado");
    Integer posicaoUsuario = (Integer) request.getAttribute("posicaoUsuario");
    List<Ranking> listaRankingTopGeral = (List<Ranking>) request.getAttribute("listaRankingTopGeral");
    List<Ranking> listaRankingTopSemana = (List<Ranking>) request.getAttribute("listaRankingTopSemana");
    List<Ranking> listaRankings = (List<Ranking>) request.getAttribute("listaRankings");
    
    // Se não há dados carregados, redirecionar para o controller para carregar os dados
    if (rankingUsuarioLogado == null && listaRankingTopGeral == null) {
        response.sendRedirect(request.getContextPath() + "/RankingController?action=pagina-locatario");
        return;
    }
    
    // Valores padrão se não houver dados
    if (posicaoUsuario == null) posicaoUsuario = 0;
    if (listaRankingTopGeral == null) listaRankingTopGeral = new ArrayList<>();
    if (listaRankingTopSemana == null) listaRankingTopSemana = new ArrayList<>();
    if (listaRankings == null) listaRankings = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ranking - Locatário</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/ranking.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%) !important;
            min-height: 100vh;
        }
    </style>
</head>
<body>
    <header style="background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%); color: white;">
        <h1><i class="fas fa-trophy"></i> Ranking e Leaderboards</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/UsuarioController?action=perfil"><i class="fas fa-arrow-left"></i> Voltar ao Perfil</a>
            <a href="<%=request.getContextPath()%>/BicicletaController?action=lista-locatario"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="<%=request.getContextPath()%>/FeedbackController?action=pagina-locatario"><i class="fas fa-comment-dots"></i> Dar Feedback</a>
            <a href="<%=request.getContextPath()%>/RankingController?action=pagina-locatario" class="active"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <!-- Mensagem de Sucesso -->
        <% String sucesso = request.getParameter("sucesso"); %>
        <% if (sucesso != null && !sucesso.trim().isEmpty()) { %>
        <div style="background: #d4edda; color: #155724; border: 1px solid #c3e6cb; padding: 1rem; border-radius: 8px; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
            <i class="fas fa-check-circle"></i>
            <%= sucesso %>
        </div>
        <% } %>
        
        <!-- Minha Posição -->
        <div class="stats-dashboard">
            <h2><i class="fas fa-user-circle"></i> Minha Posição no Ranking</h2>
            <% if (rankingUsuarioLogado != null) { %>
            <div class="dashboard-grid">
                <div class="dashboard-stat">
                    <div class="dashboard-value"><%= posicaoUsuario > 0 ? posicaoUsuario + "º" : "N/A" %></div>
                    <div class="dashboard-label">Posição Geral</div>
                </div>
                <div class="dashboard-stat">
                    <div class="dashboard-value">
                        <%= String.format("%.0f", rankingUsuarioLogado.getPontos_rank()) %>
                    </div>
                    <div class="dashboard-label">Total de Pontos</div>
                </div>
                <div class="dashboard-stat">
                    <div class="dashboard-value">
                        <%= String.format("%.0f", rankingUsuarioLogado.getPontosSemana_rank()) %>
                    </div>
                    <div class="dashboard-label">Pontos da Semana</div>
                </div>
            </div>
            <% } else { %>
            <div style="background: #fff3cd; border: 1px solid #ffeaa7; border-radius: 8px; padding: 1.5rem; text-align: center;">
                <i class="fas fa-info-circle" style="color: #856404; font-size: 2rem; margin-bottom: 1rem;"></i>
                <h3 style="color: #856404; margin-bottom: 0.5rem;">Você ainda não possui ranking</h3>
                <p style="color: #856404; margin: 0;">Informe a distância de suas viagens para começar a aparecer no ranking!</p>
            </div>
            <% } %>
        </div>
        
        <!-- Ações Rápidas -->
        <div class="quick-actions" style="background: white; border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);">
            <h3 style="color: #333; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-bolt"></i> Ações Rápidas
            </h3>
            <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                <a href="<%=request.getContextPath()%>/RankingController?action=informar-distancia" style="background: linear-gradient(135deg, #38b2ac, #0d9488); color: white; padding: 0.8rem 1.5rem; border-radius: 10px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='translateY(0)'">
                    <i class="fas fa-route"></i> Informar Distância Percorrida
                </a>
                <a href="<%=request.getContextPath()%>/pages/fazerReserva.jsp" style="background: linear-gradient(135deg, #059669, #047857); color: white; padding: 0.8rem 1.5rem; border-radius: 10px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='translateY(0)'">
                    <i class="fas fa-plus"></i> Nova Reserva
                </a>
            </div>
            <div style="background: #e6fffa; border-radius: 8px; padding: 1rem; margin-top: 1rem; border-left: 4px solid #38b2ac;">
                <p style="margin: 0; color: #065f46;">
                    <i class="fas fa-info-circle"></i> 
                    <strong>Ganhe pontos:</strong> Informe a distância das suas viagens finalizadas para ganhar pontos no ranking! 1 km = 1 ponto.
                </p>
            </div>
        </div>
        
        <!-- Filtros de Localização -->
        <div class="location-filters" style="background: white; border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);">
            <h3 style="color: #333; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-filter"></i> Filtros por Localização
            </h3>
            
            <form id="filtroForm" action="<%=request.getContextPath()%>/RankingController" method="post" style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: end;">
                <input type="hidden" name="action" value="pagina-locatario-filtro">
                
                <div style="flex: 1; min-width: 180px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">País:</label>
                    <input type="text" name="pais" id="paisFilter" placeholder="Ex: Brasil" 
                           style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;"
                           value="<%=request.getParameter("pais") != null ? request.getParameter("pais") : ""%>">
                </div>
                
                <div style="flex: 1; min-width: 180px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">Estado:</label>
                    <input type="text" name="estado" id="estadoFilter" placeholder="Ex: SP" 
                           style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;"
                           value="<%=request.getParameter("estado") != null ? request.getParameter("estado") : ""%>">
                </div>
                
                <div style="flex: 1; min-width: 180px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">Cidade:</label>
                    <input type="text" name="cidade" id="cidadeFilter" placeholder="Ex: São Paulo" 
                           style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;"
                           value="<%=request.getParameter("cidade") != null ? request.getParameter("cidade") : ""%>">
                </div>
                
                <div style="display: flex; gap: 0.5rem;">
                    <button type="submit" style="background: linear-gradient(135deg, #38b2ac, #0d9488); color: white; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all 0.3s ease;">
                        <i class="fas fa-search"></i> Filtrar
                    </button>
                    
                    <button type="button" onclick="clearFilters()" style="background: #6c757d; color: white; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all 0.3s ease;">
                        <i class="fas fa-times"></i> Limpar
                    </button>
                </div>
            </form>
            
            <!-- Exibir resultados de filtro se houver -->
            <%
                List<Ranking> listaRankingFiltrado = (List<Ranking>) request.getAttribute("listaRankingFiltrado");
                if (listaRankingFiltrado != null) {
            %>
            <div style="margin-top: 1rem; padding: 1rem; background: #e6fffa; border-radius: 8px; border-left: 4px solid #38b2ac;">
                <h4 style="color: #38b2ac; margin: 0 0 0.5rem 0;">
                    <i class="fas fa-info-circle"></i> Resultados do Filtro
                </h4>
                <p style="margin: 0; color: #666;">
                    Encontrados <strong><%=listaRankingFiltrado.size()%></strong> registros
                    <%if (request.getParameter("pais") != null && !request.getParameter("pais").isEmpty()) {%>
                        para o país "<strong><%=request.getParameter("pais")%></strong>"
                    <%}%>
                    <%if (request.getParameter("estado") != null && !request.getParameter("estado").isEmpty()) {%>
                        no estado "<strong><%=request.getParameter("estado")%></strong>"
                    <%}%>
                    <%if (request.getParameter("cidade") != null && !request.getParameter("cidade").isEmpty()) {%>
                        na cidade "<strong><%=request.getParameter("cidade")%></strong>"
                    <%}%>
                </p>
            </div>
            <%
                }
            %>
        </div>
        
        <!-- Filtros de Ranking -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterRanking('top-geral')">
                <i class="fas fa-trophy"></i> Top 10 Geral
            </button>
            <button class="filter-tab" onclick="filterRanking('top-semana')">
                <i class="fas fa-fire"></i> Top 10 da Semana
            </button>
            <button class="filter-tab" onclick="filterRanking('todos-locatarios')">
                <i class="fas fa-users"></i> Todos os Locatários
            </button>
        </div>
        
        <!-- Ranking Lista Dinâmica -->
        <div class="ranking-list" id="ranking-container">
            
            <!-- Seção RESULTADOS FILTRADOS -->
            <div class="ranking-section" id="filtrados-section" style="display: none;">
                <h2 class="section-title">
                    <i class="fas fa-filter"></i> Resultados do Filtro por Localização
                </h2>
                
                <% 
                if (listaRankingFiltrado != null && !listaRankingFiltrado.isEmpty()) {
                    for (int i = 0; i < listaRankingFiltrado.size(); i++) {
                        Ranking ranking = listaRankingFiltrado.get(i);
                        int posicao = i + 1;
                        boolean isCurrentUser = ranking.getUsuario().getCpfCnpj_user().equals(usuarioLogado.getCpfCnpj_user());
                %>
                <div class="ranking-item" data-category="filtrados" style="display: none; <%= isCurrentUser ? "border-left: 4px solid #38b2ac; background: #f0fdfa;" : "" %>">
                    <div class="ranking-position <%= isCurrentUser ? "current-position" : "" %>">
                        <span class="position-number"><%= posicao %>º</span>
                        <% if (posicao <= 3) { %>
                            <% if (posicao == 1) { %>
                                <span class="medal">🏆</span>
                            <% } else if (posicao == 2) { %>
                                <span class="medal">🥈</span>
                            <% } else { %>
                                <span class="medal">🥉</span>
                            <% } %>
                        <% } %>
                    </div>
                    <div class="user-details">
                        <div class="user-name">
                            <%= ranking.getUsuario().getNomeRazaoSocial_user() %>
                            <%= isCurrentUser ? "<span style='color: #38b2ac; font-weight: bold;'>(Você)</span>" : "" %>
                        </div>
                        <div class="user-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <%= ranking.getCidade_rank() %>, <%= ranking.getEstado_rank() %>, <%= ranking.getPais_rank() %>
                        </div>
                    </div>
                    <div class="ranking-points">
                        <div class="points-value">
                            <%= String.format("%.0f", ranking.getPontos_rank()) %>
                        </div>
                        <div class="points-label">pontos</div>
                    </div>
                    <% if (isCurrentUser) { %>
                        <div class="current-user-badge">
                            <span class="badge">📍 Sua Posição</span>
                        </div>
                    <% } %>
                </div>
                <% 
                    }
                } else if (listaRankingFiltrado != null) { 
                %>
                <div class="no-data" data-category="filtrados" style="display: none;">
                    <i class="fas fa-filter"></i>
                    <h3>Nenhum resultado encontrado</h3>
                    <p>Não há locatários que correspondam aos filtros aplicados.</p>
                </div>
                <% } %>
            </div>
            
            <!-- Seção TOP 10 GERAL -->
            <div class="ranking-section" id="top-geral-section">
                <h2 class="section-title">
                    <i class="fas fa-trophy"></i> Top 10 Geral - Melhores Locatários
                </h2>
                
                <% 
                if (listaRankingTopGeral != null && !listaRankingTopGeral.isEmpty()) {
                    for (int i = 0; i < Math.min(10, listaRankingTopGeral.size()); i++) {
                        Ranking ranking = listaRankingTopGeral.get(i);
                        int posicao = i + 1;
                        boolean isCurrentUser = ranking.getUsuario().getCpfCnpj_user().equals(usuarioLogado.getCpfCnpj_user());
                %>
                <div class="ranking-item" data-category="top-geral" <%= isCurrentUser ? "style='border-left: 4px solid #38b2ac; background: #f0fdfa;'" : "" %>>
                    <div class="ranking-position <%= posicao == 1 ? "first" : posicao == 2 ? "second" : posicao == 3 ? "third" : "" %>">
                        <span class="position-number"><%= posicao %>º</span>
                        <% if (posicao == 1) { %>
                            <span class="medal">🏆</span>
                        <% } else if (posicao == 2) { %>
                            <span class="medal">🥈</span>
                        <% } else if (posicao == 3) { %>
                            <span class="medal">🥉</span>
                        <% } %>
                    </div>
                    <div class="user-details">
                        <div class="user-name">
                            <%= ranking.getUsuario().getNomeRazaoSocial_user() %>
                            <%= isCurrentUser ? "<span style='color: #38b2ac; font-weight: bold;'>(Você)</span>" : "" %>
                        </div>
                        <div class="user-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <%= ranking.getCidade_rank() %>, <%= ranking.getEstado_rank() %>, <%= ranking.getPais_rank() %>
                        </div>
                    </div>
                    <div class="ranking-points">
                        <div class="points-value">
                            <%= String.format("%.0f", ranking.getPontos_rank()) %>
                        </div>
                        <div class="points-label">pontos</div>
                    </div>
                    <% if (isCurrentUser) { %>
                        <div class="current-user-badge">
                            <span class="badge">📍 Sua Posição</span>
                        </div>
                    <% } %>
                </div>
                <% 
                    }
                } else { 
                %>
                <div class="no-data" data-category="top-geral">
                    <i class="fas fa-trophy"></i>
                    <h3>Nenhum dado de ranking disponível</h3>
                    <p>Comece a usar o ShareBike para aparecer no ranking!</p>
                </div>
                <% } %>
            </div>

            <!-- Seção TOP 10 SEMANAL -->
            <div class="ranking-section" id="top-semana-section" style="display: none;">
                <h2 class="section-title">
                    <i class="fas fa-fire"></i> Top 10 da Semana - Mais Ativos
                </h2>
                
                <% 
                if (listaRankingTopSemana != null && !listaRankingTopSemana.isEmpty()) {
                    for (int i = 0; i < Math.min(10, listaRankingTopSemana.size()); i++) {
                        Ranking ranking = listaRankingTopSemana.get(i);
                        int posicao = i + 1;
                        boolean isCurrentUser = ranking.getUsuario().getCpfCnpj_user().equals(usuarioLogado.getCpfCnpj_user());
                %>
                <div class="ranking-item" data-category="top-semana" style="display: none; <%= isCurrentUser ? "border-left: 4px solid #38b2ac; background: #f0fdfa;" : "" %>">
                    <div class="ranking-position <%= posicao <= 3 ? (posicao == 1 ? "first" : posicao == 2 ? "second" : "third") : "" %>">
                        <span class="position-number"><%= posicao %>º</span>
                        <% if (posicao == 1) { %>
                            <span class="medal">⚡</span>
                        <% } else if (posicao == 2) { %>
                            <span class="medal">💪</span>
                        <% } else if (posicao == 3) { %>
                            <span class="medal">🎯</span>
                        <% } %>
                    </div>
                    <div class="user-details">
                        <div class="user-name">
                            <%= ranking.getUsuario().getNomeRazaoSocial_user() %>
                            <%= isCurrentUser ? "<span style='color: #38b2ac; font-weight: bold;'>(Você)</span>" : "" %>
                        </div>
                        <div class="user-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <%= ranking.getCidade_rank() %>, <%= ranking.getEstado_rank() %>, <%= ranking.getPais_rank() %>
                        </div>
                    </div>
                    <div class="ranking-points">
                        <div class="points-value">
                            <%= String.format("%.0f", ranking.getPontosSemana_rank()) %>
                        </div>
                        <div class="points-label">pontos na semana</div>
                    </div>
                    <% if (isCurrentUser) { %>
                        <div class="current-user-badge">
                            <span class="badge">📍 Sua Posição</span>
                        </div>
                    <% } %>
                </div>
                <% 
                    }
                } else { 
                %>
                <div class="no-data" data-category="top-semana" style="display: none;">
                    <i class="fas fa-fire"></i>
                    <h3>Nenhum dado semanal disponível</h3>
                    <p>Seja mais ativo esta semana para aparecer aqui!</p>
                </div>
                <% } %>
            </div>
            
            <!-- Seção TODOS OS LOCATÁRIOS -->
            <div class="ranking-section" id="todos-locatarios-section" style="display: none;">
                <h2 class="section-title">
                    <i class="fas fa-users"></i> Ranking Completo - Todos os Locatários
                </h2>
                
                <% 
                if (listaRankings != null && !listaRankings.isEmpty()) {
                    for (int i = 0; i < listaRankings.size(); i++) {
                        Ranking ranking = listaRankings.get(i);
                        int posicao = i + 1;
                        boolean isCurrentUser = ranking.getUsuario().getCpfCnpj_user().equals(usuarioLogado.getCpfCnpj_user());
                %>
                <div class="ranking-item" data-category="todos-locatarios" style="display: none; <%= isCurrentUser ? "border-left: 4px solid #38b2ac; background: #f0fdfa;" : "" %>">
                    <div class="ranking-position <%= isCurrentUser ? "current-position" : "" %>">
                        <span class="position-number"><%= posicao %>º</span>
                        <% if (posicao <= 3) { %>
                            <% if (posicao == 1) { %>
                                <span class="medal">🏆</span>
                            <% } else if (posicao == 2) { %>
                                <span class="medal">🥈</span>
                            <% } else { %>
                                <span class="medal">🥉</span>
                            <% } %>
                        <% } %>
                    </div>
                    <div class="user-details">
                        <div class="user-name">
                            <%= ranking.getUsuario().getNomeRazaoSocial_user() %>
                            <%= isCurrentUser ? "<span style='color: #38b2ac; font-weight: bold;'>(Você)</span>" : "" %>
                        </div>
                        <div class="user-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <%= ranking.getCidade_rank() %>, <%= ranking.getEstado_rank() %>, <%= ranking.getPais_rank() %>
                        </div>
                    </div>
                    <div class="ranking-points">
                        <div class="points-value">
                            <%= String.format("%.0f", ranking.getPontos_rank()) %>
                        </div>
                        <div class="points-label">pontos</div>
                    </div>
                    <% if (isCurrentUser) { %>
                        <div class="current-user-badge">
                            <span class="badge">📍 Sua Posição</span>
                        </div>
                    <% } %>
                </div>
                <% 
                    }
                } else { 
                %>
                <div class="no-data" data-category="todos-locatarios" style="display: none;">
                    <i class="fas fa-users"></i>
                    <h3>Nenhum ranking disponível</h3>
                    <p>Seja o primeiro a aparecer no ranking!</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        function filterRanking(category) {
            // Remove active class from all tabs
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Add active class to clicked tab
            event.target.classList.add('active');
            
            // Hide all sections first
            document.querySelectorAll('.ranking-section').forEach(section => {
                section.style.display = 'none';
            });
            
            // Hide all ranking items and no-data divs
            document.querySelectorAll('.ranking-item').forEach(item => {
                item.style.display = 'none';
            });
            
            document.querySelectorAll('.no-data').forEach(noData => {
                noData.style.display = 'none';
            });
            
            // Show appropriate section and items
            if (category === 'top-geral') {
                document.getElementById('top-geral-section').style.display = 'block';
                document.querySelectorAll('[data-category="top-geral"]').forEach(element => {
                    element.style.display = 'block';
                });
            } else if (category === 'top-semana') {
                document.getElementById('top-semana-section').style.display = 'block';
                document.querySelectorAll('[data-category="top-semana"]').forEach(element => {
                    element.style.display = 'block';
                });
            } else if (category === 'todos-locatarios') {
                document.getElementById('todos-locatarios-section').style.display = 'block';
                document.querySelectorAll('[data-category="todos-locatarios"]').forEach(element => {
                    element.style.display = 'block';
                });
            }
        }
        
        function clearFilters() {
            // Limpar os campos de filtro
            document.getElementById('paisFilter').value = '';
            document.getElementById('estadoFilter').value = '';
            document.getElementById('cidadeFilter').value = '';
            
            // Redirecionar para página sem filtros
            window.location.href = '<%=request.getContextPath()%>/RankingController?action=pagina-locatario';
        }
        
        // Initialize with first category visible
        document.addEventListener('DOMContentLoaded', function() {
            // Verificar se há resultados filtrados
            <%if (listaRankingFiltrado != null) {%>
                // Mostrar resultados filtrados
                document.getElementById('filtrados-section').style.display = 'block';
                document.querySelectorAll('[data-category="filtrados"]').forEach(item => {
                    item.style.display = 'block';
                });
                
                // Esconder outras seções
                document.querySelectorAll('.ranking-section:not(#filtrados-section)').forEach(section => {
                    section.style.display = 'none';
                });
                document.querySelectorAll('.ranking-item:not([data-category="filtrados"])').forEach(item => {
                    item.style.display = 'none';
                });
                document.querySelectorAll('.no-data:not([data-category="filtrados"])').forEach(noData => {
                    noData.style.display = 'none';
                });
                
                // Remover active de todas as tabs
                document.querySelectorAll('.filter-tab').forEach(tab => {
                    tab.classList.remove('active');
                });
            <%} else {%>
                // Show top geral by default
                document.getElementById('top-geral-section').style.display = 'block';
                document.querySelectorAll('[data-category="top-geral"]').forEach(element => {
                    element.style.display = 'block';
                });
                
                // Hide other sections
                document.querySelectorAll('[data-category="top-semana"]').forEach(element => {
                    element.style.display = 'none';
                });
                document.querySelectorAll('[data-category="todos-locatarios"]').forEach(element => {
                    element.style.display = 'none';
                });
                document.querySelectorAll('[data-category="filtrados"]').forEach(element => {
                    element.style.display = 'none';
                });
                
                // Set first tab as active
                document.querySelector('.filter-tab').classList.add('active');
            <%}%>
        });
    </script>
</body>
</html>