package br.com.sharebike.model;

import java.time.LocalDateTime;

public class Reserva {
	private int id_reserv;
	private LocalDateTime dataCheckIn_reserv;
	private LocalDateTime dataCheckOut_reserv;
	private String status_reserv;
	private boolean informada_reserv;
	private Usuario usuario;
	private Bicicleta bicicleta;
	
	public Reserva() {
		super();
	}

	public Reserva(int id_reserv, LocalDateTime dataCheckIn_reserv, LocalDateTime dataCheckOut_reserv,
			String status_reserv, boolean informada_reserv, Usuario usuario, Bicicleta bicicleta) {
		super();
		this.id_reserv = id_reserv;
		this.dataCheckIn_reserv = dataCheckIn_reserv;
		this.dataCheckOut_reserv = dataCheckOut_reserv;
		this.status_reserv = status_reserv;
		this.informada_reserv = informada_reserv;
		this.usuario = usuario;
		this.bicicleta = bicicleta;
	}
	
	public Reserva(LocalDateTime dataCheckIn_reserv, LocalDateTime dataCheckOut_reserv, Usuario usuario, Bicicleta bicicleta) {
		super();
		this.dataCheckIn_reserv = dataCheckIn_reserv;
		this.dataCheckOut_reserv = dataCheckOut_reserv;
		this.status_reserv = "PENDENTE";
		this.informada_reserv = false;
		this.usuario = usuario;
		this.bicicleta = bicicleta;
	}
	
	public String exibirDados() {
	    return "id: " + id_reserv + 
	    	   ", Check Inicio: " + dataCheckIn_reserv +
	    	   ", Check Fim: " + dataCheckOut_reserv +
	           ", Status: " + status_reserv +
	           ", Informada: " + informada_reserv +
	           ", Locatário: " + usuario.getNomeRazaoSocial_user() +
	           ", Locador: " + bicicleta.getUsuario().getNomeRazaoSocial_user() +
	           ", Bicicleta: " + bicicleta.getNome_bike();	
	}
	
	public int getId_reserv() {
		return id_reserv;
	}
	
	public void setId_reserv(int id_reserv) {
		this.id_reserv = id_reserv;
	}
	
	public LocalDateTime getDataCheckIn_reserv() {
		return dataCheckIn_reserv;
	}
	
	public void setDataCheckIn_reserv(LocalDateTime dataCheckIn_reserv) {
		this.dataCheckIn_reserv = dataCheckIn_reserv;
	}
	
	public LocalDateTime getDataCheckOut_reserv() {
		return dataCheckOut_reserv;
	}
	
	public void setDataCheckOut_reserv(LocalDateTime dataCheckOut_reserv) {
		this.dataCheckOut_reserv = dataCheckOut_reserv;
	}
	
	public String getStatus_reserv() {
		return status_reserv;
	}
	
	public void setStatus_reserv(String status_reserv) {
		this.status_reserv = status_reserv;
	}
	
	public boolean isInformada_reserv() {
		return informada_reserv;
	}
	
	public void setInformada_reserv(boolean informada_reserv) {
		this.informada_reserv = informada_reserv;
	}
	
	public Usuario getUsuario() {
		return usuario;
	}
	
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
	public Bicicleta getBicicleta() {
		return bicicleta;
	}
	
	public void setBicicleta(Bicicleta bicicleta) {
		this.bicicleta = bicicleta;
	}
	
}
