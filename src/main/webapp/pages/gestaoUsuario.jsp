<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestão de Usuários - ShareBike</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/gestaoUsuario.css">
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
                    
                    <a href="<%=request.getContextPath()%>/UsuarioController" class="nav-link active">
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
                    
                    <a href="<%=request.getContextPath()%>/RankingController" class="nav-link">
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
        <i class="fas fa-users-cog"></i> Gestão de Usuários - Administrador
    </div>

<div class="container">
    <!-- Header -->
    <div class="gestao-header">
        <div class="gestao-title" style="display: flex; align-items: center; gap: 1rem; margin-bottom: 0.5rem;">
            <i class="fas fa-users-cog" style="font-size: 1.5rem; color: white;"></i> 
            <span style="font-size: 1.5rem; color: white;">Dashboard central para visualização e navegação entre as diferentes categorias de usuários</span>
        </div>
    </div>
    
    <!-- Estatísticas -->
    <div class="stats-grid">
        <%
            List<Usuario> listaUsuario = (List<Usuario>) request.getAttribute("listaUsuario");
            int totalUsuarios = 0;
            int usuariosAtivos = 0;
            int usuariosAguardando = 0;
            int usuariosRanking = 0;
            
            if (listaUsuario != null) {
                totalUsuarios = listaUsuario.size();
                for (Usuario usuario : listaUsuario) {
                    if (usuario.isPermissaoAcesso_user()) {
                        usuariosAtivos++;
                    } else {
                        usuariosAguardando++;
                    }
                    if (usuario.isPermissaoRank_user()) {
                        usuariosRanking++;
                    }
                }
            }
        %>
        
        <div class="stat-card">
            <div class="stat-icon" style="color: #28a745;">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-value"><%= totalUsuarios %></div>
            <div class="stat-label">Usuários Cadastrados</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon" style="color: #17a2b8;">
                <i class="fas fa-user-check"></i>
            </div>
            <div class="stat-value"><%= usuariosAtivos %></div>
            <div class="stat-label">Usuários Ativos</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon" style="color: #ffc107;">
                <i class="fas fa-user-clock"></i>
            </div>
            <div class="stat-value"><%= usuariosAguardando %></div>
            <div class="stat-label">Usuários Aguardando Permissão</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon" style="color: #dc3545;">
                <i class="fas fa-trophy"></i>
            </div>
            <div class="stat-value"><%= usuariosRanking %></div>
            <div class="stat-label">Usuarios Participando no Ranking</div>
        </div>
    </div>
    
    <!-- Navegação -->
    <nav class="nav">
        <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
            <input type="hidden" name="action" value="aprovar-acesso">
            <button type="submit" class="nav-button nav-permission">
                <i class="fas fa-user-clock"></i> Usuários Aguardando Permissão
            </button>
        </form>
        
        <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
            <input type="hidden" name="action" value="aprovar-rank">
            <button type="submit" class="nav-button nav-ranking">
                <i class="fas fa-trophy"></i> Usuários Elegíveis para Ranking
            </button>
        </form>
    </nav>
    
    <!-- Barra de Pesquisa -->
    <div class="search-bar">
        <form action="<%=request.getContextPath()%>/UsuarioController" method="get">
            <input type="text" name="nomeRazaoSocial" placeholder="Pesquisar usuário pelo nome, email ou CPF/CNPJ" 
                   value="<%= request.getParameter("nomeRazaoSocial") != null ? request.getParameter("nomeRazaoSocial") : "" %>">
            <button type="submit">
                <i class="fas fa-search"></i> Buscar
            </button>
            <% if (request.getParameter("nomeRazaoSocial") != null && !request.getParameter("nomeRazaoSocial").trim().isEmpty()) { %>
                <a href="<%=request.getContextPath()%>/UsuarioController" class="btn-clear">
                    <i class="fas fa-times"></i> Limpar
                </a>
            <% } %>
        </form>
    </div>
    
    <!-- Lista de Usuários -->
    <div class="users-section">
        <h3 class="section-title">
            <i class="fas fa-list"></i> 
            <%
                String termoBusca = request.getParameter("nomeRazaoSocial");
                if (termoBusca != null && !termoBusca.trim().isEmpty()) {
            %>
                Resultados da busca por: "<%= termoBusca %>"
            <%
                } else {
            %>
                Últimos Usuários Cadastrados
            <%
                }
            %>
        </h3>
        
        <!-- Usuários com dados dinâmicos do banco -->
        <%
            if (listaUsuario == null || listaUsuario.isEmpty()) {
                if (termoBusca != null && !termoBusca.trim().isEmpty()) {
        %>
            <div class="user-card" style="text-align: center; padding: 2rem;">
                <div style="color: #999; font-size: 1.1em;">
                    <i class="fas fa-search"></i> Nenhum usuário encontrado com o termo "<%= termoBusca %>"
                </div>
                <div style="margin-top: 1rem;">
                    <a href="<%=request.getContextPath()%>/UsuarioController" class="btn btn-view">
                        <i class="fas fa-list"></i> Ver todos os usuários
                    </a>
                </div>
            </div>
        <%
                } else {
        %>
            <div class="user-card" style="text-align: center; padding: 2rem;">
                <div style="color: #999; font-size: 1.1em;">
                    <i class="fas fa-users"></i> Nenhum usuário cadastrado
                </div>
            </div>
        <%
                }
            } else {
                // Mostrar quantidade de resultados se houver busca
                if (termoBusca != null && !termoBusca.trim().isEmpty()) {
        %>
            <div class="search-info">
                <i class="fas fa-info-circle"></i> 
                Encontrado(s) <%= listaUsuario.size() %> usuário(s) 
                <a href="<%=request.getContextPath()%>/UsuarioController">
                    <i class="fas fa-times"></i> Limpar busca
                </a>
            </div>
        <%
                }
                
                for (Usuario usuario : listaUsuario) {
        %>
            <div class="user-card">
                <div class="user-info">
                    <div class="user-name">
                        <%
                            String nomeExibir = usuario.getNomeRazaoSocial_user();
                            // Destacar o termo de busca se existir
                            if (termoBusca != null && !termoBusca.trim().isEmpty() && nomeExibir != null) {
                                String termoLower = termoBusca.toLowerCase();
                                String nomeLower = nomeExibir.toLowerCase();
                                
                                if (nomeLower.contains(termoLower)) {
                                    int inicio = nomeLower.indexOf(termoLower);
                                    int fim = inicio + termoBusca.length();
                                    
                                    String antes = nomeExibir.substring(0, inicio);
                                    String destaque = nomeExibir.substring(inicio, fim);
                                    String depois = nomeExibir.substring(fim);
                                    
                                    out.print(antes + "<mark style='background-color: #fef08a; padding: 2px 4px; border-radius: 3px;'>" + destaque + "</mark>" + depois);
                                } else {
                                    out.print(nomeExibir);
                                }
                            } else {
                                out.print(nomeExibir);
                            }
                        %>
                    </div>
                    <div class="user-details">
                        <div class="detail-item">
                            <i class="fas fa-envelope"></i> <%= usuario.getEmail_user() %>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-id-card"></i> <%= usuario.getCpfCnpj_user() %>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-map-marker-alt"></i> <%= usuario.getCidade_user() %>, <%= usuario.getEstado_user() %>, <%= usuario.getPais_user() %>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-phone"></i> <%= usuario.getTelefone_user() %>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-star"></i> Avaliação: 
                            <% 
                                Float avaliacao = usuario.getAvaliacao_user();
                                // Debug: mostrar o valor exato
                                if (avaliacao == null) { 
                            %>
                                Sem avaliação
                            <% } else if (avaliacao.floatValue() == 0.0f) { %>
                                0.0/5.0 (zero)
                            <% } else { %>
                                <%= String.format("%.1f", avaliacao) %>/5.0
                            <% } %>
                        </div>
                        <div class="detail-item">
                            <i class="fas fa-bicycle"></i> Possui Bike: <%= usuario.isPossuiBike_user() ? "Sim" : "Não" %>
                        </div>
                    </div>
                </div>
                <div class="user-actions">
                    <% if (usuario.isPermissaoAcesso_user()) { %>
                        <span class="permission-badge permission-yes">Acesso Liberado</span>
                    <% } else { %>
                        <span class="permission-badge permission-pending">Aguardando Permissão</span>
                    <% } %>
                    
                    <!-- Formulário para ver detalhes do usuário -->
                    <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
                        <input type="hidden" name="action" value="exibir">
                        <input type="hidden" name="cpfCnpj" value="<%= usuario.getCpfCnpj_user() %>">
                        <input type="hidden" name="origem" value="gestaoUsuario">
                        <button type="submit" class="btn btn-view" onclick="event.stopPropagation();">
                            <i class="fas fa-eye"></i> Ver Detalhes
                        </button>
                    </form>
                </div>
            </div>
        <%
                }
            }
        %>
    </div>
</div>

<footer>
    <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
</footer>

</body>
</html>