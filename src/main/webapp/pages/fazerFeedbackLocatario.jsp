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
        response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locatario");
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
    <title>Avaliar Experiência - ShareBike</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/feedback.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            color: white;
            text-align: center;
            padding: 2rem 0;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }
        
        header h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: 300;
        }
        
        .container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        
        .feedback-form {
            background: white;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        
        .reservation-info {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 3rem;
            border-left: 5px solid #38b2ac;
        }
        
        .reservation-info h3 {
            color: #495057;
            margin-bottom: 1.5rem;
            font-size: 1.3rem;
        }
        
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-top: 1rem;
        }
        
        .detail-grid div {
            background: white;
            padding: 1rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .detail-grid strong {
            color: #38b2ac;
            display: block;
            margin-bottom: 0.5rem;
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
            margin-bottom: 1rem;
            color: #495057;
            font-size: 1.1rem;
        }
        
        .rating-input {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .star-rating {
            display: flex;
            gap: 0.5rem;
        }
        
        .star {
            cursor: pointer;
            color: #ddd;
            font-size: 2rem;
            transition: all 0.3s ease;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .star:hover,
        .star.active {
            color: #ffc107;
            transform: scale(1.1);
        }
        
        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .checkbox-item:hover {
            background: #e9ecef;
        }
        
        .checkbox-item input[type="checkbox"] {
            width: 20px;
            height: 20px;
            accent-color: #38b2ac;
        }
        
        .checkbox-item label {
            margin: 0;
            cursor: pointer;
            font-weight: 500;
        }
        
        textarea {
            padding: 1.2rem;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            resize: vertical;
            font-family: inherit;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }
        
        textarea:focus {
            outline: none;
            border-color: #38b2ac;
            box-shadow: 0 0 0 3px rgba(56, 178, 172, 0.1);
        }
        
        .submit-section {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 2px solid #e9ecef;
        }
        
        .btn {
            padding: 1rem 2.5rem;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(56, 178, 172, 0.3);
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #0d9488 0%, #047857 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(56, 178, 172, 0.4);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
            box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
        }
        
        .btn-secondary:hover {
            background: #545b62;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
        }
        
        .rating-value {
            font-weight: bold;
            color: #38b2ac;
            font-size: 1.2rem;
            padding: 0.5rem 1rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        footer {
            text-align: center;
            padding: 2rem;
            color: white;
            background: rgba(0, 0, 0, 0.1);
            margin-top: 3rem;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 0 1rem;
            }
            
            .feedback-form {
                padding: 2rem 1.5rem;
            }
            
            .detail-grid {
                grid-template-columns: 1fr;
            }
            
            .submit-section {
                flex-direction: column;
            }
            
            .btn {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-star"></i> Avaliar Experiência de Aluguel</h1>
    </header>
    
    <div class="container">
        <!-- Informações da Reserva -->
        <div class="reservation-info">
            <h3><i class="fas fa-info-circle"></i> Detalhes da Reserva</h3>
            <div class="detail-grid">
                <div>
                    <strong><i class="fas fa-bicycle"></i> Bicicleta:</strong>
                    <%= reserva.getBicicleta().getTipo_bike() %> - <%= reserva.getBicicleta().getNome_bike() %>
                </div>
                <div>
                    <strong><i class="fas fa-user"></i> Proprietário:</strong>
                    <%= reserva.getBicicleta().getUsuario().getNomeRazaoSocial_user() %>
                </div>
                <div>
                    <strong><i class="fas fa-calendar"></i> Período:</strong>
                    <%= reserva.getDataCheckIn_reserv().format(formatter) %> - <%= reserva.getDataCheckOut_reserv().format(formatter) %>
                </div>
                <div>
                    <strong><i class="fas fa-hashtag"></i> Reserva:</strong>
                    #<%= reserva.getId_reserv() %>
                </div>
            </div>
        </div>
        
        <!-- Formulário de Avaliação -->
        <form class="feedback-form" action="<%=request.getContextPath()%>/FeedbackController" method="post" accept-charset="UTF-8">
            <input type="hidden" name="action" value="adicionar-locatario">
            <input type="hidden" name="id_reserv" value="<%= reserva.getId_reserv() %>">
            <input type="hidden" name="cpfCnpjAvaliado" value="<%= reserva.getBicicleta().getUsuario().getCpfCnpj_user() %>">
            <input type="hidden" name="avaliacaoBike" id="avaliacao_bike_hidden" value="0">
            <input type="hidden" name="avaliacaoUser" id="avaliacao_user_hidden" value="0">
            
            <h3><i class="fas fa-comment-dots"></i> Sua Avaliação</h3>
            
            <div class="form-grid">
                <!-- Avaliação da Bicicleta -->
                <div class="form-group">
                    <label><i class="fas fa-bicycle"></i> Como você avalia esta bicicleta?</label>
                    <div class="rating-input">
                        <div class="star-rating" id="bikeRating">
                            <span class="star" data-rating="1">★</span>
                            <span class="star" data-rating="2">★</span>
                            <span class="star" data-rating="3">★</span>
                            <span class="star" data-rating="4">★</span>
                            <span class="star" data-rating="5">★</span>
                        </div>
                        <span id="bikeRatingValue" class="rating-value">0/5</span>
                    </div>
                </div>
                
                <!-- Avaliação do Proprietário -->
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Como você avalia o proprietário?</label>
                    <div class="rating-input">
                        <div class="star-rating" id="ownerRating">
                            <span class="star" data-rating="1">★</span>
                            <span class="star" data-rating="2">★</span>
                            <span class="star" data-rating="3">★</span>
                            <span class="star" data-rating="4">★</span>
                            <span class="star" data-rating="5">★</span>
                        </div>
                        <span id="ownerRatingValue" class="rating-value">0/5</span>
                    </div>
                </div>
                
                <!-- Estado da Bicicleta -->
                <div class="form-group">
                    <label><i class="fas fa-cogs"></i> Como estava o estado da bicicleta?</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" name="funcional" id="funcional">
                            <label for="funcional">Totalmente Funcional</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="manutencao" id="manutencao">
                            <label for="manutencao">Bem Conservada</label>
                        </div>
                    </div>
                </div>
                
                <!-- Qualidades do Proprietário -->
                <div class="form-group">
                    <label><i class="fas fa-handshake"></i> Quais qualidades destacar no proprietário?</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" name="confComp" id="confComp">
                            <label for="confComp">Compartilhamento Confortável</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" name="comunicBoa" id="comunicBoa">
                            <label for="comunicBoa">Boa Comunicação</label>
                        </div>
                    </div>
                </div>
                
                <!-- Comentário sobre a Bicicleta -->
                <div class="form-group">
                    <label for="obsBike"><i class="fas fa-comment"></i> Conte como foi sua experiência com a bicicleta:</label>
                    <textarea id="obsBike" name="obsBike" placeholder="Descreva como foi pedalar com esta bicicleta, se atendeu suas expectativas, se houve algum problema... (opcional)" rows="4"></textarea>
                </div>
                
                <!-- Comentário sobre o Proprietário -->
                <div class="form-group">
                    <label for="obsUser"><i class="fas fa-comment-alt"></i> Como foi o atendimento do proprietário?</label>
                    <textarea id="obsUser" name="obsUser" placeholder="Conte como foi a comunicação, a pontualidade, a cordialidade do proprietário... (opcional)" rows="4"></textarea>
                </div>
            </div>
            
            <!-- Botões de Ação -->
            <div class="submit-section">
                <a href="<%=request.getContextPath()%>/FeedbackController?action=pagina-locatario" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Cancelar
                </a>
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <i class="fas fa-paper-plane"></i> Enviar Avaliação
                </button>
            </div>
        </form>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Avalie com sinceridade e ajude nossa comunidade a crescer!</p>
    </footer>
    
    <script>
        let currentBikeRating = 0;
        let currentOwnerRating = 0;
        
        // Inicializar as estrelas
        document.addEventListener('DOMContentLoaded', function() {
            // As estrelas já existem no HTML, não precisamos criá-las
            // Apenas inicializar os eventos
        });
        
        // Funcionalidade das estrelas para avaliação da bicicleta
        document.getElementById('bikeRating').addEventListener('click', function(e) {
            if (e.target.classList.contains('star')) {
                currentBikeRating = parseInt(e.target.dataset.rating);
                updateStarRating('bikeRating', currentBikeRating);
                document.getElementById('bikeRatingValue').textContent = currentBikeRating + '/5';
                document.getElementById('avaliacao_bike_hidden').value = currentBikeRating;
            }
        });
        
        // Funcionalidade das estrelas para avaliação do proprietário
        document.getElementById('ownerRating').addEventListener('click', function(e) {
            if (e.target.classList.contains('star')) {
                currentOwnerRating = parseInt(e.target.dataset.rating);
                updateStarRating('ownerRating', currentOwnerRating);
                document.getElementById('ownerRatingValue').textContent = currentOwnerRating + '/5';
                document.getElementById('avaliacao_user_hidden').value = currentOwnerRating;
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
        
        // Validação do formulário
        document.querySelector('form').addEventListener('submit', function(e) {
            if (currentBikeRating === 0 || currentOwnerRating === 0) {
                e.preventDefault();
                alert('⭐ Por favor, avalie tanto a bicicleta quanto o proprietário antes de enviar!');
                return false;
            }
            
            // Confirmar envio
            if (!confirm('🚀 Deseja enviar esta avaliação?\n\nSua opinião é muito importante para nossa comunidade!')) {
                e.preventDefault();
                return false;
            }
            
            // Mostrar mensagem de envio
            document.getElementById('submitBtn').innerHTML = '<i class="fas fa-spinner fa-spin"></i> Enviando...';
            document.getElementById('submitBtn').disabled = true;
            
            return true;
        });
        
        // Hover effect nas estrelas
        document.querySelectorAll('.star-rating').forEach(rating => {
            rating.addEventListener('mouseover', function(e) {
                if (e.target.classList.contains('star')) {
                    const hoverRating = parseInt(e.target.dataset.rating);
                    const stars = this.querySelectorAll('.star');
                    
                    stars.forEach((star, index) => {
                        if (index < hoverRating) {
                            star.style.color = '#ffc107';
                        } else {
                            star.style.color = '#ddd';
                        }
                    });
                }
            });
            
            rating.addEventListener('mouseleave', function() {
                const containerId = this.id;
                let currentRating = 0;
                
                if (containerId === 'bikeRating') {
                    currentRating = currentBikeRating;
                } else if (containerId === 'ownerRating') {
                    currentRating = currentOwnerRating;
                }
                
                updateStarRating(containerId, currentRating);
            });
        });
        
        // Animação suave nos checkboxes
        document.querySelectorAll('.checkbox-item').forEach(item => {
            item.addEventListener('click', function() {
                const checkbox = this.querySelector('input[type="checkbox"]');
                checkbox.checked = !checkbox.checked;
                
                if (checkbox.checked) {
                    this.style.background = '#c8f7f2';
                    this.style.borderLeft = '4px solid #38b2ac';
                } else {
                    this.style.background = '#f8f9fa';
                    this.style.borderLeft = 'none';
                }
            });
        });
        
        // Contador de caracteres para os textareas
        document.querySelectorAll('textarea').forEach(textarea => {
            const maxLength = 500;
            
            textarea.addEventListener('input', function() {
                const remaining = maxLength - this.value.length;
                if (remaining < 50) {
                    this.style.borderColor = remaining < 0 ? '#dc3545' : '#ffc107';
                } else {
                    this.style.borderColor = '#e9ecef';
                }
            });
        });
        
        // Mensagens de dica para as estrelas
        const starTips = {
            1: 'Muito ruim',
            2: 'Ruim', 
            3: 'Regular',
            4: 'Bom',
            5: 'Excelente'
        };
        
        document.querySelectorAll('.star').forEach(star => {
            star.addEventListener('mouseenter', function() {
                const rating = this.dataset.rating;
                const tip = starTips[rating];
                this.title = tip;
            });
        });
    </script>
</body>
</html>
