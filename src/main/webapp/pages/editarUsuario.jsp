<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="java.util.List" %>

<%!
    // Funções auxiliares (declarações de métodos)
    String formatarCpfCnpj(String cpfCnpj) {
        if (cpfCnpj == null || cpfCnpj.trim().isEmpty()) {
            return "";
        }
        String digits = cpfCnpj.replaceAll("\\D", "");
        if (digits.length() == 11) {
            return digits.replaceAll("(\\d{3})(\\d{3})(\\d{3})(\\d{2})", "$1.$2.$3-$4");
        } else if (digits.length() == 14) {
            return digits.replaceAll("(\\d{2})(\\d{3})(\\d{3})(\\d{4})(\\d{2})", "$1.$2.$3/$4-$5");
        }
        return cpfCnpj;
    }
    
    String formatarTelefone(String telefone) {
        if (telefone == null || telefone.trim().isEmpty()) {
            return "";
        }
        String digits = telefone.replaceAll("\\D", "");
        if (digits.length() == 11) {
            return digits.replaceAll("(\\d{2})(\\d{5})(\\d{4})", "($1) $2-$3");
        } else if (digits.length() == 10) {
            return digits.replaceAll("(\\d{2})(\\d{4})(\\d{4})", "($1) $2-$3");
        }
        return telefone;
    }
    
    String obterStatusUsuario(Usuario user) {
        if (user.isPermissaoAcesso_user()) {
            return "Ativo";
        } else {
            return "Inativo";
        }
    }
    
    String obterStatusCor(Usuario user) {
        if (user.isPermissaoAcesso_user()) {
            return "status-active";
        } else {
            return "status-inactive";
        }
    }
    
    String obterStatusIcon(Usuario user) {
        if (user.isPermissaoAcesso_user()) {
            return "fas fa-check-circle";
        } else {
            return "fas fa-times-circle";
        }
    }
    
    String obterPermissaoTexto(boolean permissao) {
        if (permissao) {
            return "Habilitado";
        } else {
            return "Desabilitado";
        }
    }
    
    String obterPossuiBikeTexto(boolean possuiBike) {
        if (possuiBike) {
            return "Sim";
        } else {
            return "Não";
        }
    }
%>

<%
    // Verificar se o usuário está logado
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    Usuario admLogado = (Usuario) session.getAttribute("admLogado");
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    
    if (usuario == null && usuarioLogado != null) {
        usuario = usuarioLogado;
    } else if (usuario == null && admLogado != null) {
        usuario = admLogado;
    }
    
    if (usuario == null) {
        response.sendRedirect("loginUsuario.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Usuário - ShareBike</title>
    <link rel="stylesheet" href="../assets/css/usuarioDetalhes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            background: #f8f9fa;
            min-height: 100vh;
        }
        
        .edit-header {
            background: linear-gradient(135deg, #008080 0%, #006666 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .edit-title {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .form-container {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .form-section {
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .form-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
        
        .section-title {
            font-size: 1.3rem;
            color: #333;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #008080;
            box-shadow: 0 0 0 3px rgba(0, 128, 128, 0.1);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .checkbox-group {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .checkbox-item:hover {
            background: #e9ecef;
        }
        
        .checkbox-item input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }
        
        .checkbox-item label {
            cursor: pointer;
            font-weight: 500;
            margin: 0;
        }
        
        .profile-image {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .current-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid #008080;
            margin-bottom: 1rem;
        }
        
        .image-upload {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
        }
        
        .file-input {
            display: none;
        }
        
        .file-label {
            background: linear-gradient(135deg, #008080, #006666);
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .file-label:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
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
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }
        
        .status-indicator {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.2rem;
            border-radius: 8px;
            font-weight: 500;
            margin-bottom: 1rem;
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
        
        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="edit-header">
            <h1 class="edit-title">
                <i class="fas fa-user-edit"></i> 
                Editar Usuário
            </h1>
            <p>Edite as informações do usuário: <%= usuario.getNomeRazaoSocial_user() != null ? usuario.getNomeRazaoSocial_user() : "Usuário sem nome" %></p>
        </div>
        
        <!-- Formulário de Edição -->
        <form action="<%=request.getContextPath()%>/UsuarioController?action=editar" method="post">
            <input type="hidden" name="cpfCnpj" value="<%= usuario.getCpfCnpj_user() %>">
            <input type="hidden" name="avaliacao" value="<%= usuario.getAvaliacao_user() != null ? usuario.getAvaliacao_user() : 0 %>">
            <input type="hidden" name="permissaoAcesso" value="<%= usuario.isPermissaoAcesso_user() %>">
            <input type="hidden" name="permissaoRank" value="<%= usuario.isPermissaoRank_user() %>">
            <input type="hidden" name="possuiBike" value="<%= usuario.isPossuiBike_user() %>">
            
            <div class="form-container">
                <!-- Status do Usuário -->
                <div class="status-indicator <%= obterStatusCor(usuario) %>">
                    <i class="<%= obterStatusIcon(usuario) %>"></i>
                    Usuário <%= obterStatusUsuario(usuario) %>
                </div>
                
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i>
                    <span>Use este formulário para editar as informações do usuário. Campos obrigatórios estão marcados com *</span>
                </div>
                
                <!-- Foto do Perfil -->
                <div class="profile-image">
                    <%
                        String foto = usuario.getFoto_user();
                        if (foto != null && !foto.trim().isEmpty() && !foto.equals("null")) {
                    %>
                        <img src="../assets/images/<%= foto %>" alt="<%= foto %>" class="current-image">
                    <%
                        } else {
                            // Gerar iniciais do nome
                            String nome = usuario.getNomeRazaoSocial_user();
                            String iniciais = "";
                            if (nome != null && !nome.trim().isEmpty()) {
                                String[] palavras = nome.trim().split("\\s+");
                                if (palavras.length >= 2) {
                                    iniciais = String.valueOf(palavras[0].charAt(0)).toUpperCase() + 
                                              String.valueOf(palavras[palavras.length-1].charAt(0)).toUpperCase();
                                } else if (palavras.length == 1) {
                                    iniciais = String.valueOf(palavras[0].charAt(0)).toUpperCase();
                                    if (palavras[0].length() > 1) {
                                        iniciais += String.valueOf(palavras[0].charAt(1)).toUpperCase();
                                    }
                                }
                            } else {
                                iniciais = "U";
                            }
                    %>
                        <div class="current-image" style="display: flex; align-items: center; justify-content: center; background: linear-gradient(135deg, #008080, #006666); color: white; font-size: 2rem; font-weight: bold;">
                            <%= iniciais %>
                        </div>
                    <%
                        }
                    %>
                    <div class="form-group" style="margin-top: 1rem;">
                        <label for="foto">
                            <i class="fas fa-image"></i>
                            URL da Foto
                        </label>
                        <input type="text" id="foto" name="foto" 
                               value="<%= usuario.getFoto_user() != null ? usuario.getFoto_user() : "" %>"
                               placeholder="Ex: foto_perfil.jpg">
                        <small>Digite o nome do arquivo da foto </small>
                    </div>
                </div>
                
                <!-- Informações Pessoais -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-user"></i>
                        Informações Pessoais
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="nomeRazaoSocial">
                                <i class="fas fa-signature"></i>
                                Nome/Razão Social *
                            </label>
                            <input type="text" id="nomeRazaoSocial" name="nomeRazaoSocial" 
                                   value="<%= usuario.getNomeRazaoSocial_user() != null ? usuario.getNomeRazaoSocial_user() : "" %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="cpfCnpj">
                                <i class="fas fa-id-card"></i>
                                CPF/CNPJ *
                            </label>
                            <input type="text" id="cpfCnpj" name="cpfCnpjDisplay" 
                                   value="<%= formatarCpfCnpj(usuario.getCpfCnpj_user()) %>" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">
                                <i class="fas fa-envelope"></i>
                                Email *
                            </label>
                            <input type="email" id="email" name="email" 
                                   value="<%= usuario.getEmail_user() != null ? usuario.getEmail_user() : "" %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="telefone">
                                <i class="fas fa-phone"></i>
                                Telefone
                            </label>
                            <input type="tel" id="telefone" name="telefone" 
                                   value="<%= usuario.getTelefone_user() != null ? usuario.getTelefone_user() : "" %>">
                        </div>
                        
                        <div class="form-group" style="grid-column: 1 / -1;">
                            <label for="senha">
                                <i class="fas fa-key"></i>
                                Nova Senha
                            </label>
                            <input type="password" id="senha" name="senha" 
                                   placeholder="Deixe em branco para manter a senha atual">
                        </div>
                    </div>
                </div>
                
                <!-- Endereço -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-map-marker-alt"></i>
                        Endereço
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="cidade">
                                <i class="fas fa-city"></i>
                                Cidade
                            </label>
                            <input type="text" id="cidade" name="cidade" 
                                   value="<%= usuario.getCidade_user() != null ? usuario.getCidade_user() : "" %>">
                        </div>
                        
                        <div class="form-group">
                            <label for="estado">
                                <i class="fas fa-flag"></i>
                                Estado
                            </label>
                            <input type="text" id="estado" name="estado" 
                                   value="<%= usuario.getEstado_user() != null ? usuario.getEstado_user() : "" %>">
                        </div>
                        
                        <div class="form-group">
                            <label for="pais">
                                <i class="fas fa-globe"></i>
                                País
                            </label>
                            <input type="text" id="pais" name="pais" 
                                   value="<%= usuario.getPais_user() != null ? usuario.getPais_user() : "" %>">
                        </div>
                    </div>
                </div>
                
                <!-- Comprovação de Bicicleta Própria -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-bicycle"></i>
                        Comprovação de Bicicleta Própria
                    </h3>
                    
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        <span>Você pode informar uma foto para comprovar que possui bicicleta própria. A validação final será feita pelo administrador.</span>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group full-width">
                            <label for="fotoComprBike">
                                <i class="fas fa-camera"></i>
                                Foto de Comprovação da Bicicleta
                            </label>
                            <input type="text" id="fotoComprBike" name="fotoComprBike" 
                                   value="<%= usuario.getFotoComprBike_user() != null ? usuario.getFotoComprBike_user() : "" %>"
                                   placeholder="Ex: minha_bicicleta.jpg">
                            <small>Digite o nome do arquivo da foto da sua bicicleta como comprovação</small>
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-info-circle"></i>
                                Status Atual
                            </label>
                            <input type="text" value="<%= obterPossuiBikeTexto(usuario.isPossuiBike_user()) %>" readonly style="background: #f8f9fa; color: #6c757d;">
                            <small>Este status é validado pelo administrador após análise da comprovação</small>
                        </div>
                    </div>
                </div>
                
                <!-- Informações do Sistema -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-cogs"></i>
                        Informações do Sistema
                    </h3>
                    
                    <!-- Campos somente leitura -->
                    <div class="form-grid" style="margin-top: 1.5rem;">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-star"></i>
                                Avaliação do Usuário
                            </label>
                            <input type="text" value="<%= usuario.getAvaliacao_user() != null && usuario.getAvaliacao_user() != 0 ? usuario.getAvaliacao_user() + " estrelas" : "Sem avaliação" %>" readonly style="background: #f8f9fa; color: #6c757d;">
                            <small>Este campo é calculado automaticamente pelo sistema</small>
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-key"></i>
                                Permissão de Acesso
                            </label>
                            <input type="text" value="<%= obterPermissaoTexto(usuario.isPermissaoAcesso_user()) %>" readonly style="background: #f8f9fa; color: #6c757d;">
                            <small>Gerenciado pelo administrador do sistema</small>
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-trophy"></i>
                                Permissão Ranking
                            </label>
                            <input type="text" value="<%= obterPermissaoTexto(usuario.isPermissaoRank_user()) %>" readonly style="background: #f8f9fa; color: #6c757d;">
                            <small>Configurado automaticamente pelo sistema</small>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Botões de Ação -->
            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i>
                    Salvar Alterações
                </button>
                
                <a href="<%=request.getContextPath()%>/UsuarioController?action=perfil" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Voltar ao Perfil
                </a>
            </div>
        </form>
    </div>

    <script>
        // Formatação de telefone apenas visual
        document.getElementById('telefone').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length <= 11) {
                if (value.length === 11) {
                    e.target.style.display = value.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
                } else if (value.length === 10) {
                    e.target.style.display = value.replace(/(\d{2})(\d{4})(\d{4})/, '($1) $2-$3');
                }
            }
            // Manter apenas números no value
            e.target.value = value;
        });
        
        // Antes de enviar o formulário, garantir que dados sejam limpos
        document.querySelector('form').addEventListener('submit', function() {
            const telefoneInput = document.getElementById('telefone');
            telefoneInput.value = telefoneInput.value.replace(/\D/g, '');
        });
        
        console.log('Página de edição de usuário carregada');
    </script>
</body>
</html>
