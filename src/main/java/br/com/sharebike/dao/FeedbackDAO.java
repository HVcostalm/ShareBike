package br.com.sharebike.dao;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import br.com.sharebike.model.Feedback;
import br.com.sharebike.model.Reserva;
import br.com.sharebike.model.Usuario;
import br.com.sharebike.utils.Conexao;

public class FeedbackDAO extends BaseDAO{

	// Inserir novo feedback
	public int cadastrarFeedback(Feedback feedback) {
		String insert = """
				    INSERT INTO Feedback(avaliacaoUser_feedb, avaliacaoBike_feedb, obsBike_feedb, obsUser_feedb, data_feedb, 
				    confComp_feedb, comunicBoa_feedb, funcional_feedb, manutencao_feedb, Reserva, avaliado_Usuario, avaliador_Usuario)
				    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
				""";

		int linha = 0;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(insert);

			sql.setInt(1, feedback.getAvaliacaoUser_feedb());
			sql.setInt(2, feedback.getAvaliacaoBike_feedb());
			sql.setString(3, feedback.getObsBike_feedb());
			sql.setString(4, feedback.getObsUser_feedb());
			sql.setTimestamp(5, Timestamp.valueOf(feedback.getData_feedb()));
			sql.setBoolean(6, feedback.isConfComp_feedb());
			sql.setBoolean(7, feedback.isComunicBoa_feedb());
			sql.setBoolean(8, feedback.isFuncional_feedb());
			sql.setBoolean(9, feedback.isManutencao_feedb());
			sql.setInt(10, feedback.getReserva().getId_reserv());
			sql.setString(11, feedback.getAvaliado_Usuario().getCpfCnpj_user());
			sql.setString(12, feedback.getAvaliador_Usuario().getCpfCnpj_user());

			linha = sql.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return linha;
	}

	// Buscar feedback por ID
	public Feedback buscarPorId(int id) {
		String select = "SELECT * FROM Feedback WHERE id_feedb = ?";
		Feedback feedback = null;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			sql.setInt(1, id);
			rset = sql.executeQuery();

			if (rset.next()) {
				feedback = montarFeedback(rset);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return feedback;
	}

	// Listar todos os feedbacks
	public List<Feedback> listarFeedbacks() {
		String select = "SELECT * FROM Feedback";
		List<Feedback> lista = new ArrayList<>();

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			rset = sql.executeQuery();

			while (rset.next()) {
				lista.add(montarFeedback(rset));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return lista;
	}

	// Listar feedbacks de um usuário avaliado específico
	public List<Feedback> listarPorAvaliado(String cpfAvaliado) {
		String select = "SELECT * FROM Feedback WHERE avaliado_Usuario = ?";
		List<Feedback> lista = new ArrayList<>();

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			sql.setString(1, cpfAvaliado);
			rset = sql.executeQuery();

			while (rset.next()) {
				lista.add(montarFeedback(rset));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return lista;
	}

	// Listar feedbacks feitos por um usuário específico
	public List<Feedback> listarPorAvaliador(String cpfAvaliador) {
		String select = "SELECT * FROM Feedback WHERE avaliador_Usuario = ?";
		List<Feedback> lista = new ArrayList<>();

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			sql.setString(1, cpfAvaliador);
			rset = sql.executeQuery();

			while (rset.next()) {
				lista.add(montarFeedback(rset));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return lista;
	}
	
	public List<Feedback> listarFeedbacksPorBicicleta(int id_bike) {
	    String sqlSelect = """
	        SELECT f.* FROM Feedback f
	        INNER JOIN Reserva r ON f.Reserva = r.id_reserv
	        WHERE r.Bicicleta = ?
	    """;

	    List<Feedback> feedbacks = new ArrayList<>();

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(sqlSelect);
	        sql.setInt(1, id_bike);
	        rset = sql.executeQuery();

	        while (rset.next()) {
	            feedbacks.add(montarFeedback(rset));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }

	    return feedbacks;
	}

	
	// Montar objeto Feedback
	private Feedback montarFeedback(ResultSet rset) throws Exception {
		Feedback fb = new Feedback();

		fb.setId_feedb(rset.getInt("id_feedb"));
		fb.setAvaliacaoUser_feedb(rset.getInt("avaliacaoUser_feedb"));
		fb.setAvaliacaoBike_feedb(rset.getInt("avaliacaoBike_feedb"));
		fb.setObsBike_feedb(rset.getString("obsBike_feedb"));
		fb.setObsUser_feedb(rset.getString("obsUser_feedb"));
		fb.setData_feedb(rset.getTimestamp("data_feedb").toLocalDateTime());
		fb.setConfComp_feedb(rset.getBoolean("confComp_feedb"));
		fb.setComunicBoa_feedb(rset.getBoolean("comunicBoa_feedb"));
		fb.setFuncional_feedb(rset.getBoolean("funcional_feedb"));
		fb.setManutencao_feedb(rset.getBoolean("manutencao_feedb"));

		Reserva reserva = new Reserva();
		reserva.setId_reserv(rset.getInt("Reserva"));
		fb.setReserva(reserva);

		Usuario avaliado = new Usuario();
		avaliado.setCpfCnpj_user(rset.getString("avaliado_Usuario"));
		fb.setAvaliado_Usuario(avaliado);

		Usuario avaliador = new Usuario();
		avaliador.setCpfCnpj_user(rset.getString("avaliador_Usuario"));
		fb.setAvaliador_Usuario(avaliador);

		return fb;
	}

}
