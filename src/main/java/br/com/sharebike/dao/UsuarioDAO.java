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
	    	 
	    	 if(usuario.getFotoComprBike_user().equals(""))
	    		 sql.setString(14, null);
	    	 else
	    		 sql.setString(14, usuario.getFotoComprBike_user());
	    	 
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
		 StringBuilder sqlBuilder = new StringBuilder();
	     sqlBuilder
	     			.append("update Usuario set")
	     			.append("foto_user = ?,")
	     			.append("cidade_user = ?,")
	     			.append("estado_user = ?,")
	     			.append("pais_user = ?,")
	     			.append("telefone_user = ?,")
	     			.append("email_user = ?,")
	     			.append("senha_user = ?,")
	     			.append("avaliacao_user = ?,")
	     			.append("permissaoAcesso_user = ?,")
	     			.append("permissaoRank_user = ?,")
	     			.append("possuiBike_user = ?,")
	     			.append("fotoComprBike_user = ?")
	     			.append("where cpfCnpj_user = ?");
	     
	     String update = sqlBuilder.toString();
	     int linha = 0;
	     
	     try {
	    	 conexao = Conexao.getConnection();
	    	 
	    	 sql = (PreparedStatement) conexao.prepareStatement(update);
	    	 sql.setString(1, usuario.getFoto_user());
	    	 sql.setString(2, usuario.getCidade_user());
	    	 sql.setString(3, usuario.getEstado_user());
	    	 sql.setString(4, usuario.getPais_user());
	    	 sql.setString(5, usuario.getTelefone_user());
	    	 sql.setString(6, usuario.getEmail_user());
	    	 sql.setString(7, usuario.getSenha_user());
	    	 sql.setFloat(8, usuario.getAvaliacao_user());
	    	 sql.setBoolean(9, usuario.isPermissaoAcesso_user());
	    	 sql.setBoolean(10, usuario.isPermissaoRank_user());
	    	 sql.setBoolean(11, usuario.isPossuiBike_user());
	    	 sql.setString(12, usuario.getFotoComprBike_user());
	    	 sql.setString(13, usuario.getCpfCnpj_user());
	    	 
	    	 linha = sql.executeUpdate();
	    	 
	     }catch (Exception e){
	    	 e.printStackTrace();
	     } finally {
	    	 fecharConexao();
	     }
	     
	     return linha;
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
				usuario.setAvaliacao_user(rset.getFloat("avaliacao_user"));
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
				usuario.setAvaliacao_user(rset.getFloat("avaliacao_user"));
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
	        sql.setString(1, cpfCnpj_user); // parâmetro do subselect
	        sql.setString(2, cpfCnpj_user); // parâmetro do where externo
	        sql.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }
	}

	
	// Função para mostrar os usuarios que precisam da aprovação do admin para acessarem e usarem o ranking 
	public List<Usuario> usuariosParaAprovarRank(){
		StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder
                .append("select * from Usuario ")
                .append("where fotoComprBike_user is not null") // Verificar se é isso mesmo // == ""
        		.append("AND permissaoRank_user = false");
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
				usuario.setAvaliacao_user(rset.getFloat("avaliacao_user"));
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
	
	// Função para aprovar acesso ao ranking
	public void aprovarAcessoRanking(String cpfCnpj_user) {
	    String query = "UPDATE Usuario u " +
	                   "JOIN ( " +
	                   "    SELECT DISTINCT Usuario " +
	                   "    FROM Reserva " +
	                   "    WHERE status_reserv = 'FINALIZADA' " +
	                   ") AS locatarios_aptos ON u.cpfCnpj_user = locatarios_aptos.Usuario " +
	                   "SET u.permissaoRank_user = true " +
	                   "WHERE u.cpfCnpj_user = ?;";

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
	        	 usuario.setAvaliacao_user(rset.getFloat("avaliacao_user"));
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
}
