<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8" />
    <title>Cadastro de Usuário - ShareBike</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" type="text/css" media="all">
    <style>
        .min-h-screen-with-nav {
            min-height: calc(100vh - 68px); /* 68px é a altura aproximada da navbar */
        }
        footer {
		    text-align: center;
		    padding: 1rem;
		    background-color: #343a40;
		    color: white;
		    bottom: 0;
		    width: 100%;
		}
    </style>
    <script>
      function toggleFotoComprovacao() {
        const possuiBikeSim = document.getElementById('possuiBikeSim').checked;
        const campoFotoComprovacao = document.getElementById('campoFotoComprovacao');
        if (possuiBikeSim) {
          campoFotoComprovacao.style.display = 'block';
        } else {
          campoFotoComprovacao.style.display = 'none';
          // Limpa o input para evitar enviar dados desnecessários
          document.getElementById('fotoComprBike').value = '';
        }
      }
      window.onload = function() {
        toggleFotoComprovacao(); // Para ajustar ao carregar a página
      }
    </script>
</head>
<body class="bg-gray-50 font-sans">
    <!-- Navigation - Igual ao index.jsp -->
    <nav class="bg-white shadow-md sticky top-0 z-40">
        <div class="container mx-auto px-4 py-3 flex justify-between items-center">
            <div class="flex items-center space-x-2">
                <a href="../index.jsp" class="flex items-center space-x-2">
                    <i class="fas fa-bicycle text-teal-600 text-2xl"></i>
                    <span class="text-xl font-bold text-teal-800">ShareBike</span>
                </a>
            </div>
        </div>
    </nav>

    <!-- Conteúdo principal centralizado -->
    <div class="flex items-center justify-center min-h-screen-with-nav">
        <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-lg mx-4 my-8">
            <h1 class="text-2xl font-bold mb-6 text-teal-700">Cadastro de Usuário</h1>
            <form action="../UsuarioController" method="post" enctype="multipart/form-data" class="space-y-4">
                <!-- CPF/CNPJ -->
                <div>
                    <label for="cpfCnpj" class="block mb-1 font-semibold">CPF ou CNPJ</label>
                    <input type="text" id="cpfCnpj" name="cpfCnpj" maxlength="14" required
                           class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-600" />
                </div>
                <!-- Nome/Razão Social -->
                <div>
                    <label for="nomeRazaoSocial" class="block mb-1 font-semibold">Nome ou Razão Social</label>
                    <input type="text" id="nomeRazaoSocial" name="nomeRazaoSocial" maxlength="100" required
                           class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-600" />
                </div>
                <!-- Foto (URL) -->
                <div>
                    <label for="foto" class="block font-semibold mb-1">Foto do Usuário:</label> 
                    <input type="file" id="foto" name="foto" accept="image/*" class="w-full" />
                </div>
                <!-- País -->
                <div>
                    <label for="pais" class="block mb-1 font-semibold">País</label>
                    <input type="text" id="pais" name="pais" maxlength="45" required
                           class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-600" />
                </div>
                <!-- Estado -->
                <div>
                    <label for="estado" class="block mb-1 font-semibold">Estado (Sigla)</label>
                    <input type="text" id="estado" name="estado" maxlength="2" required
                           class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-600" />
                </div>
                <!-- Cidade -->
                <div>
                    <label for="cidade" class="block mb-1 font-semibold">Cidade</label>
                    <input type="text" id="cidade" name="cidade" maxlength="100" required
                           class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-600" />
                </div>           
                <!-- Telefone -->
                <div>
                    <label for="telefone" class="block mb-1 font-semibold">Telefone</label>
                    <input type="text" id="telefone" name="telefone" maxlength="11" required
                           class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-600" />
                </div>
                <!-- Email -->
                <div>
                    <label for="email" class="block mb-1 font-semibold">Email</label>
                    <input type="email" id="email" name="email" maxlength="100" required
                           class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-600" />
                </div>
                <!-- Senha -->
                <div>
                    <label for="senha" class="block mb-1 font-semibold">Senha</label>
                    <input type="password" id="senha" name="senha" maxlength="20" required
                           class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-600" />
                </div>
                <!-- Pergunta se possui bicicleta pessoal -->
                <div>
                    <p class="font-semibold mb-1">Você possui bicicleta pessoal?</p>
                    <label> 
                        <input type="radio" id="possuiBikeSim" name="possuiBike" value="true" onclick="toggleFotoComprovacao()" />
                        Sim - Você poderá participar dos rankings sem precisar realizar reservas
                    </label><br /> 
                    <label> 
                        <input type="radio" id="possuiBikeNao" name="possuiBike" value="false" checked onclick="toggleFotoComprovacao()" /> 
                        Não
                    </label>
                </div>

                <!-- Campo de foto comprovação - só aparece se respondeu "Sim" -->
                <div id="campoFotoComprovacao" style="display: none;">
                    <label for="fotoComprBike" class="block font-semibold mb-1">Foto Comprovação da Bicicleta:</label> 
                    <input type="file" id="fotoComprBike" name="fotoComprBike" accept="image/*" class="w-full" />
                </div>

                <button type="submit" name="action" value="adicionar" 
                        class="w-full bg-teal-600 text-white font-semibold py-3 rounded hover:bg-teal-700 transition">
                        Cadastrar
                </button>
            </form>
        </div>
    </div>
    <footer>
	    <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
	</footer>
</body>
</html>