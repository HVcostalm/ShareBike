<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestão da Reserva - ShareBike</title>
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
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
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
            color: white;
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

        .locatario-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1.5rem;
            display: flex;
            gap: 1.5rem;
            align-items: center;
        }

        .locatario-image {
            width: 80px;
            height: 80px;
            background: #28a745;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
            flex-shrink: 0;
        }

        .locatario-info h3 {
            margin-bottom: 0.5rem;
            color: #333;
        }

        .locatario-details {
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

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            color: #212529;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
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
            background: #28a745;
            border-radius: 50%;
            border: 3px solid white;
            box-shadow: 0 0 0 3px #28a745;
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

        .price-summary {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            border-left: 4px solid #28a745;
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

        .current-time {
            background: #e3f2fd;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            text-align: center;
            font-weight: 600;
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
            
            .locatario-card {
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
            <a href="reservasLocador.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Voltar às Reservas
            </a>
            
            <h1 class="header-title">
                <i class="fas fa-cogs"></i> 
                Gestão da Reserva #001
            </h1>
            <p>Gerencie e acompanhe o status da reserva da sua bicicleta</p>
        </div>

        <!-- Horário Atual -->
        <div class="current-time">
            <i class="fas fa-clock"></i> 
            Horário Atual: <span id="currentTime">7 de agosto de 2025 - 14:30</span>
        </div>

        <!-- Status da Reserva -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-info-circle"></i>
                Status da Reserva
            </div>
            
            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                <span class="status-badge status-em-andamento" id="statusBadge">
                    <i class="fas fa-play"></i> Em Andamento
                </span>
                
                <div style="text-align: right;">
                    <div class="info-label">Reserva criada em</div>
                    <div class="info-value">1 de agosto de 2025</div>
                </div>
            </div>

            <div class="alert alert-info" id="statusAlert" style="margin-top: 1rem;">
                <i class="fas fa-bicycle"></i>
                <span>Bicicleta foi entregue. Aguardando o horário de devolução (17:00).</span>
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
                    <span class="info-label">Local de Retirada</span>
                    <span class="info-value">Rua das Flores, 123 - Centro</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Status</span>
                    <span class="info-value">Confirmada</span>
                </div>
            </div>
        </div>

        <!-- Bicicleta da Reserva -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-bicycle"></i>
                Sua Bicicleta
            </div>
            
            <div class="locatario-card">
                <div class="locatario-image">
                    <i class="fas fa-bicycle"></i>
                </div>
                <div class="locatario-info">
                    <h3>Trek Mountain Pro 2024</h3>
                    <div class="locatario-details">
                        <i class="fas fa-mountain"></i> Mountain Bike<br>
                        <i class="fas fa-star"></i> 4.8/5.0 (25 avaliações)<br>
                        <i class="fas fa-cogs"></i> 21 marchas - Aro 29<br>
                        <i class="fas fa-shield-alt"></i> Seguro incluído
                    </div>
                </div>
            </div>
        </div>

        <!-- Informações do Locatário -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-user"></i>
                Informações do Locatário
            </div>
            
            <div class="locatario-card">
                <div class="locatario-image">
                    <i class="fas fa-user"></i>
                </div>
                <div class="locatario-info">
                    <h3>João Silva</h3>
                    <div class="locatario-details">
                        <i class="fas fa-star"></i> 4.2/5.0 (18 avaliações)<br>
                        <i class="fas fa-phone"></i> (11) 99999-8888<br>
                        <i class="fas fa-calendar"></i> Membro desde Janeiro 2023<br>
                        <i class="fas fa-bicycle"></i> 47 aluguéis realizados
                    </div>
                </div>
            </div>
            
            <div style="background: #e3f2fd; border-radius: 8px; padding: 1rem; margin-top: 1rem;">
                <h4><i class="fas fa-shield-check"></i> Perfil Verificado</h4>
                <p>Locatário confiável com histórico positivo de aluguéis.</p>
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
                        <h4>Solicitação de Reserva</h4>
                        <div class="timeline-date">1 de agosto de 2025 - 14:30</div>
                    </div>
                </div>
                
                <div class="timeline-item">
                    <div class="timeline-marker completed"></div>
                    <div class="timeline-content">
                        <h4>Reserva Confirmada por Você</h4>
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
                    <div class="timeline-marker pending"></div>
                    <div class="timeline-content">
                        <h4>Aguardando Devolução</h4>
                        <div class="timeline-date">Previsto: 5 de agosto de 2025 - 17:00</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Botões de Ação -->
        <div class="action-buttons" id="actionButtons">
            <!-- Botões que aparecem baseado no status -->
            <button class="btn btn-success" onclick="marcarComoDevolvida()" id="btnDevolvida">
                <i class="fas fa-check"></i>
                Marcar como Devolvida
            </button>
            
            <button class="btn btn-warning" onclick="reportarAtraso()" id="btnAtraso">
                <i class="fas fa-exclamation-triangle"></i>
                Reportar Atraso
            </button>
            
            <a href="reservasLocador.jsp" class="btn btn-secondary">
                <i class="fas fa-list"></i>
                Ver Todas as Reservas
            </a>
        </div>
    </div>

    <script>
        // Simular diferentes status da reserva
        function atualizarInterface(status) {
            const statusBadge = document.getElementById('statusBadge');
            const statusAlert = document.getElementById('statusAlert');
            const actionButtons = document.getElementById('actionButtons');
            
            // Limpar botões anteriores
            const botoesAntigos = actionButtons.querySelectorAll('.btn:not([href])');
            botoesAntigos.forEach(btn => btn.remove());
            
            switch(status) {
                case 'pendente':
                    statusBadge.className = 'status-badge status-pendente';
                    statusBadge.innerHTML = '<i class="fas fa-clock"></i> Pendente';
                    statusAlert.innerHTML = '<i class="fas fa-clock"></i><span>Nova solicitação de reserva aguardando sua aprovação.</span>';
                    statusAlert.className = 'alert alert-warning';
                    
                    // Adicionar botões de aceitar/rejeitar
                    actionButtons.insertAdjacentHTML('afterbegin', `
                        <button class="btn btn-success" onclick="confirmarReserva()">
                            <i class="fas fa-check"></i> Confirmar Reserva
                        </button>
                        <button class="btn btn-danger" onclick="negarReserva()">
                            <i class="fas fa-times"></i> Negar Reserva
                        </button>
                    `);
                    break;
                    
                case 'confirmada':
                    statusBadge.className = 'status-badge status-confirmada';
                    statusBadge.innerHTML = '<i class="fas fa-thumbs-up"></i> Confirmada';
                    statusAlert.innerHTML = '<i class="fas fa-check"></i><span>Reserva confirmada. Aguarde o dia da retirada.</span>';
                    statusAlert.className = 'alert alert-success';
                    break;
                    
                case 'dia-da-entrega':
                    statusBadge.className = 'status-badge status-confirmada';
                    statusBadge.innerHTML = '<i class="fas fa-calendar-day"></i> Dia da Entrega';
                    statusAlert.innerHTML = '<i class="fas fa-info-circle"></i><span>Hoje é o dia da entrega! Confirme quando entregar a bicicleta.</span>';
                    statusAlert.className = 'alert alert-info';
                    
                    // Adicionar botão de entregar
                    actionButtons.insertAdjacentHTML('afterbegin', `
                        <button class="btn btn-primary" onclick="marcarComoEntregue()">
                            <i class="fas fa-handshake"></i> Marcar como Entregue
                        </button>
                    `);
                    break;
                    
                case 'em-andamento':
                    statusBadge.className = 'status-badge status-em-andamento';
                    statusBadge.innerHTML = '<i class="fas fa-play"></i> Em Andamento';
                    statusAlert.innerHTML = '<i class="fas fa-bicycle"></i><span>Bicicleta foi entregue. Aguardando o horário de devolução (17:00).</span>';
                    statusAlert.className = 'alert alert-info';
                    
                    // Verificar se é hora da devolução
                    const agora = new Date();
                    const horaDevolucao = new Date();
                    horaDevolucao.setHours(17, 0, 0);
                    
                    if (agora >= horaDevolucao) {
                        actionButtons.insertAdjacentHTML('afterbegin', `
                            <button class="btn btn-success" onclick="marcarComoDevolvida()">
                                <i class="fas fa-check"></i> Marcar como Devolvida
                            </button>
                            <button class="btn btn-warning" onclick="reportarAtraso()">
                                <i class="fas fa-exclamation-triangle"></i> Reportar Atraso
                            </button>
                        `);
                    }
                    break;
                    
                case 'finalizada':
                    statusBadge.className = 'status-badge status-finalizada';
                    statusBadge.innerHTML = '<i class="fas fa-check-circle"></i> Finalizada';
                    statusAlert.innerHTML = '<i class="fas fa-check-circle"></i><span>Reserva finalizada com sucesso! Você pode avaliar o locatário.</span>';
                    statusAlert.className = 'alert alert-success';
                    
                    // Adicionar botão de feedback
                    actionButtons.insertAdjacentHTML('afterbegin', `
                        <a href="fazerFeedbackLocador.jsp?reservaId=001" class="btn btn-success">
                            <i class="fas fa-star"></i> Avaliar Locatário
                        </a>
                    `);
                    break;
            }
        }
        
        function confirmarReserva() {
            if (confirm('Confirmar esta reserva?')) {
                alert('Reserva confirmada com sucesso!');
                atualizarInterface('confirmada');
            }
        }
        
        function negarReserva() {
            if (confirm('Tem certeza que deseja negar esta reserva?')) {
                alert('Reserva negada. O locatário será notificado.');
                window.location.href = 'reservasLocador.jsp';
            }
        }
        
        function marcarComoEntregue() {
            if (confirm('Confirmar que a bicicleta foi entregue ao locatário?')) {
                alert('Bicicleta marcada como entregue!');
                atualizarInterface('em-andamento');
            }
        }
        
        function marcarComoDevolvida() {
            if (confirm('Confirmar que a bicicleta foi devolvida?')) {
                alert('Bicicleta devolvida! Redirecionando para avaliação...');
                window.location.href = 'fazerFeedbackLocador.jsp?reservaId=001';
            }
        }
        
        function reportarAtraso() {
            alert('Atraso reportado. O locatário será notificado e taxas adicionais podem ser aplicadas.');
        }
        
        // Atualizar horário atual
        function atualizarHorario() {
            const agora = new Date();
            const opcoes = { 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            };
            document.getElementById('currentTime').textContent = agora.toLocaleDateString('pt-BR', opcoes);
        }
        
        // Inicializar página
        atualizarInterface('em-andamento');
        atualizarHorario();
        setInterval(atualizarHorario, 60000); // Atualizar a cada minuto
        
        console.log('Página de gestão da reserva (locador) carregada');
    </script>
</body>
</html>
