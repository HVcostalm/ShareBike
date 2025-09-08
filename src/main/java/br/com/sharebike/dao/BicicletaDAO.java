package br.com.sharebike.dao;

import java.util.ArrayList;
import java.util.List;

import br.com.sharebike.model.Bicicleta;
import br.com.sharebike.model.Usuario;
import br.com.sharebike.utils.Conexao;

public class BicicletaDAO extends BaseDAO{
	
	// Cadastrar bicicleta
	public int cadastrarBicicleta(Bicicleta bicicleta) {
		String insert = "INSERT INTO Bicicleta(nome_bike, foto_bike, localEntr_bike, chassi_bike, estadoConserv_bike, tipo_bike, avaliacao_bike, Usuario)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		int linha = 0;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(insert);
			
			sql.setString(1, bicicleta.getNome_bike());
			sql.setString(2, bicicleta.getFoto_bike());
			sql.setString(3, bicicleta.getLocalEntr_bike());
			sql.setString(4, bicicleta.getChassi_bike());
			sql.setString(5, bicicleta.getEstadoConserv_bike());
			sql.setString(6, bicicleta.getTipo_bike());
			sql.setObject(7, null);
			sql.setString(8, bicicleta.getUsuario().getCpfCnpj_user());

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
		String update = "UPDATE Bicicleta SET nome_bike = ?, foto_bike = ?, localEntr_bike = ?, chassi_bike = ?, estadoConserv_bike = ?, tipo_bike = ?, avaliacao_bike = ?, Usuario = ? "
				+ "WHERE id_bike = ?";
		int linha = 0;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(update);
			
			// Debug da avaliação
			System.out.println("DEBUG - Bicicleta ID: " + bicicleta.getId_bike() + ", Avaliação: " + bicicleta.getAvaliacao_bike());
			
			sql.setString(1, bicicleta.getNome_bike());
			sql.setString(2, bicicleta.getFoto_bike());
			sql.setString(3, bicicleta.getLocalEntr_bike());
			sql.setString(4, bicicleta.getChassi_bike());
			sql.setString(5, bicicleta.getEstadoConserv_bike());
			sql.setString(6, bicicleta.getTipo_bike());
			
			// Tratar avaliação nula
			Float avaliacao = bicicleta.getAvaliacao_bike();
			if (avaliacao != null) {
				sql.setFloat(7, avaliacao);
			} else {
				sql.setFloat(7, 0.0f); // Valor padrão se for null
			}
			
			sql.setString(8, bicicleta.getUsuario().getCpfCnpj_user());
			sql.setInt(9, bicicleta.getId_bike());
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
                bike.setNome_bike(rset.getString("nome_bike"));
                bike.setFoto_bike(rset.getString("foto_bike"));
                bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
                bike.setChassi_bike(rset.getString("chassi_bike"));
                bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
                bike.setTipo_bike(rset.getString("tipo_bike"));
                
                // Verificar se avaliacao_bike é NULL para não retornar 0.0f
                Float avaliacao = rset.getObject("avaliacao_bike", Float.class);
                bike.setAvaliacao_bike(avaliacao);

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
 				bike.setNome_bike(rset.getString("nome_bike"));
                 bike.setFoto_bike(rset.getString("foto_bike"));
 				bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
 				bike.setChassi_bike(rset.getString("chassi_bike"));
 				bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
 				bike.setTipo_bike(rset.getString("tipo_bike"));
 				
 				// Verificar se avaliacao_bike é NULL para não retornar 0.0f
                Float avaliacao = rset.getObject("avaliacao_bike", Float.class);
                bike.setAvaliacao_bike(avaliacao);

 				String cpfCnpjUsuario = rset.getString("Usuario");

 				// Buscar o usuário completo com UsuarioDAO
 				UsuarioDAO usuarioDAO = new UsuarioDAO();
 				Usuario usuario = usuarioDAO.exibirUsuario(cpfCnpjUsuario);
 				bike.setUsuario(usuario);
 			}

 		} catch (Exception e) {
 			e.printStackTrace();
 		} finally {
 			fecharConexao();
 		}

 		return bike;
 	}
    
	// Atualiza a avaliação média da bicicleta com base nas avaliações recebidas nas
	// reservas
	public int atualizarAvaliacaoBicicleta(int idBicicleta) {
		String update = """
				    UPDATE Bicicleta
				    SET avaliacao_bike = (
				        SELECT AVG(f.avaliacaoBike_feedb)
				        FROM Feedback f
				        INNER JOIN Reserva r ON f.Reserva = r.id_reserv
				        WHERE r.Bicicleta = ? 
				        AND f.avaliador_Usuario = r.Usuario
				        AND f.avaliacaoBike_feedb > 0
				    )
				    WHERE id_bike = ?
				""";

		int linhaAfetada = 0;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(update);
			sql.setInt(1, idBicicleta); // para o subselect (r.Bicicleta = ?)
			sql.setInt(2, idBicicleta); // para o update (where id_bike = ?)

			linhaAfetada = sql.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return linhaAfetada;
	}

 	
	// Listar todas as bicicletas
	public List<Bicicleta> listarBicicletas() {
		String select = "SELECT b.*, u.nomeRazaoSocial_user, u.telefone_user, u.cidade_user " +
		               "FROM Bicicleta b " +
		               "JOIN Usuario u ON b.Usuario = u.cpfCnpj_user";
		List<Bicicleta> bicicletas = new ArrayList<>();

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			rset = sql.executeQuery();

			while (rset.next()) {
				Bicicleta bike = new Bicicleta();

				bike.setId_bike(rset.getInt("id_bike"));
				bike.setNome_bike(rset.getString("nome_bike"));
                bike.setFoto_bike(rset.getString("foto_bike"));
				bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
				bike.setChassi_bike(rset.getString("chassi_bike"));
				bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
				bike.setTipo_bike(rset.getString("tipo_bike"));
				
				// Verificar se avaliacao_bike é NULL para não retornar 0.0f
                Float avaliacao = rset.getObject("avaliacao_bike", Float.class);
                bike.setAvaliacao_bike(avaliacao);

				Usuario usuario = new Usuario();
				usuario.setCpfCnpj_user(rset.getString("Usuario"));
				usuario.setNomeRazaoSocial_user(rset.getString("nomeRazaoSocial_user"));
				usuario.setTelefone_user(rset.getString("telefone_user"));
				usuario.setCidade_user(rset.getString("cidade_user"));
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
	
	// Método para verificar se uma bicicleta tem disponibilidade
	public boolean verificarDisponibilidade(int idBicicleta) {
		String select = "SELECT COUNT(*) as total FROM Disponibilidade WHERE Bicicleta = ? AND disponivel_disp = true";
		boolean temDisponibilidade = false;
		
		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(select);
			sql.setInt(1, idBicicleta);
			rset = sql.executeQuery();
			
			if (rset.next()) {
				temDisponibilidade = rset.getInt("total") > 0;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}
		
		return temDisponibilidade;
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
	            bike.setNome_bike(rset.getString("nome_bike"));
                bike.setFoto_bike(rset.getString("foto_bike"));
	            bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
	            bike.setChassi_bike(rset.getString("chassi_bike"));
	            bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
	            bike.setTipo_bike(rset.getString("tipo_bike"));
	            
	            // Verificar se avaliacao_bike é NULL para não retornar 0.0f
                Float avaliacao = rset.getObject("avaliacao_bike", Float.class);
                bike.setAvaliacao_bike(avaliacao);

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
	
	public List<Bicicleta> listarBicicletasDisponiveisFiltradas(String cidade, String tipo, String estado, String ordemAvaliacao) {
	    List<Bicicleta> bicicletas = new ArrayList<>();

	    StringBuilder sqlBuilder = new StringBuilder();
	    sqlBuilder
	        .append("SELECT DISTINCT b.* ")
	        .append("FROM Bicicleta b ")
	        .append("JOIN Usuario u ON b.Usuario = u.cpfCnpj_user ")
	        .append("JOIN Disponibilidade d ON b.id_bike = d.Bicicleta ")
	        .append("WHERE d.disponivel_disp = true ");

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

	    // Ordenação por avaliação
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
	            bike.setNome_bike(rset.getString("nome_bike"));
	            bike.setFoto_bike(rset.getString("foto_bike"));
	            bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
	            bike.setChassi_bike(rset.getString("chassi_bike"));
	            bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
	            bike.setTipo_bike(rset.getString("tipo_bike"));
	            bike.setAvaliacao_bike(rset.getObject("avaliacao_bike", Float.class));

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
	
	// Método sobrecarregado que exclui bicicletas de um usuário específico (para locatários)
	public List<Bicicleta> listarBicicletasDisponiveisFiltradas(String cidade, String tipo, String estado, String ordemAvaliacao, String cpfExcluir) {
	    List<Bicicleta> bicicletas = new ArrayList<>();

	    StringBuilder sqlBuilder = new StringBuilder();
	    sqlBuilder
	        .append("SELECT DISTINCT b.* ")
	        .append("FROM Bicicleta b ")
	        .append("JOIN Usuario u ON b.Usuario = u.cpfCnpj_user ")
	        .append("JOIN Disponibilidade d ON b.id_bike = d.Bicicleta ")
	        .append("WHERE d.disponivel_disp = true ");

	    // Excluir bicicletas do próprio usuário (evita que locatário veja suas próprias bikes)
	    if (cpfExcluir != null && !cpfExcluir.isEmpty()) {
	        sqlBuilder.append("AND b.Usuario != ? ");
	    }

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

	    // Ordenação por avaliação
	    if ("asc".equalsIgnoreCase(ordemAvaliacao)) {
	        sqlBuilder.append("ORDER BY b.avaliacao_bike ASC");
	    } else if ("desc".equalsIgnoreCase(ordemAvaliacao)) {
	        sqlBuilder.append("ORDER BY b.avaliacao_bike DESC");
	    }

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(sqlBuilder.toString());

	        int index = 1;
	        
	        // Configurar parâmetro de exclusão primeiro
	        if (cpfExcluir != null && !cpfExcluir.isEmpty()) {
	            sql.setString(index++, cpfExcluir);
	        }
	        
	        // Configurar filtros na ordem correta
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
	            bike.setNome_bike(rset.getString("nome_bike"));
	            bike.setFoto_bike(rset.getString("foto_bike"));
	            bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
	            bike.setChassi_bike(rset.getString("chassi_bike"));
	            bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
	            bike.setTipo_bike(rset.getString("tipo_bike"));
	            bike.setAvaliacao_bike(rset.getObject("avaliacao_bike", Float.class));

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
	
	/*
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
	            bike.setNome_bike(rset.getString("nome_bike"));
                bike.setFoto_bike(rset.getString("foto_bike"));
	            bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
	            bike.setChassi_bike(rset.getString("chassi_bike"));
	            bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
	            bike.setTipo_bike(rset.getString("tipo_bike"));
	            bike.setAvaliacao_bike(rset.getObject("avaliacao_bike", Float.class));

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
	            bike.setNome_bike(rset.getString("nome_bike"));
                bike.setFoto_bike(rset.getString("foto_bike"));
	            bike.setLocalEntr_bike(rset.getString("localEntr_bike"));
	            bike.setChassi_bike(rset.getString("chassi_bike"));
	            bike.setEstadoConserv_bike(rset.getString("estadoConserv_bike"));
	            bike.setTipo_bike(rset.getString("tipo_bike"));
	            bike.setAvaliacao_bike(rset.getObject("avaliacao_bike", Float.class));

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
	*/
}
