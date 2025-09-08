<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="br.com.sharebike.model.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // Verificar se o usuário está logado
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
        return;
    }
    
    // Recuperar dados enviados pelo controller
    List<Reserva> reservasFinalizadas = (List<Reserva>) request.getAttribute("reservasFinalizadas");
    List<Feedback> feedbacksFeitos = (List<Feedback>) request.getAttribute("feedbacksFeitos");
    List<Feedback> feedbacksRecebidos = (List<Feedback>) request.getAttribute("feedbacksRecebidos");
    
    // Verificar se foi solicitada uma reserva específica
    Integer reservaEspecifica = (Integer) request.getAttribute("reservaEspecifica");
    
    if (reservasFinalizadas == null) reservasFinalizadas = new ArrayList<>();
    if (feedbacksFeitos == null) feedbacksFeitos = new ArrayList<>();
    if (feedbacksRecebidos == null) feedbacksRecebidos = new ArrayList<>();
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    
    // Filtrar reservas se foi especificada uma reserva específica
    List<Reserva> pendentes = new ArrayList<>();
    if (reservaEspecifica != null) {
        // Se foi especificada uma reserva, filtrar apenas essa
        for (Reserva reserva : reservasFinalizadas) {
            if (reserva.getId_reserv() == reservaEspecifica) {
                pendentes.add(reserva);
                break;
            }
        }
    } else {
        // Calcular pendentes - reservas que não têm feedback do locatário
        for (Reserva reserva : reservasFinalizadas) {
            boolean jaFezFeedback = false;
            for (Feedback feedback : feedbacksFeitos) {
                if (feedback.getReserva() != null && feedback.getReserva().getId_reserv() == reserva.getId_reserv()) {
                    jaFezFeedback = true;
                    break;
                }
            }
            if (!jaFezFeedback) {
                pendentes.add(reserva);
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Avaliar Experiências - Locatário</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/feedback.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .star {
            cursor: pointer;
            color: #ddd;
            font-size: 1.5rem;
            transition: color 0.2s;
        }
        .star:hover,
        .star.active {
            color: #ffc107;
        }
        .quality-tag {
            display: inline-block;
            background: #e9ecef;
            color: #495057;
            padding: 0.25rem 0.5rem;
            margin: 0.25rem;
            border-radius: 15px;
            font-size: 0.8rem;
            border: 1px solid #dee2e6;
        }
        .qualities-display {
            margin-top: 0.5rem;
        }
        .no-data {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        .rating-stars {
            color: #ffc107;
            font-size: 1.1rem;
        }
        .feedback-card {
            display: block;
        }
        .feedback-card[data-category="realizadas"],
        .feedback-card[data-category="recebidas"] {
            display: none;
        }
        .no-data[data-category="realizadas"],
        .no-data[data-category="recebidas"] {
            display: none;
        }
        
        /* Forçar header com tamanho igual ao bicicletasLocatario */
        header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%) !important;
            color: white !important;
            padding: 2rem !important;
            text-align: center !important;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1) !important;
            margin: 0 !important;
        }
        
        header h1 {
            margin: 0 !important;
            font-size: 2.5rem !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            gap: 1rem !important;
            font-weight: 600 !important;
        }
        
        /* Garantir que o container tenha o espaçamento correto */
        .container {
            margin: 0 auto !important;
            max-width: 1200px !important;
            padding: 20px !important;
            background: white !important;
            border-radius: 10px !important;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2) !important;
        }
        
        /* Centralizar navegação igual às outras páginas */
        .nav {
            display: flex !important;
            justify-content: center !important;
            margin-bottom: 2rem !important;
            flex-wrap: wrap !important;
            background: white !important;
            padding: 15px !important;
            border-radius: 10px !important;
            gap: 15px !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1) !important;
        }
        
        .nav a {
            text-decoration: none !important;
            color: white !important;
            background-color: #38b2ac !important;
            padding: 1rem 2rem !important;
            border-radius: 5px !important;
            transition: background-color 0.3s !important;
            margin: 0 !important;
        }
        
        .nav a:hover {
            background-color: #0d9488 !important;
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-comment-dots"></i> Minhas Avaliações - Dashboard</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
        	<a href="<%=request.getContextPath()%>/UsuarioController?action=perfil" class="nav-profile"><i class="fas fa-user"></i> Meu Perfil</a>
            <a href="<%=request.getContextPath()%>/BicicletaController?action=lista-locatario"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="<%=request.getContextPath()%>/FeedbackController?action=pagina-locatario"><i class="fas fa-comment-dots"></i> Dar Feedback</a>
            <a href="<%=request.getContextPath()%>/pages/rankingLocatario.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <!-- Filtros -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterFeedbacks('pendentes')">
                <i class="fas fa-clock"></i> Avaliações Pendentes (<%= pendentes.size() %>)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('realizadas')">
                <i class="fas fa-check-circle"></i> Já Avaliadas (<%= feedbacksFeitos.size() %>)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('recebidas')">
                <i class="fas fa-star"></i> Avaliações Recebidas (<%= feedbacksRecebidos.size() %>)
            </button>
        </div>
        
        <!-- Lista de Feedbacks -->
        <div class="feedback-grid">
            <!-- Avaliações Pendentes -->
            <% for (Reserva reserva : pendentes) { %>
            <div class="feedback-card" data-category="pendentes">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> Reserva finalizada em: <%= reserva.getDataCheckOut_reserv().format(formatter) %>
                            <span style="color: #ffc107; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-clock"></i> PENDENTE AVALIAÇÃO
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #<%= reserva.getId_reserv() %></div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/bike-placeholder.jpg" alt="<%= reserva.getBicicleta().getTipo_bike() %>" 
                         class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/ffc107/000000?text=Bike'">
                    <div class="feedback-details">
                        <div class="bike-name"><%= reserva.getBicicleta().getTipo_bike() %> - <%= reserva.getBicicleta().getNome_bike() %></div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: <%= reserva.getBicicleta().getUsuario().getNomeRazaoSocial_user() %> (<%= reserva.getBicicleta().getUsuario().getEmail_user() %>)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: <%= reserva.getDataCheckIn_reserv().format(formatter) %> - <%= reserva.getDataCheckOut_reserv().format(formatter) %></span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-clock"></i>
                            <span>Duração: <%= java.time.Duration.between(reserva.getDataCheckIn_reserv(), reserva.getDataCheckOut_reserv()).toDays() %> dia(s)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-bicycle"></i>
                            <span>Tipo: <%= reserva.getBicicleta().getTipo_bike() %> - Estado: <%= reserva.getBicicleta().getEstadoConserv_bike() %></span>
                        </div>
                        <div class="feedback-actions">
                            <a href="<%=request.getContextPath()%>/FeedbackController?action=fazer-avaliacao&reservaId=<%= reserva.getId_reserv() %>" class="btn btn-primary">
                                <i class="fas fa-star"></i> Avaliar Experiência
                            </a>
                            <a href="<%=request.getContextPath()%>/UsuarioController?action=exibir&cpfCnpj=<%= reserva.getBicicleta().getUsuario().getCpfCnpj_user() %>&origem=feedbackLocatario" class="btn btn-info">
                                <i class="fas fa-user-circle"></i> Ver Perfil do Proprietário
                            </a>	
                            <a href="<%=request.getContextPath()%>/BicicletaController?action=exibir-locatario&id=<%= reserva.getBicicleta().getId_bike() %>" class="btn btn-info">
                                <i class="fas fa-user-circle"></i> Ver Bicicleta
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            
            <% if (pendentes.isEmpty()) { %>
            <div class="no-data" data-category="pendentes">
                <i class="fas fa-check-circle" style="font-size: 4rem; color: #28a745; margin-bottom: 1rem;"></i>
                <h3>Todas as avaliações foram realizadas!</h3>
                <p>Você não possui nenhuma avaliação pendente no momento.</p>
            </div>
            <% } %>
            
            <!-- Avaliações Já Realizadas -->
            <% for (Feedback feedback : feedbacksFeitos) { %>
            <div class="feedback-card" data-category="realizadas">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> Avaliado em: <%= feedback.getData_feedb().format(formatter) %>
                            <span style="color: #28a745; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-check-circle"></i> AVALIADO
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #<%= feedback.getReserva().getId_reserv() %></div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/bike-placeholder.jpg" alt="<%= feedback.getReserva().getBicicleta().getTipo_bike() %>" 
                         class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/28a745/ffffff?text=Avaliado'">
                    <div class="feedback-details">
                        <div class="bike-name"><%= feedback.getReserva().getBicicleta().getTipo_bike() %> - <%= feedback.getReserva().getBicicleta().getNome_bike() %></div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: <%= feedback.getAvaliado_Usuario().getNomeRazaoSocial_user() %></span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: <%= feedback.getReserva().getDataCheckIn_reserv().format(formatter) %> - <%= feedback.getReserva().getDataCheckOut_reserv().format(formatter) %></span>
                        </div>
                        <div class="rating-section">
                            <% if (feedback.getAvaliacaoBike_feedb() > 0) { %>
                            <div class="rating-row">
                                <span>Avaliação da Bicicleta:</span>
                                <div>
                                    <span class="rating-stars">
                                        <% for (int i = 1; i <= 5; i++) { %>
                                            <%= i <= feedback.getAvaliacaoBike_feedb() ? "★" : "☆" %>
                                        <% } %>
                                    </span>
                                    <span class="rating-value"><%= feedback.getAvaliacaoBike_feedb() %>.0/5.0</span>
                                </div>
                            </div>
                            <% } %>
                            <% if (feedback.getAvaliacaoUser_feedb() > 0) { %>
                            <div class="rating-row">
                                <span>Avaliação do Proprietário:</span>
                                <div>
                                    <span class="rating-stars">
                                        <% for (int i = 1; i <= 5; i++) { %>
                                            <%= i <= feedback.getAvaliacaoUser_feedb() ? "★" : "☆" %>
                                        <% } %>
                                    </span>
                                    <span class="rating-value"><%= feedback.getAvaliacaoUser_feedb() %>.0/5.0</span>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <% if (feedback.getObsBike_feedb() != null && !feedback.getObsBike_feedb().trim().isEmpty()) { %>
                        <div class="feedback-text">
                            "Sobre a bicicleta: <%= feedback.getObsBike_feedb() %>"
                        </div>
                        <% } %>
                        <% if (feedback.getObsUser_feedb() != null && !feedback.getObsUser_feedb().trim().isEmpty()) { %>
                        <div class="feedback-text">
                            "Sobre o proprietário: <%= feedback.getObsUser_feedb() %>"
                        </div>
                        <% } %>
                        <div class="qualities-display">
                            <% if (feedback.isConfComp_feedb()) { %><span class="quality-tag">Compartilhamento Confortável</span><% } %>
                            <% if (feedback.isComunicBoa_feedb()) { %><span class="quality-tag">Boa Comunicação</span><% } %>
                            <% if (feedback.isFuncional_feedb()) { %><span class="quality-tag">Funcional</span><% } %>
                            <% if (feedback.isManutencao_feedb()) { %><span class="quality-tag">Bem Conservada</span><% } %>
                        </div>
                        <div class="feedback-actions">
                            <a href="<%=request.getContextPath()%>/UsuarioController?action=exibir&cpfCnpj=<%= feedback.getReserva().getBicicleta().getUsuario().getCpfCnpj_user() %>&origem=feedbackLocatario" class="btn btn-info">
                                <i class="fas fa-user-circle"></i> Ver Perfil do Proprietário
                            </a>
                            <a href="<%=request.getContextPath()%>/BicicletaController?action=exibir-locatario&id=<%= feedback.getReserva().getBicicleta().getId_bike() %>" class="btn btn-info">
                                <i class="fas fa-user-circle"></i> Ver Bicicleta
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            
            <% if (feedbacksFeitos.isEmpty()) { %>
            <div class="no-data" data-category="realizadas" style="display: none;">
                <i class="fas fa-comment-slash" style="font-size: 4rem; color: #6c757d; margin-bottom: 1rem;"></i>
                <h3>Nenhuma avaliação realizada ainda</h3>
                <p>Você ainda não avaliou nenhuma experiência de aluguel.</p>
            </div>
            <% } %>
            
            <!-- Avaliações Recebidas -->
            <% for (Feedback feedback : feedbacksRecebidos) { %>
            <div class="feedback-card" data-category="recebidas">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> Recebida em: <%= feedback.getData_feedb().format(formatter) %>
                            <span style="color: #17a2b8; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-inbox"></i> AVALIAÇÃO RECEBIDA
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #<%= feedback.getReserva().getId_reserv() %></div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/bike-placeholder.jpg" alt="<%= feedback.getReserva().getBicicleta().getTipo_bike() %>" 
                         class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/17a2b8/ffffff?text=Recebida'">
                    <div class="feedback-details">
                        <div class="bike-name"><%= feedback.getReserva().getBicicleta().getTipo_bike() %> - <%= feedback.getReserva().getBicicleta().getNome_bike() %></div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Avaliado por: <%= feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() %> (Proprietário)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período da reserva: <%= feedback.getReserva().getDataCheckIn_reserv().format(formatter) %> - <%= feedback.getReserva().getDataCheckOut_reserv().format(formatter) %></span>
                        </div>
                        <div class="rating-section">
                            <% if (feedback.getAvaliacaoBike_feedb() > 0) { %>
                            <div class="rating-row">
                                <span><i class="fas fa-star"></i> Nota que você recebeu:</span>
                                <div>
                                    <span class="rating-stars">
                                        <% for (int i = 1; i <= 5; i++) { %>
                                            <%= i <= feedback.getAvaliacaoBike_feedb() ? "★" : "☆" %>
                                        <% } %>
                                    </span>
                                    <span class="rating-value"><%= feedback.getAvaliacaoBike_feedb() %>.0/5.0</span>
                                </div>
                            </div>
                            <% } %>
                            <% if (feedback.getAvaliacaoUser_feedb() > 0) { %>
                            <div class="rating-row">
                                <span>Avaliação Sua (Como Locatário):</span>
                                <div>
                                    <span class="rating-stars">
                                        <% for (int i = 1; i <= 5; i++) { %>
                                            <%= i <= feedback.getAvaliacaoUser_feedb() ? "★" : "☆" %>
                                        <% } %>
                                    </span>
                                    <span class="rating-value"><%= feedback.getAvaliacaoUser_feedb() %>.0/5.0</span>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <% if (feedback.getObsUser_feedb() != null && !feedback.getObsUser_feedb().trim().isEmpty()) { %>
                        <div class="feedback-text">
                            "<%= feedback.getObsUser_feedb() %>"
                        </div>
                        <% } %>
                        <div class="detail-row">
                            <i class="fas fa-check-circle"></i>
                            <span>Qualidades destacadas: 
                                <% if (feedback.isConfComp_feedb()) { %>Compartilhamento Confortável<% } %>
                                <% if (feedback.isComunicBoa_feedb()) { %><% if (feedback.isConfComp_feedb()) { %>, <% } %>Boa Comunicação<% } %>
                                <% if (feedback.isFuncional_feedb()) { %><% if (feedback.isConfComp_feedb() || feedback.isComunicBoa_feedb()) { %>, <% } %>Funcional<% } %>
                                <% if (feedback.isManutencao_feedb()) { %><% if (feedback.isConfComp_feedb() || feedback.isComunicBoa_feedb() || feedback.isFuncional_feedb()) { %>, <% } %>Cuidadoso<% } %>
                            </span>
                        </div>
                        <div class="feedback-actions">
                            <a href="<%=request.getContextPath()%>/UsuarioController?action=exibir&cpfCnpj=<%= feedback.getReserva().getBicicleta().getUsuario().getCpfCnpj_user() %>&origem=feedbackLocatario" class="btn btn-info">
                                <i class="fas fa-user-circle"></i> Ver Perfil do Proprietário
                            </a>
                            <a href="<%=request.getContextPath()%>/BicicletaController?action=exibir-locatario&id=<%= feedback.getReserva().getBicicleta().getId_bike() %>" class="btn btn-info">
                                <i class="fas fa-user-circle"></i> Ver Bicicleta
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            
            <% if (feedbacksRecebidos.isEmpty()) { %>
            <div class="no-data" data-category="recebidas" style="display: none;">
                <i class="fas fa-inbox" style="font-size: 4rem; color: #6c757d; margin-bottom: 1rem;"></i>
                <h3>Nenhuma avaliação recebida ainda</h3>
                <p>Você ainda não recebeu nenhuma avaliação dos proprietários.</p>
            </div>
            <% } %>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        // Inicializar a página mostrando apenas "pendentes"
        document.addEventListener('DOMContentLoaded', function() {
            filterFeedbacks('pendentes');
        });
        
        function filterFeedbacks(category) {
            // Remove active class from all tabs
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Add active class to clicked tab
            document.querySelector('.filter-tab[onclick*="' + category + '"]').classList.add('active');
            
            // Show/hide feedback cards and no-data messages
            document.querySelectorAll('.feedback-card, .no-data').forEach(element => {
                if (element.dataset.category === category) {
                    element.style.display = 'block';
                } else {
                    element.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>