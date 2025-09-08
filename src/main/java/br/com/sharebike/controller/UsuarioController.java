package br.com.sharebike.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.dao.FeedbackDAO;
import br.com.sharebike.dao.ReservaDAO;
import br.com.sharebike.model.Usuario;
import br.com.sharebike.model.Feedback;
import br.com.sharebike.model.Reserva;
import br.com.sharebike.utils.ValidadorCpfCnpj;
import br.com.sharebike.utils.ValidadorUsuario;

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
		// Configurar encoding UTF-8
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String action = request.getParameter("action");
		try {
			if (action == null) {
				listarUsuarios(request, response);
			} else {
				switch (action) {
				case "exibir":
					exibirUsuario(request, response);
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
				case "listar-ativo":
					usuariosAtivos(request, response);
					break;
				case "listar":
					listarUsuarios(request, response);
					break;
				case "perfil":
					carregarPerfil(request, response);
					break;    
				case "carregarEdicao":
					carregarEdicao(request, response);
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Configurar encoding UTF-8
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
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
				case "atualizar-avaliacao":
					atualizarAvaliacaoUsuario(request, response);
					break;
				case "deletar":
					deletarUsuario(request, response);
					break;
				case "negar-ranking":
					negarRanking(request, response);
					break;
				case "aprovar-acesso":
					aprovarAcessoUsuario(request, response);
					break;
				case "aprovar-acesso-usuario":
					aprovarAcessoUsuarioEspecifico(request, response);
					break;
				case "negar-acesso-usuario":
					negarAcessoUsuarioEspecifico(request, response);
					break;
				case "revogar-acesso-usuario":
					revogarAcessoUsuario(request, response);
					break;
				case "aprovar-rank":
					aprovarRankUsuario(request, response);
					break;
				case "aprovar-rank-usuario":
					aprovarRankingUsuarioEspecifico(request, response);
					break;
				case "listar-ativo":
					usuariosAtivos(request, response);
					break;
				case "listar":
					listarUsuarios(request, response);
					break;
				case "perfil":
					carregarPerfil(request, response);
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
		try {
			// Configurar encoding UTF-8
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			
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
			
			// DEBUG: Log dos parâmetros recebidos
			System.out.println("=== DEBUG PARÂMETROS ===");
			System.out.println("Encoding da requisição: " + request.getCharacterEncoding());
			System.out.println("CPF/CNPJ: " + cpfCnpj_user);
			System.out.println("Nome: " + nomeRazaoSocial_user);
			System.out.println("Cidade: " + cidade_user);
			System.out.println("Estado: " + estado_user);
			System.out.println("País: " + pais_user);
			System.out.println("========================");
			
			// Validar CPF/CNPJ antes de prosseguir
			if (!ValidadorCpfCnpj.validarDocumento(cpfCnpj_user)) {
				// CPF/CNPJ inválido - retornar erro
				String tipoDoc = ValidadorCpfCnpj.isCPF(cpfCnpj_user) ? "CPF" : 
								 ValidadorCpfCnpj.isCNPJ(cpfCnpj_user) ? "CNPJ" : "CPF/CNPJ";
				
				request.setAttribute("erro", "O " + tipoDoc + " informado é inválido. Verifique os dados e tente novamente.");
				request.setAttribute("cpfCnpj", cpfCnpj_user);
				request.setAttribute("nomeRazaoSocial", nomeRazaoSocial_user);
				request.setAttribute("cidade", cidade_user);
				request.setAttribute("estado", estado_user);
				request.setAttribute("pais", pais_user);
				request.setAttribute("telefone", telefone_user);
				request.setAttribute("email", email_user);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/cadastroUsuario.jsp");
				dispatcher.forward(request, response);
				return;
			}
			
			// Validar dados únicos (email e CPF/CNPJ duplicados)
			String erroValidacao = ValidadorUsuario.validarDadosUnicos(email_user, cpfCnpj_user);
			if (erroValidacao != null) {
				// Email ou CPF/CNPJ já existe - retornar erro
				request.setAttribute("erro", erroValidacao);
				request.setAttribute("cpfCnpj", cpfCnpj_user);
				request.setAttribute("nomeRazaoSocial", nomeRazaoSocial_user);
				request.setAttribute("cidade", cidade_user);
				request.setAttribute("estado", estado_user);
				request.setAttribute("pais", pais_user);
				request.setAttribute("telefone", telefone_user);
				request.setAttribute("email", email_user);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/cadastroUsuario.jsp");
				dispatcher.forward(request, response);
				return;
			}
			
			// Se foto_user estiver vazia, usar valor padrão
			if (foto_user == null || foto_user.trim().isEmpty()) {
				foto_user = "default.jpg";
			}

			Usuario usuario = new Usuario(cpfCnpj_user, nomeRazaoSocial_user, foto_user, cidade_user, estado_user, pais_user, telefone_user, 
					email_user, senha_user, fotoComprBike_user);
			
			usuarioDAO.cadastrarUsuario(usuario);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type='text/javascript'>");
			out.println("alert('Cadastro realizado com sucesso! Aguarde a aprovação do administrador para ter acesso a plataforma');");
			out.println("window.location.href='index.jsp';");
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			System.out.println("ERRO no cadastro: " + e.getMessage());
			e.printStackTrace();
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE html>");
			out.println("<html>");
			out.println("<head><meta charset='UTF-8'></head>");
			out.println("<body>");
			out.println("<script type='text/javascript'>");
			out.println("alert('Erro no cadastro: " + e.getMessage().replace("'", "\\'") + "');");
			out.println("window.location.href = 'pages/cadastroUsuario.jsp';");
			out.println("</script>");
			out.println("</body>");
			out.println("</html>");
			out.flush();
			out.close();
		}
	}

	private void editarUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Configurar encoding UTF-8
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
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

		// Se a senha estiver vazia, buscar a senha atual do usuário
		if (senha_user == null || senha_user.trim().isEmpty()) {
			Usuario usuarioAtual = usuarioDAO.exibirUsuario(cpfCnpj_user);
			if (usuarioAtual != null) {
				senha_user = usuarioAtual.getSenha_user();
			}
		}
		
		// Tentar corrigir encoding se necessário
		if (nomeRazaoSocial_user != null) {
			try {
				// Testar se precisa de conversão de encoding
				String nomeTestISO = new String(nomeRazaoSocial_user.getBytes("ISO-8859-1"), "UTF-8");

				// Se a conversão melhorou, usar ela
				if (nomeTestISO.contains("ã") || nomeTestISO.contains("ç") || nomeTestISO.contains("ê")) {
					nomeRazaoSocial_user = nomeTestISO;
				}
			} catch (Exception e) {
				System.out.println("DEBUG - Erro na conversão de encoding: " + e.getMessage());
			}
		}

		// Aplicar mesma correção para cidade se necessário
		if (cidade_user != null) {
			try {
				String cidadeTestISO = new String(cidade_user.getBytes("ISO-8859-1"), "UTF-8");
				if (cidadeTestISO.contains("ã") || cidadeTestISO.contains("ç") || cidadeTestISO.contains("ê")) {
					cidade_user = cidadeTestISO;
				}
			} catch (Exception e) {
				// Ignora erro
			}
		}

		if (pais_user != null) {
			try {
				String cidadeTestISO = new String(pais_user.getBytes("ISO-8859-1"), "UTF-8");
				if (cidadeTestISO.contains("ã") || cidadeTestISO.contains("ç") || cidadeTestISO.contains("ê")) {
					pais_user = cidadeTestISO;
				}
			} catch (Exception e) {
				// Ignora erro
			}
		}

		if (email_user != null) {
			try {
				String cidadeTestISO = new String(email_user.getBytes("ISO-8859-1"), "UTF-8");
				if (cidadeTestISO.contains("ã") || cidadeTestISO.contains("ç") || cidadeTestISO.contains("ê")) {
					email_user = cidadeTestISO;
				}
			} catch (Exception e) {
				// Ignora erro
			}
		}

		if (senha_user != null) {
			try {
				String cidadeTestISO = new String(senha_user.getBytes("ISO-8859-1"), "UTF-8");
				if (cidadeTestISO.contains("ã") || cidadeTestISO.contains("ç") || cidadeTestISO.contains("ê")) {
					senha_user = cidadeTestISO;
				}
			} catch (Exception e) {
				// Ignora erro
			}
		}
		
		Usuario usuario = new Usuario(cpfCnpj_user, nomeRazaoSocial_user, foto_user, cidade_user, estado_user, pais_user, telefone_user, email_user, senha_user, 
				avaliacao_user, permissaoAcesso_user, permissaoRank_user, possuiBike_user, fotoComprBike_user);

		usuarioDAO.editarUsuario(usuario);

		// Atualizar a sessão com os dados atualizados
		HttpSession session = request.getSession();
		Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
		Usuario admLogado = (Usuario) session.getAttribute("admLogado");
		
		if (usuarioLogado != null && usuarioLogado.getCpfCnpj_user().equals(cpfCnpj_user)) {
			session.setAttribute("usuarioLogado", usuario);
		} else if (admLogado != null && admLogado.getCpfCnpj_user().equals(cpfCnpj_user)) {
			session.setAttribute("admLogado", usuario);
		}

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Usuario editado com sucesso!');");
		out.println("window.location.href='pages/perfil.jsp';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("pages/usuarioDetalhes.jsp");

	}
	
	private void exibirUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cpfCnpj = request.getParameter("cpfCnpj");
		String nomeRazaoSocial = request.getParameter("nomeRazaoSocial");
		String origem = request.getParameter("origem"); // Parâmetro para identificar a origem
		String bicicletaId = request.getParameter("bicicletaId"); // Parâmetro para ID da bicicleta
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
			} else if ("usuariosPermissao".equals(origem)){
				response.sendRedirect("pages/perfilAdmCadastro.jsp");
			} else if ("usuariosRanking".equals(origem)){
				response.sendRedirect("pages/perfilAdmRanking.jsp");
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
			request.setAttribute("bicicletaId", bicicletaId); // Passa o ID da bicicleta para a JSP
			
			// Buscar feedbacks do usuário
			try {
				FeedbackDAO feedbackDAO = new FeedbackDAO();
				List<Feedback> feedbacks = feedbackDAO.listarPorAvaliado(usuario.getCpfCnpj_user());
				request.setAttribute("feedbacks", feedbacks);
				
				// Buscar observações dos locadores sobre como o usuário tratou as bicicletas
				List<Feedback> observacoesBicicletas = feedbackDAO.listarFeedbacksLocadorSobreBicicletas(usuario.getCpfCnpj_user());
				request.setAttribute("observacoesBicicletas", observacoesBicicletas);
			} catch (Exception e) {
				e.printStackTrace();
				// Se houver erro ao buscar feedbacks, continua sem eles
			}
			
			// Se for para análise de ranking, buscar reservas finalizadas
			if ("usuariosRanking".equals(origem) || "aprovarRanking".equals(origem)) {
				try {
					ReservaDAO reservaDAO = new ReservaDAO();
					List<Reserva> reservasFinalizadas = reservaDAO.listarReservasFinalizadasNaoInformadasPorUsuario(usuario.getCpfCnpj_user());
					request.setAttribute("listaReservasFinalizadas", reservasFinalizadas);
				} catch (Exception e) {
					e.printStackTrace();
					// Se houver erro ao buscar reservas, continua sem elas
				}
			}
			
			// Redireciona baseado na origem
			if ("usuariosPermissao".equals(origem) || "aprovarAcesso".equals(origem)) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/perfilAdmCadastro.jsp");
				dispatcher.forward(request, response);
			} else if ("usuariosRanking".equals(origem) || "aprovarRanking".equals(origem)) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/perfilAdmRanking.jsp");
				dispatcher.forward(request, response);
			} else {
				// Para outras origens, mantém o comportamento anterior
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/perfilConvidado.jsp");
				dispatcher.forward(request, response);
			}
		}
	}
	
	private void loginUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj = request.getParameter("cpfCnpj");
		String senha = request.getParameter("senha");
		// ADM = 70700111000196 @ShareBike5202
		
		List<Usuario> listaUsuario = usuarioDAO.listarUsuario();
		Usuario usuarioEncontrado = null;
		
		for (Usuario usuario : listaUsuario) {
	        if (usuario.getCpfCnpj_user().equalsIgnoreCase(cpfCnpj) &&
	            usuario.getSenha_user().equalsIgnoreCase(senha)) {
	            usuarioEncontrado = usuario;
	            break;
	        }
	    }
		
		if (usuarioEncontrado != null) {
	        if (usuarioEncontrado.getCpfCnpj_user().equalsIgnoreCase("70700111000196")) {
	            // ADM
	            HttpSession session = request.getSession();
	            session.setAttribute("admLogado", usuarioEncontrado);
	            response.sendRedirect("pages/admDetalhes.jsp");
	        } else {
	            if (usuarioEncontrado.isPermissaoAcesso_user()) {
	                HttpSession session = request.getSession();
	                session.setAttribute("usuarioLogado", usuarioEncontrado);

	                // Redirecionar para o perfil do usuário via controller
	                response.sendRedirect("UsuarioController?action=perfil");
	            } else {
	                request.setAttribute("mensagemErro", "Conta não aprovada pelo Administrador");
	                RequestDispatcher dispatcher = request.getRequestDispatcher("pages/loginUsuario.jsp");
	                dispatcher.forward(request, response);
	            }
	        }
	    } else {
	        // só cai aqui se realmente não encontrou nenhum usuário válido
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
	
	private void negarRanking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	        String cpfCnpj_user = request.getParameter("cpfCnpj");
	        usuarioDAO.deletarFoto(cpfCnpj_user);
	        
	        // Redireciona de volta para a lista de usuários pendentes
	        response.sendRedirect("UsuarioController?action=aprovar-rank");
	    } catch (Exception e) {
	        throw new ServletException("Erro ao apagar foto da comprovação da bicicleta", e);
	    }
	}
	
	private void aprovarAcessoUsuarioEspecifico(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		usuarioDAO.aprovarAcessoUsuario(cpfCnpj_user);
		
		// Recarrega a lista de usuários para aprovação e encaminha para a página
		List<Usuario> listaUsuarioAcesso = usuarioDAO.usuariosParaAprovarAcesso();
		removerAdministradorDaLista(listaUsuarioAcesso);
		request.setAttribute("listaUsuarioAcesso", listaUsuarioAcesso);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/usuariosPermissao.jsp");
		dispatcher.forward(request, response);
	}
	
	private void negarAcessoUsuarioEspecifico(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		usuarioDAO.deletarUsuario(cpfCnpj_user);
		
		// Recarrega a lista de usuários para aprovação e encaminha para a página
		List<Usuario> listaUsuarioAcesso = usuarioDAO.usuariosParaAprovarAcesso();
		removerAdministradorDaLista(listaUsuarioAcesso);
		request.setAttribute("listaUsuarioAcesso", listaUsuarioAcesso);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/usuariosPermissao.jsp");
		dispatcher.forward(request, response);
	}
	
	private void revogarAcessoUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		String origem = request.getParameter("origem"); // Pegar origem se fornecida
		String bicicletaId = request.getParameter("bicicletaId"); // Pegar bicicletaId se fornecido
		
		// Negar acesso do usuário (alterar permissaoAcesso_user para false)
		usuarioDAO.negarAcessoUsuario(cpfCnpj_user);
		
		// Adicionar mensagem de sucesso
		request.getSession().setAttribute("mensagemSucesso", "Acesso negado com sucesso!");
		
		// Construir URL de redirecionamento para manter o administrador no perfil do usuário
		StringBuilder redirectUrl = new StringBuilder("UsuarioController?action=exibir&cpfCnpj=" + cpfCnpj_user);
		
		// Adicionar parâmetros de origem se existirem
		if (origem != null && !origem.trim().isEmpty()) {
			redirectUrl.append("&origem=").append(origem);
		}
		if (bicicletaId != null && !bicicletaId.trim().isEmpty()) {
			redirectUrl.append("&bicicletaId=").append(bicicletaId);
		}
		
		// Redirecionar de volta para o perfil do usuário (PerfilConvidado.jsp)
		response.sendRedirect(redirectUrl.toString());
	}
	
	private void atualizarAvaliacaoUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj = request.getParameter("cpfCnpj");
		
		// Atualizar a média de avaliação do usuário
		usuarioDAO.atualizarMediaAvaliacao(cpfCnpj);
		
		// Redirecionar de volta para o perfil
		response.sendRedirect("UsuarioController?action=perfil");
	}
	
	private void aprovarRankingUsuarioEspecifico(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		usuarioDAO.aprovarAcessoRanking(cpfCnpj_user);
		
		// Redireciona de volta para a lista de usuários pendentes
		response.sendRedirect("UsuarioController?action=aprovar-rank");
	}
	
	private void carregarPerfil(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		// Verificar se é admin ou usuário comum
		Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
		Usuario admLogado = (Usuario) session.getAttribute("admLogado");
		
		Usuario usuario = null;
		
		if (usuarioLogado != null) {
			usuario = usuarioLogado;
		} else if (admLogado != null) {
			usuario = admLogado;
		}
		
		if (usuario == null) {
			// Usuário não logado, redirecionar para login
			response.sendRedirect("pages/loginUsuario.jsp");
			return;
		}
		
		// Buscar dados atualizados do usuário no banco
		Usuario usuarioAtualizado = usuarioDAO.exibirUsuario(usuario.getCpfCnpj_user());
		
		if (usuarioAtualizado == null) {
			response.sendRedirect("pages/loginUsuario.jsp");
			return;
		}
		
		// Buscar feedbacks sobre o usuário logado
		FeedbackDAO feedbackDAO = new FeedbackDAO();
		List<Feedback> feedbacksRecebidos = feedbackDAO.listarPorAvaliado(usuario.getCpfCnpj_user());
		
		// Buscar observações dos locadores sobre como o usuário tratou as bicicletas
		List<Feedback> observacoesBicicletas = feedbackDAO.listarFeedbacksLocadorSobreBicicletas(usuario.getCpfCnpj_user());
		
		// Debug: imprimir informações sobre as observações
		System.out.println("=== DEBUG OBSERVAÇÕES BICICLETAS ===");
		System.out.println("CPF do usuário: " + usuario.getCpfCnpj_user());
		System.out.println("Número de observações encontradas: " + (observacoesBicicletas != null ? observacoesBicicletas.size() : "null"));
		if (observacoesBicicletas != null) {
			for (int i = 0; i < observacoesBicicletas.size(); i++) {
				Feedback obs = observacoesBicicletas.get(i);
				System.out.println("Observação " + (i+1) + ":");
				System.out.println("  - ID: " + obs.getId_feedb());
				System.out.println("  - Observação: " + obs.getObsBike_feedb());
				System.out.println("  - Data: " + obs.getData_feedb());
				System.out.println("  - Avaliador: " + (obs.getAvaliador_Usuario() != null ? obs.getAvaliador_Usuario().getNomeRazaoSocial_user() : "null"));
				System.out.println("  - Reserva: " + (obs.getReserva() != null ? obs.getReserva().getId_reserv() : "null"));
			}
		}
		System.out.println("=== FIM DEBUG ===");
		
		// Calcular estatísticas dos feedbacks
		int totalFeedbacks = feedbacksRecebidos.size();
		double somaAvaliacoes = 0;
		if (totalFeedbacks > 0) {
			for (Feedback feedback : feedbacksRecebidos) {
				somaAvaliacoes += feedback.getAvaliacaoUser_feedb();
			}
		}
		double mediaAvaliacao = totalFeedbacks > 0 ? somaAvaliacoes / totalFeedbacks : 0;
		
		// Atualizar a avaliação no banco de dados automaticamente
		try {
			usuarioDAO.atualizarMediaAvaliacao(usuario.getCpfCnpj_user());
			// Buscar dados atualizados novamente após a atualização da avaliação
			usuarioAtualizado = usuarioDAO.exibirUsuario(usuario.getCpfCnpj_user());
		} catch (Exception e) {
			// Se falhar a atualização, continua com os dados que já temos
			System.out.println("Erro ao atualizar avaliação automaticamente: " + e.getMessage());
		}
		
		// Definir atributos para a JSP
		request.setAttribute("usuario", usuarioAtualizado);
		request.setAttribute("feedbacksRecebidos", feedbacksRecebidos);
		request.setAttribute("observacoesBicicletas", observacoesBicicletas);
		request.setAttribute("totalFeedbacks", totalFeedbacks);
		request.setAttribute("mediaAvaliacao", mediaAvaliacao);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/perfil.jsp");
		dispatcher.forward(request, response);
	}
	
	private void carregarEdicao(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		// Verificar se é admin ou usuário comum
		Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
		Usuario admLogado = (Usuario) session.getAttribute("admLogado");
		
		Usuario usuario = null;
		
		if (usuarioLogado != null) {
			usuario = usuarioLogado;
		} else if (admLogado != null) {
			usuario = admLogado;
		}
		
		if (usuario == null) {
			// Usuário não logado, redirecionar para login
			response.sendRedirect("pages/loginUsuario.jsp");
			return;
		}
		
		// Buscar dados atualizados do usuário no banco
		Usuario usuarioAtualizado = usuarioDAO.exibirUsuario(usuario.getCpfCnpj_user());
		
		if (usuarioAtualizado == null) {
			response.sendRedirect("pages/loginUsuario.jsp");
			return;
		}
		
		// Definir atributos para a JSP
		request.setAttribute("usuario", usuarioAtualizado);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/editarUsuario.jsp");
		dispatcher.forward(request, response);
	}
	
	private void usuariosAtivos(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuarioAtivos = usuarioDAO.usuariosAtivos();

		request.setAttribute("listaUsuarioAtivos", listaUsuarioAtivos);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/usuariosPermissao.jsp");
		dispatcher.forward(request, response);
	}
	
	private void aprovarAcessoUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuarioAcesso = usuarioDAO.usuariosParaAprovarAcesso();
		
		// Remover o usuário administrador da lista
		removerAdministradorDaLista(listaUsuarioAcesso);

		request.setAttribute("listaUsuarioAcesso", listaUsuarioAcesso);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/usuariosPermissao.jsp");
		dispatcher.forward(request, response);
	}

	private void aprovarRankUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuarioRank = usuarioDAO.usuariosParaAprovarRank();
		
		// Remover o usuário administrador da lista
		removerAdministradorDaLista(listaUsuarioRank);

		request.setAttribute("listaUsuarioRank", listaUsuarioRank);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/usuariosRanking.jsp");
		dispatcher.forward(request, response);
	}
	
	/**
	 * Remove o usuário administrador (CPF/CNPJ: 70700111000196) da lista de usuários
	 * @param listaUsuarios Lista de usuários da qual remover o administrador
	 */
	private void removerAdministradorDaLista(List<Usuario> listaUsuarios) {
		if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
			for (int i = 0; i < listaUsuarios.size(); i++) {
				Usuario usuario = listaUsuarios.get(i);
				if (usuario != null && "70700111000196".equals(usuario.getCpfCnpj_user())) {
					listaUsuarios.remove(i);
					break; // Sai do loop após encontrar e remover o administrador
				}
			}
		}
	}

	private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Usuario> listaUsuario = usuarioDAO.listarUsuario();
		String filtroNome = request.getParameter("nomeRazaoSocial");
		
		// Se há um filtro de nome, aplicar o filtro
		if (filtroNome != null && !filtroNome.trim().isEmpty()) {
			List<Usuario> listaFiltrada = new ArrayList<>();
			String filtroLowerCase = filtroNome.trim().toLowerCase();
			
			for (Usuario usuario : listaUsuario) {
				if (usuario.getNomeRazaoSocial_user() != null && 
					usuario.getNomeRazaoSocial_user().toLowerCase().contains(filtroLowerCase)) {
					listaFiltrada.add(usuario);
				}
			}
			listaUsuario = listaFiltrada;
		}
		
		// Remover o usuário administrador da lista
		removerAdministradorDaLista(listaUsuario);
		
		request.setAttribute("listaUsuario", listaUsuario);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/gestaoUsuario.jsp");
		dispatcher.forward(request, response);
	}

}