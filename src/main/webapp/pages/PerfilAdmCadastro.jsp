<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Perfil do Usuário - Administração</title>
    <link rel="stylesheet" href="../assets/css/admDetalhes.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        .back-button {
            margin-bottom: 20px;
        }
        .back-button a {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-right: 10px;
            font-weight: 600;
        }
        .back-button a:hover {
            background-color: #5a6268;
        }
        .profile-header {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .profile-photo {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 15px;
            background-color: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: #6c757d;
        }
        .profile-header h1 {
            color: #343a40;
            margin-bottom: 10px;
        }
        .user-details {
            background-color: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .user-details h2 {
            color: #343a40;
            margin-bottom: 20px;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 10px;
        }
        .detail-row {
            display: flex;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .detail-label {
            font-weight: bold;
            width: 180px;
            color: #495057;
        }
        .detail-value {
            flex: 1;
            color: #6c757d;
        }
        .status-badge {
            background-color: #ffeaa7;
            color: #2d3436;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            display: inline-block;
            font-weight: 600;
        }
        .action-buttons {
            text-align: center;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin: 0 10px;
            transition: all 0.3s ease;
        }
        .btn-approve {
            background-color: #28a745;
            color: white;
        }
        .btn-approve:hover {
            background-color: #218838;
        }
        .btn-deny {
            background-color: #dc3545;
            color: white;
        }
        .btn-deny:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Botões de navegação -->
        <div class="back-button">
            <a href="usuariosPermissao.jsp">← Voltar para Lista de Usuários</a>
            <a href="admDetalhes.jsp">← Voltar para Painel do Administrador</a>
        </div>
        
        <!-- Dados estáticos do usuário -->
        <div class="profile-header">
            <div class="profile-photo">
                👤
            </div>
            <h1>Ana Carolina Ferreira</h1>
            <span class="status-badge">Aguardando Aprovação de Acesso</span>
        </div>

        <div class="user-details">
            <h2>Informações Pessoais</h2>
            
            <div class="detail-row">
                <div class="detail-label">CPF/CNPJ:</div>
                <div class="detail-value">123.456.789-10</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Nome/Razão Social:</div>
                <div class="detail-value">Ana Carolina Ferreira</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Email:</div>
                <div class="detail-value">ana.ferreira@email.com</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Telefone:</div>
                <div class="detail-value">(11) 99888-7777</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Cidade:</div>
                <div class="detail-value">São Paulo</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Estado:</div>
                <div class="detail-value">SP</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">País:</div>
                <div class="detail-value">Brasil</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Possui Bicicleta:</div>
                <div class="detail-value">Sim</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Comprovante Bicicleta:</div>
                <div class="detail-value">
                    <div style="background: #f0f0f0; padding: 10px; border-radius: 5px; color: #666;">
                        📄 comprovante_bike_ana.jpg
                    </div>
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Data de Cadastro:</div>
                <div class="detail-value">15/07/2025</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Permissão de Acesso:</div>
                <div class="detail-value">Pendente</div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Permissão de Ranking:</div>
                <div class="detail-value">Não definida</div>
            </div>
        </div>

        <div class="action-buttons">
            <button type="button" class="btn btn-approve" onclick="aprovarUsuario()">
                ✓ Aprovar Acesso
            </button>
            
            <button type="button" class="btn btn-deny" onclick="negarUsuario()">
                ✗ Negar Acesso e Excluir
            </button>
        </div>
    </div>

    <script>
        function aprovarUsuario() {
            if (confirm('Tem certeza que deseja aprovar o acesso deste usuário?')) {
                alert('Usuário aprovado com sucesso!\n\nAna Carolina Ferreira agora pode:\n• Fazer login no sistema\n• Cadastrar bicicletas\n• Fazer reservas\n• Participar do sistema');
                window.location.href = 'usuariosPermissao.jsp';
            }
        }
        
        function negarUsuario() {
            if (confirm('Tem certeza que deseja negar o acesso e excluir este usuário?\n\nEsta ação não pode ser desfeita.')) {
                alert('Usuário removido do sistema com sucesso.\n\nO cadastro de Ana Carolina Ferreira foi excluído permanentemente.');
                window.location.href = 'usuariosPermissao.jsp';
            }
        }
    </script>
</body>
</html>
