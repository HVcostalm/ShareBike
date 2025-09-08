<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Bicicleta" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="br.com.sharebike.model.Reserva" %>
<%@ page import="br.com.sharebike.model.Feedback" %>
<%@ page import="br.com.sharebike.model.Disponibilidade" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%!
// Função para gerar estrelas da avaliação
String gerarEstrelas(Float avaliacao) {
    if (avaliacao == null || avaliacao <= 0) {
        return "<i class=\"far fa-star\"></i><i class=\"far fa-star\"></i><i class=\"far fa-star\"></i><i class=\"far fa-star\"></i><i class=\"far fa-star\"></i>";
    }
    
    StringBuilder estrelas = new StringBuilder();
    int estrelasCompletas = (int) Math.floor(avaliacao);
    boolean meiaEstrela = (avaliacao - estrelasCompletas) >= 0.5;
    
    for (int i = 0; i < estrelasCompletas; i++) {
        estrelas.append("<i class=\"fas fa-star\"></i>");
    }
    if (meiaEstrela && estrelasCompletas < 5) {
        estrelas.append("<i class=\"fas fa-star-half-alt\"></i>");
        estrelasCompletas++;
    }
    for (int i = estrelasCompletas; i < 5; i++) {
        estrelas.append("<i class=\"far fa-star\"></i>");
    }
    
    return estrelas.toString();
}

// Função para gerar estrelas da avaliação (int)
String gerarEstrelas(int avaliacao) {
    return gerarEstrelas((float) avaliacao);
}

// Função para formatar avaliação
String formatarAvaliacao(Float avaliacao) {
    if (avaliacao == null || avaliacao <= 0) {
        return "Sem Avaliação";
    }
    return String.format("%.1f/5.0", avaliacao);
}

// Função para exibir avaliação completa (estrelas + texto)
String exibirAvaliacaoCompleta(Float avaliacao) {
    if (avaliacao == null || avaliacao <= 0) {
        return "<i class=\"far fa-star\"></i><i class=\"far fa-star\"></i><i class=\"far fa-star\"></i><i class=\"far fa-star\"></i><i class=\"far fa-star\"></i> Sem Avaliação";
    }
    return gerarEstrelas(avaliacao) + " (" + String.format("%.1f/5.0", avaliacao) + ")";
}

// Função para exibir avaliação completa com int (para feedbacks)
String exibirAvaliacaoCompletaInt(int avaliacao) {
    if (avaliacao <= 0) {
        return "Sem Avaliação";
    }
    Float avaliacaoFloat = (float) avaliacao;
    return gerarEstrelas(avaliacaoFloat) + " (" + avaliacao + "/5)";
}
%>

<%
// Obter dados enviados pelo controller
Bicicleta bicicleta = (Bicicleta) request.getAttribute("bicicleta");
Usuario proprietario = (Usuario) request.getAttribute("proprietario");
List<Reserva> reservasBicicleta = (List<Reserva>) request.getAttribute("reservasBicicleta");
List<Feedback> feedbacksBicicleta = (List<Feedback>) request.getAttribute("feedbacksBicicleta");
List<Disponibilidade> disponibilidadesBicicleta = (List<Disponibilidade>) request.getAttribute("disponibilidadesBicicleta");

// Obter métricas calculadas pelo controller
Integer totalReservasAttr = (Integer) request.getAttribute("totalReservas");
Integer reservasAtivasAttr = (Integer) request.getAttribute("reservasAtivas");
Integer totalFeedbacksAttr = (Integer) request.getAttribute("totalFeedbacks");
Double mediaAvaliacoesFeedbackAttr = (Double) request.getAttribute("mediaAvaliacoesFeedback");

int totalReservas = totalReservasAttr != null ? totalReservasAttr : 0;
int reservasAtivas = reservasAtivasAttr != null ? reservasAtivasAttr : 0;
int totalFeedbacks = totalFeedbacksAttr != null ? totalFeedbacksAttr : 0;
double mediaAvaliacoesFeedback = mediaAvaliacoesFeedbackAttr != null ? mediaAvaliacoesFeedbackAttr : 0.0;

// Verificar se há dados
if (bicicleta == null) {
    response.sendRedirect(request.getContextPath() + "/BicicletaController?action=lista-locatario");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes da Bicicleta - ShareBike</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .page-header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
            text-align: center;
            border-radius: 10px;
        }
        
        .page-header h1 {
            margin: 0;
            font-size: 2.5rem;
        }
        
        .nav {
            background: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .nav a {
            color: #38b2ac;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            transition: all 0.3s;
            border: 2px solid #38b2ac;
        }
        
        .nav a:hover, .nav a.active {
            background: #38b2ac;
            color: white;
        }
        
        .bike-header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 2rem;
        }
        
        .bike-image-main {
            width: 300px;
            height: 200px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }
        
        .bike-info-main {
            flex: 1;
        }
        
        .bike-title {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        
        .bike-subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
            margin-bottom: 1.5rem;
        }
        
        .bike-stats {
            display: flex;
            gap: 2rem;
            margin-top: 1rem;
        }
        
        .stat-item {
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
            padding: 1rem;
            border-radius: 10px;
            backdrop-filter: blur(10px);
        }
        
        .stat-value {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 0.3rem;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        .details-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .details-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #38b2ac;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .detail-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid #f8f9fa;
        }
        
        .detail-item:last-child {
            border-bottom: none;
        }
        
        .detail-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            color: white;
        }
        
        .detail-content {
            flex: 1;
        }
        
        .detail-label {
            font-weight: 500;
            color: #333;
            margin-bottom: 0.3rem;
        }
        
        .detail-value {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .owner-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        
        .owner-card:hover {
            transform: translateY(-5px);
        }
        
        .owner-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2rem;
            font-weight: bold;
            margin: 0 auto 1rem;
        }
        
        .availability-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .availability-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
        
        .availability-item:last-child {
            margin-bottom: 0;
        }
        
        .availability-dates {
            flex: 1;
        }
        
        .availability-status {
            padding: 0.5rem 1rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
            margin-right: 1rem;
        }
        
        .status-disponivel {
            background: #d4edda;
            color: #155724;
        }
        
        .status-indisponivel {
            background: #f8d7da;
            color: #721c24;
        }
        
        .review-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .review-item {
            display: flex;
            gap: 1rem;
            padding: 1.5rem 0;
            border-bottom: 1px solid #f8f9fa;
        }
        
        .review-item:last-child {
            border-bottom: none;
        }
        
        .review-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .review-content {
            flex: 1;
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }
        
        .review-author {
            font-weight: 600;
            color: #333;
        }
        
        .review-rating {
            color: #ffc107;
        }
        
        .review-date {
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .review-text {
            color: #555;
            line-height: 1.5;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin: 2rem 0;
        }
        
        .btn {
            background: #38b2ac;
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .btn:hover {
            background: #0d9488;
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }
        
        .btn-secondary {
            background: #6c757d;
        }
        
        .btn-secondary:hover {
            background: #545b62;
        }
        
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #666;
        }
        
        .empty-state i {
            font-size: 3rem;
            color: #ccc;
            margin-bottom: 1rem;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            color: #666;
            border-top: 1px solid #eee;
            margin-top: 40px;
            background: white;
            border-radius: 10px;
        }
        
        @media (max-width: 768px) {
            .bike-header {
                flex-direction: column;
                text-align: center;
            }
            
            .bike-image-main {
                width: 100%;
                max-width: 300px;
            }
            
            .details-grid {
                grid-template-columns: 1fr;
            }
            
            .bike-stats {
                justify-content: center;
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1><i class="fas fa-bicycle"></i> Detalhes da Bicicleta</h1>
        </div>
        
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/BicicletaController?action=lista-locatario"><i class="fas fa-search"></i> Buscar Bicicletas</a>
        </nav>
        
        <!-- Cabeçalho da Bicicleta -->
        <div class="bike-header">
            <img src="<%=bicicleta.getFoto_bike()%>" alt="<%=bicicleta.getNome_bike()%>" class="bike-image-main">
            <div class="bike-info-main">
                <div class="bike-title"><%=bicicleta.getNome_bike() != null ? bicicleta.getNome_bike() : "Bicicleta"%></div>
                <div class="bike-subtitle"><%=bicicleta.getTipo_bike() != null ? bicicleta.getTipo_bike() : "Tipo não informado"%></div>
                <div class="bike-stats">
                    <div class="stat-item">
                        <div class="stat-value"><%=exibirAvaliacaoMetrica(bicicleta.getAvaliacao_bike())%></div>
                        <div class="stat-label">Avaliação</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value"><%=totalReservas%></div>
                        <div class="stat-label">Total Reservas</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value"><%=totalFeedbacks%></div>
                        <div class="stat-label">Avaliações</div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Grid de Detalhes -->
        <div class="details-grid">
            <!-- Especificações -->
            <div class="details-section">
                <h2 class="section-title">
                    <i class="fas fa-cog"></i> Especificações Técnicas
                </h2>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-bicycle"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Tipo de Bicicleta</div>
                        <div class="detail-value"><%=bicicleta.getTipo_bike() != null ? bicicleta.getTipo_bike() : "Não informado"%></div>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-cogs"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Estado de Conservação</div>
                        <div class="detail-value"><%=bicicleta.getEstadoConserv_bike() != null ? bicicleta.getEstadoConserv_bike() : "Não informado"%></div>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Local de Entrega</div>
                        <div class="detail-value"><%=bicicleta.getLocalEntr_bike() != null ? bicicleta.getLocalEntr_bike() : "Não informado"%></div>
                    </div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Avaliação</div>
                        <div class="detail-value"><%=exibirAvaliacaoCompleta(bicicleta.getAvaliacao_bike())%></div>
                    </div>
                </div>
                
                <% if (bicicleta.getChassi_bike() != null && !bicicleta.getChassi_bike().trim().isEmpty()) { %>
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-barcode"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Chassi</div>
                        <div class="detail-value"><%=bicicleta.getChassi_bike()%></div>
                    </div>
                </div>
                <% } %>
            </div>
            
            <!-- Informações do Proprietário -->
            <div class="owner-card" onclick="location.href='<%=request.getContextPath()%>/UsuarioController?action=exibir&cpfCnpj=<%=proprietario != null ? proprietario.getCpfCnpj_user() : ""%>&origem=bicicletaDetalhesLocatario&bicicletaId=<%=bicicleta.getId_bike()%>'">
                <h2 class="section-title">
                    <i class="fas fa-user"></i> Proprietário
                </h2>
                
                <% if (proprietario != null) { %>
                <div class="owner-avatar">
                    <%=proprietario.getNomeRazaoSocial_user().substring(0, 1).toUpperCase()%>
                </div>
                <h3><%=proprietario.getNomeRazaoSocial_user()%></h3>
                <p><%=proprietario.getCidade_user()%>, <%=proprietario.getEstado_user()%></p>
                <p>📞 <%=proprietario.getTelefone_user()%></p>
                <% if (proprietario.getAvaliacao_user() != null) { %>
                <div class="review-rating">
                    <%=exibirAvaliacaoCompleta(proprietario.getAvaliacao_user())%>
                </div>
                <% } %>
                <p><small>Clique para ver perfil</small></p>
                <% } else { %>
                <p>Informações do proprietário não disponíveis</p>
                <% } %>
            </div>
        </div>
        
        <!-- Disponibilidades -->
        <div class="availability-section">
            <h2 class="section-title">
                <i class="fas fa-calendar-alt"></i> Disponibilidade
            </h2>
            
            <% if (disponibilidadesBicicleta != null && !disponibilidadesBicicleta.isEmpty()) { %>
                <% for (Disponibilidade disp : disponibilidadesBicicleta) { %>
                <div class="availability-item">
                    <div class="availability-dates">
                        <strong><%=disp.getDataHoraIn_disp().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))%></strong>
                        até
                        <strong><%=disp.getDataHoraFim_disp().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))%></strong>
                    </div>
                    <div class="availability-status <%=disp.isDisponivel_disp() ? "status-disponivel" : "status-indisponivel"%>">
                        <%=disp.isDisponivel_disp() ? "Disponível" : "Indisponível"%>
                    </div>
                    <% if (disp.isDisponivel_disp()) { %>
                    <a href="<%=request.getContextPath()%>/BicicletaController?action=fazer-reserva&id=<%=bicicleta.getId_bike()%>&disponibilidadeId=<%=disp.getId_disp()%>" class="btn">
                        <i class="fas fa-calendar-plus"></i> Fazer Reserva
                    </a>
                    <% } %>
                </div>
                <% } %>
            <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-calendar-times"></i>
                    <p>Nenhuma disponibilidade cadastrada para esta bicicleta.</p>
                </div>
            <% } %>
        </div>
        
        <!-- Seção de Avaliações -->
        <div class="review-section">
            <h2 class="section-title">
                <i class="fas fa-star"></i> Avaliações dos Locatários
            </h2>
            
            <% if (feedbacksBicicleta != null && !feedbacksBicicleta.isEmpty()) { %>
                <% for (Feedback feedback : feedbacksBicicleta) { %>
                <div class="review-item">
                    <div class="review-avatar">
                        <%=feedback.getAvaliador_Usuario() != null && feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() != null ? 
                           feedback.getAvaliador_Usuario().getNomeRazaoSocial_user().substring(0, 1).toUpperCase() : "U"%>
                    </div>
                    <div class="review-content">
                        <div class="review-header">
                            <div class="review-author">
                                <%=feedback.getAvaliador_Usuario() != null && feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() != null ? 
                                   feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() : "Usuário Anônimo"%>
                            </div>
                            <div class="review-rating">
                                <%=exibirAvaliacaoCompletaInt(feedback.getAvaliacaoBike_feedb())%>
                            </div>
                        </div>
                        <div class="review-date">
                            <%=feedback.getData_feedb().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))%>
                        </div>
                        <% if (feedback.getObsBike_feedb() != null && !feedback.getObsBike_feedb().trim().isEmpty()) { %>
                        <div class="review-text">
                            "<%=feedback.getObsBike_feedb()%>"
                        </div>
                        <% } %>
                    </div>
                </div>
                <% } %>
            <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-comment-slash"></i>
                    <p>Ainda não há avaliações para esta bicicleta.</p>
                </div>
            <% } %>
        </div>
        
        <!-- Botões de Ação -->
        <div class="action-buttons">
            <a href="<%=request.getContextPath()%>/BicicletaController?action=lista-locatario" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Voltar à Busca
            </a>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
</body>
</html>

<%!
// Função auxiliar para exibir valor de avaliação em métricas
String exibirAvaliacaoMetrica(Float avaliacao) {
    if (avaliacao == null || avaliacao == 0.0f) {
        return "Sem Avaliação";
    }
    return String.format("%.1f", avaliacao);
}
%>
