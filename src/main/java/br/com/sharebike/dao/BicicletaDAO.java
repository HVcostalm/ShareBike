package br.com.sharebike.dao;

import java.util.ArrayList;
import java.util.List;

import br.com.sharebike.model.Bicicleta;
import br.com.sharebike.model.Usuario;
import br.com.sharebike.utils.Conexao;

public class BicicletaDAO extends BaseDAO{

	// Cadastrar bicicleta
	public int cadastrarBicicleta(Bicicleta bicicleta) {
		String insert = "INSERT INTO Bicicleta(localEntr_bike, chassi_bike, estadoConserv_bike, tipo_bike, avaliacao_bike, Usuario) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		int linha = 0;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(insert);

			sql.setString(1, bicicleta.getLocalEntr_bike());
			sql.setString(2, bicicleta.getChassi_bike());
			sql.setString(3, bicicleta.getEstadoConserv_bike());
			sql.setString(4, bicicleta.getTipo_bike());
			sql.setFloat(5, bicicleta.getAvaliacao_bike());
			sql.setString(6, bicicleta.getUsuario().getCpfCnpj_user());

			linha = sql.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return linha;
	}

	// Editar bicicleta
	public int editarBicicleta(Bicicleta bicicleta) {
		String update = "UPDATE Bicicleta SET localEntr_bike = ?, chassi_bike = ?, estadoConserv_bike = ?, tipo_bike = ?, avaliacao_bike = ?, Usuario = ? "
				+ "WHERE id_bike = ?";
		int linha = 0;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(update);

			sql.setString(1, bicicleta.getLocalEntr_bike());
			sql.setString(2, bicicleta.getChassi_bike());
			sql.setString(3, bicicleta.getEstadoConserv_bike());
			sql.setString(4, bicicleta.getTipo_bike());
			sql.setFloat(5, bicicleta.getAvaliacao_bike());
			sql.setString(6, bicicleta.getUsuario().getCpfCnpj_user());
			sql.setInt(7, bicicleta.getId_bike());

			linha = sql.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return linha;
	}
	
    // Buscar bicicleta por ID
    public Bicicleta buscarPorId(int id) {
        String select = "SELECT * FROM Bicicleta WHERE id_bike = ?";
        Bicicleta bike = null;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(select);
            sql.setInt(1, id);
            rset = sql.executeQuery();

            if (rset.next()) {
                bike = new Bicicleta();

                bike.setId_bike(rset.getInt("id_bike"));
                bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
                bike.setChassi_bike(rset.getString("chassi_bike"));
                bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
                bike.setTipo_bike(rset.getString("tipo_bike"));
                bike.setAvaliacao_bike(rset.getFloat("avaliacao_bike"));

                Usuario usuario = new Usuario();
                usuario.setCpfCnpj_user(rset.getString("Usuario"));
                bike.setUsuario(usuario);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return bike;
    }
	
	// Listar todas as bicicletas
	public List<Bicicleta> listarBicicletas() {
		String select = "SELECT * FROM Bicicleta";
		List<Bicicleta> bicicletas = new ArrayList<>();

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			rset = sql.executeQuery();

			while (rset.next()) {
				Bicicleta bike = new Bicicleta();

				bike.setId_bike(rset.getInt("id_bike"));
				bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
				bike.setChassi_bike(rset.getString("chassi_bike"));
				bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
				bike.setTipo_bike(rset.getString("tipo_bike"));
				bike.setAvaliacao_bike(rset.getFloat("avaliacao_bike"));

				Usuario usuario = new Usuario();
				usuario.setCpfCnpj_user(rset.getString("Usuario"));
				bike.setUsuario(usuario);

				bicicletas.add(bike);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return bicicletas;
	}
	
	// Função traz os dados da bike e também carrega o Usuario completo
	public Bicicleta buscarBicicletaComUsuario(int id_bike) {
		String select = "SELECT * FROM Bicicleta WHERE id_bike = ?";
		Bicicleta bike = null;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			sql.setInt(1, id_bike);
			rset = sql.executeQuery();

			if (rset.next()) {
				bike = new Bicicleta();

				bike.setId_bike(rset.getInt("id_bike"));
				bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
				bike.setChassi_bike(rset.getString("chassi_bike"));
				bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
				bike.setTipo_bike(rset.getString("tipo_bike"));
				bike.setAvaliacao_bike(rset.getFloat("avaliacao_bike"));

				String cpfUsuario = rset.getString("Usuario");

				// Buscar o usuário completo com UsuarioDAO
				UsuarioDAO usuarioDAO = new UsuarioDAO();
				Usuario usuario = usuarioDAO.exibirUsuario(cpfUsuario);
				bike.setUsuario(usuario);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return bike;
	}

	// Lista todas as bicicletas associadas a um determinado usuário.
	public List<Bicicleta> listarBicicletasPorUsuario(String cpfCnpj_user) {
	    String select = "SELECT * FROM Bicicleta WHERE Usuario = ?";
	    List<Bicicleta> bicicletas = new ArrayList<>();

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(select);
	        sql.setString(1, cpfCnpj_user);

	        rset = sql.executeQuery();

	        while (rset.next()) {
	            Bicicleta bike = new Bicicleta();

	            bike.setId_bike(rset.getInt("id_bike"));
	            bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
	            bike.setChassi_bike(rset.getString("chassi_bike"));
	            bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
	            bike.setTipo_bike(rset.getString("tipo_bike"));
	            bike.setAvaliacao_bike(rset.getFloat("avaliacao_bike"));

	            Usuario usuario = new Usuario();
	            usuario.setCpfCnpj_user(cpfCnpj_user);
	            bike.setUsuario(usuario);

	            bicicletas.add(bike);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }

	    return bicicletas;
	}
	
	// Função para aplicar múltiplos filtros  
	public List<Bicicleta> listarBicicletasFiltradas(String cidade, String tipo, String estado, String ordemAvaliacao) {
	    List<Bicicleta> bicicletas = new ArrayList<>();

	    StringBuilder sqlBuilder = new StringBuilder();
	    sqlBuilder
	        .append("SELECT b.* ")
	        .append("FROM Bicicleta b ")
	        .append("JOIN Usuario u ON b.Usuario = u.cpfCnpj_user ")
	        .append("WHERE 1=1 ");

	    // Filtros opcionais
	    if (cidade != null && !cidade.isEmpty()) {
	        sqlBuilder.append("AND u.cidade_user = ? ");
	    }
	    if (tipo != null && !tipo.isEmpty()) {
	        sqlBuilder.append("AND b.tipo_bike = ? ");
	    }
	    if (estado != null && !estado.isEmpty()) {
	        sqlBuilder.append("AND b.estadoConserv_bike = ? ");
	    }

	    // Ordenação da avaliação
	    if ("asc".equalsIgnoreCase(ordemAvaliacao)) {
	        sqlBuilder.append("ORDER BY b.avaliacao_bike ASC");
	    } else if ("desc".equalsIgnoreCase(ordemAvaliacao)) {
	        sqlBuilder.append("ORDER BY b.avaliacao_bike DESC");
	    }

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(sqlBuilder.toString());

	        int index = 1;
	        if (cidade != null && !cidade.isEmpty()) {
	            sql.setString(index++, cidade);
	        }
	        if (tipo != null && !tipo.isEmpty()) {
	            sql.setString(index++, tipo);
	        }
	        if (estado != null && !estado.isEmpty()) {
	            sql.setString(index++, estado);
	        }

	        rset = sql.executeQuery();

	        while (rset.next()) {
	            Bicicleta bike = new Bicicleta();

	            bike.setId_bike(rset.getInt("id_bike"));
	            bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
	            bike.setChassi_bike(rset.getString("chassi_bike"));
	            bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
	            bike.setTipo_bike(rset.getString("tipo_bike"));
	            bike.setAvaliacao_bike(rset.getFloat("avaliacao_bike"));

	            // Apenas CPF/CNPJ do usuário
	            Usuario usuario = new Usuario();
	            usuario.setCpfCnpj_user(rset.getString("Usuario"));
	            bike.setUsuario(usuario);

	            bicicletas.add(bike);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }

	    return bicicletas;
	}
	
	public List<Bicicleta> listarBicicletasComDisponibilidade() {
	    String select = """
	    		SELECT DISTINCT b.*
	    		FROM Bicicleta b
	    		JOIN Disponibilidade d ON b.id_bike = d.Bicicleta
	    		WHERE d.disponivel_disp = true
	    """;

	    List<Bicicleta> bicicletas = new ArrayList<>();

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(select);
	        rset = sql.executeQuery();

	        while (rset.next()) {
	            Bicicleta bike = new Bicicleta();

	            bike.setId_bike(rset.getInt("id_bike"));
	            bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
	            bike.setChassi_bike(rset.getString("chassi_bike"));
	            bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
	            bike.setTipo_bike(rset.getString("tipo_bike"));
	            bike.setAvaliacao_bike(rset.getFloat("avaliacao_bike"));

	            Usuario usuario = new Usuario();
	            usuario.setCpfCnpj_user(rset.getString("Usuario"));
	            bike.setUsuario(usuario);

	            bicicletas.add(bike);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }

	    return bicicletas;
	}

}
