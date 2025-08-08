<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestão de Bicicletas - Administrador</title>
    <link rel="stylesheet" href="../assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <div style="margin-bottom: 1rem;">
            <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" style="background: linear-gradient(135deg, #6c757d, #495057); color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-flex; align-items: center; gap: 0.5rem; font-weight: 600; transition: all 0.3s ease;">
                <i class="fas fa-arrow-left"></i> Voltar para Painel do Administrador
            </a>
        </div>
        <h1><i class="fas fa-bicycle"></i> Gestão de Bicicletas - Administrador</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasAdm.jsp"><i class="fas fa-list"></i> Todas as Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/gestaoUsuario.jsp"><i class="fas fa-users"></i> Gestão de Usuários</a>
            <a href="<%=request.getContextPath()%>/pages/reservasAdm.jsp"><i class="fas fa-calendar-check"></i> Reservas</a>
            <a href="<%=request.getContextPath()%>/pages/feedbackAdm.jsp"><i class="fas fa-comments"></i> Feedbacks</a>
            <a href="<%=request.getContextPath()%>/pages/rankingAdm.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <div class="search-filter">
            <h3><i class="fas fa-filter"></i> Filtros de Busca</h3>
            <div class="filter-row">
                <div class="filter-group">
                    <label for="search-name">Nome da Bicicleta:</label>
                    <input type="text" id="search-name" placeholder="Digite o nome da bicicleta">
                </div>
                <div class="filter-group">
                    <label for="filter-type">Tipo:</label>
                    <select id="filter-type">
                        <option value="">Todos os tipos</option>
                        <option value="urbana">Urbana</option>
                        <option value="mountain">Mountain Bike</option>
                        <option value="road">Speed/Road</option>
                        <option value="eletrica">Elétrica</option>
                        <option value="dobravel">Dobrável</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="filter-status">Estado:</label>
                    <select id="filter-status">
                        <option value="">Todos os estados</option>
                        <option value="excelente">Excelente</option>
                        <option value="bom">Bom</option>
                        <option value="regular">Regular</option>
                        <option value="manutencao">Manutenção</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="filter-city">Cidade:</label>
                    <input type="text" id="filter-city" placeholder="Digite a cidade">
                </div>
            </div>
        </div>
        
        <div class="bike-grid">
            <!-- Bicicleta 1 - Baseado no modelo Bicicleta -->
            <div class="bike-card">
                <img src="../assets/images/bike1.jpg" alt="Mountain Explorer" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/38b2ac/ffffff?text=Bike+1'">
                <div class="bike-name">Mountain Explorer MX-2024</div>
                <div class="bike-details">
                    <i class="fas fa-mountain"></i> Mountain<br>
                    <i class="fas fa-map-marker-alt"></i> Rua Augusta, 1500 - São Paulo, SP<br>
                    <i class="fas fa-user"></i> João Carlos Silva (11987654321)
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                    4.3/5.0
                </div>
                <div class="bike-status status-disponivel">Disponível - EXCELENTE</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('1')">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="#" class="btn btn-primary" onclick="viewReservations('1')">
                        <i class="fas fa-calendar"></i> Disponibilidade
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta 2 - Baseado no modelo Bicicleta -->
            <div class="bike-card">
                <img src="../assets/images/bike2.jpg" alt="Speed Urbana" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/007bff/ffffff?text=Bike+2'">
                <div class="bike-name">Speed Urbana SP-2024</div>
                <div class="bike-details">
                    <i class="fas fa-road"></i> Speed<br>
                    <i class="fas fa-map-marker-alt"></i> Av. Copacabana, 890 - Rio de Janeiro, RJ<br>
                    <i class="fas fa-user"></i> Maria Silva Santos (21987654321)
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                    4.0/5.0
                </div>
                <div class="bike-status status-ocupada">Reservada - ÓTIMA</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('2')">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="#" class="btn btn-primary" onclick="viewReservations('2')">
                        <i class="fas fa-calendar"></i> Disponibilidade
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta 3 - Baseado no modelo Bicicleta -->
            <div class="bike-card">
                <img src="../assets/images/bike3.jpg" alt="Urbana City" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/28a745/ffffff?text=Bike+3'">
                <div class="bike-name">Urbana City Life UB-2024</div>
                <div class="bike-details">
                    <i class="fas fa-city"></i> Urbana<br>
                    <i class="fas fa-map-marker-alt"></i> Rua dos Caetés, 245 - Belo Horizonte, MG<br>
                    <i class="fas fa-user"></i> Carlos Alberto Oliveira (31987654321)
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    5.0/5.0
                </div>
                <div class="bike-status status-disponivel">Disponível - EXCELENTE</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('3')">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="#" class="btn btn-primary" onclick="viewReservations('3')">
                        <i class="fas fa-calendar"></i> Disponibilidade
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta 4 -->
            <div class="bike-card">
                <img src="../assets/images/bike4.jpg" alt="Dobrável Compacta" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/ffc107/000000?text=Dobrável'">
                <div class="bike-name">Dobrável Compacta DB-2024</div>
                <div class="bike-details">
                    <i class="fas fa-bolt"></i> Elétrica<br>
                    <i class="fas fa-map-marker-alt"></i> Porto Alegre, RS<br>
                    <i class="fas fa-user"></i> Ana Paula (Ana101)
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                    <i class="far fa-star"></i>
                    3.0/5.0
                </div>
                <div class="bike-status status-manutencao">Em Manutenção</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('4')">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="#" class="btn btn-primary" onclick="viewReservations('4')">
                        <i class="fas fa-calendar"></i> Disponibilidade
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta 5 -->
            <div class="bike-card">
                <img src="../assets/images/bike5.jpg" alt="Dobravel Durban" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/17a2b8/ffffff?text=Bike+5'">
                <div class="bike-name">Durban Sampa Pro</div>
                <div class="bike-details">
                    <i class="fas fa-compress-alt"></i> Dobrável<br>
                    <i class="fas fa-map-marker-alt"></i> Curitiba, PR<br>
                    <i class="fas fa-user"></i> Pedro Costa (Pedro222)
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                    4.2/5.0
                </div>
                <div class="bike-status status-disponivel">Disponível</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('5')">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="#" class="btn btn-primary" onclick="viewReservations('5')">
                        <i class="fas fa-calendar"></i> Disponibilidade
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta 6 -->
            <div class="bike-card">
                <img src="../assets/images/bike6.jpg" alt="Giant Mountain" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/6c757d/ffffff?text=Bike+6'">
                <div class="bike-name">Giant ATX Elite</div>
                <div class="bike-details">
                    <i class="fas fa-mountain"></i> Mountain Bike<br>
                    <i class="fas fa-map-marker-alt"></i> Brasília, DF<br>
                    <i class="fas fa-user"></i> Luisa Ferreira (Luisa333)
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                    4.7/5.0
                </div>
                <div class="bike-status status-ocupada">Reservada</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('6')">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="#" class="btn btn-primary" onclick="viewReservations('6')">
                        <i class="fas fa-calendar"></i> Disponibilidade
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        function viewDetails(bikeId) {
            alert('Visualizar detalhes da bicicleta ID: ' + bikeId + '. Funcionalidade de visualização para administradores em desenvolvimento.');
            // Administradores apenas visualizam informações, não editam
        }
        
        function viewReservations(bikeId) {
            window.location.href = '<%=request.getContextPath()%>/pages/editarDisponibilidade.jsp?id=' + bikeId;
        }
        
        // Filtros de busca
        document.getElementById('search-name').addEventListener('input', filterBikes);
        document.getElementById('filter-type').addEventListener('change', filterBikes);
        document.getElementById('filter-status').addEventListener('change', filterBikes);
        document.getElementById('filter-city').addEventListener('input', filterBikes);
        
        function filterBikes() {
            const searchName = document.getElementById('search-name').value.toLowerCase();
            const filterType = document.getElementById('filter-type').value.toLowerCase();
            const filterStatus = document.getElementById('filter-status').value.toLowerCase();
            const filterCity = document.getElementById('filter-city').value.toLowerCase();
            
            const bikeCards = document.querySelectorAll('.bike-card');
            
            bikeCards.forEach(card => {
                const bikeName = card.querySelector('.bike-name').textContent.toLowerCase();
                const bikeDetails = card.querySelector('.bike-details').textContent.toLowerCase();
                const bikeStatus = card.querySelector('.bike-status').textContent.toLowerCase();
                
                const matchesName = bikeName.includes(searchName);
                const matchesType = filterType === '' || bikeDetails.includes(filterType);
                const matchesStatus = filterStatus === '' || bikeStatus.includes(filterStatus);
                const matchesCity = filterCity === '' || bikeDetails.includes(filterCity);
                
                if (matchesName && matchesType && matchesStatus && matchesCity) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>