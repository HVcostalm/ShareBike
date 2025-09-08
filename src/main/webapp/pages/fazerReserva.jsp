<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="br.com.sharebike.model.Bicicleta" %>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="br.com.sharebike.model.Disponibilidade" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fazer Reserva - ShareBike</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .reservation-form {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .form-group label {
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #495057;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            padding: 0.75rem;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 1rem;
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .bike-selection {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 1rem;
            background: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .bike-selection:hover {
            border-color: #38b2ac;
            background: #e6fffa;
        }
        
        .bike-selection.selected {
            border-color: #38b2ac;
            background: #e6fffa;
            box-shadow: 0 0 0 2px rgba(56, 178, 172, 0.2);
        }
        
        .bike-option {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .bike-option input[type="radio"] {
            margin: 0;
        }
        
        .bike-info {
            flex: 1;
        }
        
        .bike-preview-image {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .price-summary {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            border-left: 4px solid #38b2ac;
        }
        
        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }
        
        .price-total {
            font-size: 1.2rem;
            font-weight: bold;
            color: #38b2ac;
            border-top: 1px solid #dee2e6;
            padding-top: 0.5rem;
            margin-top: 0.5rem;
        }
        
        .submit-section {
            text-align: center;
            margin-top: 2rem;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #38b2ac 0%, #2c8e89 100%);
            color: white;
            padding: 1rem 3rem;
            font-size: 1.1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(56, 178, 172, 0.3);
        }
        
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%
        // Obter dados enviados pelo controller
        Bicicleta bicicleta = (Bicicleta) request.getAttribute("bicicleta");
        Usuario proprietario = (Usuario) request.getAttribute("proprietario");
        List<Disponibilidade> disponibilidades = (List<Disponibilidade>) request.getAttribute("disponibilidades");
        Disponibilidade disponibilidadeSelecionada = (Disponibilidade) request.getAttribute("disponibilidadeSelecionada");
        
        // Verificar se há dados
        if (bicicleta == null) {
            response.sendRedirect(request.getContextPath() + "/BicicletaController?action=lista-locatario");
            return;
        }
        
        // Obter usuário logado
        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        if (usuarioLogado == null) {
            response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
            return;
        }
    %>
    
    <header>
        <h1><i class="fas fa-calendar-plus"></i> Fazer Reserva</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/BicicletaController?action=exibir-locatario&id=<%=bicicleta.getId_bike()%>"><i class="fas fa-arrow-left"></i> Voltar para Bicicleta</a>
        </nav>
        
        <form class="reservation-form" id="reservationForm" action="<%=request.getContextPath()%>/ReservaController" method="post">
            <input type="hidden" name="action" value="adicionar">
            <input type="hidden" name="cpfCnpj" value="<%=usuarioLogado.getCpfCnpj_user()%>">
            <input type="hidden" name="id_bike" value="<%=bicicleta.getId_bike()%>">
            
            <!-- Informações da Bicicleta -->
            <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px; margin-bottom: 2rem; border-left: 4px solid #28a745;">
                <h3><i class="fas fa-bicycle"></i> Bicicleta Selecionada</h3>
                <div style="display: grid; grid-template-columns: auto 1fr; gap: 1rem; align-items: center;">
                    <img src="<%=bicicleta.getFoto_bike()%>" alt="<%=bicicleta.getNome_bike()%>" 
                         style="width: 120px; height: 80px; object-fit: cover; border-radius: 8px;">
                    <div>
                        <h4><%=bicicleta.getNome_bike()%></h4>
                        <p><strong>Tipo:</strong> <%=bicicleta.getTipo_bike()%></p>
                        <p><strong>Estado:</strong> <%=bicicleta.getEstadoConserv_bike()%></p>
                        <p><strong>Local de Entrega:</strong> <%=bicicleta.getLocalEntr_bike()%></p>
                    </div>
                </div>
            </div>
            
            <!-- Informações do Proprietário -->
            <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 10px; margin-bottom: 2rem; border-left: 4px solid #17a2b8;">
                <h3><i class="fas fa-user"></i> Proprietário</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem;">
                    <p><strong>Nome:</strong> <%=proprietario.getNomeRazaoSocial_user()%></p>
                    <p><strong>Telefone:</strong> <%=proprietario.getTelefone_user()%></p>
                    <p><strong>Email:</strong> <%=proprietario.getEmail_user()%></p>
                </div>
            </div>
            
            <h3><i class="fas fa-calendar-alt"></i> Período da Reserva</h3>
            
            <div class="form-grid">
                <div class="form-group">
                    <label for="dataCheckIn">
                        <i class="fas fa-calendar"></i> Data e Hora de Retirada
                    </label>
                    <input type="datetime-local" id="dataCheckIn" name="dataCheckIn" readonly
                           <% if (disponibilidadeSelecionada != null) { %>
                           value="<%=disponibilidadeSelecionada.getDataHoraIn_disp().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"))%>"
                           <% } %>>
                </div>
                
                <div class="form-group">
                    <label for="dataCheckOut">
                        <i class="fas fa-calendar"></i> Data e Hora de Devolução
                    </label>
                    <input type="datetime-local" id="dataCheckOut" name="dataCheckOut" readonly
                           <% if (disponibilidadeSelecionada != null) { %>
                           value="<%=disponibilidadeSelecionada.getDataHoraFim_disp().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"))%>"
                           <% } %>>
                </div>
            </div>
            
            <!-- Resumo da Reserva -->
            <div class="price-summary" style="margin-top: 2rem;">
                <h4><i class="fas fa-info-circle"></i> Resumo da Reserva</h4>
                <div class="price-row">
                    <span>Bicicleta:</span>
                    <span><%=bicicleta.getNome_bike()%></span>
                </div>
                <div class="price-row">
                    <span>Tipo:</span>
                    <span><%=bicicleta.getTipo_bike()%></span>
                </div>
                <div class="price-row">
                    <span>Local de Entrega:</span>
                    <span><%=bicicleta.getLocalEntr_bike()%></span>
                </div>
                <div class="price-row">
                    <span>Proprietário:</span>
                    <span><%=proprietario.getNomeRazaoSocial_user()%></span>
                </div>
                <% if (disponibilidadeSelecionada != null) { %>
                <div class="price-row">
                    <span>Período Sugerido:</span>
                    <span><%=disponibilidadeSelecionada.getDataHoraIn_disp().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))%> até <%=disponibilidadeSelecionada.getDataHoraFim_disp().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))%></span>
                </div>
                <% } %>
                <div class="price-row price-total">
                    <span>Status:</span>
                    <span style="color: #28a745; font-weight: bold;">Pronto para reserva</span>
                </div>
            </div>
            
            <div class="submit-section">
                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i> Solicitar Reserva
                </button>
                <p style="margin-top: 1rem; color: #6c757d; font-size: 0.9rem;">
                    Sua solicitação será enviada ao proprietário da bicicleta para aprovação.
                </p>
            </div>
        </form>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        // Submissão do formulário
        document.getElementById('reservationForm').addEventListener('submit', function(e) {
            const checkInDate = document.getElementById('dataCheckIn').value;
            const checkOutDate = document.getElementById('dataCheckOut').value;
            
            if (!checkInDate || !checkOutDate) {
                e.preventDefault();
                alert('Erro: Período da reserva não está definido.');
                return;
            }
            
            // Formulário será enviado normalmente para o ReservaController
        });
    </script>
</body>
</html>