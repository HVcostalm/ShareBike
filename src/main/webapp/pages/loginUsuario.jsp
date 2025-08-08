<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8" />
  <title>Login - ShareBike</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" type="text/css" media="all">
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
  footer {
    text-align: center;
    padding: 1rem;
    background-color: #343a40;
    color: white;
    position: fixed;
    bottom: 0;
    width: 100%;
}
  </style>
</head>
<body class="bg-gray-50 min-h-screen flex flex-col">

  <!-- Navbar -->
  <nav class="bg-white shadow-md sticky top-0 z-40">
    <div class="container mx-auto px-4 py-3 flex items-center space-x-2">
      <a href="../index.jsp" class="flex items-center space-x-2">
        <i class="fas fa-bicycle text-teal-600 text-2xl"></i>
        <span class="text-xl font-bold text-teal-800">ShareBike</span>
      </a>
    </div>
  </nav>

  <!-- Main content: centralizado -->
  <main class="flex-grow flex items-center justify-center p-6">
    <div class="bg-white p-8 rounded shadow-md w-full max-w-md">
      <h1 class="text-2xl font-bold mb-6 text-teal-700 text-center">Login ShareBike</h1>

      <form action="../UsuarioController" method="post" class="space-y-4">
        <input type="hidden" name="action" value="login" />

        <div>
          <label for="cpfCnpj" class="block mb-1 font-semibold text-gray-700">CPF ou CNPJ</label>
          <input
            type="text"
            id="cpfCnpj"
            name="cpfCnpj"
            required
            maxlength="14"
            class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-500 focus:ring-1 focus:ring-teal-600"
            placeholder="Digite seu CPF ou CNPJ"
          />
        </div>

        <div>
          <label for="senha" class="block mb-1 font-semibold text-gray-700">Senha</label>
          <input
            type="password"
            id="senha"
            name="senha"
            required
            class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-teal-500 focus:ring-1 focus:ring-teal-600"
            placeholder="Digite sua senha"
          />
        </div>

        <button
          type="submit"
          class="w-full bg-teal-600 text-white font-semibold py-2 rounded hover:bg-teal-700 transition"
        >
          Entrar
        </button>
      </form>

      <p class="mt-4 text-center text-gray-600">
        Não tem uma conta?
        <a href="cadastroUsuario.jsp" class="text-teal-600 hover:underline">Cadastre-se aqui</a>
      </p>
    </div>
  </main>
  <footer>
	    <p>&copy; 2025 ShareBike. Todos os direitos reservados.</p>
  </footer>
</body>
</html>
