<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.sharebike.model.Feedback" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestão de Feedbacks - Administrador</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        
        /* Navegação sem conflitos */
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
        
        .page-header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            color: white;
            padding: 1.5rem;
            text-align: center;
            font-size: 1.8rem;
        }
        
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .no-data {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        
        .no-data i {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        
        .feedback-grid {
            display: grid;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .feedback-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        
        .feedback-card:hover {
            transform: translateY(-2px);
        }
        
        .feedback-header {
            background: linear-gradient(135deg, #008080, #006666);
            color: white;
            padding: 1rem;
        }
        
        .feedback-content {
            display: flex;
            gap: 1rem;
            padding: 1.5rem;
        }
        
        .feedback-details {
            flex: 1;
        }
        
        .bike-name {
            font-size: 1.2rem;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        
        .detail-row {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
            color: #6c757d;
        }
        
        .detail-row i {
            color: #008080;
            margin-right: 0.5rem;
        }
        
        .rating-value {
            font-weight: bold;
            color: #28a745;
        }
        
        .feedback-text {
            background: #e9ecef;
            padding: 1rem;
            border-radius: 8px;
            margin: 1rem 0;
            font-style: italic;
            border-left: 4px solid #008080;
        }
        
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
            padding: 1rem 2rem;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            color: white;
            text-decoration: none;
        }
        
        /* Estilos para os filtros */
        .filter-button:hover {
            background: #006666 !important;
            transform: translateY(-1px);
        }
        
        .clear-filter-link:hover {
            background-color: rgba(0, 86, 179, 0.1);
            border-radius: 4px;
            padding: 0.2rem 0.4rem;
        }
        
        .all-feedbacks-button:hover {
            background: #5a6268 !important;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <!-- Navegação sem conflitos CSS -->
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
                    
                    <a href="<%=request.getContextPath()%>/FeedbackController" class="nav-link active">
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
        <i class="fas fa-comments"></i> Gestão de Feedbacks - Administrador
    </div>
    
    <div class="container">
        <%
        List<Feedback> listaFeedbacks = (List<Feedback>) request.getAttribute("listaFeedbacks");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        %>
        
        <!-- Seção de Filtros -->
        <div style="background: #f8f9fa; border-radius: 10px; padding: 1.5rem; margin-bottom: 2rem; border: 1px solid #dee2e6;">
            <h3 style="color: #008080; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-filter"></i> Filtros de Feedback
            </h3>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem;">
                <!-- Filtro por Usuário Avaliado -->
                <div style="background: white; padding: 1rem; border-radius: 8px; border: 1px solid #e9ecef;">
                    <h4 style="color: #495057; margin-bottom: 0.5rem; font-size: 1rem;">
                        <i class="fas fa-user-check"></i> Por Nome do Usuário Avaliado
                    </h4>
                    <form action="<%=request.getContextPath()%>/FeedbackController" method="post" style="margin: 0;">
                        <input type="hidden" name="action" value="listarFeedbacksPorAvaliado">
                        <div style="display: flex; gap: 0.5rem;">
                            <input type="text" name="nomeAvaliado" placeholder="Nome do usuário avaliado" 
                                   style="flex: 1; padding: 0.5rem; border: 1px solid #ccc; border-radius: 4px; font-size: 0.9rem;">
                            <button type="submit" class="filter-button" style="background: #008080; color: white; border: none; padding: 0.5rem 1rem; border-radius: 4px; cursor: pointer; white-space: nowrap; transition: all 0.3s ease;">
                                <i class="fas fa-search"></i> Buscar
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Filtro por Usuário Avaliador -->
                <div style="background: white; padding: 1rem; border-radius: 8px; border: 1px solid #e9ecef;">
                    <h4 style="color: #495057; margin-bottom: 0.5rem; font-size: 1rem;">
                        <i class="fas fa-user-edit"></i> Por Nome do Usuário Avaliador
                    </h4>
                    <form action="<%=request.getContextPath()%>/FeedbackController" method="post" style="margin: 0;">
                        <input type="hidden" name="action" value="listarFeedbacksPorAvaliador">
                        <div style="display: flex; gap: 0.5rem;">
                            <input type="text" name="nomeAvaliador" placeholder="Nome do usuário avaliador" 
                                   style="flex: 1; padding: 0.5rem; border: 1px solid #ccc; border-radius: 4px; font-size: 0.9rem;">
                            <button type="submit" class="filter-button" style="background: #008080; color: white; border: none; padding: 0.5rem 1rem; border-radius: 4px; cursor: pointer; white-space: nowrap; transition: all 0.3s ease;">
                                <i class="fas fa-search"></i> Buscar
                            </button>
                        </div>
                    </form>
                </div>
                
                <!-- Filtro por Bicicleta -->
                <div style="background: white; padding: 1rem; border-radius: 8px; border: 1px solid #e9ecef;">
                    <h4 style="color: #495057; margin-bottom: 0.5rem; font-size: 1rem;">
                        <i class="fas fa-bicycle"></i> Por Nome da Bicicleta
                    </h4>
                    <form action="<%=request.getContextPath()%>/FeedbackController" method="post" style="margin: 0;">
                        <input type="hidden" name="action" value="listarFeedbacksPorBicicleta">
                        <div style="display: flex; gap: 0.5rem;">
                            <input type="text" name="nomeBicicleta" placeholder="Nome da bicicleta"
                                   style="flex: 1; padding: 0.5rem; border: 1px solid #ccc; border-radius: 4px; font-size: 0.9rem;">
                            <button type="submit" class="filter-button" style="background: #008080; color: white; border: none; padding: 0.5rem 1rem; border-radius: 4px; cursor: pointer; white-space: nowrap; transition: all 0.3s ease;">
                                <i class="fas fa-search"></i> Buscar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Botão para ver todos os feedbacks -->
            <div style="margin-top: 1rem; text-align: center;">
                <a href="<%=request.getContextPath()%>/FeedbackController?action=listarFeedbacks" 
                   class="all-feedbacks-button" style="display: inline-flex; align-items: center; gap: 0.5rem; background: #6c757d; color: white; padding: 0.75rem 1.5rem; text-decoration: none; border-radius: 8px; font-weight: 500; transition: all 0.3s ease;">
                    <i class="fas fa-list"></i> Ver Todos os Feedbacks
                </a>
            </div>
        </div>
        
        <!-- Indicador do Filtro Ativo -->
        <%
        String action = request.getParameter("action");
        String filtroInfo = "";
        String parametroFiltro = "";
        
        if ("listarFeedbacksPorAvaliado".equals(action)) {
            parametroFiltro = request.getParameter("nomeAvaliado");
            filtroInfo = "Filtrado por usuário avaliado: " + (parametroFiltro != null ? parametroFiltro : "N/A");
        } else if ("listarFeedbacksPorAvaliador".equals(action)) {
            parametroFiltro = request.getParameter("nomeAvaliador");
            filtroInfo = "Filtrado por usuário avaliador: " + (parametroFiltro != null ? parametroFiltro : "N/A");
        } else if ("listarFeedbacksPorBicicleta".equals(action)) {
            parametroFiltro = request.getParameter("nomeBicicleta");
            filtroInfo = "Filtrado por bicicleta: " + (parametroFiltro != null ? parametroFiltro : "N/A");
        } else {
            filtroInfo = "Exibindo todos os feedbacks";
        }
        %>
        
        <% if (!"Exibindo todos os feedbacks".equals(filtroInfo)) { %>
            <div style="background: #e7f3ff; border: 1px solid #b3d9ff; border-radius: 8px; padding: 1rem; margin-bottom: 1.5rem; display: flex; align-items: center; justify-content: space-between;">
                <div style="display: flex; align-items: center; gap: 0.5rem; color: #0056b3;">
                    <i class="fas fa-info-circle"></i>
                    <span><%= filtroInfo %></span>
                </div>
                <a href="<%=request.getContextPath()%>/FeedbackController?action=listarFeedbacks" 
                   class="clear-filter-link" style="color: #0056b3; text-decoration: none; font-size: 0.9rem; display: flex; align-items: center; gap: 0.3rem; transition: all 0.3s ease;">
                    <i class="fas fa-times"></i> Limpar filtro
                </a>
            </div>
        <% } %>
        
        <!-- Lista de Feedbacks -->
        <div class="feedback-grid">
            <% if (listaFeedbacks != null && !listaFeedbacks.isEmpty()) { %>
                <% for (Feedback feedback : listaFeedbacks) { %>
                    <div class="feedback-card">
                        <div class="feedback-header">
                            <div class="feedback-info">
                                <div class="feedback-date">
                                    <i class="fas fa-calendar"></i> <%= feedback.getData_feedb().format(formatter) %>
                                </div>
                                <div class="reservation-id">Reserva: #<%= feedback.getReserva().getId_reserv() %></div>
                            </div>
                        </div>
                        <div class="feedback-content">
                            <div class="feedback-details">
                                <% if (feedback.getReserva() != null && feedback.getReserva().getBicicleta() != null) { %>
                                    <div class="bike-name"><%= feedback.getReserva().getBicicleta().getNome_bike() != null ? feedback.getReserva().getBicicleta().getNome_bike() : "Nome não disponível" %></div>
                                <% } else { %>
                                    <div class="bike-name">Bicicleta não identificada</div>
                                <% } %>
                                <div class="detail-row">
                                    <i class="fas fa-user"></i>
                                    <span>Avaliador: <%= feedback.getAvaliador_Usuario() != null ? feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() : "Não identificado" %></span>
                                </div>
                                <div class="detail-row">
                                    <i class="fas fa-user-tie"></i>
                                    <span>Avaliado: <%= feedback.getAvaliado_Usuario() != null ? feedback.getAvaliado_Usuario().getNomeRazaoSocial_user() : "Não identificado" %></span>
                                </div>
                                <% if (feedback.getReserva() != null && feedback.getReserva().getBicicleta() != null) { %>
                                    <div class="detail-row">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span>Local: <%= feedback.getReserva().getBicicleta().getLocalEntr_bike() != null ? feedback.getReserva().getBicicleta().getLocalEntr_bike() : "Local não disponível" %></span>
                                    </div>
                                <% } %>
                                <div class="rating-section">
                                    <div class="rating-row">
                                        <span>Avaliação da Bicicleta:</span>
                                        <div>
                                            <span class="rating-stars">
                                                <% 
                                                int avaliacaoBike = feedback.getAvaliacaoBike_feedb();
                                                for (int i = 1; i <= 5; i++) {
                                                    if (i <= avaliacaoBike) {
                                                        out.print("★");
                                                    } else {
                                                        out.print("☆");
                                                    }
                                                }
                                                %>
                                            </span>
                                            <span class="rating-value"><%= avaliacaoBike %>.0/5.0</span>
                                        </div>
                                    </div>
                                    <div class="rating-row">
                                        <span>Avaliação do Usuário:</span>
                                        <div>
                                            <span class="rating-stars">
                                                <% 
                                                int avaliacaoUser = feedback.getAvaliacaoUser_feedb();
                                                for (int i = 1; i <= 5; i++) {
                                                    if (i <= avaliacaoUser) {
                                                        out.print("★");
                                                    } else {
                                                        out.print("☆");
                                                    }
                                                }
                                                %>
                                            </span>
                                            <span class="rating-value"><%= avaliacaoUser %>.0/5.0</span>
                                        </div>
                                    </div>
                                </div>
                                <% if (feedback.getObsBike_feedb() != null && !feedback.getObsBike_feedb().trim().isEmpty()) { %>
                                    <div class="feedback-text">
                                        <strong>Observações sobre a Bicicleta:</strong> <%= feedback.getObsBike_feedb() %>
                                    </div>
                                <% } %>
                                <% if (feedback.getObsUser_feedb() != null && !feedback.getObsUser_feedb().trim().isEmpty()) { %>
                                    <div class="feedback-text">
                                        <strong>Observações sobre o Usuário:</strong> <%= feedback.getObsUser_feedb() %>
                                    </div>
                                <% } %>
                                <div class="detail-row">
                                    <i class="fas fa-tools"></i>
                                    <span>Status: 
                                        <% if (feedback.isFuncional_feedb()) { %>
                                            Funcional
                                        <% } else { %>
                                            Não funcional
                                        <% } %>
                                        <% if (feedback.isManutencao_feedb()) { %>
                                            - Bem Conservada 
                                        <% } else {%>
                                        	- Necessita manutenção
                                        <% } %>
                                        <% if (feedback.isComunicBoa_feedb()) { %>
                                            - Boa comunicação
                                        <% } %>
                                        <% if (feedback.isConfComp_feedb()) { %>
                                            - Compromisso confirmado
                                        <% } %>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="no-data">
                    <i class="fas fa-comments"></i>
                    <h3>Nenhum feedback encontrado</h3>
                    <p>Ainda não há feedbacks cadastrados no sistema.</p>
                </div>
            <% } %>
        </div>
        
        <!-- Botão de Voltar -->
        <div style="text-align: center; margin-top: 2rem;">
            <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar ao Painel
            </a>
        </div>
    </div>
    
    <footer style="text-align: center; padding: 2rem; background-color: #000; color: #fff; border-top: 1px solid #dee2e6; margin-top: 3rem;">
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
</body>
</html>