package br.com.sharebike.controller;

import java.util.ArrayList;
import java.util.List;

import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.model.Usuario;

public class UsuarioController {
	
	UsuarioDAO usuarioDAO = new UsuarioDAO();
	
	// Função de cadastro de usuario, retorna true se foi criada e salva no banco, false se não foi
	public boolean cadastrarUsuario(String cpfCnpj_user, String nomeRazaoSocial_user, String foto_user, String cidade_user,
			String estado_user, String pais_user, String telefone_user, String email_user, String senha_user,
			float avaliacao_user, boolean permissaoAcesso_user, boolean permissaoRank_user, boolean possuiBike_user,
			String fotoComprBike_user) {
				
		Usuario usuario = new Usuario(cpfCnpj_user, nomeRazaoSocial_user, foto_user, cidade_user, estado_user, pais_user,
				telefone_user, email_user, senha_user, permissaoAcesso_user, permissaoRank_user,
				possuiBike_user, fotoComprBike_user);
		
		int sucesso;
		
		sucesso = usuarioDAO.cadastrarUsuario(usuario);
		
		if(sucesso != 0)
			return true;
		else
			return false;
	}
	
	// Função que irá exibir ao admin todos os usuarios e os usuarios que precisam da sua aprovação para acessar a plataforma
	// e para acessar o ranking
	public List<Usuario> listarUsuario(String tipoListagem){
		List<Usuario> usuarios = new ArrayList<Usuario>();
		
		if(tipoListagem.equalsIgnoreCase("Mostrar Todos Usuarios")) {
			usuarios = usuarioDAO.listarUsuario();
		}
		if(tipoListagem.equalsIgnoreCase("Mostrar Usuarios Aprovacao")) {
			usuarios = usuarioDAO.usuariosParaAprovarAcesso();
		}
		if(tipoListagem.equalsIgnoreCase("Mostrar Usuarios Ranking")) {
			usuarios = usuarioDAO.usuariosParaAprovarRank();
		}
		
		return usuarios;
	}
	
	// Função para retornar um usuario para visibilidade e possiveis modificações
	public Usuario mostrarUsuario(String cpfCnpj_user){
		Usuario usuario = new Usuario();
		usuario = usuarioDAO.exibirUsuario(cpfCnpj_user);
		return usuario;
	}
	
	// Função que o admin aprova o acesso do usuario à plataforma
	public void aprovarUsuario(String cpfCnpj_user) {
		Usuario usuario = mostrarUsuario(cpfCnpj_user);
		
		usuario.setPermissaoAcesso_user(true);
		
		usuarioDAO.editarUsuario(usuario);
		
	}
	
	// Função que o admin aprova que o usuário realmente possui uma bicicleta para participar de rankings sem precisar 
	// fazer reservas
	public void aprovarUsuarioBicicletaPrópria(String cpfCnpj_user) {
		Usuario usuario = mostrarUsuario(cpfCnpj_user);
		
		usuario.setPossuiBike_user(true);
		usuario.setPermissaoRank_user(true);
		
		usuarioDAO.editarUsuario(usuario);
		
	}
	
	// Função que o admin aprova o acesso do Usuario ao ranking
	public void aprovarUsuarioRanking(String cpfCnpj_user) {
		Usuario usuario = mostrarUsuario(cpfCnpj_user);
		
		usuario.setPermissaoRank_user(true);
		
		usuarioDAO.editarUsuario(usuario);
		
	}
	
	
	
}
