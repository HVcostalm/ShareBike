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
import javax.servlet.http.Part;

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
			if (action == null) {
				// ação padrão ou redirecionamento
				response.sendRedirect("index.jsp");
			}else {
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
				case "deletar":
					deletarUsuario(request, response);
					break;
				case "aprovar-acesso":
					aprovarAcessoUsuario(request, response);
					break;
				case "aprovar-acesso-usuario":
					aprovarAcessoUsuarioEspecifico(request, response);
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
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void adicionarUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		String nomeRazaoSocial_user = request.getParameter("nomeRazaoSocial");
		//String foto_user = request.getParameter("foto");
		Part fotoPart = request.getPart("foto");
		String foto_user = (fotoPart != null) ? fotoPart.getSubmittedFileName() : null;
		String cidade_user = request.getParameter("cidade");
		String estado_user = request.getParameter("estado");
		String pais_user = request.getParameter("pais");
		String telefone_user = request.getParameter("telefone");
		String email_user = request.getParameter("email");
		String senha_user = request.getParameter("senha");
		//String fotoComprBike_user = request.getParameter("fotoComprBike");
		Part fotoComprPart = request.getPart("fotoComprBike");
		String fotoComprBike_user = (fotoComprPart != null) ? fotoComprPart.getSubmittedFileName() : null;

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
		String cpfCnpj = request.getParameter("cpfCnpj");
		String nomeRazaoSocial = request.getParameter("nomeRazaoSocial");
		String origem = request.getParameter("origem"); // Parâmetro para identificar a origem
		Usuario usuario = null;
		
		if (cpfCnpj != null && !cpfCnpj.trim().isEmpty()) {
			// Busca diretamente pelo CPF/CNPJ usando o método do DAO
			usuario = usuarioDAO.exibirUsuario(cpfCnpj);
		} else if (nomeRazaoSocial != null && !nomeRazaoSocial.trim().isEmpty()) {
			// Busca pelo nome (comportamento anterior)
			List<Usuario> listaUsuario = usuarioDAO.listarUsuario();
			
			if (listaUsuario != null && !listaUsuario.isEmpty()) {
				for (Usuario usuarioLista : listaUsuario) {
					if(usuarioLista.getNomeRazaoSocial_user().equalsIgnoreCase(nomeRazaoSocial)) {
						usuario = usuarioLista;
						break;
					}
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
			
			// Redireciona baseado na origem
			if ("gestaoUsuario".equals(origem)) {
				response.sendRedirect("pages/gestaoUsuario.jsp");
			} else if ("bicicletaDetalhes".equals(origem)) {
				response.sendRedirect("pages/bicicletaDetalhes.jsp");
			} else {
				// Fallback para compatibilidade com código existente
				if (cpfCnpj != null) {
					response.sendRedirect("pages/usuariosPermissao.jsp");
				} else {
					response.sendRedirect("pages/usuarioDetalhes.jsp");
				}
			}
		} else {
			request.setAttribute("Usuario", usuario);
			request.setAttribute("origem", origem); // Passa a origem para a JSP
			
			// Sempre redireciona para PerfilConvidado.jsp
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/PerfilConvidado.jsp");
			dispatcher.forward(request, response);
		}
	}
	
	private void loginUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj = request.getParameter("cpfCnpj");
		String senha = request.getParameter("senha");
		
		Usuario usuario = new Usuario();
		usuario.setCpfCnpj_user(cpfCnpj);
		usuario.setSenha_user(senha);
		
		if (cpfCnpj.equalsIgnoreCase("123") && senha.equalsIgnoreCase("456")) {
			// Cria sessão para o usuário autenticado
			HttpSession session = request.getSession();
			session.setAttribute("admLogado", usuario);

			// Redireciona para página de detalhes
			response.sendRedirect("pages/admDetalhes.jsp");
			
		} else if (cpfCnpj.equalsIgnoreCase("456") && senha.equalsIgnoreCase("123")) {
			// Cria sessão para o usuário autenticado
			HttpSession session = request.getSession();
			session.setAttribute("usuarioLogado", usuario);
			
			// Redireciona para página de detalhes
			request.getRequestDispatcher("/FeedbackController?action=listar-para-detalhes&cpfCnpjAvaliado=" + usuario.getCpfCnpj_user()).forward(request, response);
			
		} else {
			// Mensagem de erro e redirecionamento de volta para o login
			request.setAttribute("mensagemErro", "CPF/CNPJ ou senha inválidos!");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/loginUsuario.jsp");
	        dispatcher.forward(request, response);
		}
		
		/*
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj);
		
		if(usuario != null && usuario.getSenha_user().equals(senha)) {
			// Cria sessão para o usuário autenticado
	        HttpSession session = request.getSession();
	        session.setAttribute("usuarioLogado", usuario);

	        // Redireciona para página de detalhes
	        response.sendRedirect("pages/usuarioDetalhes.jsp");
		}else {
			// Mensagem de erro e redirecionamento de volta para o login
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script type='text/javascript'>");
	        out.println("alert('CPF/CNPJ ou senha inválidos!');");
	        out.println("window.location.href='pages/loginUsuario.jsp';"); // ou "login.jsp", se esse for o nome da página
	        out.println("</script>");
	        out.close();
		}
		*/
	}
	
	private void logoutUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		HttpSession session = request.getSession(false);
		if(session != null) {
			session.invalidate();
		}
		response.sendRedirect("index.jsp");
	}
	
	private void deletarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        String cpfCnpj_user = request.getParameter("cpfCnpj");
	        usuarioDAO.deletarUsuario(cpfCnpj_user);
	        
	        // Redireciona de volta para a lista de usuários pendentes
	        response.sendRedirect("UsuarioController?action=aprovar-acesso");
	    } catch (Exception e) {
	        throw new ServletException("Erro ao deletar usuário", e);
	    }
	}
	
	private void aprovarAcessoUsuarioEspecifico(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		usuarioDAO.aprovarAcessoUsuario(cpfCnpj_user);
		
		// Redireciona de volta para a lista de usuários pendentes
		response.sendRedirect("UsuarioController?action=aprovar-acesso");
	}
	
	private void aprovarAcessoUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuarioAcesso = usuarioDAO.usuariosParaAprovarAcesso();

		request.setAttribute("listaUsuarioAcesso", listaUsuarioAcesso);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/usuariosPermissao.jsp");
		dispatcher.forward(request, response);
	}

	private void aprovarRankUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuarioRank = usuarioDAO.usuariosParaAprovarRank();

		request.setAttribute("listaUsuarioRank", listaUsuarioRank);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/usuariosRanking.jsp");
		dispatcher.forward(request, response);
	}

	private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuario = usuarioDAO.listarUsuario();
		
		request.setAttribute("listaUsuario", listaUsuario);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/gestaoUsuario.jsp");
		dispatcher.forward(request, response);
	}
	

}