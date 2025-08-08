<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Perfil do Usuário - Análise para Ranking</title>
    <link rel="stylesheet" href="../assets/css/admDetalhes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #f8f9fa;
            min-height: 100vh;
        }
        
        .user-profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2.5rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .profile-info {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 1.5rem;
        }
        
        .user-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            font-weight: bold;
            border: 4px solid rgba(255, 255, 255, 0.3);
        }
        
        .user-details h1 {
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
        }
        
        .user-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            font-size: 1rem;
            opacity: 0.9;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .ranking-status {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }
        
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .status-eligible {
            background: #28a745;
            color: white;
        }
        
        .status-not-eligible {
            background: #dc3545;
            color: white;
        }
        
        .status-pending {
            background: #ffc107;
            color: #212529;
        }
        
        .analysis-section {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .criteria-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        .criteria-card {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            border-left: 4px solid #e9ecef;
            transition: all 0.3s ease;
        }
        
        .criteria-card.met {
            border-left-color: #28a745;
            background: #d4edda;
        }
        
        .criteria-card.not-met {
            border-left-color: #dc3545;
            background: #f8d7da;
        }
        
        .criteria-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        
        .criteria-title {
            font-weight: 600;
            color: #333;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .criteria-icon {
            font-size: 1.5rem;
        }
        
        .criteria-icon.met {
            color: #28a745;
        }
        
        .criteria-icon.not-met {
            color: #dc3545;
        }
        
        .criteria-details {
            color: #666;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .bikes-list, .reservas-list {
            list-style: none;
            padding: 0;
            margin: 1rem 0 0 0;
        }
        
        .bike-item, .reserva-item {
            padding: 1rem;
            background: white;
            border-radius: 8px;
            margin-bottom: 0.8rem;
            border: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .item-info h4 {
            margin: 0 0 0.3rem 0;
            color: #333;
        }
        
        .item-info p {
            margin: 0;
            color: #666;
            font-size: 0.9rem;
        }
        
        .item-status {
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .status-ativa {
            background: #d4edda;
            color: #28a745;
        }
        
        .status-finalizada {
            background: #cce5ff;
            color: #0066cc;
        }
        
        .decision-section {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            margin-top: 2rem;
        }
        
        .decision-title {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 1rem;
        }
        
        .decision-subtitle {
            color: #666;
            margin-bottom: 2rem;
            font-size: 1.1rem;
        }
        
        .decision-buttons {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
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
        
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        
        .summary-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .stat-item {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 0.3rem;
        }
        
        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }
        
        .back-button {
            text-align: center;
            margin-top: 2rem;
        }
        
        .btn-back {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
            padding: 1rem 2rem;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
        }
        
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            color: white;
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-user-check"></i> Perfil do Usuário - Análise para Ranking</h1>
    </header>
    
    <div class="container">
        <!-- Cabeçalho do Perfil do Usuário -->
        <div class="user-profile-header">
            <div class="profile-info">
                <div class="user-avatar">
                    <!-- Primeira letra do nome do usuário -->
                    M
                </div>
                <div class="user-details">
                    <h1>Maria Silva Santos</h1>
                    <div class="user-meta">
                        <div class="meta-item">
                            <i class="fas fa-envelope"></i>
                            <span>maria.silva@email.com</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-phone"></i>
                            <span>(11) 9876-5432</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-calendar"></i>
                            <span>Membro desde: Jan 2024</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-user-tag"></i>
                            <span>Tipo: Locatário</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="ranking-status">
                <span><strong>Status no Ranking:</strong></span>
                <div class="status-badge status-pending">
                    <i class="fas fa-clock"></i>
                    Aguardando Aprovação
                </div>
            </div>
        </div>

        <!-- Resumo Estatístico -->
        <div class="summary-stats">
            <div class="stat-item">
                <div class="stat-value">1</div>
                <div class="stat-label">Comprovante Enviado</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">7</div>
                <div class="stat-label">Reservas Feitas</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">5</div>
                <div class="stat-label">Reservas Finalizadas</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">127.5</div>
                <div class="stat-label">Km Percorridos</div>
            </div>
        </div>

        <!-- Análise dos Critérios de Elegibilidade -->
        <div class="analysis-section">
            <h2 class="section-title">
                <i class="fas fa-clipboard-check"></i>
                Critérios de Elegibilidade para Ranking
            </h2>
            
            <div class="criteria-grid">
                <!-- Critério 1: Comprovante de Posse de Bicicleta -->
                <div class="criteria-card met">
                    <div class="criteria-header">
                        <div class="criteria-title">
                            <span>Comprovante de Posse de Bicicleta</span>
                        </div>
                        <div class="criteria-icon met">
                            <i class="fas fa-check-circle"></i>
                        </div>
                    </div>
                    <div class="criteria-details">
                        <p><strong>Status:</strong> ✅ Comprovante enviado e validado</p>
                        <p><strong>Arquivo:</strong> comprovante_bicicleta_maria_silva.jpg</p>
                        <p><strong>Data de envio:</strong> 28/03/2024</p>
                        <p><strong>Validado por:</strong> Admin Sistema</p>
                        
                        <div style="margin-top: 1rem; padding: 1rem; background: rgba(40, 167, 69, 0.1); border-radius: 8px; border-left: 4px solid #28a745;">
                            <h4 style="margin: 0 0 0.5rem 0; color: #28a745;">
                                <i class="fas fa-file-image"></i> Comprovante Anexado
                            </h4>
                            <p style="margin: 0; font-size: 0.9rem;">
                                O usuário enviou foto da nota fiscal ou documento que comprova a posse de bicicleta própria.
                                Este critério é essencial para participação no ranking de sustentabilidade.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Critério 2: Reservas Finalizadas -->
                <div class="criteria-card met">
                    <div class="criteria-header">
                        <div class="criteria-title">
                            <span>Reservas Finalizadas</span>
                        </div>
                        <div class="criteria-icon met">
                            <i class="fas fa-check-circle"></i>
                        </div>
                    </div>
                    <div class="criteria-details">
                        <p>O usuário possui reservas finalizadas com sucesso:</p>
                        <ul class="reservas-list">
                            <li class="reserva-item">
                                <div class="item-info">
                                    <h4>Reserva #2024001</h4>
                                    <p>Bike: Urban Classic • Distância: 25 km • Data: 15/03/2024</p>
                                </div>
                                <span class="item-status status-finalizada">Finalizada</span>
                            </li>
                            <li class="reserva-item">
                                <div class="item-info">
                                    <h4>Reserva #2024015</h4>
                                    <p>Bike: Speed Pro • Distância: 42 km • Data: 22/03/2024</p>
                                </div>
                                <span class="item-status status-finalizada">Finalizada</span>
                            </li>
                            <li class="reserva-item">
                                <div class="item-info">
                                    <h4>Reserva #2024023</h4>
                                    <p>Bike: Mountain Explorer • Distância: 18.5 km • Data: 28/03/2024</p>
                                </div>
                                <span class="item-status status-finalizada">Finalizada</span>
                            </li>
                            <li class="reserva-item">
                                <div class="item-info">
                                    <h4>Reserva #2024031</h4>
                                    <p>Bike: City Comfort • Distância: 12 km • Data: 02/04/2024</p>
                                </div>
                                <span class="item-status status-finalizada">Finalizada</span>
                            </li>
                            <li class="reserva-item">
                                <div class="item-info">
                                    <h4>Reserva #2024038</h4>
                                    <p>Bike: Adventure Plus • Distância: 30 km • Data: 08/04/2024</p>
                                </div>
                                <span class="item-status status-finalizada">Finalizada</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Histórico de Atividades -->
        <div class="analysis-section">
            <h2 class="section-title">
                <i class="fas fa-history"></i>
                Histórico de Atividades
            </h2>
            
            <div class="criteria-grid">
                <!-- Histórico de Participação -->
                <div class="criteria-card met">
                    <div class="criteria-header">
                        <div class="criteria-title">
                            <span>Engajamento na Plataforma</span>
                        </div>
                        <div class="criteria-icon met">
                            <i class="fas fa-chart-line"></i>
                        </div>
                    </div>
                    <div class="criteria-details">
                        <p><strong>Tempo na plataforma:</strong> 4 meses</p>
                        <p><strong>Frequência de uso:</strong> Alta (semanal)</p>
                        <p><strong>Avaliação média recebida:</strong> 4.8/5.0 ⭐</p>
                        <p><strong>Pontos sustentabilidade atuais:</strong> 285 pontos</p>
                    </div>
                </div>

                <!-- Atividade como Locatário -->
                <div class="criteria-card met">
                    <div class="criteria-header">
                        <div class="criteria-title">
                            <span>Atividade como Locatário</span>
                        </div>
                        <div class="criteria-icon met">
                            <i class="fas fa-route"></i>
                        </div>
                    </div>
                    <div class="criteria-details">
                        <p><strong>Total de reservas:</strong> 7</p>
                        <p><strong>Reservas finalizadas:</strong> 5 (71.4%)</p>
                        <p><strong>Distância total percorrida:</strong> 127.5 km</p>
                        <p><strong>Reservas concluídas:</strong> 12</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Conclusão da Análise e Decisão -->
        <div class="decision-section">
            <h2 class="decision-title">
                <i class="fas fa-gavel"></i>
                Decisão de Elegibilidade
            </h2>
            <p class="decision-subtitle">
                Com base na análise dos critérios, este usuário <strong>ATENDE</strong> aos requisitos para participação no ranking.<br>
                ✓ Enviou comprovante de posse de bicicleta E ✓ Possui reservas finalizadas
            </p>
            
            <div class="decision-buttons">
                <button class="btn btn-success" onclick="aprovarRanking()">
                    <i class="fas fa-check"></i>
                    Aprovar para Ranking
                </button>
                <button class="btn btn-danger" onclick="negarRanking()">
                    <i class="fas fa-times"></i>
                    Negar Participação
                </button>
                <button class="btn btn-secondary" onclick="solicitarMaisInfo()">
                    <i class="fas fa-info-circle"></i>
                    Solicitar Mais Informações
                </button>
            </div>
        </div>

        <!-- Botão de Voltar -->
        <div class="back-button">
            <a href="usuariosRanking.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Voltar para Usuários do Ranking
            </a>
        </div>
    </div>

    <script>
        // Funções de decisão para aprovação do ranking
        function aprovarRanking() {
            if (confirm('Confirma a aprovação deste usuário para participar do ranking?')) {
                alert('Usuário aprovado com sucesso!\n\nO usuário agora pode participar do sistema de ranking e acumular pontos.');
                // Aqui seria feita a integração com o controller para aprovar o usuário
                window.location.href = 'usuariosRanking.jsp';
            }
        }
        
        function negarRanking() {
            const motivo = prompt('Informe o motivo da negação:');
            if (motivo && motivo.trim() !== '') {
                alert(`Participação negada.\n\nMotivo: ${motivo}\n\nO usuário será notificado sobre a decisão.`);
                // Aqui seria feita a integração com o controller para negar o usuário
                window.location.href = 'usuariosRanking.jsp';
            } else if (motivo !== null) {
                alert('É necessário informar um motivo para a negação.');
            }
        }
        
        function solicitarMaisInfo() {
            const infoSolicitada = prompt('Que informações adicionais são necessárias?');
            if (infoSolicitada && infoSolicitada.trim() !== '') {
                alert(`Solicitação enviada ao usuário.\n\nInformações solicitadas: ${infoSolicitada}\n\nO usuário receberá uma notificação.`);
                // Aqui seria feita a integração com o controller para solicitar mais informações
                window.location.href = 'usuariosRanking.jsp';
            } else if (infoSolicitada !== null) {
                alert('É necessário especificar que informações são necessárias.');
            }
        }
        
        // Função para destacar critérios atendidos
        function verificarElegibilidade() {
            const temComprovante = document.querySelector('.criteria-card').classList.contains('met');
            const temReservas = document.querySelectorAll('.criteria-card')[1].classList.contains('met');
            
            if (temComprovante || temReservas) {
                console.log('Usuário elegível para ranking - possui comprovante de bicicleta ou reservas finalizadas');
                return true;
            } else {
                console.log('Usuário não elegível para ranking');
                return false;
            }
        }
        
        // Inicialização da página
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Análise de perfil carregada');
            verificarElegibilidade();
            
            // Adicionar efeitos visuais nos cards
            const cards = document.querySelectorAll('.criteria-card');
            cards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
            
            // Efeito de contador nos stats
            animateCounters();
        });
        
        // Animação dos contadores estatísticos
        function animateCounters() {
            const counters = document.querySelectorAll('.stat-value');
            
            counters.forEach(counter => {
                const target = parseFloat(counter.textContent);
                const increment = target / 30;
                let current = 0;
                
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        counter.textContent = target % 1 === 0 ? target : target.toFixed(1);
                        clearInterval(timer);
                    } else {
                        counter.textContent = current % 1 === 0 ? Math.floor(current) : current.toFixed(1);
                    }
                }, 50);
            });
        }
    </script>
</body>
</html>