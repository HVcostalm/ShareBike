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

import br.com.sharebike.dao.FeedbackDAO;
import br.com.sharebike.dao.ReservaDAO;
import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.model.Feedback;
import br.com.sharebike.model.Reserva;
import br.com.sharebike.model.Usuario;

@WebServlet("/FeedbackController")
public class FeedbackController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private FeedbackDAO feedbackDAO;
	private ReservaDAO reservaDAO;
	private UsuarioDAO usuarioDAO;
	
	public void init() throws ServletException{
		try {
			feedbackDAO = new FeedbackDAO();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar FeedbackDAO", e);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			listarFeedbacks(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String action = request.getParameter("action");
		try {
			switch(action) {
			case "adicionar":
				adicionarFeedback(request, response);
				break;
			case "exibir":
				exibirFeedback(request, response);
				break;
			case "listar":
				listarFeedbacks(request,response);
				break;
			case "listar-por-avaliado":
				listarFeedbacksPorAvaliado(request, response);
				break;
			case "listar-por-avaliador":
				listarFeedbacksPorAvaliador(request, response);
				break;
			case "listar-por-bicicleta":
				listarFeedbacksPorBicicleta(request, response);
				break;
			case "listar-para-detalhes":
				listarFeedbacksUsuarioDetalhes(request, response);
				break;
			default:
				listarFeedbacks(request, response);
				break;
			}
		}catch (Exception e){
			throw new ServletException(e);
		}
	}
	
	private void adicionarFeedback(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int avaliacaoUser_feedb = Integer.parseInt(request.getParameter("avaliacaoUser"));
		int avaliacaoBike_feedb = Integer.parseInt(request.getParameter("avaliacaoBike"));
		String obsBike_feedb = request.getParameter("obsBike");
		String obsUser_feedb = request.getParameter("obsUser");
		LocalDateTime data_feedb = LocalDateTime.parse(request.getParameter("data"));
		boolean confComp_feedb = Boolean.parseBoolean(request.getParameter("confComp"));
		boolean comunicBoa_feedb = Boolean.parseBoolean(request.getParameter("comunicBoa"));
		boolean funcional_feedb = Boolean.parseBoolean(request.getParameter("funcional"));
		boolean manutencao_feedb = Boolean.parseBoolean(request.getParameter("manutencao"));
		int id_reserv = Integer.parseInt(request.getParameter("id_reserv"));
		String cpfCnpjAvaliado = request.getParameter("cpfCnpjAvaliado");
		String cpfCnpjAvaliador = request.getParameter("cpfCnpjAvaliador");
		
		Reserva reserva = reservaDAO.buscarPorId(id_reserv);
		Usuario avaliado_Usuario = usuarioDAO.exibirUsuario(cpfCnpjAvaliado);
		Usuario avaliador_Usuario = usuarioDAO.exibirUsuario(cpfCnpjAvaliador);
		
		Feedback feedback = new Feedback(avaliacaoUser_feedb, avaliacaoBike_feedb, obsBike_feedb, obsUser_feedb,
				data_feedb, confComp_feedb, comunicBoa_feedb, funcional_feedb, manutencao_feedb, reserva, 
				avaliado_Usuario, avaliador_Usuario);
		
		feedbackDAO.cadastrarFeedback(feedback);
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Feedback realizado');");
		out.println("window.location.href='pages/principal.jsp';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("index.jsp");
	}
	
	private void exibirFeedback(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_feedb = Integer.parseInt(request.getParameter("id"));
		
		Feedback feedback = feedbackDAO.buscarPorId(id_feedb);
		
		// Atribuindo os objetos à request
		request.setAttribute("Feedback", feedback);

		// Encaminha para a página de exibição detalhada
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalhesFeedback.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarFeedbacksUsuarioDetalhes(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String cpfCnpjAvaliado = request.getParameter("cpfCnpjAvaliado");
		List<Feedback> listaFeedbacksAvaliado = feedbackDAO.listarPorAvaliado(cpfCnpjAvaliado);

		request.setAttribute("listaFeedbacksUsuario", listaFeedbacksAvaliado);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/Perfil.jsp");
		dispatcher.forward(request, response);
	}

	
	private void listarFeedbacksPorAvaliado(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpjAvaliado = request.getParameter("cpfCnpjAvaliado");
		List<Feedback> listaFeedbacksAvaliado = feedbackDAO.listarPorAvaliado(cpfCnpjAvaliado);
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaFeedbacksAvaliado == null || listaFeedbacksAvaliado.isEmpty()) {
			System.out.println("Este usuário não tem feedbacks");
		} else {
			System.out.println("Lista de feedbacks Obtida:");
			for (Feedback feedback : listaFeedbacksAvaliado) {
				System.out.println(feedback.exibirDados());
			}
		}

		request.setAttribute("listaFeedbacksAvaliado", listaFeedbacksAvaliado);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarFeedbacksPorBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt(request.getParameter("id_bike"));
		List<Feedback> listaFeedbacksBicicleta = feedbackDAO.listarFeedbacksPorBicicleta(id_bike);
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaFeedbacksBicicleta == null || listaFeedbacksBicicleta.isEmpty()) {
			System.out.println("Esta bicicleta não tem feedbacks");
		} else {
			System.out.println("Lista de feedbacks Obtida:");
			for (Feedback feedback : listaFeedbacksBicicleta) {
				System.out.println(feedback.exibirDados());
			}
		}

		request.setAttribute("listaFeedbacksBicicleta", listaFeedbacksBicicleta);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
		
	}
	
	private void listarFeedbacksPorAvaliador(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpjAvaliador = request.getParameter("cpfCnpjAvaliador");
		List<Feedback> listaFeedbacksAvaliador = feedbackDAO.listarPorAvaliador(cpfCnpjAvaliador);
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaFeedbacksAvaliador == null || listaFeedbacksAvaliador.isEmpty()) {
			System.out.println("Este usuário não realizou feedbacks");
		} else {
			System.out.println("Lista de feedbacks Obtida:");
			for (Feedback feedback : listaFeedbacksAvaliador) {
				System.out.println(feedback.exibirDados());
			}
		}

		request.setAttribute("listaFeedbacksAvaliado", listaFeedbacksAvaliador);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarFeedbacks(HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Feedback> listaFeedbacks = feedbackDAO.listarFeedbacks();
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaFeedbacks == null || listaFeedbacks.isEmpty()) {
			System.out.println("A lista de feedbacks está vazia ou nula");
		} else {
			System.out.println("Lista de feedbacks Obtida:");
			for (Feedback feedback : listaFeedbacks) {
				System.out.println(feedback.exibirDados());
			}
		}

		request.setAttribute("listaFeedbacks", listaFeedbacks);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
}
