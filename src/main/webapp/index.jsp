<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%
    // Obter estatísticas do contexto da aplicação (carregadas pelo WebListener)
    Integer bicicletasCompartilhadasObj = (Integer) application.getAttribute("bicicletasCompartilhadas");
    Integer usuariosSatisfeitosObj = (Integer) application.getAttribute("usuariosSatisfeitos");
    Float kmPedaladosObj = (Float) application.getAttribute("kmPedalados");
    
    // Valores padrão caso os atributos não existam
    int bicicletasCompartilhadas = bicicletasCompartilhadasObj != null ? bicicletasCompartilhadasObj : 0;
    int usuariosSatisfeitos = usuariosSatisfeitosObj != null ? usuariosSatisfeitosObj : 0;
    float kmPedalados = kmPedaladosObj != null ? kmPedaladosObj : 0.0f;
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShareBike - Compartilhamento de Bicicletas Sustentável</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" type="text/css" media="all">
    <style>
        .hero-gradient {
            background: linear-gradient(135deg, #38b2ac 0%, #0d9488 50%, #047857 100%);
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="font-sans bg-gray-50">
    <!-- Navigation -->
    <nav class="bg-white shadow-md sticky top-0 z-40">
        <div class="container mx-auto px-4 py-3 flex justify-between items-center">
            <div class="flex items-center space-x-2">
                <i class="fas fa-bicycle text-teal-600 text-2xl"></i>
                <span class="text-xl font-bold text-teal-800">ShareBike</span>
            </div>
            <div class="hidden md:flex space-x-6">
                <a href="#features" class="text-gray-600 hover:text-teal-600 transition">Recursos</a>
                <a href="#how-it-works" class="text-gray-600 hover:text-teal-600 transition">Como Funciona</a>
                <a href="#footer" class="text-gray-600 hover:text-teal-600 transition">Sobre</a>
                <a href="#footer" class="text-gray-600 hover:text-teal-600 transition">Contato</a>
            </div>
            <div class="flex items-center space-x-4">
                <a href="pages/loginUsuario.jsp" class="px-4 py-2 text-teal-600 border border-teal-600 rounded-lg hover:bg-teal-50 transition">Entrar</a>
                <a href="pages/cadastroUsuario.jsp" class="px-4 py-2 bg-teal-600 text-white rounded-lg hover:bg-teal-700 transition">Cadastrar</a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-gradient text-white py-20">
        <div class="container mx-auto px-4 flex flex-col md:flex-row items-center">
            <div class="md:w-1/2 mb-10 md:mb-0">
                <h1 class="text-4xl md:text-5xl font-bold mb-6">Pedale, compartilhe, transforme!</h1>
                <p class="text-xl mb-8">O ShareBike conecta pessoas que precisam de transporte com bicicletas disponíveis em sua comunidade, promovendo mobilidade sustentável e inclusão social.</p>
                <div class="flex space-x-4">
                    <a href="pages/cadastroUsuario.jsp" class="px-6 py-3 bg-white text-teal-700 font-semibold rounded-lg hover:bg-gray-100 transition">Comece agora</a>
                    <a href="pages/loginUsuario.jsp" class="px-6 py-3 border border-white text-white font-semibold rounded-lg hover:bg-white hover:bg-opacity-10 transition">Entrar</a>
                </div>
            </div>
            <div class="md:w-1/2 flex justify-center">
                <img src="https://images.unsplash.com/photo-1511994298241-608e28f14fde?auto=format&fit=crop&w=1470&q=80" 
                     alt="Pessoas pedalando juntas" 
                     class="rounded-lg shadow-2xl max-w-md w-full">
            </div>
        </div>
    </section>

     <!-- Stats Section -->
    <section class="bg-white py-12">
        <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
                <div class="p-6 rounded-lg bg-gray-50">
                    <div class="text-4xl font-bold text-teal-600 mb-2">
                        <%=String.format("%,d", bicicletasCompartilhadas)%>
                    </div>
                    <div class="text-gray-600">Bicicletas compartilhadas</div>
                </div>
                <div class="p-6 rounded-lg bg-gray-50">
                    <div class="text-4xl font-bold text-teal-600 mb-2">
                        <%=String.format("%,d", usuariosSatisfeitos)%>
                    </div>
                    <div class="text-gray-600">Usuários satisfeitos</div>
                </div>
                <div class="p-6 rounded-lg bg-gray-50">
                    <div class="text-4xl font-bold text-teal-600 mb-2">
                        <%=String.format("%,.0f", kmPedalados)%>
                    </div>
                    <div class="text-gray-600">Km pedalados</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-20 bg-gray-50">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-4 text-gray-800">Nossos Recursos</h2>
            <p class="text-xl text-center mb-12 text-gray-600 max-w-3xl mx-auto">Tudo que você precisa para uma experiência completa de compartilhamento de bicicletas</p>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Feature 1 -->
                <div class="feature-card bg-white p-8 rounded-lg shadow-md transition duration-300">
                    <div class="w-14 h-14 bg-teal-100 rounded-full flex items-center justify-center mb-6">
                        <i class="fas fa-list text-teal-600 text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-800">Lista de Bicicletas</h3>
                    <p class="text-gray-600">Veja todas as bicicletas disponíveis em uma lista organizada e filtrada.</p>
                </div>
                
                <!-- Feature 2 -->
                <div class="feature-card bg-white p-8 rounded-lg shadow-md transition duration-300">
                    <div class="w-14 h-14 bg-teal-100 rounded-full flex items-center justify-center mb-6">
                        <i class="fas fa-calendar-check text-teal-600 text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-800">Reservas Flexíveis</h3>
                    <p class="text-gray-600">Reserve bicicletas com antecedência de acordo com sua disponibilidade.</p>
                </div>
                
                <!-- Feature 3 -->
                <div class="feature-card bg-white p-8 rounded-lg shadow-md transition duration-300">
                    <div class="w-14 h-14 bg-teal-100 rounded-full flex items-center justify-center mb-6">
                        <i class="fas fa-star text-teal-600 text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-800">Sistema de Avaliação</h3>
                    <p class="text-gray-600">Avalie e seja avaliado para manter a comunidade segura e confiável.</p>
                </div>
                
                <!-- Feature 4 -->
                <div class="feature-card bg-white p-8 rounded-lg shadow-md transition duration-300">
                    <div class="w-14 h-14 bg-teal-100 rounded-full flex items-center justify-center mb-6">
                        <i class="fas fa-trophy text-teal-600 text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-800">Rankings Motivadores</h3>
                    <p class="text-gray-600">Ganhe pontos por km pedalado e dispute os primeiros lugares nos rankings.</p>
                </div>
                
                <!-- Feature 5 -->
                <div class="feature-card bg-white p-8 rounded-lg shadow-md transition duration-300">
                    <div class="w-14 h-14 bg-teal-100 rounded-full flex items-center justify-center mb-6">
                        <i class="fas fa-shield-alt text-teal-600 text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-800">Segurança Garantida</h3>
                    <p class="text-gray-600">Todos os usuários são verificados para sua tranquilidade.</p>
                </div>
                
                <!-- Feature 6 -->
                <div class="feature-card bg-white p-8 rounded-lg shadow-md transition duration-300">
                    <div class="w-14 h-14 bg-teal-100 rounded-full flex items-center justify-center mb-6">
                        <i class="fas fa-leaf text-teal-600 text-2xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-800">Impacto Sustentável</h3>
                    <p class="text-gray-600">Contribua para um planeta mais verde reduzindo emissões de CO₂.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="py-20 bg-white">
        <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold text-center mb-4 text-gray-800">Como Funciona</h2>
            <p class="text-xl text-center mb-12 text-gray-600 max-w-3xl mx-auto">Em poucos passos você pode começar a pedalar ou compartilhar sua bicicleta</p>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Step 1 -->
                <div class="text-center">
                    <div class="w-20 h-20 bg-teal-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <span class="text-2xl font-bold text-teal-600">1</span>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-800">Cadastre-se</h3>
                    <p class="text-gray-600">Crie sua conta como locador ou locatário e aguarde a aprovação.</p>
                </div>
                
                <!-- Step 2 -->
                <div class="text-center">
                    <div class="w-20 h-20 bg-teal-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <span class="text-2xl font-bold text-teal-600">2</span>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-800">Encontre ou Ofereça</h3>
                    <p class="text-gray-600">Busque bicicletas disponíveis ou cadastre a sua para compartilhar.</p>
                </div>
                
                <!-- Step 3 -->
                <div class="text-center">
                    <div class="w-20 h-20 bg-teal-100 rounded-full flex items-center justify-center mx-auto mb-6">
                        <span class="text-2xl font-bold text-teal-600">3</span>
                    </div>
                    <h3 class="text-xl font-semibold mb-3 text-gray-800">Conecte-se</h3>
                    <p class="text-gray-600">Faça reservas, pedale e contribua para uma comunidade mais sustentável.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="py-16 bg-teal-700 text-white">
        <div class="container mx-auto px-4 text-center">
            <h2 class="text-3xl font-bold mb-6">Pronto para começar?</h2>
            <p class="text-xl mb-8 max-w-2xl mx-auto">Junte-se à comunidade ShareBike e faça parte da mudança para uma mobilidade mais sustentável e inclusiva.</p>
            <div class="flex justify-center space-x-4">
                <a href="pages/cadastroUsuario.jsp" class="px-6 py-3 bg-white text-teal-700 font-semibold rounded-lg hover:bg-gray-100 transition">Cadastre-se agora</a>
                <a href="pages/loginUsuario.jsp" class="px-6 py-3 border border-white text-white font-semibold rounded-lg hover:bg-white hover:bg-opacity-10 transition">Fazer login</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="footer" class="bg-gray-800 text-white py-12">
        <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div>
                    <div class="flex items-center space-x-2 mb-4">
                        <i class="fas fa-bicycle text-teal-400 text-2xl"></i>
                        <span class="text-xl font-bold">ShareBike</span>
                    </div>
                    <p class="text-gray-400">Promovendo mobilidade sustentável e inclusão social através do compartilhamento de bicicletas.</p>
                </div>
                
                <div>
                    <h4 class="text-lg font-semibold mb-4">Links Rápidos</h4>
                    <ul class="space-y-2">
                        <li><a href="#" class="text-gray-400 hover:text-teal-400 transition">Início</a></li>
                        <li><a href="#features" class="text-gray-400 hover:text-teal-400 transition">Recursos</a></li>
                        <li><a href="#how-it-works" class="text-gray-400 hover:text-teal-400 transition">Como Funciona</a></li>
                        <li><a href="#footer" class="text-gray-400 hover:text-teal-400 transition">Sobre</a></li>
                    </ul>
                </div>
                
                <div>
                    <h4 class="text-lg font-semibold mb-4">Contato</h4>
                    <ul class="space-y-2">
                        <li class="flex items-center space-x-2 text-gray-400">
                            <i class="fas fa-envelope"></i>
                            <span>contato@sharebike.com</span>
                        </li>
                        <li class="flex items-center space-x-2 text-gray-400">
                            <i class="fas fa-phone"></i>
                            <span>(11) 98765-4321</span>
                        </li>
                        <li class="flex items-center space-x-2 text-gray-400">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>São Paulo, Brasil</span>
                        </li>
                    </ul>
                </div>
                
                <div>
                    <h4 class="text-lg font-semibold mb-4">Redes Sociais</h4>
                    <div class="flex space-x-4">
                        <a href="#" class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center hover:bg-teal-600 transition">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center hover:bg-teal-600 transition">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center hover:bg-teal-600 transition">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="w-10 h-10 bg-gray-700 rounded-full flex items-center justify-center hover:bg-teal-600 transition">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400">
                <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
            </div>
        </div>
    </footer>

</body>
</html>
