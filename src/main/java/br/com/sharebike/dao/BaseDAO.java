package br.com.sharebike.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public abstract class BaseDAO {
	
	protected Connection conexao = null;
    protected PreparedStatement sql = null;
    protected ResultSet rset = null;
    
	// Função para fechar a conexão MySQL
	protected void fecharConexao() {
		try {
			if (rset != null) {
				rset.close();
			}
			if (sql != null) {
				sql.close();
			}

			if (conexao != null) {
				conexao.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
