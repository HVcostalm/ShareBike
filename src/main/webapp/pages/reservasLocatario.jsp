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
Map<Integer, Boolean> mapaFeedbackLocatario = (Map<Integer, Boolean>) request.getAttribute("mapaFeedbackLocatario");

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
    <title>Minhas Reservas - Locatário</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/reservas.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/reservasLocatario.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            color: #666;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 1rem;
        }
        
        .empty-state h3 {
            margin-bottom: 1rem;
            color: #333;
        }
        
        .empty-state p {
            margin-bottom: 2rem;
            font-size: 1.1rem;
        }
        
        .empty-state .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(56, 178, 172, 0.3);
        }
        
        .empty-state .btn:hover {
            background: linear-gradient(135deg, #319795, #0d9488);
            transform: translateY(-2px);
            text-decoration: none;
            color: white;
            box-shadow: 0 8px 25px rgba(56, 178, 172, 0.4);
        }
        
        /* Ajustes para status */
        .status-pendente { background: #fff3cd; color: #856404; }
        .status-confirmada { background: #d4edda; color: #155724; }
        .status-negada { background: #f8d7da; color: #721c24; }
        .status-em-andamento { background: #cce7ff; color: #004085; }
        .status-finalizada { background: #f8f9fa; color: #6c757d; }
        .status-indefinido { background: #e2e3e5; color: #495057; }
        
        /* Correção para botão Meu Perfil */
        .nav .nav-profile {
            background: #38b2ac !important;
            background-image: none !important;
        }
        
        .nav .nav-profile:hover {
            background: #0d9488 !important;
            background-image: none !important;
        }
        
        /* Centralização forçada da navegação */
        .nav {
            background: white;
            padding: 10px 0px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .nav a {
            text-decoration: none;
            color: white;
            background-color: #38b2ac;
            padding: 1rem 2rem;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin: 0;
        }
        
        .nav a:hover, .nav a.active {
            background: #0d9488;
            color: white;
        }
        
        /* Garantir que o container não interfira na centralização */
        .container {
            max-width: 1200px;
            margin: 30px auto 0 auto;
            padding: 20px;
            text-align: left;
            overflow: visible !important;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        /* Estilos para header igual ao bicicletasLocatario */
        header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            color: white;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        header h1 {
            margin: 0;
            font-size: 2.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }
        
        body {
            margin: 0;
            padding: 0;
            background: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-calendar-check"></i> Minhas Reservas</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/UsuarioController?action=perfil"><i class="fas fa-user"></i> Meu Perfil</a>
            <a href="<%=request.getContextPath()%>/BicicletaController?action=lista-locatario"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="<%=request.getContextPath()%>/FeedbackController?action=pagina-locatario"><i class="fas fa-comment-dots"></i> Dar Feedback</a>
            <a href="<%=request.getContextPath()%>/pages/rankingLocatario.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <!-- Estatísticas do Locatário - Dados Dinâmicos -->
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
        
        <!-- Filtros por Status - Dados Dinâmicos -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterReservations('todas')">
                <i class="fas fa-list"></i> Todas (<%=totalReservas%>)
            </button>
            <button class="filter-tab" onclick="filterReservations('pendentes')">
                <i class="fas fa-clock"></i> Pendentes (<%=totalPendentes%>)
            </button>
            <button class="filter-tab" onclick="filterReservations('confirmadas')">
                <i class="fas fa-check"></i> Confirmadas (<%=totalConfirmadas%>)
            </button>
            <button class="filter-tab" onclick="filterReservations('em-andamento')">
                <i class="fas fa-play-circle"></i> Em Andamento (<%=totalEmAndamento%>)
            </button>
            <button class="filter-tab" onclick="filterReservations('finalizadas')">
                <i class="fas fa-flag-checkered"></i> Finalizadas (<%=totalFinalizadas%>)
            </button>
            <button class="filter-tab" onclick="filterReservations('negadas')">
                <i class="fas fa-times-circle"></i> Negadas (<%=totalNegadas%>)
            </button>
        </div>
        
        <!-- Lista de Reservas - Dados Dinâmicos -->
        <div class="reservations-list">
            <% 
            if (todasReservas != null && !todasReservas.isEmpty()) {
                for (Reserva reserva : todasReservas) {
                    String statusLower = reserva.getStatus_reserv().toLowerCase();
                    String dataStatus = "";
                    
                    // Determinar filtro apropriado
                    String filtroStatus = "";
                    switch (reserva.getStatus_reserv().toUpperCase()) {
                        case "PENDENTE": filtroStatus = "pendentes"; break;
                        case "CONFIRMADA": filtroStatus = "confirmadas"; break;
                        case "NEGADA": filtroStatus = "negadas"; break;
                        case "EM ANDAMENTO": filtroStatus = "em-andamento"; break;
                        case "FINALIZADA": filtroStatus = "finalizadas"; break;
                        default: filtroStatus = "todas"; break;
                    }
            %>
            <div class="reservation-card" data-status="<%=filtroStatus%>">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-<%=String.format("%03d", reserva.getId_reserv())%></div>
                    <div class="reservation-status <%=obterClasseStatus(reserva.getStatus_reserv())%>">
                        <%=traduzirStatus(reserva.getStatus_reserv())%>
                    </div>
                </div>
                <div class="reservation-content">
                    <%
                    // Definir URL de placeholder baseada no status
                    String placeholderUrl = "https://via.placeholder.com/200x150/";
                    switch (reserva.getStatus_reserv().toUpperCase()) {
                        case "PENDENTE":
                            placeholderUrl += "ffc107/000000?text=Pendente";
                            break;
                        case "CONFIRMADA":
                            placeholderUrl += "28a745/ffffff?text=Confirmada";
                            break;
                        case "NEGADA":
                            placeholderUrl += "dc3545/ffffff?text=Negada";
                            break;
                        case "EM ANDAMENTO":
                            placeholderUrl += "007bff/ffffff?text=Em+Andamento";
                            break;
                        case "FINALIZADA":
                            placeholderUrl += "6c757d/ffffff?text=Finalizada";
                            break;
                        default:
                            placeholderUrl += "6c757d/ffffff?text=" + reserva.getStatus_reserv().replace(" ", "+");
                            break;
                    }
                    %>
                    <img src="<%=reserva.getBicicleta().getFoto_bike()%>" 
                         alt="<%=reserva.getBicicleta().getNome_bike()%>" 
                         class="bike-image">
                    <div class="reservation-details">
                        <div class="bike-name"><%=reserva.getBicicleta().getNome_bike()%></div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: <%=reserva.getBicicleta().getUsuario().getNomeRazaoSocial_user()%></span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-bicycle"></i>
                            <span>Tipo: <%=reserva.getBicicleta().getTipo_bike()%></span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: <%=reserva.getBicicleta().getLocalEntr_bike()%></span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-tools"></i>
                            <span>Estado: <%=reserva.getBicicleta().getEstadoConserv_bike()%></span>
                        </div>
                        <% if (reserva.getBicicleta().getUsuario().getTelefone_user() != null) { %>
                        <div class="detail-row">
                            <i class="fas fa-phone"></i>
                            <span>Contato: <%=reserva.getBicicleta().getUsuario().getTelefone_user()%></span>
                        </div>
                        <% } %>
                        
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">
                                        <%=reserva.getStatus_reserv().equals("PENDENTE") ? "Check-in Desejado" : 
                                           reserva.getStatus_reserv().equals("EM ANDAMENTO") ? "Retirada" : "Retirada"%>
                                    </div>
                                    <div class="date-value"><%=formatarData(reserva.getDataCheckIn_reserv())%></div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">
                                        <%=reserva.getStatus_reserv().equals("PENDENTE") ? "Check-out Desejado" : 
                                           reserva.getStatus_reserv().equals("EM ANDAMENTO") ? "Devolução Prevista" : "Devolução"%>
                                    </div>
                                    <div class="date-value"><%=formatarData(reserva.getDataCheckOut_reserv())%></div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">
                                        <%=reserva.getStatus_reserv().equals("PENDENTE") ? "Status" : 
                                           reserva.getStatus_reserv().equals("EM ANDAMENTO") ? "Tempo Restante" : 
                                           reserva.getStatus_reserv().equals("FINALIZADA") ? "Duração" : "Duração"%>
                                    </div>
                                    <div class="date-value">
                                        <%=reserva.getStatus_reserv().equals("PENDENTE") ? "Aguardando resposta" : 
                                           reserva.getStatus_reserv().equals("EM ANDAMENTO") ? calcularTempoRestante(reserva.getDataCheckOut_reserv()) : 
                                           calcularDuracao(reserva.getDataCheckIn_reserv(), reserva.getDataCheckOut_reserv())%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="reservation-actions">
                            <a href="<%=request.getContextPath()%>/ReservaController?action=exibir&id=<%=reserva.getId_reserv()%>&origem=locatario" class="btn btn-info">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            
                            <% 
                            // Verificar se é finalizada E se ainda não fez feedback
                            if (reserva.getStatus_reserv().equals("FINALIZADA")) {
                                Boolean jaFezFeedback = (mapaFeedbackLocatario != null) ? mapaFeedbackLocatario.get(reserva.getId_reserv()) : false;
                                if (jaFezFeedback == null) jaFezFeedback = false;
                                
                                if (!jaFezFeedback) {
                            %>
                                <!-- Botão só aparece se ainda não fez feedback -->
                                <a href="#" class="btn btn-info" onclick="viewFeedback('<%=reserva.getId_reserv()%>')">
                                    <i class="fas fa-comments"></i> Realizar Feedback
                                </a>
                            <% 
                                } else {
                            %>
                                <!-- Feedback já realizado -->
                                <span class="btn btn-secondary" style="cursor: default;">
                                    <i class="fas fa-check"></i> Feedback Realizado
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
                }
            } else { 
            %>
            <div class="empty-state">
                <i class="fas fa-calendar-times"></i>
                <h3>Nenhuma reserva encontrada</h3>
                <p>Você ainda não fez nenhuma reserva. Que tal começar agora?</p>
                <a href="<%=request.getContextPath()%>/BicicletaController?action=lista-locatario" class="btn btn-primary">
                    <i class="fas fa-search"></i> Buscar Bicicletas
                </a>
            </div>
            <% } %>
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
        
        function contactOwner(reservationId) {
            alert('Contatar proprietário da reserva: ' + reservationId);
            // Implementar sistema de mensagens
        }
        
        function modifyRequest(reservationId) {
            alert('Modificar solicitação: ' + reservationId);
            // Implementar modificação da reserva
        }
        
        function cancelRequest(reservationId) {
            if (confirm('Tem certeza que deseja cancelar esta solicitação?')) {
                alert('Solicitação cancelada: ' + reservationId);
                // Implementar cancelamento
                location.reload();
            }
        }
        
        function confirmPickup(reservationId) {
            if (confirm('Confirmar que você retirou a bicicleta?')) {
                alert('Retirada confirmada para reserva: ' + reservationId);
                // Implementar confirmação de retirada
                location.reload();
            }
        }
        
        function getDirections(reservationId) {
            alert('Abrindo direções para o local de retirada da reserva: ' + reservationId);
            // Implementar integração com mapas
        }
        
        function reportIssue(reservationId) {
            const issue = prompt('Descreva o problema encontrado:');
            if (issue) {
                alert('Problema reportado para reserva ' + reservationId + ': ' + issue);
                // Implementar sistema de reportes
            }
        }
        
        function extendReservation(reservationId) {
            const hours = prompt('Quantas horas a mais você precisa?');
            if (hours && !isNaN(hours)) {
                alert('Solicitação de extensão enviada: ' + hours + ' horas para reserva ' + reservationId);
                // Implementar extensão de reserva
            }
        }
        
        function getReturnDirections(reservationId) {
            alert('Abrindo direções para o local de devolução da reserva: ' + reservationId);
            // Implementar integração com mapas
        }
        
        function confirmReturn(reservationId) {
            if (confirm('Confirmar que você devolveu a bicicleta?')) {
                alert('Devolução confirmada para reserva: ' + reservationId);
                // Implementar confirmação de devolução
                location.reload();
            }
        }
        
        function viewFeedback(reservationId) {
            // Redirecionar para página de feedback do locatário com ID da reserva
            window.location.href = '<%=request.getContextPath()%>/FeedbackController?action=fazer-avaliacao&reservaId=' + reservationId;
        }
        
        function bookAgain(reservationId) {
            if (confirm('Deseja fazer uma nova reserva para esta bicicleta?')) {
                alert('Redirecionando para nova reserva baseada em: ' + reservationId);
                // Implementar nova reserva
            }
        }
        
        function downloadReceipt(reservationId) {
            alert('Baixando comprovante da reserva: ' + reservationId);
            // Implementar download do comprovante
        }
        
        function viewRejectionReason(reservationId) {
            alert('Ver motivo da rejeição da reserva: ' + reservationId);
            // Implementar visualização do motivo de rejeição
        }
    </script>
</body>
</html>