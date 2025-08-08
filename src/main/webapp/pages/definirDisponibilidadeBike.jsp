<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Definir Disponibilidade - Bicicleta</title>
    <link rel="stylesheet" href="../assets/css/bicicletas.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .availability-container {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .bike-info {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .bike-image-large {
            width: 200px;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            border: 3px solid #f8f9fa;
        }
        
        .bike-details h2 {
            color: #333;
            margin-bottom: 1rem;
        }
        
        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
            color: #6c757d;
        }
        
        .availability-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        .form-section {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
        }
        
        .form-section h3 {
            color: #333;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #333;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
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
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }
        
        .checkbox-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 0.8rem;
        }
        
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem;
            background: white;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        
        .checkbox-item:hover {
            background: #e3f2fd;
        }
        
        .checkbox-item input {
            width: auto;
        }
        
        .availability-status {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .status-option {
            flex: 1;
            padding: 1rem;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .status-option.active {
            border-color: #007bff;
            background: #e3f2fd;
        }
        
        .status-option.available {
            border-color: #28a745;
            background: #d4edda;
        }
        
        .status-option.unavailable {
            border-color: #dc3545;
            background: #f8d7da;
        }
        
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        .calendar-day {
            padding: 0.8rem;
            text-align: center;
            border: 1px solid #e9ecef;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .calendar-day.header {
            background: #f8f9fa;
            font-weight: bold;
            cursor: default;
        }
        
        .calendar-day.available {
            background: #d4edda;
            border-color: #28a745;
        }
        
        .calendar-day.unavailable {
            background: #f8d7da;
            border-color: #dc3545;
        }
        
        .calendar-day.reserved {
            background: #fff3cd;
            border-color: #ffc107;
        }
        
        .submit-section {
            grid-column: 1 / -1;
            text-align: center;
            padding-top: 2rem;
            border-top: 2px solid #f8f9fa;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 1rem 3rem;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .current-status {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        
        .status-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .status-item {
            text-align: center;
        }
        
        .status-value {
            font-size: 1.5rem;
            font-weight: bold;
            display: block;
        }
        
        .status-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <header>
        <h1><i class="fas fa-calendar-alt"></i> Definir Disponibilidade da Bicicleta</h1>
    </header>
    
    <div class="container">
        <nav class="nav">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocador.jsp"><i class="fas fa-bicycle"></i> Minhas Bicicletas</a>
            <a href="<%=request.getContextPath()%>/pages/reservasLocador.jsp"><i class="fas fa-calendar-check"></i> Gerenciar Reservas</a>
            <a href="<%=request.getContextPath()%>/pages/fazerFeedbackLocador.jsp"><i class="fas fa-comment-dots"></i> Avaliar Locatários</a>
            <a href="<%=request.getContextPath()%>/pages/dashboardBikes.jsp"><i class="fas fa-chart-bar"></i> Dashboard</a>
        </nav>
        
        <div class="availability-container">
            <!-- Informações da Bicicleta -->
            <div class="bike-info">
                <img src="../assets/images/bike1.jpg" alt="Trek FX 3 Disc" class="bike-image-large" onerror="this.src='https://via.placeholder.com/200x150/007bff/ffffff?text=Trek+FX+3'">
                <div class="bike-details">
                    <h2>Trek FX 3 Disc</h2>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Vila Madalena, São Paulo - SP</span>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-calendar-check"></i>
                        <span>Disponível para reserva</span>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-star"></i>
                        <span>4.8/5.0 (23 avaliações)</span>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-calendar-check"></i>
                        <span>ID: BK-001 | Última atualização: 10/08/2025</span>
                    </div>
                </div>
            </div>
            
            <!-- Status Atual -->
            <div class="current-status">
                <h3><i class="fas fa-info-circle"></i> Status Atual da Disponibilidade</h3>
                <div class="status-grid">
                    <div class="status-item">
                        <span class="status-value">Disponível</span>
                        <span class="status-label">Status Geral</span>
                    </div>
                    <div class="status-item">
                        <span class="status-value">23</span>
                        <span class="status-label">Dias Disponíveis</span>
                    </div>
                    <div class="status-item">
                        <span class="status-value">5</span>
                        <span class="status-label">Reservas Ativas</span>
                    </div>
                    <div class="status-item">
                        <span class="status-value">85%</span>
                        <span class="status-label">Taxa de Ocupação</span>
                    </div>
                </div>
            </div>
            
            <!-- Formulário de Disponibilidade -->
            <form class="availability-form" id="availabilityForm">
                <!-- Status Geral -->
                <div class="form-section">
                    <h3><i class="fas fa-toggle-on"></i> Status Geral</h3>
                    <div class="availability-status">
                        <div class="status-option available active" onclick="setStatus('available')">
                            <i class="fas fa-check-circle" style="font-size: 2rem; color: #28a745; margin-bottom: 0.5rem;"></i>
                            <div style="font-weight: bold;">Disponível</div>
                            <div style="font-size: 0.9rem; color: #6c757d;">Aceita novas reservas</div>
                        </div>
                        <div class="status-option unavailable" onclick="setStatus('unavailable')">
                            <i class="fas fa-times-circle" style="font-size: 2rem; color: #dc3545; margin-bottom: 0.5rem;"></i>
                            <div style="font-weight: bold;">Indisponível</div>
                            <div style="font-size: 0.9rem; color: #6c757d;">Não aceita reservas</div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="statusReason">Motivo (se indisponível):</label>
                        <select id="statusReason" name="statusReason">
                            <option value="">Selecione o motivo</option>
                            <option value="manutencao">Manutenção</option>
                            <option value="uso_pessoal">Uso pessoal</option>
                            <option value="reparo">Em reparo</option>
                            <option value="viagem">Viagem</option>
                            <option value="outro">Outro motivo</option>
                        </select>
                    </div>
                </div>
                
                <!-- Período Específico -->
                <div class="form-section">
                    <h3><i class="fas fa-calendar-week"></i> Período Específico</h3>
                    <div class="form-group">
                        <label for="startDate">Data de Início:</label>
                        <input type="date" id="startDate" name="startDate" value="2025-08-15">
                    </div>
                    <div class="form-group">
                        <label for="endDate">Data de Fim:</label>
                        <input type="date" id="endDate" name="endDate" value="2025-09-15">
                    </div>
                    <div class="form-group">
                        <label for="periodType">Tipo de Período:</label>
                        <select id="periodType" name="periodType">
                            <option value="disponivel">Disponível neste período</option>
                            <option value="indisponivel">Indisponível neste período</option>
                            <option value="promocao">Período promocional</option>
                        </select>
                    </div>
                </div>
                
                <!-- Horários -->
                <div class="form-section">
                    <h3><i class="fas fa-clock"></i> Horários de Disponibilidade</h3>
                    <div class="form-group">
                        <label for="startTime">Horário de Início:</label>
                        <input type="time" id="startTime" name="startTime" value="06:00">
                    </div>
                    <div class="form-group">
                        <label for="endTime">Horário de Fim:</label>
                        <input type="time" id="endTime" name="endTime" value="22:00">
                    </div>
                    <div class="form-group">
                        <label>Dias da Semana:</label>
                        <div class="checkbox-group">
                            <div class="checkbox-item">
                                <input type="checkbox" id="seg" name="weekdays" value="segunda" checked>
                                <label for="seg">Segunda</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="ter" name="weekdays" value="terca" checked>
                                <label for="ter">Terça</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="qua" name="weekdays" value="quarta" checked>
                                <label for="qua">Quarta</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="qui" name="weekdays" value="quinta" checked>
                                <label for="qui">Quinta</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="sex" name="weekdays" value="sexta" checked>
                                <label for="sex">Sexta</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="sab" name="weekdays" value="sabado" checked>
                                <label for="sab">Sábado</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="dom" name="weekdays" value="domingo">
                                <label for="dom">Domingo</label>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Condições de Uso -->
                <div class="form-section">
                    <h3><i class="fas fa-cogs"></i> Condições de Uso</h3>
                    <div class="form-group">
                        <label for="minRental">Período Mínimo de Aluguel:</label>
                        <select id="minRental" name="minRental">
                            <option value="1">1 dia</option>
                            <option value="2">2 dias</option>
                            <option value="3">3 dias</option>
                            <option value="7">1 semana</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="maxRental">Período Máximo de Aluguel:</label>
                        <select id="maxRental" name="maxRental">
                            <option value="7">1 semana</option>
                            <option value="14">2 semanas</option>
                            <option value="30" selected>1 mês</option>
                            <option value="0">Sem limite</option>
                        </select>
                    </div>
                </div>
                
                <!-- Regras Especiais -->
                <div class="form-section">
                    <h3><i class="fas fa-cogs"></i> Regras Especiais</h3>
                    <div class="form-group">
                        <label>Condições Especiais:</label>
                        <div class="checkbox-group">
                            <div class="checkbox-item">
                                <input type="checkbox" id="autoApproval" name="specialRules" value="auto_approval">
                                <label for="autoApproval">Aprovação Automática</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="instantBooking" name="specialRules" value="instant_booking" checked>
                                <label for="instantBooking">Reserva Instantânea</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="flexibleCancel" name="specialRules" value="flexible_cancel">
                                <label for="flexibleCancel">Cancelamento Flexível</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="verifiedOnly" name="specialRules" value="verified_only">
                                <label for="verifiedOnly">Apenas Usuários Verificados</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="specialNotes">Observações Especiais:</label>
                        <textarea id="specialNotes" name="specialNotes" rows="3" placeholder="Ex: Capacete incluído, entrega em pontos específicos, etc.">Capacete e cadeado inclusos. Possível entrega em estações de metrô da Linha Amarela.</textarea>
                    </div>
                </div>
                
                <!-- Calendário Visual (próximos 30 dias) -->
                <div class="form-section" style="grid-column: 1 / -1;">
                    <h3><i class="fas fa-calendar"></i> Calendário de Disponibilidade (Próximos 30 Dias)</h3>
                    <div class="calendar-grid" id="calendar">
                        <!-- Headers -->
                        <div class="calendar-day header">Dom</div>
                        <div class="calendar-day header">Seg</div>
                        <div class="calendar-day header">Ter</div>
                        <div class="calendar-day header">Qua</div>
                        <div class="calendar-day header">Qui</div>
                        <div class="calendar-day header">Sex</div>
                        <div class="calendar-day header">Sáb</div>
                        
                        <!-- Dias do mês (exemplo) -->
                        <div class="calendar-day available" onclick="toggleDay(this)">15</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">16</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">17</div>
                        <div class="calendar-day reserved">18</div>
                        <div class="calendar-day reserved">19</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">20</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">21</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">22</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">23</div>
                        <div class="calendar-day unavailable" onclick="toggleDay(this)">24</div>
                        <div class="calendar-day unavailable" onclick="toggleDay(this)">25</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">26</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">27</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">28</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">29</div>
                        <div class="calendar-day reserved">30</div>
                        <div class="calendar-day reserved">31</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">1</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">2</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">3</div>
                        <div class="calendar-day available" onclick="toggleDay(this)">4</div>
                    </div>
                    <div style="margin-top: 1rem; display: flex; justify-content: center; gap: 2rem; font-size: 0.9rem;">
                        <span><span style="display: inline-block; width: 20px; height: 20px; background: #d4edda; border-radius: 3px; margin-right: 0.5rem;"></span>Disponível</span>
                        <span><span style="display: inline-block; width: 20px; height: 20px; background: #f8d7da; border-radius: 3px; margin-right: 0.5rem;"></span>Indisponível</span>
                        <span><span style="display: inline-block; width: 20px; height: 20px; background: #fff3cd; border-radius: 3px; margin-right: 0.5rem;"></span>Reservado</span>
                    </div>
                </div>
                
                <!-- Botões de Ação -->
                <div class="submit-section">
                    <button type="button" onclick="previewChanges()" style="background: #17a2b8; color: white; padding: 0.8rem 2rem; border: none; border-radius: 8px; margin-right: 1rem;">
                        <i class="fas fa-eye"></i> Visualizar Alterações
                    </button>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-save"></i> Salvar Disponibilidade
                    </button>
                    <button type="button" onclick="resetToDefaults()" style="background: #6c757d; color: white; padding: 0.8rem 2rem; border: none; border-radius: 8px; margin-left: 1rem;">
                        <i class="fas fa-undo"></i> Restaurar Padrões
                    </button>
                </div>
            </form>
        </div>
        
        <div class="back-button">
            <a href="<%=request.getContextPath()%>/pages/bicicletasLocador.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Voltar para Minhas Bicicletas
            </a>
        </div>
    </div>
    
    <footer>
        <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
    </footer>
    
    <script>
        let currentStatus = 'available';
        
        function setStatus(status) {
            currentStatus = status;
            
            // Update visual status
            document.querySelectorAll('.status-option').forEach(option => {
                option.classList.remove('active');
            });
            
            if (status === 'available') {
                document.querySelector('.status-option.available').classList.add('active');
                document.getElementById('statusReason').value = '';
                document.getElementById('statusReason').disabled = true;
            } else {
                document.querySelector('.status-option.unavailable').classList.add('active');
                document.getElementById('statusReason').disabled = false;
            }
        }
        
        function toggleDay(dayElement) {
            if (dayElement.classList.contains('reserved')) {
                return; // Can't modify reserved days
            }
            
            if (dayElement.classList.contains('available')) {
                dayElement.classList.remove('available');
                dayElement.classList.add('unavailable');
            } else if (dayElement.classList.contains('unavailable')) {
                dayElement.classList.remove('unavailable');
                dayElement.classList.add('available');
            }
        }
        
        function previewChanges() {
            const formData = new FormData(document.getElementById('availabilityForm'));
            const data = Object.fromEntries(formData);
            
            let preview = 'Resumo das Alterações:\n\n';
            preview += 'Status Geral: ' + (currentStatus === 'available' ? 'Disponível' : 'Indisponível') + '\n';
            preview += 'Período: ' + data.startDate + ' até ' + data.endDate + '\n';
            preview += 'Horário: ' + data.startTime + ' às ' + data.endTime + '\n';
            preview += 'Período Mínimo: ' + data.minRental + ' dia(s)\n';
            preview += 'Período Máximo: ' + (data.maxRental == '0' ? 'Sem limite' : data.maxRental + ' dia(s)') + '\n';
            
            const weekdays = Array.from(document.querySelectorAll('input[name="weekdays"]:checked')).map(cb => cb.nextElementSibling.textContent);
            preview += 'Dias da Semana: ' + weekdays.join(', ') + '\n';
            
            const specialRules = Array.from(document.querySelectorAll('input[name="specialRules"]:checked')).map(cb => cb.nextElementSibling.textContent);
            if (specialRules.length > 0) {
                preview += 'Regras Especiais: ' + specialRules.join(', ') + '\n';
            }
            
            if (data.specialNotes) {
                preview += 'Observações: ' + data.specialNotes + '\n';
            }
            
            alert(preview);
        }
        
        function resetToDefaults() {
            if (confirm('Tem certeza que deseja restaurar as configurações padrão?')) {
                // Reset form to defaults
                document.getElementById('availabilityForm').reset();
                setStatus('available');
                
                // Reset checkboxes to default state
                document.querySelectorAll('input[name="weekdays"]').forEach(cb => {
                    cb.checked = cb.value !== 'domingo';
                });
                
                document.getElementById('instantBooking').checked = true;
                
                alert('Configurações restauradas para os padrões.');
            }
        }
        
        // Form submission
        document.getElementById('availabilityForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            
            // Validate required fields
            if (!formData.get('startDate') || !formData.get('endDate')) {
                alert('Por favor, selecione as datas de início e fim.');
                return;
            }
            
            if (!formData.get('startTime') || !formData.get('endTime')) {
                alert('Por favor, defina os horários de disponibilidade.');
                return;
            }
            
            const weekdaysSelected = document.querySelectorAll('input[name="weekdays"]:checked').length;
            if (weekdaysSelected === 0) {
                alert('Por favor, selecione pelo menos um dia da semana.');
                return;
            }
            
            // Simulate form submission
            const submitBtn = document.querySelector('.btn-submit');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Salvando...';
            submitBtn.disabled = true;
            
            setTimeout(() => {
                alert('Disponibilidade da bicicleta atualizada com sucesso!\n\nAs alterações já estão visíveis para os locatários.');
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            }, 2000);
        });
        
        // Initialize form
        document.addEventListener('DOMContentLoaded', function() {
            setStatus('available');
        });
    </script>
</body>
</html>