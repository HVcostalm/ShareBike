package br.com.sharebike.dao;

import java.sql.Timestamp;
import java.time.LocalDateTime;
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
    
    /**
     * Torna indisponíveis apenas as disponibilidades que se sobrepõem ao período da reserva PENDENTE
     */
    public int tornarIndisponivelSeReservaPendente(int idBicicleta, LocalDateTime checkIn, LocalDateTime checkOut) {
        String update = "UPDATE Disponibilidade " +
                        "SET disponivel_disp = false " +
                        "WHERE Bicicleta = ? " +
                        "AND ( " +
                        "    (dataHoraIn_disp < ? AND dataHoraFim_disp > ?) " +     // Disponibilidade envolve check-in
                        "    OR (dataHoraIn_disp < ? AND dataHoraFim_disp > ?) " +  // Disponibilidade envolve check-out  
                        "    OR (dataHoraIn_disp >= ? AND dataHoraFim_disp <= ?) " + // Disponibilidade está dentro da reserva
                        "    OR (dataHoraIn_disp <= ? AND dataHoraFim_disp >= ?) " + // Disponibilidade envolve toda a reserva
                        ")";
        int linhasAfetadas = 0;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(update);
            sql.setInt(1, idBicicleta);
            sql.setTimestamp(2, java.sql.Timestamp.valueOf(checkOut));     // dataHoraIn_disp < checkOut
            sql.setTimestamp(3, java.sql.Timestamp.valueOf(checkIn));      // dataHoraFim_disp > checkIn
            sql.setTimestamp(4, java.sql.Timestamp.valueOf(checkOut));     // dataHoraIn_disp < checkOut
            sql.setTimestamp(5, java.sql.Timestamp.valueOf(checkIn));      // dataHoraFim_disp > checkIn
            sql.setTimestamp(6, java.sql.Timestamp.valueOf(checkIn));      // dataHoraIn_disp >= checkIn
            sql.setTimestamp(7, java.sql.Timestamp.valueOf(checkOut));     // dataHoraFim_disp <= checkOut
            sql.setTimestamp(8, java.sql.Timestamp.valueOf(checkIn));      // dataHoraIn_disp <= checkIn
            sql.setTimestamp(9, java.sql.Timestamp.valueOf(checkOut));     // dataHoraFim_disp >= checkOut
            
            linhasAfetadas = sql.executeUpdate();
            
            System.out.println("💡 Disponibilidades tornadas indisponíveis para reserva PENDENTE na bicicleta " + idBicicleta + 
                              ": " + linhasAfetadas + " períodos afetados");
            
        } catch (Exception e) {
            System.err.println("❌ Erro ao tornar disponibilidades indisponíveis: " + e.getMessage());
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return linhasAfetadas;
    }
    
    
    /**
     * Torna disponíveis novamente as disponibilidades que foram bloqueadas para uma reserva NEGADA
     */
    public int tornarDisponivelSeReservaNegada(int idBicicleta, LocalDateTime checkIn, LocalDateTime checkOut) {
        String update = "UPDATE Disponibilidade " +
                        "SET disponivel_disp = true " +
                        "WHERE Bicicleta = ? " +
                        "AND ( " +
                        "    (dataHoraIn_disp < ? AND dataHoraFim_disp > ?) " +     // Disponibilidade envolve check-in
                        "    OR (dataHoraIn_disp < ? AND dataHoraFim_disp > ?) " +  // Disponibilidade envolve check-out  
                        "    OR (dataHoraIn_disp >= ? AND dataHoraFim_disp <= ?) " + // Disponibilidade está dentro da reserva
                        "    OR (dataHoraIn_disp <= ? AND dataHoraFim_disp >= ?) " + // Disponibilidade envolve toda a reserva
                        ")";
        int linhasAfetadas = 0;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(update);
            sql.setInt(1, idBicicleta);
            sql.setTimestamp(2, java.sql.Timestamp.valueOf(checkOut));     // dataHoraIn_disp < checkOut
            sql.setTimestamp(3, java.sql.Timestamp.valueOf(checkIn));      // dataHoraFim_disp > checkIn
            sql.setTimestamp(4, java.sql.Timestamp.valueOf(checkOut));     // dataHoraIn_disp < checkOut
            sql.setTimestamp(5, java.sql.Timestamp.valueOf(checkIn));      // dataHoraFim_disp > checkIn
            sql.setTimestamp(6, java.sql.Timestamp.valueOf(checkIn));      // dataHoraIn_disp >= checkIn
            sql.setTimestamp(7, java.sql.Timestamp.valueOf(checkOut));     // dataHoraFim_disp <= checkOut
            sql.setTimestamp(8, java.sql.Timestamp.valueOf(checkIn));      // dataHoraIn_disp <= checkIn
            sql.setTimestamp(9, java.sql.Timestamp.valueOf(checkOut));     // dataHoraFim_disp >= checkOut
            
            linhasAfetadas = sql.executeUpdate();
            
            System.out.println("💡 Disponibilidades liberadas para reserva NEGADA na bicicleta " + idBicicleta + 
                              ": " + linhasAfetadas + " períodos liberados");
            
        } catch (Exception e) {
            System.err.println("❌ Erro ao liberar disponibilidades: " + e.getMessage());
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return linhasAfetadas;
    }
    
    // Verificar se existe conflito de horários para uma nova disponibilidade
    public boolean verificarConflitoHorarios(int id_bike, LocalDateTime novaDataInicio, LocalDateTime novaDataFim) {
        return verificarConflitoHorarios(id_bike, novaDataInicio, novaDataFim, -1); // -1 indica que é uma nova disponibilidade
    }
    
    // Verificar se existe conflito de horários (incluindo exclusão de ID para edição)
    public boolean verificarConflitoHorarios(int id_bike, LocalDateTime novaDataInicio, LocalDateTime novaDataFim, int excluirIdDisp) {
        String select = "SELECT id_disp, dataHoraIn_disp, dataHoraFim_disp FROM Disponibilidade WHERE Bicicleta = ?";
        
        // Se estamos editando, excluir a disponibilidade atual da verificação
        if (excluirIdDisp != -1) {
            select += " AND id_disp != ?";
        }
        
        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(select);
            sql.setInt(1, id_bike);
            
            if (excluirIdDisp != -1) {
                sql.setInt(2, excluirIdDisp);
            }
            
            rset = sql.executeQuery();
            
            while (rset.next()) {
                LocalDateTime existenteInicio = rset.getTimestamp("dataHoraIn_disp").toLocalDateTime();
                LocalDateTime existenteFim = rset.getTimestamp("dataHoraFim_disp").toLocalDateTime();
                
                // Verificar se há sobreposição: 
                // Há conflito se: nova.início < existente.fim AND nova.fim > existente.início
                if (novaDataInicio.isBefore(existenteFim) && novaDataFim.isAfter(existenteInicio)) {
                    return true; // Há conflito
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }
        
        return false; // Sem conflito
    }

}
