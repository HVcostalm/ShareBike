<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Bicicleta" %>
<%@ page import="br.com.sharebike.model.Usuario" %>

<%
// Verificar se o usuário está logado
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
if (usuarioLogado == null) {
    response.sendRedirect("loginUsuario.jsp");
    return;
}

// Obter ID da bicicleta dos parâmetros ou do atributo
String idParam = request.getParameter("id");
Integer idBikeAttr = (Integer) request.getAttribute("id_bike");

int id_bike;
if (idBikeAttr != null) {
    // Se há atributo (vindo do controller após erro), usar ele
    id_bike = idBikeAttr;
} else if (idParam != null && !idParam.trim().isEmpty()) {
    // Se há parâmetro na URL, usar ele
    id_bike = Integer.parseInt(idParam);
} else {
    // Se não há nenhum, redirecionar
    response.sendRedirect("bicicletasLocador.jsp");
    return;
}

// Verificar se há dados da bicicleta vindos do controller
Bicicleta bicicleta = (Bicicleta) request.getAttribute("bicicleta");
Usuario proprietario = (Usuario) request.getAttribute("proprietario");

// Se não há dados do controller, ainda assim mostra a página (pode ser acesso direto via URL)
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Definir Disponibilidade - ShareBike</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/usuarioDetalhes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background: #f8f9fa;
            min-height: 100vh;
        }
        
        .header {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
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
        
        .form-container {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .bike-info {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            border-left: 4px solid #007bff;
        }
        
        .bike-info h3 {
            color: #333;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .bike-detail {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
            color: #6c757d;
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
        .form-group select {
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
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
        
        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
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
        
        .datetime-group {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        .datetime-input {
            display: flex;
            flex-direction: column;
        }
        
        .datetime-input label {
            font-weight: 500;
            color: #333;
            margin-bottom: 0.3rem;
            font-size: 0.9rem;
        }
        
        .help-text {
            font-size: 0.8rem;
            color: #6c757d;
            margin-top: 0.3rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1 class="header-title">
                <i class="fas fa-calendar-alt"></i> 
                Definir Disponibilidade
            </h1>
            <p>Configure os períodos de disponibilidade da sua bicicleta</p>
        </div>
        
        <div class="alert alert-info">
            <i class="fas fa-info-circle"></i>
            Defina o período em que sua bicicleta estará disponível para locação
        </div>
        
        <!-- Exibir erro se houver -->
        <% String erro = (String) request.getAttribute("erro"); %>
        <% if (erro != null && !erro.trim().isEmpty()) { %>
        <div class="alert alert-error" style="background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; margin-bottom: 1rem;">
            <i class="fas fa-exclamation-triangle"></i>
            <%= erro %>
        </div>
        <% } %>
        
        <!-- Informações da Bicicleta -->
        <% if (bicicleta != null) { %>
        <div class="bike-info">
            <h3><i class="fas fa-bicycle"></i> Informações da Bicicleta</h3>
            <div class="bike-detail">
                <i class="fas fa-tag"></i>
                <strong>Nome:</strong> <%= bicicleta.getNome_bike() != null ? bicicleta.getNome_bike() : "Não informado" %>
            </div>
            <div class="bike-detail">
                <i class="fas fa-bicycle"></i>
                <strong>Tipo:</strong> <%= bicicleta.getTipo_bike() != null ? bicicleta.getTipo_bike() : "Não informado" %>
            </div>
            <div class="bike-detail">
                <i class="fas fa-map-marker-alt"></i>
                <strong>Local:</strong> <%= bicicleta.getLocalEntr_bike() != null ? bicicleta.getLocalEntr_bike() : "Não informado" %>
            </div>
            <div class="bike-detail">
                <i class="fas fa-cogs"></i>
                <strong>Estado:</strong> <%= bicicleta.getEstadoConserv_bike() != null ? bicicleta.getEstadoConserv_bike() : "Não informado" %>
            </div>
            <% if (proprietario != null) { %>
            <div class="bike-detail">
                <i class="fas fa-user"></i>
                <strong>Proprietário:</strong> <%= proprietario.getNomeRazaoSocial_user() %>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="bike-info">
            <h3><i class="fas fa-bicycle"></i> Bicicleta ID: <%= id_bike %></h3>
            <p>Configurando disponibilidade para a bicicleta selecionada.</p>
        </div>
        <% } %>
        
        <!-- Formulário de Disponibilidade -->
        <form action="<%=request.getContextPath()%>/DisponibilidadeController" method="post">
            <input type="hidden" name="action" value="adicionar">
            <input type="hidden" name="id_bike" value="<%= id_bike %>">
            
            <div class="form-container">
                <!-- Período de Disponibilidade -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-calendar-week"></i>
                        Período de Disponibilidade
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="dataHoraIn">
                                <i class="fas fa-calendar-plus"></i>
                                Data e Hora de Início *
                            </label>
                            <input type="datetime-local" id="dataHoraIn" name="dataHoraIn" required>
                            <div class="help-text">Quando a bicicleta ficará disponível</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="dataHoraFim">
                                <i class="fas fa-calendar-minus"></i>
                                Data e Hora de Fim *
                            </label>
                            <input type="datetime-local" id="dataHoraFim" name="dataHoraFim" required>
                            <div class="help-text">Quando a disponibilidade expira</div>
                        </div>
                    </div>
                    
                    <div class="alert alert-info" style="margin-top: 1rem;">
                        <i class="fas fa-lightbulb"></i>
                        <strong>Dica:</strong> A data de fim deve ser posterior à data de início
                    </div>
                </div>
                
                <!-- Instruções Adicionais -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-info-circle"></i>
                        Como Funciona
                    </h3>
                    
                    <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 8px;">
                        <ul style="margin: 0; padding-left: 1.5rem; color: #6c757d;">
                            <li><strong>Data de Início:</strong> Momento em que a bicicleta ficará disponível para reservas</li>
                            <li><strong>Data de Fim:</strong> Momento em que a disponibilidade expira automaticamente</li>
                            <li><strong>Gerenciamento:</strong> Você pode criar múltiplos períodos de disponibilidade</li>
                            <li><strong>Reservas:</strong> Durante o período ativo, locatários poderão fazer reservas</li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <!-- Botões de Ação -->
            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i>
                    Salvar Disponibilidade
                </button>
                
                <a href="<%=request.getContextPath()%>/BicicletaController?action=exibir&id=<%= id_bike %>" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Voltar aos Detalhes
                </a>
            </div>
        </form>
    </div>

    <script>
        // Definir data mínima como agora
        document.addEventListener('DOMContentLoaded', function() {
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const day = String(now.getDate()).padStart(2, '0');
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            
            const nowString = `${year}-${month}-${day}T${hours}:${minutes}`;
            
            const dataInicio = document.getElementById('dataHoraIn');
            const dataFim = document.getElementById('dataHoraFim');
            
            // Definir valor mínimo
            dataInicio.min = nowString;
            dataFim.min = nowString;
            
            // Definir valor padrão (agora + 1 hora para início, + 1 dia para fim)
            const startTime = new Date(now.getTime() + 60 * 60 * 1000); // +1 hora
            const endTime = new Date(now.getTime() + 24 * 60 * 60 * 1000); // +24 horas
            
            dataInicio.value = formatDateTime(startTime);
            dataFim.value = formatDateTime(endTime);
            
            // Validar que data fim é posterior à data início
            dataInicio.addEventListener('change', function() {
                const startValue = new Date(this.value);
                const endValue = new Date(dataFim.value);
                
                if (endValue <= startValue) {
                    const newEndTime = new Date(startValue.getTime() + 60 * 60 * 1000); // +1 hora após início
                    dataFim.value = formatDateTime(newEndTime);
                }
                
                dataFim.min = this.value;
            });
            
            dataFim.addEventListener('change', function() {
                const startValue = new Date(dataInicio.value);
                const endValue = new Date(this.value);
                
                if (endValue <= startValue) {
                    alert('A data de fim deve ser posterior à data de início!');
                    const newEndTime = new Date(startValue.getTime() + 60 * 60 * 1000);
                    this.value = formatDateTime(newEndTime);
                }
            });
        });
        
        function formatDateTime(date) {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            
            return `${year}-${month}-${day}T${hours}:${minutes}`;
        }
        
        // Validação do formulário
        document.querySelector('form').addEventListener('submit', function(e) {
            const dataInicio = document.getElementById('dataHoraIn').value;
            const dataFim = document.getElementById('dataHoraFim').value;
            
            if (!dataInicio || !dataFim) {
                e.preventDefault();
                alert('Por favor, preencha ambas as datas!');
                return;
            }
            
            const startDate = new Date(dataInicio);
            const endDate = new Date(dataFim);
            const now = new Date();
            
            if (startDate <= now) {
                e.preventDefault();
                alert('A data de início deve ser futura!');
                return;
            }
            
            if (endDate <= startDate) {
                e.preventDefault();
                alert('A data de fim deve ser posterior à data de início!');
                return;
            }
            
            // Confirmação
            if (!confirm('Deseja salvar esta disponibilidade?\n\nInício: ' + startDate.toLocaleString('pt-BR') + '\nFim: ' + endDate.toLocaleString('pt-BR'))) {
                e.preventDefault();
            }
        });
        
        console.log('Página de definir disponibilidade carregada');
    </script>
</body>
</html>
