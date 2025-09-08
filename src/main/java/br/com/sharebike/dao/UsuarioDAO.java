package br.com.sharebike.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import br.com.sharebike.model.Usuario;
import br.com.sharebike.utils.Conexao;

public class UsuarioDAO extends BaseDAO{
		
    // Função para inserir/cadastrar novos usuarios
	public int cadastrarUsuario(Usuario usuario) {
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
					.append("insert into Usuario(cpfCnpj_user, nomeRazaoSocial_user, foto_user, cidade_user, estado_user, pais_user, telefone_user, email_user, senha_user, avaliacao_user, permissaoAcesso_user, permissaoRank_user, possuiBike_user, fotoComprBike_user)")
					.append("values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		
		 String insert = sqlBuilder.toString();
	     int linha = 0;
	     
	     try {
	    	 conexao = Conexao.getConnection();
	    	 
	    	 sql = (PreparedStatement) conexao.prepareStatement(insert);
	    	 sql.setString(1, usuario.getCpfCnpj_user());
	    	 sql.setString(2, usuario.getNomeRazaoSocial_user());
	    	 sql.setString(3, usuario.getFoto_user());
	    	 sql.setString(4, usuario.getCidade_user());
	    	 sql.setString(5, usuario.getEstado_user());
	    	 sql.setString(6, usuario.getPais_user());
	    	 sql.setString(7, usuario.getTelefone_user());
	    	 sql.setString(8, usuario.getEmail_user());
	    	 sql.setString(9, usuario.getSenha_user());
	    	 sql.setObject(10, null);
	    	 sql.setBoolean(11, usuario.isPermissaoAcesso_user());
	    	 sql.setBoolean(12, usuario.isPermissaoRank_user());
	    	 sql.setBoolean(13, usuario.isPossuiBike_user());
	    	 
	    	 // Tratamento seguro para fotoComprBike_user
	    	 String fotoComprBike = usuario.getFotoComprBike_user();
	    	 if (fotoComprBike == null || fotoComprBike.trim().isEmpty()) {
	    		 sql.setString(14, null);
	    	 } else {
	    		 sql.setString(14, fotoComprBike);
	    	 }
	    	 
	    	 linha = sql.executeUpdate();
	    	 
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            fecharConexao();
	        }
	        
	        return linha;
	    	 
	     }
	
	// Função para editar as informações do usuario e aprovar as permissoes 
	public int editarUsuario(Usuario usuario) {
		 String update = "UPDATE Usuario SET nomeRazaoSocial_user = ?, foto_user = ?, cidade_user = ?, estado_user = ?, pais_user = ?, telefone_user = ?, email_user = ?, senha_user = ?, avaliacao_user = ?, permissaoAcesso_user = ?, permissaoRank_user = ?, possuiBike_user = ?, fotoComprBike_user = ? WHERE cpfCnpj_user = ?";
	     
	     int linha = 0;
	     
	     try {
	    	 conexao = Conexao.getConnection();
	    	 
	    	 // Debug: imprimir a query
	    	 System.out.println("SQL Query: " + update);
	    	 System.out.println("Parametros: ");
	    	 System.out.println("1. nomeRazaoSocial: " + usuario.getNomeRazaoSocial_user());
	    	 System.out.println("2. foto: " + usuario.getFoto_user());
	    	 System.out.println("3. cidade: " + usuario.getCidade_user());
	    	 System.out.println("14. cpfCnpj: " + usuario.getCpfCnpj_user());
	    	 
	    	 sql = (PreparedStatement) conexao.prepareStatement(update);
	    	 sql.setString(1, usuario.getNomeRazaoSocial_user());
	    	 sql.setString(2, usuario.getFoto_user());
	    	 sql.setString(3, usuario.getCidade_user());
	    	 sql.setString(4, usuario.getEstado_user());
	    	 sql.setString(5, usuario.getPais_user());
	    	 sql.setString(6, usuario.getTelefone_user());
	    	 sql.setString(7, usuario.getEmail_user());
	    	 sql.setString(8, usuario.getSenha_user());
	    	 sql.setFloat(9, usuario.getAvaliacao_user());
	    	 sql.setBoolean(10, usuario.isPermissaoAcesso_user());
	    	 sql.setBoolean(11, usuario.isPermissaoRank_user());
	    	 sql.setBoolean(12, usuario.isPossuiBike_user());
	    	 sql.setString(13, usuario.getFotoComprBike_user());
	    	 sql.setString(14, usuario.getCpfCnpj_user());
	    	 
	    	 linha = sql.executeUpdate();
	    	 
	     }catch (Exception e){
	    	 e.printStackTrace();
	     } finally {
	    	 fecharConexao();
	     }
	     
	     return linha;
	}
	
	// Atualiza a média de avaliação de um usuário com base nos feedbacks recebidos
	public void atualizarMediaAvaliacao(String cpfCnpj_user) {
	    String query = "UPDATE Usuario " +
	                   "SET avaliacao_user = ( " +
	                   "    SELECT AVG(avaliacaoUser_feedb) " +
	                   "    FROM Feedback " +
	                   "    WHERE Feedback.avaliado_Usuario = ? " +
	                   ") " +
	                   "WHERE cpfCnpj_user = ?";

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(query);
	        sql.setString(1, cpfCnpj_user); // parâmetro do SELECT interno
	        sql.setString(2, cpfCnpj_user); // parâmetro do WHERE externo
	        sql.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }
	}
	
	public void deletarUsuario(String cpfCnpj_user) {
	    String query = "DELETE FROM Usuario WHERE cpfCnpj_user = ?";
	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(query);
	        sql.setString(1, cpfCnpj_user);
	        sql.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }
	}
	
	// Função para aprovar acesso de um usuário específico
	public void aprovarAcessoUsuario(String cpfCnpj_user) {
	    String query = "UPDATE Usuario SET permissaoAcesso_user = true WHERE cpfCnpj_user = ?";
	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(query);
	        sql.setString(1, cpfCnpj_user);
	        sql.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }
	}
	
	// Função para negar acesso de um usuário específico
	public void negarAcessoUsuario(String cpfCnpj_user) {
	    String query = "UPDATE Usuario SET permissaoAcesso_user = false WHERE cpfCnpj_user = ?";
	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(query);
	        sql.setString(1, cpfCnpj_user);
	        sql.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }
	}
	
	// 
	public void deletarFoto(String cpfCnpj_user) {
		String query = "UPDATE Usuario SET fotoComprBike_user = null WHERE cpfCnpj_user = ?";
		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(query);
			sql.setString(1, cpfCnpj_user);
			sql.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}
	}
	
	// Função para aprovar acesso ao ranking
	public void aprovarAcessoRanking(String cpfCnpj_user) {
	    // Primeiro, verifica se o usuário possui bicicleta própria
	    String queryPossuiBike = "UPDATE Usuario " +
	                            "SET permissaoRank_user = true, possuiBike_user = true " +
	                            "WHERE cpfCnpj_user = ? AND fotoComprBike_user IS NOT NULL";
	    
	    // Segundo, verifica se o usuário tem reservas finalizadas (sem bicicleta própria)
	    String queryReservas = "UPDATE Usuario u " +
	                          "SET u.permissaoRank_user = true " +
	                          "WHERE u.cpfCnpj_user = ? " +
	                          "AND u.fotoComprBike_user IS NULL " +
	                          "AND EXISTS ( " +
	                          "    SELECT 1 FROM Reserva r " +
	                          "    WHERE r.Usuario = u.cpfCnpj_user " +
	                          "    AND r.status_reserv = 'FINALIZADA' " +
	                          ")";

	    try {
	        conexao = Conexao.getConnection();
	        
	        // Primeiro tenta aprovar usuários com bicicleta própria
	        sql = conexao.prepareStatement(queryPossuiBike);
	        sql.setString(1, cpfCnpj_user);
	        int linhasAfetadas1 = sql.executeUpdate();
	        
	        // Se não foi afetado pela primeira query, tenta a segunda (usuários sem bicicleta)
	        if (linhasAfetadas1 == 0) {
	            sql = conexao.prepareStatement(queryReservas);
	            sql.setString(1, cpfCnpj_user);
	            sql.executeUpdate();
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }
	}
	
	// Função para encontrar o usuario existente, que  pode servir também para exibir algumas de suas informações
	public Usuario exibirUsuario(String cpfCnpj_user) {
		 StringBuilder sqlBuilder = new StringBuilder();
	     sqlBuilder
	     			.append("select * from Usuario ")
	     			.append("where cpfCnpj_user = ?");
	        
	     String select = sqlBuilder.toString();
	     
	     Usuario usuario = null;
	     
	     try {
	    	 
	    	 conexao = Conexao.getConnection();

	         sql = (PreparedStatement) conexao.prepareStatement(select);

	         sql.setString(1, cpfCnpj_user);

	         rset = sql.executeQuery();
	         
	         while(rset.next()) {
	        	 usuario = new Usuario();
	        	 
	        	 usuario.setCpfCnpj_user(rset.getString("cpfCnpj_user"));
	        	 usuario.setNomeRazaoSocial_user(rset.getString("nomeRazaoSocial_user"));
	        	 usuario.setFoto_user(rset.getString("foto_user"));
	        	 usuario.setCidade_user(rset.getString("cidade_user"));
	        	 usuario.setEstado_user(rset.getString("estado_user"));
	        	 usuario.setPais_user(rset.getString("pais_user"));
	        	 usuario.setTelefone_user(rset.getString("telefone_user"));
	        	 usuario.setEmail_user(rset.getString("email_user"));
	        	 usuario.setSenha_user(rset.getString("senha_user"));
	        	 // Tratar avaliacao_user como nullable
	        	 Float avaliacao = rset.getFloat("avaliacao_user");
	        	 if (rset.wasNull()) {
	        	     usuario.setAvaliacao_user(null);
	        	 } else {
	        	     usuario.setAvaliacao_user(avaliacao);
	        	 }
	        	 usuario.setPermissaoAcesso_user(rset.getBoolean("permissaoAcesso_user"));
	        	 usuario.setPermissaoRank_user(rset.getBoolean("permissaoRank_user"));
	        	 usuario.setPossuiBike_user(rset.getBoolean("possuiBike_user"));
	        	 usuario.setFotoComprBike_user(rset.getString("fotoComprBike_user"));
	         }
	    	 
	     }catch (Exception e) {
	    	 e.printStackTrace();
	     } finally {
	    	 fecharConexao();
	     }
	     
	     return usuario;
	}
	
	// Função para mostrar todos os usuarios
	public List<Usuario> listarUsuario(){
		
		String select = "select * from Usuario";
		
		List<Usuario> usuarios = new ArrayList<Usuario>();
		
		try {
			conexao = Conexao.getConnection();
			
			sql = (PreparedStatement) conexao.prepareStatement(select);
			
			rset = sql.executeQuery();
			
			while (rset.next()) {
				Usuario usuario = new Usuario();
				
				usuario.setCpfCnpj_user(rset.getString("cpfCnpj_user"));
				usuario.setNomeRazaoSocial_user(rset.getString("nomeRazaoSocial_user"));
				usuario.setFoto_user(rset.getString("foto_user"));
				usuario.setCidade_user(rset.getString("cidade_user"));
				usuario.setEstado_user(rset.getString("estado_user"));
				usuario.setPais_user(rset.getString("pais_user"));
				usuario.setTelefone_user(rset.getString("telefone_user"));
				usuario.setEmail_user(rset.getString("email_user"));
				usuario.setSenha_user(rset.getString("senha_user"));
				// Tratar avaliacao_user como nullable
				Float avaliacao = rset.getFloat("avaliacao_user");
				if (rset.wasNull()) {
				    usuario.setAvaliacao_user(null);
				} else {
				    usuario.setAvaliacao_user(avaliacao);
				}
				usuario.setPermissaoAcesso_user(rset.getBoolean("permissaoAcesso_user"));
				usuario.setPermissaoRank_user(rset.getBoolean("permissaoRank_user"));
				usuario.setPossuiBike_user(rset.getBoolean("possuiBike_user"));
				usuario.setFotoComprBike_user(rset.getString("fotoComprBike_user"));
				
				usuarios.add(usuario);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}
		
		return usuarios;
	}
	
	// Função para mostrar os usuarios que precisam da aprovação do admin para acessarem a plataforma
	public List<Usuario> usuariosParaAprovarAcesso(){
		StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder
                .append("select * from Usuario ")
                .append("where permissaoAcesso_user = false");
        
        String select = sqlBuilder.toString();
		
		List<Usuario> usuarios = new ArrayList<Usuario>();
		
		try {
			conexao = Conexao.getConnection();
			
			sql = (PreparedStatement) conexao.prepareStatement(select);
			
			rset = sql.executeQuery();
			
			while (rset.next()) {
				Usuario usuario = new Usuario();
				
				usuario.setCpfCnpj_user(rset.getString("cpfCnpj_user"));
				usuario.setNomeRazaoSocial_user(rset.getString("nomeRazaoSocial_user"));
				usuario.setFoto_user(rset.getString("foto_user"));
				usuario.setCidade_user(rset.getString("cidade_user"));
				usuario.setEstado_user(rset.getString("estado_user"));
				usuario.setPais_user(rset.getString("pais_user"));
				usuario.setTelefone_user(rset.getString("telefone_user"));
				usuario.setEmail_user(rset.getString("email_user"));
				usuario.setSenha_user(rset.getString("senha_user"));
				// Tratar avaliacao_user como nullable
				Float avaliacao = rset.getFloat("avaliacao_user");
				if (rset.wasNull()) {
				    usuario.setAvaliacao_user(null);
				} else {
				    usuario.setAvaliacao_user(avaliacao);
				}
				usuario.setPermissaoAcesso_user(rset.getBoolean("permissaoAcesso_user"));
				usuario.setPermissaoRank_user(rset.getBoolean("permissaoRank_user"));
				usuario.setPossuiBike_user(rset.getBoolean("possuiBike_user"));
				usuario.setFotoComprBike_user(rset.getString("fotoComprBike_user"));
				
				usuarios.add(usuario);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}
		
		return usuarios;
	}
	
	// Função para mostrar os usuarios que precisam da aprovação do admin para acessarem a plataforma
	public List<Usuario> usuariosAtivos(){
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
		.append("select * from Usuario ")
		.append("where permissaoAcesso_user = false");

		String select = sqlBuilder.toString();

		List<Usuario> usuarios = new ArrayList<Usuario>();

		try {
			conexao = Conexao.getConnection();

			sql = (PreparedStatement) conexao.prepareStatement(select);

			rset = sql.executeQuery();

			while (rset.next()) {
				Usuario usuario = new Usuario();

				usuario.setCpfCnpj_user(rset.getString("cpfCnpj_user"));
				usuario.setNomeRazaoSocial_user(rset.getString("nomeRazaoSocial_user"));
				usuario.setFoto_user(rset.getString("foto_user"));
				usuario.setCidade_user(rset.getString("cidade_user"));
				usuario.setEstado_user(rset.getString("estado_user"));
				usuario.setPais_user(rset.getString("pais_user"));
				usuario.setTelefone_user(rset.getString("telefone_user"));
				usuario.setEmail_user(rset.getString("email_user"));
				usuario.setSenha_user(rset.getString("senha_user"));
				// Tratar avaliacao_user como nullable
				Float avaliacao = rset.getFloat("avaliacao_user");
				if (rset.wasNull()) {
				    usuario.setAvaliacao_user(null);
				} else {
				    usuario.setAvaliacao_user(avaliacao);
				}
				usuario.setPermissaoAcesso_user(rset.getBoolean("permissaoAcesso_user"));
				usuario.setPermissaoRank_user(rset.getBoolean("permissaoRank_user"));
				usuario.setPossuiBike_user(rset.getBoolean("possuiBike_user"));
				usuario.setFotoComprBike_user(rset.getString("fotoComprBike_user"));

				usuarios.add(usuario);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return usuarios;
	}
	
	
	// Função para mostrar os usuarios que precisam da aprovação do admin para acessarem e usarem o ranking 
	public List<Usuario> usuariosParaAprovarRank(){
		StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder
                .append("select * from Usuario ")
                .append("where permissaoRank_user = false AND permissaoAcesso_user = true");
        String select = sqlBuilder.toString();
		
		List<Usuario> usuarios = new ArrayList<Usuario>();
		
		try {
			conexao = Conexao.getConnection();
			
			sql = (PreparedStatement) conexao.prepareStatement(select);
			
			rset = sql.executeQuery();
			
			while (rset.next()) {
				Usuario usuario = new Usuario();
				
				usuario.setCpfCnpj_user(rset.getString("cpfCnpj_user"));
				usuario.setNomeRazaoSocial_user(rset.getString("nomeRazaoSocial_user"));
				usuario.setFoto_user(rset.getString("foto_user"));
				usuario.setCidade_user(rset.getString("cidade_user"));
				usuario.setEstado_user(rset.getString("estado_user"));
				usuario.setPais_user(rset.getString("pais_user"));
				usuario.setTelefone_user(rset.getString("telefone_user"));
				usuario.setEmail_user(rset.getString("email_user"));
				usuario.setSenha_user(rset.getString("senha_user"));
				// Tratar avaliacao_user como nullable
				Float avaliacao = rset.getFloat("avaliacao_user");
				if (rset.wasNull()) {
				    usuario.setAvaliacao_user(null);
				} else {
				    usuario.setAvaliacao_user(avaliacao);
				}
				usuario.setPermissaoAcesso_user(rset.getBoolean("permissaoAcesso_user"));
				usuario.setPermissaoRank_user(rset.getBoolean("permissaoRank_user"));
				usuario.setPossuiBike_user(rset.getBoolean("possuiBike_user"));
				usuario.setFotoComprBike_user(rset.getString("fotoComprBike_user"));
				
				usuarios.add(usuario);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}
		
		return usuarios;
	}
}
