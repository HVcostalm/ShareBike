<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Bicicleta" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="br.com.sharebike.model.Disponibilidade" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
// Verificar se o usuário está logado
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
if (usuarioLogado == null) {
    response.sendRedirect("loginUsuario.jsp");
    return;
}

// Obter dados enviados pelo controller
Bicicleta bicicleta = (Bicicleta) request.getAttribute("bicicleta");
Usuario proprietario = (Usuario) request.getAttribute("proprietario");
Disponibilidade disponibilidade = (Disponibilidade) request.getAttribute("disponibilidade");

if (bicicleta == null || disponibilidade == null) {
    response.sendRedirect("bicicletasLocador.jsp");
    return;
}

// Formatadores para exibir as datas nos inputs
DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Disponibilidade - ShareBike</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/usuarioDetalhes.css">
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
            background: linear-gradient(135deg, #28a745, #20c997);
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
            border-color: #28a745;
            box-shadow: 0 0 0 3px rgba(40, 167, 69, 0.1);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
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
        
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
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
        
        .status-available {
            background: #d4edda;
            color: #28a745;
        }
        
        .status-unavailable {
            background: #f8d7da;
            color: #dc3545;
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
                <i class="fas fa-calendar-alt"></i> 
                Editar Disponibilidade
            </h1>
            <p>Gerencie a disponibilidade da bicicleta: <%= bicicleta.getNome_bike() %></p>
        </div>
        
        <!-- Status Atual -->
        <div class="form-container">
            <div class="status-indicator <%= disponibilidade.isDisponivel_disp() ? "status-available" : "status-unavailable" %>">
                <i class="fas fa-clock"></i>
                Status: <%= disponibilidade.isDisponivel_disp() ? "Disponível" : "Indisponível" %>
            </div>
            
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i>
                <span>Editando disponibilidade de <%= disponibilidade.getDataHoraIn_disp().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")) %> até <%= disponibilidade.getDataHoraFim_disp().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")) %></span>
            </div>
            
            <!-- Exibir erro se houver -->
            <% String erro = (String) request.getAttribute("erro"); %>
            <% if (erro != null && !erro.trim().isEmpty()) { %>
            <div class="alert alert-error" style="background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; margin-bottom: 1rem;">
                <i class="fas fa-exclamation-triangle"></i>
                <%= erro %>
            </div>
            <% } %>
        </div>
        
        <!-- Formulário de Edição -->
        <form action="<%= request.getContextPath() %>/DisponibilidadeController" method="post">
            <input type="hidden" name="action" value="editar">
            <input type="hidden" name="id_disp" value="<%= disponibilidade.getId_disp() %>">
            <input type="hidden" name="id_bike" value="<%= bicicleta.getId_bike() %>">
            <input type="hidden" name="disponivel" value="<%= disponibilidade.isDisponivel_disp() %>">
            
            <div class="form-container">
                <h3 class="section-title">
                    <i class="fas fa-edit"></i>
                    Editar Disponibilidade
                </h3>
                
                <div class="form-section">
                    <div class="section-title">
                        <i class="fas fa-info-circle"></i>
                        Informações da Bicicleta
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label><i class="fas fa-bicycle"></i> Nome da Bicicleta</label>
                            <input type="text" value="<%= bicicleta.getNome_bike() %>" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Proprietário</label>
                            <input type="text" value="<%= proprietario != null ? proprietario.getNomeRazaoSocial_user() : "N/A" %>" readonly>
                        </div>
                    </div>
                </div>
                
                <div class="form-section">
                    <div class="section-title">
                        <i class="fas fa-calendar-check"></i>
                        Período de Disponibilidade
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="dataHoraIn"><i class="fas fa-play"></i> Data e Hora de Início</label>
                            <input type="datetime-local" 
                                   id="dataHoraIn" 
                                   name="dataHoraIn" 
                                   value="<%= disponibilidade.getDataHoraIn_disp().format(inputFormatter) %>" 
                                   required>
                        </div>
                        
                        <div class="form-group">
                            <label for="dataHoraFim"><i class="fas fa-stop"></i> Data e Hora de Fim</label>
                            <input type="datetime-local" 
                                   id="dataHoraFim" 
                                   name="dataHoraFim" 
                                   value="<%= disponibilidade.getDataHoraFim_disp().format(inputFormatter) %>" 
                                   required>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Botões de Ação -->
            <div class="action-buttons">
                <a href="<%= request.getContextPath() %>/BicicletaController?action=exibir&id=<%= bicicleta.getId_bike() %>" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Voltar
                </a>
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-save"></i> Salvar Disponibilidade
                </button>
            </div>
        </form>
    </div>

    <script>
        // Validação básica de datas
        document.addEventListener('DOMContentLoaded', function() {
            const dataInicio = document.getElementById('dataHoraIn');
            const dataFim = document.getElementById('dataHoraFim');
            
            function validarDatas() {
                if (dataInicio.value && dataFim.value) {
                    const inicio = new Date(dataInicio.value);
                    const fim = new Date(dataFim.value);
                    
                    if (inicio >= fim) {
                        alert('A data de início deve ser anterior à data de fim.');
                        dataFim.value = '';
                        return false;
                    }
                }
                return true;
            }
            
            dataInicio.addEventListener('change', validarDatas);
            dataFim.addEventListener('change', validarDatas);
        });
        
        console.log('Página de edição de disponibilidade carregada');
    </script>
</body>
</html>
