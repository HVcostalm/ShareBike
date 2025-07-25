package br.com.sharebike.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import br.com.sharebike.model.Ranking;
import br.com.sharebike.model.Usuario;
import br.com.sharebike.utils.Conexao;

public class RankingDAO extends BaseDAO{
	
	// Zerar pontosSemana no controller (service)
	// Criar função para zerar pontosSemana
	
	// Cadastrar novo ranking
	public int cadastrarRanking(Ranking ranking) {
		String insert = """
				    INSERT INTO Ranking(cidade_rank, estado_rank, pais_rank, pontos_rank, pontosSemana_rank, Usuario)
				    VALUES (?, ?, ?, ?, ?, ?)
				""";

		int linha = 0;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(insert);

			sql.setString(1, ranking.getCidade_rank());
			sql.setString(2, ranking.getEstado_rank());
			sql.setString(3, ranking.getPais_rank());
			sql.setFloat(4, ranking.getPontos_rank());
			sql.setFloat(5, ranking.getPontosSemana_rank());
			sql.setString(6, ranking.getUsuario().getCpfCnpj_user());

			linha = sql.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return linha;
	}

	// Atualizar ranking de um usuário
	public int atualizarRanking(Ranking ranking) {
		String update = """
				    UPDATE Ranking SET cidade_rank = ?, estado_rank = ?, pais_rank = ?, 
				    pontos_rank = ?, pontosSemana_rank = ? WHERE Usuario = ?
				""";

		int linha = 0;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(update);

			sql.setString(1, ranking.getCidade_rank());
			sql.setString(2, ranking.getEstado_rank());
			sql.setString(3, ranking.getPais_rank());
			sql.setFloat(4, ranking.getPontos_rank());
			sql.setFloat(5, ranking.getPontosSemana_rank());
			sql.setString(6, ranking.getUsuario().getCpfCnpj_user());

			linha = sql.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return linha;
	}

	// Buscar ranking por CPF do usuário
	public Ranking buscarPorUsuario(String cpf) {
		String select = "SELECT * FROM Ranking WHERE Usuario = ?";
		Ranking rank = null;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			sql.setString(1, cpf);
			rset = sql.executeQuery();

			if (rset.next()) {
				rank = montarRanking(rset);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return rank;
	}

	// Listar todos os rankings
	public List<Ranking> listarTodos() {
		String select = "SELECT * FROM Ranking";
		List<Ranking> lista = new ArrayList<>();

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			rset = sql.executeQuery();

			while (rset.next()) {
				lista.add(montarRanking(rset));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return lista;
	}

	// Listar ranking por país, estado ou cidade (filtros combináveis)
	public List<Ranking> listarPorLocalidade(String pais, String estado, String cidade) {
		StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM Ranking WHERE 1=1");

		if (pais != null && !pais.isEmpty()) {
			sqlBuilder.append(" AND pais_rank = ?");
		}
		if (estado != null && !estado.isEmpty()) {
			sqlBuilder.append(" AND estado_rank = ?");
		}
		if (cidade != null && !cidade.isEmpty()) {
			sqlBuilder.append(" AND cidade_rank = ?");
		}

		List<Ranking> lista = new ArrayList<>();

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(sqlBuilder.toString());

			int index = 1;
			if (pais != null && !pais.isEmpty()) {
				sql.setString(index++, pais);
			}
			if (estado != null && !estado.isEmpty()) {
				sql.setString(index++, estado);
			}
			if (cidade != null && !cidade.isEmpty()) {
				sql.setString(index++, cidade);
			}

			rset = sql.executeQuery();

			while (rset.next()) {
				lista.add(montarRanking(rset));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return lista;
	}
	
	// Função que faz um top dos usuarios por ponto semana
	public List<Ranking> listarTopSemana(int limite) {
	    String select = """
	        SELECT * FROM Ranking
	        ORDER BY pontosSemana_rank DESC
	        LIMIT ?
	    """;

	    List<Ranking> lista = new ArrayList<>();

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(select);
	        sql.setInt(1, limite);

	        rset = sql.executeQuery();

	        while (rset.next()) {
	            lista.add(montarRanking(rset));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }

	    return lista;
	}
	
	// Função que faz um top dos usuarios por ponto total
	public List<Ranking> listarTopGeral(int limite) {
	    String select = """
	        SELECT * FROM Ranking
	        ORDER BY pontos_rank DESC
	        LIMIT ?
	    """;

	    List<Ranking> lista = new ArrayList<>();

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(select);
	        sql.setInt(1, limite);

	        rset = sql.executeQuery();

	        while (rset.next()) {
	            lista.add(montarRanking(rset));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }

	    return lista;
	}

	public int resetarPontosSemana() {
	    String update = "UPDATE Ranking SET pontosSemana_rank = 0";
	    int linhasAfetadas = 0;

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(update);
	        linhasAfetadas = sql.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }

	    return linhasAfetadas;
	}
	
	// Monta objeto Ranking a partir do ResultSet
	private Ranking montarRanking(ResultSet rset) throws Exception {
		Ranking ranking = new Ranking();

		ranking.setId_rank(rset.getInt("id_rank"));
		ranking.setCidade_rank(rset.getString("cidade_rank"));
		ranking.setEstado_rank(rset.getString("estado_rank"));
		ranking.setPais_rank(rset.getString("pais_rank"));
		ranking.setPontos_rank(rset.getFloat("pontos_rank"));
		ranking.setPontosSemana_rank(rset.getFloat("pontosSemana_rank"));

		Usuario usuario = new Usuario();
		usuario.setCpfCnpj_user(rset.getString("Usuario"));
		ranking.setUsuario(usuario);

		return ranking;
	}
}
