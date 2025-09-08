<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Reserva" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="br.com.sharebike.model.Bicicleta" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%!
// Função para formatação de datas
String formatarData(LocalDateTime data) {
    if (data == null) return "N/A";
    return data.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
}

// Função para calcular tempo restante
String calcularTempoRestante(LocalDateTime dataFim) {
    if (dataFim == null) return "N/A";
    LocalDateTime agora = LocalDateTime.now();
    if (agora.isAfter(dataFim)) return "Expirado";
    
    long totalMinutos = ChronoUnit.MINUTES.between(agora, dataFim);
    long dias = totalMinutos / (24 * 60);
    long horas = (totalMinutos % (24 * 60)) / 60;
    long minutos = totalMinutos % 60;
    
    if (dias > 0) {
        return dias + " dia" + (dias > 1 ? "s" : "") + 
               (horas > 0 ? " " + horas + "h" : "") + 
               (minutos > 0 ? " " + minutos + "min" : "");
    } else if (horas > 0) {
        return horas + "h" + (minutos > 0 ? " " + minutos + "min" : "");
    } else {
        return minutos + "min";
    }
}

// Função para calcular duração
String calcularDuracao(LocalDateTime inicio, LocalDateTime fim) {
    if (inicio == null || fim == null) return "N/A";
    
    long horas = ChronoUnit.HOURS.between(inicio, fim);
    long dias = horas / 24;
    horas = horas % 24;
    
    if (dias > 0) {
        return dias + " dia" + (dias > 1 ? "s" : "") + (horas > 0 ? " " + horas + "h" : "");
    }
    return horas + "h";
}

// Função para obter classe CSS do status
String obterClasseStatus(String status) {
    if (status == null) return "status-indefinido";
    switch (status.toUpperCase()) {
        case "PENDENTE": return "status-pendente";
        case "CONFIRMADA": return "status-confirmada";
        case "NEGADA": return "status-negada";
        case "EM ANDAMENTO": return "status-em-andamento";
        case "FINALIZADA": return "status-finalizada";
        default: return "status-indefinido";
    }
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
%>
<%
// Verificar se usuário está logado
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
if (usuarioLogado == null) {
    response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
    return;
}

// Obter listas de reservas por status (vindas do controller)
List<Reserva> todasReservas = (List<Reserva>) request.getAttribute("todasReservas");
List<Reserva> reservasPendentes = (List<Reserva>) request.getAttribute("reservasPendentes");
List<Reserva> reservasConfirmadas = (List<Reserva>) request.getAttribute("reservasConfirmadas");
List<Reserva> reservasNegadas = (List<Reserva>) request.getAttribute("reservasNegadas");
List<Reserva> reservasEmAndamento = (List<Reserva>) request.getAttribute("reservasEmAndamento");
List<Reserva> reservasFinalizadas = (List<Reserva>) request.getAttribute("reservasFinalizadas");

// *** NOVO: Obter mapa de feedback ***
Map<Integer, Boolean> mapaFeedbackLocador = (Map<Integer, Boolean>) request.getAttribute("mapaFeedbackLocador");

// Contadores para estatísticas
int totalReservas = todasReservas != null ? todasReservas.size() : 0;
int totalPendentes = reservasPendentes != null ? reservasPendentes.size() : 0;
int totalConfirmadas = reservasConfirmadas != null ? reservasConfirmadas.size() : 0;
int totalNegadas = reservasNegadas != null ? reservasNegadas.size() : 0;
int totalEmAndamento = reservasEmAndamento != null ? reservasEmAndamento.size() : 0;
int totalFinalizadas = reservasFinalizadas != null ? reservasFinalizadas.size() : 0;

// Se não há dados, usar a lista vinda do controller
if (todasReservas == null) {
    todasReservas = (List<Reserva>) request.getAttribute("listaReservas");
    totalReservas = todasReservas != null ? todasReservas.size() : 0;
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reservas Recebidas - Locador</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/reservas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .no-reservations {
            text-align: center;
            padding: 60px 20px;
            background: #f8f9fa;
            border-radius: 12px;
            margin: 20px 0;
        }
        
        .no-reservations-icon {
            font-size: 4rem;
            color: #6c757d;
            margin-bottom: 20px;
        }
        
        .no-reservations h3 {
            color: #495057;
            margin-bottom: 10px;
            font-size: 1.5rem;
        }
        
        .no-reservations p {
            color: #6c757d;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }
        
        .status-pendente { 
            background: linear-gradient(135deg, #ffc107, #ffb300); 
            color: white; 
        }
        .status-confirmada { 
            background: linear-gradient(135deg, #28a745, #20c997); 
            color: white; 
        }
        .status-negada { 
            background: linear-gradient(135deg, #dc3545, #c82333); 
            color: white; 
        }
        .status-em-andamento { 
            background: linear-gradient(135deg, #007bff, #0056b3); 
            color: white; 
        }
        .status-finalizada { 
            background: linear-gradient(135deg, #6c757d, #5a6268); 
            color: white; 
        }
        .status-indefinido { 
            background: linear-gradient(135deg, #6f42c1, #5a32a3); 
            color: white; 
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-calendar-check"></i> Reservas das Minhas Bicicletas</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/UsuarioController?action=perfil" ><i class="fas fa-user"></i> Meu Perfil</a>
            <a href="<%=request.getContextPath()%>/BicicletaController?action=minhas-bikes&cpfCnpj=<%=usuarioLogado.getCpfCnpj_user()%>"><i class="fas fa-bicycle"></i> Minhas Bicicletas</a>
            <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas-locador"><i class="fas fa-calendar-check"></i> Reservas Recebidas</a>
            <a href="<%=request.getContextPath()%>/FeedbackController?action=pagina-locador"><i class="fas fa-comment-dots"></i> Feedbacks</a>
        </nav>
        
        <!-- Estatísticas do Locador - Dados Dinâmicos -->
        <div class="stats-summary">
            <h3><i class="fas fa-chart-pie"></i> Meu Histórico</h3>
            <div class="stats-row">
                <div class="stat-item">
                    <div class="stat-number"><%=totalReservas%></div>
                    <div class="stat-label">Total de Reservas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=totalPendentes%></div>
                    <div class="stat-label">Pendentes</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=totalConfirmadas + totalEmAndamento%></div>
                    <div class="stat-label">Em Andamento</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=totalFinalizadas%></div>
                    <div class="stat-label">Finalizadas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=totalNegadas%></div>
                    <div class="stat-label">Negadas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=usuarioLogado.getAvaliacao_user() != null ? String.format("%.1f", usuarioLogado.getAvaliacao_user()) : "N/A"%></div>
                    <div class="stat-label">Minha Avaliação</div>
                </div>
            </div>
        </div>
        
        <!-- Filtros por Status -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterReservations('todas')">
                <i class="fas fa-list"></i> Todas (<%= totalReservas %>)
            </button>
            <button class="filter-tab" onclick="filterReservations('pendentes')">
                <i class="fas fa-clock"></i> Pendentes (<%= totalPendentes %>)
            </button>
            <button class="filter-tab" onclick="filterReservations('confirmadas')">
                <i class="fas fa-check"></i> Confirmadas (<%= totalConfirmadas %>)
            </button>
            <button class="filter-tab" onclick="filterReservations('negadas')">
                <i class="fas fa-times-circle"></i> Negadas (<%= totalNegadas %>)
            </button>
            <button class="filter-tab" onclick="filterReservations('ativas')">
                <i class="fas fa-play-circle"></i> Em Andamento (<%= totalEmAndamento %>)
            </button>
            <button class="filter-tab" onclick="filterReservations('finalizadas')">
                <i class="fas fa-flag-checkered"></i> Finalizadas (<%= totalFinalizadas %>)
            </button>
        </div>
        
        <!-- Lista de Reservas -->
        <div class="reservations-list">
            <%
            // Verificar se há reservas para exibir
            if (todasReservas != null && !todasReservas.isEmpty()) {
                for (Reserva reserva : todasReservas) {
                    Usuario locatario = reserva.getUsuario();
                    Bicicleta bicicleta = reserva.getBicicleta();
                    String statusAtual = reserva.getStatus_reserv() != null ? reserva.getStatus_reserv() : "INDEFINIDO";
                    
                    // Definir classe de filtro baseado no status
                    String filterClass = "";
                    switch (statusAtual.toUpperCase()) {
                        case "PENDENTE":
                            filterClass = "pendentes";
                            break;
                        case "CONFIRMADA":
                            filterClass = "confirmadas";
                            break;
                        case "NEGADA":
                            filterClass = "negadas";
                            break;
                        case "EM ANDAMENTO":
                            filterClass = "ativas";
                            break;
                        case "FINALIZADA":
                            filterClass = "finalizadas";
                            break;
                        default:
                            filterClass = "todas";
                    }
            %>
            <!-- Reserva ID: <%= reserva.getId_reserv() %> - Status: <%= statusAtual %> -->
            <div class="reservation-card" data-status="<%= filterClass %>">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-<%= String.format("%03d", reserva.getId_reserv()) %></div>
                    <div class="reservation-status <%= obterClasseStatus(statusAtual) %>"><%= traduzirStatus(statusAtual) %></div>
                </div>
                <div class="reservation-content">
                    <img src="<%= bicicleta.getFoto_bike()%>" 
                         alt="<%= bicicleta != null ? bicicleta.getNome_bike() : "Bicicleta" %>" 
                         class="bike-image">
                    <div class="reservation-details">
                        <div class="bike-name">
                            <%= bicicleta != null ? bicicleta.getNome_bike() : "Modelo não informado" %>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Solicitante: <%= locatario != null ? locatario.getNomeRazaoSocial_user() : "N/A" %> 
                                  (<%= locatario != null ? locatario.getEmail_user() : "email@exemplo.com" %>)</span>
                        </div>
                        <% if (locatario != null && locatario.getTelefone_user() != null && !locatario.getTelefone_user().isEmpty()) { %>
                        <div class="detail-row">
                            <i class="fas fa-phone"></i>
                            <span>Contato: <%= locatario.getTelefone_user() %></span>
                        </div>
                        <% } %>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: <%= bicicleta != null ? bicicleta.getLocalEntr_bike() : "Local não informado" %></span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: <%= formatarData(reserva.getDataCheckIn_reserv()) %> até <%= formatarData(reserva.getDataCheckOut_reserv()) %></span>
                        </div>
                        
                        <!-- Datas importantes -->
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Check-in Solicitado</div>
                                    <div class="date-value"><%= formatarData(reserva.getDataCheckIn_reserv()) %></div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Check-out Solicitado</div>
                                    <div class="date-value"><%= formatarData(reserva.getDataCheckOut_reserv()) %></div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">
                                        <%=reserva.getStatus_reserv().equals("PENDENTE") ? "Status" : 
                                           reserva.getStatus_reserv().equals("EM ANDAMENTO") ? "Tempo Restante" : 
                                           reserva.getStatus_reserv().equals("FINALIZADA") ? "Duração" : "Status"%>
                                    </div>
                                    <div class="date-value">
                                        <%=reserva.getStatus_reserv().equals("PENDENTE") ? "Aguardando resposta" : 
                                           reserva.getStatus_reserv().equals("EM ANDAMENTO") ? calcularTempoRestante(reserva.getDataCheckOut_reserv()) : 
                                           reserva.getStatus_reserv().equals("FINALIZADA") ? calcularDuracao(reserva.getDataCheckIn_reserv(), reserva.getDataCheckOut_reserv()) :
                                           traduzirStatus(statusAtual)%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Ações baseadas no status -->
                        <div class="reservation-actions">
                            <!-- Ação comum para todos os status -->
                            <a href="<%=request.getContextPath()%>/ReservaController?action=exibir&id=<%= reserva.getId_reserv() %>&origem=locador" class="btn btn-primary">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            
                            <% 
                            // Verificar se é finalizada E se ainda não fez feedback
                            if ("FINALIZADA".equals(statusAtual.toUpperCase())) {
                                Boolean jaFezFeedback = (mapaFeedbackLocador != null) ? mapaFeedbackLocador.get(reserva.getId_reserv()) : false;
                                if (jaFezFeedback == null) jaFezFeedback = false;
                                
                                if (!jaFezFeedback) {
                            %>
                                <!-- Botão só aparece se ainda não fez feedback -->
                                <a href="#" class="btn btn-success" onclick="giveFeedback('<%= reserva.getId_reserv() %>')">
                                    <i class="fas fa-star"></i> Avaliar Locatário
                                </a>
                            <% 
                                } else {
                            %>
                                <!-- Feedback já realizado -->
                                <span class="btn btn-secondary" style="cursor: default;">
                                    <i class="fas fa-check"></i> Avaliação Realizada
                                </span>
                            <% 
                                }
                            } 
                            %>
                        </div>
                    </div>
                </div>
            </div>
            <%
                } // fim do for
            } else {
            %>
            <!-- Mensagem quando não há reservas -->
            <div class="no-reservations">
                <div class="no-reservations-icon">
                    <i class="fas fa-calendar-times"></i>
                </div>
                <h3>Nenhuma reserva encontrada</h3>
                <p>Você ainda não recebeu solicitações de reserva para suas bicicletas.</p>
                <a href="<%=request.getContextPath()%>/BicicletaController?action=minhas-bikes&cpfCnpj=<%=usuarioLogado.getCpfCnpj_user()%>" class="btn btn-primary">
                    <i class="fas fa-bicycle"></i> Ver Minhas Bicicletas
                </a>
            </div>
            <%
            }
            %>


        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        function filterReservations(status) {
            // Remove active class from all tabs
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Add active class to clicked tab
            event.target.classList.add('active');
            
            // Show/hide reservation cards
            document.querySelectorAll('.reservation-card').forEach(card => {
                if (status === 'todas' || card.dataset.status === status) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        function giveFeedback(reservationId) {
            // Redirecionar para página de feedback do locador com ID da reserva
            window.location.href = '<%=request.getContextPath()%>/FeedbackController?action=fazer-avaliacao-locador&reservaId=' + reservationId;
        }
    </script>
</body>
</html>