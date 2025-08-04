package br.com.sharebike.model;

public class Usuario {
	private String cpfCnpj_user;
	private String nomeRazaoSocial_user;
	private String foto_user;
	private String cidade_user;
	private String estado_user;
	private String pais_user;
	private String telefone_user;
	private String email_user;
	private String senha_user;
	private Float avaliacao_user;
	private boolean permissaoAcesso_user;
	private boolean permissaoRank_user;
	private boolean possuiBike_user;
	private String fotoComprBike_user;
	
	
	public Usuario(String cpfCnpj_user, String nomeRazaoSocial_user, String foto_user, String cidade_user,
			String estado_user, String pais_user, String telefone_user, String email_user, String senha_user,
			String fotoComprBike_user) {
		super();
		this.cpfCnpj_user = cpfCnpj_user;
		this.nomeRazaoSocial_user = nomeRazaoSocial_user;
		this.foto_user = foto_user;
		this.cidade_user = cidade_user;
		this.estado_user = estado_user;
		this.pais_user = pais_user;
		this.telefone_user = telefone_user;
		this.email_user = email_user;
		this.senha_user = senha_user;
		this.avaliacao_user = null;
		this.permissaoAcesso_user = false;
		this.permissaoRank_user = false;
		this.possuiBike_user = false;
		this.fotoComprBike_user = fotoComprBike_user;
	}
	
	public Usuario(String cpfCnpj_user, String nomeRazaoSocial_user, String foto_user, String cidade_user,
			String estado_user, String pais_user, String telefone_user, String email_user, String senha_user,
			Float avaliacao_user, boolean permissaoAcesso_user, boolean permissaoRank_user, boolean possuiBike_user,
			String fotoComprBike_user) {
		super();
		this.cpfCnpj_user = cpfCnpj_user;
		this.nomeRazaoSocial_user = nomeRazaoSocial_user;
		this.foto_user = foto_user;
		this.cidade_user = cidade_user;
		this.estado_user = estado_user;
		this.pais_user = pais_user;
		this.telefone_user = telefone_user;
		this.email_user = email_user;
		this.senha_user = senha_user;
		this.avaliacao_user = avaliacao_user;
		this.permissaoAcesso_user = permissaoAcesso_user;
		this.permissaoRank_user = permissaoRank_user;
		this.possuiBike_user = possuiBike_user;
		this.fotoComprBike_user = fotoComprBike_user;
	}

	public Usuario() {
		super();
	}
	
	public String exibirDados() {
	    return "CPF/CNPJ: " + cpfCnpj_user + 
	           ", Nome/Razao Social: " + nomeRazaoSocial_user +
	           ", Foto: " + foto_user +
	           ", Cidade: " + cidade_user +
	           ", Estado: " + estado_user +
	           ", País: " + pais_user +
	           ", Telefone: " + telefone_user +
	           ", Email: " + email_user +
	           ", Senha: " + senha_user +
	           ", Avaliação: " + avaliacao_user +
	           ", Permissão Acesso: " + permissaoAcesso_user +
	           ", Permissão Rank: " + permissaoRank_user +
	           ", Possui Bike: " + possuiBike_user +
	           ", Foto Comprovacao Bike: " + fotoComprBike_user;
	}
	
	public String getCpfCnpj_user() {
		return cpfCnpj_user;
	}
	
	public void setCpfCnpj_user(String cpfCnpj_user) {
		this.cpfCnpj_user = cpfCnpj_user;
	}
	
	public String getNomeRazaoSocial_user() {
		return nomeRazaoSocial_user;
	}
	
	public void setNomeRazaoSocial_user(String nomeRazaoSocial_user) {
		this.nomeRazaoSocial_user = nomeRazaoSocial_user;
	}
	
	public String getFoto_user() {
		return foto_user;
	}
	
	public void setFoto_user(String foto_user) {
		this.foto_user = foto_user;
	}
	
	public String getCidade_user() {
		return cidade_user;
	}
	
	public void setCidade_user(String cidade_user) {
		this.cidade_user = cidade_user;
	}
	
	public String getEstado_user() {
		return estado_user;
	}
	
	public void setEstado_user(String estado_user) {
		this.estado_user = estado_user;
	}
	
	public String getPais_user() {
		return pais_user;
	}
	
	public void setPais_user(String pais_user) {
		this.pais_user = pais_user;
	}
	
	public String getTelefone_user() {
		return telefone_user;
	}
	
	public void setTelefone_user(String telefone_user) {
		this.telefone_user = telefone_user;
	}
	
	public String getEmail_user() {
		return email_user;
	}
	
	public void setEmail_user(String email_user) {
		this.email_user = email_user;
	}
	
	public String getSenha_user() {
		return senha_user;
	}
	
	public void setSenha_user(String senha_user) {
		this.senha_user = senha_user;
	}
	
	public float getAvaliacao_user() {
		return avaliacao_user;
	}
	
	public void setAvaliacao_user(float avaliacao_user) {
		this.avaliacao_user = avaliacao_user;
	}
	
	public boolean isPermissaoAcesso_user() {
		return permissaoAcesso_user;
	}
	
	public void setPermissaoAcesso_user(boolean permissaoAcesso_user) {
		this.permissaoAcesso_user = permissaoAcesso_user;
	}
	
	public boolean isPermissaoRank_user() {
		return permissaoRank_user;
	}
	
	public void setPermissaoRank_user(boolean permissaoRank_user) {
		this.permissaoRank_user = permissaoRank_user;
	}
	
	public boolean isPossuiBike_user() {
		return possuiBike_user;
	}
	
	public void setPossuiBike_user(boolean possuiBike_user) {
		this.possuiBike_user = possuiBike_user;
	}
	
	public String getFotoComprBike_user() {
		return fotoComprBike_user;
	}
	
	public void setFotoComprBike_user(String fotoComprBike_user) {
		this.fotoComprBike_user = fotoComprBike_user;
	}
	
}
