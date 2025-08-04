package br.com.sharebike.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.model.Usuario;

@WebServlet("/UsuarioController")
public class UsuarioController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private UsuarioDAO usuarioDAO;

	public void init() throws ServletException{
		try {
			usuarioDAO = new UsuarioDAO();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar UsuarioDAO", e);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			listarUsuarios(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		try {
			switch (action) {
			case "adicionar":
				adicionarUsuario(request, response);
				break;
			case "editar":
				editarUsuario(request, response);
				break;
			case "exibir":
				exibirUsuario(request, response);
				break;
			case "login":
				loginUsuario(request, response);
				break;
			case "logout":
				logoutUsuario(request, response);
				break;
			case "aprovar-acesso":
				aprovarAcessoUsuario(request, response);
				break;
			case "aprovar-rank":
				aprovarRankUsuario(request, response);
				break;
			case "listar":
				listarUsuarios(request, response);
				break;    
			default:
				listarUsuarios(request, response);
				break;
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void adicionarUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		String nomeRazaoSocial_user = request.getParameter("nomeRazaoSocial");
		String foto_user = request.getParameter("foto");
		String cidade_user = request.getParameter("cidade");
		String estado_user = request.getParameter("estado");
		String pais_user = request.getParameter("pais");
		String telefone_user = request.getParameter("telefone");
		String email_user = request.getParameter("email");
		String senha_user = request.getParameter("senha");
		String fotoComprBike_user = request.getParameter("fotoComprBike");

		Usuario usuario = new Usuario(cpfCnpj_user, nomeRazaoSocial_user, foto_user, cidade_user, estado_user, pais_user, telefone_user, 
				email_user, senha_user, fotoComprBike_user);

		usuarioDAO.cadastrarUsuario(usuario);

		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Usuario adicionado com sucesso!');");
		out.println("window.location.href='pages/lista.jsp';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("index.jsp");

	}

	private void editarUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		String nomeRazaoSocial_user = request.getParameter("nomeRazaoSocial");
		String foto_user = request.getParameter("foto");
		String cidade_user = request.getParameter("cidade");
		String estado_user = request.getParameter("estado");
		String pais_user = request.getParameter("pais");
		String telefone_user = request.getParameter("telefone");
		String email_user = request.getParameter("email");
		String senha_user = request.getParameter("senha");
		Float avaliacao_user = Float.parseFloat(request.getParameter("avaliacao"));
		boolean permissaoAcesso_user = Boolean.parseBoolean(request.getParameter("permissaoAcesso"));
		boolean permissaoRank_user = Boolean.parseBoolean(request.getParameter("permissaoRank"));
		boolean possuiBike_user = Boolean.parseBoolean(request.getParameter("possuiBike"));
		String fotoComprBike_user = request.getParameter("fotoComprBike");

		Usuario usuario = new Usuario(cpfCnpj_user, nomeRazaoSocial_user, foto_user, cidade_user, estado_user, pais_user, telefone_user, email_user, senha_user, 
				avaliacao_user, permissaoAcesso_user, permissaoRank_user, possuiBike_user, fotoComprBike_user);

		usuarioDAO.editarUsuario(usuario);


		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Usuario editado com sucesso!');");
		out.println("window.location.href='pages/lista.jsp';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("pages/usuarioDetalhes.jsp");

	}
	
	private void exibirUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nomeRazaoSocial = request.getParameter("nomeRazaoSocial");
		List<Usuario> listaUsuario = usuarioDAO.listarUsuario();
		Usuario usuario = null;
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaUsuario == null || listaUsuario.isEmpty()) {
			System.out.println("A lista de usuarios está vazia ou nula");
		} else {
			System.out.println("Lista de Usuarios Obtida:");
			for (Usuario usuarioLista : listaUsuario) {
				if(usuarioLista.getNomeRazaoSocial_user().equalsIgnoreCase(nomeRazaoSocial)) {
					usuario = usuarioLista;
					break;
				}
			}
		}

		if(usuario == null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type='text/javascript'>");
			out.println("alert('Usuario inexistente!');");
			out.println("</script>");
			out.close();
			response.sendRedirect("pages/usuarioDetalhes.jsp");
		} else {
			request.setAttribute("Usuario", usuario);
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/usuarioDetalhes.jsp");
			dispatcher.forward(request, response);
		}
	}
	
	private void loginUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj = request.getParameter("cpfCnpj");
		String senha = request.getParameter("senha");
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj);
		
		if(usuario != null && usuario.getSenha_user().equals(senha)) {
			request.setAttribute("Usuario", usuario);
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/usuarioDetalhes.jsp");
			dispatcher.forward(request, response);
		}else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type='text/javascript'>");
			out.println("alert('CPF/CNPJ ou senha está inválida!');");
			out.println("</script>");
			out.close();
		}
	}
	
	private void logoutUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session = request.getSession(false);
		if(session != null) {
			session.invalidate();
		}
		response.sendRedirect("index.jsp");
	}
	
	private void aprovarAcessoUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuarioAcesso = usuarioDAO.usuariosParaAprovarAcesso();

		// Verificando se a lista tem dados e exibindo no console
		if (listaUsuarioAcesso == null || listaUsuarioAcesso.isEmpty()) {
			System.out.println("Sem Usuarios Cadastrados");
		} else {
			System.out.println("Lista de Usuarios Obtida:");
			for (Usuario usuario : listaUsuarioAcesso) {
				System.out.println(usuario.exibirDados());
			}
		}

		request.setAttribute("listaUsuarioAcesso", listaUsuarioAcesso);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaUsuarioAcesso.jsp");
		dispatcher.forward(request, response);
	}

	private void aprovarRankUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuarioRank = usuarioDAO.usuariosParaAprovarRank();

		// Verificando se a lista tem dados e exibindo no console
		if (listaUsuarioRank == null || listaUsuarioRank.isEmpty()) {
			System.out.println("Usuarios sem reservas ou sem bicicleta");
		} else {
			System.out.println("Lista de Usuarios Obtida:");
			for (Usuario usuario : listaUsuarioRank) {
				System.out.println(usuario.exibirDados());
			}
		}

		request.setAttribute("listaUsuarioRank", listaUsuarioRank);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaUsuarioRank.jsp");
		dispatcher.forward(request, response);
	}

	private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuario = usuarioDAO.listarUsuario();

		// Verificando se a lista tem dados e exibindo no console
		if (listaUsuario == null || listaUsuario.isEmpty()) {
			System.out.println("A lista de usuarios está vazia ou nula");
		} else {
			System.out.println("Lista de Usuarios Obtida:");
			for (Usuario usuario : listaUsuario) {
				System.out.println(usuario.exibirDados());
			}
		}

		request.setAttribute("listaUsuario", listaUsuario);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaUsuarios.jsp");
		dispatcher.forward(request, response);
	}

}
