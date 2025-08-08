<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fazer Reserva - ShareBike</title>
    <link rel="stylesheet" href="../assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .reservation-form {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .form-group label {
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #495057;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            padding: 0.75rem;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 1rem;
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .bike-selection {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 1rem;
            background: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .bike-selection:hover {
            border-color: #38b2ac;
            background: #e6fffa;
        }
        
        .bike-selection.selected {
            border-color: #38b2ac;
            background: #e6fffa;
            box-shadow: 0 0 0 2px rgba(56, 178, 172, 0.2);
        }
        
        .bike-option {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .bike-option input[type="radio"] {
            margin: 0;
        }
        
        .bike-info {
            flex: 1;
        }
        
        .bike-preview-image {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .price-summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            border-left: 4px solid #38b2ac;
        }
        
        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }
        
        .price-total {
            font-size: 1.2rem;
            font-weight: bold;
            color: #38b2ac;
            border-top: 1px solid #dee2e6;
            padding-top: 0.5rem;
            margin-top: 0.5rem;
        }
        
        .submit-section {
            text-align: center;
            margin-top: 2rem;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #38b2ac 0%, #2c8e89 100%);
            color: white;
            padding: 1rem 3rem;
            font-size: 1.1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(56, 178, 172, 0.3);
        }
        
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-calendar-plus"></i> Fazer Nova Reserva</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="bicicletasLocatario.jsp"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="reservasLocatario.jsp"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="fazerReserva.jsp"><i class="fas fa-calendar-plus"></i> Nova Reserva</a>
            <a href="rankingLocatario.jsp"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <form class="reservation-form" id="reservationForm">
            <h3><i class="fas fa-bicycle"></i> Escolha uma Bicicleta</h3>
            
            <!-- Seleção de Bicicletas -->
            <div style="display: grid; gap: 1rem; margin-bottom: 2rem;">
                <div class="bike-selection" onclick="selectBike(this, 'bike1')">
                    <div class="bike-option">
                        <input type="radio" name="selectedBike" value="bike1" id="bike1">
                        <img src="../assets/images/rent1.jpg" alt="Mountain Explorer" class="bike-preview-image" onerror="this.src='https://via.placeholder.com/80x60/38b2ac/ffffff?text=B1'">
                        <div class="bike-info">
                            <strong>Mountain Explorer MX-2024</strong><br>
                            <span>Mountain - Vila Madalena, SP</span><br>
                            <span style="color: #38b2ac; font-weight: bold;">Disponível</span>
                            <span style="float: right;">⭐ 4.5/5.0</span>
                        </div>
                    </div>
                </div>
                
                <div class="bike-selection" onclick="selectBike(this, 'bike2')">
                    <div class="bike-option">
                        <input type="radio" name="selectedBike" value="bike2" id="bike2">
                        <img src="../assets/images/rent2.jpg" alt="Speed Urbana" class="bike-preview-image" onerror="this.src='https://via.placeholder.com/80x60/007bff/ffffff?text=B2'">
                        <div class="bike-info">
                            <strong>Speed Urbana SP-2024</strong><br>
                            <span>Speed - Copacabana, RJ</span><br>
                            <span style="color: #38b2ac; font-weight: bold;">Disponível</span>
                            <span style="float: right;">⭐ 4.0/5.0</span>
                        </div>
                    </div>
                </div>
                
                <div class="bike-selection" onclick="selectBike(this, 'bike3')">
                    <div class="bike-option">
                        <input type="radio" name="selectedBike" value="bike3" id="bike3">
                        <img src="../assets/images/rent3.jpg" alt="Urbana City" class="bike-preview-image" onerror="this.src='https://via.placeholder.com/80x60/28a745/ffffff?text=B3'">
                        <div class="bike-info">
                            <strong>Urbana City UB-2024</strong><br>
                            <span>Urbana - Savassi, BH</span><br>
                            <span style="color: #38b2ac; font-weight: bold;">Disponível</span>
                            <span style="float: right;">⭐ 5.0/5.0</span>
                        </div>
                    </div>
                </div>
                
                <div class="bike-selection" onclick="selectBike(this, 'bike4')">
                    <div class="bike-option">
                        <input type="radio" name="selectedBike" value="bike4" id="bike4">
                        <img src="../assets/images/rent4.jpg" alt="Dobrável Compacta" class="bike-preview-image" onerror="this.src='https://via.placeholder.com/80x60/ffc107/000000?text=D'">
                        <div class="bike-info">
                            <strong>Dobrável Compacta DB-2024</strong><br>
                            <span>Dobrável - Moinhos de Vento, POA</span><br>
                            <span style="color: #38b2ac; font-weight: bold;">Disponível</span>
                            <span style="float: right;">⭐ 4.2/5.0</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <h3><i class="fas fa-calendar-alt"></i> Dados da Reserva</h3>
            
            <div class="form-grid">
                <div class="form-group">
                    <label for="checkInDate">
                        <i class="fas fa-calendar"></i> Data de Retirada
                    </label>
                    <input type="date" id="checkInDate" name="checkInDate" required onchange="calculatePrice()">
                </div>
                
                <div class="form-group">
                    <label for="checkInTime">
                        <i class="fas fa-clock"></i> Horário de Retirada
                    </label>
                    <input type="time" id="checkInTime" name="checkInTime" value="09:00" required>
                </div>
                
                <div class="form-group">
                    <label for="checkOutDate">
                        <i class="fas fa-calendar"></i> Data de Devolução
                    </label>
                    <input type="date" id="checkOutDate" name="checkOutDate" required onchange="calculatePrice()">
                </div>
                
                <div class="form-group">
                    <label for="checkOutTime">
                        <i class="fas fa-clock"></i> Horário de Devolução
                    </label>
                    <input type="time" id="checkOutTime" name="checkOutTime" value="18:00" required>
                </div>
                
                <div class="form-group">
                    <label for="pickupLocation">
                        <i class="fas fa-map-marker-alt"></i> Local de Retirada
                    </label>
                    <input type="text" id="pickupLocation" name="pickupLocation" placeholder="Endereço para retirada" required>
                </div>
                
                <div class="form-group">
                    <label for="returnLocation">
                        <i class="fas fa-map-marker-alt"></i> Local de Devolução
                    </label>
                    <input type="text" id="returnLocation" name="returnLocation" placeholder="Endereço para devolução" required>
                </div>
                
                <div class="form-group">
                    <label for="contactPhone">
                        <i class="fas fa-phone"></i> Telefone de Contato
                    </label>
                    <input type="tel" id="contactPhone" name="contactPhone" placeholder="(11) 99999-9999" required>
                </div>
                
                <div class="form-group">
                    <label for="emergencyContact">
                        <i class="fas fa-user-friends"></i> Contato de Emergência
                    </label>
                    <input type="tel" id="emergencyContact" name="emergencyContact" placeholder="(11) 88888-8888">
                </div>
                
                <div class="form-group full-width">
                    <label for="purpose">
                        <i class="fas fa-question-circle"></i> Finalidade do Uso
                    </label>
                    <select id="purpose" name="purpose" required>
                        <option value="">Selecione a finalidade</option>
                        <option value="lazer">Lazer/Recreação</option>
                        <option value="trabalho">Trabalho/Profissional</option>
                        <option value="exercicio">Exercício/Fitness</option>
                        <option value="transporte">Transporte Urbano</option>
                        <option value="turismo">Turismo</option>
                        <option value="outro">Outro</option>
                    </select>
                </div>
                
                <div class="form-group full-width">
                    <label for="specialRequests">
                        <i class="fas fa-comment"></i> Observações Especiais (opcional)
                    </label>
                    <textarea id="specialRequests" name="specialRequests" placeholder="Alguma solicitação especial ou informação adicional..."></textarea>
                </div>
            </div>
            
            <!-- Resumo da Reserva -->
            <div class="price-summary">
                <h4><i class="fas fa-info-circle"></i> Resumo da Reserva</h4>
                <div class="price-row">
                    <span>Bicicleta selecionada:</span>
                    <span id="selectedBikeName">Nenhuma selecionada</span>
                </div>
                <div class="price-row">
                    <span>Localização:</span>
                    <span id="bikeLocation">-</span>
                </div>
                <div class="price-row">
                    <span>Período selecionado:</span>
                    <span id="selectedPeriod">-</span>
                </div>
                <div class="price-row">
                    <span>Número de dias:</span>
                    <span id="numberOfDays">0</span>
                </div>
                <div class="price-row price-total">
                    <span>Status:</span>
                    <span id="reservationStatus" style="color: #28a745; font-weight: bold;">Disponível para reserva</span>
                </div>
            </div>
            
            <div class="submit-section">
                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i> Solicitar Reserva
                </button>
                <p style="margin-top: 1rem; color: #6c757d; font-size: 0.9rem;">
                    Sua solicitação será enviada ao proprietário da bicicleta para aprovação.
                </p>
            </div>
        </form>
        
        <div class="back-button">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocatario.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar à Busca de Bicicletas
            </a>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        // Dados das bicicletas
        const bikes = {
            bike1: { name: 'Mountain Explorer MX-2024', location: 'Vila Madalena, SP' },
            bike2: { name: 'Speed Urbana SP-2024', location: 'Copacabana, RJ' },
            bike3: { name: 'Urbana City UB-2024', location: 'Savassi, BH' },
            bike4: { name: 'Dobrável Compacta DB-2024', location: 'Moinhos de Vento, POA' }
        };
        
        let selectedBikeData = null;
        
        // Define datas mínimas
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('checkInDate').min = today;
        document.getElementById('checkOutDate').min = today;
        
        function selectBike(element, bikeId) {
            // Remove seleção anterior
            document.querySelectorAll('.bike-selection').forEach(el => {
                el.classList.remove('selected');
            });
            
            // Adiciona seleção atual
            element.classList.add('selected');
            document.getElementById(bikeId).checked = true;
            
            // Atualiza dados da bicicleta selecionada
            selectedBikeData = bikes[bikeId];
            updatePriceSummary();
        }
        
        function calculatePrice() {
            const checkInDate = new Date(document.getElementById('checkInDate').value);
            const checkOutDate = new Date(document.getElementById('checkOutDate').value);
            
            if (checkInDate && checkOutDate && checkOutDate > checkInDate) {
                const timeDiff = checkOutDate.getTime() - checkInDate.getTime();
                const daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
                
                // Atualiza data mínima de checkout
                const minCheckOut = new Date(checkInDate);
                minCheckOut.setDate(minCheckOut.getDate() + 1);
                document.getElementById('checkOutDate').min = minCheckOut.toISOString().split('T')[0];
                
                updatePriceSummary(daysDiff);
            } else {
                updatePriceSummary(0);
            }
        }
        
        function updatePriceSummary(days = 0) {
            if (selectedBikeData) {
                document.getElementById('selectedBikeName').textContent = selectedBikeData.name;
                document.getElementById('bikeLocation').textContent = selectedBikeData.location;
            } else {
                document.getElementById('selectedBikeName').textContent = 'Nenhuma selecionada';
                document.getElementById('bikeLocation').textContent = '-';
            }
            
            document.getElementById('numberOfDays').textContent = days;
            
            // Atualizar período selecionado
            const checkInDate = document.getElementById('checkInDate').value;
            const checkOutDate = document.getElementById('checkOutDate').value;
            
            if (checkInDate && checkOutDate) {
                document.getElementById('selectedPeriod').textContent = `${checkInDate} até ${checkOutDate}`;
            } else {
                document.getElementById('selectedPeriod').textContent = '-';
            }
        }
        
        // Auto-preencher local de devolução quando local de retirada for preenchido
        document.getElementById('pickupLocation').addEventListener('blur', function() {
            const returnLocation = document.getElementById('returnLocation');
            if (!returnLocation.value && this.value) {
                returnLocation.value = this.value;
            }
        });
        
        // Submissão do formulário
        document.getElementById('reservationForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (!selectedBikeData) {
                alert('Por favor, selecione uma bicicleta.');
                return;
            }
            
            const checkInDate = document.getElementById('checkInDate').value;
            const checkOutDate = document.getElementById('checkOutDate').value;
            
            if (!checkInDate || !checkOutDate) {
                alert('Por favor, preencha as datas de retirada e devolução.');
                return;
            }
            
            if (new Date(checkOutDate) <= new Date(checkInDate)) {
                alert('A data de devolução deve ser posterior à data de retirada.');
                return;
            }
            
            // Simular envio da reserva
            const formData = new FormData(this);
            const reservationData = {
                bike: selectedBikeData.name,
                location: selectedBikeData.location,
                checkIn: checkInDate + ' ' + formData.get('checkInTime'),
                checkOut: checkOutDate + ' ' + formData.get('checkOutTime'),
                pickupLocation: formData.get('pickupLocation'),
                returnLocation: formData.get('returnLocation'),
                phone: formData.get('contactPhone'),
                purpose: formData.get('purpose')
            };
            
            console.log('Dados da reserva:', reservationData);
            
            alert(`Solicitação de reserva enviada com sucesso!\n\nBicicleta: ${reservationData.bike}\nLocalização: ${reservationData.location}\nPeríodo: ${reservationData.checkIn} até ${reservationData.checkOut}\n\nO proprietário receberá sua solicitação e responderá em breve.`);
            
            // Redirecionar para página de reservas
            window.location.href = '<%=request.getContextPath()%>/pages/reservasLocatario.jsp';
        });
    </script>
</body>
</html>