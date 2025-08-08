<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes da Bicicleta - ShareBike</title>
    <link rel="stylesheet" href="../assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .bike-details-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .bike-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 2rem;
        }
        
        .bike-image-main {
            width: 300px;
            height: 200px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
        }
        
        .bike-info-main {
            flex: 1;
        }
        
        .bike-title {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }
        
        .bike-subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
            margin-bottom: 1.5rem;
        }
        
        .bike-stats {
            display: flex;
            gap: 2rem;
            margin-top: 1rem;
        }
        
        .stat-item {
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
            padding: 1rem;
            border-radius: 10px;
            backdrop-filter: blur(10px);
        }
        
        .stat-value {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 0.3rem;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        .details-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .details-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .detail-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid #f8f9fa;
        }
        
        .detail-item:last-child {
            border-bottom: none;
        }
        
        .detail-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }
        
        .detail-content {
            flex: 1;
        }
        
        .detail-label {
            font-weight: 500;
            color: #333;
            margin-bottom: 0.3rem;
        }
        
        .detail-value {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .availability-calendar {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        .calendar-day {
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .calendar-day.header {
            background: #f8f9fa;
            color: #6c757d;
            font-weight: 600;
            cursor: default;
        }
        
        .calendar-day.available {
            background: #d4edda;
            color: #155724;
        }
        
        .calendar-day.available:hover {
            background: #c3e6cb;
            transform: scale(1.05);
        }
        
        .calendar-day.unavailable {
            background: #f8d7da;
            color: #721c24;
            cursor: not-allowed;
        }
        
        .calendar-day.reserved {
            background: #fff3cd;
            color: #856404;
            cursor: not-allowed;
        }
        
        .calendar-legend {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .legend-color {
            width: 20px;
            height: 20px;
            border-radius: 3px;
        }
        
        .review-section {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .review-item {
            display: flex;
            gap: 1rem;
            padding: 1.5rem 0;
            border-bottom: 1px solid #f8f9fa;
        }
        
        .review-item:last-child {
            border-bottom: none;
        }
        
        .review-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .review-content {
            flex: 1;
        }
        
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }
        
        .review-author {
            font-weight: 600;
            color: #333;
        }
        
        .review-rating {
            color: #ffc107;
        }
        
        .review-date {
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .review-text {
            color: #555;
            line-height: 1.5;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin: 2rem 0;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        
        @media (max-width: 768px) {
            .bike-header {
                flex-direction: column;
                text-align: center;
            }
            
            .bike-image-main {
                width: 100%;
                max-width: 300px;
            }
            
            .details-grid {
                grid-template-columns: 1fr;
            }
            
            .bike-stats {
                justify-content: center;
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-bicycle"></i> Detalhes da Bicicleta</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocatario.jsp"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasLocatario.jsp"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="<%=request.getContextPath()%>/pages/fazerFeedbackLocatario.jsp"><i class="fas fa-comment-dots"></i> Dar Feedback</a>
            <a href="<%=request.getContextPath()%>/pages/fazerReserva.jsp"><i class="fas fa-calendar-plus"></i> Nova Reserva</a>
            <a href="<%=request.getContextPath()%>/pages/rankingLocatario.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <div class="bike-details-container">
            <!-- Cabeçalho da Bicicleta -->
            <div class="bike-header">
                <img src="../assets/images/bike1.jpg" alt="Trek FX 3 Disc" class="bike-image-main" onerror="this.src='https://via.placeholder.com/300x200/007bff/ffffff?text=Trek+FX+3'">
                <div class="bike-info-main">
                    <div class="bike-title">Trek FX 3 Disc</div>
                    <div class="bike-subtitle">Bicicleta Híbrida de Alta Performance</div>
                    <div class="bike-stats">
                        <div class="stat-item">
                            <div class="stat-value">4.8</div>
                            <div class="stat-label">Avaliação</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">23</div>
                            <div class="stat-label">Avaliações</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">87%</div>
                            <div class="stat-label">Disponibilidade</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Grid de Detalhes -->
            <div class="details-grid">
                <!-- Especificações -->
                <div class="details-section">
                    <h2 class="section-title">
                        <i class="fas fa-cog"></i> Especificações Técnicas
                    </h2>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-bicycle"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Marca e Modelo</div>
                            <div class="detail-value">Trek FX 3 Disc - Modelo 2024</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-palette"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Cor</div>
                            <div class="detail-value">Azul Metalizado</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-arrows-alt-v"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Tamanho do Quadro</div>
                            <div class="detail-value">Médio (17") - Altura 1,65m - 1,80m</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-weight-hanging"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Peso</div>
                            <div class="detail-value">12,8 kg</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-cogs"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Câmbio</div>
                            <div class="detail-value">Shimano Altus 8 velocidades</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-circle"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Freios</div>
                            <div class="detail-value">Freios a disco hidráulicos</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-road"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Pneus</div>
                            <div class="detail-value">700x35c - Ideais para asfalto e trilhas leves</div>
                        </div>
                    </div>
                </div>
                
                <!-- Informações do Locador -->
                <div class="details-section">
                    <h2 class="section-title">
                        <i class="fas fa-user"></i> Informações do Locador
                    </h2>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-user-circle"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Proprietário</div>
                            <div class="detail-value">Carlos Roberto Silva</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Localização</div>
                            <div class="detail-value">Vila Madalena, São Paulo - SP</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Avaliação do Locador</div>
                            <div class="detail-value">4.9/5.0 (156 avaliações)</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Tempo de Resposta</div>
                            <div class="detail-value">Geralmente responde em 2 horas</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Verificação</div>
                            <div class="detail-value">Perfil verificado ✓</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Calendário de Disponibilidade -->
            <div class="availability-calendar">
                <h2 class="section-title">
                    <i class="fas fa-calendar-alt"></i> Disponibilidade (Próximos 30 dias)
                </h2>
                
                <div class="calendar-grid">
                    <!-- Cabeçalhos dos dias -->
                    <div class="calendar-day header">Dom</div>
                    <div class="calendar-day header">Seg</div>
                    <div class="calendar-day header">Ter</div>
                    <div class="calendar-day header">Qua</div>
                    <div class="calendar-day header">Qui</div>
                    <div class="calendar-day header">Sex</div>
                    <div class="calendar-day header">Sáb</div>
                    
                    <!-- Dias do mês (exemplo) -->
                    <div class="calendar-day available">8</div>
                    <div class="calendar-day available">9</div>
                    <div class="calendar-day available">10</div>
                    <div class="calendar-day reserved">11</div>
                    <div class="calendar-day reserved">12</div>
                    <div class="calendar-day available">13</div>
                    <div class="calendar-day available">14</div>
                    <div class="calendar-day available">15</div>
                    <div class="calendar-day available">16</div>
                    <div class="calendar-day unavailable">17</div>
                    <div class="calendar-day unavailable">18</div>
                    <div class="calendar-day available">19</div>
                    <div class="calendar-day available">20</div>
                    <div class="calendar-day available">21</div>
                    <div class="calendar-day available">22</div>
                    <div class="calendar-day reserved">23</div>
                    <div class="calendar-day reserved">24</div>
                    <div class="calendar-day available">25</div>
                    <div class="calendar-day available">26</div>
                    <div class="calendar-day available">27</div>
                    <div class="calendar-day available">28</div>
                    <div class="calendar-day available">29</div>
                    <div class="calendar-day available">30</div>
                    <div class="calendar-day available">31</div>
                    <div class="calendar-day available">1</div>
                    <div class="calendar-day available">2</div>
                    <div class="calendar-day available">3</div>
                    <div class="calendar-day available">4</div>
                    <div class="calendar-day available">5</div>
                    <div class="calendar-day available">6</div>
                    <div class="calendar-day available">7</div>
                </div>
                
                <div class="calendar-legend">
                    <div class="legend-item">
                        <div class="legend-color" style="background: #d4edda;"></div>
                        <span>Disponível</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-color" style="background: #f8d7da;"></div>
                        <span>Indisponível</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-color" style="background: #fff3cd;"></div>
                        <span>Reservado</span>
                    </div>
                </div>
            </div>
            
            <!-- Seção de Avaliações -->
            <div class="review-section">
                <h2 class="section-title">
                    <i class="fas fa-star"></i> Avaliações dos Locatários
                </h2>
                
                <div class="review-item">
                    <div class="review-avatar">MS</div>
                    <div class="review-content">
                        <div class="review-header">
                            <span class="review-author">Maria Santos</span>
                            <div class="review-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>
                        <div class="review-date">Há 3 dias</div>
                        <div class="review-text">
                            "Bicicleta excelente! Muito bem conservada e o Carlos foi super atencioso. A bike é perfeita para pedalar pela cidade, muito confortável e segura. Recomendo!"
                        </div>
                    </div>
                </div>
                
                <div class="review-item">
                    <div class="review-avatar">JS</div>
                    <div class="review-content">
                        <div class="review-header">
                            <span class="review-author">João Silva</span>
                            <div class="review-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                            </div>
                        </div>
                        <div class="review-date">Há 1 semana</div>
                        <div class="review-text">
                            "Ótima experiência! A bicicleta estava em perfeito estado, bem ajustada e limpa. O processo de retirada foi muito fácil e o proprietário foi muito prestativo."
                        </div>
                    </div>
                </div>
                
                <div class="review-item">
                    <div class="review-avatar">PC</div>
                    <div class="review-content">
                        <div class="review-header">
                            <span class="review-author">Pedro Costa</span>
                            <div class="review-rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                            </div>
                        </div>
                        <div class="review-date">Há 2 semanas</div>
                        <div class="review-text">
                            "Muito boa a bicicleta, apenas os freios poderiam estar um pouco mais ajustados. No geral, uma ótima opção para quem quer pedalar pela cidade."
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Botões de Ação -->
            <div class="action-buttons">
                <a href="<%=request.getContextPath()%>/pages/fazerReserva.jsp" class="btn-primary">
                    <i class="fas fa-calendar-plus"></i> Fazer Reserva
                </a>
                <a href="<%=request.getContextPath()%>/pages/bicicletasLocatario.jsp" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Voltar à Busca
                </a>
            </div>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        // Interatividade do calendário
        document.querySelectorAll('.calendar-day.available').forEach(day => {
            day.addEventListener('click', function() {
                // Remove seleção anterior
                document.querySelectorAll('.calendar-day.selected').forEach(selected => {
                    selected.classList.remove('selected');
                });
                
                // Adiciona seleção atual
                this.classList.add('selected');
                this.style.background = '#007bff';
                this.style.color = 'white';
                
                console.log('Data selecionada:', this.textContent);
            });
        });
        
        // Animações de entrada
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.details-section, .availability-calendar, .review-section');
            elements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    element.style.transition = 'all 0.6s ease';
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, index * 200);
            });
        });
    </script>
</body>
</html>
