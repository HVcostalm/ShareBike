<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="br.com.sharebike.model.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // Verificar se o usuário está logado
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
        return;
    }
    
    // Recuperar dados da reserva específica
    Reserva reserva = (Reserva) request.getAttribute("reserva");
    if (reserva == null) {
        response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locador");
        return;
    }
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Avaliar Locatário - ShareBike</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/feedback.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            min-height: 100vh;
            padding: 2rem 1rem;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .header h1 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .reservation-info {
            background: #f8f9fa;
            padding: 2rem;
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
            align-items: center;
        }

        .bike-info {
            text-align: center;
        }

        .bike-image {
            width: 150px;
            height: 120px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            margin-bottom: 1rem;
        }

        .bike-name {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .bike-type {
            color: #6c757d;
            font-size: 1rem;
        }

        .reservation-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .detail-icon {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
        }

        .detail-content {
            flex: 1;
        }

        .detail-label {
            font-size: 0.8rem;
            color: #6c757d;
            margin-bottom: 0.2rem;
        }

        .detail-value {
            font-weight: 600;
            color: #333;
        }

        .form-section {
            padding: 2rem;
        }

        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 2rem;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .form-grid {
            display: grid;
            gap: 2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .rating-container {
            background: #f8f9fa;
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            border: 2px solid #e9ecef;
            transition: border-color 0.3s ease;
        }

        .rating-container:hover {
            border-color: #ffc107;
        }

        .star-rating {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .star {
            font-size: 3rem;
            color: #ddd;
            cursor: pointer;
            transition: all 0.3s ease;
            user-select: none;
        }

        .star:hover,
        .star.active {
            color: #ffc107;
            transform: scale(1.1);
        }

        .bike-star {
            font-size: 3rem;
            color: #ddd;
            cursor: pointer;
            transition: all 0.3s ease;
            user-select: none;
        }

        .bike-star:hover,
        .bike-star.active {
            color: #38b2ac;
            transform: scale(1.1);
        }

        .rating-display {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
        }

        .qualities-section {
            background: #f8f9fa;
            padding: 2rem;
            border-radius: 15px;
        }

        .qualities-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .quality-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: white;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .quality-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        .quality-item.selected {
            border-color: #38b2ac;
            background: linear-gradient(135deg, #c8f7f2, #a7f3d0);
        }

        .quality-checkbox {
            display: none;
        }

        .quality-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .quality-content {
            flex: 1;
        }

        .quality-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.3rem;
        }

        .quality-description {
            font-size: 0.9rem;
            color: #6c757d;
        }

        .comment-section {
            background: #f8f9fa;
            padding: 2rem;
            border-radius: 15px;
        }

        .comment-textarea {
            width: 100%;
            min-height: 120px;
            padding: 1rem;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-family: inherit;
            font-size: 1rem;
            resize: vertical;
            transition: border-color 0.3s ease;
        }

        .comment-textarea:focus {
            outline: none;
            border-color: #38b2ac;
        }

        .char-counter {
            text-align: right;
            margin-top: 0.5rem;
            font-size: 0.9rem;
            color: #6c757d;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            padding: 2rem;
            background: #f8f9fa;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-cancel {
            background: #6c757d;
            color: white;
        }

        .btn-cancel:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .btn-submit {
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(56, 178, 172, 0.3);
        }        .btn-submit:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
        }

        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid transparent;
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            border: 1px solid #f5c6cb;
        }

        .success-message {
            background: #c8f7f2;
            color: #047857;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            border: 1px solid #a7f3d0;
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                border-radius: 15px;
            }

            .reservation-info {
                grid-template-columns: 1fr;
                gap: 1rem;
                text-align: center;
            }

            .reservation-details {
                grid-template-columns: 1fr;
            }

            .qualities-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .star {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-star"></i> Avaliar Locatário</h1>
            <p>Compartilhe sua experiência com <%= reserva.getUsuario().getNomeRazaoSocial_user() %></p>
        </div>

        <!-- Informações da Reserva -->
        <div class="reservation-info">
            <div class="bike-info">
                <img src="<%= request.getContextPath() %>/assets/images/bike-placeholder.jpg" 
                     alt="<%= reserva.getBicicleta().getNome_bike() %>" 
                     class="bike-image"
                     onerror="this.src='https://via.placeholder.com/150x120/38b2ac/ffffff?text=Bike'">
                <div class="bike-name"><%= reserva.getBicicleta().getNome_bike() %></div>
                <div class="bike-type"><%= reserva.getBicicleta().getTipo_bike() %></div>
            </div>

            <div class="reservation-details">
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Locatário</div>
                        <div class="detail-value"><%= reserva.getUsuario().getNomeRazaoSocial_user() %></div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Contato</div>
                        <div class="detail-value"><%= reserva.getUsuario().getEmail_user() %></div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-calendar"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Check-in</div>
                        <div class="detail-value"><%= reserva.getDataCheckIn_reserv().format(formatter) %></div>
                    </div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Check-out</div>
                        <div class="detail-value"><%= reserva.getDataCheckOut_reserv().format(formatter) %></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Formulário de Avaliação -->
        <form action="<%= request.getContextPath() %>/FeedbackController" method="post" id="avaliacaoForm" accept-charset="UTF-8">
            <input type="hidden" name="action" value="adicionar-locador">
            <input type="hidden" name="id_reserv" value="<%= reserva.getId_reserv() %>">
            <input type="hidden" name="cpfCnpjAvaliado" value="<%= reserva.getUsuario().getCpfCnpj_user() %>">
            <input type="hidden" name="avaliacaoUser" id="avaliacaoUser" value="0">
            <input type="hidden" name="avaliacaoBike" id="avaliacaoBike" value="0">

            <div class="form-section">
                <div class="section-title">
                    <i class="fas fa-star"></i>
                    Avaliação Geral
                </div>

                <div class="form-group">
                    <label>Como foi sua experiência com este locatário?</label>
                    <div class="rating-container">
                        <div class="star-rating" id="starRating">
                            <span class="star" data-rating="1">★</span>
                            <span class="star" data-rating="2">★</span>
                            <span class="star" data-rating="3">★</span>
                            <span class="star" data-rating="4">★</span>
                            <span class="star" data-rating="5">★</span>
                        </div>
                        <div class="rating-display" id="ratingDisplay">Clique nas estrelas para avaliar</div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <div class="section-title">
                    <i class="fas fa-bicycle"></i>
                    Estado da Bicicleta
                </div>

                <div class="form-group">
                    <label>Como a bicicleta foi devolvida?</label>
                    <div class="rating-container">
                        <div class="star-rating" id="bikeStarRating">
                            <span class="bike-star" data-rating="1">★</span>
                            <span class="bike-star" data-rating="2">★</span>
                            <span class="bike-star" data-rating="3">★</span>
                            <span class="bike-star" data-rating="4">★</span>
                            <span class="bike-star" data-rating="5">★</span>
                        </div>
                        <div class="rating-display" id="bikeRatingDisplay">Clique nas estrelas para avaliar o estado da bicicleta</div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <div class="section-title">
                    <i class="fas fa-check-circle"></i>
                    Qualidades do Locatário
                </div>

                <div class="form-group">
                    <label>Quais qualidades você destacaria?</label>
                    <div class="qualities-section">
                        <div class="qualities-grid">
                            <div class="quality-item" onclick="toggleQuality('confComp')">
                                <input type="checkbox" id="confComp" name="confComp" value="1" class="quality-checkbox">
                                <div class="quality-icon">
                                    <i class="fas fa-handshake"></i>
                                </div>
                                <div class="quality-content">
                                    <div class="quality-title">Compartilhamento Confortável</div>
                                    <div class="quality-description">Fácil de lidar e respeitoso</div>
                                </div>
                            </div>

                            <div class="quality-item" onclick="toggleQuality('comunicBoa')">
                                <input type="checkbox" id="comunicBoa" name="comunicBoa" value="1" class="quality-checkbox">
                                <div class="quality-icon">
                                    <i class="fas fa-comments"></i>
                                </div>
                                <div class="quality-content">
                                    <div class="quality-title">Boa Comunicação</div>
                                    <div class="quality-description">Claro e responsivo nas mensagens</div>
                                </div>
                            </div>

                            <div class="quality-item" onclick="toggleQuality('funcional')">
                                <input type="checkbox" id="funcional" name="funcional" value="1" class="quality-checkbox">
                                <div class="quality-icon">
                                    <i class="fas fa-cogs"></i>
                                </div>
                                <div class="quality-content">
                                    <div class="quality-title">Funcional</div>
                                    <div class="quality-description">Prático e eficiente</div>
                                </div>
                            </div>

                            <div class="quality-item" onclick="toggleQuality('manutencao')">
                                <input type="checkbox" id="manutencao" name="manutencao" value="1" class="quality-checkbox">
                                <div class="quality-icon">
                                    <i class="fas fa-tools"></i>
                                </div>
                                <div class="quality-content">
                                    <div class="quality-title">Cuidadoso</div>
                                    <div class="quality-description">Cuidou bem da bicicleta</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <div class="section-title">
                    <i class="fas fa-wrench"></i>
                    Comentário sobre a Bicicleta
                </div>

                <div class="form-group">
                    <label for="obsBike">Como a bicicleta foi devolvida? Houve algum problema?</label>
                    <div class="comment-section">
                        <textarea 
                            id="obsBike" 
                            name="obsBike" 
                            class="comment-textarea"
                            placeholder="Descreva o estado da bicicleta após o uso: funcionamento, limpeza, danos, etc..."
                            maxlength="300"
                            oninput="updateBikeCharCounter()"></textarea>
                        <div class="char-counter">
                            <span id="bikeCharCount">0</span>/300 caracteres
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <div class="section-title">
                    <i class="fas fa-comment"></i>
                    Comentário sobre o Locatário
                </div>

                <div class="form-group">
                    <label for="obsUser">Deixe um comentário sobre sua experiência:</label>
                    <div class="comment-section">
                        <textarea 
                            id="obsUser" 
                            name="obsUser" 
                            class="comment-textarea"
                            placeholder="Conte-nos mais sobre sua experiência com este locatário..."
                            maxlength="500"
                            oninput="updateCharCounter()"></textarea>
                        <div class="char-counter">
                            <span id="charCount">0</span>/500 caracteres
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <a href="<%= request.getContextPath() %>/FeedbackController?action=pagina-locador" class="btn btn-cancel">
                    <i class="fas fa-times"></i>
                    Cancelar
                </a>
                <button type="submit" class="btn btn-submit" id="submitBtn" disabled>
                    <div class="loading-spinner" id="loadingSpinner"></div>
                    <span id="submitText">
                        <i class="fas fa-paper-plane"></i>
                        Enviar Avaliação
                    </span>
                </button>
            </div>
        </form>
    </div>

    <script>
        let currentRating = 0;
        let currentBikeRating = 0;

        // Funcionalidade das estrelas do usuário
        document.addEventListener('DOMContentLoaded', function() {
            const stars = document.querySelectorAll('.star');
            const bikeStars = document.querySelectorAll('.bike-star');
            
            // Inicializar os displays
            updateRatingDisplay();
            updateBikeRatingDisplay();
            updateSubmitButton();
            
            // Estrelas para avaliação do usuário
            stars.forEach(star => {
                star.addEventListener('click', function() {
                    currentRating = parseInt(this.dataset.rating);
                    updateStars();
                    updateRatingDisplay();
                    updateSubmitButton();
                    document.getElementById('avaliacaoUser').value = currentRating;
                });

                star.addEventListener('mouseenter', function() {
                    const hoverRating = parseInt(this.dataset.rating);
                    highlightStars(hoverRating);
                });
            });

            document.getElementById('starRating').addEventListener('mouseleave', function() {
                updateStars();
            });

            // Estrelas para avaliação da bicicleta
            bikeStars.forEach(star => {
                star.addEventListener('click', function() {
                    currentBikeRating = parseInt(this.dataset.rating);
                    updateBikeStars();
                    updateBikeRatingDisplay();
                    updateSubmitButton();
                    document.getElementById('avaliacaoBike').value = currentBikeRating;
                });

                star.addEventListener('mouseenter', function() {
                    const hoverRating = parseInt(this.dataset.rating);
                    highlightBikeStars(hoverRating);
                });
            });

            document.getElementById('bikeStarRating').addEventListener('mouseleave', function() {
                updateBikeStars();
            });
        });

        function updateStars() {
            const stars = document.querySelectorAll('.star');
            stars.forEach((star, index) => {
                if (index < currentRating) {
                    star.classList.add('active');
                } else {
                    star.classList.remove('active');
                }
            });
        }

        function highlightStars(rating) {
            const stars = document.querySelectorAll('.star');
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('active');
                } else {
                    star.classList.remove('active');
                }
            });
        }

        function updateRatingDisplay() {
            const display = document.getElementById('ratingDisplay');
            if (currentRating === 0) {
                display.textContent = 'Clique nas estrelas para avaliar';
            } else {
                const ratingText = ['', 'Péssimo', 'Ruim', 'Regular', 'Bom', 'Excelente'];
                display.textContent = currentRating + '/5 - ' + ratingText[currentRating];
            }
        }

        // Funcionalidade das estrelas da bicicleta
        function updateBikeStars() {
            const stars = document.querySelectorAll('.bike-star');
            stars.forEach((star, index) => {
                if (index < currentBikeRating) {
                    star.classList.add('active');
                } else {
                    star.classList.remove('active');
                }
            });
        }

        function highlightBikeStars(rating) {
            const stars = document.querySelectorAll('.bike-star');
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('active');
                } else {
                    star.classList.remove('active');
                }
            });
        }

        function updateBikeRatingDisplay() {
            const display = document.getElementById('bikeRatingDisplay');
            if (currentBikeRating === 0) {
                display.textContent = 'Clique nas estrelas para avaliar o estado da bicicleta';
            } else {
                const ratingText = ['', 'Péssimo estado', 'Estado ruim', 'Estado regular', 'Bom estado', 'Excelente estado'];
                display.textContent = currentBikeRating + '/5 - ' + ratingText[currentBikeRating];
            }
        }

        function updateSubmitButton() {
            const submitBtn = document.getElementById('submitBtn');
            // Agora precisa avaliar tanto o usuário quanto a bicicleta
            submitBtn.disabled = currentRating === 0 || currentBikeRating === 0;
        }

        // Funcionalidade das qualidades
        function toggleQuality(qualityId) {
            const checkbox = document.getElementById(qualityId);
            const qualityItem = checkbox.closest('.quality-item');
            
            checkbox.checked = !checkbox.checked;
            
            if (checkbox.checked) {
                qualityItem.classList.add('selected');
            } else {
                qualityItem.classList.remove('selected');
            }
        }

        // Contador de caracteres
        function updateCharCounter() {
            const textarea = document.getElementById('obsUser');
            const charCount = document.getElementById('charCount');
            charCount.textContent = textarea.value.length;
        }

        // Contador de caracteres da bicicleta
        function updateBikeCharCounter() {
            const textarea = document.getElementById('obsBike');
            const charCount = document.getElementById('bikeCharCount');
            charCount.textContent = textarea.value.length;
        }

        // Validação e submissão do formulário
        document.getElementById('avaliacaoForm').addEventListener('submit', function(e) {
            if (currentRating === 0) {
                e.preventDefault();
                alert('Por favor, selecione uma avaliação de 1 a 5 estrelas para o locatário.');
                return;
            }

            if (currentBikeRating === 0) {
                e.preventDefault();
                alert('Por favor, selecione uma avaliação de 1 a 5 estrelas para o estado da bicicleta.');
                return;
            }

            // Mostrar loading
            const submitBtn = document.getElementById('submitBtn');
            const loadingSpinner = document.getElementById('loadingSpinner');
            const submitText = document.getElementById('submitText');
            
            submitBtn.disabled = true;
            loadingSpinner.style.display = 'block';
            submitText.style.display = 'none';
        });

        // Animações de entrada
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.querySelector('.container');
            container.style.opacity = '0';
            container.style.transform = 'translateY(30px)';
            
            setTimeout(() => {
                container.style.transition = 'all 0.6s ease';
                container.style.opacity = '1';
                container.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>