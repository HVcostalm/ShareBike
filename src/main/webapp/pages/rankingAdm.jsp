<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ranking - Administrador</title>
    <link rel="stylesheet" href="../assets/css/ranking.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <div style="margin-bottom: 1rem;">
            <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" style="background: linear-gradient(135deg, #6c757d, #495057); color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-flex; align-items: center; gap: 0.5rem; font-weight: 600; transition: all 0.3s ease;">
                <i class="fas fa-arrow-left"></i> Voltar para Painel do Administrador
            </a>
        </div>
        <h1><i class="fas fa-trophy"></i> Sistema de Ranking - Administração</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasAdm.jsp"><i class="fas fa-bicycle"></i> Gerenciar Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasAdm.jsp"><i class="fas fa-calendar-check"></i> Gerenciar Reservas</a>
            <a href="<%=request.getContextPath()%>/pages/feedbackAdm.jsp"><i class="fas fa-comment-dots"></i> Gerenciar Feedbacks</a>
            <a href="<%=request.getContextPath()%>/pages/rankingAdm.jsp"><i class="fas fa-trophy"></i> Sistema de Ranking</a>
            <a href="<%=request.getContextPath()%>/pages/gestaoUsuario.jsp"><i class="fas fa-users"></i> Gestão de Usuários</a>
        </nav>
        
        <!-- Dashboard de Estatísticas -->
        <div class="stats-dashboard">
            <h2><i class="fas fa-chart-bar"></i> Estatísticas Gerais do Sistema</h2>
            <div class="dashboard-grid">
                <div class="dashboard-stat">
                    <div class="dashboard-value">247</div>
                    <div class="dashboard-label">Usuários Ativos</div>
                </div>
                <div class="dashboard-stat">
                    <div class="dashboard-value">1,823</div>
                    <div class="dashboard-label">Reservas Totais</div>
                </div>
                <div class="dashboard-stat">
                    <div class="dashboard-value">4.7</div>
                    <div class="dashboard-label">Avaliação Média</div>
                </div>
                <div class="dashboard-stat">
                    <div class="dashboard-value">89%</div>
                    <div class="dashboard-label">Taxa de Sucesso</div>
                </div>
            </div>
        </div>
        
        <!-- Filtros -->
        <div class="filter-tabs">
            <button class="filter-tab active" onclick="filterRanking('top-geral')">
                <i class="fas fa-trophy"></i> Top 10 Geral
            </button>
            <button class="filter-tab" onclick="filterRanking('top-semana')">
                <i class="fas fa-fire"></i> Top 10 da Semana
            </button>
            <button class="filter-tab" onclick="filterRanking('todos-locatarios')">
                <i class="fas fa-users"></i> Todos os Locatários
            </button>
            <button class="filter-tab" onclick="filterRanking('problematicos')">
                <i class="fas fa-exclamation-triangle"></i> Usuários Problemáticos
            </button>
        </div>
        
        <!-- Filtros de Localização para Administrador -->
        <div class="location-filters" style="background: white; border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);">
            <h3 style="color: #333; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-filter"></i> Filtros Administrativos
            </h3>
            <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: end;">
                <div style="flex: 1; min-width: 180px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">País:</label>
                    <select id="paisFilter" style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;" onchange="filterByLocation()">
                        <option value="">Todos os países</option>
                        <option value="Brasil">Brasil</option>
                        <option value="Argentina">Argentina</option>
                        <option value="Chile">Chile</option>
                    </select>
                </div>
                <div style="flex: 1; min-width: 180px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">Estado:</label>
                    <select id="estadoFilter" style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;" onchange="filterByLocation()">
                        <option value="">Todos os estados</option>
                        <option value="SP">São Paulo</option>
                        <option value="RJ">Rio de Janeiro</option>
                        <option value="MG">Minas Gerais</option>
                        <option value="RS">Rio Grande do Sul</option>
                    </select>
                </div>
                <div style="flex: 1; min-width: 180px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">Cidade:</label>
                    <select id="cidadeFilter" style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;" onchange="filterByLocation()">
                        <option value="">Todas as cidades</option>
                        <option value="São Paulo">São Paulo</option>
                        <option value="Rio de Janeiro">Rio de Janeiro</option>
                        <option value="Belo Horizonte">Belo Horizonte</option>
                        <option value="Porto Alegre">Porto Alegre</option>
                    </select>
                </div>
                <div style="flex: 1; min-width: 180px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">Status:</label>
                    <select id="statusFilter" style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;" onchange="filterByStatus()">
                        <option value="">Todos</option>
                        <option value="ativo">Ativos</option>
                        <option value="suspenso">Suspensos</option>
                        <option value="advertencia">Com Advertência</option>
                    </select>
                </div>
                <div>
                    <button onclick="clearAllFilters()" style="background: #6c757d; color: white; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-weight: 600; cursor: pointer;">
                        <i class="fas fa-times"></i> Limpar Filtros
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Ranking Grid -->
        <div class="ranking-grid">
            <!-- TOP 10 GERAL - 1º Lugar - Baseado no modelo Ranking -->
            <div class="ranking-card" data-category="top-geral" data-location="São Paulo,SP,Brasil" data-status="ativo">
                <div class="ranking-header">
                    <div class="ranking-position first">1º</div>
                    <div class="ranking-category">TOP GERAL</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user3.jpg" alt="Maria Silva Santos" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/dc3545/ffffff?text=MS'">
                    <div class="user-details">
                        <h3>Maria Silva Santos</h3>
                        <div class="user-type">Locatário Premium - ATIVO</div>
                        <div class="join-date">São Paulo, SP, Brasil - 2.850 pontos</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">47</span>
                        <span class="stat-label">Aluguéis</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">2.850</span>
                        <span class="stat-label">Pontos Total</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">85</span>
                        <span class="stat-label">Pontos Semana</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Avaliação:</span>
                        <div>
                            <span class="rating-stars">★★★★★</span>
                            <span class="rating-value">5.0/5.0</span>
                        </div>
                    </div>
                    <div class="rating-row">
                        <span>Última Atividade:</span>
                        <span class="rating-value">Hoje</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement gold">👑 Campeão Geral</span>
                    <span class="achievement">🛡️ Usuário Modelo</span>
                    <span class="achievement">� Excelência</span>
                </div>
                <div class="ranking-actions">
                    <a href="#" class="btn btn-info" onclick="viewUserProfile('maria.santos')">
                        <i class="fas fa-user"></i> Ver Perfil
                    </a>
                    <a href="#" class="btn btn-success" onclick="promoteUser('maria.santos')">
                        <i class="fas fa-medal"></i> Destacar
                    </a>
                </div>
            </div>

            <!-- TOP 10 GERAL - 2º Lugar -->
            <div class="ranking-card" data-category="top-geral" data-location="Rio de Janeiro,RJ,Brasil" data-status="ativo">
                <div class="ranking-header">
                    <div class="ranking-position second">2º</div>
                    <div class="ranking-category">TOP GERAL</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user4.jpg" alt="João Silva" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/ffc107/000000?text=JS'">
                    <div class="user-details">
                        <h3>João Silva</h3>
                        <div class="user-type">Locatário Expert - ATIVO</div>
                        <div class="join-date">Rio de Janeiro, RJ - 2.180 pontos</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">132</span>
                        <span class="stat-label">Aluguéis</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">2.180</span>
                        <span class="stat-label">Pontos</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">1</span>
                        <span class="stat-label">Problemas</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Avaliação:</span>
                        <div>
                            <span class="rating-stars">★★★★★</span>
                            <span class="rating-value">4.9/5.0</span>
                        </div>
                    </div>
                    <div class="rating-row">
                        <span>Última Atividade:</span>
                        <span class="rating-value">Ontem</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement silver">🥈 Vice-Campeão</span>
                    <span class="achievement">⭐ Consistente</span>
                    <span class="achievement">� Comunicativo</span>
                </div>
                <div class="ranking-actions">
                    <a href="#" class="btn btn-info" onclick="viewUserProfile('joao.silva')">
                        <i class="fas fa-user"></i> Ver Perfil
                    </a>
                    <a href="#" class="btn btn-primary" onclick="sendMessage('joao.silva')">
                        <i class="fas fa-envelope"></i> Mensagem
                    </a>
                </div>
            </div>

            <!-- TOP 10 DA SEMANA - 1º Lugar -->
            <div class="ranking-card" data-category="top-semana" data-location="Porto Alegre,RS,Brasil" data-status="ativo">
                <div class="ranking-header">
                    <div class="ranking-position first">1º</div>
                    <div class="ranking-category">TOP DA SEMANA</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user7.jpg" alt="Carlos Mendes" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/28a745/ffffff?text=CM'">
                    <div class="user-details">
                        <h3>Carlos Mendes</h3>
                        <div class="user-type">Locatário em Alta - ATIVO</div>
                        <div class="join-date">Porto Alegre, RS - 285 pontos esta semana</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">18</span>
                        <span class="stat-label">Aluguéis Semana</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">285</span>
                        <span class="stat-label">Pontos Semana</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">0</span>
                        <span class="stat-label">Problemas</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Distância Semana:</span>
                        <span class="rating-value">285 km</span>
                    </div>
                    <div class="rating-row">
                        <span>Crescimento:</span>
                        <span class="rating-value">+45% vs semana anterior</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement gold">� Destaque da Semana</span>
                    <span class="achievement">⚡ Super Ativo</span>
                    <span class="achievement">� Em Crescimento</span>
                </div>
                <div class="ranking-actions">
                    <a href="#" class="btn btn-info" onclick="viewUserProfile('carlos.mendes')">
                        <i class="fas fa-user"></i> Ver Perfil
                    </a>
                    <a href="#" class="btn btn-success" onclick="giveReward('carlos.mendes')">
                        <i class="fas fa-gift"></i> Premiar
                    </a>
                </div>
            </div>

            <!-- TODOS OS LOCATÁRIOS - Participante Normal -->
            <div class="ranking-card" data-category="todos-locatarios" data-location="Belo Horizonte,MG,Brasil" data-status="advertencia">
                <div class="ranking-header">
                    <div class="ranking-position">8º</div>
                    <div class="ranking-category">LOCATÁRIO</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user6.jpg" alt="Ana Costa" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/ffc107/000000?text=AC'">
                    <div class="user-details">
                        <h3>Ana Costa</h3>
                        <div class="user-type">Locatário Regular - ADVERTÊNCIA</div>
                        <div class="join-date">Belo Horizonte, MG - 1.250 pontos</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">68</span>
                        <span class="stat-label">Aluguéis</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">1.250</span>
                        <span class="stat-label">Pontos</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">3</span>
                        <span class="stat-label">Problemas</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Avaliação:</span>
                        <div>
                            <span class="rating-stars">★★★☆☆</span>
                            <span class="rating-value">3.8/5.0</span>
                        </div>
                    </div>
                    <div class="rating-row">
                        <span>Motivo Advertência:</span>
                        <span class="rating-value">Atrasos recorrentes</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement" style="background: #ffc107; color: #000;">⚠️ Advertência Ativa</span>
                    <span class="achievement">� Plano de Melhoria</span>
                </div>
                <div class="ranking-actions">
                    <a href="#" class="btn btn-info" onclick="viewUserProfile('ana.costa')">
                        <i class="fas fa-user"></i> Ver Perfil
                    </a>
                    <a href="#" class="btn" style="background: #ffc107; color: #000;" onclick="manageWarning('ana.costa')">
                        <i class="fas fa-exclamation-triangle"></i> Gerenciar Advertência
                    </a>
                </div>
            </div>

            <!-- Usuário Problemático -->
            <div class="ranking-card" data-category="problematicos" data-location="Curitiba,PR,Brasil" data-status="suspenso">
                <div class="ranking-header">
                    <div class="ranking-position" style="background: linear-gradient(135deg, #dc3545, #c82333);">⚠️</div>
                    <div class="ranking-category">SUSPENSO</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user5.jpg" alt="Pedro Costa" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/dc3545/ffffff?text=PC'">
                    <div class="user-details">
                        <h3>Pedro Costa</h3>
                        <div class="user-type">Locatário - SUSPENSO</div>
                        <div class="join-date">Curitiba, PR - Suspenso até 15/08/2025</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">23</span>
                        <span class="stat-label">Aluguéis</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">450</span>
                        <span class="stat-label">Pontos</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">8</span>
                        <span class="stat-label">Problemas</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Avaliação:</span>
                        <div>
                            <span class="rating-stars">★★☆☆☆</span>
                            <span class="rating-value">2.1/5.0</span>
                        </div>
                    </div>
                    <div class="rating-row">
                        <span>Motivo Suspensão:</span>
                        <span class="rating-value">Danos às bicicletas</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement" style="background: linear-gradient(135deg, #dc3545, #c82333);">🚫 Suspenso</span>
                    <span class="achievement" style="background: linear-gradient(135deg, #6c757d, #495057);">� Requer Revisão</span>
                </div>
                <div class="ranking-actions">
                    <a href="#" class="btn btn-info" onclick="viewUserProfile('pedro.costa')">
                        <i class="fas fa-user"></i> Ver Perfil
                    </a>
                    <a href="#" class="btn" style="background: #dc3545; color: white;" onclick="manageSuspension('pedro.costa')">
                        <i class="fas fa-ban"></i> Gerenciar Suspensão
                    </a>
                    <a href="#" class="btn" style="background: #28a745; color: white;" onclick="reviewAccount('pedro.costa')">
                        <i class="fas fa-gavel"></i> Revisar Conta
                    </a>
                </div>
            </div>

            </div>
        </div>
        
        <div class="back-button">
            <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar ao Painel Admin
            </a>
        </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        function filterRanking(category) {
            // Remove active class from all tabs
            document.querySelectorAll('.filter-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Add active class to clicked tab
            event.target.classList.add('active');
            
            // Show/hide ranking cards based on category
            document.querySelectorAll('.ranking-card').forEach(card => {
                if (category === 'todos-locatarios') {
                    card.style.display = 'block';
                } else if (card.dataset.category === category) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        function filterByLocation() {
            const pais = document.getElementById('paisFilter').value;
            const estado = document.getElementById('estadoFilter').value;
            const cidade = document.getElementById('cidadeFilter').value;
            
            document.querySelectorAll('.ranking-card').forEach(card => {
                const location = card.dataset.location;
                if (!location) return;
                
                const [cardCidade, cardEstado, cardPais] = location.split(',');
                
                let show = true;
                
                if (pais && cardPais !== pais) show = false;
                if (estado && cardEstado !== estado) show = false;
                if (cidade && cardCidade !== cidade) show = false;
                
                card.style.display = show ? 'block' : 'none';
            });
        }
        
        function filterByStatus() {
            const status = document.getElementById('statusFilter').value;
            
            document.querySelectorAll('.ranking-card').forEach(card => {
                const cardStatus = card.dataset.status;
                
                if (!status || cardStatus === status) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        function clearAllFilters() {
            document.getElementById('paisFilter').value = '';
            document.getElementById('estadoFilter').value = '';
            document.getElementById('cidadeFilter').value = '';
            document.getElementById('statusFilter').value = '';
            
            // Show all cards
            document.querySelectorAll('.ranking-card').forEach(card => {
                card.style.display = 'block';
            });
        }
        
        function viewUserProfile(username) {
            alert('Visualizar perfil completo de: ' + username + '\n\n' +
                  'Informações disponíveis:\n' +
                  '• Histórico completo de atividades\n' +
                  '• Dados de contato e localização\n' +
                  '• Estatísticas detalhadas\n' +
                  '• Feedbacks recebidos e dados\n' +
                  '• Relatórios de problemas\n' +
                  '• Status da conta e advertências');
        }
        
        function promoteUser(username) {
            if (confirm('Destacar usuário ' + username + ' no sistema?\n\nEste usuário aparecerá em destaque nas páginas principais.')) {
                alert('Usuário ' + username + ' foi destacado com sucesso!\n\n' +
                      'Benefícios aplicados:\n' +
                      '• Badge de usuário destacado\n' +
                      '• Prioridade em resultados de busca\n' +
                      '• Notificação para outros usuários');
            }
        }
        
        function sendMessage(username) {
            const message = prompt('Digite a mensagem para ' + username + ':');
            if (message) {
                alert('Mensagem enviada para ' + username + ': "' + message + '"\n\n' +
                      'A mensagem será entregue via:\n' +
                      '• Notificação no sistema\n' +
                      '• Email (se configurado)\n' +
                      '• SMS (para assuntos urgentes)');
            }
        }
        
        function giveReward(username) {
            const rewards = {
                '1': 'Desconto de 10% em próximos aluguéis',
                '2': 'Badge especial de usuário exemplar',
                '3': 'Pontos bônus no ranking (50 pontos)',
                '4': 'Acesso antecipado a novas funcionalidades'
            };
            
            const choice = prompt('Escolha uma recompensa para ' + username + ':\n\n' +
                                '1 - Desconto de 10%\n' +
                                '2 - Badge especial\n' +
                                '3 - 50 pontos bônus\n' +
                                '4 - Acesso antecipado\n\n' +
                                'Digite o número da recompensa:');
            
            if (choice && rewards[choice]) {
                alert('Recompensa enviada para ' + username + '!\n\n' +
                      'Recompensa: ' + rewards[choice] + '\n\n' +
                      'O usuário receberá uma notificação sobre a recompensa.');
            }
        }
        
        function manageWarning(username) {
            const actions = {
                '1': 'Remover advertência',
                '2': 'Estender prazo para melhoria',
                '3': 'Aplicar suspensão temporária',
                '4': 'Agendar revisão da conta'
            };
            
            const action = prompt('Gerenciar advertência de ' + username + ':\n\n' +
                                '1 - Remover advertência\n' +
                                '2 - Estender prazo\n' +
                                '3 - Aplicar suspensão\n' +
                                '4 - Agendar revisão\n\n' +
                                'Digite o número da ação:');
            
            if (action && actions[action]) {
                const details = prompt('Adicione detalhes ou justificativa:');
                if (details) {
                    alert('Ação aplicada para ' + username + ':\n\n' +
                          'Ação: ' + actions[action] + '\n' +
                          'Detalhes: ' + details + '\n\n' +
                          'Registro adicionado ao histórico do usuário.');
                }
            }
        }
        
        function manageSuspension(username) {
            const actions = {
                '1': 'Revogar suspensão imediatamente',
                '2': 'Reduzir tempo de suspensão',
                '3': 'Estender tempo de suspensão',
                '4': 'Converter em advertência final'
            };
            
            const action = prompt('Gerenciar suspensão de ' + username + ':\n\n' +
                                '1 - Revogar suspensão\n' +
                                '2 - Reduzir tempo\n' +
                                '3 - Estender tempo\n' +
                                '4 - Converter em advertência\n\n' +
                                'Digite o número da ação:');
            
            if (action && actions[action]) {
                const justification = prompt('Justificativa da ação:');
                if (justification) {
                    alert('Suspensão de ' + username + ' atualizada:\n\n' +
                          'Ação: ' + actions[action] + '\n' +
                          'Justificativa: ' + justification + '\n\n' +
                          'Usuário será notificado sobre a mudança.');
                }
            }
        }
        
        function reviewAccount(username) {
            const reviewTypes = {
                '1': 'Revisão completa da conta',
                '2': 'Análise de padrões de comportamento',
                '3': 'Verificação de identidade',
                '4': 'Avaliação para reabilitação'
            };
            
            const type = prompt('Tipo de revisão para ' + username + ':\n\n' +
                               '1 - Revisão completa\n' +
                               '2 - Análise comportamental\n' +
                               '3 - Verificação de identidade\n' +
                               '4 - Avaliação reabilitação\n\n' +
                               'Digite o número do tipo:');
            
            if (type && reviewTypes[type]) {
                alert('Revisão agendada para ' + username + ':\n\n' +
                      'Tipo: ' + reviewTypes[type] + '\n' +
                      'Status: Pendente\n' +
                      'Prazo: 5 dias úteis\n\n' +
                      'Equipe de moderação foi notificada.');
            }
        }
        
        // Initialize with first category visible
        document.addEventListener('DOMContentLoaded', function() {
            filterRanking('top-geral');
        });
    </script>
</body>
</html>