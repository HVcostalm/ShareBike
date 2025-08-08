<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
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
            border: 4px solid #667eea;
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
            background: linear-gradient(135deg, #667eea, #764ba2);
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
            <p>Edite as informações do usuário: Maria Silva Santos</p>
        </div>
        
        <!-- Formulário de Edição -->
        <form action="../UsuarioController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="editar">
            <input type="hidden" name="cpfCnpj" value="12345678901">
            
            <div class="form-container">
                <!-- Status do Usuário -->
                <div class="status-indicator status-active">
                    <i class="fas fa-check-circle"></i>
                    Usuário Ativo
                </div>
                
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i>
                    <span>Use este formulário para editar as informações do usuário. Campos obrigatórios estão marcados com *</span>
                </div>
                
                <!-- Foto do Perfil -->
                <div class="profile-image">
                    <img src="../assets/images/user-placeholder.jpg" alt="Foto atual" class="current-image">
                    <div class="image-upload">
                        <input type="file" id="foto" name="foto" class="file-input" accept="image/*">
                        <label for="foto" class="file-label">
                            <i class="fas fa-camera"></i>
                            Alterar Foto
                        </label>
                        <small>Formatos aceitos: JPG, PNG, GIF (máx. 2MB)</small>
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
                                   value="Maria Silva Santos" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="cpfCnpj">
                                <i class="fas fa-id-card"></i>
                                CPF/CNPJ *
                            </label>
                            <input type="text" id="cpfCnpj" name="cpfCnpjDisplay" 
                                   value="123.456.789-01" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">
                                <i class="fas fa-envelope"></i>
                                Email *
                            </label>
                            <input type="email" id="email" name="email" 
                                   value="maria.silva@email.com" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="telefone">
                                <i class="fas fa-phone"></i>
                                Telefone
                            </label>
                            <input type="tel" id="telefone" name="telefone" 
                                   value="(11) 99999-9999">
                        </div>
                        
                        <div class="form-group">
                            <label for="dataNascimento">
                                <i class="fas fa-calendar-alt"></i>
                                Data de Nascimento
                            </label>
                            <input type="date" id="dataNascimento" name="dataNascimento" 
                                   value="1990-05-15">
                        </div>
                        
                        <div class="form-group">
                            <label for="tipoUsuario">
                                <i class="fas fa-user-tag"></i>
                                Tipo de Usuário *
                            </label>
                            <select id="tipoUsuario" name="tipoUsuario" required>
                                <option value="locador" selected>Locador</option>
                                <option value="locatario">Locatário</option>
                                <option value="ambos">Ambos</option>
                            </select>
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
                            <label for="cep">
                                <i class="fas fa-mail-bulk"></i>
                                CEP
                            </label>
                            <input type="text" id="cep" name="cep" 
                                   value="01234-567" onblur="buscarCEP()">
                        </div>
                        
                        <div class="form-group">
                            <label for="logradouro">
                                <i class="fas fa-road"></i>
                                Logradouro
                            </label>
                            <input type="text" id="logradouro" name="logradouro" 
                                   value="Rua das Flores">
                        </div>
                        
                        <div class="form-group">
                            <label for="numero">
                                <i class="fas fa-hashtag"></i>
                                Número
                            </label>
                            <input type="text" id="numero" name="numero" 
                                   value="123">
                        </div>
                        
                        <div class="form-group">
                            <label for="complemento">
                                <i class="fas fa-plus-circle"></i>
                                Complemento
                            </label>
                            <input type="text" id="complemento" name="complemento" 
                                   value="Apto 45">
                        </div>
                        
                        <div class="form-group">
                            <label for="bairro">
                                <i class="fas fa-building"></i>
                                Bairro
                            </label>
                            <input type="text" id="bairro" name="bairro" 
                                   value="Centro">
                        </div>
                        
                        <div class="form-group">
                            <label for="cidade">
                                <i class="fas fa-city"></i>
                                Cidade
                            </label>
                            <input type="text" id="cidade" name="cidade" 
                                   value="São Paulo">
                        </div>
                        
                        <div class="form-group">
                            <label for="estado">
                                <i class="fas fa-flag"></i>
                                Estado
                            </label>
                            <select id="estado" name="estado">
                                <option value="SP" selected>São Paulo</option>
                                <option value="RJ">Rio de Janeiro</option>
                                <option value="MG">Minas Gerais</option>
                                <option value="RS">Rio Grande do Sul</option>
                                <option value="PR">Paraná</option>
                                <option value="SC">Santa Catarina</option>
                                <option value="BA">Bahia</option>
                                <option value="DF">Distrito Federal</option>
                                <!-- Outros estados -->
                            </select>
                        </div>
                    </div>
                </div>
                
                <!-- Configurações do Usuário -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-cogs"></i>
                        Configurações do Usuário
                    </h3>
                    
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="receberNotificacoes" name="receberNotificacoes" checked>
                            <label for="receberNotificacoes">
                                <i class="fas fa-bell"></i>
                                Receber Notificações por Email
                            </label>
                        </div>
                        
                        <div class="checkbox-item">
                            <input type="checkbox" id="perfilPublico" name="perfilPublico" checked>
                            <label for="perfilPublico">
                                <i class="fas fa-eye"></i>
                                Perfil Público (visível para outros usuários)
                            </label>
                        </div>
                    </div>
                    
                    <!-- Campos somente leitura -->
                    <div class="form-grid" style="margin-top: 1.5rem;">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-star"></i>
                                Avaliação do Usuário
                            </label>
                            <input type="text" value="4.8 estrelas" readonly style="background: #f8f9fa; color: #6c757d;">
                            <small>Este campo é calculado automaticamente pelo sistema</small>
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-bicycle"></i>
                                Possui Bicicleta
                            </label>
                            <input type="text" value="Sim" readonly style="background: #f8f9fa; color: #6c757d;">
                            <small>Definido automaticamente ao cadastrar bicicletas</small>
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-key"></i>
                                Permissão de Acesso
                            </label>
                            <input type="text" value="Ativo" readonly style="background: #f8f9fa; color: #6c757d;">
                            <small>Gerenciado pelo administrador do sistema</small>
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-trophy"></i>
                                Permissão Ranking
                            </label>
                            <input type="text" value="Habilitado" readonly style="background: #f8f9fa; color: #6c757d;">
                            <small>Configurado automaticamente pelo sistema</small>
                        </div>
                    </div>
                </div>
                
                <!-- Observações Administrativas -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-sticky-note"></i>
                        Observações Administrativas
                    </h3>
                    
                    <div class="form-group full-width">
                        <label for="observacoes">
                            <i class="fas fa-comment-alt"></i>
                            Observações Internas
                        </label>
                        <textarea id="observacoes" name="observacoes" 
                                  placeholder="Adicione observações internas sobre este usuário...">Usuário ativo desde janeiro de 2025. Excelente histórico de reservas.</textarea>
                    </div>
                </div>
            </div>
            
            <!-- Botões de Ação -->
            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i>
                    Salvar Alterações
                </button>
                
                <a href="<%=request.getContextPath()%>/pages/Perfil.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Voltar ao Perfil
                </a>
                
                <button type="button" class="btn btn-danger" onclick="confirmarExclusao()">
                    <i class="fas fa-trash-alt"></i>
                    Excluir Usuário
                </button>
            </div>
        </form>
    </div>

    <script>
        function buscarCEP() {
            const cep = document.getElementById('cep').value.replace(/\D/g, '');
            
            if (cep.length === 8) {
                console.log('Buscando CEP:', cep);
                // Simulação de preenchimento automático
                document.getElementById('logradouro').value = 'Rua Exemplo';
                document.getElementById('bairro').value = 'Centro';
                document.getElementById('cidade').value = 'São Paulo';
                document.getElementById('estado').value = 'SP';
            }
        }
        
        function confirmarExclusao() {
            if (confirm('Tem certeza que deseja excluir este usuário?\n\nEsta ação não pode ser desfeita e todos os dados do usuário serão permanentemente removidos.')) {
                alert('Usuário excluído com sucesso!');
                window.location.href = '<%=request.getContextPath()%>/pages/Perfil.jsp';
            }
        }
        
        // Preview da imagem
        document.getElementById('foto').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.querySelector('.current-image').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
        
        // Formatação de CPF/CNPJ e telefone
        document.getElementById('telefone').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length <= 11) {
                value = value.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
            }
            e.target.value = value;
        });
        
        console.log('Página de edição de usuário carregada');
    </script>
</body>
</html>