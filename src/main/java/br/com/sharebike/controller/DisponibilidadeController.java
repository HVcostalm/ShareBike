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
import br.com.sharebike.dao.DisponibilidadeDAO;
import br.com.sharebike.model.Bicicleta;
import br.com.sharebike.model.Disponibilidade;
import br.com.sharebike.utils.DisponibilidadeScheduler;

@WebServlet("/DisponibilidadeController")
public class DisponibilidadeController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private DisponibilidadeDAO disponibilidadeDAO;
	private BicicletaDAO bicicletaDAO;
	
	public void init() throws ServletException{
		try {
			disponibilidadeDAO = new DisponibilidadeDAO();
			
			DisponibilidadeScheduler.iniciar();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar o DisponibilidadeDAO", e);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			listarDisponibilidades(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String action = request.getParameter("action");
		try {
			switch (action) {
			case "adicionar":
				adicionarDisponibilidade(request, response);
				break;
			case "editar":
				editarDisponibilidade(request, response);
				break;
			case "exibir":
				exibirDisponibilidade(request, response);
				break;
			case "listar-por-bicicleta":
				listarDisponibilidadesPorBicicleta(request, response);
				break;
			case "listar":
				listarDisponibilidades(request, response);
				break;
			default:
				listarDisponibilidades(request, response);
				break;
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
	
	private void adicionarDisponibilidade(HttpServletRequest request, HttpServletResponse response) throws Exception{
		LocalDateTime dataHoraIn_disp = LocalDateTime.parse(request.getParameter("dataHoraIn"));
		LocalDateTime dataHoraFim_disp = LocalDateTime.parse(request.getParameter("dataHoraFim"));;
		boolean disponivel_disp = Boolean.parseBoolean(request.getParameter("disponivel"));
		int id_bike = Integer.parseInt(request.getParameter("id_bike"));
		
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		
		Disponibilidade disponibilidade = new Disponibilidade(dataHoraIn_disp, dataHoraFim_disp, disponivel_disp, bicicleta);
		
		disponibilidadeDAO.cadastrarDisponibilidade(disponibilidade);
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Disponibilidade adicionada com sucesso!');");
		out.println("window.location.href='pages/detalhesBicicleta.jsp';");
		out.println("</script>");
		out.close();
		//response.sendRedirect("index.jsp");
	}
	
	private void editarDisponibilidade(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_disp = Integer.parseInt(request.getParameter("id_disp"));
		LocalDateTime dataHoraIn_disp = LocalDateTime.parse(request.getParameter("dataHoraIn"));
		LocalDateTime dataHoraFim_disp = LocalDateTime.parse(request.getParameter("dataHoraFim"));;
		boolean disponivel_disp = Boolean.parseBoolean(request.getParameter("disponivel"));
		int id_bike = Integer.parseInt(request.getParameter("id_bike"));
		
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		
		Disponibilidade disponibilidade = new Disponibilidade(id_disp, dataHoraIn_disp, dataHoraFim_disp, disponivel_disp, bicicleta);
		
		disponibilidadeDAO.editarDisponibilidade(disponibilidade);
		
		// Resposta com um script para exibir o alerta e redirecionar
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('Disponibilidade editada com sucesso!');");
		out.println("window.location.href='pages/detalhesBicicleta.jsp';");
		out.println("</script>");
		out.close();
		// response.sendRedirect("index.jsp");
	}
	
	private void exibirDisponibilidade(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_disp = Integer.parseInt(request.getParameter("id_disp"));
		
		Disponibilidade disponibilidade = disponibilidadeDAO.buscarPorId(id_disp);
		
		// Atribuindo os objetos à request
	    request.setAttribute("disponibilidade", disponibilidade);

	    // Encaminha para a página de exibição detalhada
	    RequestDispatcher dispatcher = request.getRequestDispatcher("pages/detalhesDisponibilidade.jsp");
	    dispatcher.forward(request, response);
	}
	
	/*
	
	private void tornarIndisponiviel(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int atualizadas = disponibilidadeDAO.tornarIndisponivel();
        System.out.println("Agendado: " + atualizadas + " disponibilidades tornadas indisponíveis.");
	}
	
	*/
	
	private void listarDisponibilidadesPorBicicleta(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt(request.getParameter("id_bike"));
		List <Disponibilidade> listaDisponibilidadesBicicleta = disponibilidadeDAO.listarPorBicicleta(id_bike);

		// Verificando se a lista tem dados e exibindo no console
		if (listaDisponibilidadesBicicleta == null || listaDisponibilidadesBicicleta.isEmpty()) {
			System.out.println("A lista de disponibilidades está vazia ou nula");
		} else {
			System.out.println("Lista de Disponibilidades Obtida:");
			for (Disponibilidade disponibilidade : listaDisponibilidadesBicicleta) {
				System.out.println(disponibilidade.exibirDados());
			}
		}

		request.setAttribute("listaDisponibilidadesBicicleta", listaDisponibilidadesBicicleta);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
	
	private void listarDisponibilidades(HttpServletRequest request, HttpServletResponse response) throws Exception{
		List <Disponibilidade> listaDisponibilidades = disponibilidadeDAO.listarDisponibilidade();
		
		// Verificando se a lista tem dados e exibindo no console
		if (listaDisponibilidades == null || listaDisponibilidades.isEmpty()) {
			System.out.println("A lista de disponibilidades está vazia ou nula");
		} else {
			System.out.println("Lista de Disponibilidades Obtida:");
			for (Disponibilidade disponibilidade : listaDisponibilidades) {
				System.out.println(disponibilidade.exibirDados());
			}
		}

		request.setAttribute("listaDisponibilidades", listaDisponibilidades);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/listaBicicletas.jsp");
		dispatcher.forward(request, response);
	}
}
