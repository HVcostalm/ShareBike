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

    
    /*
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
    
    */
    
    
    // Montar objeto Reserva a partir do ResultSet
    private Reserva montarReserva(ResultSet rset) throws Exception {
    	Reserva reserva = new Reserva();

    	reserva.setId_reserv(rset.getInt("id_reserv"));
    	reserva.setDataCheckIn_reserv(rset.getTimestamp("dataCheckIn_reserv").toLocalDateTime());
    	reserva.setDataCheckOut_reserv(rset.getTimestamp("dataCheckOut_reserv").toLocalDateTime());
    	reserva.setStatus_reserv(rset.getString("status_reserv"));
    	reserva.setInformada_reserv(rset.getBoolean("informada_reserv"));

    	Usuario usuario = new Usuario();
    	usuario.setCpfCnpj_user(rset.getString("Usuario"));
    	reserva.setUsuario(usuario);

    	Bicicleta bicicleta = new Bicicleta();
    	bicicleta.setId_bike(rset.getInt("Bicicleta"));
    	reserva.setBicicleta(bicicleta);

    	return reserva;
    }
}
