<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestão de Usuários - ShareBike</title>
<link rel="stylesheet" href="../assets/css/gestaoUsuario.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 20px;
        background: #f8f9fa;
        min-height: 100vh;
    }
    
    .gestao-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 2rem;
        border-radius: 15px;
        margin-bottom: 2rem;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    }
    
    .gestao-title {
        font-size: 2.5rem;
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 1rem;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }
    
    .stat-card {
        background: white;
        padding: 2rem;
        border-radius: 15px;
        text-align: center;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }
    
    .stat-icon {
        font-size: 3rem;
        margin-bottom: 1rem;
    }
    
    .stat-value {
        font-size: 2.5rem;
        font-weight: bold;
        color: #333;
        margin-bottom: 0.5rem;
    }
    
    .stat-label {
        color: #666;
        font-size: 1rem;
        font-weight: 500;
    }
    
    .nav {
        background: white;
        padding: 1.5rem;
        border-radius: 15px;
        margin-bottom: 2rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        display: flex;
        gap: 1rem;
        flex-wrap: wrap;
    }
    
    .nav a {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 1rem 2rem;
        text-decoration: none;
        border-radius: 10px;
        font-weight: 600;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    
    .nav a:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }
    
    .search-bar {
        background: white;
        padding: 2rem;
        border-radius: 15px;
        margin-bottom: 2rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }
    
    .search-bar form {
        display: flex;
        gap: 1rem;
        align-items: center;
        flex-wrap: wrap;
    }
    
    .search-bar input {
        flex: 1;
        padding: 1rem;
        border: 2px solid #e9ecef;
        border-radius: 10px;
        font-size: 1rem;
        min-width: 250px;
    }
    
    .search-bar input:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }
    
    .search-bar button {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: white;
        border: none;
        padding: 1rem 2rem;
        border-radius: 10px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .search-bar button:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }
    
    .users-section {
        background: white;
        border-radius: 15px;
        padding: 2rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
    }
    
    .section-title {
        font-size: 1.5rem;
        color: #333;
        margin-bottom: 2rem;
        display: flex;
        align-items: center;
        gap: 0.8rem;
        padding-bottom: 1rem;
        border-bottom: 2px solid #f8f9fa;
    }
    
    .user-card {
        display: flex;
        align-items: center;
        gap: 1.5rem;
        padding: 1.5rem;
        background: #f8f9fa;
        border-radius: 12px;
        margin-bottom: 1rem;
        transition: all 0.3s ease;
        border: 2px solid transparent;
        cursor: pointer;
    }
    
    .user-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        border-color: #667eea;
        background: white;
    }
    
    .user-avatar {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background: linear-gradient(135deg, #667eea, #764ba2);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        color: white;
        font-weight: bold;
        flex-shrink: 0;
    }
    
    .user-info {
        flex: 1;
        min-width: 0;
    }
    
    .user-name {
        font-weight: 600;
        color: #333;
        margin-bottom: 0.5rem;
        font-size: 1.1rem;
    }
    
    .user-details {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 0.5rem;
        font-size: 0.9rem;
        color: #666;
    }
    
    .detail-item {
        display: flex;
        align-items: center;
        gap: 0.3rem;
    }
    
    .user-actions {
        display: flex;
        gap: 0.5rem;
        flex-shrink: 0;
    }
    
    .btn {
        padding: 0.5rem 1rem;
        border: none;
        border-radius: 8px;
        font-size: 0.8rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 0.3rem;
    }
    
    .btn-edit {
        background: linear-gradient(135deg, #ffc107, #e0a800);
        color: #212529;
    }
    
    .btn-view {
        background: linear-gradient(135deg, #17a2b8, #138496);
        color: white;
    }
    
    .btn-permission {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: white;
    }
    
    .btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
    }
    
    .permission-badge {
        padding: 0.3rem 0.8rem;
        border-radius: 15px;
        font-size: 0.8rem;
        font-weight: 500;
    }
    
    .permission-yes {
        background: #d4edda;
        color: #28a745;
    }
    
    .permission-no {
        background: #f8d7da;
        color: #dc3545;
    }
    
    .permission-pending {
        background: #fff3cd;
        color: #856404;
    }
    
    .back-button {
        text-align: center;
        margin-top: 2rem;
    }
    
    .btn-back {
        background: linear-gradient(135deg, #6c757d, #5a6268);
        color: white;
        padding: 1rem 2rem;
        text-decoration: none;
        border-radius: 10px;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 0.8rem;
    }
    
    .btn-back:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        text-decoration: none;
        color: white;
    }
    
    footer {
        background: #333;
        color: white;
        text-align: center;
        padding: 2rem;
        border-radius: 15px;
        margin-top: 2rem;
    }
</style>
</head>
<body>
<div class="container">
    <!-- Botão de voltar no início -->
    <div style="margin-bottom: 1rem;">
        <a href="<%=request.getContextPath()%>/pages/admDetalhes.jsp" class="btn-back" style="background: linear-gradient(135deg, #6c757d, #495057); color: white; padding: 0.8rem 1.5rem; text-decoration: none; border-radius: 8px; display: inline-flex; align-items: center; gap: 0.5rem; font-weight: 600; transition: all 0.3s ease;">
            <i class="fas fa-arrow-left"></i> Voltar para Página Inicial
        </a>
    </div>
    
    <!-- Header -->
    <div class="gestao-header">
        <h1 class="gestao-title">
            <i class="fas fa-users-cog"></i> 
            Gestão de Usuários ShareBike
        </h1>
        <p>Dashboard central para visualização e navegação entre as diferentes categorias de usuários</p>
    </div>
    
    <!-- Estatísticas -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon" style="color: #28a745;">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-value">847</div>
            <div class="stat-label">Usuários Cadastrados</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon" style="color: #17a2b8;">
                <i class="fas fa-user-check"></i>
            </div>
            <div class="stat-value">623</div>
            <div class="stat-label">Usuários Ativos</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon" style="color: #ffc107;">
                <i class="fas fa-user-clock"></i>
            </div>
            <div class="stat-value">45</div>
            <div class="stat-label">Usuários Aguardando Permissão</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon" style="color: #dc3545;">
                <i class="fas fa-trophy"></i>
            </div>
            <div class="stat-value">23</div>
            <div class="stat-label">Elegíveis para Ranking</div>
        </div>
    </div>
    
    <!-- Navegação -->
    <nav class="nav">
        <a href="usuariosPermissao.jsp">
            <i class="fas fa-user-clock"></i> Usuários Aguardando Permissão
        </a>
        <a href="usuariosRanking.jsp">
            <i class="fas fa-trophy"></i> Usuários Elegíveis para Ranking
        </a>
    </nav>
    
    <!-- Barra de Pesquisa -->
    <div class="search-bar">
        <form>
            <input type="text" name="nomeRazaoSocial" placeholder="Pesquisar usuário pelo nome, email ou CPF/CNPJ">
            <button type="button" onclick="buscarUsuario()">
                <i class="fas fa-search"></i> Buscar
            </button>
        </form>
    </div>
    
    <!-- Lista de Usuários -->
    <div class="users-section">
        <h3 class="section-title">
            <i class="fas fa-list"></i> 
            Últimos Usuários Cadastrados
        </h3>
        
        <!-- Usuários com dados baseados no modelo Usuario -->
        <div class="user-card">
            <div class="user-avatar">MS</div>
            <div class="user-info">
                <div class="user-name">Maria Silva Santos</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> maria.silva@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 12345678901
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> São Paulo, SP, Brasil
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-phone"></i> (11) 99999-8888
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-star"></i> Avaliação: 4.5/5.0
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> Possui Bike: Sim
                    </div>
                </div>
            </div>
            <div class="user-actions">
                <span class="permission-badge permission-yes">Acesso Liberado</span>
                <button class="btn btn-view" onclick="event.stopPropagation(); redirecionarParaPerfil('12345678901')">
                    <i class="fas fa-eye"></i> Ver Detalhes
                </button>
            </div>
        </div>
        
        <div class="user-card">
            <div class="user-avatar">JP</div>
            <div class="user-info">
                <div class="user-name">João Pedro Oliveira</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> joao.pedro@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 98765432100
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> Rio de Janeiro, RJ, Brasil
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-phone"></i> (21) 88888-7777
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-star"></i> Avaliação: Sem avaliação
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> Possui Bike: Não
                    </div>
                </div>
            </div>
            <div class="user-actions">
                <span class="permission-badge permission-pending">Aguardando Permissão</span>
                <button class="btn btn-view" onclick="event.stopPropagation(); redirecionarParaPerfil('98765432100')">
                    <i class="fas fa-eye"></i> Ver Detalhes
                </button>
            </div>
        </div>
        
        <div class="user-card">
            <div class="user-avatar">AC</div>
            <div class="user-info">
                <div class="user-name">Ana Carolina Costa</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> ana.costa@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 11122233345
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> Belo Horizonte, MG, Brasil
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-phone"></i> (31) 77777-6666
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-star"></i> Avaliação: 4.8/5.0
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> Possui Bike: Sim
                    </div>
                </div>
            </div>
            <div class="user-actions">
                <span class="permission-badge permission-yes">Acesso Liberado</span>
                <button class="btn btn-view" onclick="event.stopPropagation(); redirecionarParaPerfil('11122233345')">
                    <i class="fas fa-eye"></i> Ver Detalhes
                </button>
            </div>
        </div>
        
        <div class="user-card">
            <div class="user-avatar">CE</div>
            <div class="user-info">
                <div class="user-name">Carlos Eduardo Lima</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> carlos.lima@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 55566677788
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> Brasília, DF, Brasil
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-phone"></i> (61) 66666-5555
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-star"></i> Avaliação: 2.1/5.0
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> Possui Bike: Não
                    </div>
                </div>
            </div>
            <div class="user-actions">
                <span class="permission-badge permission-no">Acesso Negado</span>
                <button class="btn btn-view" onclick="event.stopPropagation(); redirecionarParaPerfil('55566677788')">
                    <i class="fas fa-eye"></i> Ver Detalhes
                </button>
            </div>
        </div>
        
        <div class="user-card">
            <div class="user-avatar">FS</div>
            <div class="user-info">
                <div class="user-name">Fernanda Santos</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> fernanda.santos@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 99988877766
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> Salvador, BA, Brasil
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-phone"></i> (71) 55555-4444
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-star"></i> Avaliação: 4.2/5.0
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> Possui Bike: Sim
                    </div>
                </div>
            </div>
            <div class="user-actions">
                <span class="permission-badge permission-yes">Acesso Liberado</span>
                <button class="btn btn-view" onclick="event.stopPropagation(); redirecionarParaPerfil('99988877766')">
                    <i class="fas fa-eye"></i> Ver Detalhes
                </button>
            </div>
        </div>
    </div>
</div>

<footer>
    <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
</footer>

<script>
    function redirecionarParaPerfil(cpfCnpj) {
        console.log('Redirecionando para perfil:', cpfCnpj);
        // Redirecionar para a página de perfil do convidado
        window.location.href = '<%=request.getContextPath()%>/pages/PerfilConvidado.jsp?cpf=' + cpfCnpj;
    }
    
    function buscarUsuario() {
        const termo = document.querySelector('input[name="nomeRazaoSocial"]').value;
        console.log('Buscando usuário:', termo);
        
        if (!termo.trim()) {
            alert('Digite um termo para buscar (nome, email ou CPF/CNPJ)');
            return;
        }
        
        // Redirecionar para a página de perfil do convidado com o termo de busca
        window.location.href = '<%=request.getContextPath()%>/pages/PerfilConvidado.jsp?busca=' + encodeURIComponent(termo);
    }
</script>
</body>
</html>
