package br.com.sharebike.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.sharebike.dao.BicicletaDAO;
import br.com.sharebike.dao.DisponibilidadeDAO;
import br.com.sharebike.dao.FeedbackDAO;
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
	private DisponibilidadeDAO disponibilidadeDAO;
	
	// Ver função em amarelo para listar as reservas para ver o ranking
	
	public void init() throws ServletException{
		try {
			reservaDAO = new ReservaDAO();
			bicicletaDAO = new BicicletaDAO();
			usuarioDAO = new UsuarioDAO();
			disponibilidadeDAO = new DisponibilidadeDAO();
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
				case "exibir":
					exibirReserva(request,response);
					break;	
				case "listar":
					listarReservas(request,response);
					break;
				case "listar-por-locatario":
					listarReservasPorLocatario(request, response);
					break;
				case "listar-minhas-reservas":
					listarMinhasReservas(request, response);
					break;
				case "listar-por-locador":
					listarReservasPorLocador(request, response);
					break;
				case "listar-minhas-reservas-locador":
					listarMinhasReservasComoLocador(request, response);
					break;
				case "obter-estatisticas":
					obterEstatisticasReservas(request, response);
					break;
				case "listar-por-bicicleta":
					listarReservasPorBicicleta(request, response);
					break;
				case "listar-finaliza":
					listarReservasRanking(request, response);
					break;
				default:
					listarReservas(request, response);
					break;
			}
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
			default:
				// Redirecionar para GET para outras ações
				doGet(request, response);
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
		
		// Tornar disponibilidade indisponível quando reserva está pendente
		try {
			// Fazer chamada para DisponibilidadeController para tornar indisponível apenas o período específico
			br.com.sharebike.dao.DisponibilidadeDAO disponibilidadeDAO = new br.com.sharebike.dao.DisponibilidadeDAO();
			disponibilidadeDAO.tornarIndisponivelSeReservaPendente(id_bike, dataCheckIn_reserv, dataCheckOut_reserv);
			System.out.println("✅ Disponibilidades do período " + dataCheckIn_reserv + " a " + dataCheckOut_reserv + 
							   " tornadas indisponíveis para bicicleta ID " + id_bike);
		} catch (Exception e) {
			System.err.println("Erro ao tornar disponibilidade indisponível: " + e.getMessage());
		}
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Reserva solicitada com sucesso! O proprietário será notificado.');");
		out.println("window.location.href='" + request.getContextPath() + "/BicicletaController?action=exibir-locatario&id=" + id_bike + "';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("index.jsp");
	}
	
	private void editarReserva(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_reserv = Integer.parseInt(request.getParameter("id_reserv"));
		String status_reserv = request.getParameter("status_reserv"); // Parâmetro correto do JSP
		
		// Buscar a reserva atual para obter dados completos
		Reserva reservaAtual = reservaDAO.buscarPorId(id_reserv);
		if (reservaAtual == null) {
			response.sendRedirect(request.getContextPath() + "/ReservaController?action=listar-minhas-reservas-locador");
			return;
		}
		
		// Obter usuário logado para determinar tipo de redirecionamento
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Atualizar apenas o status da reserva
		Reserva reservaAtualizada = new Reserva(
			id_reserv, 
			reservaAtual.getDataCheckIn_reserv(), 
			reservaAtual.getDataCheckOut_reserv(), 
			status_reserv, 
			reservaAtual.isInformada_reserv(), 
			reservaAtual.getUsuario(), 
			reservaAtual.getBicicleta()
		);
		
		reservaDAO.atualizarReserva(reservaAtualizada);
		
		// Se a reserva foi negada, tornar a bicicleta disponível novamente
		if ("NEGADA".equals(status_reserv)) {
			try {
				int id_bike = reservaAtual.getBicicleta().getId_bike();
				disponibilidadeDAO.tornarDisponivelSeReservaNegada(
					id_bike, 
					reservaAtual.getDataCheckIn_reserv(), 
					reservaAtual.getDataCheckOut_reserv()
				);
				System.out.println("✅ Bicicleta ID " + id_bike + " teve as disponibilidades do período " + 
								   reservaAtual.getDataCheckIn_reserv() + " a " + reservaAtual.getDataCheckOut_reserv() + 
								   " liberadas após negação/cancelamento da reserva.");
			} catch (Exception e) {
				System.err.println("Erro ao tornar bicicleta disponível após negação/cancelamento: " + e.getMessage());
			}
		}
		
		// Determinar origem baseado no usuário logado
		String cpfUsuarioLogado = usuarioLogado.getCpfCnpj_user();
		String cpfLocatario = reservaAtual.getUsuario().getCpfCnpj_user();
		String cpfLocador = reservaAtual.getBicicleta().getUsuario().getCpfCnpj_user();
		
		String origem = "";
		if (cpfUsuarioLogado.equals(cpfLocatario)) {
			origem = "&origem=locatario";
		} else if (cpfUsuarioLogado.equals(cpfLocador)) {
			origem = "&origem=locador";
		}
		
		// Redirecionar de volta para a página de detalhes da reserva com origem correta
		response.sendRedirect(request.getContextPath() + "/ReservaController?action=exibir&id=" + id_reserv + origem);
	}
	
	private void exibirReserva(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_reserv = Integer.parseInt(request.getParameter("id"));
		
		Reserva reserva = reservaDAO.buscarPorId(id_reserv);
		
		// Verificar se a reserva existe
		if (reserva == null) {
			response.sendRedirect(request.getContextPath() + "/ReservaController?action=listar-minhas-reservas");
			return;
		}
		
		// Obter usuário logado
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Atribuindo os objetos à request
		request.setAttribute("reserva", reserva);
		
		// Verificar origem da solicitação
		String origem = request.getParameter("origem");
		
		// Verificar se o usuário logado é o locatário ou o locador
		String cpfUsuarioLogado = usuarioLogado.getCpfCnpj_user();
		String cpfLocatario = reserva.getUsuario().getCpfCnpj_user();
		String cpfLocador = reserva.getBicicleta().getUsuario().getCpfCnpj_user();
		
		// Debug para verificar origem e usuários
		System.out.println("=== DEBUG exibirReserva ===");
		System.out.println("ID da Reserva: " + id_reserv);
		System.out.println("Origem da solicitação: " + origem);
		System.out.println("CPF Usuario Logado: '" + cpfUsuarioLogado + "'");
		System.out.println("CPF Locatario: '" + cpfLocatario + "'");
		System.out.println("CPF Locador: '" + cpfLocador + "'");
		System.out.println("É Locatário? " + cpfUsuarioLogado.equals(cpfLocatario));
		System.out.println("É Locador? " + cpfUsuarioLogado.equals(cpfLocador));
		
		// Verificar se são strings não nulas e fazer trim
		if (cpfUsuarioLogado != null) cpfUsuarioLogado = cpfUsuarioLogado.trim();
		if (cpfLocatario != null) cpfLocatario = cpfLocatario.trim();
		if (cpfLocador != null) cpfLocador = cpfLocador.trim();
		
		// Verificar permissões
		boolean isLocatario = cpfUsuarioLogado.equals(cpfLocatario);
		boolean isLocador = cpfUsuarioLogado.equals(cpfLocador);
		
		if (!isLocatario && !isLocador) {
			System.out.println("❌ USUÁRIO NÃO TEM PERMISSÃO PARA VER ESTA RESERVA");
			response.sendRedirect(request.getContextPath() + "/ReservaController?action=listar-minhas-reservas");
			return;
		}
		
		// Redirecionamento inteligente baseado na origem
		if ("locador".equals(origem)) {
			// Forçar página do locador se origem for "locador"
			if (isLocador) {
				System.out.println("✅ REDIRECIONANDO PARA PÁGINA DO LOCADOR (origem: locador)");
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalheReservaLocador.jsp");
				dispatcher.forward(request, response);
			} else {
				System.out.println("❌ USUÁRIO NÃO É LOCADOR, MAS ORIGEM É 'locador' - redirecionando para locatário");
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalheReservaLocatario.jsp");
				dispatcher.forward(request, response);
			}
		} else if ("locatario".equals(origem)) {
			// Forçar página do locatário se origem for "locatario"
			if (isLocatario) {
				System.out.println("✅ REDIRECIONANDO PARA PÁGINA DO LOCATÁRIO (origem: locatario)");
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalheReservaLocatario.jsp");
				dispatcher.forward(request, response);
			} else {
				System.out.println("❌ USUÁRIO NÃO É LOCATÁRIO, MAS ORIGEM É 'locatario' - redirecionando para locador");
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalheReservaLocador.jsp");
				dispatcher.forward(request, response);
			}
		} else {
			// Lógica padrão quando não há origem específica
			if (isLocador) {
				System.out.println("✅ REDIRECIONANDO PARA PÁGINA DO LOCADOR (lógica padrão)");
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalheReservaLocador.jsp");
				dispatcher.forward(request, response);
			} else if (isLocatario) {
				System.out.println("✅ REDIRECIONANDO PARA PÁGINA DO LOCATÁRIO (lógica padrão)");
				RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalheReservaLocatario.jsp");
				dispatcher.forward(request, response);
			}
		}
	}
	
	private void listarReservasRanking(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj = request.getParameter("cpfCnpj");
		
		List<Reserva> listaReservasFinalizadas = reservaDAO.listarReservasFinalizadasNaoInformadasPorUsuario(cpfCnpj);


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
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/reservasAdm.jsp");
			dispatcher.forward(request, response);
		}
		
	}
	
	private void listarMinhasReservas(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// Obter usuário da sessão
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		
		if (usuarioLogado == null) {
			System.out.println("Usuario não logado, redirecionando para login");
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Buscar todas as reservas do usuário
		List<Reserva> todasReservas = reservaDAO.listarPorUsuario(usuarioLogado.getCpfCnpj_user());
		
		// Criar mapa para verificar quais reservas já têm feedback do locatário
		Map<Integer, Boolean> mapaFeedbackLocatario = new HashMap<>();
		if (todasReservas != null) {
			FeedbackDAO feedbackDAO = new FeedbackDAO();
			for (Reserva reserva : todasReservas) {
				// Verificar se o locatário (usuário logado) já fez feedback para esta reserva
				boolean jaFezFeedback = feedbackDAO.existeFeedbackDeAvaliadorParaReserva(
					reserva.getId_reserv(), 
					usuarioLogado.getCpfCnpj_user()
				);
				mapaFeedbackLocatario.put(reserva.getId_reserv(), jaFezFeedback);
			}
		}
		
		// Separar por status para facilitar a filtragem na JSP
		List<Reserva> reservasPendentes = new ArrayList<>();
		List<Reserva> reservasConfirmadas = new ArrayList<>();
		List<Reserva> reservasNegadas = new ArrayList<>();
		List<Reserva> reservasEmAndamento = new ArrayList<>();
		List<Reserva> reservasFinalizadas = new ArrayList<>();
		
		if (todasReservas != null) {
			for (Reserva reserva : todasReservas) {
				String status = reserva.getStatus_reserv().toUpperCase();
				switch (status) {
					case "PENDENTE":
						reservasPendentes.add(reserva);
						break;
					case "CONFIRMADA":
						reservasConfirmadas.add(reserva);
						break;
					case "NEGADA":
						reservasNegadas.add(reserva);
						break;
					case "EM ANDAMENTO":
						reservasEmAndamento.add(reserva);
						break;
					case "FINALIZADA":
						reservasFinalizadas.add(reserva);
						break;
				}
			}
		}
		
		// Atribuir todas as listas à request
		request.setAttribute("todasReservas", todasReservas);
		request.setAttribute("reservasPendentes", reservasPendentes);
		request.setAttribute("reservasConfirmadas", reservasConfirmadas);
		request.setAttribute("reservasNegadas", reservasNegadas);
		request.setAttribute("reservasEmAndamento", reservasEmAndamento);
		request.setAttribute("reservasFinalizadas", reservasFinalizadas);
		
		// *** NOVO: Adicionar mapa de feedback ***
		request.setAttribute("mapaFeedbackLocatario", mapaFeedbackLocatario);
		
		// Encaminhar para a página do locatário
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/reservasLocatario.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarReservasPorLocador(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String nomeRazaoSocial_user = request.getParameter("nomeRazaoSocial");
		List<Reserva> listaReservasPorLocador = reservaDAO.listarPorLocador(nomeRazaoSocial_user);


		request.setAttribute("listaReservas", listaReservasPorLocador);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/reservasAdm.jsp");
		dispatcher.forward(request, response);
		
	}
	
	private void listarMinhasReservasComoLocador(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// Obter usuário da sessão
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		
		System.out.println("=== DEBUG: listarMinhasReservasComoLocador ===");
		System.out.println("Usuario logado: " + (usuarioLogado != null ? usuarioLogado.getNomeRazaoSocial_user() : "NULL"));
		
		if (usuarioLogado == null) {
			System.out.println("Usuario não logado, redirecionando para login");
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Buscar todas as reservas das bicicletas do usuário (como locador)
		List<Reserva> todasReservas = reservaDAO.listarPorLocador(usuarioLogado.getCpfCnpj_user());
		System.out.println("Reservas das minhas bicicletas encontradas: " + (todasReservas != null ? todasReservas.size() : "NULL"));
		
		// Criar mapa para verificar quais reservas já têm feedback do locador
		Map<Integer, Boolean> mapaFeedbackLocador = new HashMap<>();
		if (todasReservas != null) {
			FeedbackDAO feedbackDAO = new FeedbackDAO();
			for (Reserva reserva : todasReservas) {
				// Verificar se o locador (usuário logado) já fez feedback para esta reserva
				boolean jaFezFeedback = feedbackDAO.existeFeedbackDeAvaliadorParaReserva(
					reserva.getId_reserv(), 
					usuarioLogado.getCpfCnpj_user()
				);
				mapaFeedbackLocador.put(reserva.getId_reserv(), jaFezFeedback);
			}
		}
		
		// Separar por status para facilitar a filtragem na JSP
		List<Reserva> reservasPendentes = new ArrayList<>();
		List<Reserva> reservasConfirmadas = new ArrayList<>();
		List<Reserva> reservasNegadas = new ArrayList<>();
		List<Reserva> reservasEmAndamento = new ArrayList<>();
		List<Reserva> reservasFinalizadas = new ArrayList<>();
		
		if (todasReservas != null) {
			for (Reserva reserva : todasReservas) {
				String status = reserva.getStatus_reserv().toUpperCase();
				switch (status) {
					case "PENDENTE":
						reservasPendentes.add(reserva);
						break;
					case "CONFIRMADA":
						reservasConfirmadas.add(reserva);
						break;
					case "NEGADA":
						reservasNegadas.add(reserva);
						break;
					case "EM ANDAMENTO":
						reservasEmAndamento.add(reserva);
						break;
					case "FINALIZADA":
						reservasFinalizadas.add(reserva);
						break;
				}
			}
		}
		
		// Atribuir todas as listas à request
		request.setAttribute("todasReservas", todasReservas);
		request.setAttribute("reservasPendentes", reservasPendentes);
		request.setAttribute("reservasConfirmadas", reservasConfirmadas);
		request.setAttribute("reservasNegadas", reservasNegadas);
		request.setAttribute("reservasEmAndamento", reservasEmAndamento);
		request.setAttribute("reservasFinalizadas", reservasFinalizadas);
		
		// *** NOVO: Adicionar mapa de feedback ***
		request.setAttribute("mapaFeedbackLocador", mapaFeedbackLocador);
		
		System.out.println("Dados preparados e enviando para reservasLocador.jsp");
		
		// Encaminhar para a página do locador
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/reservasLocador.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarReservas(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String status = request.getParameter("status");
		
		// Sempre buscar todas as reservas para estatísticas gerais
		List<Reserva> todasReservas = reservaDAO.listarReservasPorStatus(null);
		
		// DEBUG: Verificar se as reservas estão sendo buscadas
		System.out.println("=== DEBUG listarReservas ===");
		System.out.println("Total de reservas encontradas: " + (todasReservas != null ? todasReservas.size() : "NULL"));
		
		// Buscar reservas filtradas por status (se aplicável)
		List<Reserva> listaReservas = reservaDAO.listarReservasPorStatus(status);
		System.out.println("Reservas filtradas por status '" + status + "': " + (listaReservas != null ? listaReservas.size() : "NULL"));
		
		// Calcular estatísticas gerais baseadas em TODAS as reservas
		int totalGeral = 0;
		int pendentesGeral = 0;
		int confirmadasGeral = 0;
		int emAndamentoGeral = 0;
		int finalizadasGeral = 0;
		int negadasGeral = 0;
		
		if (todasReservas != null) {
			totalGeral = todasReservas.size();
			System.out.println("Calculando estatísticas para " + totalGeral + " reservas:");
			
			for (Reserva reserva : todasReservas) {
				String statusReserva = reserva.getStatus_reserv().toLowerCase();
				System.out.println("- Reserva ID " + reserva.getId_reserv() + " com status: '" + statusReserva + "'");
				
				switch (statusReserva) {
					case "pendente":
						pendentesGeral++;
						break;
					case "confirmada":
					case "confirmado":
						confirmadasGeral++;
						break;
					case "em andamento":
					case "em_andamento":
						emAndamentoGeral++;
						break;
					case "finalizada":
					case "finalizado":
						finalizadasGeral++;
						break;
					case "negada":
					case "negado":
						negadasGeral++;
						break;
					default:
						System.out.println("  ⚠️ Status não reconhecido: '" + statusReserva + "'");
						break;
				}
			}
		} else {
			System.out.println("❌ todasReservas é NULL!");
		}
		
		// Imprimir estatísticas calculadas
		System.out.println("Estatísticas calculadas:");
		System.out.println("- Total: " + totalGeral);
		System.out.println("- Pendentes: " + pendentesGeral);
		System.out.println("- Confirmadas: " + confirmadasGeral);
		System.out.println("- Em Andamento: " + emAndamentoGeral);
		System.out.println("- Finalizadas: " + finalizadasGeral);
		System.out.println("- Negadas: " + negadasGeral);
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaReservas == null || listaReservas.isEmpty()) {
			System.out.println("A lista de reservas está vazia ou nula para status: " + status);
		} else {
			System.out.println("Lista de Reservas Obtida para status: " + status);
			for (Reserva reserva : listaReservas) {
				System.out.println(reserva.exibirDados());
			}
		}

		// Enviar tanto as reservas filtradas quanto as estatísticas gerais
		request.setAttribute("listaReservas", listaReservas);
		request.setAttribute("totalGeral", totalGeral);
		request.setAttribute("pendentesGeral", pendentesGeral);
		request.setAttribute("confirmadasGeral", confirmadasGeral);
		request.setAttribute("emAndamentoGeral", emAndamentoGeral);
		request.setAttribute("finalizadasGeral", finalizadasGeral);
		request.setAttribute("negadasGeral", negadasGeral);
		request.setAttribute("statusFiltro", status);
		
		System.out.println("Atributos enviados para JSP - totalGeral: " + totalGeral);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/reservasAdm.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarReservasPorBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt(request.getParameter("id_bike"));
		List<Reserva> listaReservasBicicleta = reservaDAO.listarPorBicicleta(id_bike);
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaReservasBicicleta == null || listaReservasBicicleta.isEmpty()) {
			System.out.println("A lista de reservas da bicicleta está vazia ou nula");
		} else {
			System.out.println("Lista de Reservas da Bicicleta Obtida:");
			for (Reserva reserva : listaReservasBicicleta) {
				System.out.println(reserva.exibirDados());
			}
		}

		request.setAttribute("listaReservasBicicleta", listaReservasBicicleta);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/reservasBicicleta.jsp");
		dispatcher.forward(request, response);
	}
	
	// Método para buscar estatísticas de reservas seguindo o padrão do controller
	private void obterEstatisticasReservas(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int bicicletasCompartilhadas = reservaDAO.contarReservasFinalizadas();
		
		request.setAttribute("bicicletasCompartilhadas", bicicletasCompartilhadas);
		RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
		dispatcher.forward(request, response);
	}
	
}