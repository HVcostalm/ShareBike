<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Minhas Reservas - Locatário</title>
    <link rel="stylesheet" href="../assets/css/reservas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <h1><i class="fas fa-calendar-check"></i> Minhas Reservas</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocatario.jsp"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasLocatario.jsp"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="<%=request.getContextPath()%>/pages/fazerFeedbackLocatario.jsp"><i class="fas fa-comment-dots"></i> Dar Feedback</a>
            <a href="<%=request.getContextPath()%>/pages/fazerReserva.jsp"><i class="fas fa-calendar-plus"></i> Nova Reserva</a>
            <a href="<%=request.getContextPath()%>/pages/rankingLocatario.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <!-- Estatísticas do Locatário - Baseado no modelo Reserva -->
        <div class="stats-summary">
            <h3><i class="fas fa-chart-pie"></i> Meu Histórico</h3>
            <div class="stats-row">
                <div class="stat-item">
                    <div class="stat-number">23</div>
                    <div class="stat-label">Total de Reservas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">2</div>
                    <div class="stat-label">Pendentes</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">1</div>
                    <div class="stat-label">Em Andamento</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">18</div>
                    <div class="stat-label">Finalizadas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">4.7</div>
                    <div class="stat-label">Minha Avaliação</div>
                </div>
            </div>
        </div>
        
        <!-- Filtros por Status -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterReservations('todas')">
                <i class="fas fa-list"></i> Todas (23)
            </button>
            <button class="filter-tab" onclick="filterReservations('pendentes')">
                <i class="fas fa-clock"></i> Pendentes (2)
            </button>
            <button class="filter-tab" onclick="filterReservations('confirmadas')">
                <i class="fas fa-check"></i> Confirmadas (1)
            </button>
            <button class="filter-tab" onclick="filterReservations('ativas')">
                <i class="fas fa-play-circle"></i> Em Andamento (1)
            </button>
            <button class="filter-tab" onclick="filterReservations('finalizadas')">
                <i class="fas fa-flag-checkered"></i> Finalizadas (19)
            </button>
        </div>
        
        <!-- Lista de Reservas -->
        <div class="reservations-list">
            <!-- Reserva Pendente -->
            <div class="reservation-card" data-status="pendentes">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-USER-001</div>
                    <div class="reservation-status status-pendente">Aguardando Aprovação</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/rent1.jpg" alt="Mountain Explorer" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/ffc107/000000?text=Pendente'">
                    <div class="reservation-details">
                        <div class="bike-name">Mountain Explorer MX-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: João Carlos Silva</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-bicycle"></i>
                            <span>Tipo: Mountain Bike</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: Vila Madalena, São Paulo - SP</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-tools"></i>
                            <span>Estado: Excelente conservação</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-clock"></i>
                            <span>Solicitado há: 2 horas</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Check-in Desejado</div>
                                    <div class="date-value">12/08/2025 14:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Check-out Desejado</div>
                                    <div class="date-value">15/08/2025 14:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Status</div>
                                    <div class="date-value">Aguardando resposta</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="detalheReservaLocatario.jsp?id=RSV-USER-001" class="btn btn-info">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            <a href="#" class="btn btn-primary" onclick="contactOwner('RSV-USER-001')">
                                <i class="fas fa-envelope"></i> Contatar Proprietário
                            </a>
                            <a href="#" class="btn btn-warning" onclick="modifyRequest('RSV-USER-001')">
                                <i class="fas fa-edit"></i> Modificar
                            </a>
                            <a href="#" class="btn btn-danger" onclick="cancelRequest('RSV-USER-001')">
                                <i class="fas fa-times"></i> Cancelar
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reserva Confirmada -->
            <div class="reservation-card" data-status="confirmadas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-USER-002</div>
                    <div class="reservation-status status-confirmada">Confirmada</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/rent2.jpg" alt="Speed Urbana" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/28a745/ffffff?text=Confirmada'">
                    <div class="reservation-details">
                        <div class="bike-name">Speed Urbana SP-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: Maria Silva Santos</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-phone"></i>
                            <span>Contato: (21) 99999-8888</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Retirada: Rua Copacabana, 456 - Rio de Janeiro</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-bicycle"></i>
                            <span>Tipo: Speed - Excelente estado</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-check-circle"></i>
                            <span>Aprovada em: 07/08/2025 09:15</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Retirada</div>
                                    <div class="date-value">10/08/2025 10:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Devolução</div>
                                    <div class="date-value">12/08/2025 18:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Tempo Restante</div>
                                    <div class="date-value">2 dias 2h</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="detalheReservaLocatario.jsp?id=RSV-USER-002" class="btn btn-info">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            <a href="#" class="btn btn-success" onclick="confirmPickup('RSV-USER-002')">
                                <i class="fas fa-handshake"></i> Confirmar Retirada
                            </a>
                            <a href="#" class="btn btn-primary" onclick="getDirections('RSV-USER-002')">
                                <i class="fas fa-route"></i> Como Chegar
                            </a>
                            <a href="#" class="btn btn-info" onclick="contactOwner('RSV-USER-002')">
                                <i class="fas fa-envelope"></i> Contatar
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reserva Ativa -->
            <div class="reservation-card" data-status="ativas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-USER-003</div>
                    <div class="reservation-status status-ativa">Em Andamento</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/rent3.jpg" alt="Urbana City" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/007bff/ffffff?text=Em+Uso'">
                    <div class="reservation-details">
                        <div class="bike-name">Urbana City UB-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: Carlos Oliveira</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-clock"></i>
                            <span>Em uso há: 6 horas e 30 minutos</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local Devolução: Praça da Savassi, BH</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Duração: 2 dias</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-battery-three-quarters"></i>
                            <span>Estado: Funcionando perfeitamente</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Retirada</div>
                                    <div class="date-value">07/08/2025 14:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Devolução Prevista</div>
                                    <div class="date-value">09/08/2025 14:00</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Tempo Restante</div>
                                    <div class="date-value">1 dia 7h 30m</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="detalheReservaLocatario.jsp?id=RSV-USER-003" class="btn btn-info">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            <a href="#" class="btn btn-warning" onclick="reportIssue('RSV-USER-003')">
                                <i class="fas fa-exclamation-triangle"></i> Reportar Problema
                            </a>
                            <a href="#" class="btn btn-info" onclick="extendReservation('RSV-USER-003')">
                                <i class="fas fa-clock"></i> Estender Tempo
                            </a>
                            <a href="#" class="btn btn-primary" onclick="getReturnDirections('RSV-USER-003')">
                                <i class="fas fa-route"></i> Como Devolver
                            </a>
                            <a href="#" class="btn btn-success" onclick="confirmReturn('RSV-USER-003')">
                                <i class="fas fa-check-circle"></i> Devolver
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reserva Finalizada Recente -->
            <div class="reservation-card" data-status="finalizadas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-USER-004</div>
                    <div class="reservation-status status-finalizada">Finalizada</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/rent4.jpg" alt="Dobrável Compacta" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/6c757d/ffffff?text=Finalizada'">
                    <div class="reservation-details">
                        <div class="bike-name">Dobrável Compacta DB-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: Ana Paula</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-check-circle"></i>
                            <span>Finalizada em: 05/08/2025 16:00</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-star"></i>
                            <span>Sua Avaliação: 4.8/5.0</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Duração: 2 dias</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-heart"></i>
                            <span>Experiência: Excelente!</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Período de Uso</div>
                                    <div class="date-value">03/08 - 05/08/2025</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Duração</div>
                                    <div class="date-value">2 dias</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Km Percorridos</div>
                                    <div class="date-value">~45 km</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="detalheReservaLocatario.jsp?id=RSV-USER-004" class="btn btn-primary">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            <a href="#" class="btn btn-info" onclick="viewFeedback('RSV-USER-004')">
                                <i class="fas fa-comments"></i> Ver Avaliações
                            </a>
                            <a href="#" class="btn btn-success" onclick="bookAgain('RSV-USER-004')">
                                <i class="fas fa-redo"></i> Reservar Novamente
                            </a>
                            <a href="#" class="btn btn-primary" onclick="downloadReceipt('RSV-USER-004')">
                                <i class="fas fa-download"></i> Comprovante
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Mais uma Reserva Finalizada -->
            <div class="reservation-card" data-status="finalizadas">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-USER-005</div>
                    <div class="reservation-status status-finalizada">Finalizada</div>
                </div>
                <div class="reservation-content">
                    <img src="../assets/images/rent5.jpg" alt="Durban Dobrável" class="bike-image" onerror="this.src='https://via.placeholder.com/200x150/6c757d/ffffff?text=Finalizada'">
                    <div class="reservation-details">
                        <div class="bike-name">Durban Sampa Pro</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: Pedro Costa</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-check-circle"></i>
                            <span>Finalizada em: 01/08/2025 12:00</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-star"></i>
                            <span>Sua Avaliação: 4.2/5.0</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Duração: 1 dia</span>
                        </div>
                        <div class="reservation-dates">
                            <div class="dates-row">
                                <div class="date-info">
                                    <div class="date-label">Período de Uso</div>
                                    <div class="date-value">31/07 - 01/08/2025</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Duração</div>
                                    <div class="date-value">1 dia</div>
                                </div>
                                <div class="date-info">
                                    <div class="date-label">Uso</div>
                                    <div class="date-value">Transporte urbano</div>
                                </div>
                            </div>
                        </div>
                        <div class="reservation-actions">
                            <a href="detalheReservaLocatario.jsp?id=RSV-USER-005" class="btn btn-primary">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                            <a href="#" class="btn btn-info" onclick="viewFeedback('RSV-USER-005')">
                                <i class="fas fa-comments"></i> Ver Avaliações
                            </a>
                            <a href="#" class="btn btn-success" onclick="bookAgain('RSV-USER-005')">
                                <i class="fas fa-redo"></i> Reservar Novamente
                            </a>
                            <a href="#" class="btn btn-primary" onclick="downloadReceipt('RSV-USER-005')">
                                <i class="fas fa-download"></i> Comprovante
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
            alert('Ver avaliações da reserva: ' + reservationId);
            // Implementar visualização de feedback
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
    </script>
</body>
</html>