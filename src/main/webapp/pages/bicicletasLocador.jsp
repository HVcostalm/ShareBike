<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.sharebike.model.Bicicleta" %>
<%@ page import="br.com.sharebike.model.Usuario" %>

<%
// Verificar se o usuário está logado
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
if (usuarioLogado == null) {
    response.sendRedirect("loginUsuario.jsp");
    return;
}

// Obter dados enviados pelo controller
List<Bicicleta> listaBicicletaProprietario = (List<Bicicleta>) request.getAttribute("listaBicicletaProprietario");
java.util.Map<Integer, Boolean> disponibilidadeMap = (java.util.Map<Integer, Boolean>) request.getAttribute("disponibilidadeMap");

// Estatísticas já calculadas pelo controller
Integer totalBicicletas = (Integer) request.getAttribute("totalBicicletas");
Integer bicicletasDisponiveis = (Integer) request.getAttribute("bicicletasDisponiveis");
Integer bicicletasAlugadas = (Integer) request.getAttribute("bicicletasAlugadas");

// Valores padrão caso não venham do controller
if (totalBicicletas == null) totalBicicletas = 0;
if (bicicletasDisponiveis == null) bicicletasDisponiveis = 0;
if (bicicletasAlugadas == null) bicicletasAlugadas = 0;

// Verificar se há mensagem de sucesso
String mensagemSucesso = (String) session.getAttribute("mensagemSucesso");
if (mensagemSucesso != null) {
    session.removeAttribute("mensagemSucesso"); // Remove a mensagem após exibir
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Minhas Bicicletas - Locador</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <header>
        <h1><i class="fas fa-bicycle"></i> Minhas Bicicletas - Painel do Locador</h1>
    </header>
    
    <div class="container">
        <% if (mensagemSucesso != null) { %>
            <div class="alert alert-success" style="background-color: #d4edda; color: #155724; padding: 1rem; margin-bottom: 1rem; border: 1px solid #c3e6cb; border-radius: 5px;">
                <i class="fas fa-check-circle"></i> <%= mensagemSucesso %>
            </div>
        <% } %>
        
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/UsuarioController?action=perfil" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Voltar ao Perfil
            </a>
            <a href="<%=request.getContextPath()%>/BicicletaController?action=minhas-bikes&cpfCnpj=<%= usuarioLogado.getCpfCnpj_user() %>"><i class="fas fa-bicycle"></i> Minhas Bicicletas</a>
            <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas-locador"><i class="fas fa-calendar-check"></i> Reservas Recebidas</a>
            <a href="<%=request.getContextPath()%>/FeedbackController?action=pagina-locador"><i class="fas fa-comment-dots"></i> Feedbacks</a>
            <a href="<%=request.getContextPath()%>/pages/cadastrarBicicleta.jsp" class="btn btn-success">
                <i class="fas fa-plus"></i> Cadastrar Nova Bicicleta
            </a>
        </nav>
        
        <!-- Estatísticas do Locador -->
        <div class="search-filter">
            <h3><i class="fas fa-chart-bar"></i> Minhas Estatísticas</h3>
            <div class="filter-row">
                <div class="filter-group">
                    <label>Total de Bicicletas:</label>
                    <div style="font-size: 1.5rem; font-weight: bold; color: #38b2ac;"><%= totalBicicletas %></div>
                </div>
                <div class="filter-group">
                    <label>Bicicletas Disponíveis:</label>
                    <div style="font-size: 1.5rem; font-weight: bold; color: #28a745;"><%= bicicletasDisponiveis %></div>
                </div>
                <div class="filter-group">
                    <label>Bicicletas Reservadas/Indisponíveis:</label>
                    <div style="font-size: 1.5rem; font-weight: bold; color: #dc3545;"><%= bicicletasAlugadas %></div>
                </div>
            </div>
        </div>
        
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
            <%
            if (listaBicicletaProprietario != null && !listaBicicletaProprietario.isEmpty()) {
                for (Bicicleta bicicleta : listaBicicletaProprietario) {
                    // Verificar disponibilidade
                    Boolean temDisponibilidade = disponibilidadeMap != null ? disponibilidadeMap.get(bicicleta.getId_bike()) : null;
                    String statusClass = "";
                    String statusTexto = "";
                    
                    if (temDisponibilidade != null && temDisponibilidade) {
                        statusClass = "status-disponivel";
                        statusTexto = "Disponível";
                    } else {
                        statusClass = "status-reservada";
                        statusTexto = "Indisponível";
                    }
                    
                    // Gerar estrelas da avaliação
                    String estrelasHtml = "";
                    String avaliacaoTexto = "";
                    Float avaliacao = bicicleta.getAvaliacao_bike();
                    
                    // Debug: verificar se avaliação tem valor
                    System.out.println("DEBUG - Bicicleta ID: " + bicicleta.getId_bike() + ", Avaliação: " + avaliacao);
                    
                    if (avaliacao != null && avaliacao > 0) {
                        int estrelasCompletas = (int) Math.floor(avaliacao);
                        boolean meiaestrela = (avaliacao - estrelasCompletas) >= 0.5;
                        
                        for (int i = 0; i < estrelasCompletas; i++) {
                            estrelasHtml += "<i class=\"fas fa-star\"></i>";
                        }
                        if (meiaestrela && estrelasCompletas < 5) {
                            estrelasHtml += "<i class=\"fas fa-star-half-alt\"></i>";
                            estrelasCompletas++;
                        }
                        for (int i = estrelasCompletas; i < 5; i++) {
                            estrelasHtml += "<i class=\"far fa-star\"></i>";
                        }
                        avaliacaoTexto = String.format("%.1f", avaliacao) + "/5.0";
                    } else {
                        estrelasHtml = "<i class=\"far fa-star\"></i><i class=\"far fa-star\"></i><i class=\"far fa-star\"></i><i class=\"far fa-star\"></i><i class=\"far fa-star\"></i>";
                        avaliacaoTexto = "Sem avaliação";
                    }
            %>
            <div class="bike-card">
            	<img src="<%=bicicleta.getFoto_bike()%>" alt="<%= bicicleta.getFoto_bike() %>" class="bike-image" >
                <div class="bike-name"><%= bicicleta.getNome_bike() != null ? bicicleta.getNome_bike() : "Nome não informado" %></div>
                <div class="bike-details">
                    <i class="fas fa-bicycle"></i> <%= bicicleta.getTipo_bike() != null ? bicicleta.getTipo_bike() : "Tipo não informado" %><br>
                    <i class="fas fa-map-marker-alt"></i> <%= bicicleta.getLocalEntr_bike() != null ? bicicleta.getLocalEntr_bike() : "Local não informado" %><br>
                    <i class="fas fa-cogs"></i> Estado: <%= bicicleta.getEstadoConserv_bike() != null ? bicicleta.getEstadoConserv_bike() : "Não informado" %><br>
                    <i class="fas fa-barcode"></i> Chassi: <%= bicicleta.getChassi_bike() != null ? bicicleta.getChassi_bike() : "Não informado" %>
                </div>
                <div class="bike-rating">
                    <%= estrelasHtml %>
                    <%= avaliacaoTexto %>
                </div>
                <div class="bike-status <%= statusClass %>"><%= statusTexto %></div>
                <div class="bike-actions">
                    <a href="<%=request.getContextPath()%>/BicicletaController?action=exibir&id=<%= bicicleta.getId_bike() %>" class="btn btn-info">
                        <i class="fas fa-eye"></i> Detalhes
                    </a>
                    <a href="<%=request.getContextPath()%>/BicicletaController?action=form-editar&id=<%= bicicleta.getId_bike() %>" class="btn btn-warning">
                        <i class="fas fa-edit"></i> Editar
                    </a>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="no-bikes-message" style="grid-column: 1 / -1; text-align: center; padding: 2rem; background: white; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                <i class="fas fa-bicycle" style="font-size: 3rem; color: #ccc; margin-bottom: 1rem;"></i>
                <h3>Nenhuma bicicleta cadastrada</h3>
                <p>Você ainda não possui bicicletas cadastradas. Comece adicionando sua primeira bicicleta!</p>
                <a href="<%=request.getContextPath()%>/pages/cadastrarBicicleta.jsp" class="btn btn-success">
                    <i class="fas fa-plus"></i> Cadastrar Primeira Bicicleta
                </a>
            </div>
            <%
            }
            %>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
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
        
        // Filtros de busca
        document.addEventListener('DOMContentLoaded', function() {
            const searchName = document.getElementById('search-name');
            const filterType = document.getElementById('filter-type');
            const filterAvailability = document.getElementById('filter-availability');
            
            if (searchName) searchName.addEventListener('input', filterBikes);
            if (filterType) filterType.addEventListener('change', filterBikes);
            if (filterAvailability) filterAvailability.addEventListener('change', filterBikes);
            
            // Remover mensagem de sucesso após 5 segundos
            const alertSuccess = document.querySelector('.alert-success');
            if (alertSuccess) {
                setTimeout(function() {
                    alertSuccess.style.transition = 'opacity 0.5s ease-out';
                    alertSuccess.style.opacity = '0';
                    setTimeout(function() {
                        alertSuccess.remove();
                    }, 500);
                }, 5000);
            }
        });
        
        console.log('Página de Bicicletas do Locador carregada');
    </script>
</body>
</html>