<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestão de Feedbacks - Administrador</title>
    <link rel="stylesheet" href="../assets/css/feedback.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <div style="margin-bottom: 1rem;">
            <a href="admDetalhes.jsp" style="background: linear-gradient(135deg, #6c757d, #495057); color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-flex; align-items: center; gap: 0.5rem; font-weight: 600; transition: all 0.3s ease;">
                <i class="fas fa-arrow-left"></i> Voltar para Painel do Administrador
            </a>
        </div>
        <h1><i class="fas fa-comments"></i> Gestão de Feedbacks - Administrador</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="bicicletasAdm.jsp"><i class="fas fa-bicycle"></i> Bicicletas</a>
            <a href="reservasAdm.jsp"><i class="fas fa-calendar-check"></i> Reservas</a>
            <a href="gestaoUsuario.jsp"><i class="fas fa-users"></i> Usuários</a>
            <a href="feedbackAdm.jsp"><i class="fas fa-comments"></i> Feedbacks</a>
            <a href="rankingAdm.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <!-- Estatísticas de Feedback -->
        <div class="stats-summary">
            <h3><i class="fas fa-chart-pie"></i> Estatísticas de Feedbacks</h3>
            <div class="stats-row">
                <div class="stat-item">
                    <div class="stat-number">156</div>
                    <div class="stat-label">Total de Feedbacks</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">4.3</div>
                    <div class="stat-label">Média Geral</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">8</div>
                    <div class="stat-label">Feedbacks Negativos</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">3</div>
                    <div class="stat-label">Necessitam Mediação</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">92%</div>
                    <div class="stat-label">Satisfação</div>
                </div>
            </div>
        </div>
        
        <!-- Filtros -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterFeedbacks('todos')">
                <i class="fas fa-list"></i> Todos (156)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('positivos')">
                <i class="fas fa-thumbs-up"></i> Positivos (143)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('negativos')">
                <i class="fas fa-thumbs-down"></i> Negativos (8)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('mediacao')">
                <i class="fas fa-exclamation-triangle"></i> Precisam Mediação (3)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('recentes')">
                <i class="fas fa-clock"></i> Recentes (12)
            </button>
        </div>
        
        <!-- Lista de Feedbacks -->
        <div class="feedback-grid">
            <!-- Feedback Negativo que Precisa de Mediação -->
            <div class="feedback-card" data-category="negativos mediacao">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> 06/08/2025 às 14:30
                            <span style="color: #dc3545; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-exclamation-triangle"></i> PRECISA MEDIAÇÃO
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-2025-045</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/bike1.jpg" alt="Mountain Explorer" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/dc3545/ffffff?text=Problema'">
                    <div class="feedback-details">
                        <div class="bike-name">Mountain Explorer MX-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Avaliador: Carlos Pereira (Locatário)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Avaliado: João Silva (Locador)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: Vila Madalena, São Paulo - SP</span>
                        </div>
                        <div class="rating-section">
                            <div class="rating-row">
                                <span>Avaliação da Bicicleta:</span>
                                <div>
                                    <span class="rating-stars">★☆☆☆☆</span>
                                    <span class="rating-value">1.0/5.0</span>
                                </div>
                            </div>
                            <div class="rating-row">
                                <span>Avaliação do Usuário:</span>
                                <div>
                                    <span class="rating-stars">★★☆☆☆</span>
                                    <span class="rating-value">2.0/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "A bicicleta estava em péssimo estado de conservação. Os freios não funcionavam direito e a corrente estava suja. O proprietário foi grosseiro e não ajudou quando relatei os problemas. Experiência terrível!"
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-tools"></i>
                            <span>Problemas: Freios defeituosos, corrente suja, comunicação ruim</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-warning" onclick="mediateConflict('RSV-2025-045')">
                                <i class="fas fa-gavel"></i> Mediar Conflito
                            </a>
                            <a href="#" class="btn btn-info" onclick="viewReservationDetails('RSV-2025-045')">
                                <i class="fas fa-eye"></i> Ver Reserva
                            </a>
                            <a href="#" class="btn btn-primary" onclick="contactUsers('RSV-2025-045')">
                                <i class="fas fa-envelope"></i> Contatar Usuários
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Feedback Positivo -->
            <div class="feedback-card" data-category="positivos recentes">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> 07/08/2025 às 09:15
                        </div>
                        <div class="reservation-id">Reserva: #RSV-2025-048</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/bike2.jpg" alt="Speed Urbana" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/28a745/ffffff?text=Ótimo'">
                    <div class="feedback-details">
                        <div class="bike-name">Speed Urbana SP-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Avaliador: Ana Santos (Locatária)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Avaliado: Maria Silva (Locadora)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: Copacabana, Rio de Janeiro - RJ</span>
                        </div>
                        <div class="rating-section">
                            <div class="rating-row">
                                <span>Avaliação da Bicicleta:</span>
                                <div>
                                    <span class="rating-stars">★★★★★</span>
                                    <span class="rating-value">5.0/5.0</span>
                                </div>
                            </div>
                            <div class="rating-row">
                                <span>Avaliação do Usuário:</span>
                                <div>
                                    <span class="rating-stars">★★★★★</span>
                                    <span class="rating-value">5.0/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "Experiência perfeita! A bicicleta estava impecável, bem cuidada e funcionando perfeitamente. A Maria foi super atenciosa, pontual e prestativa. Recomendo muito!"
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-check-circle"></i>
                            <span>Qualidades: Funcional, bem conservada, boa comunicação, pontualidade</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-info" onclick="viewReservationDetails('RSV-2025-048')">
                                <i class="fas fa-eye"></i> Ver Reserva
                            </a>
                            <a href="#" class="btn btn-success" onclick="highlightPositiveFeedback('RSV-2025-048')">
                                <i class="fas fa-star"></i> Destacar Feedback
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Feedback Neutro/Regular -->
            <div class="feedback-card" data-category="positivos">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> 05/08/2025 às 16:45
                        </div>
                        <div class="reservation-id">Reserva: #RSV-2025-042</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/bike3.jpg" alt="Urbana City" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/ffc107/000000?text=OK'">
                    <div class="feedback-details">
                        <div class="bike-name">Urbana City UB-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Avaliador: Pedro Oliveira (Locatário)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Avaliado: Carlos Mendes (Locador)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: Savassi, Belo Horizonte - MG</span>
                        </div>
                        <div class="rating-section">
                            <div class="rating-row">
                                <span>Avaliação da Bicicleta:</span>
                                <div>
                                    <span class="rating-stars">★★★☆☆</span>
                                    <span class="rating-value">3.0/5.0</span>
                                </div>
                            </div>
                            <div class="rating-row">
                                <span>Avaliação do Usuário:</span>
                                <div>
                                    <span class="rating-stars">★★★★☆</span>
                                    <span class="rating-value">4.0/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "A bicicleta cumpriu o propósito, mas poderia estar em melhor estado. Algumas marchas não funcionavam bem. O proprietário foi educado e pontual."
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-wrench"></i>
                            <span>Observações: Problemas nas marchas, mas funcional</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-info" onclick="viewReservationDetails('RSV-2025-042')">
                                <i class="fas fa-eye"></i> Ver Reserva
                            </a>
                            <a href="#" class="btn btn-warning" onclick="suggestMaintenance('RSV-2025-042')">
                                <i class="fas fa-tools"></i> Sugerir Manutenção
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Feedback Muito Positivo -->
            <div class="feedback-card" data-category="positivos recentes">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> 07/08/2025 às 18:20
                        </div>
                        <div class="reservation-id">Reserva: #RSV-2025-050</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/bike4.jpg" alt="Dobrável Compacta" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/28a745/ffffff?text=Top'">
                    <div class="feedback-details">
                        <div class="bike-name">Dobrável Compacta DB-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Avaliador: Luisa Ferreira (Locatária)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Avaliado: Ana Paula (Locadora)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: Moinhos de Vento, Porto Alegre - RS</span>
                        </div>
                        <div class="rating-section">
                            <div class="rating-row">
                                <span>Avaliação da Bicicleta:</span>
                                <div>
                                    <span class="rating-stars">★★★★★</span>
                                    <span class="rating-value">5.0/5.0</span>
                                </div>
                            </div>
                            <div class="rating-row">
                                <span>Avaliação do Usuário:</span>
                                <div>
                                    <span class="rating-stars">★★★★★</span>
                                    <span class="rating-value">5.0/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "Bicicleta elétrica fantástica! Bateria durou todo o passeio, muito bem cuidada e limpa. A Ana foi extremamente profissional, explicou tudo sobre o funcionamento e foi muito flexível com os horários. Definitivamente vou alugar novamente!"
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-battery-full"></i>
                            <span>Destaque: Bateria 100%, excelente condição, atendimento profissional</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-info" onclick="viewReservationDetails('RSV-2025-050')">
                                <i class="fas fa-eye"></i> Ver Reserva
                            </a>
                            <a href="#" class="btn btn-success" onclick="highlightPositiveFeedback('RSV-2025-050')">
                                <i class="fas fa-star"></i> Destacar Feedback
                            </a>
                            <a href="#" class="btn btn-primary" onclick="promoteLocador('ana.paula')">
                                <i class="fas fa-trophy"></i> Reconhecer Locador
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Feedback Negativo Moderado -->
            <div class="feedback-card" data-category="negativos">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> 04/08/2025 às 11:30
                        </div>
                        <div class="reservation-id">Reserva: #RSV-2025-038</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/bike5.jpg" alt="Durban Dobrável" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/dc3545/ffffff?text=Ruim'">
                    <div class="feedback-details">
                        <div class="bike-name">Durban Sampa Pro</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Avaliador: Roberto Silva (Locatário)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-user-tie"></i>
                            <span>Avaliado: Pedro Costa (Locador)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Local: Centro, Curitiba - PR</span>
                        </div>
                        <div class="rating-section">
                            <div class="rating-row">
                                <span>Avaliação da Bicicleta:</span>
                                <div>
                                    <span class="rating-stars">★★☆☆☆</span>
                                    <span class="rating-value">2.0/5.0</span>
                                </div>
                            </div>
                            <div class="rating-row">
                                <span>Avaliação do Usuário:</span>
                                <div>
                                    <span class="rating-stars">★★★☆☆</span>
                                    <span class="rating-value">3.0/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "A bicicleta não dobrava direito, estava com ruídos estranhos. O dono se atrasou 30 minutos para a entrega e não foi muito comunicativo sobre os problemas da bike."
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>Problemas: Mecanismo de dobra defeituoso, atraso na entrega</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-info" onclick="viewReservationDetails('RSV-2025-038')">
                                <i class="fas fa-eye"></i> Ver Reserva
                            </a>
                            <a href="#" class="btn btn-warning" onclick="sendMaintenanceAlert('pedro.costa')">
                                <i class="fas fa-tools"></i> Alerta Manutenção
                            </a>
                            <a href="#" class="btn btn-primary" onclick="sendImprovementTips('pedro.costa')">
                                <i class="fas fa-lightbulb"></i> Dicas de Melhoria
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="back-button">
            <a href="admDetalhes.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar ao Painel Administrativo
            </a>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        function filterFeedbacks(category) {
            // Remove active class from all tabs
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Add active class to clicked tab
            event.target.classList.add('active');
            
            // Show/hide feedback cards
            document.querySelectorAll('.feedback-card').forEach(card => {
                const categories = card.dataset.category.split(' ');
                if (category === 'todos' || categories.includes(category)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        function mediateConflict(reservationId) {
            alert('Iniciar mediação para reserva: ' + reservationId);
            // Implementar sistema de mediação
        }
        
        function viewReservationDetails(reservationId) {
            alert('Ver detalhes da reserva: ' + reservationId);
            // Implementar visualização de detalhes
        }
        
        function contactUsers(reservationId) {
            alert('Contatar usuários da reserva: ' + reservationId);
            // Implementar sistema de contato
        }
        
        function highlightPositiveFeedback(reservationId) {
            if (confirm('Destacar este feedback positivo na página inicial?')) {
                alert('Feedback destacado: ' + reservationId);
            }
        }
        
        function suggestMaintenance(reservationId) {
            if (confirm('Enviar sugestão de manutenção para o proprietário?')) {
                alert('Sugestão de manutenção enviada para reserva: ' + reservationId);
            }
        }
        
        function promoteLocador(locadorId) {
            if (confirm('Enviar reconhecimento especial para este locador?')) {
                alert('Reconhecimento enviado para locador: ' + locadorId);
            }
        }
        
        function sendMaintenanceAlert(userId) {
            if (confirm('Enviar alerta de manutenção necessária?')) {
                alert('Alerta de manutenção enviado para: ' + userId);
            }
        }
        
        function sendImprovementTips(userId) {
            if (confirm('Enviar dicas de melhoria para o usuário?')) {
                alert('Dicas de melhoria enviadas para: ' + userId);
            }
        }
    </script>
</body>
</html>