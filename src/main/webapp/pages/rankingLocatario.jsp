<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ranking - Locatário</title>
    <link rel="stylesheet" href="../assets/css/ranking.css">
    <link rel="stylesheet" href="https:/s.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <h1><i class="fas fa-trophy"></i> Ranking e Leaderboards</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocatario.jsp"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasLocatario.jsp"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="<%=request.getContextPath()%>/pages/fazerFeedbackLocatario.jsp"><i class="fas fa-comment-dots"></i> Dar Feedback</a>
            <a href="<%=request.getContextPath()%>/pages/fazerReserva.jsp"><i class="fas fa-calendar-plus"></i> Nova Reserva</a>
            <a href="<%=request.getContextPath()%>/pages/rankingLocatario.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <!-- Minha Posição -->
        <div class="stats-dashboard">
            <h2><i class="fas fa-user-circle"></i> Minha Posição no Ranking</h2>
            <div class="dashboard-grid">
                <div class="dashboard-stat">
                    <div class="dashboard-value">12º</div>
                    <div class="dashboard-label">Posição Geral</div>
                </div>
                <div class="dashboard-stat">
                    <div class="dashboard-value">4.7</div>
                    <div class="dashboard-label">Minha Avaliação</div>
                </div>
                <div class="dashboard-stat">
                    <div class="dashboard-value">23</div>
                    <div class="dashboard-label">Aluguéis Realizados</div>
                </div>
                <div class="dashboard-stat">
                    <div class="dashboard-value">95%</div>
                    <div class="dashboard-label">Taxa de Sucesso</div>
                </div>
            </div>
        </div>
        
        <!-- Ações Rápidas -->
        <div class="quick-actions" style="background: white; border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);">
            <h3 style="color: #333; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-bolt"></i> Ações Rápidas
            </h3>
            <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                <a href="<%=request.getContextPath()%>/pages/informarDistancia.jsp" style="background: linear-gradient(135deg, #ffc107, #e0a800); color: #212529; padding: 0.8rem 1.5rem; border-radius: 10px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='translateY(0)'">
                    <i class="fas fa-route"></i> Informar Distância Percorrida
                </a>
                <a href="<%=request.getContextPath()%>/pages/reservasLocatario.jsp" style="background: linear-gradient(135deg, #007bff, #0056b3); color: white; padding: 0.8rem 1.5rem; border-radius: 10px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='translateY(0)'">
                    <i class="fas fa-calendar-check"></i> Minhas Reservas
                </a>
                <a href="<%=request.getContextPath()%>/pages/fazerReserva.jsp" style="background: linear-gradient(135deg, #28a745, #20c997); color: white; padding: 0.8rem 1.5rem; border-radius: 10px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 0.5rem; transition: all 0.3s ease;" onmouseover="this.style.transform='translateY(-2px)'" onmouseout="this.style.transform='translateY(0)'">
                    <i class="fas fa-plus"></i> Nova Reserva
                </a>
            </div>
            <div style="background: #e3f2fd; border-radius: 8px; padding: 1rem; margin-top: 1rem;">
                <p style="margin: 0; color: #0c5460;">
                    <i class="fas fa-info-circle"></i> 
                    <strong>Ganhe pontos:</strong> Informe a distância das suas viagens finalizadas para ganhar pontos no ranking! 1 km = 1 ponto.
                </p>
            </div>
        </div>
        
        <!-- Filtros de Ranking -->
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
        </div>
        
        <!-- Filtros de Localização -->
        <div class="location-filters" style="background: white; border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);">
            <h3 style="color: #333; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-map-marker-alt"></i> Filtrar por Localização
            </h3>
            <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: end;">
                <div style="flex: 1; min-width: 200px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">País:</label>
                    <select id="paisFilter" style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;" onchange="filterByLocation()">
                        <option value="">Todos os países</option>
                        <option value="Brasil">Brasil</option>
                        <option value="Argentina">Argentina</option>
                        <option value="Chile">Chile</option>
                        <option value="Uruguai">Uruguai</option>
                    </select>
                </div>
                <div style="flex: 1; min-width: 200px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">Estado:</label>
                    <select id="estadoFilter" style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;" onchange="filterByLocation()">
                        <option value="">Todos os estados</option>
                        <option value="SP">São Paulo</option>
                        <option value="RJ">Rio de Janeiro</option>
                        <option value="MG">Minas Gerais</option>
                        <option value="RS">Rio Grande do Sul</option>
                        <option value="PR">Paraná</option>
                        <option value="SC">Santa Catarina</option>
                    </select>
                </div>
                <div style="flex: 1; min-width: 200px;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #555;">Cidade:</label>
                    <select id="cidadeFilter" style="width: 100%; padding: 0.8rem; border: 2px solid #e9ecef; border-radius: 8px; font-size: 1rem;" onchange="filterByLocation()">
                        <option value="">Todas as cidades</option>
                        <option value="São Paulo">São Paulo</option>
                        <option value="Rio de Janeiro">Rio de Janeiro</option>
                        <option value="Belo Horizonte">Belo Horizonte</option>
                        <option value="Porto Alegre">Porto Alegre</option>
                        <option value="Curitiba">Curitiba</option>
                        <option value="Florianópolis">Florianópolis</option>
                    </select>
                </div>
                <div>
                    <button onclick="clearLocationFilters()" style="background: #6c757d; color: white; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all 0.3s ease;" onmouseover="this.style.background='#545b62'" onmouseout="this.style.background='#6c757d'">
                        <i class="fas fa-times"></i> Limpar Filtros
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Ranking Grid -->
        <div class="ranking-grid">
            <!-- TOP 10 GERAL - 1º Lugar - Baseado no modelo Ranking -->
            <div class="ranking-card" data-category="top-geral" data-location="São Paulo,SP,Brasil">
                <div class="ranking-header">
                    <div class="ranking-position first">1º</div>
                    <div class="ranking-category">TOP GERAL</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user3.jpg" alt="Maria Silva Santos" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/ffd700/000000?text=MS'">
                    <div class="user-details">
                        <h3>Maria Silva Santos</h3>
                        <div class="user-type">Locatário Premium</div>
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
                            <span class="rating-stars">★★★★☆</span>
                            <span class="rating-value">4.5/5.0</span>
                        </div>
                    </div>
                    <div class="rating-row">
                        <span>Esta semana:</span>
                        <span class="rating-value">+85 pontos</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement gold">👑 Campeão Geral</span>
                    <span class="achievement">🎯 Consistente</span>
                    <span class="achievement">💎 Top Semanal</span>
                </div>
            </div>

            <!-- TOP 10 GERAL - 2º Lugar - Baseado no modelo Ranking -->
            <div class="ranking-card" data-category="top-geral" data-location="Rio de Janeiro,RJ,Brasil">
                <div class="ranking-header">
                    <div class="ranking-position second">2º</div>
                    <div class="ranking-category">TOP GERAL</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user4.jpg" alt="João Carlos Silva" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/c0c0c0/000000?text=JS'">
                    <div class="user-details">
                        <h3>João Carlos Silva</h3>
                        <div class="user-type">Locatário Expert</div>
                        <div class="join-date">Rio de Janeiro, RJ, Brasil - 2.620 pontos</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">39</span>
                        <span class="stat-label">Aluguéis</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">2.620</span>
                        <span class="stat-label">Pontos Total</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">78</span>
                        <span class="stat-label">Pontos Semana</span>
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
                        <span>Esta semana:</span>
                        <span class="rating-value">+78 pontos</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement silver">🥈 Vice-Campeão</span>
                    <span class="achievement">⭐ Avaliação Máxima</span>
                    <span class="achievement">💬 Comunicativo</span>
                </div>
            </div>

            <!-- TOP 10 GERAL - 3º Lugar - Baseado no modelo Ranking -->
            <div class="ranking-card" data-category="top-geral" data-location="Belo Horizonte,MG,Brasil">
                <div class="ranking-header">
                    <div class="ranking-position third">3º</div>
                    <div class="ranking-category">TOP GERAL</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user6.jpg" alt="Fernanda Costa Lima" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/cd7f32/ffffff?text=FL'">
                    <div class="user-details">
                        <h3>Fernanda Costa Lima</h3>
                        <div class="user-type">Locatário Ativo</div>
                        <div class="join-date">Belo Horizonte, MG, Brasil - 2.340 pontos</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">31</span>
                        <span class="stat-label">Aluguéis</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">2.340</span>
                        <span class="stat-label">Pontos Total</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">65</span>
                        <span class="stat-label">Pontos Semana</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Avaliação:</span>
                        <div>
                            <span class="rating-stars">★★★★☆</span>
                            <span class="rating-value">4.2/5.0</span>
                        </div>
                    </div>
                    <div class="rating-row">
                        <span>Esta semana:</span>
                        <span class="rating-value">+65 pontos</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement bronze">🥉 3º Lugar</span>
                    <span class="achievement">🌟 Em Crescimento</span>
                    <span class="achievement">🚀 Promissora</span>
                </div>
            </div>

            <!-- TOP 10 DA SEMANA - 1º Lugar -->
            <div class="ranking-card" data-category="top-semana" data-location="Porto Alegre,RS,Brasil">
                <div class="ranking-header">
                    <div class="ranking-position first">1º</div>
                    <div class="ranking-category">TOP DA SEMANA</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user7.jpg" alt="Carlos Augusto Mendes" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/ff6b35/ffffff?text=CM'">
                    <div class="user-details">
                        <h3>Carlos Augusto Mendes</h3>
                        <div class="user-type">Locatário em Alta</div>
                        <div class="join-date">Porto Alegre, RS, Brasil - 125 pontos esta semana</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">8</span>
                        <span class="stat-label">Aluguéis Semana</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">125</span>
                        <span class="stat-label">Pontos Semana</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">1.680</span>
                        <span class="stat-label">Pontos Total</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Avaliação:</span>
                        <div>
                            <span class="rating-stars">★★★★☆</span>
                            <span class="rating-value">4.3/5.0</span>
                        </div>
                    </div>
                    <div class="rating-row">
                        <span>Meta semanal:</span>
                        <span class="rating-value">125% atingida</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement gold">🔥 Destaque da Semana</span>
                    <span class="achievement">⚡ Super Ativo</span>
                    <span class="achievement">� Em Alta</span>
                </div>
            </div>

            <!-- TOP 10 DA SEMANA - 2º Lugar -->
            <div class="ranking-card" data-category="top-semana" data-location="Curitiba,PR,Brasil">
                <div class="ranking-header">
                    <div class="ranking-position second">2º</div>
                    <div class="ranking-category">TOP DA SEMANA</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user8.jpg" alt="Ana Costa" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/28a745/ffffff?text=AC'">
                    <div class="user-details">
                        <h3>Ana Costa</h3>
                        <div class="user-type">Locatário Dedicado</div>
                        <div class="join-date">Curitiba, PR - 250 pontos esta semana</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">15</span>
                        <span class="stat-label">Aluguéis Semana</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">250</span>
                        <span class="stat-label">Pontos Semana</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">98%</span>
                        <span class="stat-label">Taxa Sucesso</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Distância Semana:</span>
                        <span class="rating-value">250 km</span>
                    </div>
                    <div class="rating-row">
                        <span>Média Diária:</span>
                        <span class="rating-value">35.7 km</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement silver">🥈 2º da Semana</span>
                    <span class="achievement">💪 Forte Performance</span>
                    <span class="achievement">🎯 Focada</span>
                </div>
            </div>

            <!-- TODOS OS LOCATÁRIOS - Participantes Adicionais -->
            <div class="ranking-card" data-category="todos-locatarios" data-location="Florianópolis,SC,Brasil">
                <div class="ranking-header">
                    <div class="ranking-position">4º</div>
                    <div class="ranking-category">RANKING GERAL</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/user9.jpg" alt="Pedro Santos" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/17a2b8/ffffff?text=PS'">
                    <div class="user-details">
                        <h3>Pedro Santos</h3>
                        <div class="user-type">Locatário Regular</div>
                        <div class="join-date">Florianópolis, SC - 1.650 pontos</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">87</span>
                        <span class="stat-label">Aluguéis</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">1.650</span>
                        <span class="stat-label">Pontos</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">93%</span>
                        <span class="stat-label">Taxa Sucesso</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Avaliação:</span>
                        <div>
                            <span class="rating-stars">★★★★☆</span>
                            <span class="rating-value">4.6/5.0</span>
                        </div>
                    </div>
                    <div class="rating-row">
                        <span>Distância Total:</span>
                        <span class="rating-value">1.650 km</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement">🏃 Ativo</span>
                    <span class="achievement">⭐ Bom Desempenho</span>
                </div>
            </div>

            <!-- Minha Posição Detalhada -->
            <div class="ranking-card" data-category="todos-locatarios" data-location="São Paulo,SP,Brasil" style="border: 3px solid #007bff;">
                <div class="ranking-header">
                    <div class="ranking-position" style="background: linear-gradient(135deg, #007bff, #0056b3);">12º</div>
                    <div class="ranking-category">MINHA POSIÇÃO</div>
                </div>
                <div class="user-info">
                    <img src="../assets/images/current-user.jpg" alt="Você" class="user-avatar" onerror="this.src='https://via.placeholder.com/60x60/007bff/ffffff?text=EU'">
                    <div class="user-details">
                        <h3>Você (Usuário Atual)</h3>
                        <div class="user-type">Locatário Ativo</div>
                        <div class="join-date">São Paulo, SP - 890 pontos</div>
                    </div>
                </div>
                <div class="statistics">
                    <div class="stat-item">
                        <span class="stat-value">47</span>
                        <span class="stat-label">Aluguéis</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">890</span>
                        <span class="stat-label">Pontos</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-value">89%</span>
                        <span class="stat-label">Taxa Sucesso</span>
                    </div>
                </div>
                <div class="rating-section">
                    <div class="rating-row">
                        <span>Minha Avaliação:</span>
                        <div>
                            <span class="rating-stars">★★★★☆</span>
                            <span class="rating-value">4.4/5.0</span>
                        </div>
                    </div>
                    <div class="rating-row">
                        <span>Para 11º lugar:</span>
                        <span class="rating-value">Faltam 60 pontos</span>
                    </div>
                </div>
                <div class="achievements">
                    <span class="achievement">📈 Subindo</span>
                    <span class="achievement">💪 Melhorando</span>
                    <span class="achievement">🎯 Focado</span>
                </div>
                <div class="ranking-actions">
                    <a href="#" class="btn btn-primary" onclick="viewMyProgress()">
                        <i class="fas fa-chart-line"></i> Meu Progresso
                    </a>
                    <a href="#" class="btn btn-success" onclick="viewImprovementTips()">
                        <i class="fas fa-lightbulb"></i> Dicas de Melhoria
                    </a>
                </div>
            </div>
        </div>
        
        <div class="back-button">
            <a href="<%=request.getContextPath()%>/pages/Perfil.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar ao Perfil
            </a>
        </div>
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
        
        function clearLocationFilters() {
            document.getElementById('paisFilter').value = '';
            document.getElementById('estadoFilter').value = '';
            document.getElementById('cidadeFilter').value = '';
            
            // Show all cards
            document.querySelectorAll('.ranking-card').forEach(card => {
                card.style.display = 'block';
            });
        }
        
        function followUser(username) {
            if (confirm('Seguir usuário ' + username + '?')) {
                alert('Agora você está seguindo ' + username + '! Você receberá notificações sobre suas atividades.');
            }
        }
        
        function viewPublicProfile(username) {
            alert('Visualizando perfil público de: ' + username);
        }
        
        function connectWithUser(username) {
            if (confirm('Enviar solicitação de conexão para ' + username + '?')) {
                alert('Solicitação de conexão enviada para ' + username + '!');
            }
        }
        
        function viewMyProgress() {
            alert('Visualizando seu progresso detalhado...\n\n' +
                  'Para alcançar a 11ª posição você precisa:\n' +
                  '• Ganhar mais 60 pontos\n' +
                  '• Realizar mais 8 aluguéis sem problemas\n' +
                  '• Melhorar pontualidade para 95%\n' +
                  '• Manter avaliação acima de 4.5\n\n' +
                  'Dica: Informe a distância das suas viagens para ganhar pontos!');
        }
        
        function viewImprovementTips() {
            alert('Dicas para melhorar sua posição no ranking:\n\n' +
                  '📊 Sistema de Pontuação:\n' +
                  '• 1 km percorrido = 1 ponto\n' +
                  '• Avaliação 5 estrelas = +5 pontos bônus\n' +
                  '• Zero problemas no mês = +10 pontos bônus\n\n' +
                  '✅ Como Melhorar:\n' +
                  '• Sempre chegue no horário combinado\n' +
                  '• Cuide bem das bicicletas\n' +
                  '• Mantenha boa comunicação\n' +
                  '• Deixe feedbacks construtivos\n' +
                  '• Informe sempre a distância percorrida\n' +
                  '• Seja respeitoso com os proprietários');
        }
        
        // Initialize with first category visible
        document.addEventListener('DOMContentLoaded', function() {
            filterRanking('top-geral');
        });
    </script>
</body>
</html>