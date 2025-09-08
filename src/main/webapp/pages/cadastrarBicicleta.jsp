<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Usuario" %>

<%
// Verificar se o usuário está logado
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
if (usuarioLogado == null) {
    response.sendRedirect("loginUsuario.jsp");
    return;
}

// Verificar se há mensagem de erro
String mensagemErro = (String) session.getAttribute("mensagemErro");
if (mensagemErro != null) {
    session.removeAttribute("mensagemErro"); // Remove a mensagem após exibir
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Nova Bicicleta - ShareBike</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/usuarioDetalhes.css">
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
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .header-title {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .back-link {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .back-link:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-1px);
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
            border-color: #28a745;
            box-shadow: 0 0 0 3px rgba(40, 167, 69, 0.1);
        }

        .form-group.full-width {
            grid-column: 1 / -1;
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

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
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

        small {
            color: #666;
            font-size: 0.9em;
            margin-top: 0.5rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .header {
                padding: 1.5rem;
            }
            
            .header-title {
                font-size: 2rem;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <% if (mensagemErro != null) { %>
            <div class="alert alert-danger" style="background-color: #f8d7da; color: #721c24; padding: 1rem; margin-bottom: 1rem; border: 1px solid #f5c6cb; border-radius: 5px;">
                <i class="fas fa-exclamation-triangle"></i> <%= mensagemErro %>
            </div>
        <% } %>
        
        <!-- Header -->
        <div class="header">
            <a href="<%=request.getContextPath()%>/BicicletaController?action=minhas-bikes&cpfCnpj=<%= usuarioLogado.getCpfCnpj_user() %>" class="back-link">
                <i class="fas fa-arrow-left"></i> Voltar às Minhas Bicicletas
            </a>
            
            <h1 class="header-title">
                <i class="fas fa-plus-circle"></i> 
                Cadastrar Nova Bicicleta
            </h1>
            <p>Adicione uma nova bicicleta ao seu inventário para começar a alugar</p>
        </div>

        <!-- Formulário de Cadastro -->
        <form action="<%=request.getContextPath()%>/BicicletaController" method="post" accept-charset="UTF-8"
              enctype="application/x-www-form-urlencoded"
              onsubmit="return validarFormulario();"
              style="margin-top: 1rem;"
              id="cadastroForm"
              name="cadastroForm">
            <input type="hidden" name="action" value="adicionar">
            <input type="hidden" name="cpfCnpj" value="<%= usuarioLogado.getCpfCnpj_user() %>">
            
            <!-- Informações da Bicicleta -->
            <div class="form-container">
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-info-circle"></i>
                        Informações da Bicicleta
                    </h3>
                    
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        <span>Preencha as informações básicas da sua bicicleta. Campos com * são obrigatórios.</span>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="nome">
                                <i class="fas fa-bicycle"></i>
                                Nome da Bicicleta *
                            </label>
                            <input type="text" id="nome" name="nome" required
                                   placeholder="Ex: Trek Mountain Pro 2024 Aro 23">
                            <small>Digite um nome identificador para sua bicicleta</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="tipo">
                                <i class="fas fa-list"></i>
                                Tipo de Bicicleta *
                            </label>
                            <select id="tipo" name="tipo" required>
                                <option value="">Selecione o tipo</option>
                                <option value="Urbana">Urbana</option>
                                <option value="Passeio">Passeio</option>
                                <option value="Dobravel">Dobrável</option>
                                <option value="Mountain">Mountain</option>
                                <option value="BMX">BMX</option>
                                <option value="Speed">Speed</option>
                            </select>
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="localEntr">
                                <i class="fas fa-map-marker-alt"></i>
                                Local de Entrega *
                            </label>
                            <input type="text" id="localEntr" name="localEntr" required
                                   placeholder="Ex: Rua das Flores, 123 - Centro, São Paulo - SP">
                            <small>Endereço onde o locatário poderá retirar a bicicleta</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="chassi">
                                <i class="fas fa-barcode"></i>
                                Número do Chassi *
                            </label>
                            <input type="text" id="chassi" name="chassi" required maxlength="10"
                                   placeholder="Ex: ABC1234567 (máx. 10 caracteres)">
                            <small>Número de série ou chassi da bicicleta (máximo 10 caracteres)</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="estadoConserv">
                                <i class="fas fa-cogs"></i>
                                Estado de Conservação *
                            </label>
                            <select id="estadoConserv" name="estadoConserv" required>
                                <option value="">Selecione o estado</option>
                                <option value="BOM">BOM</option>
                                <option value="OTIMA">ÓTIMA</option>
                                <option value="EXCELENTE">EXCELENTE</option>
                            </select>
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="foto">
                                <i class="fas fa-camera"></i>
                                Foto da Bicicleta
                            </label>
                            <input type="text" id="foto" name="foto"
                                   placeholder="Ex: minha-bike-001.jpg ou https://exemplo.com/foto.jpg">
                            <small>Nome do arquivo de imagem (ex: bike1.jpg) ou URL da imagem. Deixe em branco para usar imagem padrão.</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Botões de Ação -->
            <div class="action-buttons">
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-save"></i>
                    Cadastrar Bicicleta
                </button>
                
                <a href="<%=request.getContextPath()%>/BicicletaController?action=minhas-bikes&cpfCnpj=<%= usuarioLogado.getCpfCnpj_user() %>" class="btn btn-secondary">
                    <i class="fas fa-times"></i>
                    Cancelar
                </a>
            </div>
        </form>
    </div>

    <script>
        // Função para atualizar contador do chassi
        function atualizarContadorChassi() {
            try {
                console.log('Tentando atualizar contador do chassi...');
                
                const chassiInput = document.getElementById('chassi');
                if (!chassiInput) {
                    console.error('Campo chassi não encontrado!');
                    return;
                }
                
                console.log('Campo chassi encontrado:', chassiInput);
                
                // Tentar encontrar o elemento small de diferentes formas
                let small = chassiInput.parentElement.querySelector('small');
                
                if (!small) {
                    // Buscar o próximo elemento small
                    small = chassiInput.nextElementSibling;
                    while (small && small.tagName !== 'SMALL') {
                        small = small.nextElementSibling;
                    }
                }
                
                if (!small) {
                    console.error('Elemento small não encontrado! Criando um novo...');
                    // Criar um novo elemento small se não existir
                    small = document.createElement('small');
                    small.className = 'form-text text-muted';
                    chassiInput.parentElement.appendChild(small);
                }
                
                console.log('Elemento small:', small);
                
                const contador = chassiInput.value.length;
                console.log('Contador atual:', contador);
                
                if (contador == 10) {
                    chassiInput.value = chassiInput.value.substring(0, 10);
                    small.style.color = '#dc3545';
                    small.style.fontWeight = 'bold';
                    small.textContent = '🚫 LIMITE ATINGIDO! (10/10 caracteres)';
                } else if (contador >= 8 && contador <= 9) {
                    small.style.color = '#ffc107';
                    small.style.fontWeight = 'bold';
                    small.textContent = '⚠️ Chassi: ' + contador + '/10 caracteres (quase no limite)';
                } else if (contador >= 1) {
                    small.style.color = '#28a745';
                    small.style.fontWeight = 'normal';
                    small.textContent = '✓ Chassi: ' + contador + '/10 caracteres';
                } else {
                    small.style.color = '#6c757d';
                    small.style.fontWeight = 'normal';
                    small.textContent = 'Número de série ou chassi da bicicleta (0/10 caracteres)';
                }
                
                console.log('Contador atualizado com sucesso!');
                
            } catch (error) {
                console.error('Erro ao atualizar contador:', error);
            }
        }
        
        // Validação do formulário
        function validarFormulario() {
            // Garantir que o encoding está correto antes do envio
            const form = document.getElementById('cadastroForm');
            if (form) {
                form.acceptCharset = 'UTF-8';
            }
            
            const campos = ['nome', 'tipo', 'localEntr', 'chassi', 'estadoConserv'];
            let camposVazios = [];
            
            campos.forEach(campo => {
                const elemento = document.getElementById(campo);
                if (!elemento.value.trim()) {
                    const label = elemento.parentElement.querySelector('label').textContent.replace('*', '').trim();
                    camposVazios.push(label);
                }
            });
            
            if (camposVazios.length > 0) {
                alert('Por favor, preencha os seguintes campos obrigatórios:\n\n' + camposVazios.join('\n'));
                return false;
            }
            // Validar chassi (deve ter pelo menos 3 caracteres e máximo 10)
            const chassi = document.getElementById('chassi').value.trim();
            if (chassi.length < 3) {
                alert('O número do chassi deve ter pelo menos 3 caracteres.');
                document.getElementById('chassi').focus();
                return false;
            }
            
            if (chassi.length > 10) {
                alert('O número do chassi não pode ultrapassar 10 caracteres.');
                document.getElementById('chassi').focus();
                return false;
            }
            
            // Confirmar cadastro
            if (confirm('Confirmar o cadastro da bicicleta?')) {
                // Enviar formulário
                return true;
            } else {
                return false;
            }
        }
        
        // Inicializar eventos quando a página carregar
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM carregado, configurando eventos...');
            
            // Remover mensagem de erro após 7 segundos
            const alertError = document.querySelector('.alert-danger');
            if (alertError) {
                setTimeout(function() {
                    alertError.style.transition = 'opacity 0.5s ease-out';
                    alertError.style.opacity = '0';
                    setTimeout(function() {
                        alertError.remove();
                    }, 500);
                }, 7000);
            }
            
            const chassiInput = document.getElementById('chassi');
            if (chassiInput) {
                console.log('Campo chassi encontrado, adicionando eventos...');
                
                // Converter chassi para maiúsculo e controlar tamanho
                chassiInput.addEventListener('input', function() {
                    console.log('Evento input disparado');
                    this.value = this.value.toUpperCase();
                    atualizarContadorChassi();
                });
                
                // Também escutar evento 'keyup' como backup
                chassiInput.addEventListener('keyup', function() {
                    console.log('Evento keyup disparado');
                    this.value = this.value.toUpperCase();
                    atualizarContadorChassi();
                });
                
                // Inicializar contador
                atualizarContadorChassi();
                
            } else {
                console.error('Campo chassi não encontrado no DOM!');
            }
        });
        
        // Backup com window.load
        window.addEventListener('load', function() {
            console.log('Window carregada, configurando backup...');
            setTimeout(function() {
                const chassiInput = document.getElementById('chassi');
                if (chassiInput) {
                    atualizarContadorChassi();
                }
            }, 500);
        });
        
        console.log('Página de cadastro de bicicleta carregada');
        console.log('Usuário logado: <%= usuarioLogado.getNomeRazaoSocial_user() %>');
    </script>
</body>
</html>
