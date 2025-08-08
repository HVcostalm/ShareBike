<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar Bicicletas - Locatário</title>
    <link rel="stylesheet" href="../assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <h1><i class="fas fa-search"></i> Buscar Bicicletas Disponíveis</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocatario.jsp"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasLocatario.jsp"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="<%=request.getContextPath()%>/pages/fazerFeedbackLocatario.jsp"><i class="fas fa-comment-dots"></i> Dar Feedback</a>
            <a href="<%=request.getContextPath()%>/pages/fazerReserva.jsp"><i class="fas fa-calendar-plus"></i> Fazer Reserva</a>
            <a href="<%=request.getContextPath()%>/pages/rankingLocatario.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <div class="search-filter">
            <h3><i class="fas fa-filter"></i> Filtros de Busca</h3>
            <div class="filter-row">
                <div class="filter-group">
                    <label for="search-location">Localização:</label>
                    <input type="text" id="search-location" placeholder="Digite cidade, bairro ou endereço">
                </div>
                <div class="filter-group">
                    <label for="filter-type">Tipo de Bicicleta:</label>
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
                    <label for="filter-rating">Avaliação Mínima:</label>
                    <select id="filter-rating">
                        <option value="">Qualquer avaliação</option>
                        <option value="4">4+ estrelas</option>
                        <option value="3">3+ estrelas</option>
                        <option value="2">2+ estrelas</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="search-date">Data Desejada:</label>
                    <input type="date" id="search-date">
                </div>
            </div>
        </div>
        
        <div class="bike-grid">
            <!-- Bicicleta Disponível 1 - Baseada no modelo Bicicleta -->
            <div class="bike-card">
                <img src="../assets/images/rent1.jpg" alt="Mountain Explorer MX-2024" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/38b2ac/ffffff?text=Mountain+Explorer'">
                <div class="bike-name">Mountain Explorer MX-2024</div>
                <div class="bike-details">
                    <i class="fas fa-mountain"></i> Mountain<br>
                    <i class="fas fa-map-marker-alt"></i> Parque Ibirapuera, São Paulo - SP<br>
                    <i class="fas fa-user"></i> Maria Silva Santos<br>
                    <i class="fas fa-cogs"></i> Estado: EXCELENTE<br>
                    <i class="fas fa-barcode"></i> ID: 1
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
                        <i class="fas fa-eye"></i> Ver Detalhes
                    </a>
                    <a href="#" class="btn btn-success" onclick="reserveBike('1')">
                        <i class="fas fa-calendar-plus"></i> Reservar
                    </a>
                    <a href="#" class="btn btn-primary" onclick="contactOwner('1')">
                        <i class="fas fa-comment"></i> Contatar
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta Disponível 2 - Baseada no modelo Bicicleta -->
            <div class="bike-card">
                <img src="../assets/images/rent2.jpg" alt="Speed Urbana SP-2024" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/007bff/ffffff?text=Speed+Urbana'">
                <div class="bike-name">Speed Urbana SP-2024</div>
                <div class="bike-details">
                    <i class="fas fa-road"></i> Speed<br>
                    <i class="fas fa-map-marker-alt"></i> Vila Madalena, São Paulo - SP<br>
                    <i class="fas fa-user"></i> Maria Silva Santos<br>
                    <i class="fas fa-cogs"></i> Estado: ÓTIMA<br>
                    <i class="fas fa-barcode"></i> ID: 3
                </div>
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                    4.0/5.0 (8 avaliações)
                </div>
                <div class="bike-status status-disponivel">Disponível</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('2')">
                        <i class="fas fa-eye"></i> Ver Detalhes
                    </a>
                    <a href="#" class="btn btn-success" onclick="reserveBike('2')">
                        <i class="fas fa-calendar-plus"></i> Reservar
                    </a>
                    <a href="#" class="btn btn-primary" onclick="contactOwner('2')">
                        <i class="fas fa-comment"></i> Contatar
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta Disponível 3 -->
            <div class="bike-card">
                <img src="../assets/images/rent3.jpg" alt="Urbana City UB-2024" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/28a745/ffffff?text=Urbana+City'">
                <div class="bike-name">Urbana City UB-2024</div>
                <div class="bike-details">
                    <i class="fas fa-city"></i> Urbana<br>
                    <i class="fas fa-map-marker-alt"></i> Savassi, Belo Horizonte - MG<br>
                    <i class="fas fa-user"></i> Carlos Oliveira<br>
                    <i class="fas fa-cogs"></i> Estado: Excelente
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    5.0/5.0 (15 avaliações)
                </div>
                <div class="bike-status status-disponivel">Disponível</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('3')">
                        <i class="fas fa-eye"></i> Ver Detalhes
                    </a>
                    <a href="#" class="btn btn-success" onclick="reserveBike('3')">
                        <i class="fas fa-calendar-plus"></i> Reservar
                    </a>
                    <a href="#" class="btn btn-primary" onclick="contactOwner('3')">
                        <i class="fas fa-comment"></i> Contatar
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta Disponível 4 -->
            <div class="bike-card">
                <img src="../assets/images/rent4.jpg" alt="Dobrável Compacta DB-2024" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/ffc107/000000?text=Dobrável'">
                <div class="bike-name">Dobrável Compacta DB-2024</div>
                <div class="bike-details">
                    <i class="fas fa-bolt"></i> Elétrica<br>
                    <i class="fas fa-map-marker-alt"></i> Moinhos de Vento, Porto Alegre - RS<br>
                    <i class="fas fa-user"></i> Ana Paula<br>
                    <i class="fas fa-cogs"></i> Estado: Excelente
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                    4.2/5.0 (6 avaliações)
                </div>
                <div class="bike-status status-disponivel">Disponível</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('4')">
                        <i class="fas fa-eye"></i> Ver Detalhes
                    </a>
                    <a href="#" class="btn btn-success" onclick="reserveBike('4')">
                        <i class="fas fa-calendar-plus"></i> Reservar
                    </a>
                    <a href="#" class="btn btn-primary" onclick="contactOwner('4')">
                        <i class="fas fa-comment"></i> Contatar
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta Disponível 5 -->
            <div class="bike-card">
                <img src="../assets/images/rent5.jpg" alt="Dobravel Durban" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/17a2b8/ffffff?text=Dobrável'">
                <div class="bike-name">Durban Sampa Pro</div>
                <div class="bike-details">
                    <i class="fas fa-compress-alt"></i> Dobrável<br>
                    <i class="fas fa-map-marker-alt"></i> Centro, Curitiba - PR<br>
                    <i class="fas fa-user"></i> Pedro Costa<br>
                    <i class="fas fa-cogs"></i> Estado: Bom
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                    4.2/5.0 (9 avaliações)
                </div>
                <div class="bike-status status-disponivel">Disponível</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('5')">
                        <i class="fas fa-eye"></i> Ver Detalhes
                    </a>
                    <a href="#" class="btn btn-success" onclick="reserveBike('5')">
                        <i class="fas fa-calendar-plus"></i> Reservar
                    </a>
                    <a href="#" class="btn btn-primary" onclick="contactOwner('5')">
                        <i class="fas fa-comment"></i> Contatar
                    </a>
                </div>
            </div>
            
            <!-- Bicicleta Disponível 6 -->
            <div class="bike-card">
                <img src="../assets/images/rent6.jpg" alt="Giant Mountain" class="bike-image" onerror="this.src='https://via.placeholder.com/300x200/6c757d/ffffff?text=Mountain'">
                <div class="bike-name">Giant ATX Elite</div>
                <div class="bike-details">
                    <i class="fas fa-mountain"></i> Mountain Bike<br>
                    <i class="fas fa-map-marker-alt"></i> Asa Norte, Brasília - DF<br>
                    <i class="fas fa-user"></i> Luisa Ferreira<br>
                    <i class="fas fa-cogs"></i> Estado: Excelente
                </div>
                <div class="bike-rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                    4.7/5.0 (11 avaliações)
                </div>
                <div class="bike-status status-disponivel">Disponível</div>
                <div class="bike-actions">
                    <a href="#" class="btn btn-info" onclick="viewDetails('6')">
                        <i class="fas fa-eye"></i> Ver Detalhes
                    </a>
                    <a href="#" class="btn btn-success" onclick="reserveBike('6')">
                        <i class="fas fa-calendar-plus"></i> Reservar
                    </a>
                    <a href="#" class="btn btn-primary" onclick="contactOwner('6')">
                        <i class="fas fa-comment"></i> Contatar
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Dicas para Locatários -->
        <div class="search-filter">
            <h3><i class="fas fa-lightbulb"></i> Dicas para uma Boa Experiência</h3>
            <div class="filter-row">
                <div class="filter-group">
                    <label><i class="fas fa-check-circle"></i> Verifique as Avaliações</label>
                    <div>Sempre confira os comentários de outros usuários sobre a bicicleta e o locador.</div>
                </div>
                <div class="filter-group">
                    <label><i class="fas fa-camera"></i> Documente o Estado</label>
                    <div>Tire fotos da bicicleta antes e depois do uso para evitar problemas.</div>
                </div>
                <div class="filter-group">
                    <label><i class="fas fa-clock"></i> Seja Pontual</label>
                    <div>Respeite os horários combinados para retirada e devolução da bicicleta.</div>
                </div>
                <div class="filter-group">
                    <label><i class="fas fa-heart"></i> Cuide Bem</label>
                    <div>Trate a bicicleta com cuidado e deixe feedback construtivo para o locador.</div>
                </div>
            </div>
        </div>
        
        <div class="back-button">
            <a href="<%=request.getContextPath()%>/pages/Perfil.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar ao Perfil
            </a>
        </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        function viewDetails(bikeId) {
            // Redirecionar para página de detalhes do locatário
            window.location.href = '<%=request.getContextPath()%>/pages/bicicletaDetalhesLocatario.jsp?id=' + bikeId;
        }
        
        function reserveBike(bikeId) {
            if (confirm('Deseja fazer uma reserva para esta bicicleta?')) {
                alert('Redirecionando para página de reserva da bicicleta ID: ' + bikeId);
                // Implementar redirecionamento para página de reserva
            }
        }
        
        function contactOwner(bikeId) {
            alert('Entrar em contato com o proprietário da bicicleta ID: ' + bikeId);
            // Implementar sistema de mensagens
        }
        
        // Filtros de busca
        document.getElementById('search-location').addEventListener('input', filterBikes);
        document.getElementById('filter-type').addEventListener('change', filterBikes);
        document.getElementById('filter-rating').addEventListener('change', filterBikes);
        document.getElementById('search-date').addEventListener('change', filterBikes);
        
        function filterBikes() {
            const searchLocation = document.getElementById('search-location').value.toLowerCase();
            const filterType = document.getElementById('filter-type').value.toLowerCase();
            const filterRating = document.getElementById('filter-rating').value;
            const searchDate = document.getElementById('search-date').value;
            
            const bikeCards = document.querySelectorAll('.bike-card');
            
            bikeCards.forEach(card => {
                const bikeDetails = card.querySelector('.bike-details').textContent.toLowerCase();
                const bikeRating = parseFloat(card.querySelector('.bike-rating').textContent.match(/(\d+\.\d+)/)[1]);
                
                const matchesLocation = searchLocation === '' || bikeDetails.includes(searchLocation);
                const matchesType = filterType === '' || bikeDetails.includes(filterType);
                const matchesRating = filterRating === '' || bikeRating >= parseFloat(filterRating);
                const matchesDate = searchDate === '' || true; // Implementar lógica de disponibilidade por data
                
                if (matchesLocation && matchesType && matchesRating && matchesDate) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        // Define data mínima como hoje
        document.getElementById('search-date').min = new Date().toISOString().split('T')[0];
    </script>
</body>
</html>