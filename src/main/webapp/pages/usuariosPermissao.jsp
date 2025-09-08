<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Usuários Aguardando Aprovação - ShareBike</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/gestaoUsuario.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #f8f9fa;
            min-height: 100vh;
        }
        
        .approval-header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .approval-title {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .user-card {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            padding: 1.5rem;
            background: white;
            border-radius: 12px;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            border: 2px solid transparent;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .user-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            border-color: #38b2ac;
        }
        
        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #38b2ac, #0d9488);
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
        
        .status-pending {
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            color: #1f2937;
            padding: 0.6rem 1.2rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            flex-shrink: 0;
        }
        
        .user-type-badge {
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 500;
            display: inline-block;
            margin-top: 0.5rem;
        }
        
        .company-type {
            background: linear-gradient(135deg, #10b981, #047857);
        }
        
        .no-users {
            text-align: center;
            color: #666;
            font-style: italic;
            margin: 3rem 0;
            padding: 3rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .no-users i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #dee2e6;
        }
        
        .back-button {
            background: linear-gradient(135deg, #6b7280, #4b5563);
            color: white;
            padding: 1rem 2rem;
            text-decoration: none;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            margin-bottom: 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .back-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            color: white;
        }
        
        .section-title {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 1.5rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .user-count {
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            color: white;
            padding: 1rem 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            text-align: center;
            font-weight: 600;
            font-size: 1.1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .actions-section {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .btn-approve {
            background: linear-gradient(135deg, #10b981, #047857);
            color: white;
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-approve:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
        
        .btn-view {
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            color: white;
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-view:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            text-decoration: none;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <form action="<%=request.getContextPath()%>/UsuarioController" method="get" style="display: inline-block;">
            <button type="submit" class="back-button">
                <i class="fas fa-arrow-left"></i> Voltar para Gestão
            </button>
        </form>
        
        <div class="approval-header">
            <h1 class="approval-title">
                <i class="fas fa-user-clock"></i> 
                Usuários Aguardando Aprovação de Acesso
            </h1>
            <p>Gerencie usuários que se cadastraram no sistema e aguardam liberação para utilizar a plataforma ShareBike</p>
        </div>
        
        <%
            List<Usuario> listaUsuario = (List<Usuario>) request.getAttribute("listaUsuarioAcesso");
            int totalPendentes = (listaUsuario != null) ? listaUsuario.size() : 0;
        %>
        
        <div class="user-count">
            <i class="fas fa-users"></i> 
            <strong><%= totalPendentes %> usuário<%= totalPendentes != 1 ? "s" : "" %></strong> 
            aguardando aprovação de acesso ao sistema
        </div>
        
        <h2 class="section-title">
            <i class="fas fa-list"></i> 
            Lista de Usuários Pendentes
        </h2>
        
        <!-- Usuários com dados dinâmicos do banco -->
        <%
            if (listaUsuario == null || listaUsuario.isEmpty()) {
        %>
            <div class="no-users">
                <i class="fas fa-check-circle"></i>
                <h3>Nenhum usuário aguardando aprovação</h3>
                <p>Todos os usuários cadastrados já foram aprovados para acessar o sistema.</p>
            </div>
        <%
            } else {
                for (Usuario usuario : listaUsuario) {
                    String iniciais = "";
                    if (usuario.getNomeRazaoSocial_user() != null && !usuario.getNomeRazaoSocial_user().trim().isEmpty()) {
                        String[] nomes = usuario.getNomeRazaoSocial_user().trim().split(" ");
                        iniciais += nomes[0].charAt(0);
                        if (nomes.length > 1) {
                            iniciais += nomes[nomes.length - 1].charAt(0);
                        }
                        iniciais = iniciais.toUpperCase();
                    }
        %>
            <div class="user-card">
                <div class="user-avatar"><%= iniciais %></div>
                <div class="user-info">
                    <div class="user-name"><%= usuario.getNomeRazaoSocial_user() %></div>
                </div>
                <div class="actions-section">
                    <div class="status-pending">
                        <i class="fas fa-hourglass-half"></i>
                        Aguardando Aprovação
                    </div>
                    
                    <!-- Formulário para aprovar usuário -->
                    <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
                        <input type="hidden" name="action" value="exibir">
                        <input type="hidden" name="cpfCnpj" value="<%= usuario.getCpfCnpj_user() %>">
                        <input type="hidden" name="origem" value="usuariosPermissao">
                        <button type="submit" class="btn-approve">
                            <i class="fas fa-check"></i> Verificar Usuario
                        </button>
                    </form>
                    
                </div>
            </div>
        <%
                }
            }
        %>
    </div>
</body>
</html>