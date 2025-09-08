<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="br.com.sharebike.model.Feedback" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Perfil do Usuário - ShareBike</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/usuarioDetalhes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .navbar {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .project-name {
            font-size: 1.8rem;
            font-weight: bold;
            color: white;
        }

        .back-button {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .back-button:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-1px);
        }

        .profile-header {
            background: white;
            border-radius: 20px;
            padding: 3rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
        }

        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin: 0 auto 2rem;
            border: 5px solid #17a2b8;
            object-fit: cover;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            background: linear-gradient(135deg, #17a2b8, #20c997);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            font-weight: bold;
        }

        .user-name {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 0.5rem;
            font-weight: 300;
        }

        .user-type {
            display: inline-block;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .rating-section {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stars {
            display: flex;
            gap: 0.2rem;
        }

        .star {
            color: #ffc107;
            font-size: 1.5rem;
        }

        .star.empty {
            color: #dee2e6;
        }

        .rating-text {
            font-size: 1.2rem;
            color: #6c757d;
            font-weight: 500;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .info-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .info-card h3 {
            color: #17a2b8;
            margin-bottom: 1.5rem;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.8rem 0;
            border-bottom: 1px solid #f8f9fa;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #6c757d;
            font-weight: 500;
        }

        .info-value {
            color: #333;
            font-weight: 600;
        }

        .status-badge {
            padding: 0.3rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .status-active {
            background: #d4edda;
            color: #28a745;
        }

        .status-inactive {
            background: #f8d7da;
            color: #dc3545;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }

        .empty-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .action-button {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .action-button:hover {
            background: linear-gradient(135deg, #c82333, #a71e2a);
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .action-button:active {
            transform: translateY(0);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .permission-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.8rem 0;
            border-bottom: 1px solid #f8f9fa;
        }

        .permission-row:last-child {
            border-bottom: none;
        }

        .permission-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex: 1;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .navbar {
                padding: 1rem;
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .profile-header {
                padding: 2rem 1rem;
            }
            
            .user-name {
                font-size: 2rem;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .rating-section {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <%
        Usuario usuario = (Usuario) request.getAttribute("Usuario");
        String origem = (String) request.getAttribute("origem");
        String bicicletaId = (String) request.getAttribute("bicicletaId");
        
        // Verificar se o usuário logado é administrador
        Usuario admLogado = (Usuario) session.getAttribute("admLogado");
        boolean isAdmin = (admLogado != null);
        
        // Valores padrão caso não haja dados
        if (usuario == null) {
            usuario = new Usuario();
            usuario.setNomeRazaoSocial_user("Usuário não encontrado");
            usuario.setCpfCnpj_user("000.000.000-00");
            usuario.setEmail_user("email@exemplo.com");
            usuario.setTelefone_user("(00) 00000-0000");
            usuario.setCidade_user("Cidade");
            usuario.setEstado_user("Estado");
            usuario.setPais_user("País");
            usuario.setAvaliacao_user(null);
            usuario.setPermissaoAcesso_user(false);
            usuario.setPermissaoRank_user(false);
            usuario.setPossuiBike_user(false);
        }
        
        // Gerar iniciais para o avatar
        String nomeCompleto = usuario.getNomeRazaoSocial_user() != null ? usuario.getNomeRazaoSocial_user() : "NN";
        String[] partesNome = nomeCompleto.split(" ");
        String iniciais = "";
        if (partesNome.length >= 2) {
            iniciais = partesNome[0].substring(0, 1).toUpperCase() + partesNome[1].substring(0, 1).toUpperCase();
        } else if (partesNome.length == 1) {
            iniciais = partesNome[0].substring(0, Math.min(2, partesNome[0].length())).toUpperCase();
        } else {
            iniciais = "NN";
        }
        
        // Calcular avaliação e estrelas
        Float avaliacao = usuario.getAvaliacao_user();
        int estrelasCompletas = 0;
        int estrelasVazias = 5;
        String textoAvaliacao = "Sem avaliação";
        
        if (avaliacao != null && avaliacao > 0) {
            estrelasCompletas = Math.round(avaliacao);
            estrelasVazias = 5 - estrelasCompletas;
            textoAvaliacao = String.format("%.1f de 5.0", avaliacao);
        }
    %>

    <div class="container">
        <!-- Barra de navegação -->
        <nav class="navbar">
            <div class="navbar-left">
                <span class="project-name">
                    <i class="fas fa-bicycle"></i> ShareBike
                </span>
            </div>
            <div class="navbar-right">
                <%
                    String voltarUrl = request.getContextPath() + "/UsuarioController";
                    if ("gestaoUsuario".equals(origem)) {
                        voltarUrl = request.getContextPath() + "/UsuarioController";
                    } else if ("bicicletaDetalhesLocatario".equals(origem)) {
                        if (bicicletaId != null && !bicicletaId.isEmpty()) {
                            voltarUrl = request.getContextPath() + "/BicicletaController?action=exibir-locatario&id=" + bicicletaId;
                        } else {
                            voltarUrl = request.getContextPath() + "/BicicletaController?action=lista-locatario";
                        }
                    } else if ("feedbackLocatario".equals(origem)) {
                        voltarUrl = request.getContextPath() + "/FeedbackController?action=pagina-locatario";
                    } else if ("feedbackLocador".equals(origem)) {
                        voltarUrl = request.getContextPath() + "/FeedbackController?action=pagina-locador";
                    }
                %>
                <a href="<%=voltarUrl%>" class="back-button">
                    <i class="fas fa-arrow-left"></i> Voltar
                </a>
            </div>
        </nav>

        <!-- Mensagens de Sucesso/Erro -->
        <%
            String mensagemSucesso = (String) session.getAttribute("mensagemSucesso");
            String mensagemErro = (String) session.getAttribute("mensagemErro");
            
            if (mensagemSucesso != null) {
                session.removeAttribute("mensagemSucesso");
        %>
            <div style="background: #d4edda; border: 1px solid #c3e6cb; color: #155724; padding: 1rem; border-radius: 8px; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-check-circle"></i>
                <span><%= mensagemSucesso %></span>
            </div>
        <%
            }
            
            if (mensagemErro != null) {
                session.removeAttribute("mensagemErro");
        %>
            <div style="background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; padding: 1rem; border-radius: 8px; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-exclamation-triangle"></i>
                <span><%= mensagemErro %></span>
            </div>
        <%
            }
        %>

        <!-- Cabeçalho do Perfil -->
        <div class="profile-header">
            <div class="profile-image">
                <%=iniciais%>
            </div>
            <h1 class="user-name"><%=usuario.getNomeRazaoSocial_user()%></h1>
            
            <div class="rating-section">
                <div class="stars">
                    <% for (int i = 0; i < estrelasCompletas; i++) { %>
                        <i class="fas fa-star star"></i>
                    <% } %>
                    <% for (int i = 0; i < estrelasVazias; i++) { %>
                        <i class="fas fa-star star empty"></i>
                    <% } %>
                </div>
                <span class="rating-text"><%=textoAvaliacao%></span>
            </div>
        </div>

        <!-- Grade de Informações -->
        <div class="info-grid">
            <!-- Informações Pessoais -->
            <div class="info-card">
                <h3>
                    <i class="fas fa-user"></i>
                    Informações Pessoais
                </h3>
                <div class="info-item">
                    <span class="info-label">Email:</span>
                    <span class="info-value"><%=usuario.getEmail_user() != null ? usuario.getEmail_user() : "Não informado"%></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Telefone:</span>
                    <span class="info-value"><%=usuario.getTelefone_user() != null ? usuario.getTelefone_user() : "Não informado"%></span>
                </div>
                <% if (isAdmin) { %>
                <div class="info-item">
                    <span class="info-label">CPF/CNPJ:</span>
                    <span class="info-value"><%=usuario.getCpfCnpj_user() != null ? usuario.getCpfCnpj_user() : "Não informado"%></span>
                </div>
                <% } %>
            </div>

            <% if (isAdmin) { %>
            <!-- Endereço -->
            <div class="info-card">
                <h3>
                    <i class="fas fa-map-marker-alt"></i>
                    Localização
                </h3>
                <div class="info-item">
                    <span class="info-label">Cidade:</span>
                    <span class="info-value"><%=usuario.getCidade_user() != null ? usuario.getCidade_user() : "Não informado"%></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Estado:</span>
                    <span class="info-value"><%=usuario.getEstado_user() != null ? usuario.getEstado_user() : "Não informado"%></span>
                </div>
                <div class="info-item">
                    <span class="info-label">País:</span>
                    <span class="info-value"><%=usuario.getPais_user() != null ? usuario.getPais_user() : "Não informado"%></span>
                </div>
            </div>
            <% } %>

            <% if (isAdmin) { %>
            <!-- Permissões e Status -->
            <div class="info-card">
                <h3>
                    <i class="fas fa-shield-alt"></i>
                    Permissões
                </h3>
                <div class="permission-row">
                    <div class="permission-info">
                        <span class="info-label">Acesso à Plataforma:</span>
                        <% if (usuario.isPermissaoAcesso_user()) { %>
                            <span class="status-badge status-active">Aprovado</span>
                        <% } else { %>
                            <span class="status-badge status-pending">Pendente</span>
                        <% } %>
                    </div>
                    <% if (usuario.isPermissaoAcesso_user()) { %>
                        <!-- Botão para negar acesso, só aparece se o usuário tem acesso aprovado -->
                        <button class="action-button" onclick="negarAcesso('<%=usuario.getCpfCnpj_user()%>')">
                            <i class="fas fa-ban"></i> Negar Acesso
                        </button>
                    <% } %>
                </div>
                <div class="info-item">
                    <span class="info-label">Acesso ao Ranking:</span>
                    <% if (usuario.isPermissaoRank_user()) { %>
                        <span class="status-badge status-active">Aprovado</span>
                    <% } else { %>
                        <span class="status-badge status-pending">Pendente</span>
                    <% } %>
                </div>
                <div class="info-item">
                    <span class="info-label">Possui Bicicleta:</span>
                    <% if (usuario.isPossuiBike_user()) { %>
                        <span class="status-badge status-active">Sim</span>
                    <% } else { %>
                        <span class="status-badge status-inactive">Não</span>
                    <% } %>
                </div>
            </div>
            <% } %>

            <% if (isAdmin) { %>
            <!-- Informações Adicionais -->
            <div class="info-card">
                <h3>
                    <i class="fas fa-info-circle"></i>
                    Informações Adicionais
                </h3>

                <div class="info-item">
                    <span class="info-label">Comprovante de Bicicleta:</span>
                    <% if (usuario.getFotoComprBike_user() != null && !usuario.getFotoComprBike_user().trim().isEmpty()) { %>
                        <span class="status-badge status-active">Enviado</span>
                    <% } else { %>
                        <span class="status-badge status-inactive">Não Enviado</span>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>

        <!-- Seção de Feedbacks Recebidos -->
        <%
            @SuppressWarnings("unchecked")
            List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("feedbacks");
        %>
        
        <div class="info-card">
            <h3 style="color: #17a2b8; margin-bottom: 1.5rem; font-size: 1.3rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-comments"></i>
                Feedbacks Recebidos
                <% if (feedbacks != null && !feedbacks.isEmpty()) { %>
                    <span style="background: #17a2b8; color: white; font-size: 0.8rem; padding: 0.2rem 0.5rem; border-radius: 15px; margin-left: 0.5rem;">
                        <%= feedbacks.size() %>
                    </span>
                <% } %>
            </h3>
            
            <% if (feedbacks == null || feedbacks.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-comment-slash empty-icon"></i>
                    <h4 style="margin-bottom: 0.5rem;">Nenhum feedback recebido</h4>
                    <p>Este usuário ainda não recebeu avaliações de outros usuários.</p>
                </div>
            <% } else { %>
                <div style="max-height: 400px; overflow-y: auto; padding-right: 0.5rem;">
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                        for (Feedback feedback : feedbacks) {
                    %>
                        <div style="background: #f8f9fa; border-radius: 10px; padding: 1.5rem; margin-bottom: 1rem; border-left: 4px solid #17a2b8;">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <i class="fas fa-user-circle" style="color: #6c757d; font-size: 1.2rem;"></i>
                                    <strong style="color: #333;">
                                        <%= feedback.getAvaliador_Usuario() != null ? feedback.getAvaliador_Usuario().getNomeRazaoSocial_user() : "Usuário não identificado" %>
                                    </strong>
                                </div>
                                <div style="display: flex; gap: 0.2rem;">
                                    <%
                                        int avaliacaoUser = feedback.getAvaliacaoUser_feedb();
                                        for (int i = 1; i <= 5; i++) {
                                            if (i <= avaliacaoUser) {
                                    %>
                                        <i class="fas fa-star" style="color: #ffc107; font-size: 1rem;"></i>
                                    <%  } else { %>
                                        <i class="fas fa-star" style="color: #dee2e6; font-size: 1rem;"></i>
                                    <%  } 
                                        } 
                                    %>
                                    <span style="margin-left: 0.5rem; color: #6c757d; font-weight: 500;">
                                        <%= avaliacaoUser %>/5
                                    </span>
                                </div>
                            </div>
                            
                            <% if (feedback.getObsUser_feedb() != null && !feedback.getObsUser_feedb().trim().isEmpty()) { %>
                                <p style="color: #6c757d; line-height: 1.6; margin-bottom: 1rem;">
                                    "<%= feedback.getObsUser_feedb() %>"
                                </p>
                            <% } else { %>
                                <p style="color: #adb5bd; font-style: italic; margin-bottom: 1rem;">
                                    Sem comentários adicionais.
                                </p>
                            <% } %>
                            
                            <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.9rem; color: #adb5bd;">
                                <div style="display: flex; gap: 1rem;">
                                    <% if (feedback.isComunicBoa_feedb()) { %>
                                        <span style="color: #28a745;">
                                            <i class="fas fa-check-circle"></i> Boa Comunicação
                                        </span>
                                    <% } %>
                                    <% if (feedback.isConfComp_feedb()) { %>
                                        <span style="color: #28a745;">
                                            <i class="fas fa-check-circle"></i> Confiável
                                        </span>
                                    <% } %>
                                </div>
                                <span>
                                    <i class="fas fa-calendar"></i>
                                    <%= feedback.getData_feedb() != null ? feedback.getData_feedb().format(formatter) : "Data não informada" %>
                                </span>
                            </div>
                        </div>
                    <% } %>
                </div>
                
                <div style="text-align: center; margin-top: 1rem; padding-top: 1rem; border-top: 1px solid #f8f9fa;">
                    <span style="color: #6c757d; font-size: 0.9rem;">
                        <i class="fas fa-info-circle"></i>
                        Mostrando todos os <%= feedbacks.size() %> feedback(s) recebido(s)
                    </span>
                </div>
            <% } %>
        </div>

        <!-- Seção de Observações sobre Bicicletas -->
        <%
            @SuppressWarnings("unchecked")
            List<Feedback> observacoesBicicletas = (List<Feedback>) request.getAttribute("observacoesBicicletas");
            int totalObservacoes = (observacoesBicicletas != null) ? observacoesBicicletas.size() : 0;
        %>
        
        <div class="info-card" style="margin-top: 2rem;">
            <h3 style="color: #17a2b8; margin-bottom: 1.5rem; font-size: 1.3rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="fas fa-bicycle"></i>
                Observações sobre como tratou as bicicletas
                <% if (observacoesBicicletas != null && !observacoesBicicletas.isEmpty()) { %>
                    <span style="background: #17a2b8; color: white; font-size: 0.8rem; padding: 0.2rem 0.5rem; border-radius: 15px; margin-left: 0.5rem;">
                        <%= totalObservacoes %>
                    </span>
                <% } %>
            </h3>
            
            <% if (observacoesBicicletas == null || observacoesBicicletas.isEmpty()) { %>
                <div class="empty-state">
                    <i class="fas fa-bicycle empty-icon"></i>
                    <h4 style="margin-bottom: 0.5rem;">Nenhuma observação sobre bicicletas</h4>
                    <p>Ainda não há observações dos locadores sobre como este usuário tratou as bicicletas alugadas.</p>
                </div>
            <% } else { %>
                <div style="max-height: 400px; overflow-y: auto; padding-right: 0.5rem;">
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                        for (Feedback observacao : observacoesBicicletas) {
                    %>
                        <div style="background: #f8f9fa; border-radius: 10px; padding: 1.5rem; margin-bottom: 1rem; border-left: 4px solid #17a2b8;">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <i class="fas fa-user-circle" style="color: #6c757d; font-size: 1.2rem;"></i>
                                    <strong style="color: #333;">
                                        <%= observacao.getAvaliador_Usuario() != null ? observacao.getAvaliador_Usuario().getNomeRazaoSocial_user() : "Locador" %>
                                    </strong>
                                </div>
                                <div style="color: #6c757d; font-size: 0.9rem;">
                                    <i class="fas fa-bicycle"></i>
                                    <%= observacao.getReserva() != null && observacao.getReserva().getBicicleta() != null ? 
                                        observacao.getReserva().getBicicleta().getNome_bike() : "Bicicleta não identificada" %>
                                </div>
                            </div>
                            
                            <% if (observacao.getObsBike_feedb() != null && !observacao.getObsBike_feedb().trim().isEmpty()) { %>
                                <p style="color: #6c757d; line-height: 1.6; margin-bottom: 1rem;">
                                    "<%= observacao.getObsBike_feedb() %>"
                                </p>
                            <% } else { %>
                                <p style="color: #adb5bd; font-style: italic; margin-bottom: 1rem;">
                                    Sem observações adicionais.
                                </p>
                            <% } %>
                            
                            <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.9rem; color: #adb5bd;">
                                <div style="display: flex; gap: 1rem;">
                                    <% if (observacao.isFuncional_feedb()) { %>
                                        <span style="color: #28a745;">
                                            <i class="fas fa-check-circle"></i> Funcional
                                        </span>
                                    <% } %>
                                    <% if (observacao.isManutencao_feedb()) { %>
                                        <span style="color: #28a745;">
                                            <i class="fas fa-tools"></i> Boa Manutenção
                                        </span>
                                    <% } %>
                                </div>
                                <span>
                                    <i class="fas fa-calendar"></i>
                                    <%= observacao.getData_feedb() != null ? observacao.getData_feedb().format(formatter) : "Data não informada" %>
                                </span>
                            </div>
                        </div>
                    <% } %>
                </div>
                
                <div style="text-align: center; margin-top: 1rem; padding-top: 1rem; border-top: 1px solid #f8f9fa;">
                    <span style="color: #6c757d; font-size: 0.9rem;">
                        <i class="fas fa-info-circle"></i>
                        Mostrando todas as <%= totalObservacoes %> observação(ões) sobre bicicletas
                    </span>
                </div>
            <% } %>
        </div>
    </div>

    <script>
        function negarAcesso(cpfCnpj) {
            if (confirm('Tem certeza que deseja NEGAR o acesso deste usuário à plataforma?\n\nEsta ação irá revogar as permissões do usuário.')) {
                // Criar formulário para enviar requisição POST
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath() %>/UsuarioController';
                
                // Campo action
                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'revogar-acesso-usuario';
                form.appendChild(actionInput);
                
                // Campo cpfCnpj
                var cpfCnpjInput = document.createElement('input');
                cpfCnpjInput.type = 'hidden';
                cpfCnpjInput.name = 'cpfCnpj';
                cpfCnpjInput.value = cpfCnpj;
                form.appendChild(cpfCnpjInput);
                
                // Adicionar origem se disponível
                <% if (origem != null && !origem.trim().isEmpty()) { %>
                var origemInput = document.createElement('input');
                origemInput.type = 'hidden';
                origemInput.name = 'origem';
                origemInput.value = '<%= origem %>';
                form.appendChild(origemInput);
                <% } %>
                
                // Adicionar bicicletaId se disponível
                <% if (bicicletaId != null && !bicicletaId.trim().isEmpty()) { %>
                var bicicletaIdInput = document.createElement('input');
                bicicletaIdInput.type = 'hidden';
                bicicletaIdInput.name = 'bicicletaId';
                bicicletaIdInput.value = '<%= bicicletaId %>';
                form.appendChild(bicicletaIdInput);
                <% } %>
                
                // Adicionar formulário ao body e submeter
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
