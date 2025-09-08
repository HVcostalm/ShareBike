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

// Obter dados enviados pelo controller
Bicicleta bicicleta = (Bicicleta) request.getAttribute("bicicleta");
Usuario proprietario = (Usuario) request.getAttribute("proprietario");

if (bicicleta == null) {
    response.sendRedirect("bicicletasLocador.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Bicicleta - ShareBike</title>
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
        
        .edit-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
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
            border-color: #28a745;
            box-shadow: 0 0 0 3px rgba(40, 167, 69, 0.1);
        }
        
        .form-group input[readonly] {
            background-color: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
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
        
        .bike-image-preview {
            max-width: 200px;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #e9ecef;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="edit-header">
            <h1 class="edit-title">
                <i class="fas fa-bicycle"></i> 
                Editar Bicicleta
            </h1>
            <p>Edite as informações da bicicleta: <%= bicicleta.getNome_bike() != null ? bicicleta.getNome_bike() : "Nome não informado" %></p>
        </div>
        
        <div class="alert alert-info">
            <i class="fas fa-info-circle"></i>
            Apenas alguns campos podem ser editados. Campos em cinza são somente leitura.
        </div>
        
        <!-- Formulário de Edição -->
        <form action="<%=request.getContextPath()%>/BicicletaController" method="post">
            <input type="hidden" name="action" value="editar">
            <input type="hidden" name="id" value="<%= bicicleta.getId_bike() %>">
            
            <div class="form-container">
                <!-- Foto da Bicicleta -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-camera"></i>
                        Foto da Bicicleta
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group full-width">
                            <label for="foto_bike">
                                <i class="fas fa-image"></i>
                                URL da Foto (Editável)
                            </label>
                            <input type="text" id="foto_bike" name="foto_bike" 
                                   value="<%= bicicleta.getFoto_bike() != null ? bicicleta.getFoto_bike() : "" %>"
                                   placeholder="Digite a URL da foto da bicicleta">
                        </div>
                        
                        <div class="form-group">
                            <img src="<%= bicicleta.getFoto_bike() != null ? bicicleta.getFoto_bike() : "" %>" 
                                 alt="Foto da bicicleta" class="bike-image-preview" id="preview-image">
                        </div>
                    </div>
                </div>
                
                <!-- Informações Básicas (Somente Leitura) -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-info-circle"></i>
                        Informações Básicas (Somente Leitura)
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-bicycle"></i>
                                Nome da Bicicleta
                            </label>
                            <input type="text" readonly 
                                   value="<%= bicicleta.getNome_bike() != null ? bicicleta.getNome_bike() : "" %>">
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-tags"></i>
                                Tipo da Bicicleta
                            </label>
                            <input type="text" readonly 
                                   value="<%= bicicleta.getTipo_bike() != null ? bicicleta.getTipo_bike() : "" %>">
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-barcode"></i>
                                Chassi
                            </label>
                            <input type="text" readonly 
                                   value="<%= bicicleta.getChassi_bike() != null ? bicicleta.getChassi_bike() : "" %>">
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-user"></i>
                                Proprietário
                            </label>
                            <input type="text" readonly 
                                   value="<%= proprietario != null ? proprietario.getNomeRazaoSocial_user() : "Não informado" %>">
                        </div>
                    </div>
                </div>
                
                <!-- Campos Editáveis -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-edit"></i>
                        Campos Editáveis
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="localEntr_bike">
                                <i class="fas fa-map-marker-alt"></i>
                                Local de Entrega
                            </label>
                            <input type="text" id="localEntr_bike" name="localEntr_bike" 
                                   value="<%= bicicleta.getLocalEntr_bike() != null ? bicicleta.getLocalEntr_bike() : "" %>"
                                   placeholder="Digite o local de entrega" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="estadoConserv_bike">
                                <i class="fas fa-cogs"></i>
                                Estado de Conservação
                            </label>
                            <select id="estadoConserv_bike" name="estadoConserv_bike" required>
                                <option value="BOM" <%= "BOM".equals(bicicleta.getEstadoConserv_bike()) ? "selected" : "" %>>BOM</option>
                                <option value="ÓTIMA" <%= "OTIMA".equals(bicicleta.getEstadoConserv_bike()) ? "selected" : "" %>>ÓTIMA</option>
                                <option value="EXCELENTE" <%= "EXCELENTE".equals(bicicleta.getEstadoConserv_bike()) ? "selected" : "" %>>EXCELENTE</option>
                            </select>
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
                
                <a href="<%=request.getContextPath()%>/BicicletaController?action=exibir&id=<%= bicicleta.getId_bike() %>" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Voltar aos Detalhes
                </a>
            </div>
        </form>
    </div>

    <script>
        // Preview da imagem quando URL é alterada
        document.getElementById('foto_bike').addEventListener('blur', function() {
            const url = this.value;
            const img = document.getElementById('preview-image');
            if (url && img) {
                img.src = url;
                img.onerror = function() {
                    this.src = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="200" height="150" viewBox="0 0 200 150"%3E%3Crect width="200" height="150" fill="%23f8f9fa"/%3E%3Ctext x="100" y="75" text-anchor="middle" fill="%236c757d"%3EImagem não encontrada%3C/text%3E%3C/svg%3E';
                };
            }
        });
        
        console.log('Página de edição de bicicleta carregada');
    </script>
</body>
</html>
