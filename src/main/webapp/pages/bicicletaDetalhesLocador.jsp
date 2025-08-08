<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes da Bicicleta - Locador</title>
    <link rel="stylesheet" href="../assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .bike-details-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .bike-header {
            background: linear-gradient(135deg, #28a745, #20c997);
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
        
        .bike-status {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255, 255, 255, 0.2);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
            margin-bottom: 1rem;
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
        
        .management-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }
        
        .action-btn {
            background: rgba(255, 255, 255, 0.9);
            color: #28a745;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .action-btn:hover {
            background: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
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
            background: linear-gradient(135deg, #28a745, #20c997);
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
        
        .edit-icon {
            color: #007bff;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 50%;
            transition: all 0.3s ease;
        }
        
        .edit-icon:hover {
            background: #f8f9fa;
            color: #0056b3;
        }
        
        .performance-metrics {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 1rem;
        }
        
        .metric-card {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
        }
        
        .metric-value {
            font-size: 2rem;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 0.5rem;
        }
        
        .metric-label {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .metric-change {
            font-size: 0.8rem;
            margin-top: 0.5rem;
        }
        
        .metric-change.positive {
            color: #28a745;
        }
        
        .metric-change.negative {
            color: #dc3545;
        }
        
        .availability-calendar {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
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
            cursor: default;
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
        
        .recent-bookings {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .booking-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            border-bottom: 1px solid #f8f9fa;
            transition: background 0.3s ease;
        }
        
        .booking-item:hover {
            background: #f8f9fa;
        }
        
        .booking-item:last-child {
            border-bottom: none;
        }
        
        .booking-avatar {
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
        
        .booking-details {
            flex: 1;
        }
        
        .booking-customer {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.3rem;
        }
        
        .booking-period {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .booking-status {
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .booking-status.active {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .booking-status.completed {
            background: #d4edda;
            color: #155724;
        }
        
        .booking-status.upcoming {
            background: #fff3cd;
            color: #856404;
        }
        
        .main-action-buttons {
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
        
        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
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
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(40, 167, 69, 0.3);
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
            
            .management-actions {
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .main-action-buttons {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-bicycle"></i> Gerenciar Bicicleta</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocador.jsp"><i class="fas fa-bicycle"></i> Minhas Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasLocador.jsp"><i class="fas fa-calendar-check"></i> Gerenciar Reservas</a>
            <a href="<%=request.getContextPath()%>/pages/fazerFeedbackLocador.jsp"><i class="fas fa-comment-dots"></i> Avaliar Locatários</a>
            <a href="<%=request.getContextPath()%>/pages/dashboardBikes.jsp"><i class="fas fa-chart-bar"></i> Dashboard</a>
        </nav>
        
        <div class="bike-details-container">
            <!-- Cabeçalho da Bicicleta -->
            <div class="bike-header">
                <img src="../assets/images/bike1.jpg" alt="Trek FX 3 Disc" class="bike-image-main" onerror="this.src='https://via.placeholder.com/300x200/28a745/ffffff?text=Trek+FX+3'">
                <div class="bike-info-main">
                    <div class="bike-title">Trek FX 3 Disc</div>
                    <div class="bike-subtitle">Bicicleta Híbrida de Alta Performance</div>
                    <div class="bike-status">
                        <i class="fas fa-check-circle"></i>
                        Ativa e Disponível
                    </div>
                    <div class="bike-stats">
                        <div class="stat-item">
                            <div class="stat-value">4.8</div>
                            <div class="stat-label">Avaliação</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">23</div>
                            <div class="stat-label">Reservas</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">87%</div>
                            <div class="stat-label">Ocupação</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">47</div>
                            <div class="stat-label">Aluguéis</div>
                        </div>
                    </div>
                    <div class="management-actions">
                        <a href="<%=request.getContextPath()%>/pages/editarBicicleta.jsp" class="action-btn">
                            <i class="fas fa-edit"></i> Editar Detalhes
                        </a>
                        <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp" class="action-btn">
                            <i class="fas fa-calendar-alt"></i> Gerenciar Disponibilidade
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Métricas de Performance -->
            <div class="performance-metrics">
                <h2 class="section-title">
                    <i class="fas fa-chart-line"></i> Métricas de Performance
                </h2>
                <div class="metrics-grid">
                    <div class="metric-card">
                        <div class="metric-value">87%</div>
                        <div class="metric-label">Taxa de Ocupação</div>
                        <div class="metric-change positive">+15% este mês</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value">23</div>
                        <div class="metric-label">Total de Reservas</div>
                        <div class="metric-change positive">+3 novas</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value">87%</div>
                        <div class="metric-label">Taxa de Ocupação</div>
                        <div class="metric-change positive">+5% vs. média</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value">4.8</div>
                        <div class="metric-label">Avaliação Média</div>
                        <div class="metric-change positive">+0.2 pontos</div>
                    </div>
                </div>
            </div>
            
            <!-- Grid de Detalhes -->
            <div class="details-grid">
                <!-- Especificações -->
                <div class="details-section">
                    <h2 class="section-title">
                        <i class="fas fa-cog"></i> Especificações Técnicas
                        <i class="fas fa-edit edit-icon" onclick="window.location.href='<%=request.getContextPath()%>/pages/editarBicicleta.jsp'" title="Editar especificações"></i>
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
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Data de Cadastro</div>
                            <div class="detail-value">15 de Janeiro de 2024</div>
                        </div>
                    </div>
                </div>
                
                <!-- Configurações de Aluguel -->
                <div class="details-section">
                    <h2 class="section-title">
                        <i class="fas fa-dollar-sign"></i> Configurações de Aluguel
                        <i class="fas fa-edit edit-icon" onclick="window.location.href='<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp'" title="Editar configurações"></i>
                    </h2>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-tag"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Disponibilidade</div>
                            <div class="detail-value">Disponível</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-percentage"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Desconto Semanal</div>
                            <div class="detail-value">15% (7+ dias)</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Período Mínimo</div>
                            <div class="detail-value">1 dia</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-calendar-week"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Período Máximo</div>
                            <div class="detail-value">30 dias</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Local de Retirada</div>
                            <div class="detail-value">Vila Madalena, São Paulo - SP</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Política de Cancelamento</div>
                            <div class="detail-value">Flexível (até 24h antes)</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-tools"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Última Manutenção</div>
                            <div class="detail-value">5 de Agosto de 2025</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Calendário de Disponibilidade -->
            <div class="availability-calendar">
                <div class="calendar-header">
                    <h2 class="section-title">
                        <i class="fas fa-calendar-alt"></i> Disponibilidade (Próximos 30 dias)
                    </h2>
                    <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp" class="btn-primary" style="font-size: 0.9rem; padding: 0.5rem 1rem;">
                        <i class="fas fa-cog"></i> Gerenciar
                    </a>
                </div>
                
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
            
            <!-- Reservas Recentes -->
            <div class="recent-bookings">
                <h2 class="section-title">
                    <i class="fas fa-calendar-check"></i> Reservas Recentes
                </h2>
                
                <div class="booking-item">
                    <div class="booking-avatar">MS</div>
                    <div class="booking-details">
                        <div class="booking-customer">Maria Santos</div>
                        <div class="booking-period">11-12 de Agosto • 2 dias</div>
                    </div>
                    <div class="booking-status upcoming">Confirmada</div>
                </div>
                
                <div class="booking-item">
                    <div class="booking-avatar">JS</div>
                    <div class="booking-details">
                        <div class="booking-customer">João Silva</div>
                        <div class="booking-period">5-7 de Agosto • 3 dias</div>
                    </div>
                    <div class="booking-status completed">Concluída</div>
                </div>
                
                <div class="booking-item">
                    <div class="booking-avatar">PC</div>
                    <div class="booking-details">
                        <div class="booking-customer">Pedro Costa</div>
                        <div class="booking-period">23-24 de Agosto • 2 dias</div>
                    </div>
                    <div class="booking-status upcoming">Agendada</div>
                </div>
                
                <div class="booking-item">
                    <div class="booking-avatar">AP</div>
                    <div class="booking-details">
                        <div class="booking-customer">Ana Paula</div>
                        <div class="booking-period">1-3 de Agosto • 3 dias</div>
                    </div>
                    <div class="booking-status completed">Concluída</div>
                </div>
            </div>
            
            <!-- Botões de Ação Principais -->
            <div class="main-action-buttons">
                <a href="<%=request.getContextPath()%>/pages/editarBicicleta.jsp" class="btn-primary">
                    <i class="fas fa-edit"></i> Editar Bicicleta
                </a>
                <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp" class="btn-success">
                    <i class="fas fa-calendar-alt"></i> Definir Disponibilidade
                </a>
                <a href="<%=request.getContextPath()%>/pages/bicicletasLocador.jsp" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Voltar às Minhas Bicicletas
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
                if (confirm('Deseja alterar a disponibilidade para este dia?')) {
                    // Redirecionar para página de configuração
                    window.location.href = '<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp';
                }
            });
        });
        
        // Função para atualizar métricas
        function updateMetrics() {
            console.log('Atualizando métricas de performance...');
        }
        
        // Atualizar a cada 60 segundos
        setInterval(updateMetrics, 60000);
        
        // Animações de entrada
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.performance-metrics, .details-section, .availability-calendar, .recent-bookings');
            elements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    element.style.transition = 'all 0.6s ease';
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, index * 150);
            });
        });
        
        // Tooltip para ícones de edição
        document.querySelectorAll('.edit-icon').forEach(icon => {
            icon.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.2)';
            });
            
            icon.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
            });
        });
    </script>
</body>
</html>