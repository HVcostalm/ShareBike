package br.com.sharebike.dao;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import br.com.sharebike.model.Bicicleta;
import br.com.sharebike.model.Reserva;
import br.com.sharebike.model.Usuario;
import br.com.sharebike.utils.Conexao;

public class ReservaDAO extends BaseDAO{
	
	// Cadastrar nova reserva
    public int cadastrarReserva(Reserva reserva) {
        String insert = "INSERT INTO Reserva(dataCheckIn_reserv, dataCheckOut_reserv, status_reserv, informada_reserv, Usuario, Bicicleta) VALUES (?, ?, ?, ?, ?, ?)";
        int linha = 0;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(insert);

            sql.setTimestamp(1, Timestamp.valueOf(reserva.getDataCheckIn_reserv()));
            sql.setTimestamp(2, Timestamp.valueOf(reserva.getDataCheckOut_reserv()));
            sql.setString(3, reserva.getStatus_reserv());
            sql.setBoolean(4, reserva.isInformada_reserv());
            sql.setString(5, reserva.getUsuario() != null ? reserva.getUsuario().getCpfCnpj_user() : null);
            sql.setInt(6, reserva.getBicicleta().getId_bike());

            linha = sql.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return linha;
    }

    // Atualizar status, datas ou se foi informada
    public int atualizarReserva(Reserva reserva) {
        String update = "UPDATE Reserva SET dataCheckIn_reserv = ?, dataCheckOut_reserv = ?, status_reserv = ?, informada_reserv = ?, Usuario = ?, Bicicleta = ? WHERE id_reserv = ?";
        int linha = 0;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(update);

            sql.setTimestamp(1, Timestamp.valueOf(reserva.getDataCheckIn_reserv()));
            sql.setTimestamp(2, Timestamp.valueOf(reserva.getDataCheckOut_reserv()));
            sql.setString(3, reserva.getStatus_reserv());
            sql.setBoolean(4, reserva.isInformada_reserv());
            sql.setString(5, reserva.getUsuario() != null ? reserva.getUsuario().getCpfCnpj_user() : null);
            sql.setInt(6, reserva.getBicicleta().getId_bike());
            sql.setInt(7, reserva.getId_reserv());

            linha = sql.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return linha;
    }
    
    // Buscar reserva por ID
    public Reserva buscarPorId(int id) {
        String select = "SELECT * FROM Reserva WHERE id_reserv = ?";
        Reserva reserva = null;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(select);
            sql.setInt(1, id);
            rset = sql.executeQuery();

            if (rset.next()) {
                reserva = montarReserva(rset);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return reserva;
    }
    
    public int atualizarStatusReserva(int idReserva, String novoStatus) {
        String update = "UPDATE Reserva SET status_reserv = ? WHERE id_reserv = ?";
        int linhasAfetadas = 0;

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(update);
            sql.setString(1, novoStatus);
            sql.setInt(2, idReserva);
            linhasAfetadas = sql.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return linhasAfetadas;
    }

    
    // Função que mostra todas as reservas ou por status
    public List<Reserva> listarReservasPorStatus(String status) {
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT * FROM Reserva");

        if (status != null && !status.isEmpty()) {
            sqlBuilder.append(" WHERE status_reserv = ?");
        }

        List<Reserva> reservas = new ArrayList<>();

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(sqlBuilder.toString());

            if (status != null && !status.isEmpty()) {
                sql.setString(1, status);
            }

            rset = sql.executeQuery();

            while (rset.next()) {
                reservas.add(montarReserva(rset));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return reservas;
    }

    
    // Listar reservas por CPF do usuário
    public List<Reserva> listarPorUsuario(String cpfUsuario) {
        String select = "SELECT * FROM Reserva WHERE Usuario = ?";
        List<Reserva> reservas = new ArrayList<>();

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(select);
            sql.setString(1, cpfUsuario);
            rset = sql.executeQuery();

            while (rset.next()) {
                reservas.add(montarReserva(rset));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return reservas;
    }
    
    public List<Reserva> listarPorLocador(String cpfCnpjLocador) {
        String select = """
            SELECT r.* FROM Reserva r
            INNER JOIN Bicicleta b ON r.Bicicleta = b.id_bike
            WHERE b.usuario = ?
        """;
        
        List<Reserva> reservas = new ArrayList<>();

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(select);
            sql.setString(1, cpfCnpjLocador);
            rset = sql.executeQuery();

            while (rset.next()) {
                reservas.add(montarReserva(rset));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return reservas;
    }
    
	// Função que mostra todas as reservas concluídas que não foram informadas para quantificar ranking pessoal 
    public List<Reserva> listarReservasFinalizadasNaoInformadasPorUsuario(String cpfCnpj_usuario) {
        String select = """
            SELECT * FROM Reserva 
            WHERE status_reserv = 'finalizada' 
            AND informada_reserv = false 
            AND usuario = ?
        """;

        List<Reserva> reservas = new ArrayList<>();

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(select);
            sql.setString(1, cpfCnpj_usuario);
            rset = sql.executeQuery();

            while (rset.next()) {
                reservas.add(montarReserva(rset));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return reservas;
    }

    
    // Listar reservas por bicicleta
    public List<Reserva> listarPorBicicleta(int id_bike) {
        String select = "SELECT * FROM Reserva WHERE Bicicleta = ?";
        List<Reserva> reservas = new ArrayList<>();

        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(select);
            sql.setInt(1, id_bike);
            rset = sql.executeQuery();

            while (rset.next()) {
                reservas.add(montarReserva(rset));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharConexao();
        }

        return reservas;
    }
    
    
    // Método para verificar se o usuário tem reservas finalizadas (para permissão de acesso ao ranking)
    public boolean usuarioTemReservasFinalizada(String cpfCnpj_usuario) {
        String select = """
            SELECT COUNT(*) as total FROM Reserva 
            WHERE status_reserv = 'FINALIZADA' 
            AND usuario = ?
        """;
        
        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(select);
            sql.setString(1, cpfCnpj_usuario);
            rset = sql.executeQuery();
            
            if (rset.next()) {
                return rset.getInt("total") > 0;
            }
        } catch (Exception e) {
            System.out.println("Erro ao verificar reservas finalizadas: " + e.getMessage());
        } finally {
            fecharConexao();
        }
        
        return false;
    }
    
    // Método para atualizar o status informada_reserv de uma reserva
    public boolean atualizarInformadaReserva(int idReserva) {
        String update = "UPDATE Reserva SET informada_reserv = true WHERE id_reserv = ?";
        
        try {
            conexao = Conexao.getConnection();
            sql = conexao.prepareStatement(update);
            sql.setInt(1, idReserva);
            
            int linhasAfetadas = sql.executeUpdate();
            return linhasAfetadas > 0;
            
        } catch (Exception e) {
            System.out.println("Erro ao atualizar informada_reserv: " + e.getMessage());
            return false;
        } finally {
            fecharConexao();
        }
    }
    
	// Contar reservas finalizadas para estatísticas
	public int contarReservasFinalizadas() {
		String query = "SELECT COUNT(*) FROM Reserva WHERE status_reserv = 'FINALIZADA'";
		int count = 0;

		try {
			conexao = Conexao.getConnection();
			sql = conexao.prepareStatement(query);
			ResultSet resultado = sql.executeQuery();

			if (resultado.next()) {
				count = resultado.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			fecharConexao();
		}

		return count;
	}
    
    // Montar objeto Reserva a partir do ResultSet
    private Reserva montarReserva(ResultSet rset) throws Exception {
    	Reserva reserva = new Reserva();

    	reserva.setId_reserv(rset.getInt("id_reserv"));
    	reserva.setDataCheckIn_reserv(rset.getTimestamp("dataCheckIn_reserv").toLocalDateTime());
    	reserva.setDataCheckOut_reserv(rset.getTimestamp("dataCheckOut_reserv").toLocalDateTime());
    	reserva.setStatus_reserv(rset.getString("status_reserv"));
    	reserva.setInformada_reserv(rset.getBoolean("informada_reserv"));

    	// Buscar dados completos do usuário
    	UsuarioDAO usuarioDAO = new UsuarioDAO();
    	String cpfUsuario = rset.getString("Usuario");
    	if (cpfUsuario != null) {
    		Usuario usuario = usuarioDAO.exibirUsuario(cpfUsuario);
    		reserva.setUsuario(usuario);
    	}

    	// Buscar dados completos da bicicleta
    	BicicletaDAO bicicletaDAO = new BicicletaDAO();
    	int idBicicleta = rset.getInt("Bicicleta");
    	if (idBicicleta > 0) {
    		Bicicleta bicicleta = bicicletaDAO.buscarBicicletaComUsuario(idBicicleta);
    		reserva.setBicicleta(bicicleta);
    	}

    	return reserva;
    }
    
    
}