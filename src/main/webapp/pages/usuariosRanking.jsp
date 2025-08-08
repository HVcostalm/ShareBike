<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Usuários para o Ranking - ShareBike</title>
    <link rel="stylesheet" href="../assets/css/gestaoUsuario.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #f8f9fa;
            min-height: 100vh;
        }
        
        .ranking-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .ranking-title {
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
            border-color: #667eea;
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
        
        .status-pending {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            color: #212529;
            padding: 0.6rem 1.2rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            flex-shrink: 0;
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
            background: linear-gradient(135deg, #6c757d, #5a6268);
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
    </style>
</head>
<body>
    <div class="container">
        <a href="<%=request.getContextPath()%>/pages/gestaoUsuario.jsp" class="back-button">
            <i class="fas fa-arrow-left"></i> Voltar para Gestão
        </a>
        
        <div class="ranking-header">
            <h1 class="ranking-title">
                <i class="fas fa-trophy"></i> 
                Usuários Aguardando Aprovação para Ranking
            </h1>
            <p>Usuários que finalizaram reservas e estão aguardando participar do sistema de rankings</p>
        </div>
        
        <h2 class="section-title">
            <i class="fas fa-clock"></i> 
            Usuários Pendentes - Dados Estáticos
        </h2>
        
        <!-- Usuários com dados estáticos -->
        <div class="user-card" onclick="redirecionarParaPerfil('11111111111')">
            <div class="user-avatar">RS</div>
            <div class="user-info">
                <div class="user-name">Roberto Silva</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> roberto.silva@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 111.111.111-11
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> São Paulo - SP
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> 3 reservas finalizadas
                    </div>
                </div>
            </div>
            <div class="status-pending">
                <i class="fas fa-hourglass-half"></i>
                Aguardando Aprovação Ranking
            </div>
        </div>
        
        <div class="user-card" onclick="redirecionarParaPerfil('22222222222')">
            <div class="user-avatar">MF</div>
            <div class="user-info">
                <div class="user-name">Marina Ferreira</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> marina.ferreira@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 222.222.222-22
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> Rio de Janeiro - RJ
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> 5 reservas finalizadas
                    </div>
                </div>
            </div>
            <div class="status-pending">
                <i class="fas fa-hourglass-half"></i>
                Aguardando Aprovação Ranking
            </div>
        </div>
        
        <div class="user-card" onclick="redirecionarParaPerfil('33333333333')">
            <div class="user-avatar">AL</div>
            <div class="user-info">
                <div class="user-name">Antonio Lima</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> antonio.lima@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 333.333.333-33
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> Belo Horizonte - MG
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> 2 reservas finalizadas
                    </div>
                </div>
            </div>
            <div class="status-pending">
                <i class="fas fa-hourglass-half"></i>
                Aguardando Aprovação Ranking
            </div>
        </div>
        
        <div class="user-card" onclick="redirecionarParaPerfil('44444444444')">
            <div class="user-avatar">CS</div>
            <div class="user-info">
                <div class="user-name">Carla Santos</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> carla.santos@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 444.444.444-44
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> Brasília - DF
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> 7 reservas finalizadas
                    </div>
                </div>
            </div>
            <div class="status-pending">
                <i class="fas fa-hourglass-half"></i>
                Aguardando Aprovação Ranking
            </div>
        </div>
        
        <div class="user-card" onclick="redirecionarParaPerfil('55555555555')">
            <div class="user-avatar">DR</div>
            <div class="user-info">
                <div class="user-name">Diego Rodrigues</div>
                <div class="user-details">
                    <div class="detail-item">
                        <i class="fas fa-envelope"></i> diego.rodrigues@email.com
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-id-card"></i> 555.555.555-55
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i> Salvador - BA
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-bicycle"></i> 4 reservas finalizadas
                    </div>
                </div>
            </div>
            <div class="status-pending">
                <i class="fas fa-hourglass-half"></i>
                Aguardando Aprovação Ranking
            </div>
        </div>
    </div>

    <script>
        function redirecionarParaPerfil(cpfCnpj) {
            // Redireciona diretamente para a página PerfilAdmRanking com dados estáticos
            window.location.href = 'PerfilAdmRanking.jsp?cpf=' + encodeURIComponent(cpfCnpj);
        }
    </script>
</body>
</html>