<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="br.com.sharebike.model.Usuario" %>
<%@ page import="br.com.sharebike.model.Reserva" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Análise para Ranking - ShareBike</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/admDetalhes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .back-button {
            background: linear-gradient(135deg, #6b7280, #4b5563);
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
            border: none;
            cursor: pointer;
        }
        
        .back-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-decoration: none;
            color: white;
        }
        
        .user-profile-header {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
            color: white;
            padding: 2.5rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .profile-info {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 1.5rem;
        }
        
        .user-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            font-weight: bold;
            border: 4px solid rgba(255, 255, 255, 0.3);
            flex-shrink: 0;
        }
        
        .user-details h1 {
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
            color: white;
        }
        
        .user-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            font-size: 1rem;
            opacity: 0.9;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .ranking-status {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }
        
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .status-eligible {
            background: #10b981;
            color: white;
        }
        
        .status-not-eligible {
            background: #ef4444;
            color: white;
        }
        
        .status-pending {
            background: #fbbf24;
            color: #1f2937;
        }
        
        .analysis-section {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .section-title {
            font-size: 1.5rem;
            color: #1f2937;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #38b2ac;
        }
        
        .criteria-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
        }
        
        .criteria-card {
            background: #f9fafb;
            padding: 1.5rem;
            border-radius: 12px;
            border-left: 4px solid #e5e7eb;
            transition: all 0.3s ease;
        }
        
        .criteria-card.met {
            border-left-color: #10b981;
            background: #ecfdf5;
        }
        
        .criteria-card.not-met {
            border-left-color: #ef4444;
            background: #fef2f2;
        }
        
        .criteria-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        
        .criteria-title {
            font-weight: 600;
            color: #1f2937;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .criteria-icon {
            font-size: 1.5rem;
        }
        
        .criteria-icon.met {
            color: #10b981;
        }
        
        .criteria-icon.not-met {
            color: #ef4444;
        }
        
        .criteria-details {
            color: #6b7280;
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .reservas-list {
            list-style: none;
            padding: 0;
            margin: 1rem 0 0 0;
        }
        
        .reserva-item {
            padding: 1rem;
            background: white;
            border-radius: 8px;
            margin-bottom: 0.8rem;
            border: 1px solid #e5e7eb;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .item-info h4 {
            margin: 0 0 0.3rem 0;
            color: #1f2937;
        }
        
        .item-info p {
            margin: 0;
            color: #6b7280;
            font-size: 0.9rem;
        }
        
        .item-status {
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .status-finalizada {
            background: #d1fae5;
            color: #10b981;
        }
        
        .summary-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .stat-item {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-top: 4px solid #38b2ac;
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: bold;
            color: #38b2ac;
            margin-bottom: 0.3rem;
        }
        
        .stat-label {
            color: #6b7280;
            font-size: 0.9rem;
        }
        
        .decision-section {
            background: linear-gradient(135deg, #f9fafb, #f3f4f6);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            margin-top: 2rem;
            border: 2px solid #38b2ac;
        }
        
        .decision-title {
            font-size: 1.8rem;
            color: #1f2937;
            margin-bottom: 1rem;
        }
        
        .decision-subtitle {
            color: #6b7280;
            margin-bottom: 2rem;
            font-size: 1.1rem;
        }
        
        .decision-buttons {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            text-decoration: none;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #10b981, #047857);
            color: white;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #6b7280, #4b5563);
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        
        .criteria-highlight {
            background: linear-gradient(135deg, #d1fae5, #bbf7d0);
            border: 1px solid #10b981;
            border-radius: 10px;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .criteria-highlight h4 {
            margin: 0 0 0.5rem 0;
            color: #047857;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .criteria-highlight p {
            margin: 0;
            color: #065f46;
            font-size: 0.9rem;
        }
        
        .user-type-badge {
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 500;
            display: inline-block;
        }
        
        .company-type {
            background: linear-gradient(135deg, #10b981, #047857);
        }
        
        @media (max-width: 768px) {
            .profile-info {
                flex-direction: column;
                text-align: center;
            }
            
            .criteria-grid {
                grid-template-columns: 1fr;
            }
            
            .decision-buttons {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <%
        Usuario usuario = (Usuario) request.getAttribute("Usuario");
        String origem = (String) request.getAttribute("origem");
        @SuppressWarnings("unchecked")
        List<Reserva> reservasFinalizadas = (List<Reserva>) request.getAttribute("listaReservasFinalizadas");
        
        if (usuario == null) {
    %>
        <div class="container">
            <div class="analysis-section">
                <h3>Erro: Usuário não encontrado</h3>
                <p>Não foi possível carregar os dados do usuário.</p>
                <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
                    <input type="hidden" name="action" value="aprovar-rank">
                    <button type="submit" class="back-button">
                        <i class="fas fa-arrow-left"></i> Voltar para Lista
                    </button>
                </form>
            </div>
        </div>
    <%
        } else {
            // Calcular iniciais do usuário
            String iniciais = "";
            if (usuario.getNomeRazaoSocial_user() != null && !usuario.getNomeRazaoSocial_user().trim().isEmpty()) {
                String[] nomes = usuario.getNomeRazaoSocial_user().trim().split(" ");
                iniciais += nomes[0].charAt(0);
                if (nomes.length > 1) {
                    iniciais += nomes[nomes.length - 1].charAt(0);
                }
                iniciais = iniciais.toUpperCase();
            }
                        
            // Verificar critérios de elegibilidade
            boolean temBicicletaPropria = (usuario.getFotoComprBike_user() != null && !usuario.getFotoComprBike_user().trim().isEmpty());
            boolean temReservasFinalizadas = (reservasFinalizadas != null && !reservasFinalizadas.isEmpty());
            boolean isEligible = temBicicletaPropria || temReservasFinalizadas;
            
            // Calcular estatísticas
            int totalReservas = reservasFinalizadas != null ? reservasFinalizadas.size() : 0;
            // Simulação de dados adicionais (em implementação real, estes viriam do banco)
            int kmPercorridos = totalReservas * 25; // Estimativa baseada nas reservas
    %>
    
    <div class="container">
        <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
            <input type="hidden" name="action" value="aprovar-rank">
            <button type="submit" class="back-button">
                <i class="fas fa-arrow-left"></i> Voltar para Lista
            </button>
        </form>
        
        <!-- Cabeçalho do Perfil do Usuário -->
        <div class="user-profile-header">
            <div class="profile-info">
                <div class="user-avatar"><%= iniciais %></div>
                <div class="user-details">
                    <h1><%= usuario.getNomeRazaoSocial_user() %></h1>
                    <div class="user-meta">
                        <div class="meta-item">
                            <i class="fas fa-envelope"></i>
                            <span><%= usuario.getEmail_user() %></span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-phone"></i>
                            <span><%= usuario.getTelefone_user() != null ? usuario.getTelefone_user() : "Não informado" %></span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span><%= usuario.getCidade_user() != null ? usuario.getCidade_user() + ", " + usuario.getEstado_user() : "Localização não informada" %></span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="ranking-status">
                <span><strong>Status no Ranking:</strong></span>
                <div class="status-badge <%= isEligible ? "status-pending" : "status-not-eligible" %>">
                    <i class="fas fa-<%= isEligible ? "clock" : "times" %>"></i>
                    <%= isEligible ? "Aguardando Aprovação" : "Não Elegível" %>
                </div>
            </div>
        </div>

        <!-- Resumo Estatístico -->
        <div class="summary-stats">
            <div class="stat-item">
                <div class="stat-value"><%= temBicicletaPropria ? "1" : "0" %></div>
                <div class="stat-label">Comprovante Enviado</div>
            </div>
            <div class="stat-item">
                <div class="stat-value"><%= totalReservas %></div>
                <div class="stat-label">Reservas Finalizadas</div>
            </div>
            <div class="stat-item">
                <div class="stat-value"><%= usuario.getAvaliacao_user() != null ? usuario.getAvaliacao_user() : "N/A" %></div>
                <div class="stat-label">Avaliação Média</div>
            </div>
        </div>

        <!-- Análise dos Critérios de Elegibilidade -->
        <div class="analysis-section">
            <h2 class="section-title">
                <i class="fas fa-clipboard-check"></i>
                Critérios de Elegibilidade para Ranking
            </h2>
            
            <div class="criteria-grid">
                <!-- Critério 1: Comprovante de Posse de Bicicleta -->
                <div class="criteria-card <%= temBicicletaPropria ? "met" : "not-met" %>">
                    <div class="criteria-header">
                        <div class="criteria-title">
                            <span>Comprovante de Posse de Bicicleta</span>
                        </div>
                        <div class="criteria-icon <%= temBicicletaPropria ? "met" : "not-met" %>">
                            <i class="fas fa-<%= temBicicletaPropria ? "check-circle" : "times-circle" %>"></i>
                        </div>
                    </div>
                    <div class="criteria-details">
                        <% if (temBicicletaPropria) { %>
                            <p><strong>Status:</strong> ✅ Comprovante enviado</p>
                            <p><strong>Arquivo:</strong> <%= usuario.getFotoComprBike_user() %></p>
                            <p><strong>Situação:</strong> Usuário possui bicicleta própria</p>
                            
                            <div class="criteria-highlight">
                                <h4><i class="fas fa-file-image"></i> Comprovante Anexado</h4>
                                <p>O usuário enviou comprovante que atesta a posse de bicicleta própria. Este critério qualifica o usuário para participação no ranking de sustentabilidade.</p>
                            </div>
                        <% } else { %>
                            <p><strong>Status:</strong> ❌ Comprovante não enviado</p>
                            <p><strong>Situação:</strong> Usuário não possui bicicleta própria cadastrada</p>
                            <p><strong>Observação:</strong> Para se qualificar por este critério, é necessário enviar comprovante de posse de bicicleta.</p>
                        <% } %>
                    </div>
                </div>

                <!-- Critério 2: Reservas Finalizadas -->
                <div class="criteria-card <%= temReservasFinalizadas ? "met" : "not-met" %>">
                    <div class="criteria-header">
                        <div class="criteria-title">
                            <span>Reservas Finalizadas</span>
                        </div>
                        <div class="criteria-icon <%= temReservasFinalizadas ? "met" : "not-met" %>">
                            <i class="fas fa-<%= temReservasFinalizadas ? "check-circle" : "times-circle" %>"></i>
                        </div>
                    </div>
                    <div class="criteria-details">
                        <% if (temReservasFinalizadas) { %>
                            <p><strong>Status:</strong> ✅ Possui reservas finalizadas</p>
                            <p><strong>Total de reservas:</strong> <%= totalReservas %></p>
                            <p>O usuário possui reservas finalizadas com sucesso:</p>
                            <ul class="reservas-list">
                                <% for (Reserva reserva : reservasFinalizadas) { %>
                                <li class="reserva-item">
                                    <div class="item-info">
                                        <h4>Reserva #<%= reserva.getId_reserv() %></h4>
                                        <p>Bike: <%= reserva.getBicicleta().getNome_bike() %> • Status: <%= reserva.getStatus_reserv() %></p>
                                    </div>
                                    <span class="item-status status-finalizada">Finalizada</span>
                                </li>
                                <% } %>
                            </ul>
                        <% } else { %>
                            <p><strong>Status:</strong> ❌ Sem reservas finalizadas</p>
                            <p><strong>Situação:</strong> Usuário ainda não possui reservas com status 'FINALIZADA'</p>
                            <p><strong>Observação:</strong> Para se qualificar por este critério, é necessário ter pelo menos uma reserva finalizada.</p>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Histórico de Atividades -->
        <div class="analysis-section">
            <h2 class="section-title">
                <i class="fas fa-history"></i>
                Perfil do Usuário
            </h2>
            
            <div class="criteria-grid">
                <!-- Informações Gerais -->
                <div class="criteria-card met">
                    <div class="criteria-header">
                        <div class="criteria-title">
                            <span>Informações Gerais</span>
                        </div>
                        <div class="criteria-icon met">
                            <i class="fas fa-user"></i>
                        </div>
                    </div>
                    <div class="criteria-details">
                        <p><strong>CPF/CNPJ:</strong> <%= usuario.getCpfCnpj_user() %></p>
                        <p><strong>Email:</strong> <%= usuario.getEmail_user() %></p>
                        <p><strong>Telefone:</strong> <%= usuario.getTelefone_user() != null ? usuario.getTelefone_user() : "Não informado" %></p>
                        <p><strong>Localização:</strong> <%= usuario.getCidade_user() != null ? usuario.getCidade_user() + "/" + usuario.getEstado_user() : "Não informada" %></p>
                    </div>
                </div>

                <!-- Status de Permissões -->
                <div class="criteria-card met">
                    <div class="criteria-header">
                        <div class="criteria-title">
                            <span>Status de Permissões</span>
                        </div>
                        <div class="criteria-icon met">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                    </div>
                    <div class="criteria-details">
                        <p><strong>Acesso à plataforma:</strong> 
                            <span style="color: <%= usuario.isPermissaoAcesso_user() ? "#10b981" : "#ef4444" %>;">
                                <%= usuario.isPermissaoAcesso_user() ? "✓ Liberado" : "❌ Pendente" %>
                            </span>
                        </p>
                        <p><strong>Participação no ranking:</strong> 
                            <span style="color: <%= usuario.isPermissaoRank_user() ? "#10b981" : "#f59e0b" %>;">
                                <%= usuario.isPermissaoRank_user() ? "✓ Aprovado" : "⏳ Pendente" %>
                            </span>
                        </p>
                        <% if (usuario.getAvaliacao_user() != null) { %>
                        <p><strong>Avaliação atual:</strong> 
                            <span style="color: #f59e0b;">
                                <i class="fas fa-star"></i> <%= String.format("%.1f", usuario.getAvaliacao_user()) %>/5.0
                            </span>
                        </p>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Conclusão da Análise e Decisão -->
        <div class="decision-section">
            <h2 class="decision-title">
                <i class="fas fa-gavel"></i>
                Decisão de Elegibilidade
            </h2>
            <% if (isEligible) { %>
                <p class="decision-subtitle">
                    Com base na análise dos critérios, este usuário <strong style="color: #10b981;">ATENDE</strong> aos requisitos para participação no ranking.<br>
                    <% if (temBicicletaPropria && temReservasFinalizadas) { %>
                        ✓ Enviou comprovante de posse de bicicleta E ✓ Possui reservas finalizadas
                    <% } else if (temBicicletaPropria) { %>
                        ✓ Enviou comprovante de posse de bicicleta própria
                    <% } else { %>
                        ✓ Possui reservas finalizadas no sistema
                    <% } %>
                </p>
            <% } else { %>
                <p class="decision-subtitle">
                    Com base na análise dos critérios, este usuário <strong style="color: #ef4444;">NÃO ATENDE</strong> aos requisitos para participação no ranking.<br>
                    ❌ Não enviou comprovante de bicicleta E ❌ Não possui reservas finalizadas
                </p>
            <% } %>
            
            <div class="decision-buttons">
                <% if (isEligible) { %>
                    <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
                        <input type="hidden" name="action" value="aprovar-rank-usuario">
                        <input type="hidden" name="cpfCnpj" value="<%= usuario.getCpfCnpj_user() %>">
                        <button type="submit" class="btn btn-success" onclick="return confirm('Confirma a aprovação deste usuário para participar do ranking?');">
                            <i class="fas fa-check"></i>
                            Aprovar para Ranking
                        </button>
                    </form>
                    
                    <!-- Botão de negar só aparece se o usuário tem bicicleta própria (pode remover comprovante) -->
                    <% if (temBicicletaPropria) { %>
                        <form action="<%=request.getContextPath()%>/UsuarioController" method="post" style="display: inline-block;">
                            <input type="hidden" name="action" value="negar-ranking">
                            <input type="hidden" name="cpfCnpj" value="<%= usuario.getCpfCnpj_user() %>">
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Tem certeza que deseja negar a participação no ranking?\\n\\nEsta ação irá:\\n• Remover o comprovante de bicicleta\\n• Impedir participação no ranking\\n• Usuário precisará enviar novo comprovante');">
                                <i class="fas fa-times"></i>
                                Negar Participação
                            </button>
                        </form>
                    <% } %>
                <% } else { %>
                    <button class="btn btn-secondary" disabled>
                        <i class="fas fa-info-circle"></i>
                        Usuário Não Elegível
                    </button>
                <% } %>
            </div>
        </div>
    </div>
    <% } %>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Análise de perfil para ranking carregada');
            
            // Adicionar efeitos visuais nos cards
            const cards = document.querySelectorAll('.criteria-card');
            cards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
            
            // Animação dos contadores estatísticos
            animateCounters();
        });
        
        // Animação dos contadores estatísticos
        function animateCounters() {
            const counters = document.querySelectorAll('.stat-value');
            
            counters.forEach(counter => {
                const target = parseFloat(counter.textContent);
                if (isNaN(target)) return;
                
                const increment = target / 30;
                let current = 0;
                
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= target) {
                        counter.textContent = target % 1 === 0 ? target : target.toFixed(1);
                        clearInterval(timer);
                    } else {
                        counter.textContent = current % 1 === 0 ? Math.floor(current) : current.toFixed(1);
                    }
                }, 50);
            });
        }
    </script>
</body>
</html>