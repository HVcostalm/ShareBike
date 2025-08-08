<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Painel do Administrador</title>
<link rel="stylesheet" href="../assets/css/admDetalhes.css">
</head>
<body>
<header>
    <h1>Painel do Administrador</h1>
</header>
<div class="container">
    <nav class="nav">
        <a href="gestaoUsuario.jsp">Gestão de Usuários</a>
        <a href="rankingAdm.jsp">Gestão do Ranking</a>
        <a href="feedbackAdm.jsp">Monitorar Feedbacks</a>
        <a href="reservasAdm.jsp">Supervisão de Reservas</a>
        <a href="bicicletasAdm.jsp">Gestão de Bicicletas</a>
    </nav>
    <div class="logout">
        <form action="../UsuarioController" method="post" style="display: inline;">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="btn-logout">Sair</button>
        </form>
    </div>
</div>
<footer>
    <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
</footer>
</body>
</html>