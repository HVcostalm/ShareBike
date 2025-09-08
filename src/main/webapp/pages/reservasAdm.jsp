<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.sharebike.model.Reserva" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestão de Reservas - Administrador</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/reservas.css">
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
        
        /* Estilos para página sem dados */
        .no-data {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        
        .no-data i {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        
        /* Estilização adicional para garantir que elementos sejam exibidos corretamente */
        .container {
            margin: 2rem auto;
            max-width: 1200px;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .stats-summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            border: 1px solid #dee2e6;
        }
        
        .stats-row {
            display: flex;
            justify-content: space-around;
            text-align: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .stat-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            min-width: 120px;
            margin: 0.5rem;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #38b2ac;
        }
        
        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .filter-tabs {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .filter-tab {
            background: #6c757d;
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
        }
        
        .filter-tab:hover {
            background: #38b2ac;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }
        
        .filter-tab.active {
            background: #38b2ac;
        }
        
        .reservations-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        .reservation-card {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 1.5rem;
            background: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .reservation-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        .back-button {
            text-align: center;
            margin-top: 2rem;
        }
        
        .btn-back {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
            padding: 1rem 2rem;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            color: white;
            text-decoration: none;
        }
        
        /* Estilos para status de reserva */
        .status-em.andamento, .status-em_andamento {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        
        .status-negada {
            background-color: #f8d7da;
            color: #721c24;
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
                    
                    <a href="<%=request.getContextPath()%>/ReservaController" class="nav-link active">
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
        <i class="fas fa-calendar-check"></i> Gestão de Reservas - Administrador
    </div>
    
    <div class="container">
        <%
        List<Reserva> listaReservas = (List<Reserva>) request.getAttribute("listaReservas");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        
        // DEBUG: Verificar se os atributos estão chegando
        System.out.println("=== DEBUG JSP reservasAdm ===");
        System.out.println("listaReservas size: " + (listaReservas != null ? listaReservas.size() : "NULL"));
        
        // Usar estatísticas gerais vindas do controller (sempre todas as reservas)
        Integer totalGeral = (Integer) request.getAttribute("totalGeral");
        Integer pendentesGeral = (Integer) request.getAttribute("pendentesGeral");
        Integer confirmadaGeral = (Integer) request.getAttribute("confirmadasGeral");
        Integer emAndamentoGeral = (Integer) request.getAttribute("emAndamentoGeral");
        Integer finalizadasGeral = (Integer) request.getAttribute("finalizadasGeral");
        Integer negadasGeral = (Integer) request.getAttribute("negadasGeral");
        String statusFiltro = (String) request.getAttribute("statusFiltro");
        
        System.out.println("Atributos recebidos do controller:");
        System.out.println("- totalGeral: " + totalGeral);
        System.out.println("- pendentesGeral: " + pendentesGeral);
        System.out.println("- confirmadaGeral: " + confirmadaGeral);
        System.out.println("- emAndamentoGeral: " + emAndamentoGeral);
        System.out.println("- finalizadasGeral: " + finalizadasGeral);
        System.out.println("- negadasGeral: " + negadasGeral);
        System.out.println("- statusFiltro: " + statusFiltro);
        
        // Usar valores padrão se os atributos não estiverem disponíveis
        int totalReservas = totalGeral != null ? totalGeral : 0;
        int pendentes = pendentesGeral != null ? pendentesGeral : 0;
        int confirmadas = confirmadaGeral != null ? confirmadaGeral : 0;
        int emAndamento = emAndamentoGeral != null ? emAndamentoGeral : 0;
        int finalizadas = finalizadasGeral != null ? finalizadasGeral : 0;
        int negadas = negadasGeral != null ? negadasGeral : 0;
        
        // FALLBACK: Se os valores do controller estão zerados, calcular baseado na lista atual
        if (totalReservas == 0 && listaReservas != null && !listaReservas.isEmpty()) {
            System.out.println("⚠️ FALLBACK: Calculando estatísticas no JSP pois controller retornou zero");
            totalReservas = listaReservas.size();
        }
        
        // Informações sobre o filtro atual
        int totalFiltradas = listaReservas != null ? listaReservas.size() : 0;
        String tituloFiltro = "Todas as Reservas";
        if (statusFiltro != null && !statusFiltro.isEmpty()) {
            switch (statusFiltro.toUpperCase()) {
                case "PENDENTE": tituloFiltro = "Reservas Pendentes"; break;
                case "CONFIRMADA": tituloFiltro = "Reservas Confirmadas"; break;
                case "EM ANDAMENTO": tituloFiltro = "Reservas em Andamento"; break;
                case "FINALIZADA": tituloFiltro = "Reservas Finalizadas"; break;
                case "NEGADA": tituloFiltro = "Reservas Negadas"; break;
                default: tituloFiltro = "Reservas (" + statusFiltro + ")"; break;
            }
        }
        %>
        
        <!-- Estatísticas Resumidas do Sistema Completo -->
        <div class="stats-summary">
            <h3><i class="fas fa-chart-bar"></i> Estatísticas do Sistema Completo</h3>
            <div class="stats-row">
                <div class="stat-item">
                    <div class="stat-number"><%=totalReservas%></div>
                    <div class="stat-label">Total de Reservas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=pendentes%></div>
                    <div class="stat-label">Pendentes</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=confirmadas%></div>
                    <div class="stat-label">Confirmadas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=emAndamento%></div>
                    <div class="stat-label">Em Andamento</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=finalizadas%></div>
                    <div class="stat-label">Finalizadas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><%=negadas%></div>
                    <div class="stat-label">Negadas</div>
                </div>
            </div>
        </div>
        
        <!-- Informações sobre o filtro atual -->
        <% if (statusFiltro != null && !statusFiltro.isEmpty()) { %>
        <div class="filter-info" style="background: #e3f2fd; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; border-left: 4px solid #2196f3;">
            <h4 style="margin: 0 0 0.5rem 0; color: #1976d2;">
                <i class="fas fa-filter"></i> Filtro Ativo: <%=tituloFiltro%>
            </h4>
            <p style="margin: 0; color: #424242;">
                Exibindo <%=totalFiltradas%> de <%=totalReservas%> reservas do sistema
                <a href="<%=request.getContextPath()%>/ReservaController" style="margin-left: 15px; color: #1976d2; text-decoration: none;">
                    <i class="fas fa-times-circle"></i> Remover filtro
                </a>
            </p>
        </div>
        <% } %>
        
        <!-- Filtros por Status -->
        <div class="filter-tabs">
            <a href="<%=request.getContextPath()%>/ReservaController" class="filter-tab <%=(statusFiltro == null || statusFiltro.isEmpty()) ? "active" : ""%>">
                <i class="fas fa-list"></i> Todas (<%=totalReservas%>)
            </a>
            <a href="<%=request.getContextPath()%>/ReservaController?status=PENDENTE" class="filter-tab <%="PENDENTE".equals(statusFiltro) ? "active" : ""%>">
                <i class="fas fa-clock"></i> Pendentes (<%=pendentes%>)
            </a>
            <a href="<%=request.getContextPath()%>/ReservaController?status=CONFIRMADA" class="filter-tab <%="CONFIRMADA".equals(statusFiltro) ? "active" : ""%>">
                <i class="fas fa-check-circle"></i> Confirmadas (<%=confirmadas%>)
            </a>
            <a href="<%=request.getContextPath()%>/ReservaController?status=EM ANDAMENTO" class="filter-tab <%="EM ANDAMENTO".equals(statusFiltro) ? "active" : ""%>">
                <i class="fas fa-running"></i> Em Andamento (<%=emAndamento%>)
            </a>
            <a href="<%=request.getContextPath()%>/ReservaController?status=FINALIZADA" class="filter-tab <%="FINALIZADA".equals(statusFiltro) ? "active" : ""%>">
                <i class="fas fa-flag-checkered"></i> Finalizadas (<%=finalizadas%>)
            </a>
            <a href="<%=request.getContextPath()%>/ReservaController?status=NEGADA" class="filter-tab <%="NEGADA".equals(statusFiltro) ? "active" : ""%>">
                <i class="fas fa-times-circle"></i> Negadas (<%=negadas%>)
            </a>
        </div>
        
        <!-- Lista de Reservas -->
        <div class="reservations-list">
            <%
            if (listaReservas != null && !listaReservas.isEmpty()) {
                for (Reserva reserva : listaReservas) {
                    String statusClass = "status-" + reserva.getStatus_reserv().toLowerCase();
                    String statusText = reserva.getStatus_reserv();
                    
                    // Traduzir status para exibição mais amigável
                    switch(statusText.toUpperCase()) {
                        case "CONFIRMADA":
                            statusText = "Confirmada";
                            statusClass = "status-confirmada";
                            break;
                        case "PENDENTE":
                            statusText = "Pendente";
                            statusClass = "status-pendente";
                            break;
                        case "EM ANDAMENTO":
                            statusText = "Em Andamento";
                            statusClass = "status-em-andamento";
                            break;
                        case "FINALIZADA":
                            statusText = "Finalizada";
                            statusClass = "status-finalizada";
                            break;
                        case "NEGADA":
                            statusText = "Negada";
                            statusClass = "status-negada";
                            break;
                    }
                    
                    // Calcular duração
                    long duracaoDias = ChronoUnit.DAYS.between(reserva.getDataCheckIn_reserv(), reserva.getDataCheckOut_reserv());
                    String duracaoTexto;
                    
                    if (duracaoDias > 0) {
                        duracaoTexto = duracaoDias + (duracaoDias == 1 ? " dia" : " dias");
                    } else {
                        long duracaoHoras = ChronoUnit.HOURS.between(reserva.getDataCheckIn_reserv(), reserva.getDataCheckOut_reserv());
                        duracaoTexto = duracaoHoras + (duracaoHoras == 1 ? " hora" : " horas");
                    }
            %>
            <div class="reservation-card">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-<%=reserva.getId_reserv()%></div>
                    <div class="reservation-status <%=statusClass%>"><%=statusText%></div>
                </div>
                <div class="reservation-content">
                    <img src="https://via.placeholder.com/200x150/38b2ac/ffffff?text=<%=reserva.getBicicleta().getFoto_bike()%>" alt="<%=reserva.getBicicleta().getFoto_bike()%>" 
                         class="bike-image">
                    <div class="reservation-details">
                        <div class="bike-name"><%=reserva.getBicicleta().getNome_bike()%></div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: <%=reserva.getUsuario().getNomeRazaoSocial_user()%> (<%=reserva.getUsuario().getEmail_user()%>)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Locador: <%=reserva.getBicicleta().getUsuario().getNomeRazaoSocial_user()%> (<%=reserva.getBicicleta().getUsuario().getEmail_user()%>)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: <%=reserva.getBicicleta().getLocalEntr_bike()%></span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-clock"></i>
                            <span>Duração: <%=duracaoTexto%></span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Check-in</div>
                                    <div class="date-value"><%=reserva.getDataCheckIn_reserv().format(formatter)%></div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Check-out</div>
                                    <div class="date-value"><%=reserva.getDataCheckOut_reserv().format(formatter)%></div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Status</div>
                                    <div class="date-value"><%=statusText%></div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <%
                            if ("FINALIZADA".equals(reserva.getStatus_reserv())) {
                            %>
                                <a href="<%=request.getContextPath()%>/FeedbackController?action=listar-para-detalhes&cpfCnpjAvaliado=<%=reserva.getUsuario().getCpfCnpj_user()%>" class="btn btn-success">
                                    <i class="fas fa-comments"></i> Ver Feedback
                                </a>
                            <%
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
            <div class="no-data">
                <i class="fas fa-calendar-times"></i>
                <h3>Nenhuma reserva encontrada</h3>
                <p>Não há reservas para exibir no momento.</p>
            </div>
            <%
            }
            %>
        </div>
        
        <div class="back-button">
            <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar ao Painel Administrativo
            </a>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        // Funções futuras para funcionalidades administrativas
        // Mantidas para implementação posterior se necessário
    </script>
</body>
</html>