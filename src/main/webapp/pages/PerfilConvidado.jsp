<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Perfil do Usuário - ShareBike</title>
    <link rel="stylesheet" href="../assets/css/usuarioDetalhes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .navbar {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .project-name {
            font-size: 1.8rem;
            font-weight: bold;
            color: #212529;
        }

        .back-button {
            background: rgba(255,255,255,0.2);
            color: #212529;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .back-button:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-1px);
        }

        .profile-header {
            background: white;
            border-radius: 20px;
            padding: 3rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
        }

        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin: 0 auto 2rem;
            border: 5px solid #ffc107;
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .user-name {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 0.5rem;
            font-weight: 300;
        }

        .user-type {
            display: inline-block;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .rating-section {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stars {
            display: flex;
            gap: 0.2rem;
        }

        .star {
            color: #ffc107;
            font-size: 1.5rem;
        }

        .star.empty {
            color: #dee2e6;
        }

        .rating-text {
            font-size: 1.2rem;
            color: #6c757d;
            font-weight: 500;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .info-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .info-card h3 {
            color: #333;
            margin-bottom: 1.5rem;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.8rem 0;
            border-bottom: 1px solid #f8f9fa;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #6c757d;
            font-weight: 500;
        }

        .info-value {
            color: #333;
            font-weight: 600;
        }

        .status-badge {
            padding: 0.3rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .status-active {
            background: #d4edda;
            color: #28a745;
        }

        .feedbacks-section {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .feedbacks-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .feedbacks-title {
            font-size: 1.5rem;
            color: #333;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .feedback-item {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid #ffc107;
        }

        .feedback-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .feedback-author {
            font-weight: 600;
            color: #333;
        }

        .feedback-rating {
            display: flex;
            gap: 0.2rem;
        }

        .feedback-text {
            color: #6c757d;
            line-height: 1.6;
        }

        .feedback-date {
            font-size: 0.9rem;
            color: #adb5bd;
            margin-top: 0.5rem;
        }

        .bikes-section {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .bikes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .bike-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .bike-card:hover {
            transform: translateY(-2px);
        }

        .bike-image {
            width: 80px;
            height: 80px;
            background: #ffc107;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 2rem;
            color: white;
        }

        .bike-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .bike-status {
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-disponivel {
            background: #d4edda;
            color: #28a745;
        }

        .status-ocupada {
            background: #f8d7da;
            color: #dc3545;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }

        .empty-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .navbar {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .profile-header {
                padding: 2rem 1rem;
            }
            
            .user-name {
                font-size: 2rem;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .rating-section {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Barra de navegação -->
        <nav class="navbar">
            <div class="navbar-left">
                <span class="project-name">
                    <i class="fas fa-bicycle"></i> ShareBike
                </span>
            </div>
            <div class="navbar-right">
                <a href="gestaoUsuario.jsp" class="back-button">
                    <i class="fas fa-arrow-left"></i> Voltar à Gestão
                </a>
            </div>
        </nav>

        <!-- Cabeçalho do Perfil -->
        <div class="profile-header">
            <img src="https://via.placeholder.com/150x150/28a745/ffffff?text=JS" alt="João Silva" class="profile-image">
            <h1 class="user-name">João Silva</h1>
            <div class="user-type">
                <i class="fas fa-user"></i> Locatário
            </div>
            
            <div class="rating-section">
                <div class="stars">
                    <i class="fas fa-star star"></i>
                    <i class="fas fa-star star"></i>
                    <i class="fas fa-star star"></i>
                    <i class="fas fa-star star"></i>
                    <i class="fas fa-star star empty"></i>
                </div>
                <span class="rating-text">4.2 de 5.0 (18 avaliações)</span>
            </div>
        </div>

        <!-- Grade de Informações -->
        <div class="info-grid">
            <!-- Informações Pessoais -->
            <div class="info-card">
                <h3>
                    <i class="fas fa-user"></i>
                    Informações Pessoais
                </h3>
                <div class="info-item">
                    <span class="info-label">Email:</span>
                    <span class="info-value">joao.silva@email.com</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Telefone:</span>
                    <span class="info-value">(11) 99999-8888</span>
                </div>
                <div class="info-item">
                    <span class="info-label">CPF:</span>
                    <span class="info-value">123.456.789-01</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Data de Nascimento:</span>
                    <span class="info-value">15/03/1990</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Status:</span>
                    <span class="status-badge status-active">Ativo</span>
                </div>
            </div>

            <!-- Endereço -->
            <div class="info-card">
                <h3>
                    <i class="fas fa-map-marker-alt"></i>
                    Endereço
                </h3>
                <div class="info-item">
                    <span class="info-label">CEP:</span>
                    <span class="info-value">01234-567</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Rua:</span>
                    <span class="info-value">Rua das Flores, 123</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Bairro:</span>
                    <span class="info-value">Centro</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Cidade:</span>
                    <span class="info-value">São Paulo</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Estado:</span>
                    <span class="info-value">SP</span>
                </div>
            </div>

            <!-- Estatísticas de Uso -->
            <div class="info-card">
                <h3>
                    <i class="fas fa-chart-bar"></i>
                    Estatísticas
                </h3>
                <div class="info-item">
                    <span class="info-label">Membro desde:</span>
                    <span class="info-value">Janeiro 2023</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Total de Aluguéis:</span>
                    <span class="info-value">47 aluguéis</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Último Aluguel:</span>
                    <span class="info-value">3 dias atrás</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Tempo Total:</span>
                    <span class="info-value">85h 30min</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Reservas Totais:</span>
                    <span class="info-value">23</span>
                </div>
            </div>

            <!-- Permissões -->
            <div class="info-card">
                <h3>
                    <i class="fas fa-shield-alt"></i>
                    Permissões
                </h3>
                <div class="info-item">
                    <span class="info-label">Locatário:</span>
                    <span class="status-badge status-active">Sim</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Locador:</span>
                    <span class="info-value">Não</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Administrador:</span>
                    <span class="info-value">Não</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Verificado:</span>
                    <span class="status-badge status-active">Sim</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Conta Criada:</span>
                    <span class="info-value">15/01/2023</span>
                </div>
            </div>
        </div>

        <!-- Seção de Feedbacks -->
        <div class="feedbacks-section">
            <div class="feedbacks-header">
                <h3 class="feedbacks-title">
                    <i class="fas fa-comments"></i>
                    Feedbacks Recebidos
                </h3>
            </div>

            <div class="feedback-item">
                <div class="feedback-header">
                    <span class="feedback-author">
                        <i class="fas fa-user-circle"></i> Maria Costa
                    </span>
                    <div class="feedback-rating">
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                    </div>
                </div>
                <p class="feedback-text">
                    "Excelente locatário! Muito cuidadoso com a bicicleta e pontual na devolução. 
                    Deixou a bike limpa e em perfeito estado. Recomendo!"
                </p>
                <div class="feedback-date">
                    <i class="fas fa-calendar"></i> 28 de julho de 2025
                </div>
            </div>

            <div class="feedback-item">
                <div class="feedback-header">
                    <span class="feedback-author">
                        <i class="fas fa-user-circle"></i> Pedro Oliveira
                    </span>
                    <div class="feedback-rating">
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star empty"></i>
                    </div>
                </div>
                <p class="feedback-text">
                    "Boa experiência no geral. João foi comunicativo e seguiu todas as instruções. 
                    Pequeno atraso na devolução, mas nada demais."
                </p>
                <div class="feedback-date">
                    <i class="fas fa-calendar"></i> 20 de julho de 2025
                </div>
            </div>

            <div class="feedback-item">
                <div class="feedback-header">
                    <span class="feedback-author">
                        <i class="fas fa-user-circle"></i> Ana Santos
                    </span>
                    <div class="feedback-rating">
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                    </div>
                </div>
                <p class="feedback-text">
                    "Perfeito! Super responsável e respeitoso. A bicicleta foi devolvida 
                    em excelente estado. Definitivamente alugaria novamente para ele."
                </p>
                <div class="feedback-date">
                    <i class="fas fa-calendar"></i> 12 de julho de 2025
                </div>
            </div>

            <div class="feedback-item">
                <div class="feedback-header">
                    <span class="feedback-author">
                        <i class="fas fa-user-circle"></i> Carlos Lima
                    </span>
                    <div class="feedback-rating">
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star"></i>
                        <i class="fas fa-star star empty"></i>
                        <i class="fas fa-star star empty"></i>
                    </div>
                </div>
                <p class="feedback-text">
                    "Experiência ok. João cumpriu o combinado, mas a comunicação poderia ter sido melhor. 
                    Bicicleta foi devolvida no prazo."
                </p>
                <div class="feedback-date">
                    <i class="fas fa-calendar"></i> 5 de julho de 2025
                </div>
            </div>
        </div>
    </div>
</body>
</html>
