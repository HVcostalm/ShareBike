package br.com.sharebike.controller;

import java.io.IOException;
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
import br.com.sharebike.utils.ValidadorDisponibilidade;

@WebServlet("/DisponibilidadeController")
public class DisponibilidadeController extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private DisponibilidadeDAO disponibilidadeDAO;
	private BicicletaDAO bicicletaDAO;
	
	public void init() throws ServletException{
		try {
			disponibilidadeDAO = new DisponibilidadeDAO();
			bicicletaDAO = new BicicletaDAO();
			
			//DisponibilidadeScheduler.iniciar();
		} catch (Exception e) {
			throw new ServletException("Erro ao inicializar os DAOs", e);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		try {
			switch (action != null ? action : "listar") {
			case "form-adicionar":
				exibirFormAdicionar(request, response);
				break;
			case "form-editar":
				exibirFormEditar(request, response);
				break;
			case "exibir":
				exibirDisponibilidade(request, response);
				break;
			case "listar-por-bicicleta":
				listarDisponibilidadesPorBicicleta(request, response);
				break;
			case "listar":
			default:
				listarDisponibilidades(request, response);
				break;
			}
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
		String dataHoraInStr = request.getParameter("dataHoraIn");
		String dataHoraFimStr = request.getParameter("dataHoraFim");
		int id_bike = Integer.parseInt(request.getParameter("id_bike"));
		
		// Validar usando a classe utilitária
		ValidadorDisponibilidade.ResultadoValidacao resultado = 
			ValidadorDisponibilidade.validarNovaDisponibilidade(id_bike, dataHoraInStr, dataHoraFimStr);
		
		if (!resultado.isValido()) {
			// Há erro - retornar para a página com mensagem de erro
			request.setAttribute("erro", resultado.getMensagemErro());
			
			// Adicionar detalhes dos conflitos se existirem
			if (!resultado.getDetalhesConflitos().isEmpty()) {
				request.setAttribute("detalhesConflitos", resultado.getDetalhesConflitos());
			}
			
			request.setAttribute("id_bike", id_bike);
			request.setAttribute("dataHoraIn", dataHoraInStr);
			request.setAttribute("dataHoraFim", dataHoraFimStr);
			
			// Buscar a bicicleta para exibir na página
			Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
			request.setAttribute("bicicleta", bicicleta);
			
			// Buscar dados do proprietário
			if (bicicleta != null && bicicleta.getUsuario() != null) {
				br.com.sharebike.dao.UsuarioDAO usuarioDAO = new br.com.sharebike.dao.UsuarioDAO();
				br.com.sharebike.model.Usuario proprietario = usuarioDAO.exibirUsuario(bicicleta.getUsuario().getCpfCnpj_user());
				request.setAttribute("proprietario", proprietario);
			}
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/definirDisponibilidadeBike.jsp");
			dispatcher.forward(request, response);
			return;
		}
		
		// Dados válidos - criar disponibilidade
		LocalDateTime dataHoraIn_disp = LocalDateTime.parse(dataHoraInStr);
		LocalDateTime dataHoraFim_disp = LocalDateTime.parse(dataHoraFimStr);
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		
		Disponibilidade disponibilidade = new Disponibilidade(dataHoraIn_disp, dataHoraFim_disp, bicicleta);
		
		disponibilidadeDAO.cadastrarDisponibilidade(disponibilidade);
		
		// Redirecionar de volta para os detalhes da bicicleta
		response.sendRedirect("BicicletaController?action=exibir&id=" + id_bike);
	}
	
	private void editarDisponibilidade(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_disp = Integer.parseInt(request.getParameter("id_disp"));
		String dataHoraInStr = request.getParameter("dataHoraIn");
		String dataHoraFimStr = request.getParameter("dataHoraFim");
		boolean disponivel_disp = Boolean.parseBoolean(request.getParameter("disponivel"));
		int id_bike = Integer.parseInt(request.getParameter("id_bike"));
		
		// Validar usando a classe utilitária
		ValidadorDisponibilidade.ResultadoValidacao resultado = 
			ValidadorDisponibilidade.validarEdicaoDisponibilidade(id_bike, dataHoraInStr, dataHoraFimStr, id_disp);
		
		if (!resultado.isValido()) {
			// Há erro - retornar para a página com mensagem de erro
			request.setAttribute("erro", resultado.getMensagemErro());
			
			// Adicionar detalhes dos conflitos se existirem
			if (!resultado.getDetalhesConflitos().isEmpty()) {
				request.setAttribute("detalhesConflitos", resultado.getDetalhesConflitos());
			}
			
			// Buscar a disponibilidade atual para exibir na página
			Disponibilidade disponibilidadeAtual = disponibilidadeDAO.buscarPorId(id_disp);
			request.setAttribute("disponibilidade", disponibilidadeAtual);
			
			// Buscar a bicicleta para exibir na página
			Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
			request.setAttribute("bicicleta", bicicleta);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/editarDisponibilidade.jsp");
			dispatcher.forward(request, response);
			return;
		}
		
		// Dados válidos - atualizar disponibilidade
		LocalDateTime dataHoraIn_disp = LocalDateTime.parse(dataHoraInStr);
		LocalDateTime dataHoraFim_disp = LocalDateTime.parse(dataHoraFimStr);
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		
		Disponibilidade disponibilidade = new Disponibilidade(id_disp, dataHoraIn_disp, dataHoraFim_disp, disponivel_disp, bicicleta);
		
		disponibilidadeDAO.editarDisponibilidade(disponibilidade);
		
		// Redirecionar de volta para os detalhes da bicicleta
		response.sendRedirect("BicicletaController?action=exibir&id=" + id_bike);
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
	
	private void exibirFormAdicionar(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_bike = Integer.parseInt(request.getParameter("id"));
		
		// Buscar dados da bicicleta para exibir no formulário
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(id_bike);
		
		if (bicicleta != null) {
			// Buscar dados do proprietário
			br.com.sharebike.dao.UsuarioDAO usuarioDAO = new br.com.sharebike.dao.UsuarioDAO();
			br.com.sharebike.model.Usuario proprietario = usuarioDAO.exibirUsuario(bicicleta.getUsuario().getCpfCnpj_user());
			
			// Atribuir à request
			request.setAttribute("bicicleta", bicicleta);
			request.setAttribute("proprietario", proprietario);
		}
		
		// Encaminhar para o formulário
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/definirDisponibilidadeBike.jsp");
		dispatcher.forward(request, response);
	}
	
	private void exibirFormEditar(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int id_disp = Integer.parseInt(request.getParameter("id"));
		int idBicicleta = Integer.parseInt(request.getParameter("idBicicleta"));
		
		// Buscar dados da disponibilidade
		Disponibilidade disponibilidade = disponibilidadeDAO.buscarPorId(id_disp);
		
		// Buscar dados da bicicleta para exibir no formulário
		Bicicleta bicicleta = bicicletaDAO.buscarPorId(idBicicleta);
		
		if (bicicleta != null && disponibilidade != null) {
			// Buscar dados do proprietário
			br.com.sharebike.dao.UsuarioDAO usuarioDAO = new br.com.sharebike.dao.UsuarioDAO();
			br.com.sharebike.model.Usuario proprietario = usuarioDAO.exibirUsuario(bicicleta.getUsuario().getCpfCnpj_user());
			
			// Atribuir à request
			request.setAttribute("disponibilidade", disponibilidade);
			request.setAttribute("bicicleta", bicicleta);
			request.setAttribute("proprietario", proprietario);
		}
		
		// Encaminhar para o formulário de edição
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/editarDisponibilidade.jsp");
		dispatcher.forward(request, response);
	}
}
