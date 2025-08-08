<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Avaliar Experiências - Locatário</title>
    <link rel="stylesheet" href="../assets/css/feedback.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <h1><i class="fas fa-comment-dots"></i> Avaliar Minhas Experiências</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="bicicletasLocatario.jsp"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="reservasLocatario.jsp"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="fazerFeedbackLocatario.jsp"><i class="fas fa-comment-dots"></i> Dar Feedback</a>
            <a href="fazerReserva.jsp"><i class="fas fa-calendar-plus"></i> Nova Reserva</a>
            <a href="rankingLocatario.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <!-- Filtros -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterFeedbacks('pendentes')">
                <i class="fas fa-clock"></i> Avaliações Pendentes (2)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('realizadas')">
                <i class="fas fa-check-circle"></i> Já Avaliadas (18)
            </button>
            <button class="filter-tab" onclick="filterFeedbacks('recebidas')">
                <i class="fas fa-star"></i> Avaliações Recebidas (16)
            </button>
        </div>
        
        <!-- Lista de Feedbacks -->
        <div class="feedback-grid">
            <!-- Avaliação Pendente 1 -->
            <div class="feedback-card" data-category="pendentes">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> Reserva finalizada em: 05/08/2025
                            <span style="color: #ffc107; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-clock"></i> PENDENTE AVALIAÇÃO
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-USER-004</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/rent4.jpg" alt="Urbana City" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/ffc107/000000?text=Avaliar'">
                    <div class="feedback-details">
                        <div class="bike-name">Urbana City UB-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: Ana Paula Costa (ana.paula@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: 03/08/2025 - 05/08/2025 (2 dias)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-bicycle"></i>
                            <span>Tipo: Urbana - Estado Excelente</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-battery-full"></i>
                            <span>Experiência: Bicicleta em excelente estado, muito bem conservada</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-primary" onclick="showFeedbackForm('RSV-USER-004', 'Ana Paula', 'Urbana City UB-2024')">
                                <i class="fas fa-star"></i> Avaliar Experiência
                            </a>
                            <a href="#" class="btn btn-info" onclick="viewOwnerProfile('ana.paula')">
                                <i class="fas fa-user-circle"></i> Ver Perfil da Proprietária
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
                            <i class="fas fa-calendar"></i> Reserva finalizada em: 01/08/2025
                            <span style="color: #ffc107; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-clock"></i> PENDENTE AVALIAÇÃO
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-USER-005</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/rent5.jpg" alt="Durban Dobrável" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/ffc107/000000?text=Avaliar'">
                    <div class="feedback-details">
                        <div class="bike-name">Durban Sampa Pro</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: Pedro Costa (pedro.costa@email.com)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: 31/07/2025 - 01/08/2025 (1 dia)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-dollar-sign"></i>
                            <span>Duração: 1 hora</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-compress-alt"></i>
                            <span>Experiência: Bicicleta dobrável prática para transporte urbano</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-primary" onclick="showFeedbackForm('RSV-USER-005', 'Pedro Costa', 'Durban Sampa Pro')">
                                <i class="fas fa-star"></i> Avaliar Experiência
                            </a>
                            <a href="#" class="btn btn-info" onclick="viewOwnerProfile('pedro.costa')">
                                <i class="fas fa-user-circle"></i> Ver Perfil do Proprietário
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
                            <i class="fas fa-calendar"></i> Avaliado em: 05/08/2025
                            <span style="color: #28a745; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-check-circle"></i> AVALIADO
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-USER-003</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/rent3.jpg" alt="Urbana City" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/28a745/ffffff?text=Avaliado'">
                    <div class="feedback-details">
                        <div class="bike-name">Urbana City UB-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: Carlos Oliveira</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: 07/08/2025 - 09/08/2025 (2 dias)</span>
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
                                <span>Avaliação do Proprietário:</span>
                                <div>
                                    <span class="rating-stars">★★★★★</span>
                                    <span class="rating-value">5.0/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "Experiência perfeita! Bicicleta em excelente estado, Carlos foi super atencioso e prestativo. Local de retirada conveniente e tudo ocorreu conforme combinado. Recomendo muito!"
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-info" onclick="editFeedback('RSV-USER-003')">
                                <i class="fas fa-edit"></i> Editar Avaliação
                            </a>
                            <a href="#" class="btn btn-success" onclick="rentAgain('carlos.oliveira')">
                                <i class="fas fa-redo"></i> Alugar Novamente
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
                            <i class="fas fa-calendar"></i> Recebida em: 06/08/2025
                            <span style="color: #17a2b8; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-inbox"></i> AVALIAÇÃO RECEBIDA
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-USER-003</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/rent3.jpg" alt="Urbana City" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/17a2b8/ffffff?text=Recebida'">
                    <div class="feedback-details">
                        <div class="bike-name">Urbana City UB-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Avaliado por: Carlos Oliveira (Proprietário)</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período da reserva: 07/08/2025 - 09/08/2025</span>
                        </div>
                        <div class="rating-section">
                            <div class="rating-row">
                                <span>Avaliação Sua (Como Locatário):</span>
                                <div>
                                    <span class="rating-stars">★★★★★</span>
                                    <span class="rating-value">5.0/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "Locatário exemplar! Muito cuidadoso com a bicicleta, pontual na retirada e devolução. Devolveu a bike em perfeito estado, inclusive mais limpa do que quando entregou. Super recomendo!"
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-check-circle"></i>
                            <span>Qualidades destacadas: Cuidadoso, pontual, respeitoso, confiável</span>
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-success" onclick="thankForFeedback('carlos.oliveira')">
                                <i class="fas fa-heart"></i> Agradecer
                            </a>
                            <a href="#" class="btn btn-primary" onclick="respondToFeedback('RSV-USER-003')">
                                <i class="fas fa-reply"></i> Responder
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Outra Avaliação Realizada com nota menor -->
            <div class="feedback-card" data-category="realizadas">
                <div class="feedback-header">
                    <div class="feedback-info">
                        <div class="feedback-date">
                            <i class="fas fa-calendar"></i> Avaliado em: 02/08/2025
                            <span style="color: #28a745; font-weight: bold; margin-left: 10px;">
                                <i class="fas fa-check-circle"></i> AVALIADO
                            </span>
                        </div>
                        <div class="reservation-id">Reserva: #RSV-USER-002</div>
                    </div>
                </div>
                <div class="feedback-content">
                    <img src="../assets/images/rent2.jpg" alt="Speed Urbana" class="bike-image" onerror="this.src='https://via.placeholder.com/150x120/28a745/ffffff?text=Avaliado'">
                    <div class="feedback-details">
                        <div class="bike-name">Speed Urbana SP-2024</div>
                        <div class="detail-row">
                            <i class="fas fa-user"></i>
                            <span>Proprietário: Maria Santos</span>
                        </div>
                        <div class="detail-row">
                            <i class="fas fa-calendar"></i>
                            <span>Período: 30/07/2025 - 02/08/2025 (3 dias)</span>
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
                                <span>Avaliação do Proprietário:</span>
                                <div>
                                    <span class="rating-stars">★★★★☆</span>
                                    <span class="rating-value">4.0/5.0</span>
                                </div>
                            </div>
                        </div>
                        <div class="feedback-text">
                            "A bicicleta cumpriu o propósito, mas apresentou alguns problemas nas marchas durante o uso. A Maria foi atenciosa e respondeu rapidamente às mensagens, mas a bike poderia estar em melhor estado."
                        </div>
                        <div class="feedback-actions">
                            <a href="#" class="btn btn-info" onclick="editFeedback('RSV-USER-002')">
                                <i class="fas fa-edit"></i> Editar Avaliação
                            </a>
                            <a href="#" class="btn btn-warning" onclick="viewImprovementResponse('RSV-USER-002')">
                                <i class="fas fa-comments"></i> Ver Resposta
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="back-button">
            <a href="Perfil.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar ao Perfil
            </a>
        </div>
    </div>
    
    <!-- Modal de Avaliação -->
    <div id="feedbackModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000;">
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 2rem; border-radius: 10px; max-width: 700px; width: 95%; max-height: 90%; overflow-y: auto;">
            <h3 id="modalTitle">Avaliar Experiência</h3>
            <form id="feedbackForm" class="feedback-form">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Avaliação da Bicicleta:</label>
                        <div class="rating-input">
                            <div class="star-rating" id="bikeRating">
                                <span class="star" data-rating="1">★</span>
                                <span class="star" data-rating="2">★</span>
                                <span class="star" data-rating="3">★</span>
                                <span class="star" data-rating="4">★</span>
                                <span class="star" data-rating="5">★</span>
                            </div>
                            <span id="bikeRatingValue">0/5</span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Avaliação do Proprietário:</label>
                        <div class="rating-input">
                            <div class="star-rating" id="ownerRating">
                                <span class="star" data-rating="1">★</span>
                                <span class="star" data-rating="2">★</span>
                                <span class="star" data-rating="3">★</span>
                                <span class="star" data-rating="4">★</span>
                                <span class="star" data-rating="5">★</span>
                            </div>
                            <span id="ownerRatingValue">0/5</span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Estado da Bicicleta:</label>
                        <div class="checkbox-group">
                            <div class="checkbox-item">
                                <input type="checkbox" id="funcional" name="bikeCondition" value="funcional">
                                <label for="funcional">Funcional</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="limpa" name="bikeCondition" value="limpa">
                                <label for="limpa">Limpa</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="bem_conservada" name="bikeCondition" value="bem_conservada">
                                <label for="bem_conservada">Bem Conservada</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="problemas_leves" name="bikeCondition" value="problemas_leves">
                                <label for="problemas_leves">Pequenos Problemas</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="manutencao" name="bikeCondition" value="manutencao">
                                <label for="manutencao">Precisa Manutenção</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Qualidades do Proprietário:</label>
                        <div class="checkbox-group">
                            <div class="checkbox-item">
                                <input type="checkbox" id="comunicacao_boa" name="ownerQualities" value="comunicacao_boa">
                                <label for="comunicacao_boa">Boa Comunicação</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="pontual_owner" name="ownerQualities" value="pontual">
                                <label for="pontual_owner">Pontual</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="prestativo" name="ownerQualities" value="prestativo">
                                <label for="prestativo">Prestativo</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="flexivel" name="ownerQualities" value="flexivel">
                                <label for="flexivel">Flexível</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="confiavel_owner" name="ownerQualities" value="confiavel">
                                <label for="confiavel_owner">Confiável</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="educado" name="ownerQualities" value="educado">
                                <label for="educado">Educado</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="bikeComment">Comentário sobre a Bicicleta:</label>
                        <textarea id="bikeComment" name="bikeComment" placeholder="Como foi sua experiência com esta bicicleta?" rows="3"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="ownerComment">Comentário sobre o Proprietário:</label>
                        <textarea id="ownerComment" name="ownerComment" placeholder="Como foi o atendimento do proprietário?" rows="3"></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="wouldRentAgain">Alugaria desta pessoa novamente?</label>
                        <select id="wouldRentAgain" name="rentAgain">
                            <option value="">Selecione</option>
                            <option value="sim">Sim, com certeza</option>
                            <option value="talvez">Talvez, dependendo da situação</option>
                            <option value="nao">Não recomendo</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="overallExperience">Experiência Geral:</label>
                        <select id="overallExperience" name="experience">
                            <option value="">Selecione</option>
                            <option value="excelente">Excelente</option>
                            <option value="muito_boa">Muito Boa</option>
                            <option value="boa">Boa</option>
                            <option value="regular">Regular</option>
                            <option value="ruim">Ruim</option>
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
        let currentBikeRating = 0;
        let currentOwnerRating = 0;
        
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
        
        function showFeedbackForm(reservationId, ownerName, bikeName) {
            document.getElementById('modalTitle').textContent = `Avaliar: ${bikeName} - ${ownerName}`;
            document.getElementById('feedbackModal').style.display = 'block';
            
            // Reset form
            document.getElementById('feedbackForm').reset();
            currentBikeRating = 0;
            currentOwnerRating = 0;
            updateStarRating('bikeRating', 0);
            updateStarRating('ownerRating', 0);
            document.getElementById('bikeRatingValue').textContent = '0/5';
            document.getElementById('ownerRatingValue').textContent = '0/5';
        }
        
        function closeFeedbackModal() {
            document.getElementById('feedbackModal').style.display = 'none';
        }
        
        function viewOwnerProfile(username) {
            alert('Visualizar perfil do proprietário: ' + username);
        }
        
        function editFeedback(reservationId) {
            alert('Editar avaliação da reserva: ' + reservationId);
        }
        
        function rentAgain(username) {
            if (confirm('Buscar outras bicicletas de ' + username + '?')) {
                alert('Redirecionando para bicicletas de: ' + username);
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
        
        function viewImprovementResponse(reservationId) {
            alert('Ver resposta de melhoria para reserva: ' + reservationId);
        }
        
        // Star rating functionality
        document.getElementById('bikeRating').addEventListener('click', function(e) {
            if (e.target.classList.contains('star')) {
                currentBikeRating = parseInt(e.target.dataset.rating);
                updateStarRating('bikeRating', currentBikeRating);
                document.getElementById('bikeRatingValue').textContent = currentBikeRating + '/5';
            }
        });
        
        document.getElementById('ownerRating').addEventListener('click', function(e) {
            if (e.target.classList.contains('star')) {
                currentOwnerRating = parseInt(e.target.dataset.rating);
                updateStarRating('ownerRating', currentOwnerRating);
                document.getElementById('ownerRatingValue').textContent = currentOwnerRating + '/5';
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
            
            if (currentBikeRating === 0 || currentOwnerRating === 0) {
                alert('Por favor, avalie tanto a bicicleta quanto o proprietário.');
                return;
            }
            
            const formData = new FormData(this);
            const bikeConditions = Array.from(document.querySelectorAll('input[name="bikeCondition"]:checked')).map(cb => cb.value);
            const ownerQualities = Array.from(document.querySelectorAll('input[name="ownerQualities"]:checked')).map(cb => cb.value);
            
            const feedbackData = {
                bikeRating: currentBikeRating,
                ownerRating: currentOwnerRating,
                bikeConditions: bikeConditions,
                ownerQualities: ownerQualities,
                bikeComment: formData.get('bikeComment'),
                ownerComment: formData.get('ownerComment'),
                wouldRentAgain: formData.get('rentAgain'),
                overallExperience: formData.get('experience')
            };
            
            console.log('Feedback data:', feedbackData);
            
            alert('Avaliação enviada com sucesso! Obrigado pelo seu feedback.');
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