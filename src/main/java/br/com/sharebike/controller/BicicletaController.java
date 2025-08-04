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

import br.com.sharebike.dao.BicicletaDAO;
import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.model.Bicicleta;
import br.com.sharebike.model.Usuario;

@WebServlet("/BicicletaController")
public class BicicletaController extends HttpServlet{

	// Pensar em função para apenas mostrar as bicicletas que tenham disponibilidade
	// Pensar em função para deixar indisponivel uma data após chegar no dia

	private static final long serialVersionUID = 1L;
	private BicicletaDAO bicicletaDAO;
	private UsuarioDAO usuarioDAO;

	public void init() throws ServletException{
		try {
			bicicletaDAO = new BicicletaDAO();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar BicicletaDAO", e);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			listarBicicletas(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		try {
			switch (action) {
			case "adicionar":
				adicionarBicicleta(request, response);
				break;
			case "editar":
				editarBicicleta(request, response);
				break;
			case "acessar":
				exibirBicicleta(request, response);
				break;
			case "listar":
				listarBicicletas(request, response);
				break;
			case "lista-disponivel":
				listarBicicletasDisponiveisFiltradas(request, response);
				break;
			case "lista-usuario-adm":
				listarBicicletasUsuarioAdm(request, response);
				break;
			case "minhas-bikes":
				listarBicicletasProprietario(request, response);
				break;
			default:
				listarBicicletas(request, response);
				break;
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	private void adicionarBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nome_bike = request.getParameter("nome");
		String foto_bike = request.getParameter("foto");
		String localEntr_bike = request.getParameter("localEntr");
		String chassi_bike = request.getParameter("chassi");
		String estadoConserv_bike = request.getParameter("estadoConserv");
		String tipo_bike = request.getParameter("tipo");
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj_user);
		
		Bicicleta bicicleta = new Bicicleta(nome_bike, foto_bike, localEntr_bike, chassi_bike, estadoConserv_bike, tipo_bike, usuario);
		
		bicicletaDAO.cadastrarBicicleta(bicicleta);
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Bicicleta adicionada com sucesso!');");
		out.println("window.location.href='pages/lista.jsp';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("index.jsp");
		
	}

	private void editarBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt(request.getParameter("id"));
		String nome_bike = request.getParameter("nome");
		String foto_bike = request.getParameter("foto");
		String localEntr_bike = request.getParameter("localEntr");
		String chassi_bike = request.getParameter("chassi");
		String estadoConserv_bike = request.getParameter("estadoConserv");
		String tipo_bike = request.getParameter("tipo");
		Float avaliacao_bike = Float.parseFloat(request.getParameter("avaliacao_bike"));
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj_user);
		
		Bicicleta bicicleta = new Bicicleta(id_bike, nome_bike, foto_bike, localEntr_bike, chassi_bike, estadoConserv_bike, tipo_bike, avaliacao_bike, usuario);
		
		bicicletaDAO.editarBicicleta(bicicleta);
		
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
	
	private void exibirBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt("id");
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		Usuario usuario = usuarioDAO.exibirUsuario(bicicleta.getUsuario().getCpfCnpj_user());
		
		// Atribuindo os objetos à request
	    request.setAttribute("bicicleta", bicicleta);
	    request.setAttribute("proprietario", usuario);

	    // Encaminha para a página de exibição detalhada
	    RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalhesBicicleta.jsp");
	    dispatcher.forward(request, response);
		
	}
	
	private void listarBicicletasProprietario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		List<Bicicleta> listaBicicletaProprietario = bicicletaDAO.listarBicicletasPorUsuario(cpfCnpj_user);
		
		if (listaBicicletaProprietario == null || listaBicicletaProprietario.isEmpty()) {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('Sem bicicletas cadastradas');");
            out.println("window.location.href='pages/lista.jsp';");
            out.println("</script>");
            out.close();
		} else {
			request.setAttribute("listaBicicletaProprietario", listaBicicletaProprietario);
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
			dispatcher.forward(request, response);
		}

		
		
	}
	
	private void listarBicicletasUsuarioAdm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String nomeRazaoSocial = request.getParameter("nomeRazaoSocial");
		List<Usuario> listaUsuario = usuarioDAO.listarUsuario();
		Usuario usuario = null;
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaUsuario == null || listaUsuario.isEmpty()) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type='text/javascript'>");
			out.println("alert('A lista de usuarios está vazia ou nula!');");
			out.println("window.location.href='pages/lista.jsp';");
			out.println("</script>");
			out.close();
		} else {
			System.out.println("Lista de Usuarios Obtida:");
			for (Usuario usuarioLista : listaUsuario) {
				if(usuarioLista.getNomeRazaoSocial_user().equalsIgnoreCase(nomeRazaoSocial)) {
					usuario = usuarioLista;
					break;
				}
			}
		}
		
		if (usuario != null) {
	        List<Bicicleta> listaBicicletaUsuario = bicicletaDAO.listarBicicletasPorUsuario(usuario.getCpfCnpj_user());

	        if (listaBicicletaUsuario != null && !listaBicicletaUsuario.isEmpty()) {
	            request.setAttribute("listaBicicletaUsuario", listaBicicletaUsuario);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
	            dispatcher.forward(request, response);
	        } else {
	            // Usuário encontrado, mas sem bicicletas
	            response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script type='text/javascript'>");
	            out.println("alert('Usuário encontrado, mas ele não possui bicicletas. Exibindo todas.');");
	            out.println("window.location.href='pages/lista.jsp';");
	            out.println("</script>");
	            out.close();
	        }
	    } else {
	        // Usuário não encontrado
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script type='text/javascript'>");
	        out.println("alert('Usuário não encontrado! Exibindo todas as bicicletas.');");
	        out.println("window.location.href='pages/lista.jsp';");
	        out.println("</script>");
	        out.close();
	    }
		
	}
	
	private void listarBicicletasDisponiveisFiltradas(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cidade = request.getParameter("cidade");
		String tipo = request.getParameter("tipo");
		String estadoConserv = request.getParameter("estadoConserv");
		String ordemAvalicao = request.getParameter("ordemAvalicao");
		
		List<Bicicleta> listaBicicletaDisponivelFiltrada = bicicletaDAO.listarBicicletasDisponiveisFiltradas(cidade, tipo, estadoConserv, ordemAvalicao);

		// Verificando se a lista tem dados e exibindo no console
		if (listaBicicletaDisponivelFiltrada == null || listaBicicletaDisponivelFiltrada.isEmpty()) {
			System.out.println("A lista de bicicletas está vazia ou nula");
		} else {
			System.out.println("Lista de Bicicletas Obtida:");
			for (Bicicleta bicicleta : listaBicicletaDisponivelFiltrada) {
				System.out.println(bicicleta.exibirDados());
			}
		}

		request.setAttribute("listaBicicletaDisponivelFiltrada", listaBicicletaDisponivelFiltrada);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
		
	}
	
	private void listarBicicletas(HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Bicicleta> listaBicicleta = bicicletaDAO.listarBicicletas();
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaBicicleta == null || listaBicicleta.isEmpty()) {
			System.out.println("A lista de bicicletas está vazia ou nula");
		} else {
			System.out.println("Lista de Bicicletas Obtida:");
			for (Bicicleta bicicleta : listaBicicleta) {
				System.out.println(bicicleta.exibirDados());
			}
		}

		request.setAttribute("listaBicicleta", listaBicicleta);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}


}
