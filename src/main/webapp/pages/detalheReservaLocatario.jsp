<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes da Reserva - ShareBike</title>
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
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            color: #212529;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .header-title {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-link {
            background: rgba(255,255,255,0.2);
            color: #212529;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .back-link:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-1px);
        }

        .card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .card-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .status-badge {
            padding: 0.5rem 1.2rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            display: inline-block;
        }

        .status-pendente {
            background: #fff3cd;
            color: #856404;
        }

        .status-confirmada {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-em-andamento {
            background: #d4edda;
            color: #155724;
        }

        .status-finalizada {
            background: #e2e3e5;
            color: #383d41;
        }

        .status-cancelada {
            background: #f8d7da;
            color: #721c24;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .info-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1.1rem;
            color: #333;
            font-weight: 500;
        }

        .bike-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1.5rem;
            display: flex;
            gap: 1.5rem;
            align-items: center;
        }

        .bike-image {
            width: 80px;
            height: 80px;
            background: #ffc107;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
            flex-shrink: 0;
        }

        .bike-info h3 {
            margin-bottom: 0.5rem;
            color: #333;
        }

        .bike-details {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .timeline {
            position: relative;
            padding-left: 2rem;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 0.75rem;
            top: 0;
            height: 100%;
            width: 2px;
            background: #dee2e6;
        }

        .timeline-item {
            position: relative;
            margin-bottom: 2rem;
            padding-left: 2rem;
        }

        .timeline-marker {
            position: absolute;
            left: -2.25rem;
            top: 0.25rem;
            width: 1rem;
            height: 1rem;
            background: #ffc107;
            border-radius: 50%;
            border: 3px solid white;
            box-shadow: 0 0 0 3px #ffc107;
        }

        .timeline-marker.completed {
            background: #28a745;
            box-shadow: 0 0 0 3px #28a745;
        }

        .timeline-marker.pending {
            background: #6c757d;
            box-shadow: 0 0 0 3px #6c757d;
        }

        .timeline-content h4 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .timeline-date {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .price-summary {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            border-left: 4px solid #ffc107;
        }

        .price-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            padding: 0.5rem 0;
        }

        .price-item.total {
            border-top: 2px solid #dee2e6;
            margin-top: 1rem;
            padding-top: 1rem;
            font-weight: bold;
            font-size: 1.2rem;
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .contact-info {
            background: #e3f2fd;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .header {
                padding: 1.5rem;
            }
            
            .header-title {
                font-size: 2rem;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .bike-card {
                flex-direction: column;
                text-align: center;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <a href="reservasLocatario.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Voltar às Minhas Reservas
            </a>
            
            <h1 class="header-title">
                <i class="fas fa-calendar-check"></i> 
                Detalhes da Reserva #001
            </h1>
            <p>Visualize todas as informações da sua reserva</p>
        </div>

        <!-- Status da Reserva -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-info-circle"></i>
                Status da Reserva
            </div>
            
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <span class="status-badge status-finalizada">
                    <i class="fas fa-check-circle"></i> Finalizada
                </span>
                
                <div style="text-align: right;">
                    <div class="info-label">Reserva criada em</div>
                    <div class="info-value">1 de agosto de 2025</div>
                </div>
            </div>

            <div class="alert alert-success" style="margin-top: 1rem;">
                <i class="fas fa-check-circle"></i>
                <span>Reserva finalizada com sucesso! Você pode avaliar sua experiência.</span>
            </div>
        </div>

        <!-- Informações da Reserva -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-calendar-alt"></i>
                Informações da Reserva
            </div>
            
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">ID da Reserva</span>
                    <span class="info-value">#001</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Data de Início</span>
                    <span class="info-value">5 de agosto de 2025</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Horário de Início</span>
                    <span class="info-value">09:00</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Data de Fim</span>
                    <span class="info-value">5 de agosto de 2025</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Horário de Fim</span>
                    <span class="info-value">17:00</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Duração Total</span>
                    <span class="info-value">8 horas</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Informada</span>
                    <span class="info-value">
                        <i class="fas fa-check text-success"></i> Sim
                    </span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Local de Retirada</span>
                    <span class="info-value">Rua das Flores, 123 - Centro</span>
                </div>
            </div>
        </div>

        <!-- Bicicleta Reservada -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-bicycle"></i>
                Bicicleta Reservada
            </div>
            
            <div class="bike-card">
                <div class="bike-image">
                    <i class="fas fa-bicycle"></i>
                </div>
                <div class="bike-info">
                    <h3>Trek Mountain Pro 2024</h3>
                    <div class="bike-details">
                        <i class="fas fa-mountain"></i> Mountain Bike<br>
                        <i class="fas fa-star"></i> 4.8/5.0 (25 avaliações)<br>
                        <i class="fas fa-cogs"></i> 21 marchas - Aro 29<br>
                        <i class="fas fa-shield-alt"></i> Seguro incluído
                    </div>
                </div>
            </div>
        </div>

        <!-- Informações do Locador -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-user"></i>
                Informações do Locador
            </div>
            
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Nome</span>
                    <span class="info-value">Maria Costa</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Avaliação</span>
                    <span class="info-value">
                        <i class="fas fa-star" style="color: #ffc107;"></i>
                        <i class="fas fa-star" style="color: #ffc107;"></i>
                        <i class="fas fa-star" style="color: #ffc107;"></i>
                        <i class="fas fa-star" style="color: #ffc107;"></i>
                        <i class="fas fa-star" style="color: #ffc107;"></i>
                        5.0/5.0
                    </span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Telefone</span>
                    <span class="info-value">(11) 98765-4321</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Localização</span>
                    <span class="info-value">São Paulo, SP</span>
                </div>
            </div>
            
            <div class="contact-info">
                <h4><i class="fas fa-phone"></i> Contato para Retirada</h4>
                <p>Entre em contato com o locador para coordenar a retirada e devolução da bicicleta.</p>
            </div>
        </div>

        <!-- Timeline da Reserva -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-history"></i>
                Histórico da Reserva
            </div>
            
            <div class="timeline">
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Reserva Criada</h4>
                        <div class="timeline-date">1 de agosto de 2025 - 14:30</div>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Reserva Confirmada pelo Locador</h4>
                        <div class="timeline-date">2 de agosto de 2025 - 09:15</div>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Bicicleta Entregue</h4>
                        <div class="timeline-date">5 de agosto de 2025 - 09:00</div>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Bicicleta Devolvida</h4>
                        <div class="timeline-date">5 de agosto de 2025 - 17:00</div>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Reserva Finalizada</h4>
                        <div class="timeline-date">5 de agosto de 2025 - 17:15</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Botões de Ação -->
        <div class="action-buttons">
            <a href="fazerFeedbackLocatario.jsp?reservaId=001" class="btn btn-success">
                <i class="fas fa-star"></i>
                Avaliar Experiência
            </a>
            
            <a href="reservasLocatario.jsp" class="btn btn-secondary">
                <i class="fas fa-list"></i>
                Ver Todas as Reservas
            </a>
        </div>
    </div>

    <script>
        // Simular diferentes status para demonstração
        function mudarStatus(novoStatus) {
            const statusElement = document.querySelector('.status-badge');
            const alertElement = document.querySelector('.alert');
            const botaoFeedback = document.querySelector('a[href*="fazerFeedback"]');
            
            // Remove classes de status anteriores
            statusElement.className = 'status-badge';
            
            switch(novoStatus) {
                case 'pendente':
                    statusElement.classList.add('status-pendente');
                    statusElement.innerHTML = '<i class="fas fa-clock"></i> Pendente';
                    alertElement.innerHTML = '<i class="fas fa-clock"></i><span>Aguardando confirmação do locador.</span>';
                    alertElement.className = 'alert alert-info';
                    if(botaoFeedback) botaoFeedback.style.display = 'none';
                    break;
                    
                case 'confirmada':
                    statusElement.classList.add('status-confirmada');
                    statusElement.innerHTML = '<i class="fas fa-thumbs-up"></i> Confirmada';
                    alertElement.innerHTML = '<i class="fas fa-check"></i><span>Reserva confirmada! Aguarde o dia da retirada.</span>';
                    alertElement.className = 'alert alert-success';
                    if(botaoFeedback) botaoFeedback.style.display = 'none';
                    break;
                    
                case 'em-andamento':
                    statusElement.classList.add('status-em-andamento');
                    statusElement.innerHTML = '<i class="fas fa-play"></i> Em Andamento';
                    alertElement.innerHTML = '<i class="fas fa-bicycle"></i><span>Você está com a bicicleta. Aproveite seu passeio!</span>';
                    alertElement.className = 'alert alert-info';
                    if(botaoFeedback) botaoFeedback.style.display = 'none';
                    break;
                    
                case 'finalizada':
                    statusElement.classList.add('status-finalizada');
                    statusElement.innerHTML = '<i class="fas fa-check-circle"></i> Finalizada';
                    alertElement.innerHTML = '<i class="fas fa-check-circle"></i><span>Reserva finalizada com sucesso! Você pode avaliar sua experiência.</span>';
                    alertElement.className = 'alert alert-success';
                    if(botaoFeedback) botaoFeedback.style.display = 'inline-flex';
                    break;
            }
        }
        
        console.log('Página de detalhes da reserva (locatário) carregada');
    </script>
</body>
</html>
