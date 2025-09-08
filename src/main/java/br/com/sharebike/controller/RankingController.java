package br.com.sharebike.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.nio.file.Files;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.sharebike.dao.RankingDAO;
import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.dao.ReservaDAO;
import br.com.sharebike.model.Ranking;
import br.com.sharebike.model.Usuario;
import br.com.sharebike.model.Reserva;

@WebServlet("/RankingController")
public class RankingController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private RankingDAO rankingDAO;
	private UsuarioDAO usuarioDAO;
	private ReservaDAO reservaDAO;
	
	public void init() throws ServletException{
		try {
			rankingDAO = new RankingDAO();
			usuarioDAO = new UsuarioDAO();
			reservaDAO = new ReservaDAO();
			
			//RankingScheduler.iniciar();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar RankingDAO", e);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String action = request.getParameter("action");
			if (action == null) {
				action = "listar";
			}
			
			switch (action) {
				case "pagina-locatario":
					carregarPaginaLocatario(request, response);
					break;
				case "informar-distancia":
					carregarPaginaInformarDistancia(request, response);
					break;
				default:
					listarRankings(request, response);
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
				adicionarRanking(request, response);
				break;
			case "editar":
				editarRanking(request, response);
				break;
			case "processar-distancia":
				processarDistancia(request, response);
				break;
			case "processar-distancia-bike-propria":
				processarDistanciaBikePropria(request, response);
				break;
			case "exibir-ranking-usuario":
				exibirRankingUsuario(request, response);
				break;
			case "listar-ranking-filtro":
				listarRankingsFiltrados(request, response);
				break;
			case "pagina-locatario-filtro":
				listarRankingsFiltradosLocatario(request, response);
				break;
			case "listar":
				listarRankings(request,response);
				break;
			default:
				listarRankings(request, response);
				break;
			}
		}catch (Exception e){
			throw new ServletException(e);
		}
	}
	
	private void adicionarRanking(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// Primeiro tentar getAttribute (vindo de forward), depois getParameter (vindo de form)
		String cidade_rank = (String) request.getAttribute("cidade");
		if (cidade_rank == null) cidade_rank = request.getParameter("cidade");
		
		String estado_rank = (String) request.getAttribute("estado");
		if (estado_rank == null) estado_rank = request.getParameter("estado");
		
		String pais_rank = (String) request.getAttribute("pais");
		if (pais_rank == null) pais_rank = request.getParameter("pais");
		
		// Para pontos, tentar getAttribute primeiro
		String pontosStr = (String) request.getAttribute("pontos");
		if (pontosStr == null) pontosStr = request.getParameter("pontos");
		float pontos_rank = Float.parseFloat(pontosStr);
		
		String pontosSemanaStr = (String) request.getAttribute("pontosSemana");
		if (pontosSemanaStr == null) pontosSemanaStr = request.getParameter("pontosSemana");
		float pontosSemana_rank = Float.parseFloat(pontosSemanaStr);
		
		// Aceitar tanto 'cpfCnpj' quanto 'usuario' para compatibilidade
		String cpfCnpj = (String) request.getAttribute("usuario");
		if (cpfCnpj == null) cpfCnpj = request.getParameter("cpfCnpj");
		if (cpfCnpj == null) cpfCnpj = request.getParameter("usuario");
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj);
		
		Ranking ranking = new Ranking(cidade_rank, estado_rank, pais_rank, pontos_rank, pontosSemana_rank, usuario);
		
		rankingDAO.cadastrarRanking(ranking);
		
		// Resposta padrão para chamadas diretas
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Pontos calculados');");
		out.println("window.location.href='pages/principal.jsp';");
		out.println("</script>");
		out.close();
	}
	
	private void carregarPaginaLocatario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Obter usuário logado da sessão
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Buscar ranking do usuário logado
		Ranking rankingUsuarioLogado = rankingDAO.buscarPorUsuario(usuarioLogado.getCpfCnpj_user());
		
		// Buscar listas de rankings
		List<Ranking> listaRankingTopGeral = rankingDAO.listarTopGeral(10);
		List<Ranking> listaRankingTopSemana = rankingDAO.listarTopSemana(10);
		List<Ranking> listaRankings = rankingDAO.listarTodos();
		
		// Calcular posição do usuário no ranking geral usando método otimizado
		int posicaoUsuario = 0;
		if (rankingUsuarioLogado != null) {
			posicaoUsuario = rankingDAO.obterPosicaoUsuario(usuarioLogado.getCpfCnpj_user());
		}
		
		// Buscar localidades únicas para filtros (simplificado)
		// Como não temos os métodos específicos, vamos extrair das listas existentes
		// Isso pode ser otimizado posteriormente
		
		// Definir atributos para a JSP
		request.setAttribute("usuarioLogado", usuarioLogado);
		request.setAttribute("rankingUsuarioLogado", rankingUsuarioLogado);
		request.setAttribute("posicaoUsuario", posicaoUsuario);
		request.setAttribute("listaRankingTopGeral", listaRankingTopGeral);
		request.setAttribute("listaRankingTopSemana", listaRankingTopSemana);
		request.setAttribute("listaRankings", listaRankings);
		
		// Encaminhar para a página do locatário
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/rankingLocatario.jsp");
		dispatcher.forward(request, response);
	}
	
	private void carregarPaginaInformarDistancia(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Obter usuário logado da sessão
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Buscar reservas não informadas para o usuário
		List<Reserva> reservasNaoInformadas = reservaDAO.listarReservasFinalizadasNaoInformadasPorUsuario(usuarioLogado.getCpfCnpj_user());
		
		// Definir atributos para a JSP
		request.setAttribute("reservasNaoInformadas", reservasNaoInformadas);
		request.setAttribute("usuarioLogado", usuarioLogado);
		
		// Encaminhar para a página de informar distância
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/informarDistancia.jsp");
		dispatcher.forward(request, response);
	}
	
	private void processarDistancia(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Obter usuário logado
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		try {
			// Obter parâmetros do formulário
			int idReserva = Integer.parseInt(request.getParameter("idReserva"));
			double distancia = Double.parseDouble(request.getParameter("distancia"));
			
			// Validar distância
			if (distancia <= 0 || distancia > 10) {
				request.setAttribute("erro", "Distância deve estar entre 0.1 e 10 km!");
				carregarPaginaInformarDistancia(request, response);
				return;
			}
			
			// Converter distância para pontos (1 km = 1 ponto)
			int pontosGanhos = (int) Math.floor(distancia);
			
			// Verificar se usuário já tem ranking
			Ranking rankingExistente = rankingDAO.buscarPorUsuario(usuarioLogado.getCpfCnpj_user());
			
			if (rankingExistente != null) {
				// Usuário já tem ranking - somar pontos aos existentes
				int pontosAtuais = (int) rankingExistente.getPontos_rank();
				int pontosSemanaAtuais = (int) rankingExistente.getPontosSemana_rank();
				
				int novosPontosTotais = pontosAtuais + pontosGanhos;
				int novosPontosSemana = pontosSemanaAtuais + pontosGanhos;
				
				// Atualizar ranking existente
				Ranking rankingAtualizado = new Ranking(
					rankingExistente.getCidade_rank(),
					rankingExistente.getEstado_rank(),
					rankingExistente.getPais_rank(),
					novosPontosTotais,
					novosPontosSemana,
					usuarioLogado
				);
				rankingAtualizado.setId_rank(rankingExistente.getId_rank());
				
				rankingDAO.atualizarRanking(rankingAtualizado);
			} else {
				// Primeira vez - criar novo ranking
				Ranking novoRanking = new Ranking(
					usuarioLogado.getCidade_user(),
					usuarioLogado.getEstado_user(),
					usuarioLogado.getPais_user(),
					pontosGanhos,
					pontosGanhos,
					usuarioLogado
				);
				
				rankingDAO.cadastrarRanking(novoRanking);
			}
			
			// Atualizar status da reserva como informada
			boolean sucessoReserva = reservaDAO.atualizarInformadaReserva(idReserva);
			
			if (sucessoReserva) {
				// Sucesso - redirecionar com mensagem
				String mensagem = "Distância informada com sucesso! Você ganhou " + pontosGanhos + " pontos!";
				response.sendRedirect(request.getContextPath() + "/RankingController?action=informar-distancia&sucesso=" + 
					java.net.URLEncoder.encode(mensagem, "UTF-8"));
			} else {
				request.setAttribute("erro", "Erro ao atualizar reserva!");
				carregarPaginaInformarDistancia(request, response);
			}
			
		} catch (NumberFormatException e) {
			request.setAttribute("erro", "Dados inválidos fornecidos!");
			carregarPaginaInformarDistancia(request, response);
		} catch (Exception e) {
			request.setAttribute("erro", "Erro ao processar informação: " + e.getMessage());
			e.printStackTrace();
			carregarPaginaInformarDistancia(request, response);
		}
	}
	
	private void processarDistanciaBikePropria(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Obter usuário logado
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Verificar se o usuário possui bike própria
		if (!usuarioLogado.isPossuiBike_user()) {
			request.setAttribute("erro", "Você não possui bike própria cadastrada!");
			carregarPaginaInformarDistancia(request, response);
			return;
		}
		
		// *** CONTROLE POR ARQUIVO TEMPORÁRIO ***
		// Verificar se já informou distância de bike própria hoje
		if (jaInformouBikePropriaHoje(usuarioLogado.getCpfCnpj_user())) {
			request.setAttribute("erro", "Você já informou distância com sua bike hoje! Tente novamente amanhã.");
			carregarPaginaInformarDistancia(request, response);
			return;
		}
		
		try {
			// Obter parâmetros do formulário
			double distancia = Double.parseDouble(request.getParameter("distancia"));
			
			// Validar distância
			if (distancia <= 0 || distancia > 10) {
				request.setAttribute("erro", "Distância deve estar entre 0.1 e 10 km!");
				carregarPaginaInformarDistancia(request, response);
				return;
			}
			
			// Converter distância para pontos (1 km = 1 ponto)
			int pontosGanhos = (int) Math.floor(distancia);
			
			// Verificar se usuário já tem ranking
			Ranking rankingExistente = rankingDAO.buscarPorUsuario(usuarioLogado.getCpfCnpj_user());
			
			if (rankingExistente != null) {
				// Usuário já tem ranking - somar pontos aos existentes
				int pontosAtuais = (int) rankingExistente.getPontos_rank();
				int pontosSemanaAtuais = (int) rankingExistente.getPontosSemana_rank();
				
				int novosPontosTotais = pontosAtuais + pontosGanhos;
				int novosPontosSemana = pontosSemanaAtuais + pontosGanhos;
				
				// Atualizar ranking existente
				Ranking rankingAtualizado = new Ranking(
					rankingExistente.getCidade_rank(),
					rankingExistente.getEstado_rank(),
					rankingExistente.getPais_rank(),
					novosPontosTotais,
					novosPontosSemana,
					usuarioLogado
				);
				rankingAtualizado.setId_rank(rankingExistente.getId_rank());
				
				rankingDAO.atualizarRanking(rankingAtualizado);
			} else {
				// Primeira vez - criar novo ranking
				Ranking novoRanking = new Ranking(
					usuarioLogado.getCidade_user(),
					usuarioLogado.getEstado_user(),
					usuarioLogado.getPais_user(),
					pontosGanhos,
					pontosGanhos,
					usuarioLogado
				);
				
				rankingDAO.cadastrarRanking(novoRanking);
			}
			
			// *** CRIAR ARQUIVO DE CONTROLE ***
			// Marcar que usuário já informou hoje
			criarArquivoControleBikePropria(usuarioLogado.getCpfCnpj_user(), distancia, pontosGanhos);
			
			// Sucesso - redirecionar para ranking locatário com mensagem
			String mensagem = "Distância com bike própria informada com sucesso! Você ganhou " + pontosGanhos + " pontos!";
			response.sendRedirect(request.getContextPath() + "/RankingController?action=pagina-locatario&sucesso=" + 
				java.net.URLEncoder.encode(mensagem, "UTF-8"));
				
		} catch (NumberFormatException e) {
			request.setAttribute("erro", "Dados inválidos fornecidos!");
			carregarPaginaInformarDistancia(request, response);
		} catch (Exception e) {
			request.setAttribute("erro", "Erro ao processar informação: " + e.getMessage());
			e.printStackTrace();
			carregarPaginaInformarDistancia(request, response);
		}
	}
	
	private void editarRanking(HttpServletRequest request, HttpServletResponse response) throws Exception{
		// Primeiro tentar getAttribute (vindo de forward), depois getParameter (vindo de form)
		String cidade_rank = (String) request.getAttribute("cidade");
		if (cidade_rank == null) cidade_rank = request.getParameter("cidade");
		
		String estado_rank = (String) request.getAttribute("estado");
		if (estado_rank == null) estado_rank = request.getParameter("estado");
		
		String pais_rank = (String) request.getAttribute("pais");
		if (pais_rank == null) pais_rank = request.getParameter("pais");
		
		// Para pontos, tentar getAttribute primeiro
		String pontosStr = (String) request.getAttribute("pontos");
		if (pontosStr == null) pontosStr = request.getParameter("pontos");
		float pontos_rank = Float.parseFloat(pontosStr);
		
		String pontosSemanaStr = (String) request.getAttribute("pontosSemana");
		if (pontosSemanaStr == null) pontosSemanaStr = request.getParameter("pontosSemana");
		float pontosSemana_rank = Float.parseFloat(pontosSemanaStr);
		
		// Aceitar tanto 'cpfCnpj' quanto 'usuario' para compatibilidade
		String cpfCnpj = (String) request.getAttribute("usuario");
		if (cpfCnpj == null) cpfCnpj = request.getParameter("cpfCnpj");
		if (cpfCnpj == null) cpfCnpj = request.getParameter("usuario");
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj);
		
		Ranking ranking = new Ranking(cidade_rank, estado_rank, pais_rank, pontos_rank, pontosSemana_rank, usuario);
		
		rankingDAO.atualizarRanking(ranking);
		
		// Resposta padrão para chamadas diretas
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Pontos atualizados com sucesso!');");
		out.println("window.location.href='pages/rankingAdm.jsp';");
		out.println("</script>");
		out.close();
	}
	
	private void exibirRankingUsuario(HttpServletRequest request, HttpServletResponse response) throws Exception{
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
		
		if (usuario != null) {
	        Ranking rankingUsuario = rankingDAO.buscarPorUsuario(usuario.getCpfCnpj_user());

	        if (rankingUsuario != null) {
	            request.setAttribute("rankingUsuario", rankingUsuario);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
	            dispatcher.forward(request, response);
	        } else {
	            // Usuário encontrado, mas sem ranking
	            response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script type='text/javascript'>");
	            out.println("alert('Usuário encontrado, mas ele não tem ranking');");
	            out.println("window.location.href='pages/lista.jsp';");
	            out.println("</script>");
	            out.close();
	        }
	    } else {
	        // Usuário não encontrado
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script type='text/javascript'>");
	        out.println("alert('Usuário não encontrado! Exibindo ranking.');");
	        out.println("window.location.href='pages/lista.jsp';");
	        out.println("</script>");
	        out.close();
	    }
	}
	
	/*
	
	private void resetarPOntos(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int linhasAfetadas = rankingDAO.resetarPontosSemana();
		System.out.println("[RankingScheduler] Reset semanal executado. Linhas afetadas: " + linhasAfetadas);
	}
	
	*/
	
	private void listarRankingsFiltrados(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cidade_rank = request.getParameter("cidade");
		String estado_rank = request.getParameter("estado");
		String pais_rank = request.getParameter("pais");
		List<Ranking> listaRankingFiltrado = rankingDAO.listarPorLocalidade(pais_rank, estado_rank, cidade_rank);
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaRankingFiltrado == null || listaRankingFiltrado.isEmpty()) {
			System.out.println("A lista de rankings filtrada está vazia ou nula");
		} else {
			System.out.println("Lista de rankings filtrada obtida:");
			for (Ranking ranking : listaRankingFiltrado) {
				System.out.println(ranking.exibirDados());
			}
		}

		// Também buscar as listas padrão para manter a funcionalidade completa
		List<Ranking> listaRankings = rankingDAO.listarTodos();
		List<Ranking> listaRankingTopGeral = rankingDAO.listarTopGeral(10);
		List<Ranking> listaRankingTopSemana = rankingDAO.listarTopSemana(10);

		request.setAttribute("listaRankingFiltrado", listaRankingFiltrado);
		request.setAttribute("listaRankings", listaRankings);
		request.setAttribute("listaRankingTopGeral", listaRankingTopGeral);
		request.setAttribute("listaRankingTopSemana", listaRankingTopSemana);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/rankingAdm.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarRankingsFiltradosLocatario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// Obter usuário logado da sessão
		Usuario usuarioLogado = (Usuario) request.getSession().getAttribute("usuarioLogado");
		
		if (usuarioLogado == null) {
			response.sendRedirect(request.getContextPath() + "/pages/loginUsuario.jsp");
			return;
		}
		
		// Obter parâmetros de filtro
		String cidade_rank = request.getParameter("cidade");
		String estado_rank = request.getParameter("estado");
		String pais_rank = request.getParameter("pais");
		
		// Buscar rankings filtrados
		List<Ranking> listaRankingFiltrado = rankingDAO.listarPorLocalidade(pais_rank, estado_rank, cidade_rank);
		
		// Buscar ranking do usuário logado
		Ranking rankingUsuarioLogado = rankingDAO.buscarPorUsuario(usuarioLogado.getCpfCnpj_user());
		
		// Buscar listas de rankings padrão para manter funcionalidade completa
		List<Ranking> listaRankingTopGeral = rankingDAO.listarTopGeral(10);
		List<Ranking> listaRankingTopSemana = rankingDAO.listarTopSemana(10);
		List<Ranking> listaRankings = rankingDAO.listarTodos();
		
		// Calcular posição do usuário no ranking geral
		int posicaoUsuario = 0;
		if (rankingUsuarioLogado != null) {
			posicaoUsuario = rankingDAO.obterPosicaoUsuario(usuarioLogado.getCpfCnpj_user());
		}
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaRankingFiltrado == null || listaRankingFiltrado.isEmpty()) {
			System.out.println("A lista de rankings filtrada (locatário) está vazia ou nula");
		} else {
			System.out.println("Lista de rankings filtrada (locatário) obtida:");
			for (Ranking ranking : listaRankingFiltrado) {
				System.out.println(ranking.exibirDados());
			}
		}

		// Definir atributos para a JSP
		request.setAttribute("usuarioLogado", usuarioLogado);
		request.setAttribute("rankingUsuarioLogado", rankingUsuarioLogado);
		request.setAttribute("posicaoUsuario", posicaoUsuario);
		request.setAttribute("listaRankingFiltrado", listaRankingFiltrado);
		request.setAttribute("listaRankings", listaRankings);
		request.setAttribute("listaRankingTopGeral", listaRankingTopGeral);
		request.setAttribute("listaRankingTopSemana", listaRankingTopSemana);
		
		// Encaminhar para a página do locatário
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/rankingLocatario.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarRankings(HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Ranking> listaRankings = rankingDAO.listarTodos();
		List<Ranking> listaRankingTopGeral = rankingDAO.listarTopGeral(10);
		List<Ranking> listaRankingTopSemana = rankingDAO.listarTopSemana(10);

		// Verificando se a lista tem dados e exibindo no console
		if (listaRankings == null || listaRankings.isEmpty()) {
			System.out.println("A lista de rankings está vazia ou nula");
		} else {
			System.out.println("Lista de rankings Obtida:");
			for (Ranking ranking : listaRankings) {
				System.out.println(ranking.exibirDados());
			}
		}

		request.setAttribute("listaRankings", listaRankings);
		request.setAttribute("listaRankingTopGeral", listaRankingTopGeral);
		request.setAttribute("listaRankingTopSemana", listaRankingTopSemana);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/rankingAdm.jsp");
		dispatcher.forward(request, response);
	}
	
	// *** MÉTODOS PARA CONTROLE DE ARQUIVO TEMPORÁRIO - BIKE PRÓPRIA ***
	
	/**
	 * Verifica se o usuário já informou distância de bike própria hoje
	 */
	private boolean jaInformouBikePropriaHoje(String cpfUsuario) {
		String nomeArquivo = "bike_propria_" + cpfUsuario + "_" + LocalDate.now().toString() + ".tmp";
		String caminhoTemp = System.getProperty("java.io.tmpdir");
		File arquivoControle = new File(caminhoTemp, nomeArquivo);
		
		return arquivoControle.exists();
	}
	
	/**
	 * Cria arquivo de controle para marcar que usuário já informou hoje
	 */
	private void criarArquivoControleBikePropria(String cpfUsuario, double distancia, int pontos) {
		try {
			String nomeArquivo = "bike_propria_" + cpfUsuario + "_" + LocalDate.now().toString() + ".tmp";
			String caminhoTemp = System.getProperty("java.io.tmpdir");
			File arquivoControle = new File(caminhoTemp, nomeArquivo);
			
			// Criar arquivo
			arquivoControle.createNewFile();
			
			// Escrever informações no arquivo (opcional, para debug/auditoria)
			String conteudo = String.format(
				"Usuário: %s%n" +
				"Data: %s%n" +
				"Hora: %s%n" +
				"Distância: %.1f km%n" +
				"Pontos: %d%n",
				cpfUsuario,
				LocalDate.now(),
				LocalDateTime.now(),
				distancia,
				pontos
			);
			
			Files.write(arquivoControle.toPath(), conteudo.getBytes());
			
			// Executar limpeza de arquivos antigos em background
			limparArquivosAntigos();
			
		} catch (Exception e) {
			// Se falhar ao criar arquivo, apenas registra no log mas não interrompe o fluxo
			System.err.println("Erro ao criar arquivo de controle bike própria: " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * Remove arquivos de controle antigos (mais de 1 dia)
	 */
	private void limparArquivosAntigos() {
		try {
			String caminhoTemp = System.getProperty("java.io.tmpdir");
			File pastaTemp = new File(caminhoTemp);
			
			// Buscar todos os arquivos de controle de bike própria
			File[] arquivos = pastaTemp.listFiles((dir, name) -> 
				name.startsWith("bike_propria_") && name.endsWith(".tmp"));
			
			if (arquivos != null) {
				for (File arquivo : arquivos) {
					// Calcular diferença em dias
					long diffMillis = System.currentTimeMillis() - arquivo.lastModified();
					long diffDias = diffMillis / (24 * 60 * 60 * 1000);
					
					// Se arquivo é de ontem ou mais antigo, deletar
					if (diffDias >= 1) {
						if (arquivo.delete()) {
							System.out.println("Arquivo antigo removido: " + arquivo.getName());
						}
					}
				}
			}
		} catch (Exception e) {
			// Se falhar na limpeza, apenas registra no log
			System.err.println("Erro na limpeza de arquivos antigos: " + e.getMessage());
		}
	}
	
}