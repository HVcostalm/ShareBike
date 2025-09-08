<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="br.com.sharebike.model.Bicicleta" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="br.com.sharebike.model.Disponibilidade" %>
<%@ page session="true" %>
<%
    List<Bicicleta> listaBicicletas = (List<Bicicleta>) request.getAttribute("listaBicicletas");
    String cidadeFiltro = (String) request.getAttribute("cidadeFiltro");
    String tipoFiltro = (String) request.getAttribute("tipoFiltro");
    String estadoConservFiltro = (String) request.getAttribute("estadoConservFiltro");
    String ordemAvalicaoFiltro = (String) request.getAttribute("ordemAvalicaoFiltro");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buscar Bicicletas - Locatário</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: white;
            min-height: 100vh;
            color: #333;
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            color: white;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        header h1 {
            margin: 0;
            font-size: 2.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }
        
        .nav {
            background: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .nav a {
            text-decoration: none;
            color: white;
            background-color: #38b2ac;
            padding: 1rem 2rem;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin: 0;
        }
        
        .nav a:hover, .nav a.active {
            background: #0d9488;
            color: white;
        }
        
        .search-filter {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .search-filter h3 {
            color: #38b2ac;
            margin-bottom: 20px;
        }
        
        .filter-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .filter-group {
            display: flex;
            flex-direction: column;
        }
        
        .filter-group label {
            margin-bottom: 5px;
            font-weight: bold;
            color: #38b2ac;
        }
        
        .filter-group input, .filter-group select {
            padding: 10px;
            border: 2px solid #e9ecef;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .filter-group input:focus, .filter-group select:focus {
            border-color: #38b2ac;
            outline: none;
        }
        
        .btn {
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            text-align: center;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(56, 178, 172, 0.3);
        }
        
        .btn:hover {
            background: linear-gradient(135deg, #319795, #0d9488);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(56, 178, 172, 0.4);
        }
        
        .btn-secondary {
            background: #6c757d;
        }
        
        .btn-secondary:hover {
            background: #545b62;
        }
        
        .bike-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .bike-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .bike-card:hover {
            transform: translateY(-5px);
        }
        
        .bike-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        
        .bike-name {
            font-size: 1.2rem;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 10px;
        }
        
        .bike-details {
            margin-bottom: 15px;
            color: #666;
        }
        
        .bike-details div {
            margin-bottom: 5px;
        }
        
        .bike-details i {
            color: #28a745;
            margin-right: 8px;
            width: 16px;
        }
        
        .bike-rating {
            margin-bottom: 15px;
            color: #ffc107;
        }
        
        .bike-status {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 12px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 15px;
        }
        
        .status-disponivel {
            background: #d4edda;
            color: #155724;
        }
        
        .bike-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .bike-actions .btn {
            flex: 1;
            text-align: center;
            font-size: 12px;
            padding: 8px 12px;
        }
        
        .back-navigation {
            text-align: center;
            margin: 30px 0;
        }
        
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #666;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .empty-state i {
            font-size: 3rem;
            color: #ccc;
            margin-bottom: 15px;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            color: white;
            border-top: 1px solid #eee;
            margin-top: 40px;
            background: black;
            border-radius: 0;
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-search"></i> Buscar Bicicletas Disponíveis</h1>
    </header>
    
    <div class="container">
        
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/UsuarioController?action=perfil"><i class="fas fa-user"></i> Voltar ao Perfil</a>
            <a href="<%=request.getContextPath()%>/BicicletaController?action=lista-locatario" class="active"><i class="fas fa-search"></i> Buscar Bicicletas</a>
            <a href="<%=request.getContextPath()%>/ReservaController?action=listar-minhas-reservas"><i class="fas fa-calendar-check"></i> Minhas Reservas</a>
            <a href="<%=request.getContextPath()%>/FeedbackController?action=pagina-locatario"><i class="fas fa-comment-dots"></i> Dar Feedback</a>
            <a href="<%=request.getContextPath()%>/RankingController?action=pagina-locatario"><i class="fas fa-trophy"></i> Ranking</a>
        </nav>
        
        <div class="search-filter">
            <h3><i class="fas fa-filter"></i> Filtros de Busca</h3>
            <form action="<%=request.getContextPath()%>/BicicletaController" method="get" class="filter-form">
                <input type="hidden" name="action" value="lista-locatario">
                
                <div class="filter-group">
                    <label for="cidade">Cidade:</label>
                    <input type="text" id="cidade" name="cidade" value="<%=cidadeFiltro != null ? cidadeFiltro : ""%>" placeholder="Digite a cidade">
                </div>
                
                <div class="filter-group">
                    <label for="tipo">Tipo de Bicicleta:</label>
                    <select id="tipo" name="tipo">
                        <option value="">Todos os tipos</option>
                        <option value="Urbana" <%="Urbana".equals(tipoFiltro) ? "selected" : ""%>>Urbana</option>
                        <option value="Passeio" <%="Passeio".equals(tipoFiltro) ? "selected" : ""%>>Passeio</option>
                        <option value="Dobrável" <%="Dobrável".equals(tipoFiltro) ? "selected" : ""%>>Dobrável</option>
                        <option value="Mountain" <%="Mountain".equals(tipoFiltro) ? "selected" : ""%>>Mountain</option>
                        <option value="BMX" <%="BMX".equals(tipoFiltro) ? "selected" : ""%>>BMX</option>
                        <option value="Speed" <%="Speed".equals(tipoFiltro) ? "selected" : ""%>>Speed</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="estadoConserv">Estado de Conservação:</label>
                    <select id="estadoConserv" name="estadoConserv">
                        <option value="">Qualquer estado</option>
                        <option value="BOM" <%="BOM".equals(estadoConservFiltro) ? "selected" : ""%>>Bom</option>
                        <option value="ÓTIMA" <%="ÓTIMA".equals(estadoConservFiltro) ? "selected" : ""%>>Ótima</option>
                        <option value="EXCELENTE" <%="EXCELENTE".equals(estadoConservFiltro) ? "selected" : ""%>>Excelente</option>
                    </select>
                </div>
                
                <div class="filter-group">
                    <label for="ordemAvalicao">Ordenar por Avaliação:</label>
                    <select id="ordemAvalicao" name="ordemAvalicao">
                        <option value="">Sem ordenação</option>
                        <option value="ASC" <%="ASC".equals(ordemAvalicaoFiltro) ? "selected" : ""%>>Menor para Maior</option>
                        <option value="DESC" <%="DESC".equals(ordemAvalicaoFiltro) ? "selected" : ""%>>Maior para Menor</option>
                    </select>
                </div>
                
                <div class="filter-group" style="align-self: end;">
                    <button type="submit" class="btn">
                        <i class="fas fa-search"></i> Filtrar
                    </button>
                </div>
            </form>
        </div>
        
        <div class="bike-grid">
            <% if (listaBicicletas != null && !listaBicicletas.isEmpty()) { %>
                <% for (Bicicleta bicicleta : listaBicicletas) { %>
                    <div class="bike-card">
                        <img src="<%=bicicleta.getFoto_bike()%>" alt="<%=bicicleta.getFoto_bike()%>" class="bike-image">
                        <div class="bike-name"><%=bicicleta.getNome_bike() != null ? bicicleta.getNome_bike() : "Bicicleta"%></div>
                        <div class="bike-details">
                            <div><i class="fas fa-bicycle"></i> <%=bicicleta.getTipo_bike() != null ? bicicleta.getTipo_bike() : "Não informado"%></div>
                            <div><i class="fas fa-map-marker-alt"></i> <%=bicicleta.getLocalEntr_bike() != null ? bicicleta.getLocalEntr_bike() : "Local não informado"%></div>
                            <% if (bicicleta.getUsuario() != null) { %>
                                <div><i class="fas fa-user"></i> <%=bicicleta.getUsuario().getNomeRazaoSocial_user() != null ? bicicleta.getUsuario().getNomeRazaoSocial_user() : "Proprietário não informado"%></div>
                            <% } %>
                            <div><i class="fas fa-cogs"></i> Estado: <%=bicicleta.getEstadoConserv_bike() != null ? bicicleta.getEstadoConserv_bike() : "Não informado"%></div>
                        </div>
                        
                        <div class="bike-rating">
                            <% 
                                Float avaliacao = bicicleta.getAvaliacao_bike();
                                // Debug: verificar se avaliação tem valor
                                System.out.println("DEBUG LOCATARIO - Bicicleta ID: " + bicicleta.getId_bike() + ", Avaliação: " + avaliacao);
                                
                                if (avaliacao != null && avaliacao > 0) {
                                    int estrelas = (int) Math.round(avaliacao);
                                    for (int i = 1; i <= 5; i++) {
                                        if (i <= estrelas) {
                            %>
                                            <i class="fas fa-star"></i>
                            <%      } else { %>
                                            <i class="far fa-star"></i>
                            <%      }
                                    }
                            %>
                                    <%=String.format("%.1f", avaliacao)%>/5.0
                            <% } else { %>
                                <i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i><i class="far fa-star"></i>
                                <span style="color: #666;">Sem avaliações</span>
                            <% } %>
                        </div>
                        
                        <div class="bike-status status-disponivel">Disponível</div>
                        
                        <div class="bike-actions">
                            <a href="<%=request.getContextPath()%>/BicicletaController?action=exibir-locatario&id=<%=bicicleta.getId_bike()%>" class="btn">
                                <i class="fas fa-eye"></i> Ver Detalhes
                            </a>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <div class="empty-state">
                    <i class="fas fa-search"></i>
                    <h3>Nenhuma bicicleta encontrada</h3>
                    <p>Tente ajustar os filtros de busca ou <a href="<%=request.getContextPath()%>/BicicletaController?action=lista-locatario">ver todas as bicicletas disponíveis</a>.</p>
                </div>
            <% } %>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
</body>
</html>
