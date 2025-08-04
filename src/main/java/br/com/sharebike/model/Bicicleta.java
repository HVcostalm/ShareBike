package br.com.sharebike.model;

public class Bicicleta {
	private int id_bike;
	private String nome_bike;
	private String foto_bike;
	private String localEntr_bike;
	private String chassi_bike;
	private String estadoConserv_bike;
	private String tipo_bike;
	private Float avaliacao_bike;
	private Usuario usuario;
		
	
	public Bicicleta() {
		super();
	}
	
	public Bicicleta(int id_bike, String nome_bike, String foto_bike, String localEntr_bike, String chassi_bike,
			String estadoConserv_bike, String tipo_bike, Float avaliacao_bike, Usuario usuario) {
		super();
		this.id_bike = id_bike;
		this.nome_bike = nome_bike;
		this.foto_bike = foto_bike;
		this.localEntr_bike = localEntr_bike;
		this.chassi_bike = chassi_bike;
		this.estadoConserv_bike = estadoConserv_bike;
		this.tipo_bike = tipo_bike;
		this.avaliacao_bike = avaliacao_bike;
		this.usuario = usuario;
	}
	
	public Bicicleta(String nome_bike, String foto_bike, String localEntr_bike, String chassi_bike, String estadoConserv_bike,
			String tipo_bike, Usuario usuario) {
		super();
		this.nome_bike = nome_bike;
		this.foto_bike = foto_bike;
		this.localEntr_bike = localEntr_bike;
		this.chassi_bike = chassi_bike;
		this.estadoConserv_bike = estadoConserv_bike;
		this.tipo_bike = tipo_bike;
		this.avaliacao_bike = null;
		this.usuario = usuario;
	}

	public String exibirDados() {
	    return "id: " + id_bike + 
	    	   ", Nome: " + nome_bike +
	    	   ", Foto: " + foto_bike +
	           ", Local de Entrega: " + localEntr_bike +
	           ", Chassi: " + chassi_bike +
	           ", Estado de Conservação: " + estadoConserv_bike +
	           ", Tipo: " + tipo_bike +
	           ", Avaliação: " + avaliacao_bike +
	           ", Usuario: " + usuario.getNomeRazaoSocial_user();
	}
	

	public int getId_bike() {
		return id_bike;
	}
	
	public void setId_bike(int id_bike) {
		this.id_bike = id_bike;
	}
	
	public String getNome_bike() {
		return nome_bike;
	}

	public void setNome_bike(String nome_bike) {
		this.nome_bike = nome_bike;
	}

	public String getFoto_bike() {
		return foto_bike;
	}

	public void setFoto_bike(String foto_bike) {
		this.foto_bike = foto_bike;
	}

	public String getLocalEntr_bike() {
		return localEntr_bike;
	}
	
	public void setLocalEntr_bike(String localEntr_bike) {
		this.localEntr_bike = localEntr_bike;
	}
	
	public String getChassi_bike() {
		return chassi_bike;
	}
	
	public void setChassi_bike(String chassi_bike) {
		this.chassi_bike = chassi_bike;
	}
	
	public String getEstadoConserv_bike() {
		return estadoConserv_bike;
	}
	
	public void setEstadoConserv_bike(String estadoConserv_bike) {
		this.estadoConserv_bike = estadoConserv_bike;
	}
	
	public String getTipo_bike() {
		return tipo_bike;
	}
	
	public void setTipo_bike(String tipo_bike) {
		this.tipo_bike = tipo_bike;
	}
	
	public float getAvaliacao_bike() {
		return avaliacao_bike;
	}
	
	public void setAvaliacao_bike(Float avaliacao_bike) {
		this.avaliacao_bike = avaliacao_bike;
	}
	
	public Usuario getUsuario() {
		return usuario;
	}
	
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
	
}
