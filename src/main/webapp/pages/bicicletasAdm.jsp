<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.sharebike.model.Bicicleta" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestão de Bicicletas - Administrador</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Navegação administrativa padrão */
        .admin-navigation {
            background: linear-gradient(135deg, #008080, #006666);
            padding: 1rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }
        
        .nav-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .nav-brand {
            color: white;
            text-decoration: none;
            font-size: 1.2rem;
            font-weight: bold;
        }
        
        .nav-links {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
            align-items: center;
        }
        
        .nav-link {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .nav-link:hover {
            background-color: rgba(255,255,255,0.1);
            color: white;
            text-decoration: none;
        }
        
        .nav-link.active {
            background-color: rgba(255,255,255,0.2);
        }
        
        .nav-logout {
            background: none;
            border: none;
            color: white;
            cursor: pointer;
            font-size: inherit;
            font-family: inherit;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .nav-logout:hover {
            background-color: rgba(255,255,255,0.1);
        }
        
        /* Estilos para página sem dados */
        .no-data {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        
        .no-data i {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        
        /* Estatísticas */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
            padding: 20px 0;
        }
        
        .stat-card {
            display: flex;
            align-items: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .stat-icon {
            font-size: 3rem;
            margin-right: 20px;
            opacity: 0.8;
        }
        
        .stat-icon.status-disponivel {
            color: #28a745;
        }
        
        .stat-icon.status-manutencao {
            color: #ffc107;
        }
        
        .stat-icon.status-excelente {
            color: #ffd700;
        }
        
        /* Status para bicicletas sem disponibilidade */
        .status-indisponivel {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .stat-info {
            flex: 1;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            line-height: 1;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 1rem;
            opacity: 0.9;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        /* Espaçamento adicional para os filtros */
        .filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            align-items: end;
        }
        
        .filter-group {
            margin-bottom: 1rem;
        }
        
        .filter-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Navegação administrativa padrão -->
    <nav class="admin-navigation">
        <div class="nav-container">
            <div class="nav-content">
                <!-- Logo/Home -->
                <div>
                    <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" class="nav-brand">
                        <i class="fas fa-bicycle"></i> ShareBike Admin
                    </a>
                </div>
                
                <!-- Links de Navegação -->
                <div class="nav-links">
                    <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" class="nav-link">
                        <i class="fas fa-home"></i> Painel do Adm
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/UsuarioController" class="nav-link">
                        <i class="fas fa-users-cog"></i> Gestão Usuários
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/BicicletaController" class="nav-link active">
                        <i class="fas fa-bicycle"></i> Gestão Bicicletas
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/ReservaController" class="nav-link">
                        <i class="fas fa-calendar-check"></i> Gestão Reservas
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/FeedbackController" class="nav-link">
                        <i class="fas fa-star"></i> Feedbacks
                    </a>
                    
                    <a href="<%=request.getContextPath()%>/RankingController" class="nav-link">
                        <i class="fas fa-chart-line"></i> Rankings
                    </a>
                    
                    <!-- Logout -->
                    <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block; margin: 0;">
                        <input type="hidden" name="action" value="logout">
                        <button type="submit" class="nav-logout">
                            <i class="fas fa-sign-out-alt"></i> Sair
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </nav>

    <!-- Cabeçalho da página -->
    <div class="page-header" style="background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%); color: white; padding: 1.5rem; text-align: center; font-size: 1.8rem;">
        <i class="fas fa-bicycle"></i> Gestão de Bicicletas - Administrador
    </div>
    
    <div class="container">
        <!-- Remover a navegação antiga -->
        
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
                    <label for="filter-status">Status:</label>
                    <select id="filter-status">
                        <option value="">Todos os status</option>
                        <option value="disponível">Disponível</option>
                        <option value="indisponível">Indisponível</option>
                        <option value="excelente">Estado Excelente</option>
                        <option value="ótima">Estado Ótima</option>
                        <option value="bom">Estado Bom</option>
                        <option value="disponível - excelente">Disponível - Excelente</option>
                        <option value="disponível - ótima">Disponível - Ótima</option>
                        <option value="disponível - bom">Disponível - Bom</option>
                        <option value="indisponível - excelente">Indisponível - Excelente</option>
                        <option value="indisponível - ótima">Indisponível - Ótima</option>
                        <option value="indisponível - bom">Indisponível - Bom</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="filter-city">Proprietário:</label>
                    <input type="text" id="filter-city" placeholder="Digite o nome do proprietário">
                </div>
            </div>
        </div>
        
        <%
        List<Bicicleta> listaBicicleta = (List<Bicicleta>) request.getAttribute("listaBicicleta");
        java.util.Map<Integer, Boolean> disponibilidadeMap = (java.util.Map<Integer, Boolean>) request.getAttribute("disponibilidadeMap");
        
        // Calcular estatísticas das bicicletas
        int totalBicicletas = 0;
        int bicicletasDisponiveis = 0;
        int bicicletasIndisponiveis = 0;
        int bicicletasExcelente = 0;
        
        if (listaBicicleta != null) {
            totalBicicletas = listaBicicleta.size();
            
            for (Bicicleta bicicleta : listaBicicleta) {
                String estado = (bicicleta.getEstadoConserv_bike() != null) ? bicicleta.getEstadoConserv_bike().toLowerCase() : "desconhecido";
                
                // Verificar disponibilidade real
                Boolean temDisponibilidade = disponibilidadeMap.get(bicicleta.getId_bike());
                if (temDisponibilidade != null && temDisponibilidade) {
                    bicicletasDisponiveis++;
                } else {
                    bicicletasIndisponiveis++;
                }
                
                // Contar bicicletas em estado excelente (independente da disponibilidade)
                if ("excelente".equals(estado)) {
                    bicicletasExcelente++;
                }
            }
        }
        %>
        
        <!-- Estatísticas do Sistema -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-bicycle"></i></div>
                <div class="stat-info">
                    <div class="stat-number"><%=totalBicicletas%></div>
                    <div class="stat-label">Total de Bicicletas</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon status-disponivel"><i class="fas fa-check-circle"></i></div>
                <div class="stat-info">
                    <div class="stat-number"><%=bicicletasDisponiveis%></div>
                    <div class="stat-label">Disponíveis para Reserva</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon status-manutencao"><i class="fas fa-times-circle"></i></div>
                <div class="stat-info">
                    <div class="stat-number"><%=bicicletasIndisponiveis%></div>
                    <div class="stat-label">Indisponíveis</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon status-excelente"><i class="fas fa-star"></i></div>
                <div class="stat-info">
                    <div class="stat-number"><%=bicicletasExcelente%></div>
                    <div class="stat-label">Estado Excelente</div>
                </div>
            </div>
        </div>
        
        <div class="bike-grid">
            <%
            if (listaBicicleta != null && !listaBicicleta.isEmpty()) {
                for (Bicicleta bicicleta : listaBicicleta) {
                    // Determinar status da bicicleta baseado na disponibilidade e estado de conservação
                    String statusClass = "";
                    String statusText = "";
                    
                    // Verificar disponibilidade real
                    Boolean temDisponibilidade = disponibilidadeMap.get(bicicleta.getId_bike());
                    boolean disponivel = (temDisponibilidade != null && temDisponibilidade);
                    
                    // Obter estado de conservação
                    String estadoConservacao = "";
                    if (bicicleta.getEstadoConserv_bike() != null) {
                        String estado = bicicleta.getEstadoConserv_bike().toLowerCase();
                        switch (estado) {
                            case "excelente":
                                estadoConservacao = "EXCELENTE";
                                break;
                            case "ótima":
                            case "otima":
                                estadoConservacao = "ÓTIMA";
                                break;
                            case "bom":
                                estadoConservacao = "BOM";
                                break;
                            default:
                                estadoConservacao = bicicleta.getEstadoConserv_bike().toUpperCase();
                        }
                    }
                    
                    if (disponivel) {
                        // Bicicleta tem disponibilidade
                        if (!estadoConservacao.isEmpty()) {
                            statusClass = "status-disponivel";
                            statusText = "Disponível - " + estadoConservacao;
                        } else {
                            statusClass = "status-disponivel";
                            statusText = "Disponível";
                        }
                    } else {
                        // Bicicleta sem disponibilidade - mas mostrar estado de conservação
                        if (!estadoConservacao.isEmpty()) {
                            statusClass = "status-manutencao";
                            statusText = "Indisponível - " + estadoConservacao;
                        } else {
                            statusClass = "status-manutencao";
                            statusText = "Indisponível";
                        }
                    }
                    
                    // Gerar estrelas para avaliação
                    Float avaliacaoFloat = bicicleta.getAvaliacao_bike();
                    // Debug: verificar se avaliação tem valor
                    System.out.println("DEBUG ADM - Bicicleta ID: " + bicicleta.getId_bike() + ", Avaliação: " + avaliacaoFloat);
                    
                    float avaliacao = (avaliacaoFloat != null && avaliacaoFloat > 0) ? avaliacaoFloat : 0.0f;
                    int estrelasInteiras = (int) avaliacao;
                    boolean meiaEstrela = (avaliacao - estrelasInteiras) >= 0.5;
                    boolean temAvaliacao = avaliacaoFloat != null && avaliacaoFloat > 0;
                    
                    // Determinar ícone do tipo de bicicleta
                    String tipoIcon = "fas fa-bicycle";
                    if (bicicleta.getTipo_bike() != null) {
                        String tipo = bicicleta.getTipo_bike().toLowerCase();
                        switch (tipo) {
                            case "mountain":
                            case "mountain bike":
                                tipoIcon = "fas fa-mountain";
                                break;
                            case "speed":
                            case "road":
                                tipoIcon = "fas fa-road";
                                break;
                            case "urbana":
                                tipoIcon = "fas fa-city";
                                break;
                            case "elétrica":
                            case "eletrica":
                                tipoIcon = "fas fa-bolt";
                                break;
                            case "dobrável":
                            case "dobravel":
                                tipoIcon = "fas fa-compress-alt";
                                break;
                        }
                    }
            %>
            <div class="bike-card">
                <img src="https://via.placeholder.com/300x200/38b2ac/ffffff?text=<%=bicicleta.getNome_bike() != null ? bicicleta.getNome_bike().replace(" ", "+") : "Bicicleta"%>" alt="<%=bicicleta.getNome_bike()%>" 
                     class="bike-image">
                <div class="bike-name"><%=bicicleta.getNome_bike()%></div>
                <div class="bike-details">
                    <i class="<%=tipoIcon%>"></i> <%=bicicleta.getTipo_bike()%><br>
                    <i class="fas fa-map-marker-alt"></i> <%=bicicleta.getLocalEntr_bike()%><br>
                    <i class="fas fa-user"></i> 
                    <%if (bicicleta.getUsuario() != null) {%>
                        <%if (bicicleta.getUsuario().getNomeRazaoSocial_user() != null) {%>
                            <%=bicicleta.getUsuario().getNomeRazaoSocial_user()%>
                            <%if (bicicleta.getUsuario().getTelefone_user() != null) {%>
                                (<%=bicicleta.getUsuario().getTelefone_user()%>)
                            <%}%>
                        <%} else {%>
                            CPF: <%=bicicleta.getUsuario().getCpfCnpj_user()%>
                        <%}%>
                    <%} else {%>
                        Proprietário não informado
                    <%}%>
                </div>
                <div class="bike-rating">
                    <%if (temAvaliacao) {%>
                        <%for (int i = 1; i <= 5; i++) {%>
                            <%if (i <= estrelasInteiras) {%>
                                <i class="fas fa-star"></i>
                            <%} else if (i == estrelasInteiras + 1 && meiaEstrela) {%>
                                <i class="fas fa-star-half-alt"></i>
                            <%} else {%>
                                <i class="far fa-star"></i>
                            <%}%>
                        <%}%>
                        <%=String.format("%.1f", avaliacao)%>/5.0
                    <%} else {%>
                        <i class="far fa-star"></i>
                        <i class="far fa-star"></i>
                        <i class="far fa-star"></i>
                        <i class="far fa-star"></i>
                        <i class="far fa-star"></i>
                        Sem avaliação
                    <%}%>
                </div>
                <div class="bike-status <%=statusClass%>"><%=statusText%></div>
            </div>
            <%
                }
            } else {
            %>
            <div class="no-data">
                <i class="fas fa-bicycle"></i>
                <h3>Nenhuma bicicleta encontrada</h3>
                <p>Não há bicicletas cadastradas no sistema no momento.</p>
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
        // Filtros de busca - versão simplificada para dados dinâmicos
        document.getElementById('search-name').addEventListener('input', filterBikes);
        document.getElementById('filter-type').addEventListener('change', filterBikes);
        document.getElementById('filter-status').addEventListener('change', filterBikes);
        document.getElementById('filter-city').addEventListener('input', filterBikes);
        
        function filterBikes() {
            const searchName = document.getElementById('search-name').value.toLowerCase();
            const filterType = document.getElementById('filter-type').value.toLowerCase();
            const filterStatus = document.getElementById('filter-status').value.toLowerCase();
            const filterOwner = document.getElementById('filter-city').value.toLowerCase(); // Usando filter-city para proprietário
            
            const bikeCards = document.querySelectorAll('.bike-card');
            let visibleCount = 0;
            
            bikeCards.forEach(card => {
                const bikeName = card.querySelector('.bike-name').textContent.toLowerCase();
                const bikeDetails = card.querySelector('.bike-details').textContent.toLowerCase();
                const bikeStatus = card.querySelector('.bike-status').textContent.toLowerCase();
                
                const matchesName = bikeName.includes(searchName);
                const matchesType = filterType === '' || bikeDetails.includes(filterType);
                const matchesStatus = filterStatus === '' || bikeStatus.includes(filterStatus);
                const matchesOwner = filterOwner === '' || bikeDetails.includes(filterOwner);
                
                if (matchesName && matchesType && matchesStatus && matchesOwner) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            // Atualizar contadores se existirem
            const statsCards = document.querySelectorAll('.stat-card');
            if (statsCards.length > 0) {
                statsCards[0].querySelector('.stat-number').textContent = visibleCount;
            }
        }
    </script>
</body>
</html>