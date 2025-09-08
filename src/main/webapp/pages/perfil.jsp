<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="br.com.sharebike.model.Feedback" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
// Buscar dados do usuário do request
Usuario usuario = (Usuario) request.getAttribute("usuario");
List<Feedback> feedbacksRecebidos = (List<Feedback>) request.getAttribute("feedbacksRecebidos");
List<Feedback> observacoesBicicletas = (List<Feedback>) request.getAttribute("observacoesBicicletas");
Integer totalFeedbacks = (Integer) request.getAttribute("totalFeedbacks");
Double mediaAvaliacao = (Double) request.getAttribute("mediaAvaliacao");

// Se não há dados no request, redirecionar
if (usuario == null) {
    response.sendRedirect(request.getContextPath() + "/UsuarioController?action=perfil");
    return;
}

// Formatador para exibir a média com 1 casa decimal
DecimalFormat df = new DecimalFormat("#.#");
String mediaFormatada;
if (mediaAvaliacao != null && mediaAvaliacao > 0) {
    mediaFormatada = df.format(mediaAvaliacao);
} else {
    mediaFormatada = "Sem avaliação";
}

// Verificar se o usuário possui bicicleta
String possuiBikeTexto = usuario.isPossuiBike_user() ? "Sim" : "Não";

// Status do ranking
String statusRanking = usuario.isPermissaoRank_user() ? "Ativo no ranking" : "Não está participando";
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Perfil</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/usuarioDetalhes.css">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #006644;
            padding: 10px 20px;
            color: white;
        }

        .navbar-center {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
            padding: 8px 12px;
            border-radius: 4px;
            transition: background-color 0.3s;
            cursor: pointer;
        }

        .navbar a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .navbar a:visited {
            color: white;
        }

        .project-name {
            font-size: 1.5em;
            font-weight: bold;
        }

        .logout-button {
            background-color: #cc0000;
            border: none;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .logout-button:hover {
            background-color: #a80000;
        }

        #tipoUsuario {
            padding: 6px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background: white;
            margin-left: 10px;
        }

        .perfil {
            padding: 40px 20px;
            max-width: 800px;
            margin: auto;
        }

        .perfil-info {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .foto-perfil {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin-bottom: 20px;
            object-fit: cover;
            border: 4px solid #006644;
        }

        .avatar-iniciais {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 20px auto;
            background: linear-gradient(135deg, #006644, #008066);
            color: white;
            font-size: 2.5em;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 4px solid #006644;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }

        .nome-usuario {
            font-size: 2em;
            color: #333;
            margin-bottom: 15px;
        }

        .avaliacao {
            margin: 20px 0;
            font-size: 1.2em;
        }

        .estrela {
            color: #ffd700;
            font-size: 1.5em;
            margin: 0 2px;
        }

        .estrela.apagada {
            color: #ddd;
        }

        .nota {
            margin-left: 10px;
            color: #666;
        }

        .info-usuario {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
            text-align: left;
        }

        .info-usuario p {
            margin: 8px 0;
            padding: 8px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .btn-alterar {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            margin-top: 20px;
        }

        .btn-alterar:hover {
            background-color: #0056b3;
        }

        .feedbacks {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .feedbacks h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.5em;
        }

        .feedback {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
            border-left: 4px solid #006644;
        }

        .feedback p {
            margin: 0;
            line-height: 1.6;
        }

        .feedback strong {
            color: #006644;
        }

        .feedback small {
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
    <!-- Barra de navegação -->
    <nav class="navbar">
        <div class="navbar-left">
            <span class="project-name">ShareBike</span>
        </div>
        <div class="navbar-center">
            <a href="#perfil">Perfil</a>
            <a href="<%= request.getContextPath() %>/BicicletaController?action=lista-locatario" class="nav-locatario">Bicicletas</a>
            <a href="<%= request.getContextPath() %>/BicicletaController?action=minhas-bikes&cpfCnpj=<%= usuario.getCpfCnpj_user() %>" class="nav-locador">Bicicletas</a>
            <% if (usuario.isPermissaoRank_user()) { %>
                <a href="<%= request.getContextPath() %>/RankingController?action=pagina-locatario" class="nav-locatario">Ranking</a>
            <% } else { %>
                <a href="#" onclick="alertSemPermissaoRanking()" class="nav-locatario" style="color: #ccc; cursor: not-allowed;">Ranking</a>
            <% } %>
            <a href="<%= request.getContextPath() %>/ReservaController?action=listar-minhas-reservas" class="nav-locatario">Reservas</a>
            <a href="<%= request.getContextPath() %>/ReservaController?action=listar-minhas-reservas-locador" class="nav-locador">Reservas</a>
            <select id="tipoUsuario">
                <option value="locador">Locador</option>
                <option value="locatario">Locatário</option>
            </select>
        </div>
        <div class="navbar-right">
            <form action="<%= request.getContextPath() %>/UsuarioController" method="post">
                <input type="hidden" name="action" value="logout">
                <button type="submit" class="logout-button">Sair</button>
            </form>
        </div>
    </nav>

    <!-- Perfil do usuário -->
    <section class="perfil" id="perfil">
        <div class="perfil-info">
            <%
            // Verificar se há foto do usuário
            String fotoUser = usuario.getFoto_user();
            boolean temFoto = fotoUser != null && !fotoUser.isEmpty() && !fotoUser.equals("default.jpg");
            
            if (temFoto) {
            %>
            <img src="<%= request.getContextPath() %>/assets/images/<%= fotoUser %>" alt="Foto do Usuário" class="foto-perfil" 
                 onerror="this.style.display='none'; document.getElementById('avatar-iniciais').style.display='flex';">
            <%
            }
            
            // Gerar iniciais do nome para avatar
            String nomeCompleto = usuario.getNomeRazaoSocial_user();
            String iniciais = "";
            if (nomeCompleto != null && !nomeCompleto.trim().isEmpty()) {
                String[] partesNome = nomeCompleto.trim().split("\\s+");
                if (partesNome.length > 0) {
                    iniciais += partesNome[0].charAt(0);
                    if (partesNome.length > 1) {
                        iniciais += partesNome[partesNome.length - 1].charAt(0);
                    }
                }
                iniciais = iniciais.toUpperCase();
            } else {
                iniciais = "?";
            }
            %>
            <div id="avatar-iniciais" class="avatar-iniciais" style="display: <%= temFoto ? "none" : "flex" %>;">
                <%= iniciais %>
            </div>
            <h2 class="nome-usuario"><%= usuario.getNomeRazaoSocial_user() %></h2>
            <div class="avaliacao">
                <%
                if (mediaAvaliacao != null && mediaAvaliacao > 0) {
                    // Calcular quantas estrelas exibir
                    int estrelasCompletas = (int) Math.floor(mediaAvaliacao);
                    boolean meiaestrela = (mediaAvaliacao - estrelasCompletas) >= 0.5;
                    
                    // Exibir estrelas preenchidas
                    for (int i = 0; i < estrelasCompletas; i++) {
                %>
                <span class="estrela">&#9733;</span>
                <%
                    }
                    
                    // Exibir meia estrela se necessário
                    if (meiaestrela && estrelasCompletas < 5) {
                %>
                <span class="estrela">&#9733;</span>
                <%
                        estrelasCompletas++;
                    }
                    
                    // Exibir estrelas vazias
                    for (int i = estrelasCompletas; i < 5; i++) {
                %>
                <span class="estrela apagada">&#9733;</span>
                <%
                    }
                %>
                <span class="nota">(<%= mediaFormatada %>)</span>
                <%
                } else {
                %>
                <span class="estrela apagada">&#9733;</span>
                <span class="estrela apagada">&#9733;</span>
                <span class="estrela apagada">&#9733;</span>
                <span class="estrela apagada">&#9733;</span>
                <span class="estrela apagada">&#9733;</span>
                <span class="nota">(<%= mediaFormatada %>)</span>
                <%
                }
                %>
            </div>
            <div class="info-usuario">
                <p><strong>Email:</strong> <%= usuario.getEmail_user() %></p>
                <p><strong>Telefone:</strong> <%= usuario.getTelefone_user() %></p>
                <p><strong>Localização:</strong> <%= usuario.getCidade_user() %> - <%= usuario.getEstado_user() %>, <%= usuario.getPais_user() %></p>
                <p><strong>Possui Bicicleta:</strong> <%= possuiBikeTexto %></p>
                <p><strong>Ranking:</strong> <%= statusRanking %></p>
            </div>
            <form action="<%= request.getContextPath() %>/UsuarioController" method="get">
                <input type="hidden" name="action" value="carregarEdicao">
                <button type="submit" class="btn-alterar">Alterar Informações</button>
            </form>
        </div>

        <!-- Feedbacks -->
        <div class="feedbacks">
            <h3>Feedbacks sobre <%= usuario.getNomeRazaoSocial_user() %> (<%= totalFeedbacks %> avaliações)</h3>
            
            <%
            if (feedbacksRecebidos != null && !feedbacksRecebidos.isEmpty()) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                for (Feedback feedback : feedbacksRecebidos) {
            %>
            <div class="feedback">
                <p>
                    <strong><%= feedback.getAvaliador_Usuario() != null && feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() != null ? feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() : "Usuário Anônimo" %>:</strong>
                    <%= feedback.getObsUser_feedb() != null ? feedback.getObsUser_feedb() : "Sem comentário" %>
                    <br>
                    Avaliação: <%= feedback.getAvaliacaoUser_feedb() %>/5
                    <br>
                    <small>Data: <%= feedback.getData_feedb() != null ? feedback.getData_feedb().format(formatter) : "Data não informada" %></small>
                </p>
            </div>
            <%
                }
            } else {
            %>
            <div class="feedback">
                <p>Ainda não há feedbacks para este usuário.</p>
            </div>
            <%
            }
            %>
        </div>

        <!-- Observações sobre Bicicletas -->
        <div class="feedbacks" style="margin-top: 30px;">
            <h3>Observações sobre como você tratou as bicicletas 
                <%
                int totalObservacoes = (observacoesBicicletas != null) ? observacoesBicicletas.size() : 0;
                %>
                (<%= totalObservacoes %> observações)
            </h3>
            
            <%
            if (observacoesBicicletas != null && !observacoesBicicletas.isEmpty()) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                for (Feedback observacao : observacoesBicicletas) {
            %>
            <div class="feedback">
                <p>
                    <strong>🚲 <%= observacao.getReserva() != null && observacao.getReserva().getBicicleta() != null ? 
                                   observacao.getReserva().getBicicleta().getNome_bike() : "Bicicleta não identificada" %></strong>
                    <br>
                    👤 Locador: <%= observacao.getAvaliador_Usuario() != null ? observacao.getAvaliador_Usuario().getNomeRazaoSocial_user() : "Locador" %>
                    <br>
                    💬 Observação: <%= observacao.getObsBike_feedb() != null ? observacao.getObsBike_feedb() : "Sem observação" %>
                    <br>
                    <small>Data: <%= observacao.getData_feedb() != null ? observacao.getData_feedb().format(formatter) : "Data não informada" %></small>
                </p>
            </div>
            <%
                }
            } else {
            %>
            <div class="feedback">
                <p>Ainda não há observações dos locadores sobre como você tratou as bicicletas.</p>
            </div>
            <%
            }
            %>
        </div>
    </section>

    <script>
        // Função para alertar sobre falta de permissão no ranking
        function alertSemPermissaoRanking() {
            alert('Você não tem permissão para acessar o ranking. Entre em contato com o administrador para solicitar acesso.');
        }
        
        document.addEventListener('DOMContentLoaded', function () {
            console.log('Script carregado - Debug perfil.jsp');
            console.log('Context Path atual:', '<%= request.getContextPath() %>');
            console.log('Request URI:', '<%= request.getRequestURI() %>');
            
            const tipoSelect = document.getElementById('tipoUsuario');
            const navLocador = document.querySelectorAll('.nav-locador');
            const navLocatario = document.querySelectorAll('.nav-locatario');
            
            console.log('Elementos encontrados:', {
                tipoSelect: tipoSelect,
                navLocador: navLocador.length,
                navLocatario: navLocatario.length
            });

            function atualizarVisibilidade(tipo) {
                console.log('Atualizando visibilidade para:', tipo);
                if (tipo === 'locador') {
                    navLocador.forEach(element => element.style.display = 'inline');
                    navLocatario.forEach(element => element.style.display = 'none');
                } else {
                    navLocador.forEach(element => element.style.display = 'none');
                    navLocatario.forEach(element => element.style.display = 'inline');
                }
            }

            const tipoSalvo = localStorage.getItem('tipoUsuario') || 'locador';
            console.log('Tipo salvo no localStorage:', tipoSalvo);
            tipoSelect.value = tipoSalvo;
            atualizarVisibilidade(tipoSalvo);

            tipoSelect.addEventListener('change', function () {
                const novoTipo = tipoSelect.value;
                console.log('Mudança detectada para:', novoTipo);
                localStorage.setItem('tipoUsuario', novoTipo);
                atualizarVisibilidade(novoTipo);
            });
            
            // Debug dos links
            const links = document.querySelectorAll('.navbar a');
            links.forEach((link, index) => {
                console.log(`Link ${index}:`, link.href, 'Text:', link.textContent);
            });
        });
    </script>
</body>
</html>
