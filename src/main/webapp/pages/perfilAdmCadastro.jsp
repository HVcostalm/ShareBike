<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Aprovação de Usuário - ShareBike</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/gestaoUsuario.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
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
            border: none;
            cursor: pointer;
        }
        
        .back-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            color: white;
        }
        
        .approval-header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .approval-title {
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }
        
        .profile-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        
        .user-header {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 2px solid #e5e7eb;
        }
        
        .user-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #38b2ac, #0d9488);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: white;
            font-weight: bold;
            flex-shrink: 0;
        }
        
        .user-basic-info h2 {
            margin: 0 0 0.5rem 0;
            color: #1f2937;
            font-size: 1.8rem;
        }
        
        .user-basic-info p {
            margin: 0.3rem 0;
            color: #6b7280;
            font-size: 1rem;
        }
        
        .status-badge {
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            color: #1f2937;
            padding: 0.6rem 1.2rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .detail-section {
            background: #f9fafb;
            padding: 1.5rem;
            border-radius: 12px;
            border-left: 4px solid #38b2ac;
        }
        
        .detail-section h3 {
            color: #1f2937;
            margin: 0 0 1rem 0;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .detail-row {
            display: flex;
            margin-bottom: 1rem;
            align-items: flex-start;
        }
        
        .detail-label {
            font-weight: 600;
            width: 140px;
            color: #374151;
            flex-shrink: 0;
        }
        
        .detail-value {
            flex: 1;
            color: #6b7280;
            word-break: break-word;
        }
        
        .user-type-badge {
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 500;
            display: inline-block;
        }
        
        .company-type {
            background: linear-gradient(135deg, #10b981, #047857);
        }
        
        .yes-indicator {
            color: #10b981;
            font-weight: 600;
        }
        
        .no-indicator {
            color: #ef4444;
            font-weight: 600;
        }
        
        .action-buttons {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
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
            min-width: 180px;
            justify-content: center;
        }
        
        .btn-approve {
            background: linear-gradient(135deg, #10b981, #047857);
            color: white;
        }
        
        .btn-approve:hover {
            background: linear-gradient(135deg, #047857, #065f46);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }
        
        .btn-deny {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }
        
        .btn-deny:hover {
            background: linear-gradient(135deg, #dc2626, #b91c1c);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }
        
        .permission-info {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            border: 1px solid #f59e0b;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .permission-info h4 {
            color: #92400e;
            margin: 0 0 0.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .permission-info p {
            color: #78350f;
            margin: 0;
            line-height: 1.5;
        }
        
        @media (max-width: 768px) {
            .user-header {
                flex-direction: column;
                text-align: center;
            }
            
            .details-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <%
        Usuario usuario = (Usuario) request.getAttribute("Usuario");
        String origem = (String) request.getAttribute("origem");
        
        if (usuario == null) {
    %>
        <div class="container">
            <div class="alert alert-danger">
                <h3>Erro: Usuário não encontrado</h3>
                <p>Não foi possível carregar os dados do usuário.</p>
                <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
                    <input type="hidden" name="action" value="aprovar-acesso">
                    <button type="submit" class="back-button">
                        <i class="fas fa-arrow-left"></i> Voltar para Lista
                    </button>
                </form>
            </div>
        </div>
    <%
        } else {
            // Calcular iniciais do usuário
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
    <div class="container">
        <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
            <input type="hidden" name="action" value="aprovar-acesso">
            <button type="submit" class="back-button">
                <i class="fas fa-arrow-left"></i> Voltar para Lista
            </button>
        </form>
        
        <div class="approval-header">
            <h1 class="approval-title">
                <i class="fas fa-user-check"></i> 
                Aprovação de Usuário
            </h1>
            <p>Analise os dados do usuário e decida sobre a aprovação do acesso à plataforma ShareBike</p>
        </div>
        
        <div class="permission-info">
            <h4><i class="fas fa-info-circle"></i> Importante:</h4>
            <p>Este usuário está aguardando aprovação para acessar a plataforma. Após a aprovação, ele poderá fazer login, cadastrar bicicletas e participar do sistema de compartilhamento.</p>
        </div>
        
        <div class="profile-card">
            <div class="user-header">
                <div class="user-avatar"><%= iniciais %></div>
                <div class="user-basic-info">
                    <h2><%= usuario.getNomeRazaoSocial_user() %></h2>
                    <p><i class="fas fa-envelope"></i> <%= usuario.getEmail_user() %></p>
                    <p><i class="fas fa-id-card"></i> <%= usuario.getCpfCnpj_user() %></p>
                    <div class="status-badge">
                        <i class="fas fa-hourglass-half"></i>
                        Aguardando Aprovação
                    </div>
                </div>
            </div>
            
            <div class="details-grid">
                <div class="detail-section">
                    <h3><i class="fas fa-map-marker-alt"></i> Localização</h3>
                    <div class="detail-row">
                        <div class="detail-label">Cidade:</div>
                        <div class="detail-value"><%= usuario.getCidade_user() != null ? usuario.getCidade_user() : "Não informado" %></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Estado:</div>
                        <div class="detail-value"><%= usuario.getEstado_user() != null ? usuario.getEstado_user() : "Não informado" %></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">País:</div>
                        <div class="detail-value"><%= usuario.getPais_user() != null ? usuario.getPais_user() : "Não informado" %></div>
                    </div>
                </div>
                
                <div class="detail-section">
                    <h3><i class="fas fa-phone"></i> Contato</h3>
                    <div class="detail-row">
                        <div class="detail-label">Telefone:</div>
                        <div class="detail-value"><%= usuario.getTelefone_user() != null ? usuario.getTelefone_user() : "Não informado" %></div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">E-mail:</div>
                        <div class="detail-value"><%= usuario.getEmail_user() %></div>
                    </div>
                </div>
                
                <div class="detail-section">
                    <h3><i class="fas fa-bicycle"></i> Bicicleta</h3>
                    <div class="detail-row">
                        <div class="detail-label">Possui Bike:</div>
                        <div class="detail-value">
                            <% if (usuario.isPossuiBike_user()) { %>
                                <span class="yes-indicator"><i class="fas fa-check"></i> Sim</span>
                            <% } else { %>
                                <span class="no-indicator"><i class="fas fa-times"></i> Não</span>
                            <% } %>
                        </div>
                    </div>
                    <% if (usuario.getFotoComprBike_user() != null && !usuario.getFotoComprBike_user().trim().isEmpty()) { %>
                    <div class="detail-row">
                        <div class="detail-label">Comprovante:</div>
                        <div class="detail-value">
                            <div style="background: #f0f0f0; padding: 10px; border-radius: 5px; color: #666;">
                                <i class="fas fa-file-image"></i> <%= usuario.getFotoComprBike_user() %>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                
                <div class="detail-section">
                    <h3><i class="fas fa-shield-alt"></i> Permissões</h3>
                    <div class="detail-row">
                        <div class="detail-label">Acesso:</div>
                        <div class="detail-value">
                            <% if (usuario.isPermissaoAcesso_user()) { %>
                                <span class="yes-indicator">✓ Liberado</span>
                            <% } else { %>
                                <span style="color: #f59e0b; font-weight: 600;">⏳ Pendente</span>
                            <% } %>
                        </div>
                    </div>
                    <div class="detail-row">
                        <div class="detail-label">Ranking:</div>
                        <div class="detail-value">
                            <% if (usuario.isPermissaoRank_user()) { %>
                                <span class="yes-indicator">Liberado</span>
                            <% } else { %>
                                <span style="color: #6b7280;">Não definido</span>
                            <% } %>
                        </div>
                    </div>
                    <% if (usuario.getAvaliacao_user() != null) { %>
                    <div class="detail-row">
                        <div class="detail-label">Avaliação:</div>
                        <div class="detail-value">
                            <span style="color: #f59e0b;">
                                <i class="fas fa-star"></i> <%= String.format("%.1f", usuario.getAvaliacao_user()) %>/5.0
                            </span>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            
            <div class="action-buttons">
                <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
                    <input type="hidden" name="action" value="aprovar-acesso-usuario">
                    <input type="hidden" name="cpfCnpj" value="<%= usuario.getCpfCnpj_user() %>">
                    <button type="submit" class="btn btn-approve" onclick="return confirm('Tem certeza que deseja aprovar o acesso deste usuário?');">
                        <i class="fas fa-check"></i> Aprovar Acesso
                    </button>
                </form>
                
                <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
                    <input type="hidden" name="action" value="negar-acesso-usuario">
                    <input type="hidden" name="cpfCnpj" value="<%= usuario.getCpfCnpj_user() %>">
                    <button type="submit" class="btn btn-deny" onclick="return confirm('Tem certeza que deseja negar o acesso e excluir este usuário?');">
                        <i class="fas fa-times"></i> Negar e Excluir
                    </button>
                </form>
            </div>
        </div>
    </div>
    <% } %>
</body>
</html>
