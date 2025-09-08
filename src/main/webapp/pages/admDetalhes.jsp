<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Painel do Administrador</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/admDetalhes.css?v=2025">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
</head>
<body>
<header>
    <h1>Painel do Administrador</h1>
</header>
<div class="container">
    <nav class="nav">
        <a href="<%=request.getContextPath()%>/UsuarioController">
            <i class="fas fa-users"></i> Gestão de Usuários
        </a>
        <a href="<%=request.getContextPath()%>/RankingController">
            <i class="fas fa-trophy"></i> Gestão do Ranking
        </a>
        <a href="<%=request.getContextPath()%>/FeedbackController">
            <i class="fas fa-comment-dots"></i> Monitorar Feedbacks
        </a>
        <a href="<%=request.getContextPath()%>/ReservaController">
            <i class="fas fa-calendar-check"></i> Supervisão de Reservas
        </a>
        <a href="<%=request.getContextPath()%>/BicicletaController">
            <i class="fas fa-bicycle"></i> Gestão de Bicicletas
        </a>
    </nav>
    <div class="logout">
        <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline;">
            <input type="hidden" name="action" value="logout">
            <button type="submit" class="btn-logout">
                <i class="fas fa-sign-out-alt"></i> Sair
            </button>
        </form>
    </div>
</div>
<footer>
    <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
</footer>
</body>
</html>