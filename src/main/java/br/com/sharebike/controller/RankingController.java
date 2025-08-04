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

import br.com.sharebike.dao.RankingDAO;
import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.model.Ranking;
import br.com.sharebike.model.Usuario;
import br.com.sharebike.utils.RankingScheduler;

@WebServlet("/RankingController")
public class RankingController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private RankingDAO rankingDAO;
	private UsuarioDAO usuarioDAO;
	
	public void init() throws ServletException{
		try {
			rankingDAO = new RankingDAO();
			
			RankingScheduler.iniciar();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar RankingDAO", e);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			listarRankings(request, response);
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
			case "exibir-ranking-usuario":
				exibirRankingUsuario(request, response);
				break;
			case "listar-ranking-filtro":
				listarRankingsFiltrados(request, response);
				break;
			case "listar-ranking-top-semana":
				listarRankingsTopSemana(request, response);
				break;
			case "listar-ranking-top-geral":
				listarRankingsTopGeral(request, response);
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
		String cidade_rank = request.getParameter("cidade");
		String estado_rank = request.getParameter("estado");
		String pais_rank = request.getParameter("pais");
		float pontos_rank = Float.parseFloat(request.getParameter("pontos"));
		float pontosSemana_rank = Float.parseFloat(request.getParameter("pontosSemana"));
		String cpfCnpj = request.getParameter("cpfCnpj");
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj);
		
		Ranking ranking = new Ranking(cidade_rank, estado_rank, pais_rank, pontos_rank, pontosSemana_rank, usuario);
		
		rankingDAO.cadastrarRanking(ranking);
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Pontos calculados');");
		out.println("window.location.href='pages/principal.jsp';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("index.jsp");
	}
	
	private void editarRanking(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String cidade_rank = request.getParameter("cidade");
		String estado_rank = request.getParameter("estado");
		String pais_rank = request.getParameter("pais");
		float pontos_rank = Float.parseFloat(request.getParameter("pontos"));
		float pontosSemana_rank = Float.parseFloat(request.getParameter("pontosSemana"));
		String cpfCnpj = request.getParameter("cpfCnpj");
		
		Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpj);
		
		Ranking ranking = new Ranking(cidade_rank, estado_rank, pais_rank, pontos_rank, pontosSemana_rank, usuario);
		
		rankingDAO.atualizarRanking(ranking);
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
			System.out.println("A lista de rankings está vazia ou nula");
		} else {
			System.out.println("Lista de rankings Obtida:");
			for (Ranking ranking : listaRankingFiltrado) {
				System.out.println(ranking.exibirDados());
			}
		}

		request.setAttribute("listaRankingFiltrado", listaRankingFiltrado);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarRankingsTopSemana(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int top10 = 10;
		List<Ranking> listaRankingTopSemana = rankingDAO.listarTopSemana(top10);
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaRankingTopSemana == null || listaRankingTopSemana.isEmpty()) {
			System.out.println("A lista de rankings está vazia ou nula");
		} else {
			System.out.println("Lista de rankings Obtida:");
			for (Ranking ranking : listaRankingTopSemana) {
				System.out.println(ranking.exibirDados());
			}
		}

		request.setAttribute("listaRankingTopSemana", listaRankingTopSemana);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarRankingsTopGeral(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int top10 = 10;
		List<Ranking> listaRankingTopGeral = rankingDAO.listarTopGeral(top10);
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaRankingTopGeral == null || listaRankingTopGeral.isEmpty()) {
			System.out.println("A lista de rankings está vazia ou nula");
		} else {
			System.out.println("Lista de rankings Obtida:");
			for (Ranking ranking : listaRankingTopGeral) {
				System.out.println(ranking.exibirDados());
			}
		}

		request.setAttribute("listaRankingTopGeral", listaRankingTopGeral);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarRankings(HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Ranking> listaRankings = rankingDAO.listarTodos();

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
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
}
