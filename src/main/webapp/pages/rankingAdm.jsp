<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.sharebike.model.Ranking" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ranking - Administrador</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/ranking.css?v=20250820-2">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Navegação administrativa padrão */
        .admin-navigation {
            background: linear-gradient(135deg, #008080, #006666);
            padding: 1rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }
        
        .nav-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .nav-brand {
            color: white;
            text-decoration: none;
            font-size: 1.2rem;
            font-weight: bold;
        }
        
        .nav-links {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
            align-items: center;
        }
        
        .nav-link {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .nav-link:hover {
            background-color: rgba(255,255,255,0.1);
            color: white;
            text-decoration: none;
        }
        
        .nav-link.active {
            background-color: rgba(255,255,255,0.2);
        }
        
        .nav-logout {
            background: none;
            border: none;
            color: white;
            cursor: pointer;
            font-size: inherit;
            font-family: inherit;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .nav-logout:hover {
            background-color: rgba(255,255,255,0.1);
        }
    </style>
</head>
<body>
    <!-- Navegação administrativa padrão -->
    <nav class="admin-navigation">
        <div class="nav-container">
            <div class="nav-content">
                <!-- Logo/Home -->
                <div>
                    <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" class="nav-brand">
                        <i class="fas fa-bicycle"></i> ShareBike Admin
                    </a>
                </div>
                
                <!-- Links de Navegação -->
                <div class="nav-links">
                    <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" class="nav-link">
                        <i class="fas fa-home"></i> Painel do Adm
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/UsuarioController" class="nav-link">
                        <i class="fas fa-users-cog"></i> Gestão Usuários
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/BicicletaController" class="nav-link">
                        <i class="fas fa-bicycle"></i> Gestão Bicicletas
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/ReservaController" class="nav-link">
                        <i class="fas fa-calendar-check"></i> Gestão Reservas
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/FeedbackController" class="nav-link">
                        <i class="fas fa-star"></i> Feedbacks
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/RankingController" class="nav-link active">
                        <i class="fas fa-chart-line"></i> Rankings
                    </a>
                    
                    <!-- Logout -->
                    <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block; margin: 0;">
                        <input type="hidden" name="action" value="logout">
                        <button type="submit" class="nav-logout">
                            <i class="fas fa-sign-out-alt"></i> Sair
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </nav>

    <!-- Cabeçalho da página -->
    <div class="page-header" style="background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%); color: white; padding: 1.5rem; text-align: center; font-size: 1.8rem;">
        <i class="fas fa-chart-line"></i> Sistema de Ranking - Administração
    </div>

    <main>
        <div class="container" style="max-width: 1200px; margin: 0 auto; padding: 2rem 1rem;">
            <%
                List<Ranking> listaRankings = (List<Ranking>) request.getAttribute("listaRankings");
                List<Ranking> listaRankingTopGeral = (List<Ranking>) request.getAttribute("listaRankingTopGeral");
                List<Ranking> listaRankingTopSemana = (List<Ranking>) request.getAttribute("listaRankingTopSemana");
            %>
            
            <!-- Dashboard de Estatísticas -->
            <div class="stats-dashboard">
                <h2><i class="fas fa-chart-bar"></i> Estatísticas Gerais do Sistema</h2>
                <div class="dashboard-grid">
                    <div class="dashboard-stat">
                        <div class="dashboard-value"><%=listaRankings != null ? listaRankings.size() : 0%></div>
                        <div class="dashboard-label">Usuários no Ranking</div>
                    </div>
                    <div class="dashboard-stat">
                        <div class="dashboard-value"><%=listaRankingTopGeral != null ? listaRankingTopGeral.size() : 0%></div>
                        <div class="dashboard-label">Top 10 Geral</div>
                    </div>
                    <div class="dashboard-stat">
                        <div class="dashboard-value"><%=listaRankingTopSemana != null ? listaRankingTopSemana.size() : 0%></div>
                        <div class="dashboard-label">Top 10 Semanal</div>
                    </div>
                    <div class="dashboard-stat">
                        <%
                            double avgPontos = 0;
                            if (listaRankings != null && !listaRankings.isEmpty()) {
                                long totalPontos = 0;
                                for (Ranking r : listaRankings) {
                                    totalPontos += r.getPontos_rank();
                                }
                                avgPontos = (double) totalPontos / listaRankings.size();
                            }
                        %>
                        <div class="dashboard-value"><%=String.format("%.0f", avgPontos)%></div>
                        <div class="dashboard-label">Média de Pontos</div>
                    </div>
                </div>
            </div>
            
            <!-- Filtros -->
            <div class="filter-tabs">
                <button class="filter-tab active" onclick="filterRanking('top-geral')">
                    <i class="fas fa-trophy"></i> Top 10 Geral
                </button>
                <button class="filter-tab" onclick="filterRanking('top-semana')">
                    <i class="fas fa-fire"></i> Top 10 da Semana
                </button>
                <button class="filter-tab" onclick="filterRanking('todos-locatarios')">
                    <i class="fas fa-users"></i> Todos os Rankings
                </button>
            </div>
            
            <!-- Filtros de Localização Administrativa -->
            <div class="location-filters" style="background: white; border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);">
                <h3 style="color: #333; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                    <i class="fas fa-filter"></i> Filtros por Localização
                </h3>
                
                <form id="filtroForm" action="<%=request.getContextPath()%>/RankingController" method="post" style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: end;">
                    <input type="hidden" name="action" value="listar-ranking-filtro">
                    
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
                        <button type="submit" style="background: linear-gradient(135deg, #008080, #006666); color: white; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all 0.3s ease;">
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
                <div style="margin-top: 1rem; padding: 1rem; background: #e8f4f8; border-radius: 8px; border-left: 4px solid #008080;">
                    <h4 style="color: #008080; margin: 0 0 0.5rem 0;">
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
            
            <!-- Ranking Lista Dinâmica -->
            <div class="ranking-list" id="ranking-container">
                
                <!-- Seção TOP 10 GERAL -->
                <div class="ranking-section" id="top-geral-section">
                    <h2 class="section-title">
                        <i class="fas fa-trophy"></i> Top 10 - Ranking Geral
                    </h2>
                    
                    <%
                        if (listaRankingTopGeral != null && !listaRankingTopGeral.isEmpty()) {
                            for (int i = 0; i < listaRankingTopGeral.size(); i++) {
                                Ranking ranking = listaRankingTopGeral.get(i);
                                Usuario usuario = ranking.getUsuario();
                                
                                String positionClass = "";
                                String medal = "";
                                if (i == 0) {
                                    positionClass = "gold";
                                    medal = "🥇";
                                } else if (i == 1) {
                                    positionClass = "silver";
                                    medal = "🥈";
                                } else if (i == 2) {
                                    positionClass = "bronze";
                                    medal = "🥉";
                                }
                    %>
                    <div class="ranking-item" data-category="top-geral">
                        <div class="ranking-position <%=positionClass%>">
                            <span class="position-number"><%=i+1%>º</span>
                            <%if (!medal.isEmpty()) {%>
                                <span class="medal"><%=medal%></span>
                            <%}%>
                        </div>
                        <div class="user-details">
                            <div class="user-name">
                                <%
                                    String nomeUsuario = "Usuário não identificado";
                                    if (usuario != null && usuario.getNomeRazaoSocial_user() != null && !usuario.getNomeRazaoSocial_user().trim().isEmpty()) {
                                        nomeUsuario = usuario.getNomeRazaoSocial_user();
                                    }
                                %>
                                <%= nomeUsuario %>
                            </div>
                            <div class="user-location">
                                <i class="fas fa-map-marker-alt"></i>
                                <%= ranking.getCidade_rank() != null ? ranking.getCidade_rank() : "N/A" %>, 
                                <%= ranking.getEstado_rank() != null ? ranking.getEstado_rank() : "N/A" %>, 
                                <%= ranking.getPais_rank() != null ? ranking.getPais_rank() : "N/A" %>
                            </div>
                        </div>
                        <div class="ranking-points">
                            <div class="points-value">
                                <%= String.format("%.0f", ranking.getPontos_rank()) %>
                            </div>
                            <div class="points-label">pontos</div>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="no-data" data-category="top-geral">
                        <i class="fas fa-info-circle"></i>
                        <p>Nenhum dado disponível no momento</p>
                    </div>
                    <%
                        }
                    %>
                </div>

                <!-- Seção TOP 10 SEMANAL -->
                <div class="ranking-section" id="top-semana-section" style="display: none;">
                    <h2 class="section-title">
                        <i class="fas fa-calendar-week"></i> Top 10 - Ranking Semanal
                    </h2>
                    
                    <%
                        if (listaRankingTopSemana != null && !listaRankingTopSemana.isEmpty()) {
                            for (int i = 0; i < listaRankingTopSemana.size(); i++) {
                                Ranking ranking = listaRankingTopSemana.get(i);
                                Usuario usuario = ranking.getUsuario();
                                
                                String positionClass = "";
                                String medal = "";
                                if (i == 0) {
                                    positionClass = "gold";
                                    medal = "🔥";
                                } else if (i == 1) {
                                    positionClass = "silver";
                                    medal = "⚡";
                                } else if (i == 2) {
                                    positionClass = "bronze";
                                    medal = "💫";
                                }
                    %>
                    <div class="ranking-item" data-category="top-semana" style="display: none;">
                        <div class="ranking-position <%=positionClass%>">
                            <span class="position-number"><%=i+1%>º</span>
                            <%if (!medal.isEmpty()) {%>
                                <span class="medal"><%=medal%></span>
                            <%}%>
                        </div>
                        <div class="user-details">
                            <div class="user-name">
                                <%
                                    String nomeUsuario = "Usuário não identificado";
                                    if (usuario != null && usuario.getNomeRazaoSocial_user() != null && !usuario.getNomeRazaoSocial_user().trim().isEmpty()) {
                                        nomeUsuario = usuario.getNomeRazaoSocial_user();
                                    }
                                %>
                                <%= nomeUsuario %>
                            </div>
                            <div class="user-location">
                                <i class="fas fa-map-marker-alt"></i>
                                <%= ranking.getCidade_rank() != null ? ranking.getCidade_rank() : "N/A" %>, 
                                <%= ranking.getEstado_rank() != null ? ranking.getEstado_rank() : "N/A" %>, 
                                <%= ranking.getPais_rank() != null ? ranking.getPais_rank() : "N/A" %>
                            </div>
                        </div>
                        <div class="ranking-points">
                            <div class="points-value">
                                <%= String.format("%.0f", ranking.getPontosSemana_rank()) %>
                            </div>
                            <div class="points-label">pontos na semana</div>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="no-data" data-category="top-semana" style="display: none;">
                        <i class="fas fa-info-circle"></i>
                        <p>Nenhum dado disponível no momento</p>
                    </div>
                    <%
                        }
                    %>
                </div>

                <!-- Seção TODOS OS RANKINGS -->
                <div class="ranking-section" id="todos-locatarios-section" style="display: none;">
                    <h2 class="section-title">
                        <i class="fas fa-users"></i> Todos os Rankings
                    </h2>
                    
                    <%
                        if (listaRankings != null && !listaRankings.isEmpty()) {
                            for (int i = 0; i < listaRankings.size(); i++) {
                                Ranking ranking = listaRankings.get(i);
                                Usuario usuario = ranking.getUsuario();
                    %>
                    <div class="ranking-item" data-category="todos-locatarios" style="display: none;">
                        <div class="ranking-position">
                            <span class="position-number"><%=i+1%>º</span>
                        </div>
                        <div class="user-details">
                            <div class="user-name">
                                <%
                                    String nomeUsuario = "Usuário não identificado";
                                    if (usuario != null && usuario.getNomeRazaoSocial_user() != null && !usuario.getNomeRazaoSocial_user().trim().isEmpty()) {
                                        nomeUsuario = usuario.getNomeRazaoSocial_user();
                                    }
                                %>
                                <%= nomeUsuario %>
                            </div>
                            <div class="user-location">
                                <i class="fas fa-map-marker-alt"></i>
                                <%= ranking.getCidade_rank() != null ? ranking.getCidade_rank() : "N/A" %>, 
                                <%= ranking.getEstado_rank() != null ? ranking.getEstado_rank() : "N/A" %>, 
                                <%= ranking.getPais_rank() != null ? ranking.getPais_rank() : "N/A" %>
                            </div>
                        </div>
                        <div class="ranking-points">
                            <div class="points-value">
                                <%= String.format("%.0f", ranking.getPontos_rank()) %>
                            </div>
                            <div class="points-label">pontos</div>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="no-data" data-category="todos-locatarios" style="display: none;">
                        <i class="fas fa-info-circle"></i>
                        <p>Nenhum dado disponível no momento</p>
                    </div>
                    <%
                        }
                    %>
                </div>
                
                <!-- Seção RESULTADOS FILTRADOS -->
                <%
                    if (listaRankingFiltrado != null && !listaRankingFiltrado.isEmpty()) {
                %>
                <div class="ranking-section" id="filtrados-section">
                    <h2 class="section-title">
                        <i class="fas fa-filter"></i> Resultados Filtrados (<%=listaRankingFiltrado.size()%>)
                    </h2>
                    
                    <%
                            for (int i = 0; i < listaRankingFiltrado.size(); i++) {
                                Ranking ranking = listaRankingFiltrado.get(i);
                                Usuario usuario = ranking.getUsuario();
                    %>
                    <div class="ranking-item" data-category="filtrados">
                        <div class="ranking-position">
                            <span class="position-number"><%=i+1%>º</span>
                        </div>
                        <div class="user-details">
                            <div class="user-name">
                                <%
                                    String nomeUsuario = "Usuário não identificado";
                                    if (usuario != null && usuario.getNomeRazaoSocial_user() != null && !usuario.getNomeRazaoSocial_user().trim().isEmpty()) {
                                        nomeUsuario = usuario.getNomeRazaoSocial_user();
                                    }
                                %>
                                <%= nomeUsuario %>
                            </div>
                            <div class="user-location">
                                <i class="fas fa-map-marker-alt"></i>
                                <%= ranking.getCidade_rank() != null ? ranking.getCidade_rank() : "N/A" %>, 
                                <%= ranking.getEstado_rank() != null ? ranking.getEstado_rank() : "N/A" %>, 
                                <%= ranking.getPais_rank() != null ? ranking.getPais_rank() : "N/A" %>
                            </div>
                        </div>
                        <div class="ranking-points">
                            <div class="points-value">
                                <%= String.format("%.0f", ranking.getPontos_rank()) %>
                            </div>
                            <div class="points-label">pontos</div>
                        </div>
                    </div>
                    <%
                            }
                    %>
                </div>
                <%
                    } else if (request.getParameter("action") != null && request.getParameter("action").equals("listar-ranking-filtro")) {
                %>
                <div class="no-data">
                    <i class="fas fa-search"></i>
                    <h3>Nenhum resultado encontrado</h3>
                    <p>Não foram encontrados usuários com os critérios de filtro especificados.</p>
                    <button onclick="clearFilters()" class="btn btn-primary">
                        <i class="fas fa-times"></i> Limpar Filtros
                    </button>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </main>
                    </a>
                </div>
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
            window.location.href = '<%=request.getContextPath()%>/RankingController';
        }
        
        // Initialize with appropriate view
        document.addEventListener('DOMContentLoaded', function() {
            // Verificar se há resultados filtrados
            <%if (listaRankingFiltrado != null && !listaRankingFiltrado.isEmpty()) {%>
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
                document.querySelectorAll('.no-data').forEach(noData => {
                    noData.style.display = 'none';
                });
                
                // Remover active de todas as tabs
                document.querySelectorAll('.filter-tab').forEach(tab => {
                    tab.classList.remove('active');
                });
            <%} else {%>
                // Mostrar top geral por padrão
                document.getElementById('top-geral-section').style.display = 'block';
                document.querySelectorAll('[data-category="top-geral"]').forEach(element => {
                    element.style.display = 'block';
                });
                
                // Esconder outras seções
                document.querySelectorAll('[data-category="top-semana"]').forEach(element => {
                    element.style.display = 'none';
                });
                document.querySelectorAll('[data-category="todos-locatarios"]').forEach(element => {
                    element.style.display = 'none';
                });
                
                // Set first tab as active
                document.querySelector('.filter-tab').classList.add('active');
            <%}%>
        });
    </script>
</body>
</html>