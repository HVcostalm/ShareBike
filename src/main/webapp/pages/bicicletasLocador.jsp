<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Minhas Bicicletas - Locador</title>
    <link rel="stylesheet" href="../assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <h1><i class="fas fa-bicycle"></i> Minhas Bicicletas - Painel do Locador</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocador.jsp"><i class="fas fa-bicycle"></i> Minhas Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasLocador.jsp"><i class="fas fa-calendar-check"></i> Reservas Recebidas</a>
            <a href="<%=request.getContextPath()%>/pages/fazerFeedbackLocador.jsp"><i class="fas fa-comment-dots"></i> Feedbacks</a>
            <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp"><i class="fas fa-calendar-alt"></i> Definir Disponibilidade</a>
            <a href="<%=request.getContextPath()%>/pages/cadastrarBicicleta.jsp" class="btn btn-success">
                <i class="fas fa-plus"></i> Cadastrar Nova Bicicleta
            </a>
        </nav>
        
        <div class="search-filter">
            <h3><i class="fas fa-search"></i> Buscar Minhas Bicicletas</h3>
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
                    <label for="filter-availability">Status:</label>
                    <select id="filter-availability">
                        <option value="">Todos os status</option>
                        <option value="disponivel">Disponível</option>
                        <option value="reservada">Reservada</option>
                        <option value="indisponivel">Indisponível</option>
                    </select>
                </div>
            </div>
        </div>
        
        <div class="bike-grid">
            <!-- Bicicleta 1 do Locador - Baseada no modelo Bicicleta -->
            <div class="bike-card">
                <img src="../assets/images/mybike1.jpg" alt="Mountain Explorer MX-2024" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/38b2ac/ffffff?text=Mountain+Explorer+MX-2024'">
                <div class="bike-name">Mountain Explorer MX-2024</div>
                <div class="bike-details">
                    <i class="fas fa-mountain"></i> Mountain<br>
                    <i class="fas fa-map-marker-alt"></i> Parque Ibirapuera, São Paulo - SP<br>
                    <i class="fas fa-cogs"></i> Estado: EXCELENTE<br>
                    <i class="fas fa-barcode"></i> Chassi: CEP001
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                    4.5/5.0 (12 avaliações)
                </div>
                <div class="bike-status status-disponivel">Disponível</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('1')">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="#" class="btn btn-warning" onclick="editBike('1')">
                        <i class="fas fa-edit"></i> Editar
                    </a>
                    <a href="#" class="btn btn-primary" onclick="setAvailability('1')">
                        <i class="fas fa-calendar"></i> Disponibilidade
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta 2 do Locador - Baseada no modelo Bicicleta -->
            <div class="bike-card">
                <img src="../assets/images/mybike2.jpg" alt="Speed Urbana SP-2024" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/007bff/ffffff?text=Speed+Urbana'">
                <div class="bike-name">Speed Urbana SP-2024</div>
                <div class="bike-details">
                    <i class="fas fa-city"></i> Urbana<br>
                    <i class="fas fa-map-marker-alt"></i> Av. Paulista, São Paulo - SP<br>
                    <i class="fas fa-cogs"></i> Estado: BOM<br>
                    <i class="fas fa-barcode"></i> Chassi: OCL002
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                    4.0/5.0 (8 avaliações)
                </div>
                <div class="bike-status status-reservada">Reservada até 15/08/2025</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('2')">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="#" class="btn btn-warning" onclick="editBike('2')">
                        <i class="fas fa-edit"></i> Editar
                    </a>
                    <a href="#" class="btn btn-primary" onclick="viewCurrentReservation('2')">
                        <i class="fas fa-user"></i> Reserva Atual
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta 3 do Locador - Baseada no modelo Bicicleta -->
            <div class="bike-card">
                <img src="../assets/images/mybike3.jpg" alt="BMX Pro BX-2024" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/28a745/ffffff?text=BMX+Pro'">
                <div class="bike-name">BMX Pro BX-2024</div>
                <div class="bike-details">
                    <i class="fas fa-road"></i> Speed<br>
                    <i class="fas fa-map-marker-alt"></i> Vila Madalena, São Paulo - SP<br>
                    <i class="fas fa-cogs"></i> Estado: ÓTIMA<br>
                    <i class="fas fa-barcode"></i> Chassi: SSA003
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    4.9/5.0 (15 avaliações)
                </div>
                <div class="bike-status status-disponivel">Disponível</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('3')">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="#" class="btn btn-warning" onclick="editBike('3')">
                        <i class="fas fa-edit"></i> Editar
                    </a>
                    <a href="#" class="btn btn-primary" onclick="setAvailability('3')">
                        <i class="fas fa-calendar"></i> Disponibilidade
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Estatísticas do Locador -->
        <div class="search-filter">
            <h3><i class="fas fa-chart-bar"></i> Minhas Estatísticas</h3>
            <div class="filter-row">
                <div class="filter-group">
                    <label>Total de Bicicletas:</label>
                    <div style="font-size: 1.5rem; font-weight: bold; color: #38b2ac;">3</div>
                </div>
                <div class="filter-group">
                    <label>Bicicletas Disponíveis:</label>
                    <div style="font-size: 1.5rem; font-weight: bold; color: #28a745;">2</div>
                </div>
                <div class="filter-group">
                    <label>Total de Reservas:</label>
                    <div style="font-size: 1.5rem; font-weight: bold; color: #007bff;">1</div>
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
        // As demais funções permanecem inalteradas
        
        function viewDetails(bikeId) {
            // Redirecionar para página de detalhes do locador
            window.location.href = '<%=request.getContextPath()%>/pages/bicicletaDetalhesLocador.jsp?id=' + bikeId;
        }
        
        function editBike(bikeId) {
            window.location.href = '<%=request.getContextPath()%>/pages/editarBicicleta.jsp?id=' + bikeId;
        }
        
        function setAvailability(bikeId) {
            window.location.href = '<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp?id=' + bikeId;
        }
        
        function viewCurrentReservation(bikeId) {
            window.location.href = '<%=request.getContextPath()%>/pages/detalheReservaLocador.jsp?id=' + bikeId;
        }
        
        console.log('Página de Bicicletas do Locador carregada');
        
        // Filtros de busca
        document.getElementById('search-name').addEventListener('input', filterBikes);
        document.getElementById('filter-type').addEventListener('change', filterBikes);
        document.getElementById('filter-availability').addEventListener('change', filterBikes);
        
        function filterBikes() {
            const searchName = document.getElementById('search-name').value.toLowerCase();
            const filterType = document.getElementById('filter-type').value.toLowerCase();
            const filterAvailability = document.getElementById('filter-availability').value.toLowerCase();
            
            const bikeCards = document.querySelectorAll('.bike-card');
            
            bikeCards.forEach(card => {
                const bikeName = card.querySelector('.bike-name').textContent.toLowerCase();
                const bikeDetails = card.querySelector('.bike-details').textContent.toLowerCase();
                const bikeStatus = card.querySelector('.bike-status').textContent.toLowerCase();
                
                const matchesName = bikeName.includes(searchName);
                const matchesType = filterType === '' || bikeDetails.includes(filterType);
                const matchesAvailability = filterAvailability === '' || bikeStatus.includes(filterAvailability);
                
                if (matchesName && matchesType && matchesAvailability) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>