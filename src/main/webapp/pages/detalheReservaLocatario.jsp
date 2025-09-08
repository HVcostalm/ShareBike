<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Reserva" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="br.com.sharebike.model.Bicicleta" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%!
// Função para formatação de datas
String formatarData(LocalDateTime data) {
    if (data == null) return "N/A";
    return data.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
}

// Função para formatação de data simples
String formatarDataSimples(LocalDateTime data) {
    if (data == null) return "N/A";
    return data.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
}

// Função para formatação de hora
String formatarHora(LocalDateTime data) {
    if (data == null) return "N/A";
    return data.format(DateTimeFormatter.ofPattern("HH:mm"));
}

// Função para calcular duração em horas
long calcularDuracaoHoras(LocalDateTime inicio, LocalDateTime fim) {
    if (inicio == null || fim == null) return 0;
    return ChronoUnit.HOURS.between(inicio, fim);
}

// Função para traduzir status
String traduzirStatus(String status) {
    if (status == null) return "Indefinido";
    switch (status.toUpperCase()) {
        case "PENDENTE": return "Aguardando Aprovação";
        case "CONFIRMADA": return "Confirmada";
        case "NEGADA": return "Negada";
        case "EM ANDAMENTO": return "Em Andamento";
        case "FINALIZADA": return "Finalizada";
        default: return status;
    }
}

// Função para obter classe CSS do status
String obterClasseStatus(String status) {
    if (status == null) return "status-pendente";
    switch (status.toUpperCase()) {
        case "PENDENTE": return "status-pendente";
        case "CONFIRMADA": return "status-confirmada";
        case "NEGADA": return "status-cancelada";
        case "EM ANDAMENTO": return "status-em-andamento";
        case "FINALIZADA": return "status-finalizada";
        default: return "status-pendente";
    }
}

// Função para obter ícone do status
String obterIconeStatus(String status) {
    if (status == null) return "fas fa-clock";
    switch (status.toUpperCase()) {
        case "PENDENTE": return "fas fa-clock";
        case "CONFIRMADA": return "fas fa-thumbs-up";
        case "NEGADA": return "fas fa-times-circle";
        case "EM ANDAMENTO": return "fas fa-play";
        case "FINALIZADA": return "fas fa-check-circle";
        default: return "fas fa-clock";
    }
}
%>
<%
// Verificar se usuário está logado
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
if (usuarioLogado == null) {
    response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
    return;
}

// Obter ID da reserva dos parâmetros
String idParam = request.getParameter("id");
if (idParam == null) {
    response.sendRedirect(request.getContextPath() + "/ReservaController?action=listar-minhas-reservas");
    return;
}

// Buscar dados da reserva (devem vir do controller)
Reserva reserva = (Reserva) request.getAttribute("reserva");
if (reserva == null) {
    // Se não há dados no request, redirecionar para buscar
    response.sendRedirect(request.getContextPath() + "/ReservaController?action=exibir&id=" + idParam);
    return;
}

// Dados da reserva
Bicicleta bicicleta = reserva.getBicicleta();
Usuario locador = bicicleta.getUsuario();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes da Reserva - ShareBike</title>
    <link rel="stylesheet" href="../assets/css/usuarioDetalhes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .header-title {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-link {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .back-link:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-1px);
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .card-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .status-badge {
            padding: 0.5rem 1.2rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            display: inline-block;
        }

        .status-pendente {
            background: #fff3cd;
            color: #856404;
        }

        .status-confirmada {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-em-andamento {
            background: #d4edda;
            color: #155724;
        }

        .status-finalizada {
            background: #e2e3e5;
            color: #383d41;
        }

        .status-cancelada {
            background: #f8d7da;
            color: #721c24;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .info-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1.1rem;
            color: #333;
            font-weight: 500;
        }

        .bike-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1.5rem;
            display: flex;
            gap: 1.5rem;
            align-items: center;
        }

        .bike-image {
            width: 80px;
            height: 80px;
            background: #ffc107;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
            flex-shrink: 0;
        }

        .bike-info h3 {
            margin-bottom: 0.5rem;
            color: #333;
        }

        .bike-details {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .timeline {
            position: relative;
            padding-left: 2rem;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 0.75rem;
            top: 0;
            height: 100%;
            width: 2px;
            background: #dee2e6;
        }

        .timeline-item {
            position: relative;
            margin-bottom: 2rem;
            padding-left: 2rem;
        }

        .timeline-marker {
            position: absolute;
            left: -2.25rem;
            top: 0.25rem;
            width: 1rem;
            height: 1rem;
            background: #ffc107;
            border-radius: 50%;
            border: 3px solid white;
            box-shadow: 0 0 0 3px #ffc107;
        }

        .timeline-marker.completed {
            background: #28a745;
            box-shadow: 0 0 0 3px #28a745;
        }

        .timeline-marker.pending {
            background: #6c757d;
            box-shadow: 0 0 0 3px #6c757d;
        }

        .timeline-content h4 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .timeline-date {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .price-summary {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            border-left: 4px solid #ffc107;
        }

        .price-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            padding: 0.5rem 0;
        }

        .price-item.total {
            border-top: 2px solid #dee2e6;
            margin-top: 1rem;
            padding-top: 1rem;
            font-weight: bold;
            font-size: 1.2rem;
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .contact-info {
            background: #e3f2fd;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .text-success {
            color: #28a745 !important;
        }
        
        .text-danger {
            color: #dc3545 !important;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .header {
                padding: 1.5rem;
            }
            
            .header-title {
                font-size: 2rem;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .bike-card {
                flex-direction: column;
                text-align: center;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas" class="back-link">
                <i class="fas fa-arrow-left"></i> Voltar às Minhas Reservas
            </a>
            
            <h1 class="header-title">
                <i class="fas fa-calendar-check"></i> 
                Detalhes da Reserva #<%=reserva.getId_reserv()%>
            </h1>
            <p>Visualize todas as informações da sua reserva</p>
        </div>

        <!-- Status da Reserva -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-info-circle"></i>
                Status da Reserva
            </div>
            
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <span class="status-badge <%=obterClasseStatus(reserva.getStatus_reserv())%>">
                    <i class="<%=obterIconeStatus(reserva.getStatus_reserv())%>"></i> <%=traduzirStatus(reserva.getStatus_reserv())%>
                </span>
                
                <div style="text-align: right;">
                    <div class="info-label">Reserva criada em</div>
                    <div class="info-value"><%=formatarDataSimples(reserva.getDataCheckIn_reserv())%></div>
                </div>
            </div>

            <%
            String statusReserva = reserva.getStatus_reserv().toUpperCase();
            String alertClass = "";
            String alertIcon = "";
            String alertMessage = "";
            
            // Verificar se o usuário logado é o locatário
            boolean isLocatario = usuarioLogado.getCpfCnpj_user().equals(reserva.getUsuario().getCpfCnpj_user());
            
            switch (statusReserva) {
                case "PENDENTE":
                    alertClass = "alert-info";
                    alertIcon = "fas fa-clock";
                    alertMessage = "Aguardando confirmação do locador.";
                    break;
                case "CONFIRMADA":
                    alertClass = "alert-success";
                    alertIcon = "fas fa-check";
                    alertMessage = "Reserva confirmada! Aguarde o dia da retirada.";
                    break;
                case "NEGADA":
                    alertClass = "alert-danger";
                    alertIcon = "fas fa-times-circle";
                    alertMessage = "Reserva foi cancelada.";
                    break;
                case "EM ANDAMENTO":
                    alertClass = "alert-info";
                    alertIcon = "fas fa-bicycle";
                    alertMessage = "Você está com a bicicleta. Aproveite seu passeio!";
                    break;
                case "FINALIZADA":
                    alertClass = "alert-success";
                    alertIcon = "fas fa-check-circle";
                    alertMessage = "Reserva finalizada com sucesso! Você pode avaliar sua experiência.";
                    break;
                default:
                    alertClass = "alert-info";
                    alertIcon = "fas fa-info-circle";
                    alertMessage = "Status da reserva atualizado.";
            }
            %>
            
            <div class="alert <%=alertClass%>" style="margin-top: 1rem;">
                <i class="<%=alertIcon%>"></i>
                <span><%=alertMessage%></span>
            </div>
        </div>

        <!-- Informações da Reserva -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-calendar-alt"></i>
                Informações da Reserva
            </div>
            
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">ID da Reserva</span>
                    <span class="info-value">#<%=reserva.getId_reserv()%></span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Data de Início</span>
                    <span class="info-value"><%=formatarDataSimples(reserva.getDataCheckIn_reserv())%></span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Horário de Início</span>
                    <span class="info-value"><%=formatarHora(reserva.getDataCheckIn_reserv())%></span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Data de Fim</span>
                    <span class="info-value"><%=formatarDataSimples(reserva.getDataCheckOut_reserv())%></span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Horário de Fim</span>
                    <span class="info-value"><%=formatarHora(reserva.getDataCheckOut_reserv())%></span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Duração Total</span>
                    <span class="info-value"><%=calcularDuracaoHoras(reserva.getDataCheckIn_reserv(), reserva.getDataCheckOut_reserv())%> horas</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Local de Retirada</span>
                    <span class="info-value">
                        <%if(bicicleta.getLocalEntr_bike() != null && !bicicleta.getLocalEntr_bike().trim().isEmpty()){%>
                            <%=bicicleta.getLocalEntr_bike()%>
                        <%}else{%>
                            Entre em contato com o locador
                        <%}%>
                    </span>
                </div>
            </div>
        </div>

        <!-- Bicicleta Reservada -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-bicycle"></i>
                Bicicleta Reservada
            </div>
            
            <div class="bike-card">
                <div class="bike-image" style="background-color: #ffc107;">
                    <i class="fas fa-bicycle"></i>
                </div>
                <div class="bike-info">
                    <h3><%=bicicleta.getNome_bike()%></h3>
                    <div class="bike-details">
                        <i class="fas fa-info-circle"></i> Estado: <%=bicicleta.getEstadoConserv_bike() != null ? bicicleta.getEstadoConserv_bike() : "Não informado"%><br>
                        <%if(bicicleta.getTipo_bike() != null){%>
                            <i class="fas fa-tag"></i> <%=bicicleta.getTipo_bike()%><br>
                        <%}%>
                        <%if(bicicleta.getLocalEntr_bike() != null){%>
                            <i class="fas fa-map-marker-alt"></i> <%=bicicleta.getLocalEntr_bike()%><br>
                        <%}%>
                        <%if(bicicleta.getAvaliacao_bike() != null && bicicleta.getAvaliacao_bike() > 0){%>
                            <i class="fas fa-star"></i> <%=String.format("%.1f", bicicleta.getAvaliacao_bike())%>/5.0<br>
                        <%}else{%>
                            <i class="fas fa-star"></i> Sem Avaliação<br>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>

        <!-- Informações do Locador -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-user"></i>
                Informações do Locador
            </div>
            
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Nome</span>
                    <span class="info-value"><%=locador.getNomeRazaoSocial_user()%></span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Avaliação</span>
                    <span class="info-value">
                        <%if(locador.getAvaliacao_user() != null && locador.getAvaliacao_user() > 0){%>
                            <%
                            double avaliacao = locador.getAvaliacao_user();
                            int estrelas = (int) Math.round(avaliacao);
                            for(int i = 1; i <= 5; i++){
                                if(i <= estrelas){
                            %>
                                    <i class="fas fa-star" style="color: #ffc107;"></i>
                            <%  } else { %>
                                    <i class="far fa-star" style="color: #ffc107;"></i>
                            <%  } 
                            } %>
                            <%=String.format("%.1f", avaliacao)%>/5.0
                        <%}else{%>
                            <i class="fas fa-star" style="color: #ddd;"></i>
                            <i class="fas fa-star" style="color: #ddd;"></i>
                            <i class="fas fa-star" style="color: #ddd;"></i>
                            <i class="fas fa-star" style="color: #ddd;"></i>
                            <i class="fas fa-star" style="color: #ddd;"></i>
                            Sem Avaliação
                        <%}%>
                    </span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Telefone</span>
                    <span class="info-value">
                        <%if(locador.getTelefone_user() != null && !locador.getTelefone_user().trim().isEmpty()){%>
                            <%=locador.getTelefone_user()%>
                        <%}else{%>
                            Não informado
                        <%}%>
                    </span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Localização</span>
                    <span class="info-value">
                        <%
                        String localizacao = "";
                        if(locador.getCidade_user() != null && !locador.getCidade_user().trim().isEmpty()) {
                            localizacao += locador.getCidade_user();
                            if(locador.getEstado_user() != null && !locador.getEstado_user().trim().isEmpty()) {
                                localizacao += ", " + locador.getEstado_user();
                            }
                        }
                        if(localizacao.isEmpty()) {
                            localizacao = "Não informado";
                        }
                        %>
                        <%=localizacao%>
                    </span>
                </div>
            </div>
        </div>

        <!-- Timeline da Reserva -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-history"></i>
                Histórico da Reserva
            </div>
            
            <div class="timeline">
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Reserva Criada</h4>
                        <div class="timeline-date"><%=formatarData(reserva.getDataCheckIn_reserv())%></div>
                    </div>
                </div>
                
                <%if("CONFIRMADA".equals(reserva.getStatus_reserv()) || "EM ANDAMENTO".equals(reserva.getStatus_reserv()) || "FINALIZADA".equals(reserva.getStatus_reserv())){%>
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Reserva Confirmada pelo Locador</h4>
                        <div class="timeline-date">Confirmada</div>
                    </div>
                </div>
                <%}else if("NEGADA".equals(reserva.getStatus_reserv())){%>
                <div class="timeline-item">
                    <div class="timeline-marker" style="background: #dc3545; box-shadow: 0 0 0 3px #dc3545;"></div>
                    <div class="timeline-content">
                        <h4>Reserva Cancelada</h4>
                        <div class="timeline-date">Cancelada</div>
                    </div>
                </div>
                <%}else{%>
                <div class="timeline-item">
                    <div class="timeline-marker pending"></div>
                    <div class="timeline-content">
                        <h4>Aguardando Confirmação</h4>
                        <div class="timeline-date">Pendente</div>
                    </div>
                </div>
                <%}%>
                
                <%if("EM ANDAMENTO".equals(reserva.getStatus_reserv()) || "FINALIZADA".equals(reserva.getStatus_reserv())){%>
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Bicicleta Entregue</h4>
                        <div class="timeline-date"><%=formatarData(reserva.getDataCheckIn_reserv())%></div>
                    </div>
                </div>
                <%}%>
                
                <%if("FINALIZADA".equals(reserva.getStatus_reserv())){%>
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Bicicleta Devolvida</h4>
                        <div class="timeline-date"><%=formatarData(reserva.getDataCheckOut_reserv())%></div>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Reserva Finalizada</h4>
                        <div class="timeline-date">Finalizada</div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>

        <!-- Botões de Ação -->
        <div class="action-buttons">
            <%if("PENDENTE".equals(reserva.getStatus_reserv())){%>
            <form action="<%=request.getContextPath()%>/ReservaController" method="post" style="display: inline;">
                <input type="hidden" name="action" value="editar">
                <input type="hidden" name="id_reserv" value="<%=reserva.getId_reserv()%>">
                <input type="hidden" name="status_reserv" value="NEGADA">
                <button type="button" class="btn btn-danger" onclick="confirmarCancelamento('negar')">
                    <i class="fas fa-times"></i>
                    Cancelar Solicitação
                </button>
            </form>
            <%}%>
            
            <%if("CONFIRMADA".equals(reserva.getStatus_reserv())){%>
            <form action="<%=request.getContextPath()%>/ReservaController" method="post" style="display: inline;">
                <input type="hidden" name="action" value="editar">
                <input type="hidden" name="id_reserv" value="<%=reserva.getId_reserv()%>">
                <input type="hidden" name="status_reserv" value="NEGADA">
                <button type="button" class="btn btn-danger" onclick="confirmarCancelamento('cancelar')">
                    <i class="fas fa-times"></i>
                    Cancelar Reserva
                </button>
            </form>
            <%}%>
            
            <%if("FINALIZADA".equals(reserva.getStatus_reserv())){%>
            <a href="<%=request.getContextPath()%>/FeedbackController?action=pagina-locatario&reservaId=<%=reserva.getId_reserv()%>" class="btn btn-success">
                <i class="fas fa-star"></i>
                Avaliar Experiência
            </a>
            <%}%>
            
            <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas" class="btn btn-secondary">
                <i class="fas fa-list"></i>
                Ver Todas as Reservas
            </a>
        </div>
    </div>

    <script>
        console.log('Página de detalhes da reserva (locatário) carregada - Dados dinâmicos');
        console.log('Reserva ID: <%=reserva.getId_reserv()%>');
        console.log('Status: <%=reserva.getStatus_reserv()%>');
        
        function confirmarCancelamento(tipo) {
            let mensagem = '';
            if (tipo === 'negar') {
                mensagem = 'Tem certeza que deseja cancelar esta solicitação de reserva?\n\nO locador será avisado sobre o cancelamento.';
            } else {
                mensagem = 'Tem certeza que deseja cancelar esta reserva confirmada?\n\nO locador será avisado sobre o cancelamento.';
            }
            
            if (confirm(mensagem)) {
                // Submete o formulário
                event.target.closest('form').submit();
            }
        }
    </script>
</body>
</html>
