<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Disponibilidade - ShareBike</title>
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
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            color: #212529;
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
            border-color: #ffc107;
            box-shadow: 0 0 0 3px rgba(255, 193, 7, 0.1);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .calendar-container {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .calendar-nav {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        
        .nav-btn {
            background: #ffc107;
            color: #212529;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .nav-btn:hover {
            background: #e0a800;
            transform: translateY(-1px);
        }
        
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 0.5rem;
            text-align: center;
        }
        
        .calendar-header-day {
            font-weight: 600;
            color: #666;
            padding: 1rem 0.5rem;
            background: #e9ecef;
            border-radius: 8px;
        }
        
        .calendar-day {
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            font-weight: 500;
        }
        
        .calendar-day:hover {
            background: #fff3cd;
            transform: scale(1.05);
        }
        
        .calendar-day.today {
            background: #ffc107;
            color: #212529;
            font-weight: bold;
        }
        
        .calendar-day.available {
            background: #d4edda;
            color: #28a745;
        }
        
        .calendar-day.unavailable {
            background: #f8d7da;
            color: #dc3545;
        }
        
        .calendar-day.reserved {
            background: #fff3cd;
            color: #856404;
        }
        
        .calendar-day.selected {
            background: #007bff;
            color: white;
            box-shadow: 0 0 0 2px #007bff;
        }
        
        .calendar-day.disabled {
            background: #e9ecef;
            color: #6c757d;
            cursor: not-allowed;
        }
        
        .time-slots {
            margin-top: 2rem;
        }
        
        .time-slots-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 0.5rem;
        }
        
        .time-slot {
            padding: 0.8rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }
        
        .time-slot:hover {
            border-color: #ffc107;
            background: #fff3cd;
        }
        
        .time-slot.available {
            border-color: #28a745;
            background: #d4edda;
            color: #28a745;
        }
        
        .time-slot.unavailable {
            border-color: #dc3545;
            background: #f8d7da;
            color: #dc3545;
            cursor: not-allowed;
        }
        
        .time-slot.selected {
            border-color: #007bff;
            background: #007bff;
            color: white;
        }
        
        .availability-legend {
            display: flex;
            gap: 2rem;
            justify-content: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .legend-color {
            width: 20px;
            height: 20px;
            border-radius: 4px;
        }
        
        .quick-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }
        
        .quick-btn {
            background: #6c757d;
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .quick-btn:hover {
            background: #5a6268;
            transform: translateY(-1px);
        }
        
        .quick-btn.primary {
            background: #007bff;
        }
        
        .quick-btn.primary:hover {
            background: #0056b3;
        }
        
        .quick-btn.success {
            background: #28a745;
        }
        
        .quick-btn.success:hover {
            background: #1e7e34;
        }
        
        .quick-btn.danger {
            background: #dc3545;
        }
        
        .quick-btn.danger:hover {
            background: #c82333;
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
            background: linear-gradient(135deg, #ffc107, #e0a800);
            color: #212529;
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
        
        .status-partial {
            background: #fff3cd;
            color: #856404;
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
        
        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .reservation-info {
            background: #e3f2fd;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
        }
        
        .reservation-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid #dee2e6;
        }
        
        .reservation-item:last-child {
            border-bottom: none;
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
            <p>Gerencie a disponibilidade da bicicleta: Bike Speed Pro 2024</p>
        </div>
        
        <!-- Status Atual -->
        <div class="form-container">
            <div class="status-indicator status-partial">
                <i class="fas fa-clock"></i>
                Disponibilidade Parcial - 15 dias livres este mês
            </div>
            
            <div class="alert alert-info">
                <i class="fas fa-info-circle"></i>
                <span>Clique nos dias do calendário para definir disponibilidade. Use as ações rápidas para configurações em lote.</span>
            </div>
        </div>
        
        <!-- Ações Rápidas -->
        <div class="form-container">
            <h3 class="section-title">
                <i class="fas fa-bolt"></i>
                Ações Rápidas
            </h3>
            
            <div class="quick-actions">
                <button class="quick-btn success" onclick="disponibilizarMes()">
                    <i class="fas fa-check"></i> Disponível Todo o Mês
                </button>
                
                <button class="quick-btn primary" onclick="disponibilizarFDS()">
                    <i class="fas fa-calendar-week"></i> Apenas Fins de Semana
                </button>
                
                <button class="quick-btn" onclick="disponibilizarDias()">
                    <i class="fas fa-sun"></i> Apenas Dias Úteis
                </button>
                
                <button class="quick-btn danger" onclick="indisponibilizarMes()">
                    <i class="fas fa-times"></i> Indisponível Todo o Mês
                </button>
            </div>
            
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Atenção: Dias com reservas confirmadas não podem ser alterados para indisponível.</span>
            </div>
        </div>
        
        <!-- Calendário -->
        <div class="calendar-container">
            <div class="calendar-header">
                <h3>Janeiro 2025</h3>
                <div class="calendar-nav">
                    <button class="nav-btn" onclick="mesAnterior()">
                        <i class="fas fa-chevron-left"></i> Anterior
                    </button>
                    <button class="nav-btn" onclick="hoje()">Hoje</button>
                    <button class="nav-btn" onclick="proximoMes()">
                        Próximo <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
            
            <!-- Legenda -->
            <div class="availability-legend">
                <div class="legend-item">
                    <div class="legend-color" style="background: #d4edda;"></div>
                    <span>Disponível</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color" style="background: #f8d7da;"></div>
                    <span>Indisponível</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color" style="background: #fff3cd;"></div>
                    <span>Reservado</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color" style="background: #ffc107;"></div>
                    <span>Hoje</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color" style="background: #e9ecef;"></div>
                    <span>Passado</span>
                </div>
            </div>
            
            <!-- Grade do Calendário -->
            <div class="calendar-grid">
                <!-- Cabeçalho dos dias -->
                <div class="calendar-header-day">Dom</div>
                <div class="calendar-header-day">Seg</div>
                <div class="calendar-header-day">Ter</div>
                <div class="calendar-header-day">Qua</div>
                <div class="calendar-header-day">Qui</div>
                <div class="calendar-header-day">Sex</div>
                <div class="calendar-header-day">Sáb</div>
                
                <!-- Dias do mês (dados estáticos para Janeiro 2025) -->
                <!-- Primeira semana -->
                <div class="calendar-day disabled"></div>
                <div class="calendar-day disabled"></div>
                <div class="calendar-day disabled"></div>
                <div class="calendar-day available" onclick="toggleDia(1)" data-dia="1">1</div>
                <div class="calendar-day available" onclick="toggleDia(2)" data-dia="2">2</div>
                <div class="calendar-day unavailable" onclick="toggleDia(3)" data-dia="3">3</div>
                <div class="calendar-day available" onclick="toggleDia(4)" data-dia="4">4</div>
                
                <!-- Segunda semana -->
                <div class="calendar-day available" onclick="toggleDia(5)" data-dia="5">5</div>
                <div class="calendar-day reserved" onclick="verReserva(6)" data-dia="6">6</div>
                <div class="calendar-day today" onclick="toggleDia(7)" data-dia="7">7</div>
                <div class="calendar-day available" onclick="toggleDia(8)" data-dia="8">8</div>
                <div class="calendar-day unavailable" onclick="toggleDia(9)" data-dia="9">9</div>
                <div class="calendar-day available" onclick="toggleDia(10)" data-dia="10">10</div>
                <div class="calendar-day available" onclick="toggleDia(11)" data-dia="11">11</div>
                
                <!-- Terceira semana -->
                <div class="calendar-day reserved" onclick="verReserva(12)" data-dia="12">12</div>
                <div class="calendar-day available" onclick="toggleDia(13)" data-dia="13">13</div>
                <div class="calendar-day available" onclick="toggleDia(14)" data-dia="14">14</div>
                <div class="calendar-day reserved" onclick="verReserva(15)" data-dia="15">15</div>
                <div class="calendar-day available" onclick="toggleDia(16)" data-dia="16">16</div>
                <div class="calendar-day unavailable" onclick="toggleDia(17)" data-dia="17">17</div>
                <div class="calendar-day available" onclick="toggleDia(18)" data-dia="18">18</div>
                
                <!-- Quarta semana -->
                <div class="calendar-day available" onclick="toggleDia(19)" data-dia="19">19</div>
                <div class="calendar-day available" onclick="toggleDia(20)" data-dia="20">20</div>
                <div class="calendar-day reserved" onclick="verReserva(21)" data-dia="21">21</div>
                <div class="calendar-day available" onclick="toggleDia(22)" data-dia="22">22</div>
                <div class="calendar-day available" onclick="toggleDia(23)" data-dia="23">23</div>
                <div class="calendar-day unavailable" onclick="toggleDia(24)" data-dia="24">24</div>
                <div class="calendar-day available" onclick="toggleDia(25)" data-dia="25">25</div>
                
                <!-- Quinta semana -->
                <div class="calendar-day available" onclick="toggleDia(26)" data-dia="26">26</div>
                <div class="calendar-day available" onclick="toggleDia(27)" data-dia="27">27</div>
                <div class="calendar-day available" onclick="toggleDia(28)" data-dia="28">28</div>
                <div class="calendar-day reserved" onclick="verReserva(29)" data-dia="29">29</div>
                <div class="calendar-day available" onclick="toggleDia(30)" data-dia="30">30</div>
                <div class="calendar-day available" onclick="toggleDia(31)" data-dia="31">31</div>
                <div class="calendar-day disabled"></div>
            </div>
        </div>
        
        <!-- Formulário de Configuração Detalhada -->
        <form action="../DisponibilidadeController" method="post">
            <input type="hidden" name="action" value="editar">
            <input type="hidden" name="idBicicleta" value="1">
            
            <div class="form-container">
                <!-- Horários Específicos para Dia Selecionado -->
                <div class="form-section" id="timeSection" style="display: none;">
                    <h3 class="section-title">
                        <i class="fas fa-clock"></i>
                        Horários Específicos - <span id="selectedDate">Selecione um dia</span>
                    </h3>
                    
                    <div class="time-slots">
                        <div class="time-slots-grid">
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="06:00">06:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="07:00">07:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="08:00">08:00</div>
                            <div class="time-slot unavailable" onclick="toggleHorario(this)" data-horario="09:00">09:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="10:00">10:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="11:00">11:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="12:00">12:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="13:00">13:00</div>
                            <div class="time-slot unavailable" onclick="toggleHorario(this)" data-horario="14:00">14:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="15:00">15:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="16:00">16:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="17:00">17:00</div>
                            <div class="time-slot unavailable" onclick="toggleHorario(this)" data-horario="18:00">18:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="19:00">19:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="20:00">20:00</div>
                            <div class="time-slot available" onclick="toggleHorario(this)" data-horario="21:00">21:00</div>
                        </div>
                    </div>
                </div>
                
                <!-- Configurações Gerais -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-cogs"></i>
                        Configurações Gerais
                    </h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="horarioInicio">
                                <i class="fas fa-play"></i>
                                Horário de Início Padrão
                            </label>
                            <input type="time" id="horarioInicio" name="horarioInicio" value="06:00">
                        </div>
                        
                        <div class="form-group">
                            <label for="horarioFim">
                                <i class="fas fa-stop"></i>
                                Horário de Fim Padrão
                            </label>
                            <input type="time" id="horarioFim" name="horarioFim" value="22:00">
                        </div>
                        
                        <div class="form-group">
                            <label for="intervaloMinimo">
                                <i class="fas fa-hourglass-half"></i>
                                Intervalo Mínimo (horas)
                            </label>
                            <select id="intervaloMinimo" name="intervaloMinimo">
                                <option value="1" selected>1 hora</option>
                                <option value="2">2 horas</option>
                                <option value="3">3 horas</option>
                                <option value="4">4 horas</option>
                                <option value="6">6 horas</option>
                                <option value="8">8 horas</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="antecedenciaMinima">
                                <i class="fas fa-calendar-check"></i>
                                Antecedência Mínima (horas)
                            </label>
                            <select id="antecedenciaMinima" name="antecedenciaMinima">
                                <option value="1">1 hora</option>
                                <option value="2" selected>2 horas</option>
                                <option value="4">4 horas</option>
                                <option value="12">12 horas</option>
                                <option value="24">24 horas</option>
                            </select>
                        </div>
                    </div>
                </div>
                
                <!-- Reservas Existentes -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-calendar-check"></i>
                        Reservas Existentes
                    </h3>
                    
                    <div class="reservation-info">
                        <div class="reservation-item">
                            <div>
                                <strong>6 de Janeiro</strong> - 09:00 às 12:00<br>
                                <small>Cliente: João Silva</small>
                            </div>
                            <button type="button" class="quick-btn" onclick="verDetalhesReserva(1)">
                                <i class="fas fa-eye"></i> Ver
                            </button>
                        </div>
                        
                        <div class="reservation-item">
                            <div>
                                <strong>12 de Janeiro</strong> - 14:00 às 18:00<br>
                                <small>Cliente: Maria Costa</small>
                            </div>
                            <button type="button" class="quick-btn" onclick="verDetalhesReserva(2)">
                                <i class="fas fa-eye"></i> Ver
                            </button>
                        </div>
                        
                        <div class="reservation-item">
                            <div>
                                <strong>15 de Janeiro</strong> - 08:00 às 17:00<br>
                                <small>Cliente: Pedro Oliveira</small>
                            </div>
                            <button type="button" class="quick-btn" onclick="verDetalhesReserva(3)">
                                <i class="fas fa-eye"></i> Ver
                            </button>
                        </div>
                        
                        <div class="reservation-item">
                            <div>
                                <strong>21 de Janeiro</strong> - 10:00 às 16:00<br>
                                <small>Cliente: Ana Santos</small>
                            </div>
                            <button type="button" class="quick-btn" onclick="verDetalhesReserva(4)">
                                <i class="fas fa-eye"></i> Ver
                            </button>
                        </div>
                        
                        <div class="reservation-item">
                            <div>
                                <strong>29 de Janeiro</strong> - 07:00 às 19:00<br>
                                <small>Cliente: Carlos Lima</small>
                            </div>
                            <button type="button" class="quick-btn" onclick="verDetalhesReserva(5)">
                                <i class="fas fa-eye"></i> Ver
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Observações -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fas fa-sticky-note"></i>
                        Observações
                    </h3>
                    
                    <div class="form-group full-width">
                        <label for="observacoes">
                            <i class="fas fa-comment-alt"></i>
                            Observações sobre Disponibilidade
                        </label>
                        <textarea id="observacoes" name="observacoes" 
                                  placeholder="Adicione observações sobre a disponibilidade desta bicicleta...">Bicicleta disponível para aluguel durante a semana. Manutenção preventiva agendada para o dia 24. Horários de pico: 08:00-10:00 e 17:00-19:00.</textarea>
                    </div>
                </div>
            </div>
            
            <!-- Botões de Ação -->
            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i>
                    Salvar Disponibilidade
                </button>
                
                <button type="button" class="btn btn-success" onclick="aplicarPadrao()">
                    <i class="fas fa-magic"></i>
                    Aplicar Padrão
                </button>
                
                <a href="bicicletasAdm.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Voltar às Bicicletas
                </a>
            </div>
        </form>
    </div>

    <script>
        let selectedDay = null;
        
        function toggleDia(dia) {
            const dayElement = document.querySelector(`[data-dia="${dia}"]`);
            
            if (dayElement.classList.contains('reserved') || dayElement.classList.contains('disabled')) {
                return; // Não permite alterar dias reservados ou desabilitados
            }
            
            // Toggle entre disponível e indisponível
            if (dayElement.classList.contains('available')) {
                dayElement.classList.remove('available');
                dayElement.classList.add('unavailable');
            } else {
                dayElement.classList.remove('unavailable');
                dayElement.classList.add('available');
            }
            
            // Selecionar dia para configuração de horários
            if (selectedDay) {
                document.querySelector(`[data-dia="${selectedDay}"]`).classList.remove('selected');
            }
            
            selectedDay = dia;
            dayElement.classList.add('selected');
            
            // Mostrar seção de horários
            document.getElementById('timeSection').style.display = 'block';
            document.getElementById('selectedDate').textContent = `${dia} de Janeiro`;
            
            console.log(`Dia ${dia} selecionado`);
        }
        
        function toggleHorario(element) {
            if (element.classList.contains('unavailable')) {
                return; // Não permite alterar horários indisponíveis (ocupados)
            }
            
            element.classList.toggle('selected');
            const horario = element.getAttribute('data-horario');
            console.log(`Horário ${horario} ${element.classList.contains('selected') ? 'selecionado' : 'desmarcado'}`);
        }
        
        function verReserva(dia) {
            alert(`Visualizar reserva do dia ${dia} de Janeiro\n\nEste dia possui reservas confirmadas que não podem ser alteradas.`);
        }
        
        function verDetalhesReserva(id) {
            alert(`Visualizar detalhes da reserva #${id}\n\nAbrindo página de detalhes da reserva...`);
        }
        
        function disponibilizarMes() {
            if (confirm('Tornar toda a bicicleta disponível durante o mês de Janeiro?\n\nDias com reservas confirmadas não serão alterados.')) {
                document.querySelectorAll('.calendar-day:not(.reserved):not(.disabled)').forEach(day => {
                    day.classList.remove('unavailable');
                    day.classList.add('available');
                });
                alert('Mês configurado como disponível!');
            }
        }
        
        function disponibilizarFDS() {
            if (confirm('Tornar a bicicleta disponível apenas nos fins de semana?')) {
                // Lógica para configurar apenas fins de semana
                alert('Configurado para disponível apenas nos fins de semana!');
            }
        }
        
        function disponibilizarDias() {
            if (confirm('Tornar a bicicleta disponível apenas nos dias úteis?')) {
                // Lógica para configurar apenas dias úteis
                alert('Configurado para disponível apenas nos dias úteis!');
            }
        }
        
        function indisponibilizarMes() {
            if (confirm('Tornar toda a bicicleta indisponível durante o mês de Janeiro?\n\nDias com reservas confirmadas não serão alterados.')) {
                document.querySelectorAll('.calendar-day:not(.reserved):not(.disabled)').forEach(day => {
                    day.classList.remove('available');
                    day.classList.add('unavailable');
                });
                alert('Mês configurado como indisponível!');
            }
        }
        
        function mesAnterior() {
            alert('Carregando Dezembro 2024...');
            // Aqui seria a navegação real entre meses
        }
        
        function proximoMes() {
            alert('Carregando Fevereiro 2025...');
            // Aqui seria a navegação real entre meses
        }
        
        function hoje() {
            // Destacar dia atual
            document.querySelectorAll('.calendar-day').forEach(day => {
                day.classList.remove('selected');
            });
            document.querySelector('.today').classList.add('selected');
            selectedDay = 7; // Dia atual no exemplo
        }
        
        function aplicarPadrao() {
            if (confirm('Aplicar configuração padrão de disponibilidade?\n\nDisponível todos os dias das 06:00 às 22:00, exceto dias com reservas.')) {
                alert('Configuração padrão aplicada com sucesso!');
            }
        }
        
        console.log('Página de edição de disponibilidade carregada');
    </script>
</body>
</html>
