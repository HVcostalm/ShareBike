package br.com.sharebike.model;

public class Ranking {
	private int id_rank;
	private String cidade_rank;
	private String estado_rank;
	private String pais_rank;
	private float pontos_rank;
	private float pontosSemana_rank;
	private Usuario usuario;
	
	
	public Ranking() {
		super();
	}

	public Ranking(int id_rank, String cidade_rank, String estado_rank, String pais_rank, float pontos_rank,
			float pontosSemana_rank, Usuario usuario) {
		super();
		this.id_rank = id_rank;
		this.cidade_rank = cidade_rank;
		this.estado_rank = estado_rank;
		this.pais_rank = pais_rank;
		this.pontos_rank = pontos_rank;
		this.pontosSemana_rank = pontosSemana_rank;
		this.usuario = usuario;
	}
	
	public Ranking(String cidade_rank, String estado_rank, String pais_rank, float pontos_rank, float pontosSemana_rank,
			Usuario usuario) {
		super();
		this.cidade_rank = cidade_rank;
		this.estado_rank = estado_rank;
		this.pais_rank = pais_rank;
		this.pontos_rank = pontos_rank;
		this.pontosSemana_rank = pontosSemana_rank;
		this.usuario = usuario;
	}

	public int getId_rank() {
		return id_rank;
	}
	
	public void setId_rank(int id_rank) {
		this.id_rank = id_rank;
	}
	
	public String getCidade_rank() {
		return cidade_rank;
	}
	
	public void setCidade_rank(String cidade_rank) {
		this.cidade_rank = cidade_rank;
	}
	
	public String getEstado_rank() {
		return estado_rank;
	}
	
	public void setEstado_rank(String estado_rank) {
		this.estado_rank = estado_rank;
	}
	
	public String getPais_rank() {
		return pais_rank;
	}
	
	public void setPais_rank(String pais_rank) {
		this.pais_rank = pais_rank;
	}
	
	public float getPontos_rank() {
		return pontos_rank;
	}
	
	public void setPontos_rank(float pontos_rank) {
		this.pontos_rank = pontos_rank;
	}
	
	public float getPontosSemana_rank() {
		return pontosSemana_rank;
	}
	
	public void setPontosSemana_rank(float pontosSemana_rank) {
		this.pontosSemana_rank = pontosSemana_rank;
	}
	
	public Usuario getUsuario() {
		return usuario;
	}
	
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	
	
}
