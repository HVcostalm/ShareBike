<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="br.com.sharebike.model.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.io.File" %>
<%
    // Verificar se o usuário está logado
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    if (usuarioLogado == null) {
        response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
        return;
    }
    
    // Verificar se já informou bike própria hoje
    boolean jaInformouBikePropriaHoje = false;
    if (usuarioLogado.isPossuiBike_user()) {
        String nomeArquivo = "bike_propria_" + usuarioLogado.getCpfCnpj_user() + "_" + LocalDate.now().toString() + ".tmp";
        String caminhoTemp = System.getProperty("java.io.tmpdir");
        File arquivoControle = new File(caminhoTemp, nomeArquivo);
        jaInformouBikePropriaHoje = arquivoControle.exists();
    }
    
    // Buscar dados do controller
    List<Reserva> reservasNaoInformadas = (List<Reserva>) request.getAttribute("reservasNaoInformadas");
    String mensagemSucesso = (String) request.getAttribute("sucesso");
    String mensagemErro = (String) request.getAttribute("erro");
    
    // Se não há dados carregados, redirecionar para o controller
    if (reservasNaoInformadas == null) {
        response.sendRedirect(request.getContextPath() + "/RankingController?action=informar-distancia");
        return;
    }
    
    // Formatador de data
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Informar Distância - ShareBike</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/usuarioDetalhes.css">
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
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%) !important;
            color: #fff;
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
            color: #fff;
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
            border-left: 4px solid #28a745;
            transition: all 0.3s ease;
        }

        .reservation-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
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
            display: none;
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
            background: #6c757d !important;
        }
        
        .btn:not(:disabled) {
            opacity: 1 !important;
            cursor: pointer !important;
        }
        
        .btn-success:not(:disabled) {
            background: linear-gradient(135deg, #28a745, #20c997) !important;
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
            <a href="<%=request.getContextPath()%>/RankingController?action=pagina-locatario" class="back-link">
                <i class="fas fa-arrow-left"></i> Voltar ao Ranking
            </a>
            
            <h1 class="header-title">
                <i class="fas fa-route"></i> 
                Informar Distância Percorrida
            </h1>
            <p>Ganhe pontos no ranking informando a distância das suas viagens!</p>
        </div>

        <!-- Mensagens de Sucesso/Erro -->
        <% String sucesso = (String) request.getAttribute("sucesso"); %>
        <% String erro = (String) request.getAttribute("erro"); %>
        
        <% if (sucesso != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <%= sucesso %>
        </div>
        <% } %>
        
        <% if (erro != null) { %>
        <div class="alert alert-danger" style="background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;">
            <i class="fas fa-exclamation-triangle"></i>
            <%= erro %>
        </div>
        <% } %>

        <!-- Informações sobre Pontuação -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-info-circle"></i>
                Como Funciona a Pontuação
            </div>
            
            <div class="alert alert-info">
                <i class="fas fa-trophy"></i>
                <span>Para cada <strong>1 km percorrido</strong>, você ganha <strong>1 ponto</strong> no ranking! <strong>Máximo 10 km por viagem.</strong></span>
            </div>
            
            <div style="background: #f8f9fa; border-radius: 8px; padding: 1rem; margin-top: 1rem;">
                <h4><i class="fas fa-lightbulb"></i> Dicas para Maximizar seus Pontos:</h4>
                <ul style="margin-left: 1.5rem; margin-top: 0.5rem;">
                    <li><strong>Limite de 10 km por viagem</strong> - mais que isso não é prático de bicicleta</li>
                    <li>Informe a distância real percorrida para garantir pontos justos</li>
                    <li>Complete mais viagens para subir no ranking</li>
                </ul>
            </div>
        </div>
		
		        <!-- Verificação de Bike Própria -->
        <% if (usuarioLogado.isPossuiBike_user()) { %>
        <div class="card">
            <div class="card-title">
                <i class="fas fa-bicycle"></i>
                Informar Viagem com Minha Bike
            </div>
            
            <% if (jaInformouBikePropriaHoje) { %>
                <!-- Já informou hoje - mostrar aviso -->
                <div class="bike-info" style="background: #fff3cd; border: 2px solid #ffc107;">
                    <div class="bike-icon" style="background: #ffc107;">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div>
                        <strong>Limite diário atingido!</strong><br>
                        <small>Você já informou uma distância com sua bike hoje. Próxima submissão permitida: <strong>amanhã às 00:00</strong></small>
                    </div>
                </div>
                
                <div style="background: #fff3cd; border-radius: 8px; padding: 1rem; margin-top: 1rem; border-left: 4px solid #ffc107;">
                    <p style="margin: 0; color: #856404;">
                        <i class="fas fa-info-circle"></i> 
                        <strong>Política de uso:</strong> Para manter a integridade do ranking, usuários com bike própria podem informar distância apenas <strong>1 vez por dia</strong>.
                    </p>
                </div>
                
                <button class="btn btn-secondary" disabled style="margin-top: 1rem; opacity: 0.6;">
                    <i class="fas fa-ban"></i>
                    Já Informado Hoje
                </button>
            <% } else { %>
                <!-- Pode informar hoje - mostrar normal -->
                <div class="bike-info" style="background: #e8f5e8; border: 2px solid #28a745;">
                    <div class="bike-icon" style="background: #28a745;">
                        <i class="fas fa-bicycle"></i>
                    </div>
                    <div>
                        <strong>Você possui sua própria bicicleta!</strong><br>
                        <small>Informe distâncias percorridas com sua bike e ganhe pontos também</small>
                    </div>
                </div>
                
                <div style="background: #e6fffa; border-radius: 8px; padding: 1rem; margin-top: 1rem; border-left: 4px solid #38b2ac;">
                    <p style="margin: 0; color: #065f46;">
                        <i class="fas fa-info-circle"></i> 
                        <strong>Disponível hoje:</strong> Você pode informar <strong>1 distância</strong> com sua bike própria hoje. Use com responsabilidade!
                    </p>
                </div>
                
                <button class="btn btn-success" onclick="abrirModalBikePropria()" style="margin-top: 1rem;">
                    <i class="fas fa-plus-circle"></i>
                    Informar Distância com Minha Bike
                </button>
            <% } %>
        </div>
        <% } %>
		
        <!-- Lista de Reservas Finalizadas -->
        <div class="card">
            <div class="card-title">
                <i class="fas fa-calendar-check"></i>
                Reservas Finalizadas - Aguardando Informação de Distância
            </div>
            
            <% if (reservasNaoInformadas != null && !reservasNaoInformadas.isEmpty()) { %>
                <% for (int i = 0; i < reservasNaoInformadas.size(); i++) { 
                    Reserva reserva = reservasNaoInformadas.get(i);
                %>
                
                <div class="reservation-card">
                    <div class="reservation-header">
                        <div class="reservation-id">#RSV-<%= String.format("%03d", reserva.getId_reserv()) %></div>
                        <div class="status-badge">
                            <i class="fas fa-clock"></i> Aguardando Distância
                        </div>
                    </div>
                    
                    <div class="bike-info">
                        <div class="bike-icon">
                            <i class="fas fa-bicycle"></i>
                        </div>
                        <div>
                            <strong><%= reserva.getBicicleta().getNome_bike() %></strong><br>
                            <small><i class="fas fa-user"></i> Locador: <%= reserva.getBicicleta().getUsuario().getNomeRazaoSocial_user() %></small>
                        </div>
                    </div>
                    
                    <div class="reservation-info">
                        <div class="info-item">
                            <span class="info-label">Data da Viagem</span>
                            <span class="info-value">
                                <%= reserva.getDataCheckIn_reserv().format(dateFormatter) %> - 
                                <%= reserva.getDataCheckOut_reserv().format(dateFormatter) %>
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Check-out</span>
                            <span class="info-value"><%= reserva.getDataCheckOut_reserv().format(formatter) %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Status</span>
                            <span class="info-value">Finalizada - <%= reserva.getStatus_reserv() %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Localização</span>
                            <span class="info-value"><%= reserva.getBicicleta().getLocalEntr_bike() %></span>
                        </div>
                    </div>
                    
                    <div class="distance-form">
                        <h4><i class="fas fa-route"></i> Informar Distância Percorrida</h4>
                        <div class="form-group">
                            <label for="distance-<%= reserva.getId_reserv() %>">
                                <i class="fas fa-road"></i>
                                Distância Total (em km) - Máximo 10 km:
                            </label>
                            <input type="number" 
                                   id="distance-<%= reserva.getId_reserv() %>" 
                                   min="0.1" 
                                   max="10" 
                                   step="0.1" 
                                   placeholder="Ex: 5.5"
                                   oninput="calculatePoints('<%= reserva.getId_reserv() %>')"
                                   style="margin-bottom: 1rem;">
                            
                            <div class="points-calculator" id="calculator-<%= reserva.getId_reserv() %>" style="display: none;">
                                <div><i class="fas fa-calculator"></i> Pontos que você ganhará:</div>
                                <div class="points-display" id="points-<%= reserva.getId_reserv() %>">0</div>
                                <div>pontos</div>
                            </div>
                        </div>
                        
                        <button class="btn btn-success" 
                                onclick="submitDistance('<%= reserva.getId_reserv() %>')" 
                                id="submit-<%= reserva.getId_reserv() %>"
                                disabled>
                            <i class="fas fa-check"></i>
                            Confirmar Distância
                        </button>
                    </div>
                </div>
                
                <% } %>
            <% } else { %>
                <!-- Nenhuma reserva encontrada -->
                <div class="reservation-card" style="text-align: center; padding: 3rem;">
                    <div style="color: #6c757d; font-size: 1.2rem; margin-bottom: 1rem;">
                        <i class="fas fa-info-circle" style="font-size: 3rem; margin-bottom: 1rem; display: block;"></i>
                        Nenhuma reserva pendente encontrada
                    </div>
                    <p style="color: #9ca3af; margin-bottom: 2rem;">
                        Você não possui reservas finalizadas aguardando informação de distância.
                    </p>
                    <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas" class="btn btn-primary">
                        <i class="fas fa-calendar-check"></i>
                        Ver Todas as Minhas Reservas
                    </a>
                </div>
            <% } %>
        </div>

        <!-- Botões de Ação -->
        <div class="action-buttons">
            <a href="<%=request.getContextPath()%>/RankingController?action=pagina-locatario" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>
                Voltar ao Ranking
            </a>
            
            <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas" class="btn btn-primary">
                <i class="fas fa-calendar-check"></i>
                Ver Todas as Reservas
            </a>
            
            <button onclick="window.location.reload()" class="btn btn-primary">
                <i class="fas fa-sync-alt"></i>
                Atualizar Página
            </button>
        </div>
    </div>

    <!-- Modal para Bike Própria -->
    <div id="modalBikePropria" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
        <div style="background: white; border-radius: 15px; padding: 2rem; max-width: 500px; width: 90%; margin: 2rem;">
            <h3 style="color: #333; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-bicycle"></i>
                Informar Distância - Bike Própria
            </h3>
            
            <div class="form-group">
                <label for="distancia-bike-propria">
                    <i class="fas fa-road"></i>
                    Distância percorrida (em km) - Máximo 10 km:
                </label>
                <input type="number" 
                       id="distancia-bike-propria" 
                       min="0.1" 
                       max="10" 
                       step="0.1" 
                       placeholder="Ex: 5.0"
                       oninput="calculatePointsBikePropria()"
                       style="margin-bottom: 1rem;">
                
                <div class="points-calculator" id="calculator-bike-propria" style="display: none;">
                    <div><i class="fas fa-calculator"></i> Pontos que você ganhará:</div>
                    <div class="points-display" id="points-bike-propria">0</div>
                    <div>pontos</div>
                </div>
            </div>
            
            <div style="display: flex; gap: 1rem; justify-content: center; margin-top: 2rem;">
                <button onclick="fecharModalBikePropria()" class="btn btn-secondary">
                    <i class="fas fa-times"></i>
                    Cancelar
                </button>
                <button onclick="submitDistanciaBikePropria()" class="btn btn-success" id="submit-bike-propria" disabled>
                    <i class="fas fa-check"></i>
                    Confirmar
                </button>
            </div>
        </div>
    </div>

    <script>
        // Função para calcular pontos e habilitar/desabilitar botão
        function calculatePoints(reservaId) {
            console.log('Calculando pontos para reserva:', reservaId);
            
            const distanceInput = document.getElementById('distance-' + reservaId);
            const submitButton = document.getElementById('submit-' + reservaId);
            const calculator = document.getElementById('calculator-' + reservaId);
            const pointsDisplay = document.getElementById('points-' + reservaId);
            
            if (!distanceInput || !submitButton) {
                console.error('Elementos não encontrados');
                return;
            }
            
            const distance = parseFloat(distanceInput.value);
            console.log('Distância:', distance);
            
            if (distance >= 0.1 && distance <= 10 && !isNaN(distance)) {
                const points = Math.floor(distance);
                
                // Mostrar calculadora
                calculator.style.display = 'block';
                pointsDisplay.textContent = points;
                
                // Habilitar botão
                submitButton.disabled = false;
                submitButton.style.backgroundColor = '#28a745';
                submitButton.style.opacity = '1';
                
                console.log('✅ Botão habilitado -', points, 'pontos');
            } else {
                // Esconder calculadora
                calculator.style.display = 'none';
                
                // Desabilitar botão
                submitButton.disabled = true;
                submitButton.style.backgroundColor = '#6c757d';
                submitButton.style.opacity = '0.6';
                
                console.log('❌ Botão desabilitado');
            }
        }
        
        // Função para enviar distância
        function submitDistance(reservaId) {
            console.log('Enviando distância para reserva:', reservaId);
            
            const distanceInput = document.getElementById('distance-' + reservaId);
            const distance = parseFloat(distanceInput.value);
            const points = Math.floor(distance);
            
            if (!distance || distance < 0.1 || distance > 10) {
                alert('Por favor, informe uma distância válida entre 0.1 e 10 km!');
                return;
            }
            
            if (confirm('Confirmar distância de ' + distance + ' km?\n\nVocê ganhará ' + points + ' pontos no ranking.')) {
                // Criar formulário
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%=request.getContextPath()%>/RankingController';
                
                // Adicionar campos
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'processar-distancia';
                form.appendChild(actionInput);
                
                const reservaInput = document.createElement('input');
                reservaInput.type = 'hidden';
                reservaInput.name = 'idReserva';
                reservaInput.value = reservaId;
                form.appendChild(reservaInput);
                
                const distanciaInput = document.createElement('input');
                distanciaInput.type = 'hidden';
                distanciaInput.name = 'distancia';
                distanciaInput.value = distance;
                form.appendChild(distanciaInput);
                
                // Enviar
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Funções para modal de bike própria
        function abrirModalBikePropria() {
            <% if (jaInformouBikePropriaHoje) { %>
                alert('Você já informou uma distância com sua bike hoje! Tente novamente amanhã.');
                return;
            <% } %>
            document.getElementById('modalBikePropria').style.display = 'flex';
        }
        
        function fecharModalBikePropria() {
            document.getElementById('modalBikePropria').style.display = 'none';
            document.getElementById('distancia-bike-propria').value = '';
            document.getElementById('calculator-bike-propria').style.display = 'none';
            document.getElementById('submit-bike-propria').disabled = true;
        }
        
        function calculatePointsBikePropria() {
            const distanceInput = document.getElementById('distancia-bike-propria');
            const pointsDisplay = document.getElementById('points-bike-propria');
            const calculator = document.getElementById('calculator-bike-propria');
            const submitButton = document.getElementById('submit-bike-propria');
            
            const distance = parseFloat(distanceInput.value) || 0;
            const points = Math.floor(distance);
            
            if (distance >= 0.1 && distance <= 10) {
                calculator.style.display = 'block';
                pointsDisplay.textContent = points;
                submitButton.disabled = false;
                submitButton.style.backgroundColor = '#28a745';
                submitButton.style.opacity = '1';
            } else {
                calculator.style.display = 'none';
                submitButton.disabled = true;
                submitButton.style.backgroundColor = '#6c757d';
                submitButton.style.opacity = '0.6';
            }
        }
        
        function submitDistanciaBikePropria() {
            const distance = parseFloat(document.getElementById('distancia-bike-propria').value);
            const points = Math.floor(distance);
            
            if (!distance || distance < 0.1 || distance > 10) {
                alert('Por favor, informe uma distância válida entre 0.1 e 10 km!');
                return;
            }
            
            if (confirm('Confirmar distância de ' + distance + ' km com sua bike própria?\n\nVocê ganhará ' + points + ' pontos no ranking.')) {
                // Criar formulário para bike própria
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%=request.getContextPath()%>/RankingController';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'processar-distancia-bike-propria';
                form.appendChild(actionInput);
                
                const distanciaInput = document.createElement('input');
                distanciaInput.type = 'hidden';
                distanciaInput.name = 'distancia';
                distanciaInput.value = distance;
                form.appendChild(distanciaInput);
                
                // Enviar
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Validação de entrada
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Página carregada');
            
            // Limitar valores dos inputs
            document.querySelectorAll('input[type="number"]').forEach(input => {
                input.addEventListener('input', function() {
                    if (this.value > 10) this.value = 10;
                    if (this.value < 0) this.value = 0;
                });
            });
            
            // Fechar modal ao clicar fora
            const modal = document.getElementById('modalBikePropria');
            if (modal) {
                modal.addEventListener('click', function(e) {
                    if (e.target === modal) {
                        fecharModalBikePropria();
                    }
                });
            }
        });
    </script>

</body>
</html>
