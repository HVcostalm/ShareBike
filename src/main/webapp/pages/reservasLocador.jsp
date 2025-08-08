<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reservas Recebidas - Locador</title>
    <link rel="stylesheet" href="../assets/css/reservas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <h1><i class="fas fa-calendar-check"></i> Reservas das Minhas Bicicletas</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocador.jsp"><i class="fas fa-bicycle"></i> Minhas Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasLocador.jsp"><i class="fas fa-calendar-check"></i> Reservas Recebidas</a>
            <a href="<%=request.getContextPath()%>/pages/fazerFeedbackLocador.jsp"><i class="fas fa-comment-dots"></i> Feedbacks</a>
            <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp"><i class="fas fa-calendar-alt"></i> Disponibilidade</a>
        </nav>
        
        <!-- Estatísticas do Locador -->
        <div class="stats-summary">
            <h3><i class="fas fa-chart-line"></i> Minhas Estatísticas</h3>
            <div class="stats-row">
                <div class="stat-item">
                    <div class="stat-number">18</div>
                    <div class="stat-label">Total de Reservas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">5</div>
                    <div class="stat-label">Aguardando Resposta</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">2</div>
                    <div class="stat-label">Em Andamento</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">4.6</div>
                    <div class="stat-label">Avaliação Média</div>
                </div>
            </div>
        </div>
        
        <!-- Filtros por Status -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterReservations('todas')">
                <i class="fas fa-list"></i> Todas (18)
            </button>
            <button class="filter-tab" onclick="filterReservations('pendentes')">
                <i class="fas fa-clock"></i> Pendentes (5)
            </button>
            <button class="filter-tab" onclick="filterReservations('confirmadas')">
                <i class="fas fa-check"></i> Confirmadas (3)
            </button>
            <button class="filter-tab" onclick="filterReservations('ativas')">
                <i class="fas fa-play-circle"></i> Em Andamento (2)
            </button>
            <button class="filter-tab" onclick="filterReservations('finalizadas')">
                <i class="fas fa-flag-checkered"></i> Finalizadas (8)
            </button>
        </div>
        
        <!-- Lista de Reservas -->
        <div class="reservations-list">
            <!-- Reserva Pendente - Aguardando Aprovação -->
            <div class="reservation-card" data-status="pendentes">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-LOC-001</div>
                    <div class="reservation-status status-pendente">Aguardando Aprovação</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/mybike1.jpg" alt="Mountain Explorer MX-2024" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/38b2ac/ffffff?text=Minha+Bike'">
                    <div class="reservation-details">
                        <div class="bike-name">Mountain Explorer MX-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Solicitante: Ana Silva (ana.silva@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-star"></i>
                            <span>Avaliação do Locatário: 4.2/5.0 (15 avaliações)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local de Entrega: Vila Madalena, São Paulo - SP</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Período: 3 dias (12/08 a 14/08/2025)</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Check-in Solicitado</div>
                                    <div class="date-value">12/08/2025 14:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Check-out Solicitado</div>
                                    <div class="date-value">15/08/2025 14:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Solicitado em</div>
                                    <div class="date-value">07/08/2025 16:30</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="detalheReservaLocador.jsp?id=RSV-LOC-001" class="btn btn-primary">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            <a href="#" class="btn btn-success" onclick="approveReservation('RSV-LOC-001')">
                                <i class="fas fa-check"></i> Aprovar
                            </a>
                            <a href="#" class="btn btn-danger" onclick="rejectReservation('RSV-LOC-001')">
                                <i class="fas fa-times"></i> Recusar
                            </a>
                            <a href="#" class="btn btn-info" onclick="viewProfile('ana.silva')">
                                <i class="fas fa-user-circle"></i> Ver Perfil
                            </a>
                            <a href="#" class="btn btn-primary" onclick="sendMessage('RSV-LOC-001')">
                                <i class="fas fa-envelope"></i> Mensagem
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reserva Confirmada -->
            <div class="reservation-card" data-status="confirmadas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-LOC-002</div>
                    <div class="reservation-status status-confirmada">Confirmada</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/mybike2.jpg" alt="Speed Urbana" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/28a745/ffffff?text=Minha+Bike'">
                    <div class="reservation-details">
                        <div class="bike-name">Speed Urbana SP-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Carlos Oliveira (carlos.oliveira@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-phone"></i>
                            <span>Contato: (11) 98765-4321</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local de Entrega: Rua Augusta, 123 - São Paulo</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Período: 2 dias (15/08 a 16/08/2025)</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Check-in</div>
                                    <div class="date-value">09/08/2025 10:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Check-out</div>
                                    <div class="date-value">11/08/2025 18:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Status</div>
                                    <div class="date-value">Aguardando retirada</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="detalheReservaLocador.jsp?id=RSV-LOC-002" class="btn btn-info">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            <a href="#" class="btn btn-success" onclick="confirmPickup('RSV-LOC-002')">
                                <i class="fas fa-handshake"></i> Confirmar Retirada
                            </a>
                            <a href="#" class="btn btn-primary" onclick="sendMessage('RSV-LOC-002')">
                                <i class="fas fa-envelope"></i> Mensagem
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reserva Ativa -->
            <div class="reservation-card" data-status="ativas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-LOC-003</div>
                    <div class="reservation-status status-ativa">Em Andamento</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/mybike3.jpg" alt="BMX Pro" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/007bff/ffffff?text=Em+Uso'">
                    <div class="reservation-details">
                        <div class="bike-name">BMX Pro BX-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Pedro Costa (pedro.costa@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-clock"></i>
                            <span>Em uso há: 1 dia e 8 horas</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Última localização: Parque Ibirapuera</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Período: 3 dias (18/08 a 20/08/2025)</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Retirada</div>
                                    <div class="date-value">06/08/2025 09:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Devolução Prevista</div>
                                    <div class="date-value">09/08/2025 18:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Tempo Restante</div>
                                    <div class="date-value">1 dia 10h</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="detalheReservaLocador.jsp?id=RSV-LOC-003" class="btn btn-primary">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            <a href="#" class="btn btn-info" onclick="trackBike('RSV-LOC-003')">
                                <i class="fas fa-map"></i> Localizar
                            </a>
                            <a href="#" class="btn btn-primary" onclick="sendMessage('RSV-LOC-003')">
                                <i class="fas fa-envelope"></i> Mensagem
                            </a>
                            <a href="#" class="btn btn-warning" onclick="sendReturnReminder('RSV-LOC-003')">
                                <i class="fas fa-bell"></i> Lembrar Devolução
                            </a>
                            <a href="#" class="btn btn-success" onclick="confirmReturn('RSV-LOC-003')">
                                <i class="fas fa-check-circle"></i> Confirmar Devolução
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reserva Finalizada -->
            <div class="reservation-card" data-status="finalizadas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-LOC-004</div>
                    <div class="reservation-status status-finalizada">Finalizada</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/mybike1.jpg" alt="Mountain Explorer" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/6c757d/ffffff?text=Finalizada'">
                    <div class="reservation-details">
                        <div class="bike-name">Mountain Explorer MX-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Luisa Ferreira (luisa.ferreira@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-check-circle"></i>
                            <span>Finalizada em: 04/08/2025 17:30</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-star"></i>
                            <span>Avaliação Recebida: 4.8/5.0</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Período: 4 dias (concluído)</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Período</div>
                                    <div class="date-value">02/08 - 04/08/2025</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Duração</div>
                                    <div class="date-value">3 dias</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Estado Devolução</div>
                                    <div class="date-value">Excelente</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="detalheReservaLocador.jsp?id=RSV-LOC-004" class="btn btn-info">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            <a href="#" class="btn btn-info" onclick="viewFeedback('RSV-LOC-004')">
                                <i class="fas fa-comments"></i> Ver Avaliação
                            </a>
                            <a href="#" class="btn btn-success" onclick="giveFeedback('RSV-LOC-004')">
                                <i class="fas fa-star"></i> Avaliar Locatário
                            </a>
                            <a href="#" class="btn btn-primary" onclick="viewPayment('RSV-LOC-004')">
                                <i class="fas fa-receipt"></i> Comprovante
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="back-button">
            <a href="<%=request.getContextPath()%>/pages/Perfil.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar ao Perfil
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
        
        function approveReservation(reservationId) {
            if (confirm('Aprovar esta reserva?')) {
                alert('Reserva aprovada: ' + reservationId);
                // Implementar aprovação da reserva
                location.reload();
            }
        }
        
        function rejectReservation(reservationId) {
            const reason = prompt('Motivo da recusa (opcional):');
            if (reason !== null) {
                alert('Reserva recusada: ' + reservationId + (reason ? '\nMotivo: ' + reason : ''));
                // Implementar recusa da reserva
                location.reload();
            }
        }
        
        function viewProfile(username) {
            alert('Visualizar perfil do usuário: ' + username);
            // Implementar visualização do perfil
        }
        
        function sendMessage(reservationId) {
            alert('Enviar mensagem para reserva: ' + reservationId);
            // Implementar sistema de mensagens
        }
        
        function confirmPickup(reservationId) {
            if (confirm('Confirmar que a bicicleta foi retirada?')) {
                alert('Retirada confirmada para reserva: ' + reservationId);
                // Implementar confirmação de retirada
                location.reload();
            }
        }
        
        function trackBike(reservationId) {
            alert('Rastrear bicicleta da reserva: ' + reservationId);
            // Implementar sistema de rastreamento
        }
        
        function sendReturnReminder(reservationId) {
            if (confirm('Enviar lembrete de devolução para o locatário?')) {
                alert('Lembrete enviado para reserva: ' + reservationId);
            }
        }
        
        function confirmReturn(reservationId) {
            if (confirm('Confirmar que a bicicleta foi devolvida?')) {
                alert('Devolução confirmada para reserva: ' + reservationId);
                // Implementar confirmação de devolução
                location.reload();
            }
        }
        
        function viewFeedback(reservationId) {
            alert('Ver feedback da reserva: ' + reservationId);
            // Implementar visualização de feedback
        }
        
        function giveFeedback(reservationId) {
            alert('Avaliar locatário da reserva: ' + reservationId);
            // Implementar sistema de avaliação
        }
    </script>
</body>
</html>