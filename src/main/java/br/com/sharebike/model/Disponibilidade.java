package br.com.sharebike.model;

import java.time.LocalDateTime;

public class Disponibilidade {
	private int id_disp;
	private LocalDateTime dataHoraIn_disp;
	private LocalDateTime dataHoraFim_disp;
	private boolean disponivel_disp;
	private Bicicleta bicicleta;
	
	
	public Disponibilidade() {
		super();
	}

	public Disponibilidade(int id_disp, LocalDateTime dataHoraIn_disp, LocalDateTime dataHoraFim_disp,
			boolean disponivel_disp, Bicicleta bicicleta) {
		super();
		this.id_disp = id_disp;
		this.dataHoraIn_disp = dataHoraIn_disp;
		this.dataHoraFim_disp = dataHoraFim_disp;
		this.disponivel_disp = disponivel_disp;
		this.bicicleta = bicicleta;
	}
	
	public Disponibilidade(LocalDateTime dataHoraIn_disp, LocalDateTime dataHoraFim_disp, boolean disponivel_disp,
			Bicicleta bicicleta) {
		super();
		this.dataHoraIn_disp = dataHoraIn_disp;
		this.dataHoraFim_disp = dataHoraFim_disp;
		this.disponivel_disp = disponivel_disp;
		this.bicicleta = bicicleta;
	}

	public int getId_disp() {
		return id_disp;
	}
	
	public void setId_disp(int id_disp) {
		this.id_disp = id_disp;
	}
	
	public LocalDateTime getDataHoraIn_disp() {
		return dataHoraIn_disp;
	}
	
	public void setDataHoraIn_disp(LocalDateTime dataHoraIn_disp) {
		this.dataHoraIn_disp = dataHoraIn_disp;
	}
	
	public LocalDateTime getDataHoraFim_disp() {
		return dataHoraFim_disp;
	}
	
	public void setDataHoraFim_disp(LocalDateTime dataHoraFim_disp) {
		this.dataHoraFim_disp = dataHoraFim_disp;
	}
	
	public boolean isDisponivel_disp() {
		return disponivel_disp;
	}
	
	public void setDisponivel_disp(boolean disponivel_disp) {
		this.disponivel_disp = disponivel_disp;
	}
	
	public Bicicleta getBicicleta() {
		return bicicleta;
	}
	
	public void setBicicleta(Bicicleta bicicleta) {
		this.bicicleta = bicicleta;
	}
	
}
