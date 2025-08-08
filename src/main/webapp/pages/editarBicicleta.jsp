<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Bicicleta - ShareBike</title>
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
        
        .bike-images {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .image-gallery {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .bike-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #e9ecef;
        }
        
        .upload-area {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
            padding: 2rem;
            border: 2px dashed #28a745;
            border-radius: 8px;
            background: #f8fff8;
        }
        
        .file-input {
            display: none;
        }
        
        .file-label {
            background: linear-gradient(135deg, #28a745, #20c997);
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
        
        .price-input {
            position: relative;
        }
        
        .price-input input {
            padding-left: 40px;
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
        
        .btn-warning {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            color: #212529;
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
        
        .status-rented {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-maintenance {
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
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
        
        .rating-display {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .stars {
            color: #ffc107;
            font-size: 1.2rem;
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
            <p>Edite as informações da bicicleta: Bike Speed Pro 2024</p>
        </div>
        
        <!-- Formulário de Edição -->
        <form action="../BicicletaController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="editar">
            <input type="hidden" name="idBicicleta" value="1">
            
            <div class="form-container">
                <!-- Status da Bicicleta -->
                <div class="status-indicator status-available">
                    <i class="fas fa-check-circle"></i>
                    Bicicleta Disponível
                </div>
                
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i>
                    <span>Use este formulário para editar as informações da bicicleta. Campos obrigatórios estão marcados com *</span>
                </div>
                
                <!-- Fotos da Bicicleta -->
                <div class="bike-images">
                    <h3 class="section-title">
                        <i class="fas fa-camera"></i>
                        Fotos da Bicicleta
                    </h3>
                    
                    <div class="image-gallery">
                        <img src="../assets/images/bike1.jpg" alt="Foto 1" class="bike-image">
                        <img src="../assets/images/bike2.jpg" alt="Foto 2" class="bike-image">
                        <img src="../assets/images/bike3.jpg" alt="Foto 3" class="bike-image">
                    </div>
                    
                    <div class="upload-area">
                        <input type="file" id="fotos" name="fotos" class="file-input" accept="image/*" multiple>
                        <label for="fotos" class="file-label">
                            <i class="fas fa-camera"></i>
                            Adicionar/Alterar Fotos
                        </label>
                        <small>Formatos aceitos: JPG, PNG, GIF (máx. 5MB cada, até 10 fotos)</small>
                    </div>
                </div>
                
                <!-- Informações Básicas -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-info-circle"></i>
                        Informações Básicas
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="modelo">
                                <i class="fas fa-tag"></i>
                                Modelo *
                            </label>
                            <input type="text" id="modelo" name="modelo" 
                                   value="Bike Speed Pro 2024" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="marca">
                                <i class="fas fa-industry"></i>
                                Marca *
                            </label>
                            <input type="text" id="marca" name="marca" 
                                   value="Trek" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="cor">
                                <i class="fas fa-palette"></i>
                                Cor *
                            </label>
                            <input type="text" id="cor" name="cor" 
                                   value="Azul Metálico" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="tamanho">
                                <i class="fas fa-arrows-alt-v"></i>
                                Tamanho *
                            </label>
                            <select id="tamanho" name="tamanho" required>
                                <option value="P">P (14" - 16")</option>
                                <option value="M" selected>M (17" - 19")</option>
                                <option value="L">L (20" - 22")</option>
                                <option value="XL">XL (23" - 25")</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="tipoCategoria">
                                <i class="fas fa-list-alt"></i>
                                Categoria *
                            </label>
                            <select id="tipoCategoria" name="tipoCategoria" required>
                                <option value="mountain" selected>Mountain Bike</option>
                                <option value="speed">Speed/Road</option>
                                <option value="urbana">Urbana/City</option>
                                <option value="hibrida">Híbrida</option>
                                <option value="eletrica">Elétrica</option>
                                <option value="infantil">Infantil</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="anoFabricacao">
                                <i class="fas fa-calendar-alt"></i>
                                Ano de Fabricação
                            </label>
                            <input type="number" id="anoFabricacao" name="anoFabricacao" 
                                   value="2024" min="1990" max="2025">
                        </div>
                    </div>
                </div>
                
                <!-- Especificações Técnicas -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-cogs"></i>
                        Especificações Técnicas
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="numeroMarchas">
                                <i class="fas fa-exchange-alt"></i>
                                Número de Marchas
                            </label>
                            <select id="numeroMarchas" name="numeroMarchas">
                                <option value="1">1 Marcha</option>
                                <option value="7">7 Marchas</option>
                                <option value="14">14 Marchas</option>
                                <option value="18">18 Marchas</option>
                                <option value="21" selected>21 Marchas</option>
                                <option value="24">24 Marchas</option>
                                <option value="27">27 Marchas</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="tipoFreio">
                                <i class="fas fa-hand-paper"></i>
                                Tipo de Freio
                            </label>
                            <select id="tipoFreio" name="tipoFreio">
                                <option value="v-brake">V-Brake</option>
                                <option value="disco-mecanico" selected>Disco Mecânico</option>
                                <option value="disco-hidraulico">Disco Hidráulico</option>
                                <option value="cantilever">Cantilever</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="materialQuadro">
                                <i class="fas fa-hammer"></i>
                                Material do Quadro
                            </label>
                            <select id="materialQuadro" name="materialQuadro">
                                <option value="aco">Aço</option>
                                <option value="aluminio" selected>Alumínio</option>
                                <option value="carbono">Fibra de Carbono</option>
                                <option value="titanio">Titânio</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="tamanhoRoda">
                                <i class="fas fa-circle"></i>
                                Tamanho da Roda
                            </label>
                            <select id="tamanhoRoda" name="tamanhoRoda">
                                <option value="16">16"</option>
                                <option value="20">20"</option>
                                <option value="24">24"</option>
                                <option value="26" selected>26"</option>
                                <option value="27.5">27.5"</option>
                                <option value="29">29"</option>
                                <option value="700c">700c</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="peso">
                                <i class="fas fa-weight"></i>
                                Peso (kg)
                            </label>
                            <input type="number" id="peso" name="peso" 
                                   value="12.5" step="0.1" min="5" max="30">
                        </div>
                        
                        <div class="form-group">
                            <label for="capacidadeMaxima">
                                <i class="fas fa-weight-hanging"></i>
                                Capacidade Máxima (kg)
                            </label>
                            <input type="number" id="capacidadeMaxima" name="capacidadeMaxima" 
                                   value="120" min="50" max="200">
                        </div>
                    </div>
                </div>
                
                <!-- Status e Disponibilidade -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-calendar-check"></i>
                        Status e Disponibilidade
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="statusDisponibilidade">
                                <i class="fas fa-toggle-on"></i>
                                Status de Disponibilidade *
                            </label>
                            <select id="statusDisponibilidade" name="statusDisponibilidade" required>
                                <option value="disponivel" selected>Disponível</option>
                                <option value="alugada">Alugada</option>
                                <option value="manutencao">Em Manutenção</option>
                                <option value="inativa">Inativa</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="localizacao">
                                <i class="fas fa-map-marker-alt"></i>
                                Localização Atual
                            </label>
                            <input type="text" id="localizacao" name="localizacao" 
                                   value="Estação Central - São Paulo">
                        </div>
                    </div>
                </div>
                
                <!-- Características e Acessórios -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-plus-circle"></i>
                        Características e Acessórios
                    </h3>
                    
                    <div class="features-grid">
                        <div class="checkbox-group">
                            <div class="checkbox-item">
                                <input type="checkbox" id="possuiCadeado" name="possuiCadeado" checked>
                                <label for="possuiCadeado">
                                    <i class="fas fa-lock"></i>
                                    Possui Cadeado
                                </label>
                            </div>
                            
                            <div class="checkbox-item">
                                <input type="checkbox" id="possuiCapacete" name="possuiCapacete" checked>
                                <label for="possuiCapacete">
                                    <i class="fas fa-hard-hat"></i>
                                    Inclui Capacete
                                </label>
                            </div>
                            
                            <div class="checkbox-item">
                                <input type="checkbox" id="possuiLuz" name="possuiLuz">
                                <label for="possuiLuz">
                                    <i class="fas fa-lightbulb"></i>
                                    Sistema de Iluminação
                                </label>
                            </div>
                            
                            <div class="checkbox-item">
                                <input type="checkbox" id="possuiCesta" name="possuiCesta" checked>
                                <label for="possuiCesta">
                                    <i class="fas fa-shopping-basket"></i>
                                    Cesta/Bagageiro
                                </label>
                            </div>
                        </div>
                        
                        <div class="checkbox-group">
                            <div class="checkbox-item">
                                <input type="checkbox" id="possuiSuspensao" name="possuiSuspensao" checked>
                                <label for="possuiSuspensao">
                                    <i class="fas fa-arrows-alt-v"></i>
                                    Suspensão
                                </label>
                            </div>
                            
                            <div class="checkbox-item">
                                <input type="checkbox" id="possuiGPS" name="possuiGPS">
                                <label for="possuiGPS">
                                    <i class="fas fa-satellite"></i>
                                    Rastreamento GPS
                                </label>
                            </div>
                            
                            <div class="checkbox-item">
                                <input type="checkbox" id="apropriadaChuva" name="apropriadaChuva">
                                <label for="apropriadaChuva">
                                    <i class="fas fa-cloud-rain"></i>
                                    Apropriada para Chuva
                                </label>
                            </div>
                            
                            <div class="checkbox-item">
                                <input type="checkbox" id="bikeEletrica" name="bikeEletrica">
                                <label for="bikeEletrica">
                                    <i class="fas fa-bolt"></i>
                                    Bicicleta Elétrica
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Avaliação e Histórico -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-star"></i>
                        Avaliação e Histórico
                    </h3>
                    
                    <div class="form-grid">
                        <div class="rating-display">
                            <span class="stars">★★★★☆</span>
                            <span><strong>4.2/5</strong> (18 avaliações)</span>
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-history"></i>
                                Total de Aluguéis
                            </label>
                            <input type="text" value="42 aluguéis" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-clock"></i>
                                Tempo Total de Uso
                            </label>
                            <input type="text" value="126 horas" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label>
                                <i class="fas fa-calendar-alt"></i>
                                Última Manutenção
                            </label>
                            <input type="date" value="2025-01-15" readonly>
                        </div>
                    </div>
                </div>
                
                <!-- Observações -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-sticky-note"></i>
                        Observações e Descrição
                    </h3>
                    
                    <div class="form-group full-width">
                        <label for="descricao">
                            <i class="fas fa-align-left"></i>
                            Descrição da Bicicleta
                        </label>
                        <textarea id="descricao" name="descricao" 
                                  placeholder="Descreva as características principais da bicicleta...">Excelente bicicleta speed para uso urbano e trilhas leves. Quadro de alumínio leve, 21 marchas Shimano, freios a disco mecânicos. Ideal para ciclistas iniciantes e intermediários.</textarea>
                    </div>
                    
                    <div class="form-group full-width">
                        <label for="observacoesManutencao">
                            <i class="fas fa-tools"></i>
                            Observações de Manutenção
                        </label>
                        <textarea id="observacoesManutencao" name="observacoesManutencao" 
                                  placeholder="Histórico de manutenções e observações técnicas...">Última revisão completa em 15/01/2025. Troca de pastilhas de freio realizada. Corrente lubrificada. Pneus em bom estado.</textarea>
                    </div>
                </div>
            </div>
            
            <!-- Botões de Ação -->
            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i>
                    Salvar Alterações
                </button>
                
                <a href="<%=request.getContextPath()%>/pages/definirDisponibilidadeBike.jsp?id=1" class="btn btn-warning">
                    <i class="fas fa-calendar-alt"></i>
                    Definir Disponibilidade
                </a>
                
                <a href="<%=request.getContextPath()%>/pages/bicicletasAdm.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Voltar às Bicicletas
                </a>
                
                <button type="button" class="btn btn-danger" onclick="confirmarExclusao()">
                    <i class="fas fa-trash-alt"></i>
                    Excluir Bicicleta
                </button>
            </div>
        </form>
    </div>

    <script>
        function confirmarExclusao() {
            if (confirm('Tem certeza que deseja excluir esta bicicleta?\n\nEsta ação não pode ser desfeita e todos os dados da bicicleta serão permanentemente removidos.')) {
                alert('Bicicleta excluída com sucesso!');
                window.location.href = 'bicicletasAdm.jsp';
            }
        }
        
        // Preview das imagens
        document.getElementById('fotos').addEventListener('change', function(e) {
            const files = e.target.files;
            const gallery = document.querySelector('.image-gallery');
            
            // Limpar imagens atuais (ou manter e adicionar novas)
            Array.from(files).forEach((file, index) => {
                if (file && index < 10) { // Máximo 10 imagens
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const img = document.createElement('img');
                        img.src = e.target.result;
                        img.className = 'bike-image';
                        img.alt = `Nova foto ${index + 1}`;
                        gallery.appendChild(img);
                    };
                    reader.readAsDataURL(file);
                }
            });
        });
        
        // Formatação de campos
        document.querySelectorAll('input[type="number"][step]').forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value && this.step) {
                    const step = parseFloat(this.step);
                    const value = parseFloat(this.value);
                    this.value = value.toFixed(step < 1 ? 2 : 0);
                }
            });
        });
        
        // Atualizar status visual baseado na seleção
        document.getElementById('statusDisponibilidade').addEventListener('change', function() {
            const statusIndicator = document.querySelector('.status-indicator');
            const value = this.value;
            
            statusIndicator.className = 'status-indicator';
            
            switch(value) {
                case 'disponivel':
                    statusIndicator.classList.add('status-available');
                    statusIndicator.innerHTML = '<i class="fas fa-check-circle"></i> Bicicleta Disponível';
                    break;
                case 'alugada':
                    statusIndicator.classList.add('status-rented');
                    statusIndicator.innerHTML = '<i class="fas fa-clock"></i> Bicicleta Alugada';
                    break;
                case 'manutencao':
                    statusIndicator.classList.add('status-maintenance');
                    statusIndicator.innerHTML = '<i class="fas fa-tools"></i> Em Manutenção';
                    break;
                case 'inativa':
                    statusIndicator.classList.add('status-maintenance');
                    statusIndicator.innerHTML = '<i class="fas fa-times-circle"></i> Bicicleta Inativa';
                    break;
            }
        });
        
        console.log('Página de edição de bicicleta carregada');
    </script>
</body>
</html>
