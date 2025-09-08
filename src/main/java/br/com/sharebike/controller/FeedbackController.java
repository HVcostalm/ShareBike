package br.com.sharebike.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.sharebike.dao.BicicletaDAO;
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
	private BicicletaDAO bicicletaDAO;
	
	public void init() throws ServletException{
		try {
			feedbackDAO = new FeedbackDAO();
			reservaDAO = new ReservaDAO();
			usuarioDAO = new UsuarioDAO();
			bicicletaDAO = new BicicletaDAO();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar DAOs", e);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String action = request.getParameter("action");
			if (action == null) {
				action = "listar";
			}
			
			switch (action) {
				case "pagina-locador":
					carregarPaginaLocador(request, response);
					break;
				case "pagina-locatario":
					carregarPaginaLocatario(request, response);
					break;
				case "fazer-avaliacao":
					carregarFormularioAvaliacao(request, response);
					break;
				case "fazer-avaliacao-locador":
					carregarFormularioAvaliacaoLocador(request, response);
					break;
				case "exibir":
					exibirFeedback(request, response);
					break;
				case "listar":
					listarFeedbacks(request, response);
					break;
				case "listarFeedbacksPorAvaliado":
					listarFeedbacksPorAvaliado(request, response);
					break;
				case "listarFeedbacksPorAvaliador":
					listarFeedbacksPorAvaliador(request, response);
					break;
				case "listarFeedbacksPorBicicleta":
					listarFeedbacksPorBicicleta(request, response);
					break;
				case "listar-para-detalhes":
					listarFeedbacksUsuarioDetalhes(request, response);
					break;
				default:
					listarFeedbacks(request, response);
					break;
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// Configurar codificação UTF-8 para receber parâmetros corretamente
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String action = request.getParameter("action");
		try {
			switch(action) {
			case "adicionar":
				adicionarFeedback(request, response);
				break;
			case "adicionar-locador":
				adicionarFeedbackLocador(request, response);
				break;
			case "adicionar-locatario":
				adicionarFeedbackLocatario(request, response);
				break;
			case "exibir":
				exibirFeedback(request, response);
				break;
			case "listar":
				listarFeedbacks(request,response);
				break;
			case "listarFeedbacksPorAvaliado":
				listarFeedbacksPorAvaliado(request, response);
				break;
			case "listarFeedbacksPorAvaliador":
				listarFeedbacksPorAvaliador(request, response);
				break;
			case "listarFeedbacksPorBicicleta":
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
	
	private void carregarPaginaLocador(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Obter usuário logado da sessão
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Verificar se foi passado um ID de reserva específico
		String reservaIdParam = request.getParameter("reservaId");
		if (reservaIdParam != null && !reservaIdParam.isEmpty()) {
			// Se foi passado um ID de reserva, filtrar apenas essa reserva
			try {
				int reservaId = Integer.parseInt(reservaIdParam);
				request.setAttribute("reservaEspecifica", reservaId);
			} catch (NumberFormatException e) {
				System.err.println("ID de reserva inválido: " + reservaIdParam);
			}
		}
		
		// Buscar reservas finalizadas das bicicletas do usuário (como locador)
		List<Reserva> reservasFinalizadas = reservaDAO.listarPorLocador(usuarioLogado.getCpfCnpj_user());
		
		// Filtrar apenas reservas finalizadas
		List<Reserva> reservasPendentesAvaliacao = new ArrayList<>();
		List<Feedback> feedbacksRealizados = new ArrayList<>();
		List<Feedback> feedbacksRecebidos = new ArrayList<>();
		
		// Buscar todos os feedbacks e filtrar os do locador
		List<Feedback> todosFeedbacks = feedbackDAO.listarFeedbacks();
		String cpfCnpjLocador = usuarioLogado.getCpfCnpj_user();
		
		for (Feedback feedback : todosFeedbacks) {
			if (feedback.getAvaliador_Usuario().getCpfCnpj_user().equals(cpfCnpjLocador)) {
				feedbacksRealizados.add(feedback);
			}
			if (feedback.getAvaliado_Usuario().getCpfCnpj_user().equals(cpfCnpjLocador)) {
				feedbacksRecebidos.add(feedback);
			}
		}
		
		if (reservasFinalizadas != null) {
			for (Reserva reserva : reservasFinalizadas) {
				if ("FINALIZADA".equalsIgnoreCase(reserva.getStatus_reserv())) {
					reservasPendentesAvaliacao.add(reserva);
				}
			}
		}
		
		// Atribuir dados à request
		request.setAttribute("reservasPendentesAvaliacao", reservasPendentesAvaliacao);
		request.setAttribute("feedbacksRealizados", feedbacksRealizados);
		request.setAttribute("feedbacksRecebidos", feedbacksRecebidos);
		
		// Encaminhar para a página do locador (dashboard)
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/feedbackLocador.jsp");
		dispatcher.forward(request, response);
	}
	
	private void carregarPaginaLocatario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Obter usuário logado
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Verificar se foi passado um ID de reserva específico
		String reservaIdParam = request.getParameter("reservaId");
		if (reservaIdParam != null && !reservaIdParam.isEmpty()) {
			// Se foi passado um ID de reserva, filtrar apenas essa reserva
			try {
				int reservaId = Integer.parseInt(reservaIdParam);
				request.setAttribute("reservaEspecifica", reservaId);
			} catch (NumberFormatException e) {
				System.err.println("ID de reserva inválido: " + reservaIdParam);
			}
		}
		
		String cpfCnpjLocatario = usuarioLogado.getCpfCnpj_user();
		
		// Buscar todas as reservas do locatário e filtrar as finalizadas
		List<Reserva> todasReservas = reservaDAO.listarPorUsuario(cpfCnpjLocatario);
		List<Reserva> reservasFinalizadas = new ArrayList<>();
		
		if (todasReservas != null) {
			for (Reserva reserva : todasReservas) {
				if ("FINALIZADA".equalsIgnoreCase(reserva.getStatus_reserv())) {
					reservasFinalizadas.add(reserva);
				}
			}
		}
		
		// Buscar todos os feedbacks e filtrar os do locatário
		List<Feedback> todosFeedbacks = feedbackDAO.listarFeedbacks();
		List<Feedback> feedbacksFeitos = new ArrayList<>();
		List<Feedback> feedbacksRecebidos = new ArrayList<>();
		
		for (Feedback feedback : todosFeedbacks) {
			if (feedback.getAvaliador_Usuario().getCpfCnpj_user().equals(cpfCnpjLocatario)) {
				feedbacksFeitos.add(feedback);
			}
			if (feedback.getAvaliado_Usuario().getCpfCnpj_user().equals(cpfCnpjLocatario)) {
				feedbacksRecebidos.add(feedback);
			}
		}
		
		// Definir atributos para a JSP
		request.setAttribute("reservasFinalizadas", reservasFinalizadas);
		request.setAttribute("feedbacksFeitos", feedbacksFeitos);
		request.setAttribute("feedbacksRecebidos", feedbacksRecebidos);
		
		// Encaminhar para a página do locatário
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/feedbackLocatario.jsp");
		dispatcher.forward(request, response);
	}
	
	private void carregarFormularioAvaliacao(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Obter usuário logado
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Obter ID da reserva
		String reservaIdParam = request.getParameter("reservaId");
		if (reservaIdParam == null || reservaIdParam.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locatario");
			return;
		}
		
		try {
			int reservaId = Integer.parseInt(reservaIdParam);
			Reserva reserva = reservaDAO.buscarPorId(reservaId);
			
			if (reserva == null) {
				response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locatario");
				return;
			}
			
			// Verificar se a reserva pertence ao usuário logado
			if (!reserva.getUsuario().getCpfCnpj_user().equals(usuarioLogado.getCpfCnpj_user())) {
				response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locatario");
				return;
			}
			
			// Enviar reserva para a página de formulário
			request.setAttribute("reserva", reserva);
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/fazerFeedbackLocatario.jsp");
			dispatcher.forward(request, response);
			
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locatario");
		}
	}
	
	private void carregarFormularioAvaliacaoLocador(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Obter usuário logado da sessão (igual aos outros métodos)
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Obter ID da reserva específica (seguindo o padrão dos outros métodos)
		String reservaIdParam = request.getParameter("reservaId");
		if (reservaIdParam == null || reservaIdParam.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locador");
			return;
		}
		
		try {
			int reservaId = Integer.parseInt(reservaIdParam);
			Reserva reserva = reservaDAO.buscarPorId(reservaId);
			
			if (reserva == null) {
				response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locador");
				return;
			}
			
			// Verificar se a reserva é de uma bicicleta do locador logado
			if (!reserva.getBicicleta().getUsuario().getCpfCnpj_user().equals(usuarioLogado.getCpfCnpj_user())) {
				response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locador");
				return;
			}
			
			// Enviar reserva para a página de formulário
			request.setAttribute("reserva", reserva);
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/fazerFeedbackLocador.jsp");
			dispatcher.forward(request, response);
			
		} catch (NumberFormatException e) {
			response.sendRedirect(request.getContextPath() + "/FeedbackController?action=pagina-locador");
		}
	}
	
	private void adicionarFeedback(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int avaliacaoUser_feedb = Integer.parseInt(request.getParameter("avaliacaoUser"));
		int avaliacaoBike_feedb = 0; // Locador não avalia a própria bicicleta
		String obsBike_feedb = ""; // Locador não comenta sobre a própria bicicleta
		String obsUser_feedb = request.getParameter("obsUser");
		LocalDateTime data_feedb = LocalDateTime.now(); // Data atual
		
		// Qualidades do locatário (checkboxes)
		boolean confComp_feedb = request.getParameter("confComp") != null;
		boolean comunicBoa_feedb = request.getParameter("comunicBoa") != null;
		boolean funcional_feedb = request.getParameter("funcional") != null;
		boolean manutencao_feedb = request.getParameter("manutencao") != null;
		
		int id_reserv = Integer.parseInt(request.getParameter("id_reserv"));
		String cpfCnpjAvaliado = request.getParameter("cpfCnpjAvaliado"); // CPF do locatário
		
		// Obter usuário logado (locador/avaliador)
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		Reserva reserva = reservaDAO.buscarPorId(id_reserv);
		Usuario avaliado_Usuario = usuarioDAO.exibirUsuario(cpfCnpjAvaliado);
		Usuario avaliador_Usuario = usuarioLogado; // O usuário logado é quem está avaliando
		
		Feedback feedback = new Feedback(avaliacaoUser_feedb, avaliacaoBike_feedb, obsBike_feedb, obsUser_feedb,
				data_feedb, confComp_feedb, comunicBoa_feedb, funcional_feedb, manutencao_feedb, reserva, 
				avaliado_Usuario, avaliador_Usuario);
		
		feedbackDAO.cadastrarFeedback(feedback);
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Feedback realizado com sucesso!');");
		out.println("window.location.href='" + request.getContextPath() + "/FeedbackController?action=pagina-locador';");
		out.println("</script>");
		out.close();
	}
	
	private void adicionarFeedbackLocador(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int avaliacaoUser_feedb = Integer.parseInt(request.getParameter("avaliacaoUser")); // Avaliação do locatário
		int avaliacaoBike_feedb = Integer.parseInt(request.getParameter("avaliacaoBike")); // Avaliação da bicicleta
		String obsBike_feedb = request.getParameter("obsBike"); // Comentário sobre a bicicleta
		String obsUser_feedb = request.getParameter("obsUser"); // Comentário sobre o locatário
		LocalDateTime data_feedb = LocalDateTime.now(); // Data atual
		
		// Qualidades do locatário (checkboxes)
		boolean confComp_feedb = request.getParameter("confComp") != null;
		boolean comunicBoa_feedb = request.getParameter("comunicBoa") != null;
		boolean funcional_feedb = request.getParameter("funcional") != null;
		boolean manutencao_feedb = request.getParameter("manutencao") != null;
		
		int id_reserv = Integer.parseInt(request.getParameter("id_reserv"));
		String cpfCnpjAvaliado = request.getParameter("cpfCnpjAvaliado"); // CPF do locatário
		
		// Obter usuário logado (locador/avaliador)
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		Reserva reserva = reservaDAO.buscarPorId(id_reserv);
		Usuario avaliado_Usuario = usuarioDAO.exibirUsuario(cpfCnpjAvaliado);
		Usuario avaliador_Usuario = usuarioLogado; // O usuário logado é quem está avaliando
		
		Feedback feedback = new Feedback(avaliacaoUser_feedb, avaliacaoBike_feedb, obsBike_feedb, obsUser_feedb,
				data_feedb, confComp_feedb, comunicBoa_feedb, funcional_feedb, manutencao_feedb, reserva, 
				avaliado_Usuario, avaliador_Usuario);
		
		feedbackDAO.cadastrarFeedback(feedback);
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Feedback realizado com sucesso!');");
		out.println("window.location.href='" + request.getContextPath() + "/FeedbackController?action=pagina-locador';");
		out.println("</script>");
		out.close();
	}
	
	private void adicionarFeedbackLocatario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int avaliacaoUser_feedb = Integer.parseInt(request.getParameter("avaliacaoUser")); // Avaliação do locador 
		int avaliacaoBike_feedb = Integer.parseInt(request.getParameter("avaliacaoBike")); // Avaliação da bicicleta
		String obsBike_feedb = request.getParameter("obsBike"); // Comentário sobre a bicicleta
		String obsUser_feedb = request.getParameter("obsUser"); // Comentário sobre o locador
		LocalDateTime data_feedb = LocalDateTime.now(); // Data atual
		
		// Qualidades da bicicleta/locador (checkboxes)
		boolean confComp_feedb = request.getParameter("confComp") != null;
		boolean comunicBoa_feedb = request.getParameter("comunicBoa") != null;
		boolean funcional_feedb = request.getParameter("funcional") != null;
		boolean manutencao_feedb = request.getParameter("manutencao") != null;
		
		int id_reserv = Integer.parseInt(request.getParameter("id_reserv"));
		String cpfCnpjAvaliado = request.getParameter("cpfCnpjAvaliado"); // CPF do locador (proprietário da bike)
		
		// Obter usuário logado (locatário/avaliador)
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		Reserva reserva = reservaDAO.buscarPorId(id_reserv);
		Usuario avaliado_Usuario = usuarioDAO.exibirUsuario(cpfCnpjAvaliado); // Locador sendo avaliado
		Usuario avaliador_Usuario = usuarioLogado; // O locatário logado é quem está avaliando
		
		Feedback feedback = new Feedback(avaliacaoUser_feedb, avaliacaoBike_feedb, obsBike_feedb, obsUser_feedb,
				data_feedb, confComp_feedb, comunicBoa_feedb, funcional_feedb, manutencao_feedb, reserva, 
				avaliado_Usuario, avaliador_Usuario);
		
		feedbackDAO.cadastrarFeedback(feedback);
		
		// *** ATUALIZAR AVALIAÇÃO DA BICICLETA ***
		// Quando o locatário avalia a bicicleta, precisamos recalcular a média
		if (avaliacaoBike_feedb > 0 && reserva != null && reserva.getBicicleta() != null) {
			bicicletaDAO.atualizarAvaliacaoBicicleta(reserva.getBicicleta().getId_bike());
		}
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Feedback realizado com sucesso!');");
		out.println("window.location.href='" + request.getContextPath() + "/FeedbackController?action=pagina-locatario';");
		out.println("</script>");
		out.close();
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
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/perfil.jsp");
		dispatcher.forward(request, response);
	}

	
	private void listarFeedbacksPorAvaliado(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String nomeAvaliado = request.getParameter("nomeAvaliado");
		List<Feedback> listaFeedbacksAvaliado;
		
		// Se nomeAvaliado for fornecido, buscar por nome, senão usar o método original por CPF
		if (nomeAvaliado != null && !nomeAvaliado.trim().isEmpty()) {
			listaFeedbacksAvaliado = feedbackDAO.listarPorNomeAvaliado(nomeAvaliado);
		} else {
			String cpfCnpjAvaliado = request.getParameter("cpfCnpjAvaliado");
			listaFeedbacksAvaliado = feedbackDAO.listarPorAvaliado(cpfCnpjAvaliado);
		}
		

		request.setAttribute("listaFeedbacks", listaFeedbacksAvaliado);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/feedbackAdm.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarFeedbacksPorBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String nomeBicicleta = request.getParameter("nomeBicicleta");
		List<Feedback> listaFeedbacksBicicleta;
		
		// Se nomeBicicleta for fornecido, buscar por nome, senão usar o método original por ID
		if (nomeBicicleta != null && !nomeBicicleta.trim().isEmpty()) {
			listaFeedbacksBicicleta = feedbackDAO.listarPorNomeBicicleta(nomeBicicleta);
		} else {
			String idBikeParam = request.getParameter("id_bike");
			if (idBikeParam != null) {
				int id_bike = Integer.parseInt(idBikeParam);
				listaFeedbacksBicicleta = feedbackDAO.listarFeedbacksPorBicicleta(id_bike);
			} else {
				listaFeedbacksBicicleta = new ArrayList<>();
			}
		}
		

		request.setAttribute("listaFeedbacks", listaFeedbacksBicicleta);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/feedbackAdm.jsp");
		dispatcher.forward(request, response);
		
	}
	
	private void listarFeedbacksPorAvaliador(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String nomeAvaliador = request.getParameter("nomeAvaliador");
		List<Feedback> listaFeedbacksAvaliador;
		
		// Se nomeAvaliador for fornecido, buscar por nome, senão usar o método original por CPF
		if (nomeAvaliador != null && !nomeAvaliador.trim().isEmpty()) {
			listaFeedbacksAvaliador = feedbackDAO.listarPorNomeAvaliador(nomeAvaliador);
		} else {
			String cpfCnpjAvaliador = request.getParameter("cpfCnpjAvaliador");
			listaFeedbacksAvaliador = feedbackDAO.listarPorAvaliador(cpfCnpjAvaliador);
		}
		

		request.setAttribute("listaFeedbacks", listaFeedbacksAvaliador);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/feedbackAdm.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarFeedbacks(HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Feedback> listaFeedbacks = feedbackDAO.listarFeedbacks();
		

		request.setAttribute("listaFeedbacks", listaFeedbacks);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/feedbackAdm.jsp");
		dispatcher.forward(request, response);
	}
	
	
}
