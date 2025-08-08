<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Informar Distância - ShareBike</title>
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

        .reservation-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid #ffc107;
            transition: all 0.3s ease;
        }

        .reservation-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }

        .reservation-card.completed {
            border-left-color: #28a745;
        }

        .reservation-card.pending {
            border-left-color: #6c757d;
        }

        .reservation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .reservation-id {
            font-weight: bold;
            color: #333;
            font-size: 1.1rem;
        }

        .status-badge {
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-finalizada {
            background: #d4edda;
            color: #28a745;
        }

        .status-pendente {
            background: #fff3cd;
            color: #856404;
        }

        .reservation-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 0.3rem;
        }

        .info-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 0.9rem;
        }

        .info-value {
            color: #333;
            font-weight: 500;
        }

        .distance-form {
            background: #e3f2fd;
            border-radius: 10px;
            padding: 1.5rem;
            margin-top: 1rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-group input {
            width: 100%;
            max-width: 200px;
            padding: 0.8rem;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #ffc107;
            box-shadow: 0 0 0 3px rgba(255, 193, 7, 0.1);
        }

        .points-calculator {
            background: #fff3cd;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
            text-align: center;
        }

        .points-display {
            font-size: 2rem;
            font-weight: bold;
            color: #856404;
            margin: 0.5rem 0;
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

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
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

        .stats-summary {
            background: linear-gradient(135deg, #e3f2fd, #f3e5f5);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .stat-item {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #ffc107;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #6c757d;
            font-weight: 500;
        }

        .bike-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            background: white;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .bike-icon {
            width: 50px;
            height: 50px;
            background: #ffc107;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
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
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .reservation-info {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
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
            <a href="rankingLocatario.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> Voltar ao Ranking
            </a>
            
            <h1 class="header-title">
                <i class="fas fa-route"></i> 
                Informar Distância Percorrida
            </h1>
            <p>Ganhe pontos no ranking informando a distância das suas viagens!</p>
        </div>

        <!-- Estatísticas Gerais -->
        <div class="stats-summary">
            <h3><i class="fas fa-chart-line"></i> Suas Estatísticas de Pontos</h3>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">1,247</div>
                    <div class="stat-label">Pontos Totais</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">1,247</div>
                    <div class="stat-label">Km Percorridos</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">23</div>
                    <div class="stat-label">Viagens Completadas</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">12º</div>
                    <div class="stat-label">Posição no Ranking</div>
                </div>
            </div>
        </div>

        <!-- Informações sobre Pontuação -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-info-circle"></i>
                Como Funciona a Pontuação
            </div>
            
            <div class="alert alert-info">
                <i class="fas fa-trophy"></i>
                <span>Para cada <strong>1 km percorrido</strong>, você ganha <strong>1 ponto</strong> no ranking!</span>
            </div>
            
            <div style="background: #f8f9fa; border-radius: 8px; padding: 1rem; margin-top: 1rem;">
                <h4><i class="fas fa-lightbulb"></i> Dicas para Maximizar seus Pontos:</h4>
                <ul style="margin-left: 1.5rem; margin-top: 0.5rem;">
                    <li>Informe a distância real percorrida para garantir pontos justos</li>
                    <li>Complete mais viagens para subir no ranking</li>
                    <li>Mantenha uma boa avaliação para ser um locatário preferencial</li>
                    <li>Use aplicativos de rastreamento para medir distâncias precisas</li>
                </ul>
            </div>
        </div>

        <!-- Lista de Reservas Finalizadas -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-calendar-check"></i>
                Reservas Finalizadas - Aguardando Informação de Distância
            </div>
            
            <!-- Reserva 1 -->
            <div class="reservation-card completed" id="reserva-001">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-USER-004</div>
                    <div class="status-badge status-pendente">
                        <i class="fas fa-clock"></i> Aguardando Distância
                    </div>
                </div>
                
                <div class="bike-info">
                    <div class="bike-icon">
                        <i class="fas fa-bicycle"></i>
                    </div>
                    <div>
                        <strong>Speed Pro 2024</strong><br>
                        <small><i class="fas fa-user"></i> Locador: Maria Costa</small>
                    </div>
                </div>
                
                <div class="reservation-info">
                    <div class="info-item">
                        <span class="info-label">Data da Viagem</span>
                        <span class="info-value">03/08 - 05/08/2025</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Duração</span>
                        <span class="info-value">2 dias (48 horas)</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Finalizada em</span>
                        <span class="info-value">05/08/2025 17:00</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Status</span>
                        <span class="info-value">Devolvida com sucesso</span>
                    </div>
                </div>
                
                <div class="distance-form">
                    <h4><i class="fas fa-route"></i> Informar Distância Percorrida</h4>
                    <div class="form-group">
                        <label for="distance-001">
                            <i class="fas fa-road"></i>
                            Distância Total (em km):
                        </label>
                        <input type="number" 
                               id="distance-001" 
                               min="0" 
                               max="1000" 
                               step="0.1" 
                               placeholder="Ex: 45.5"
                               oninput="calculatePoints('001')"
                               style="margin-bottom: 1rem;">
                        
                        <div class="points-calculator" id="calculator-001" style="display: none;">
                            <div><i class="fas fa-calculator"></i> Pontos que você ganhará:</div>
                            <div class="points-display" id="points-001">0</div>
                            <div>pontos</div>
                        </div>
                    </div>
                    
                    <button class="btn btn-success" 
                            onclick="submitDistance('001')" 
                            id="submit-001"
                            disabled>
                        <i class="fas fa-check"></i>
                        Confirmar Distância
                    </button>
                </div>
            </div>
            
            <!-- Reserva 2 -->
            <div class="reservation-card completed" id="reserva-002">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-USER-005</div>
                    <div class="status-badge status-pendente">
                        <i class="fas fa-clock"></i> Aguardando Distância
                    </div>
                </div>
                
                <div class="bike-info">
                    <div class="bike-icon">
                        <i class="fas fa-bicycle"></i>
                    </div>
                    <div>
                        <strong>Urbana City UB-2024</strong><br>
                        <small><i class="fas fa-user"></i> Locador: Pedro Santos</small>
                    </div>
                </div>
                
                <div class="reservation-info">
                    <div class="info-item">
                        <span class="info-label">Data da Viagem</span>
                        <span class="info-value">31/07 - 01/08/2025</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Duração</span>
                        <span class="info-value">1 dia (24 horas)</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Finalizada em</span>
                        <span class="info-value">01/08/2025 18:30</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Status</span>
                        <span class="info-value">Devolvida com sucesso</span>
                    </div>
                </div>
                
                <div class="distance-form">
                    <h4><i class="fas fa-route"></i> Informar Distância Percorrida</h4>
                    <div class="form-group">
                        <label for="distance-002">
                            <i class="fas fa-road"></i>
                            Distância Total (em km):
                        </label>
                        <input type="number" 
                               id="distance-002" 
                               min="0" 
                               max="1000" 
                               step="0.1" 
                               placeholder="Ex: 22.3"
                               oninput="calculatePoints('002')"
                               style="margin-bottom: 1rem;">
                        
                        <div class="points-calculator" id="calculator-002" style="display: none;">
                            <div><i class="fas fa-calculator"></i> Pontos que você ganhará:</div>
                            <div class="points-display" id="points-002">0</div>
                            <div>pontos</div>
                        </div>
                    </div>
                    
                    <button class="btn btn-success" 
                            onclick="submitDistance('002')" 
                            id="submit-002"
                            disabled>
                        <i class="fas fa-check"></i>
                        Confirmar Distância
                    </button>
                </div>
            </div>
            
            <!-- Reserva 3 -->
            <div class="reservation-card completed" id="reserva-003">
                <div class="reservation-header">
                    <div class="reservation-id">#RSV-USER-006</div>
                    <div class="status-badge status-pendente">
                        <i class="fas fa-clock"></i> Aguardando Distância
                    </div>
                </div>
                
                <div class="bike-info">
                    <div class="bike-icon">
                        <i class="fas fa-bicycle"></i>
                    </div>
                    <div>
                        <strong>Mountain Explorer MX-2024</strong><br>
                        <small><i class="fas fa-user"></i> Locador: Ana Silva</small>
                    </div>
                </div>
                
                <div class="reservation-info">
                    <div class="info-item">
                        <span class="info-label">Data da Viagem</span>
                        <span class="info-value">28/07/2025</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Duração</span>
                        <span class="info-value">8 horas</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Finalizada em</span>
                        <span class="info-value">28/07/2025 18:00</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Status</span>
                        <span class="info-value">Devolvida com sucesso</span>
                    </div>
                </div>
                
                <div class="distance-form">
                    <h4><i class="fas fa-route"></i> Informar Distância Percorrida</h4>
                    <div class="form-group">
                        <label for="distance-003">
                            <i class="fas fa-road"></i>
                            Distância Total (em km):
                        </label>
                        <input type="number" 
                               id="distance-003" 
                               min="0" 
                               max="1000" 
                               step="0.1" 
                               placeholder="Ex: 67.8"
                               oninput="calculatePoints('003')"
                               style="margin-bottom: 1rem;">
                        
                        <div class="points-calculator" id="calculator-003" style="display: none;">
                            <div><i class="fas fa-calculator"></i> Pontos que você ganhará:</div>
                            <div class="points-display" id="points-003">0</div>
                            <div>pontos</div>
                        </div>
                    </div>
                    
                    <button class="btn btn-success" 
                            onclick="submitDistance('003')" 
                            id="submit-003"
                            disabled>
                        <i class="fas fa-check"></i>
                        Confirmar Distância
                    </button>
                </div>
            </div>
        </div>

        <!-- Botões de Ação -->
        <div class="action-buttons">
            <a href="rankingLocatario.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>
                Voltar ao Ranking
            </a>
            
            <a href="reservasLocatario.jsp" class="btn btn-primary">
                <i class="fas fa-calendar-check"></i>
                Ver Todas as Reservas
            </a>
        </div>
    </div>

    <script>
        function calculatePoints(reservaId) {
            const distanceInput = document.getElementById(`distance-${reservaId}`);
            const pointsDisplay = document.getElementById(`points-${reservaId}`);
            const calculator = document.getElementById(`calculator-${reservaId}`);
            const submitButton = document.getElementById(`submit-${reservaId}`);
            
            const distance = parseFloat(distanceInput.value) || 0;
            const points = Math.floor(distance); // 1 km = 1 ponto
            
            if (distance > 0) {
                calculator.style.display = 'block';
                pointsDisplay.textContent = points;
                submitButton.disabled = false;
            } else {
                calculator.style.display = 'none';
                submitButton.disabled = true;
            }
        }
        
        function submitDistance(reservaId) {
            const distanceInput = document.getElementById(`distance-${reservaId}`);
            const distance = parseFloat(distanceInput.value);
            const points = Math.floor(distance);
            
            if (!distance || distance <= 0) {
                alert('Por favor, informe uma distância válida!');
                return;
            }
            
            if (confirm(`Confirmar distância de ${distance} km?\n\nVocê ganhará ${points} pontos no ranking.`)) {
                // Simular envio para o servidor
                const reservaCard = document.getElementById(`reserva-${reservaId}`);
                const statusBadge = reservaCard.querySelector('.status-badge');
                const distanceForm = reservaCard.querySelector('.distance-form');
                
                // Atualizar status
                statusBadge.className = 'status-badge status-finalizada';
                statusBadge.innerHTML = '<i class="fas fa-check-circle"></i> Distância Informada';
                
                // Substituir formulário por informações
                distanceForm.innerHTML = `
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span>Distância informada: <strong>${distance} km</strong> • Pontos ganhos: <strong>${points}</strong></span>
                    </div>
                `;
                
                // Atualizar estatísticas (simulação)
                const pontosAtuais = parseInt(document.querySelector('.stat-number').textContent.replace(',', ''));
                const kmAtuais = parseInt(document.querySelectorAll('.stat-number')[1].textContent.replace(',', ''));
                
                document.querySelectorAll('.stat-number')[0].textContent = (pontosAtuais + points).toLocaleString();
                document.querySelectorAll('.stat-number')[1].textContent = (kmAtuais + Math.floor(distance)).toLocaleString();
                
                alert(`Parabéns! Você ganhou ${points} pontos no ranking!\n\nSua nova pontuação: ${pontosAtuais + points} pontos`);
            }
        }
        
        // Validação de entrada
        document.querySelectorAll('input[type="number"]').forEach(input => {
            input.addEventListener('input', function() {
                if (this.value < 0) this.value = 0;
                if (this.value > 1000) this.value = 1000;
            });
        });
        
        console.log('Página de informar distância carregada');
    </script>
</body>
</html>
