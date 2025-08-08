<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
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
            <a href="<%= request.getContextPath() %>/pages/bicicletasLocatario.jsp" class="nav-locatario">Bicicletas</a>
            <a href="<%= request.getContextPath() %>/pages/bicicletasLocador.jsp" class="nav-locador">Bicicletas</a>
            <a href="<%= request.getContextPath() %>/pages/rankingLocatario.jsp" class="nav-locatario">Ranking</a>
            <a href="<%= request.getContextPath() %>/pages/reservasLocatario.jsp" class="nav-locatario">Reservas</a>
            <a href="<%= request.getContextPath() %>/pages/reservasLocador.jsp" class="nav-locador">Reservas</a>
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
            <img src="<%= request.getContextPath() %>/assets/images/user-avatar.jpg" alt="Foto do Usuário" class="foto-perfil">
            <h2 class="nome-usuario">Maria Silva Santos</h2>
            <div class="avaliacao">
                <span class="estrela">&#9733;</span>
                <span class="estrela">&#9733;</span>
                <span class="estrela">&#9733;</span>
                <span class="estrela">&#9733;</span>
                <span class="estrela apagada">&#9733;</span>
                <span class="nota">(4.2)</span>
            </div>
            <div class="info-usuario">
                <p><strong>Email:</strong> maria.silva@email.com</p>
                <p><strong>Telefone:</strong> (11) 99999-8888</p>
                <p><strong>Cidade:</strong> São Paulo - SP</p>
                <p><strong>Possui Bicicleta:</strong> Sim</p>
                <p><strong>Status:</strong> Ativo no ranking</p>
            </div>
            <form action="<%= request.getContextPath() %>/pages/editarUsuario.jsp" method="get">
                <button type="submit" class="btn-alterar">Alterar Informações</button>
            </form>
        </div>

        <!-- Feedbacks -->
        <div class="feedbacks">
            <h3>Feedbacks sobre Maria Silva Santos</h3>
            
            <div class="feedback">
                <p>
                    <strong>João Pedro Oliveira:</strong>
                    Excelente locadora! Bicicleta em perfeito estado e muito pontual na entrega.
                    <br>
                    Avaliação: 5/5
                    <br>
                    <small>Data: 25/07/2025</small>
                </p>
            </div>
            
            <div class="feedback">
                <p>
                    <strong>Ana Carolina Costa:</strong>
                    Muito responsável e comunicativa. Recomendo!
                    <br>
                    Avaliação: 4/5
                    <br>
                    <small>Data: 18/07/2025</small>
                </p>
            </div>
            
            <div class="feedback">
                <p>
                    <strong>Carlos Eduardo Lima:</strong>
                    Ótima experiência de locação. Bicicleta limpa e bem cuidada.
                    <br>
                    Avaliação: 4/5
                    <br>
                    <small>Data: 10/07/2025</small>
                </p>
            </div>
        </div>
    </section>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            console.log('Script carregado - Debug Perfil.jsp');
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
