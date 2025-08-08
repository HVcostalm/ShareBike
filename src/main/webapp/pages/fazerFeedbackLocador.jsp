<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Avaliar Locatários - Locador</title>
    <link rel="stylesheet" href="../assets/css/feedback.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <h1><i class="fas fa-comment-dots"></i> Avaliar Meus Locatários</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocador.jsp"><i class="fas fa-bicycle"></i> Minhas Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasLocador.jsp"><i class="fas fa-calendar-check"></i> Reservas Recebidas</a>
            <a href="<%=request.getContextPath()%>/pages/fazerFeedbackLocador.jsp"><i class="fas fa-comment-dots"></i> Avaliar Locatários</a>
            <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp"><i class="fas fa-calendar-alt"></i> Disponibilidade</a>
        </nav>
        
        <!-- Filtros -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterFeedbacks('pendentes')">
                <i class="fas fa-clock"></i> Avaliações Pendentes (3)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('realizadas')">
                <i class="fas fa-check-circle"></i> Já Avaliadas (15)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('recebidas')">
                <i class="fas fa-star"></i> Avaliações Recebidas (12)
            </button>
        </div>
        
        <!-- Avaliações Pendentes -->
        <div class="feedback-grid">
            <!-- Avaliação Pendente 1 -->
            <div class="feedback-card" data-category="pendentes">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> Reserva finalizada em: 05/08/2025
                            <span style="color: #ffc107; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-clock"></i> PENDENTE
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-LOC-004</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/mybike1.jpg" alt="Mountain Explorer" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/ffc107/000000?text=Avaliar'">
                    <div class="feedback-details">
                        <div class="bike-name">Mountain Explorer MX-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Luisa Ferreira (luisa.ferreira@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: 02/08/2025 - 04/08/2025 (3 dias)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Duração: 5 horas</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-bicycle"></i>
                            <span>Estado da devolução: Bom estado, sem danos</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-star"></i>
                            <span>Avaliação recebida do locatário: 4.8/5.0</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-primary" onclick="showFeedbackForm('RSV-LOC-004', 'Luisa Ferreira')">
                                <i class="fas fa-star"></i> Avaliar Locatário
                            </a>
                            <a href="#" class="btn btn-info" onclick="viewLocatarioProfile('luisa.ferreira')">
                                <i class="fas fa-user-circle"></i> Ver Perfil
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Avaliação Pendente 2 -->
            <div class="feedback-card" data-category="pendentes">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> Reserva finalizada em: 06/08/2025
                            <span style="color: #ffc107; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-clock"></i> PENDENTE
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-LOC-005</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/mybike2.jpg" alt="Speed Urbana" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/ffc107/000000?text=Avaliar'">
                    <div class="feedback-details">
                        <div class="bike-name">Speed Urbana SP-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Carlos Oliveira (carlos.oliveira@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: 05/08/2025 - 06/08/2025 (2 dias)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Duração: 2 horas</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-bicycle"></i>
                            <span>Estado da devolução: Excelente, muito bem cuidada</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-star"></i>
                            <span>Avaliação recebida do locatário: 5.0/5.0</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-primary" onclick="showFeedbackForm('RSV-LOC-005', 'Carlos Oliveira')">
                                <i class="fas fa-star"></i> Avaliar Locatário
                            </a>
                            <a href="#" class="btn btn-info" onclick="viewLocatarioProfile('carlos.oliveira')">
                                <i class="fas fa-user-circle"></i> Ver Perfil
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Avaliação Já Realizada -->
            <div class="feedback-card" data-category="realizadas">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> Avaliado em: 03/08/2025
                            <span style="color: #28a745; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-check-circle"></i> AVALIADO
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-LOC-003</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/mybike3.jpg" alt="BMX Pro" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/28a745/ffffff?text=Avaliado'">
                    <div class="feedback-details">
                        <div class="bike-name">BMX Pro BX-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Locatário: Pedro Costa (pedro.costa@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: 01/08/2025 - 03/08/2025 (3 dias)</span>
                        </div>
                        <div class="rating-section">
                            <div class="rating-row">
                                <span>Sua Avaliação:</span>
                                <div>
                                    <span class="rating-stars">★★★★★</span>
                                    <span class="rating-value">5.0/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "Locatário exemplar! Muito cuidadoso com a bicicleta, pontual na retirada e devolução, e comunicativo durante todo o processo. Recomendo muito!"
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-success" onclick="inviteAgain('pedro.costa')">
                                <i class="fas fa-redo"></i> Convidar Novamente
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Avaliação Recebida -->
            <div class="feedback-card" data-category="recebidas">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> Recebida em: 05/08/2025
                            <span style="color: #17a2b8; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-inbox"></i> RECEBIDA
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-LOC-004</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/mybike1.jpg" alt="Mountain Explorer" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/17a2b8/ffffff?text=Recebida'">
                    <div class="feedback-details">
                        <div class="bike-name">Mountain Explorer MX-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Avaliado por: Luisa Ferreira</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período da reserva: 02/08/2025 - 04/08/2025</span>
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
                                <span>Avaliação Sua (Como Locador):</span>
                                <div>
                                    <span class="rating-stars">★★★★☆</span>
                                    <span class="rating-value">4.8/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "Bicicleta em excelente estado, muito bem cuidada! O João foi super atencioso, explicou tudo direitinho e foi flexível com os horários. Experiência ótima, só recomendo!"
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-success" onclick="thankForFeedback('luisa.ferreira')">
                                <i class="fas fa-heart"></i> Agradecer
                            </a>
                            <a href="#" class="btn btn-primary" onclick="respondToFeedback('RSV-LOC-004')">
                                <i class="fas fa-reply"></i> Responder
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
    
    <!-- Modal de Avaliação -->
    <div id="feedbackModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000;">
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 2rem; border-radius: 10px; max-width: 600px; width: 90%;">
            <h3 id="modalTitle">Avaliar Locatário</h3>
            <form id="feedbackForm" class="feedback-form">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Avaliação Geral do Locatário:</label>
                        <div class="rating-input">
                            <div class="star-rating" id="userRating">
                                <span class="star" data-rating="1">★</span>
                                <span class="star" data-rating="2">★</span>
                                <span class="star" data-rating="3">★</span>
                                <span class="star" data-rating="4">★</span>
                                <span class="star" data-rating="5">★</span>
                            </div>
                            <span id="userRatingValue">0/5</span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Qualidades do Locatário:</label>
                        <div class="checkbox-group">
                            <div class="checkbox-item">
                                <input type="checkbox" id="pontual" name="qualities" value="pontual">
                                <label for="pontual">Pontual</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="cuidadoso" name="qualities" value="cuidadoso">
                                <label for="cuidadoso">Cuidadoso</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="comunicativo" name="qualities" value="comunicativo">
                                <label for="comunicativo">Comunicativo</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="respeitoso" name="qualities" value="respeitoso">
                                <label for="respeitoso">Respeitoso</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="confiavel" name="qualities" value="confiavel">
                                <label for="confiavel">Confiável</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="organizado" name="qualities" value="organizado">
                                <label for="organizado">Organizado</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="feedbackComment">Comentário sobre o Locatário:</label>
                        <textarea id="feedbackComment" name="comment" placeholder="Descreva sua experiência com este locatário..." rows="4"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="wouldRentAgain">Alugaria novamente para este locatário?</label>
                        <select id="wouldRentAgain" name="rentAgain">
                            <option value="">Selecione</option>
                            <option value="sim">Sim, com certeza</option>
                            <option value="talvez">Talvez, dependendo da situação</option>
                            <option value="nao">Não recomendo</option>
                        </select>
                    </div>
                </div>
                
                <div class="submit-section">
                    <button type="button" onclick="closeFeedbackModal()" style="background: #6c757d; color: white; padding: 0.8rem 2rem; border: none; border-radius: 5px; margin-right: 1rem;">
                        Cancelar
                    </button>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-paper-plane"></i> Enviar Avaliação
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        let currentUserRating = 0;
        
        function filterFeedbacks(category) {
            // Remove active class from all tabs
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Add active class to clicked tab
            event.target.classList.add('active');
            
            // Show/hide feedback cards
            document.querySelectorAll('.feedback-card').forEach(card => {
                if (card.dataset.category === category) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        function showFeedbackForm(reservationId, locatarioName) {
            document.getElementById('modalTitle').textContent = 'Avaliar ' + locatarioName;
            document.getElementById('feedbackModal').style.display = 'block';
            
            // Reset form
            document.getElementById('feedbackForm').reset();
            currentUserRating = 0;
            updateStarRating('userRating', 0);
            document.getElementById('userRatingValue').textContent = '0/5';
        }
        
        function closeFeedbackModal() {
            document.getElementById('feedbackModal').style.display = 'none';
        }
        
        function viewLocatarioProfile(username) {
            alert('Visualizar perfil do locatário: ' + username);
        }
        
        function inviteAgain(username) {
            if (confirm('Convidar ' + username + ' para futuras reservas?')) {
                alert('Convite enviado para: ' + username);
            }
        }
        
        function thankForFeedback(username) {
            if (confirm('Enviar agradecimento para ' + username + '?')) {
                alert('Agradecimento enviado para: ' + username);
            }
        }
        
        function respondToFeedback(reservationId) {
            const response = prompt('Digite sua resposta ao feedback:');
            if (response) {
                alert('Resposta enviada para reserva: ' + reservationId);
            }
        }
        
        // Star rating functionality
        document.getElementById('userRating').addEventListener('click', function(e) {
            if (e.target.classList.contains('star')) {
                currentUserRating = parseInt(e.target.dataset.rating);
                updateStarRating('userRating', currentUserRating);
                document.getElementById('userRatingValue').textContent = currentUserRating + '/5';
            }
        });
        
        function updateStarRating(containerId, rating) {
            const container = document.getElementById(containerId);
            const stars = container.querySelectorAll('.star');
            
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('active');
                } else {
                    star.classList.remove('active');
                }
            });
        }
        
        // Form submission
        document.getElementById('feedbackForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (currentUserRating === 0) {
                alert('Por favor, selecione uma avaliação.');
                return;
            }
            
            const formData = new FormData(this);
            const qualities = Array.from(document.querySelectorAll('input[name="qualities"]:checked')).map(cb => cb.value);
            
            const feedbackData = {
                userRating: currentUserRating,
                qualities: qualities,
                comment: formData.get('comment'),
                wouldRentAgain: formData.get('rentAgain')
            };
            
            console.log('Feedback data:', feedbackData);
            
            alert('Avaliação enviada com sucesso!');
            closeFeedbackModal();
            location.reload();
        });
        
        // Close modal when clicking outside
        document.getElementById('feedbackModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeFeedbackModal();
            }
        });
    </script>
</body>
</html>