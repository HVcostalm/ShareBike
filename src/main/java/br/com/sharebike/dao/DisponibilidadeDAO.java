package br.com.sharebike.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import br.com.sharebike.model.Bicicleta;
import br.com.sharebike.model.Disponibilidade;
import br.com.sharebike.utils.Conexao;

public class DisponibilidadeDAO extends BaseDAO{
	
	// Pensar em função para deixar indisponivel uma data após chegar no dia
	
	// Cadastrar nova disponibilidade
    public int cadastrarDisponibilidade(Disponibilidade disponibilidade) {
        String insert = "INSERT INTO Disponibilidade(dataHoraIn_disp, dataHoraFim_disp, disponivel_disp, Bicicleta) VALUES (?, ?, ?, ?)";
        int linha = 0;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(insert);

            sql.setTimestamp(1, Timestamp.valueOf(disponibilidade.getDataHoraIn_disp()));
            sql.setTimestamp(2, Timestamp.valueOf(disponibilidade.getDataHoraFim_disp()));
            sql.setBoolean(3, disponibilidade.isDisponivel_disp());
            sql.setInt(4, disponibilidade.getBicicleta().getId_bike());

            linha = sql.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return linha;
    }

    // Editar disponibilidade
    public int editarDisponibilidade(Disponibilidade disponibilidade) {
        String update = "UPDATE Disponibilidade SET dataHoraIn_disp = ?, dataHoraFim_disp = ?, disponivel_disp = ?, Bicicleta = ? WHERE id_disp = ?";
        int linha = 0;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(update);

            sql.setTimestamp(1, Timestamp.valueOf(disponibilidade.getDataHoraIn_disp()));
            sql.setTimestamp(2, Timestamp.valueOf(disponibilidade.getDataHoraFim_disp()));
            sql.setBoolean(3, disponibilidade.isDisponivel_disp());
            sql.setInt(4, disponibilidade.getBicicleta().getId_bike());
            sql.setInt(5, disponibilidade.getId_disp());

            linha = sql.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return linha;
    }
	

    // Buscar disponibilidade por ID
    public Disponibilidade buscarPorId(int id) {
        String select = "SELECT * FROM Disponibilidade WHERE id_disp = ?";
        Disponibilidade disp = null;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(select);
            sql.setInt(1, id);
            rset = sql.executeQuery();

            if (rset.next()) {
                disp = new Disponibilidade();

                disp.setId_disp(rset.getInt("id_disp"));
                disp.setDataHoraIn_disp(rset.getTimestamp("dataHoraIn_disp").toLocalDateTime());
                disp.setDataHoraFim_disp(rset.getTimestamp("dataHoraFim_disp").toLocalDateTime());
                disp.setDisponivel_disp(rset.getBoolean("disponivel_disp"));

                Bicicleta bicicleta = new Bicicleta();
                bicicleta.setId_bike(rset.getInt("Bicicleta"));
                disp.setBicicleta(bicicleta);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return disp;
    }
    
    // Listar disponibilidades por bicicleta
    public List<Disponibilidade> listarDisponibilidade() {
    	String select = "SELECT * FROM Disponibilidade";
    	List<Disponibilidade> lista = new ArrayList<>();

    	try {
    		conexao = Conexao.getConnection();
    		sql = conexao.prepareStatement(select);
    		rset = sql.executeQuery();

    		while (rset.next()) {
    			Disponibilidade disp = new Disponibilidade();

    			disp.setId_disp(rset.getInt("id_disp"));
    			disp.setDataHoraIn_disp(rset.getTimestamp("dataHoraIn_disp").toLocalDateTime());
    			disp.setDataHoraFim_disp(rset.getTimestamp("dataHoraFim_disp").toLocalDateTime());
    			disp.setDisponivel_disp(rset.getBoolean("disponivel_disp"));
    			
    			
    			BicicletaDAO bicicletaDAO = new BicicletaDAO();
    			Bicicleta bicicleta = new Bicicleta();
    			
    			bicicleta = bicicletaDAO.buscarPorId(rset.getInt("Bicicleta"));
    			disp.setBicicleta(bicicleta);

    			lista.add(disp);
    		}

    	} catch (Exception e) {
    		e.printStackTrace();
    	} finally {
    		fecharConexao();
    	}

    	return lista;
    }
    
    // Listar disponibilidades por bicicleta
    public List<Disponibilidade> listarPorBicicleta(int id_bike) {
    	String select = "SELECT * FROM Disponibilidade WHERE Bicicleta = ?";
    	List<Disponibilidade> lista = new ArrayList<>();

    	try {
    		conexao = Conexao.getConnection();
    		sql = conexao.prepareStatement(select);
    		sql.setInt(1, id_bike);
    		rset = sql.executeQuery();

    		while (rset.next()) {
    			Disponibilidade disp = new Disponibilidade();

    			disp.setId_disp(rset.getInt("id_disp"));
    			disp.setDataHoraIn_disp(rset.getTimestamp("dataHoraIn_disp").toLocalDateTime());
    			disp.setDataHoraFim_disp(rset.getTimestamp("dataHoraFim_disp").toLocalDateTime());
    			disp.setDisponivel_disp(rset.getBoolean("disponivel_disp"));

    			Bicicleta bicicleta = new Bicicleta();
    			bicicleta.setId_bike(id_bike);
    			disp.setBicicleta(bicicleta);

    			lista.add(disp);
    		}

    	} catch (Exception e) {
    		e.printStackTrace();
    	} finally {
    		fecharConexao();
    	}

    	return lista;
    }
	
    
    // Ver como tratar essa função no projeto
    
    public int tornarIndisponivel() { // Por enquanto deixar com o NOW(), se não funcionar vejo depois
    	String update = "UPDATE Disponibilidade SET disponivel_disp = false WHERE DATE_SUB(dataHoraIn_disp, INTERVAL 1 DAY) < NOW()";
    	int linhasAfetadas = 0;

	    try {
	        conexao = Conexao.getConnection();
	        sql = conexao.prepareStatement(update);
	        linhasAfetadas = sql.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        fecharConexao();
	    }

	    return linhasAfetadas;
    }
    
    public int tornarIndisponivelSeReservaPendente(int idBicicleta) {
        String update = "UPDATE Disponibilidade " +
                        "SET disponivel_disp = false " +
                        "WHERE Bicicleta = ? " +
                        "AND EXISTS ( " +
                        "    SELECT 1 FROM Reserva " +
                        "    WHERE Reserva.Bicicleta = Disponibilidade.Bicicleta " +
                        "    AND Reserva.status_reserv = 'PENDENTE' " +
                        ")";
        int linhasAfetadas = 0;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(update);
            sql.setInt(1, idBicicleta);
            linhasAfetadas = sql.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return linhasAfetadas;
    }
    
    
    public int tornarDisponivelSeReservaNegada(int idBicicleta) {
        String update = "UPDATE Disponibilidade " +
                        "SET disponivel_disp = true " +
                        "WHERE Bicicleta = ? " +
                        "AND EXISTS ( " +
                        "    SELECT 1 FROM Reserva " +
                        "    WHERE Reserva.Bicicleta = Disponibilidade.Bicicleta " +
                        "    AND Reserva.status_reserv = 'NEGADA' " +
                        ")";
        int linhasAfetadas = 0;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(update);
            sql.setInt(1, idBicicleta);
            linhasAfetadas = sql.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return linhasAfetadas;
    }

}
