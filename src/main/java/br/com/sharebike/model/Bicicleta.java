package br.com.sharebike.model;

public class Bicicleta {
	private int id_bike;
	private String localEntr_bike;
	private String chassi_bike;
	private String estadoConserv_bike;
	private String tipo_bike;
	private float avaliacao_bike;
	private Usuario usuario;
	
	public int getId_bike() {
		return id_bike;
	}
	
	public void setId_bike(int id_bike) {
		this.id_bike = id_bike;
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
	
	public void setAvaliacao_bike(float avaliacao_bike) {
		this.avaliacao_bike = avaliacao_bike;
	}
	
	public Usuario getUsuario() {
		return usuario;
	}
	
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
	
}
