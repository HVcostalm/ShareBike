<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Usuários Aguardando Aprovação</title>
    <link rel="stylesheet" href="../assets/css/gestaoUsuario.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .user-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            margin: 10px 0;
            padding: 15px;
            background-color: #f9f9f9;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .user-card:hover {
            background-color: #e9e9e9;
        }
        .user-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-details {
            flex: 1;
        }
        .user-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
        .user-email {
            color: #666;
            margin-top: 5px;
        }
        .status-pending {
            background-color: #ffeaa7;
            color: #2d3436;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
        }
        .no-users {
            text-align: center;
            color: #666;
            font-style: italic;
            margin: 50px 0;
        }
        .back-button {
            background-color: #6c5ce7;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-bottom: 20px;
        }
        .back-button:hover {
            background-color: #5f3dc4;
        }
        .user-type {
            font-size: 12px;
            background-color: #74b9ff;
            color: white;
            padding: 2px 8px;
            border-radius: 10px;
            margin-top: 5px;
            display: inline-block;
        }
        .company-type {
            background-color: #00b894;
        }
        .registration-date {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }
        .user-count {
            background-color: #ddd;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="<%=request.getContextPath()%>/pages/gestaoUsuario.jsp" class="back-button">← Voltar para Gestão</a>
        
        <h1>Usuários Aguardando Aprovação de Acesso</h1>
        
        <div class="user-count">
            📋 <strong>5 usuários</strong> aguardando aprovação de acesso ao sistema
        </div>
        
        <!-- Dados estáticos para demonstração -->
        <div class="user-list">
            <div class="user-card" onclick="redirecionarParaPerfil('123.456.789-10')">
                <div class="user-info">
                    <div class="user-details">
                        <div class="user-name">Ana Carolina Ferreira</div>
                        <div class="user-email">ana.ferreira@email.com</div>
                        <div><strong>CPF/CNPJ:</strong> 123.456.789-10</div>
                        <div><strong>Cidade:</strong> São Paulo - SP</div>
                        <div class="registration-date"><strong>Data do Cadastro:</strong> 15/07/2025</div>
                        <span class="user-type">Pessoa Física</span>
                    </div>
                    <div class="status-pending">Aguardando Aprovação</div>
                </div>
            </div>
            
            <div class="user-card" onclick="redirecionarParaPerfil('987.654.321-00')">
                <div class="user-info">
                    <div class="user-details">
                        <div class="user-name">Ricardo Santos Lima</div>
                        <div class="user-email">ricardo.lima@email.com</div>
                        <div><strong>CPF/CNPJ:</strong> 987.654.321-00</div>
                        <div><strong>Cidade:</strong> Rio de Janeiro - RJ</div>
                        <div class="registration-date"><strong>Data do Cadastro:</strong> 20/07/2025</div>
                        <span class="user-type">Pessoa Física</span>
                    </div>
                    <div class="status-pending">Aguardando Aprovação</div>
                </div>
            </div>
            
            <div class="user-card" onclick="redirecionarParaPerfil('456.789.123-45')">
                <div class="user-info">
                    <div class="user-details">
                        <div class="user-name">Empresa BikeShare Ltda</div>
                        <div class="user-email">contato@bikeshare.com.br</div>
                        <div><strong>CPF/CNPJ:</strong> 12.345.678/0001-90</div>
                        <div><strong>Cidade:</strong> Belo Horizonte - MG</div>
                        <div class="registration-date"><strong>Data do Cadastro:</strong> 25/07/2025</div>
                        <span class="user-type company-type">Pessoa Jurídica</span>
                    </div>
                    <div class="status-pending">Aguardando Aprovação</div>
                </div>
            </div>
            
            <div class="user-card" onclick="redirecionarParaPerfil('789.123.456-78')">
                <div class="user-info">
                    <div class="user-details">
                        <div class="user-name">Marina Oliveira Costa</div>
                        <div class="user-email">marina.costa@email.com</div>
                        <div><strong>CPF/CNPJ:</strong> 789.123.456-78</div>
                        <div><strong>Cidade:</strong> Brasília - DF</div>
                        <div class="registration-date"><strong>Data do Cadastro:</strong> 02/08/2025</div>
                        <span class="user-type">Pessoa Física</span>
                    </div>
                    <div class="status-pending">Aguardando Aprovação</div>
                </div>
            </div>
            
            <div class="user-card" onclick="redirecionarParaPerfil('321.654.987-12')">
                <div class="user-info">
                    <div class="user-details">
                        <div class="user-name">Carlos Eduardo Mendes</div>
                        <div class="user-email">carlos.mendes@email.com</div>
                        <div><strong>CPF/CNPJ:</strong> 321.654.987-12</div>
                        <div><strong>Cidade:</strong> Porto Alegre - RS</div>
                        <div class="registration-date"><strong>Data do Cadastro:</strong> 05/08/2025</div>
                        <span class="user-type">Pessoa Física</span>
                    </div>
                    <div class="status-pending">Aguardando Aprovação</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function redirecionarParaPerfil(cpfCnpj) {
            // Redireciona diretamente para a página PerfilAdmCadastro com dados estáticos
            window.location.href = 'PerfilAdmCadastro.jsp?cpf=' + encodeURIComponent(cpfCnpj);
        }
    </script>
</body>
</html>