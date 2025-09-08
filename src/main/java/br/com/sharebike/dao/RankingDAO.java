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
		String select = "SELECT r.*, u.nomeRazaoSocial_user, u.email_user, u.cidade_user, u.estado_user, u.pais_user " +
					   "FROM Ranking r " +
					   "INNER JOIN Usuario u ON r.Usuario = u.cpfCnpj_user " +
					   "WHERE r.Usuario = ?";
		Ranking rank = null;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			sql.setString(1, cpf);
			rset = sql.executeQuery();

			if (rset.next()) {
				rank = montarRankingComUsuario(rset);
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
		String select = """
			SELECT r.*, u.nomeRazaoSocial_user, u.email_user, u.cidade_user, u.estado_user, u.pais_user 
			FROM Ranking r 
			JOIN Usuario u ON r.Usuario = u.cpfCnpj_user
			ORDER BY r.pontos_rank DESC
		""";
		List<Ranking> lista = new ArrayList<>();

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			rset = sql.executeQuery();

			while (rset.next()) {
				lista.add(montarRankingComUsuario(rset));
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
		StringBuilder sqlBuilder = new StringBuilder("""
			SELECT r.*, u.nomeRazaoSocial_user, u.email_user, u.cidade_user, u.estado_user, u.pais_user 
			FROM Ranking r 
			JOIN Usuario u ON r.Usuario = u.cpfCnpj_user 
			WHERE 1=1
		""");

		if (pais != null && !pais.isEmpty()) {
			sqlBuilder.append(" AND r.pais_rank = ?");
		}
		if (estado != null && !estado.isEmpty()) {
			sqlBuilder.append(" AND r.estado_rank = ?");
		}
		if (cidade != null && !cidade.isEmpty()) {
			sqlBuilder.append(" AND r.cidade_rank = ?");
		}
		
		sqlBuilder.append(" ORDER BY r.pontos_rank DESC");

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
				lista.add(montarRankingComUsuario(rset));
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
	        SELECT r.*, u.nomeRazaoSocial_user, u.email_user, u.cidade_user, u.estado_user, u.pais_user 
			FROM Ranking r 
			JOIN Usuario u ON r.Usuario = u.cpfCnpj_user
	        ORDER BY r.pontosSemana_rank DESC
	        LIMIT ?
	    """;

	    List<Ranking> lista = new ArrayList<>();

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(select);
	        sql.setInt(1, limite);

	        rset = sql.executeQuery();

	        while (rset.next()) {
	            lista.add(montarRankingComUsuario(rset));
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
	        SELECT r.*, u.nomeRazaoSocial_user, u.email_user, u.cidade_user, u.estado_user, u.pais_user 
			FROM Ranking r 
			JOIN Usuario u ON r.Usuario = u.cpfCnpj_user
	        ORDER BY r.pontos_rank DESC
	        LIMIT ?
	    """;

	    List<Ranking> lista = new ArrayList<>();

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(select);
	        sql.setInt(1, limite);

	        rset = sql.executeQuery();

	        while (rset.next()) {
	            lista.add(montarRankingComUsuario(rset));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }

	    return lista;
	}
	
	
	// Ver como tratar essa função no projeto
	
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
	
	// Somar todos os pontos do ranking para estatísticas (Km pedalados)
	public float somarTodosPontos() {
		String query = "SELECT SUM(pontos_rank) FROM Ranking";
		float totalPontos = 0;
		
		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(query);
			ResultSet resultado = sql.executeQuery();
			
			if (resultado.next()) {
				totalPontos = resultado.getFloat(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}
		
		return totalPontos;
	}
	
	// Obter posição do usuário no ranking geral
	public int obterPosicaoUsuario(String cpfUsuario) {
		String query = """
			SELECT posicao FROM (
				SELECT r.Usuario, 
					   ROW_NUMBER() OVER (ORDER BY r.pontos_rank DESC) as posicao
				FROM Ranking r
			) ranked
			WHERE ranked.Usuario = ?
		""";
		
		int posicao = 0;
		
		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(query);
			sql.setString(1, cpfUsuario);
			ResultSet resultado = sql.executeQuery();
			
			if (resultado.next()) {
				posicao = resultado.getInt("posicao");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}
		
		return posicao;
	}
	
	/*
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
	
	*/
	
	// Monta objeto Ranking com dados completos do usuário a partir do ResultSet com JOIN
	private Ranking montarRankingComUsuario(ResultSet rset) throws Exception {
		Ranking ranking = new Ranking();

		ranking.setId_rank(rset.getInt("id_rank"));
		ranking.setCidade_rank(rset.getString("cidade_rank"));
		ranking.setEstado_rank(rset.getString("estado_rank"));
		ranking.setPais_rank(rset.getString("pais_rank"));
		ranking.setPontos_rank(rset.getFloat("pontos_rank"));
		ranking.setPontosSemana_rank(rset.getFloat("pontosSemana_rank"));

		// Criando usuário com dados completos
		Usuario usuario = new Usuario();
		usuario.setCpfCnpj_user(rset.getString("Usuario"));
		usuario.setNomeRazaoSocial_user(rset.getString("nomeRazaoSocial_user"));
		usuario.setEmail_user(rset.getString("email_user"));
		usuario.setCidade_user(rset.getString("cidade_user"));
		usuario.setEstado_user(rset.getString("estado_user"));
		usuario.setPais_user(rset.getString("pais_user"));
		
		ranking.setUsuario(usuario);

		return ranking;
	}
	
	
}
