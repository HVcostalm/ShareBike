package br.com.sharebike.model;

import java.time.LocalDateTime;

public class Feedback {
	private int id_feedb;
	private int avaliacaoUser_feedb;
	private int avaliacaoBike_feedb;
	private String obsBike_feedb;
	private String obsUser_feedb;
	private LocalDateTime data_feedb;
	private boolean confComp_feedb;
	private boolean comunicBoa_feedb;
	private boolean funcional_feedb;
	private boolean manutencao_feedb;
	private Reserva reserva;
	private Usuario avaliado_Usuario;
	private Usuario avaliador_Usuario;
	
	public int getId_feedb() {
		return id_feedb;
	}
	
	public void setId_feedb(int id_feedb) {
		this.id_feedb = id_feedb;
	}
	
	public int getAvaliacaoUser_feedb() {
		return avaliacaoUser_feedb;
	}
	
	public void setAvaliacaoUser_feedb(int avaliacaoUser_feedb) {
		this.avaliacaoUser_feedb = avaliacaoUser_feedb;
	}
	
	public int getAvaliacaoBike_feedb() {
		return avaliacaoBike_feedb;
	}
	
	public void setAvaliacaoBike_feedb(int avaliacaoBike_feedb) {
		this.avaliacaoBike_feedb = avaliacaoBike_feedb;
	}
	
	public String getObsBike_feedb() {
		return obsBike_feedb;
	}
	
	public void setObsBike_feedb(String obsBike_feedb) {
		this.obsBike_feedb = obsBike_feedb;
	}
	
	public String getObsUser_feedb() {
		return obsUser_feedb;
	}
	
	public void setObsUser_feedb(String obsUser_feedb) {
		this.obsUser_feedb = obsUser_feedb;
	}
	
	public LocalDateTime getData_feedb() {
		return data_feedb;
	}
	
	public void setData_feedb(LocalDateTime data_feedb) {
		this.data_feedb = data_feedb;
	}
	
	public boolean isConfComp_feedb() {
		return confComp_feedb;
	}
	
	public void setConfComp_feedb(boolean confComp_feedb) {
		this.confComp_feedb = confComp_feedb;
	}
	
	public boolean isComunicBoa_feedb() {
		return comunicBoa_feedb;
	}
	
	public void setComunicBoa_feedb(boolean comunicBoa_feedb) {
		this.comunicBoa_feedb = comunicBoa_feedb;
	}
	
	public boolean isFuncional_feedb() {
		return funcional_feedb;
	}
	
	public void setFuncional_feedb(boolean funcional_feedb) {
		this.funcional_feedb = funcional_feedb;
	}
	
	public boolean isManutencao_feedb() {
		return manutencao_feedb;
	}
	
	public void setManutencao_feedb(boolean manutencao_feedb) {
		this.manutencao_feedb = manutencao_feedb;
	}
	
	public Reserva getReserva() {
		return reserva;
	}
	
	public void setReserva(Reserva reserva) {
		this.reserva = reserva;
	}
	
	public Usuario getAvaliado_Usuario() {
		return avaliado_Usuario;
	}
	
	public void setAvaliado_Usuario(Usuario avaliado_Usuario) {
		this.avaliado_Usuario = avaliado_Usuario;
	}
	
	public Usuario getAvaliador_Usuario() {
		return avaliador_Usuario;
	}
	
	public void setAvaliador_Usuario(Usuario avaliador_Usuario) {
		this.avaliador_Usuario = avaliador_Usuario;
	}
	
}
