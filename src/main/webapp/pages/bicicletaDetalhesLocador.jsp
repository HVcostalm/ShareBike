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

// Sobrecarga para aceitar int
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

// Função para exibir valor de avaliação em métricas
String exibirAvaliacaoMetrica(Float avaliacao) {
    if (avaliacao == null || avaliacao <= 0) {
        return "N/A";
    }
    return String.format("%.1f", avaliacao);
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
    // Para feedbacks, 0 também é considerado como "sem avaliação" pois não faz sentido dar 0 estrelas
    if (avaliacao <= 0) {
        return "Sem Avaliação";
    }
    Float avaliacaoFloat = (float) avaliacao;
    return gerarEstrelas(avaliacaoFloat) + " (" + avaliacao + "/5)";
}
%>

<%
// Verificar se o usuário está logado
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
if (usuarioLogado == null) {
    response.sendRedirect("loginUsuario.jsp");
    return;
}

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

if (bicicleta == null) {
    response.sendRedirect("bicicletasLocador.jsp");
    return;
}

// Obter avaliação da bicicleta
Float mediaAvaliacoes = bicicleta.getAvaliacao_bike();
// Tratar 0.0 como se fosse null
if (mediaAvaliacoes != null && mediaAvaliacoes == 0.0f) {
    mediaAvaliacoes = null;
}

// Formatadores de data
DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes da Bicicleta - Locador</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .bike-details-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
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
        
        .bike-status {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
            margin-bottom: 1rem;
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
        
        .management-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }
        
        .action-btn {
            background: rgba(255, 255, 255, 0.9);
            color: #38b2ac;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .action-btn:hover {
            background: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
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
            color: #333;
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
        
        .edit-icon {
            color: #007bff;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 50%;
            transition: all 0.3s ease;
        }
        
        .edit-icon:hover {
            background: #f8f9fa;
            color: #0056b3;
        }
        
        .performance-metrics {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 1rem;
        }
        
        .metric-card {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
        }
        
        .metric-value {
            font-size: 2rem;
            font-weight: bold;
            color: #38b2ac;
            margin-bottom: 0.5rem;
        }
        
        .metric-label {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .metric-change {
            font-size: 0.8rem;
            margin-top: 0.5rem;
        }
        
        .metric-change.positive {
            color: #38b2ac;
        }
        
        .metric-change.negative {
            color: #dc3545;
        }
        
        .availability-calendar {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        .calendar-day {
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .calendar-day.header {
            background: #f8f9fa;
            color: #6c757d;
            font-weight: 600;
            cursor: default;
        }
        
        .calendar-day.available {
            background: #d4edda;
            color: #155724;
        }
        
        .calendar-day.available:hover {
            background: #c3e6cb;
            transform: scale(1.05);
        }
        
        .calendar-day.unavailable {
            background: #f8d7da;
            color: #721c24;
            cursor: not-allowed;
        }
        
        .calendar-day.reserved {
            background: #fff3cd;
            color: #856404;
            cursor: default;
        }
        
        .calendar-legend {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .legend-color {
            width: 20px;
            height: 20px;
            border-radius: 3px;
        }
        
        .recent-bookings {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .booking-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            border-bottom: 1px solid #f8f9fa;
            transition: background 0.3s ease;
        }
        
        .booking-item:hover {
            background: #f8f9fa;
        }
        
        .booking-item:last-child {
            border-bottom: none;
        }
        
        .booking-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .booking-details {
            flex: 1;
        }
        
        .booking-customer {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.3rem;
        }
        
        .booking-period {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .booking-status {
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .booking-status.active {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .booking-status.completed {
            background: #d4edda;
            color: #155724;
        }
        
        .booking-status.upcoming {
            background: #fff3cd;
            color: #856404;
        }
        
        .main-action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin: 2rem 0;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
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
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }
        
        .btn-success {
            background: linear-gradient(135deg, #38b2ac, #0d9488);
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
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(56, 178, 172, 0.3);
        }
        
        .btn-secondary {
            background: #6c757d;
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
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
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
            
            .management-actions {
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .main-action-buttons {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-bicycle"></i> Detalhes da Bicicleta</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/BicicletaController?action=minhas-bikes&cpfCnpj=<%= usuarioLogado.getCpfCnpj_user() %>"><i class="fas fa-arrow-left"></i> Voltar às Minhas Bicicletas</a>
        </nav>
        
        <div class="bike-details-container">
            <!-- Cabeçalho da Bicicleta -->
            <div class="bike-header">
                <img src="<%= bicicleta.getFoto_bike() %>" alt="<%= bicicleta.getNome_bike() %>" class="bike-image-main" >
                <div class="bike-info-main">
                    <div class="bike-title"><%= bicicleta.getNome_bike() != null ? bicicleta.getNome_bike() : "Nome não informado" %></div>
                    <div class="bike-subtitle"><%= bicicleta.getTipo_bike() != null ? bicicleta.getTipo_bike() : "Tipo não informado" %></div>
                    <div class="bike-status">
                        <i class="fas fa-check-circle"></i>
                        Sua Bicicleta
                    </div>
                    <div class="bike-stats">
                        <div class="stat-item">
                            <div class="stat-value">
                                <%= gerarEstrelas(bicicleta.getAvaliacao_bike()) %>
                                <br>
                                <%= exibirAvaliacaoMetrica(bicicleta.getAvaliacao_bike()) %>/5.0
                            </div>
                            <div class="stat-label">Avaliação</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value"><%= totalReservas %></div>
                            <div class="stat-label">Reservas</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value"><%= totalFeedbacks %></div>
                            <div class="stat-label">Avaliações</div>
                        </div>
                    </div>
                    <div class="management-actions">
                        <a href="<%=request.getContextPath()%>/BicicletaController?action=form-editar&id=<%= bicicleta.getId_bike() %>" class="action-btn">
                            <i class="fas fa-edit"></i> Editar Detalhes
                        </a>
                        <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp?id=<%= bicicleta.getId_bike() %>" class="action-btn">
                            <i class="fas fa-calendar-alt"></i> Gerenciar Disponibilidade
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Métricas de Performance -->
            <div class="performance-metrics">
                <h2 class="section-title">
                    <i class="fas fa-chart-line"></i> Métricas de Performance
                </h2>
                <div class="metrics-grid">
                    <div class="metric-card">
                        <div class="metric-value">
                            <%= gerarEstrelas(bicicleta.getAvaliacao_bike()) %>
                            <br>
                            <%= exibirAvaliacaoMetrica(bicicleta.getAvaliacao_bike()) %>/5.0
                        </div>
                        <div class="metric-label">Avaliação Média</div>
                        <div class="metric-change <%= (bicicleta.getAvaliacao_bike() != null && bicicleta.getAvaliacao_bike() >= 4.0) ? "positive" : "negative" %>">
                            <%= formatarAvaliacao(bicicleta.getAvaliacao_bike()) %>
                        </div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value"><%= totalReservas %></div>
                        <div class="metric-label">Total de Reservas</div>
                        <div class="metric-change positive">Histórico completo</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value"><%= totalFeedbacks %></div>
                        <div class="metric-label">Avaliações Recebidas</div>
                        <div class="metric-change <%= totalFeedbacks > 0 ? "positive" : "negative" %>">
                            <%= totalFeedbacks > 0 ? "Média: " + String.format("%.1f", mediaAvaliacoesFeedback) + "/5.0" : "Nenhuma avaliação" %>
                        </div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value"><%= disponibilidadesBicicleta != null ? disponibilidadesBicicleta.size() : 0 %></div>
                        <div class="metric-label">Disponibilidades</div>
                        <div class="metric-change <%= disponibilidadesBicicleta != null && disponibilidadesBicicleta.size() > 0 ? "positive" : "negative" %>">
                            <%= disponibilidadesBicicleta != null && disponibilidadesBicicleta.size() > 0 ? "Configuradas" : "Não configuradas" %>
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
                        <i class="fas fa-edit edit-icon" onclick="window.location.href='<%=request.getContextPath()%>/BicicletaController?action=form-editar&id=<%= bicicleta.getId_bike() %>'" title="Editar especificações"></i>
                    </h2>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-bicycle"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Nome da Bicicleta</div>
                            <div class="detail-value"><%= bicicleta.getNome_bike() != null ? bicicleta.getNome_bike() : "Não informado" %></div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-tags"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Tipo</div>
                            <div class="detail-value"><%= bicicleta.getTipo_bike() != null ? bicicleta.getTipo_bike() : "Não informado" %></div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Local de Entrega</div>
                            <div class="detail-value"><%= bicicleta.getLocalEntr_bike() != null ? bicicleta.getLocalEntr_bike() : "Não informado" %></div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-tools"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Estado de Conservação</div>
                            <div class="detail-value"><%= bicicleta.getEstadoConserv_bike() != null ? bicicleta.getEstadoConserv_bike() : "Não informado" %></div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-barcode"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Chassi</div>
                            <div class="detail-value"><%= bicicleta.getChassi_bike() != null ? bicicleta.getChassi_bike() : "Não informado" %></div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Avaliação</div>
                            <div class="detail-value">
                                <%= exibirAvaliacaoCompleta(bicicleta.getAvaliacao_bike()) %>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Informações do Proprietário -->
                <div class="details-section">
                    <h2 class="section-title">
                        <i class="fas fa-user"></i> Informações do Proprietário
                    </h2>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-user-circle"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Nome</div>
                            <div class="detail-value"><%= proprietario != null && proprietario.getNomeRazaoSocial_user() != null ? proprietario.getNomeRazaoSocial_user() : "Não informado" %></div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Email</div>
                            <div class="detail-value"><%= proprietario != null && proprietario.getEmail_user() != null ? proprietario.getEmail_user() : "Não informado" %></div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Telefone</div>
                            <div class="detail-value"><%= proprietario != null && proprietario.getTelefone_user() != null ? proprietario.getTelefone_user() : "Não informado" %></div>
                        </div>
                    </div>
                    
                    
                </div>
            </div>
            
            <!-- Reservas da Bicicleta -->
            <% if (reservasBicicleta != null && !reservasBicicleta.isEmpty()) { %>
            <div class="recent-bookings">
                <h2 class="section-title">
                    <i class="fas fa-calendar-check"></i> Reservas da Bicicleta (<%= reservasBicicleta.size() %>)
                </h2>
                
                <% for (Reserva reserva : reservasBicicleta) { 
                    String statusClass = "";
                    if ("Ativa".equals(reserva.getStatus_reserv()) || "Confirmada".equals(reserva.getStatus_reserv())) {
                        statusClass = "upcoming";
                    } else if ("Finalizada".equals(reserva.getStatus_reserv()) || "Concluída".equals(reserva.getStatus_reserv())) {
                        statusClass = "completed";
                    } else {
                        statusClass = "active";
                    }
                    
                    // Criar iniciais do usuário
                    String iniciais = "";
                    if (reserva.getUsuario() != null && reserva.getUsuario().getNomeRazaoSocial_user() != null) {
                        String[] nomes = reserva.getUsuario().getNomeRazaoSocial_user().split(" ");
                        if (nomes.length >= 2) {
                            iniciais = String.valueOf(nomes[0].charAt(0)) + String.valueOf(nomes[1].charAt(0));
                        } else if (nomes.length == 1) {
                            iniciais = String.valueOf(nomes[0].charAt(0)) + String.valueOf(nomes[0].charAt(1));
                        } else {
                            iniciais = "??";
                        }
                    }
                %>
                <div class="booking-item">
                    <div class="booking-avatar"><%= iniciais.toUpperCase() %></div>
                    <div class="booking-details">
                        <div class="booking-customer">
                            <%= reserva.getUsuario() != null && reserva.getUsuario().getNomeRazaoSocial_user() != null ? 
                                reserva.getUsuario().getNomeRazaoSocial_user() : "Nome não informado" %>
                        </div>
                        <div class="booking-period">
                            <%= reserva.getDataCheckIn_reserv() != null ? reserva.getDataCheckIn_reserv().toLocalDate() : "Data não informada" %> 
                            até 
                            <%= reserva.getDataCheckOut_reserv() != null ? reserva.getDataCheckOut_reserv().toLocalDate() : "Data não informada" %>
                        </div>
                    </div>
                    <div class="booking-status <%= statusClass %>"><%= reserva.getStatus_reserv() != null ? reserva.getStatus_reserv() : "Status não informado" %></div>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="recent-bookings">
                <h2 class="section-title">
                    <i class="fas fa-calendar-check"></i> Reservas da Bicicleta
                </h2>
                <div style="text-align: center; padding: 2rem; color: #6c757d;">
                    <i class="fas fa-calendar-times" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                    <p>Nenhuma reserva encontrada para esta bicicleta.</p>
                </div>
            </div>
            <% } %>
            
            <!-- Feedbacks da Bicicleta -->
            <% if (feedbacksBicicleta != null && !feedbacksBicicleta.isEmpty()) { %>
            <div class="recent-bookings">
                <h2 class="section-title">
                    <i class="fas fa-comments"></i> Avaliações da Bicicleta (<%= feedbacksBicicleta.size() %>)
                    <span style="font-size: 0.9rem; color: #6c757d; font-weight: normal;">
                        Média: <%= String.format("%.1f", mediaAvaliacoesFeedback) %>/5.0
                    </span>
                </h2>
                
                <% for (Feedback feedback : feedbacksBicicleta) { 
                    // Criar iniciais do avaliador
                    String iniciaisAvaliador = "";
                    if (feedback.getAvaliador_Usuario() != null && feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() != null) {
                        String[] nomes = feedback.getAvaliador_Usuario().getNomeRazaoSocial_user().split(" ");
                        if (nomes.length >= 2) {
                            iniciaisAvaliador = String.valueOf(nomes[0].charAt(0)) + String.valueOf(nomes[1].charAt(0));
                        } else if (nomes.length == 1) {
                            iniciaisAvaliador = String.valueOf(nomes[0].charAt(0)) + String.valueOf(nomes[0].charAt(1));
                        } else {
                            iniciaisAvaliador = "??";
                        }
                    }
                    
                    String avaliacaoClass = feedback.getAvaliacaoBike_feedb() >= 4 ? "positive" : feedback.getAvaliacaoBike_feedb() >= 3 ? "neutral" : "negative";
                %>
                <div class="booking-item" style="border-left: 4px solid <%= feedback.getAvaliacaoBike_feedb() >= 4 ? "#38b2ac" : feedback.getAvaliacaoBike_feedb() >= 3 ? "#ffc107" : "#dc3545" %>;">
                    <div class="booking-avatar" style="background: linear-gradient(135deg, #17a2b8, #6610f2);"><%= iniciaisAvaliador.toUpperCase() %></div>
                    <div class="booking-details" style="flex: 2;">
                        <div class="booking-customer">
                            <%= feedback.getAvaliador_Usuario() != null && feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() != null ? 
                                feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() : "Avaliador anônimo" %>
                        </div>
                        <div class="booking-period">
                            <%= feedback.getData_feedb() != null ? feedback.getData_feedb().format(dateTimeFormatter) : "Data não informada" %>
                        </div>
                        <% if (feedback.getObsBike_feedb() != null && !feedback.getObsBike_feedb().trim().isEmpty()) { %>
                        <div style="margin-top: 0.5rem; font-style: italic; color: #666; font-size: 0.9rem;">
                            "<%= feedback.getObsBike_feedb() %>"
                        </div>
                        <% } %>
                    </div>
                    <div class="booking-status" style="background: <%= feedback.getAvaliacaoBike_feedb() >= 4 ? "#c8f7f2" : feedback.getAvaliacaoBike_feedb() >= 3 ? "#fff3cd" : "#f8d7da" %>; color: <%= feedback.getAvaliacaoBike_feedb() >= 4 ? "#047857" : feedback.getAvaliacaoBike_feedb() >= 3 ? "#856404" : "#721c24" %>;">
                        <%= exibirAvaliacaoCompletaInt(feedback.getAvaliacaoBike_feedb()) %>
                    </div>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="recent-bookings">
                <h2 class="section-title">
                    <i class="fas fa-comments"></i> Avaliações da Bicicleta
                </h2>
                <div style="text-align: center; padding: 2rem; color: #6c757d;">
                    <i class="fas fa-comment-slash" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                    <p>Nenhuma avaliação encontrada para esta bicicleta.</p>
                </div>
            </div>
            <% } %>
            
            <!-- Disponibilidades da Bicicleta -->
            <% if (disponibilidadesBicicleta != null && !disponibilidadesBicicleta.isEmpty()) { %>
            <div class="recent-bookings">
                <h2 class="section-title">
                    <i class="fas fa-calendar-alt"></i> Disponibilidades (<%= disponibilidadesBicicleta.size() %>)
                </h2>
                
                <% for (Disponibilidade disponibilidade : disponibilidadesBicicleta) { 
                    String statusDispClass = disponibilidade.isDisponivel_disp() ? "completed" : "upcoming";
                    String statusDispText = disponibilidade.isDisponivel_disp() ? "Disponível" : "Indisponível";
                %>
                <div class="booking-item">
                    <div class="booking-avatar" style="background: linear-gradient(135deg, #fd7e14, #e83e8c);">
                        <i class="fas fa-calendar" style="font-size: 1.2rem;"></i>
                    </div>
                    <div class="booking-details">
                        <div class="booking-customer">
                            <%= disponibilidade.getDataHoraIn_disp() != null ? disponibilidade.getDataHoraIn_disp().format(dateFormatter) : "Data início não informada" %>
                            até
                            <%= disponibilidade.getDataHoraFim_disp() != null ? disponibilidade.getDataHoraFim_disp().format(dateFormatter) : "Data fim não informada" %>
                        </div>
                        <div class="booking-period">
                            Horário: <%= disponibilidade.getDataHoraIn_disp() != null ? disponibilidade.getDataHoraIn_disp().toLocalTime() : "Não informado" %> - 
                            <%= disponibilidade.getDataHoraFim_disp() != null ? disponibilidade.getDataHoraFim_disp().toLocalTime() : "Não informado" %>
                        </div>
                    </div>
                    <div class="booking-status <%= statusDispClass %>"><%= statusDispText %></div>
                    <% if (disponibilidade.isDisponivel_disp()) { %>
                    <a href="<%=request.getContextPath()%>/DisponibilidadeController?action=form-editar&id=<%= disponibilidade.getId_disp() %>&idBicicleta=<%= bicicleta.getId_bike() %>" 
                       class="edit-icon" title="Editar Disponibilidade" style="margin-left: 1rem;">
                        <i class="fas fa-edit"></i>
                    </a>
                    <% } %>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="recent-bookings">
                <h2 class="section-title">
                    <i class="fas fa-calendar-alt"></i> Disponibilidades
                </h2>
                <div style="text-align: center; padding: 2rem; color: #6c757d;">
                    <i class="fas fa-calendar-times" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                    <p>Nenhuma disponibilidade configurada para esta bicicleta.</p>
                    <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp?id=<%= bicicleta.getId_bike() %>" 
                       style="display: inline-block; margin-top: 1rem; padding: 0.5rem 1rem; background: #007bff; color: white; text-decoration: none; border-radius: 5px;">
                        <i class="fas fa-plus"></i> Configurar Disponibilidade
                    </a>
                </div>
            </div>
            <% } %>
            
            <!-- Botões de Ação Principais -->
            <div class="main-action-buttons">
                <a href="<%=request.getContextPath()%>/BicicletaController?action=form-editar&id=<%= bicicleta.getId_bike() %>" class="btn-primary">
                    <i class="fas fa-edit"></i> Editar Bicicleta
                </a>
                <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp?id=<%= bicicleta.getId_bike() %>" class="btn-success">
                    <i class="fas fa-calendar-alt"></i> Definir Disponibilidade
                </a>
                <a href="<%=request.getContextPath()%>/BicicletaController?action=minhas-bikes&cpfCnpj=<%= usuarioLogado.getCpfCnpj_user() %>" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Voltar às Minhas Bicicletas
                </a>
            </div>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        // Interatividade do calendário
        document.querySelectorAll('.calendar-day.available').forEach(day => {
            day.addEventListener('click', function() {
                if (confirm('Deseja alterar a disponibilidade para este dia?')) {
                    // Redirecionar para página de configuração
                    window.location.href = '<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp';
                }
            });
        });
        
        // Função para atualizar métricas
        function updateMetrics() {
            console.log('Atualizando métricas de performance...');
        }
        
        // Atualizar a cada 60 segundos
        setInterval(updateMetrics, 60000);
        
        // Animações de entrada
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.performance-metrics, .details-section, .availability-calendar, .recent-bookings');
            elements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    element.style.transition = 'all 0.6s ease';
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, index * 150);
            });
        });
        
        // Tooltip para ícones de edição
        document.querySelectorAll('.edit-icon').forEach(icon => {
            icon.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.2)';
            });
            
            icon.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
            });
        });
    </script>
</body>
</html>