package br.com.sharebike.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.sharebike.dao.BicicletaDAO;
import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.dao.DisponibilidadeDAO;
import br.com.sharebike.dao.ReservaDAO;
import br.com.sharebike.dao.FeedbackDAO;
import br.com.sharebike.model.Bicicleta;
import br.com.sharebike.model.Usuario;
import br.com.sharebike.model.Reserva;
import br.com.sharebike.model.Feedback;
import br.com.sharebike.model.Disponibilidade;
import br.com.sharebike.utils.ValidadorBicicleta;

@WebServlet("/BicicletaController")
public class BicicletaController extends HttpServlet{

	// Pensar em função para apenas mostrar as bicicletas que tenham disponibilidade
	// Pensar em função para deixar indisponivel uma data após chegar no dia

	private static final long serialVersionUID = 1L;
	private BicicletaDAO bicicletaDAO;
	private UsuarioDAO usuarioDAO;
	private DisponibilidadeDAO disponibilidadeDAO;
	private ReservaDAO reservaDAO;
	private FeedbackDAO feedbackDAO;

	public void init() throws ServletException{
		try {
			bicicletaDAO = new BicicletaDAO();
			usuarioDAO = new UsuarioDAO();
			disponibilidadeDAO = new DisponibilidadeDAO();
			reservaDAO = new ReservaDAO();
			feedbackDAO = new FeedbackDAO();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar DAOs", e);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		try {
			if (action == null) {
				listarBicicletas(request, response);
			} else {
				switch (action) {
				case "adicionar":
					adicionarBicicleta(request, response);
					break;
				case "editar":
					editarBicicleta(request, response);
					break;
				case "exibir":
					exibirBicicleta(request, response);
					break;
				case "form-editar":
					exibirFormEdicao(request, response);
					break;
				case "atualizar-avaliacao":
					atualizarAvaliacaoBicicleta(request, response);
					break;
				case "listar":
					listarBicicletas(request, response);
					break;
				case "lista-disponivel":
					listarBicicletasDisponiveisFiltradas(request, response);
					break;
				case "lista-locatario":
					listarBicicletasParaLocatario(request, response);
					break;
				case "exibir-locatario":
					exibirBicicletaLocatario(request, response);
					break;
				case "fazer-reserva":
					carregarFazerReserva(request, response);
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
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Configurar encoding UTF-8 antes de qualquer operação
		try {
			request.setCharacterEncoding("UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
		} catch (Exception e) {
			System.err.println("Erro ao configurar encoding: " + e.getMessage());
		}
		
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
			case "atualizar-avaliacao":
				atualizarAvaliacaoBicicleta(request, response);
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
		// Configurar encoding para UTF-8 ANTES de obter qualquer parâmetro
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String nome_bike = request.getParameter("nome");
		String foto_bike = request.getParameter("foto");
		String localEntr_bike = request.getParameter("localEntr");
		String chassi_bike = request.getParameter("chassi");
		String estadoConserv_bike = request.getParameter("estadoConserv");
		String tipo_bike = request.getParameter("tipo");
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		
		// DEBUG: Log dos parâmetros recebidos
		System.out.println("=== DEBUG BICICLETA ===");
		System.out.println("Nome: " + nome_bike);
		System.out.println("Chassi: " + chassi_bike);
		System.out.println("Tipo: " + tipo_bike);
		System.out.println("Local: " + localEntr_bike);
		System.out.println("Proprietário: " + cpfCnpj_user);
		System.out.println("=======================");
		
		// Validar dados básicos primeiro
		String erroBasico = ValidadorBicicleta.validarDadosBasicos(nome_bike, tipo_bike, chassi_bike, 
		                                                           estadoConserv_bike, localEntr_bike);
		if (erroBasico != null) {
			// Erro de validação básica - retornar para formulário
			request.getSession().setAttribute("mensagemErro", erroBasico);
			response.sendRedirect(request.getContextPath() + "/pages/cadastrarBicicleta.jsp");
			return;
		}
		
		// Validar dados únicos (chassi duplicado, nome duplicado para proprietário)
		String erroUnico = ValidadorBicicleta.validarDadosUnicosBicicleta(chassi_bike, nome_bike, cpfCnpj_user);
		if (erroUnico != null) {
			// Chassi ou nome duplicado - retornar para formulário
			request.getSession().setAttribute("mensagemErro", erroUnico);
			response.sendRedirect(request.getContextPath() + "/pages/cadastrarBicicleta.jsp");
			return;
		}
		
		// Normalizar chassi (maiúsculo e sem espaços)
		chassi_bike = ValidadorBicicleta.normalizarChassi(chassi_bike);
		
		// Converter foto_bike para null se estiver vazia
		if (foto_bike != null && foto_bike.trim().isEmpty()) {
			foto_bike = null;
		}
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj_user);
		
		Bicicleta bicicleta = new Bicicleta(nome_bike, foto_bike, localEntr_bike, chassi_bike, estadoConserv_bike, tipo_bike, usuario);
		
		try {
			bicicletaDAO.cadastrarBicicleta(bicicleta);
			
			// Adicionar mensagem de sucesso na sessão
			request.getSession().setAttribute("mensagemSucesso", "Bicicleta cadastrada com sucesso!");
			
			// Redirecionar para a página de bicicletas do locador via controller
			response.sendRedirect(request.getContextPath() + "/BicicletaController?action=minhas-bikes&cpfCnpj=" + cpfCnpj_user);
			
		} catch (Exception e) {
			System.err.println("Erro ao cadastrar bicicleta: " + e.getMessage());
			e.printStackTrace();
			
			// Adicionar mensagem de erro na sessão
			request.getSession().setAttribute("mensagemErro", "Erro ao cadastrar bicicleta: " + e.getMessage());
			
			// Redirecionar de volta para o formulário
			response.sendRedirect(request.getContextPath() + "/pages/cadastrarBicicleta.jsp");
		}
		
	}

	private void editarBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt(request.getParameter("id"));
		
		// Buscar a bicicleta existente para manter os dados não editáveis
		Bicicleta bicicletaExistente = bicicletaDAO.buscarPorId(id_bike);
		
		// Campos que o proprietário pode editar
		String foto_bike = request.getParameter("foto_bike");
		String localEntr_bike = request.getParameter("localEntr_bike");
		String estadoConserv_bike = request.getParameter("estadoConserv_bike");
		
		// Validar se os campos não estão vazios, se estiverem, manter os valores originais
		if (foto_bike == null || foto_bike.trim().isEmpty()) {
			foto_bike = bicicletaExistente.getFoto_bike();
		}
		if (localEntr_bike == null || localEntr_bike.trim().isEmpty()) {
			localEntr_bike = bicicletaExistente.getLocalEntr_bike();
		}
		if (estadoConserv_bike == null || estadoConserv_bike.trim().isEmpty()) {
			estadoConserv_bike = bicicletaExistente.getEstadoConserv_bike();
		}
		
		// Tratar avaliação nula - se for null, usar 0.0f como padrão
		Float avaliacaoOriginal = bicicletaExistente.getAvaliacao_bike();
		if (avaliacaoOriginal == null) {
			avaliacaoOriginal = 0.0f;
		}
		
		// Criar bicicleta com os dados atualizados, mantendo os campos não editáveis
		Bicicleta bicicleta = new Bicicleta(
			id_bike, 
			bicicletaExistente.getNome_bike(), // Mantém o nome original
			foto_bike, 
			localEntr_bike, 
			bicicletaExistente.getChassi_bike(), // Mantém o chassi original
			estadoConserv_bike, 
			bicicletaExistente.getTipo_bike(), // Mantém o tipo original (não editável)
			avaliacaoOriginal, // Usa a avaliação tratada (nunca null)
			bicicletaExistente.getUsuario() // Mantém o usuário original
		);
		
		bicicletaDAO.editarBicicleta(bicicleta);
		
		// Redirecionar de volta para os detalhes da bicicleta
		response.sendRedirect("BicicletaController?action=exibir&id=" + id_bike);
	}
	
	private void exibirBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt(request.getParameter("id"));
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		Usuario usuario = usuarioDAO.exibirUsuario(bicicleta.getUsuario().getCpfCnpj_user());
		
		// Buscar reservas da bicicleta
		List<Reserva> reservasBicicleta = reservaDAO.listarPorBicicleta(id_bike);
		
		// Buscar feedbacks da bicicleta
		List<Feedback> feedbacksBicicleta = feedbackDAO.listarFeedbacksPorBicicleta(id_bike);
		
		// Buscar disponibilidades da bicicleta
		List<Disponibilidade> disponibilidadesBicicleta = disponibilidadeDAO.listarPorBicicleta(id_bike);
		
		// Calcular métricas reais
		int totalReservas = reservasBicicleta != null ? reservasBicicleta.size() : 0;
		int reservasAtivas = 0;
		int totalFeedbacks = feedbacksBicicleta != null ? feedbacksBicicleta.size() : 0;
		
		if (reservasBicicleta != null) {
			for (Reserva reserva : reservasBicicleta) {
				if ("Ativa".equals(reserva.getStatus_reserv()) || "Confirmada".equals(reserva.getStatus_reserv())) {
					reservasAtivas++;
				}
			}
		}
		
		// Calcular média de avaliações dos feedbacks
		double mediaAvaliacoesFeedback = 0.0;
		if (feedbacksBicicleta != null && !feedbacksBicicleta.isEmpty()) {
			int somaAvaliacoes = 0;
			for (Feedback feedback : feedbacksBicicleta) {
				somaAvaliacoes += feedback.getAvaliacaoBike_feedb();
			}
			mediaAvaliacoesFeedback = (double) somaAvaliacoes / feedbacksBicicleta.size();
		}
		
		// Atribuindo os objetos à request
	    request.setAttribute("bicicleta", bicicleta);
	    request.setAttribute("proprietario", usuario);
	    request.setAttribute("reservasBicicleta", reservasBicicleta);
	    request.setAttribute("feedbacksBicicleta", feedbacksBicicleta);
	    request.setAttribute("disponibilidadesBicicleta", disponibilidadesBicicleta);
	    request.setAttribute("totalReservas", totalReservas);
	    request.setAttribute("reservasAtivas", reservasAtivas);
	    request.setAttribute("totalFeedbacks", totalFeedbacks);
	    request.setAttribute("mediaAvaliacoesFeedback", mediaAvaliacoesFeedback);

	    // Encaminha para a página de exibição detalhada
	    RequestDispatcher dispatcher = request.getRequestDispatcher("pages/bicicletaDetalhesLocador.jsp");
	    dispatcher.forward(request, response);
		
	}
	
	private void atualizarAvaliacaoBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id = Integer.parseInt(request.getParameter("id"));
		
		bicicletaDAO.atualizarAvaliacaoBicicleta(id);
		
		// Encaminha para a página de exibição detalhada
	    RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalhesBicicleta.jsp");
	    dispatcher.forward(request, response);
	}
	
	private void listarBicicletasProprietario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cpfCnpj_user = request.getParameter("cpfCnpj");
		List<Bicicleta> listaBicicletaProprietario = bicicletaDAO.listarBicicletasPorUsuario(cpfCnpj_user);
		
		// Criar mapa de disponibilidade para cada bicicleta
		java.util.Map<Integer, Boolean> disponibilidadeMap = new java.util.HashMap<>();
		
		// Calcular estatísticas
		int totalBicicletas = 0;
		int bicicletasDisponiveis = 0;
		int bicicletasAlugadas = 0;
		
		if (listaBicicletaProprietario != null && !listaBicicletaProprietario.isEmpty()) {
			totalBicicletas = listaBicicletaProprietario.size();
			
			for (Bicicleta bicicleta : listaBicicletaProprietario) {
				// Buscar disponibilidades ativas da bicicleta
				List<br.com.sharebike.model.Disponibilidade> disponibilidades = disponibilidadeDAO.listarPorBicicleta(bicicleta.getId_bike());
				
				boolean temDisponibilidade = false;
				if (disponibilidades != null && !disponibilidades.isEmpty()) {
					// Verificar se há pelo menos uma disponibilidade ativa
					for (br.com.sharebike.model.Disponibilidade disp : disponibilidades) {
						if (disp.isDisponivel_disp()) {
							temDisponibilidade = true;
							break;
						}
					}
				}
				
				disponibilidadeMap.put(bicicleta.getId_bike(), temDisponibilidade);
				
				if (temDisponibilidade) {
					bicicletasDisponiveis++;
				} else {
					bicicletasAlugadas++;
				}
			}
		}
		
		// Adicionar atributos para a página JSP
		request.setAttribute("listaBicicletaProprietario", listaBicicletaProprietario);
		request.setAttribute("disponibilidadeMap", disponibilidadeMap);
		request.setAttribute("totalBicicletas", totalBicicletas);
		request.setAttribute("bicicletasDisponiveis", bicicletasDisponiveis);
		request.setAttribute("bicicletasAlugadas", bicicletasAlugadas);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/bicicletasLocador.jsp");
		dispatcher.forward(request, response);
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


		request.setAttribute("listaBicicletaDisponivelFiltrada", listaBicicletaDisponivelFiltrada);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
		
	}
	
	private void listarBicicletas(HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Bicicleta> listaBicicleta = bicicletaDAO.listarBicicletas();
		
		// Criar um Map para armazenar informações de disponibilidade
		Map<Integer, Boolean> disponibilidadeMap = new HashMap<>();
		
		if (listaBicicleta != null) {
			for (Bicicleta bicicleta : listaBicicleta) {
				boolean temDisponibilidade = bicicletaDAO.verificarDisponibilidade(bicicleta.getId_bike());
				disponibilidadeMap.put(bicicleta.getId_bike(), temDisponibilidade);
			}
		}

		request.setAttribute("listaBicicleta", listaBicicleta);
		request.setAttribute("disponibilidadeMap", disponibilidadeMap);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/bicicletasAdm.jsp");
		dispatcher.forward(request, response);
	}
	
	private void exibirFormEdicao(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt(request.getParameter("id"));
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		Usuario proprietario = usuarioDAO.exibirUsuario(bicicleta.getUsuario().getCpfCnpj_user());
		
		// Atribuindo os objetos à request
	    request.setAttribute("bicicleta", bicicleta);
	    request.setAttribute("proprietario", proprietario);

	    // Encaminha para a página de edição
	    RequestDispatcher dispatcher = request.getRequestDispatcher("pages/editarBicicleta.jsp");
	    dispatcher.forward(request, response);
	}
	
	private void listarBicicletasParaLocatario(HttpServletRequest request, HttpServletResponse response) throws Exception{
	    try {
	        // Obter usuário logado da sessão
	        Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
	        
	        if (usuarioLogado == null) {
	            response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
	            return;
	        }
	        
	        // Pega os filtros da requisição
	        String cidade = request.getParameter("cidade");
	        String tipo = request.getParameter("tipo");
	        String estadoConserv = request.getParameter("estadoConserv");
	        String ordemAvalicao = request.getParameter("ordemAvalicao");
	        
	        // Obtém a lista de bicicletas disponíveis EXCLUINDO as do próprio usuário
	        BicicletaDAO bicicletaDAO = new BicicletaDAO();
	        UsuarioDAO usuarioDAO = new UsuarioDAO();
	        
	        // Passar CPF do usuário logado para excluir suas próprias bicicletas
	        List<Bicicleta> listaBicicletas = bicicletaDAO.listarBicicletasDisponiveisFiltradas(
	            cidade, tipo, estadoConserv, ordemAvalicao, usuarioLogado.getCpfCnpj_user());
	        
        // Popula informações completas do usuário para cada bicicleta
        for (Bicicleta bicicleta : listaBicicletas) {
            if (bicicleta.getUsuario() != null && bicicleta.getUsuario().getCpfCnpj_user() != null) {
                Usuario usuarioCompleto = usuarioDAO.exibirUsuario(bicicleta.getUsuario().getCpfCnpj_user());
                bicicleta.setUsuario(usuarioCompleto);
            }
        }	        // Enviar dados para a JSP
	        request.setAttribute("listaBicicletas", listaBicicletas);
	        request.setAttribute("cidadeFiltro", cidade);
	        request.setAttribute("tipoFiltro", tipo);
	        request.setAttribute("estadoConservFiltro", estadoConserv);
	        request.setAttribute("ordemAvalicaoFiltro", ordemAvalicao);
	        
	        // Encaminhar para a página do locatário
	        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/bicicletasLocatario.jsp");
	        dispatcher.forward(request, response);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Erro ao listar bicicletas: " + e.getMessage());
	    }
	}
	
	private void exibirBicicletaLocatario(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt(request.getParameter("id"));
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		Usuario proprietario = usuarioDAO.exibirUsuario(bicicleta.getUsuario().getCpfCnpj_user());
		
		// Buscar reservas da bicicleta
		List<Reserva> reservasBicicleta = reservaDAO.listarPorBicicleta(id_bike);
		
		// Buscar feedbacks da bicicleta
		List<Feedback> feedbacksBicicleta = feedbackDAO.listarFeedbacksPorBicicleta(id_bike);
		
		// Buscar disponibilidades da bicicleta
		List<Disponibilidade> disponibilidadesBicicleta = disponibilidadeDAO.listarPorBicicleta(id_bike);
		
		// Calcular métricas reais
		int totalReservas = reservasBicicleta != null ? reservasBicicleta.size() : 0;
		int reservasAtivas = 0;
		int totalFeedbacks = feedbacksBicicleta != null ? feedbacksBicicleta.size() : 0;
		
		if (reservasBicicleta != null) {
			for (Reserva reserva : reservasBicicleta) {
				if ("Ativa".equals(reserva.getStatus_reserv()) || "Confirmada".equals(reserva.getStatus_reserv())) {
					reservasAtivas++;
				}
			}
		}
		
		// Calcular média de avaliações dos feedbacks
		double mediaAvaliacoesFeedback = 0.0;
		if (feedbacksBicicleta != null && !feedbacksBicicleta.isEmpty()) {
			int somaAvaliacoes = 0;
			for (Feedback feedback : feedbacksBicicleta) {
				somaAvaliacoes += feedback.getAvaliacaoBike_feedb();
			}
			mediaAvaliacoesFeedback = (double) somaAvaliacoes / feedbacksBicicleta.size();
		}
		
		// Atribuindo os objetos à request
	    request.setAttribute("bicicleta", bicicleta);
	    request.setAttribute("proprietario", proprietario);
	    request.setAttribute("reservasBicicleta", reservasBicicleta);
	    request.setAttribute("feedbacksBicicleta", feedbacksBicicleta);
	    request.setAttribute("disponibilidadesBicicleta", disponibilidadesBicicleta);
	    request.setAttribute("totalReservas", totalReservas);
	    request.setAttribute("reservasAtivas", reservasAtivas);
	    request.setAttribute("totalFeedbacks", totalFeedbacks);
	    request.setAttribute("mediaAvaliacoesFeedback", mediaAvaliacoesFeedback);

	    // Encaminha para a página de detalhes do locatário
	    RequestDispatcher dispatcher = request.getRequestDispatcher("pages/bicicletaDetalhesLocatario.jsp");
	    dispatcher.forward(request, response);
	}
	
	private void carregarFazerReserva(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id_bike_param = request.getParameter("id");
		String disponibilidadeId = request.getParameter("disponibilidadeId");
		
		if (id_bike_param == null || id_bike_param.trim().isEmpty()) {
			response.sendRedirect("BicicletaController?action=lista-locatario");
			return;
		}
		
		int id_bike = Integer.parseInt(id_bike_param);
		
		// Buscar dados da bicicleta
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		if (bicicleta == null) {
			response.sendRedirect("BicicletaController?action=lista-locatario");
			return;
		}
		
		// Buscar dados do proprietário
		Usuario proprietario = usuarioDAO.exibirUsuario(bicicleta.getUsuario().getCpfCnpj_user());
		
		// Buscar disponibilidades da bicicleta
		List<Disponibilidade> disponibilidades = disponibilidadeDAO.listarPorBicicleta(id_bike);
		
		// Se foi passado um ID de disponibilidade específica, buscar ela
		Disponibilidade disponibilidadeSelecionada = null;
		if (disponibilidadeId != null && !disponibilidadeId.trim().isEmpty()) {
			try {
				int dispId = Integer.parseInt(disponibilidadeId);
				for (Disponibilidade disp : disponibilidades) {
					if (disp.getId_disp() == dispId) {
						disponibilidadeSelecionada = disp;
						break;
					}
				}
			} catch (NumberFormatException e) {
				// Ignorar se ID inválido
			}
		}
		
		// Preparar atributos para a JSP
		request.setAttribute("bicicleta", bicicleta);
		request.setAttribute("proprietario", proprietario);
		request.setAttribute("disponibilidades", disponibilidades);
		request.setAttribute("disponibilidadeSelecionada", disponibilidadeSelecionada);
		
		// Encaminha para a página de fazer reserva
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/fazerReserva.jsp");
		dispatcher.forward(request, response);
	}


}
