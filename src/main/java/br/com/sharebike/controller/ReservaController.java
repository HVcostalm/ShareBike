package br.com.sharebike.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.sharebike.dao.BicicletaDAO;
import br.com.sharebike.dao.ReservaDAO;
import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.model.Bicicleta;
import br.com.sharebike.model.Reserva;
import br.com.sharebike.model.Usuario;

@WebServlet("/ReservaController")
public class ReservaController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ReservaDAO reservaDAO;
	private BicicletaDAO bicicletaDAO;
	private UsuarioDAO usuarioDAO;
	
	// Ver função em amarelo para listar as reservas para ver o ranking
	
	public void init() throws ServletException{
		try {
			reservaDAO = new ReservaDAO();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar ReservaDAO", e);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			listarReservas(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String action = request.getParameter("action");
		try {
			switch(action) {
			case "adicionar":
				adicionarReserva(request,response);
				break;
			case "editar":
				editarReserva(request,response);
				break;
			case "exibir":
				exibirReserva(request,response);
				break;	
			case "listar":
				listarReservas(request,response);
				break;
			case "listar-por-locatario":
				listarReservasPorLocatario(request, response);
				break;
			case "listar-por-locador":
				listarReservasPorLocador(request, response);
				break;
			case "listar-finaliza":
				listarReservasRanking(request, response);
				break;
			default:
				listarReservas(request, response);
				break;
			}
		}catch (Exception e){
			throw new ServletException(e);
		}
	}
	
	private void adicionarReserva(HttpServletRequest request, HttpServletResponse response) throws Exception{
		LocalDateTime dataCheckIn_reserv = LocalDateTime.parse(request.getParameter("dataCheckIn"));
		LocalDateTime dataCheckOut_reserv = LocalDateTime.parse(request.getParameter("dataCheckOut"));
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		int id_bike = Integer.parseInt(request.getParameter("id_bike"));
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj_user);
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		
		Reserva reserva = new Reserva(dataCheckIn_reserv, dataCheckOut_reserv, usuario, bicicleta);
		
		reservaDAO.cadastrarReserva(reserva);
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Reserva pendente');");
		out.println("window.location.href='pages/detalhesBicicleta.jsp';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("index.jsp");
	}
	
	private void editarReserva(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_reserv = Integer.parseInt(request.getParameter("id_reserv"));
		LocalDateTime dataCheckIn_reserv = LocalDateTime.parse(request.getParameter("dataCheckIn"));
		LocalDateTime dataCheckOut_reserv = LocalDateTime.parse(request.getParameter("dataCheckOut"));
		String status_reserv = request.getParameter("status");
		Boolean informada_reserv = Boolean.getBoolean(request.getParameter("informada")); 
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		int id_bike = Integer.parseInt(request.getParameter("id_bike"));
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj_user);
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		
		Reserva reserva = new Reserva(id_reserv, dataCheckIn_reserv, dataCheckOut_reserv, status_reserv, informada_reserv, usuario, bicicleta);
		
		reservaDAO.atualizarReserva(reserva);
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Reserva atualizada');");
		out.println("window.location.href='pages/detalhesBicicleta.jsp';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("index.jsp");
	}
	
	private void exibirReserva(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_reserv = Integer.parseInt(request.getParameter("id"));
		
		Reserva reserva = reservaDAO.buscarPorId(id_reserv);
		
		// Atribuindo os objetos à request
		request.setAttribute("Reserva", reserva);
		
		// Encaminha para a página de exibição detalhada
	    RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalhReserva.jsp");
	    dispatcher.forward(request, response);
	}
	
	private void listarReservasRanking(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj = request.getParameter("cpfCnpj");
		
		List<Reserva> listaReservasFinalizadas = reservaDAO.listarReservasFinalizadasNaoInformadasPorUsuario(cpfCnpj);

		// Verificando se a lista tem dados e exibindo no console
		if (listaReservasFinalizadas == null || listaReservasFinalizadas.isEmpty()) {
			System.out.println("A lista de reservas está vazia ou nula");
		} else {
			System.out.println("Lista de Reservas Obtida:");
			for (Reserva reserva : listaReservasFinalizadas) {
				System.out.println(reserva.exibirDados());
			}
		}

		request.setAttribute("listaReservasFinalizadas", listaReservasFinalizadas);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarReservasPorLocatario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String nomeRazaoSocial_user = request.getParameter("NomeRazaoSocial");
		List<Usuario> listaUsuario = usuarioDAO.listarUsuario();
		Usuario usuario = null;
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaUsuario == null || listaUsuario.isEmpty()) {
			System.out.println("A lista de usuarios está vazia ou nula");
		} else {
			System.out.println("Lista de Usuarios Obtida:");
			for (Usuario usuarioLista : listaUsuario) {
				if(usuarioLista.getNomeRazaoSocial_user().equalsIgnoreCase(nomeRazaoSocial_user)) {
					usuario = usuarioLista;
					break;
				}
			}
		}
		
		if(usuario==null) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type='text/javascript'>");
			out.println("alert('Usuario inexistente!');");
			out.println("</script>");
			out.close();
			response.sendRedirect("pages/usuarioDetalhes.jsp");
		} else {
			List<Reserva> listaReservasUsuario = reservaDAO.listarPorUsuario(usuario.getCpfCnpj_user());

			// Verificando se a lista tem dados e exibindo no console
			if (listaReservasUsuario == null || listaReservasUsuario.isEmpty()) {
				System.out.println("A lista de reservas está vazia ou nula");
			} else {
				System.out.println("Lista de Reservas Obtida:");
				for (Reserva reserva : listaReservasUsuario) {
					System.out.println(reserva.exibirDados());
				}
			}

			request.setAttribute("listaReservas", listaReservasUsuario);
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
			dispatcher.forward(request, response);
		}
		
	}
	
	private void listarReservasPorLocador(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String nomeRazaoSocial_user = request.getParameter("nomeRazaoSocial");
		List<Reserva> listaReservasPorLocador = reservaDAO.listarPorLocador(nomeRazaoSocial_user);

		// Verificando se a lista tem dados e exibindo no console
		if (listaReservasPorLocador == null || listaReservasPorLocador.isEmpty()) {
			System.out.println("Locador não existe ou sem reservas pelas bicicletas cadastradas");
		} else {
			System.out.println("Lista de Reservas Obtida:");
			for (Reserva reserva : listaReservasPorLocador) {
				System.out.println(reserva.exibirDados());
			}
		}

		request.setAttribute("listaReservas", listaReservasPorLocador);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
		
	}
	
	private void listarReservas(HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Reserva> listaReservas = reservaDAO.listarReservasPorStatus("");
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaReservas == null || listaReservas.isEmpty()) {
			System.out.println("A lista de reservas está vazia ou nula");
		} else {
			System.out.println("Lista de Reservas Obtida:");
			for (Reserva reserva : listaReservas) {
				System.out.println(reserva.exibirDados());
			}
		}

		request.setAttribute("listaReservas", listaReservas);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
}
