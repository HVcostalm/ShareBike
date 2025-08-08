<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestão de Reservas - Administrador</title>
    <link rel="stylesheet" href="../assets/css/reservas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <div style="margin-bottom: 1rem;">
            <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" style="background: linear-gradient(135deg, #6c757d, #495057); color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-flex; align-items: center; gap: 0.5rem; font-weight: 600; transition: all 0.3s ease;">
                <i class="fas fa-arrow-left"></i> Voltar para Painel do Administrador
            </a>
        </div>
        <h1><i class="fas fa-calendar-check"></i> Gestão de Reservas - Administrador</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasAdm.jsp"><i class="fas fa-bicycle"></i> Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasAdm.jsp"><i class="fas fa-calendar-check"></i> Reservas</a>
            <a href="<%=request.getContextPath()%>/pages/gestaoUsuario.jsp"><i class="fas fa-users"></i> Usuários</a>
            <a href="<%=request.getContextPath()%>/pages/feedbackAdm.jsp"><i class="fas fa-comments"></i> Feedbacks</a>
            <a href="<%=request.getContextPath()%>/pages/rankingAdm.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <!-- Estatísticas Resumidas -->
        <div class="stats-summary">
            <h3><i class="fas fa-chart-bar"></i> Estatísticas do Sistema</h3>
            <div class="stats-row">
                <div class="stat-item">
                    <div class="stat-number">47</div>
                    <div class="stat-label">Total de Reservas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">12</div>
                    <div class="stat-label">Pendentes</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">8</div>
                    <div class="stat-label">Ativas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">23</div>
                    <div class="stat-label">Finalizadas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">4</div>
                    <div class="stat-label">Canceladas</div>
                </div>
            </div>
        </div>
        
        <!-- Filtros por Status -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterReservations('todas')">
                <i class="fas fa-list"></i> Todas (47)
            </button>
            <button class="filter-tab" onclick="filterReservations('pendentes')">
                <i class="fas fa-clock"></i> Pendentes (12)
            </button>
            <button class="filter-tab" onclick="filterReservations('ativas')">
                <i class="fas fa-play-circle"></i> Ativas (8)
            </button>
            <button class="filter-tab" onclick="filterReservations('finalizadas')">
                <i class="fas fa-check-circle"></i> Finalizadas (23)
            </button>
            <button class="filter-tab" onclick="filterReservations('canceladas')">
                <i class="fas fa-times-circle"></i> Canceladas (4)
            </button>
        </div>
        
        <!-- Lista de Reservas -->
        <div class="reservations-list">
            <!-- Reserva Pendente 1 -->
            <div class="reservation-card" data-status="pendentes">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-2025-001</div>
                    <div class="reservation-status status-pendente">Pendente</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/bike1.jpg" alt="Mountain Explorer" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/38b2ac/ffffff?text=Bike'">
                    <div class="reservation-details">
                        <div class="bike-name">Mountain Explorer MX-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Ana Silva (ana.silva@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Locador: João Santos (joao.santos@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: Vila Madalena, São Paulo - SP</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Duração: 3 dias</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Check-in</div>
                                    <div class="date-value">10/08/2025 14:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Check-out</div>
                                    <div class="date-value">13/08/2025 14:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Duração</div>
                                    <div class="date-value">3 dias</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="#" class="btn btn-info" onclick="viewDetails('RSV-2025-001')">
                                <i class="fas fa-eye"></i> Detalhes
                            </a>
                            <a href="#" class="btn btn-primary" onclick="contactUsers('RSV-2025-001')">
                                <i class="fas fa-envelope"></i> Contatar Usuários
                            </a>
                            <a href="#" class="btn btn-warning" onclick="mediateIssue('RSV-2025-001')">
                                <i class="fas fa-gavel"></i> Mediar Conflito
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reserva Ativa 1 -->
            <div class="reservation-card" data-status="ativas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-2025-002</div>
                    <div class="reservation-status status-ativa">Em Andamento</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/bike2.jpg" alt="Speed Urbana" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/007bff/ffffff?text=Bike'">
                    <div class="reservation-details">
                        <div class="bike-name">Speed Urbana SP-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Carlos Oliveira (carlos.oliveira@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Locador: Maria Santos (maria.santos@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: Copacabana, Rio de Janeiro - RJ</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Duração: 2 dias</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Check-in</div>
                                    <div class="date-value">07/08/2025 09:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Check-out</div>
                                    <div class="date-value">09/08/2025 18:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Status</div>
                                    <div class="date-value">Em uso</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="#" class="btn btn-info" onclick="viewDetails('RSV-2025-002')">
                                <i class="fas fa-eye"></i> Detalhes
                            </a>
                            <a href="#" class="btn btn-primary" onclick="trackReservation('RSV-2025-002')">
                                <i class="fas fa-map"></i> Acompanhar
                            </a>
                            <a href="#" class="btn btn-warning" onclick="sendReminder('RSV-2025-002')">
                                <i class="fas fa-bell"></i> Lembrete
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reserva Finalizada 1 -->
            <div class="reservation-card" data-status="finalizadas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-2025-003</div>
                    <div class="reservation-status status-finalizada">Finalizada</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/bike3.jpg" alt="Urbana City" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/28a745/ffffff?text=Bike'">
                    <div class="reservation-details">
                        <div class="bike-name">Urbana City UB-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Pedro Costa (pedro.costa@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Locador: Ana Paula (ana.paula@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: Savassi, Belo Horizonte - MG</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-check-circle"></i>
                            <span>Concluída em: 05/08/2025 - Avaliação: 4.5/5</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Check-in</div>
                                    <div class="date-value">03/08/2025 10:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Check-out</div>
                                    <div class="date-value">05/08/2025 16:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Duração</div>
                                    <div class="date-value">2 dias</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="#" class="btn btn-info" onclick="viewDetails('RSV-2025-003')">
                                <i class="fas fa-eye"></i> Detalhes
                            </a>
                            <a href="#" class="btn btn-success" onclick="viewFeedback('RSV-2025-003')">
                                <i class="fas fa-comments"></i> Ver Feedback
                            </a>
                            <a href="#" class="btn btn-primary" onclick="viewPayment('RSV-2025-003')">
                                <i class="fas fa-receipt"></i> Pagamento
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reserva Cancelada 1 -->
            <div class="reservation-card" data-status="canceladas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-2025-004</div>
                    <div class="reservation-status status-cancelada">Cancelada</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/bike4.jpg" alt="Dobrável Compacta" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/dc3545/ffffff?text=Bike'">
                    <div class="reservation-details">
                        <div class="bike-name">Dobrável Compacta DB-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Luisa Ferreira (luisa.ferreira@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Locador: Roberto Silva (roberto.silva@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-times-circle"></i>
                            <span>Motivo: Problema técnico na bicicleta</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Cancelada em: 06/08/2025 11:30</span>
                        </div>
                        <div class="reservation-actions">
                            <a href="#" class="btn btn-info" onclick="viewDetails('RSV-2025-004')">
                                <i class="fas fa-eye"></i> Detalhes
                            </a>
                            <a href="#" class="btn btn-warning" onclick="viewCancellationReason('RSV-2025-004')">
                                <i class="fas fa-question-circle"></i> Motivo
                            </a>
                            <a href="#" class="btn btn-primary" onclick="processRefund('RSV-2025-004')">
                                <i class="fas fa-undo"></i> Reembolso
                            </a>
                        </div>
                    </div>
                </div>
            </div>
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
        
        function viewDetails(reservationId) {
            alert('Visualizar detalhes da reserva: ' + reservationId);
            // Implementar redirecionamento para página de detalhes
        }
        
        function contactUsers(reservationId) {
            alert('Contatar usuários da reserva: ' + reservationId);
            // Implementar sistema de mensagens
        }
        
        function mediateIssue(reservationId) {
            alert('Mediar conflito da reserva: ' + reservationId);
            // Implementar sistema de mediação
        }
        
        function trackReservation(reservationId) {
            alert('Acompanhar reserva ativa: ' + reservationId);
            // Implementar sistema de tracking
        }
        
        function sendReminder(reservationId) {
            if (confirm('Enviar lembrete para os usuários desta reserva?')) {
                alert('Lembrete enviado para reserva: ' + reservationId);
            }
        }
        
        function viewFeedback(reservationId) {
            alert('Ver feedback da reserva: ' + reservationId);
            // Implementar visualização de feedback
        }
        
        function viewPayment(reservationId) {
            alert('Ver informações de pagamento da reserva: ' + reservationId);
            // Implementar visualização de pagamento
        }
        
        function viewCancellationReason(reservationId) {
            alert('Ver motivo do cancelamento da reserva: ' + reservationId);
            // Implementar visualização do motivo
        }
        
        function processRefund(reservationId) {
            if (confirm('Processar reembolso para esta reserva?')) {
                alert('Processando reembolso para reserva: ' + reservationId);
            }
        }
    </script>
</body>
</html>