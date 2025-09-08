package br.com.sharebike.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Classe utilitária para validações relacionadas à bicicleta
 */
public class ValidadorBicicleta {
    
    /**
     * Verifica se um chassi já está cadastrado no sistema
     * @param chassi O chassi a ser verificado
     * @return true se o chassi já existe, false caso contrário
     * @throws SQLException em caso de erro na consulta ao banco
     */
    public static boolean chassiJaExiste(String chassi) throws SQLException {
        if (chassi == null || chassi.trim().isEmpty()) {
            return false;
        }
        
        Connection conexao = null;
        PreparedStatement sql = null;
        ResultSet resultado = null;
        
        try {
            // Obter conexão com o banco
            conexao = Conexao.getConnection();
            
            // Normalizar chassi para maiúsculo e sem espaços
            String chassiNormalizado = chassi.trim().toUpperCase();
            
            // Query para verificar se o chassi existe
            String query = "SELECT COUNT(*) as total FROM Bicicleta WHERE UPPER(TRIM(chassi_bike)) = ?";
            sql = conexao.prepareStatement(query);
            sql.setString(1, chassiNormalizado);
            
            resultado = sql.executeQuery();
            
            if (resultado.next()) {
                int total = resultado.getInt("total");
                return total > 0; // Se total > 0, chassi já existe
            }
            
            return false;
            
        } catch (SQLException e) {
            System.err.println("Erro ao verificar chassi duplicado: " + e.getMessage());
            throw e;
        } finally {
            // Fechar recursos
            if (resultado != null) {
                try {
                    resultado.close();
                } catch (SQLException e) {
                    System.err.println("Erro ao fechar ResultSet: " + e.getMessage());
                }
            }
            if (sql != null) {
                try {
                    sql.close();
                } catch (SQLException e) {
                    System.err.println("Erro ao fechar PreparedStatement: " + e.getMessage());
                }
            }
            if (conexao != null) {
                try {
                    conexao.close();
                } catch (SQLException e) {
                    System.err.println("Erro ao fechar Connection: " + e.getMessage());
                }
            }
        }
    }
    
    /**
     * Verifica se uma bicicleta com o mesmo nome já existe para o mesmo proprietário
     * @param nome O nome da bicicleta
     * @param cpfCnpjProprietario CPF/CNPJ do proprietário
     * @return true se já existe uma bicicleta com esse nome para esse proprietário
     * @throws SQLException em caso de erro na consulta ao banco
     */
    public static boolean nomeJaExisteParaProprietario(String nome, String cpfCnpjProprietario) throws SQLException {
        if (nome == null || nome.trim().isEmpty() || 
            cpfCnpjProprietario == null || cpfCnpjProprietario.trim().isEmpty()) {
            return false;
        }
        
        Connection conexao = null;
        PreparedStatement sql = null;
        ResultSet resultado = null;
        
        try {
            // Obter conexão com o banco
            conexao = Conexao.getConnection();
            
            // Query para verificar se já existe bicicleta com mesmo nome para o proprietário
            String query = "SELECT COUNT(*) as total FROM Bicicleta WHERE UPPER(TRIM(nome_bike)) = ? AND Usuario = ?";
            sql = conexao.prepareStatement(query);
            sql.setString(1, nome.trim().toUpperCase());
            sql.setString(2, cpfCnpjProprietario.trim());
            
            resultado = sql.executeQuery();
            
            if (resultado.next()) {
                int total = resultado.getInt("total");
                return total > 0;
            }
            
            return false;
            
        } catch (SQLException e) {
            System.err.println("Erro ao verificar nome duplicado para proprietário: " + e.getMessage());
            throw e;
        } finally {
            // Fechar recursos
            if (resultado != null) {
                try {
                    resultado.close();
                } catch (SQLException e) {
                    System.err.println("Erro ao fechar ResultSet: " + e.getMessage());
                }
            }
            if (sql != null) {
                try {
                    sql.close();
                } catch (SQLException e) {
                    System.err.println("Erro ao fechar PreparedStatement: " + e.getMessage());
                }
            }
            if (conexao != null) {
                try {
                    conexao.close();
                } catch (SQLException e) {
                    System.err.println("Erro ao fechar Connection: " + e.getMessage());
                }
            }
        }
    }
    
    /**
     * Valida se o chassi é único no sistema
     * @param chassi O chassi a ser validado
     * @return String com mensagem de erro ou null se estiver válido
     */
    public static String validarChassiUnico(String chassi) {
        if (chassi == null || chassi.trim().isEmpty()) {
            return "O chassi da bicicleta é obrigatório.";
        }
        
        // Validar formato do chassi
        String chassiLimpo = chassi.trim();
        if (chassiLimpo.length() < 3) {
            return "O chassi deve ter pelo menos 3 caracteres.";
        }
        
        if (chassiLimpo.length() > 10) {
            return "O chassi não pode ter mais de 10 caracteres.";
        }
        
        // Verificar se contém apenas caracteres alfanuméricos
        if (!chassiLimpo.matches("^[A-Za-z0-9]+$")) {
            return "O chassi deve conter apenas letras e números, sem espaços ou caracteres especiais.";
        }
        
        try {
            // Verificar se chassi já existe
            if (chassiJaExiste(chassi)) {
                return "Este chassi já está cadastrado no sistema. Cada bicicleta deve ter um chassi único.";
            }
            
            return null; // Chassi válido
            
        } catch (SQLException e) {
            System.err.println("Erro ao validar chassi único: " + e.getMessage());
            return "Erro interno do sistema. Tente novamente mais tarde.";
        }
    }
    
    /**
     * Valida todos os dados únicos da bicicleta
     * @param chassi O chassi da bicicleta
     * @param nome O nome da bicicleta
     * @param cpfCnpjProprietario CPF/CNPJ do proprietário
     * @return String com mensagem de erro ou null se estiver válido
     */
    public static String validarDadosUnicosBicicleta(String chassi, String nome, String cpfCnpjProprietario) {
        // Validar chassi único
        String erroChassi = validarChassiUnico(chassi);
        if (erroChassi != null) {
            return erroChassi;
        }
        
        try {
            // Verificar nome duplicado para o mesmo proprietário (opcional, mas útil)
            if (nomeJaExisteParaProprietario(nome, cpfCnpjProprietario)) {
                return "Você já possui uma bicicleta com este nome. Escolha um nome diferente.";
            }
            
            return null; // Todos os dados estão válidos
            
        } catch (SQLException e) {
            System.err.println("Erro ao validar dados únicos da bicicleta: " + e.getMessage());
            return "Erro interno do sistema. Tente novamente mais tarde.";
        }
    }
    
    /**
     * Normaliza o chassi para comparação (maiúsculo, sem espaços)
     * @param chassi O chassi a ser normalizado
     * @return O chassi normalizado
     */
    public static String normalizarChassi(String chassi) {
        if (chassi == null) {
            return null;
        }
        return chassi.trim().toUpperCase();
    }
    
    /**
     * Valida o formato básico dos dados da bicicleta
     * @param nome Nome da bicicleta
     * @param tipo Tipo da bicicleta
     * @param chassi Chassi da bicicleta
     * @param estadoConserv Estado de conservação
     * @param localEntr Local de entrega
     * @return String com mensagem de erro ou null se válido
     */
    public static String validarDadosBasicos(String nome, String tipo, String chassi, 
                                           String estadoConserv, String localEntr) {
        // Validar nome
        if (nome == null || nome.trim().isEmpty()) {
            return "O nome da bicicleta é obrigatório.";
        }
        if (nome.trim().length() < 3) {
            return "O nome da bicicleta deve ter pelo menos 3 caracteres.";
        }
        if (nome.trim().length() > 100) {
            return "O nome da bicicleta não pode ter mais de 100 caracteres.";
        }
        
        // Validar tipo
        if (tipo == null || tipo.trim().isEmpty()) {
            return "O tipo da bicicleta é obrigatório.";
        }
        String[] tiposValidos = {"Urbana", "Passeio", "Dobravel", "Mountain", "BMX", "Speed"};
        boolean tipoValido = false;
        for (String tipoValidoItem : tiposValidos) {
            if (tipoValidoItem.equalsIgnoreCase(tipo.trim())) {
                tipoValido = true;
                break;
            }
        }
        if (!tipoValido) {
            return "Tipo de bicicleta inválido. Selecione um tipo válido.";
        }
        
        // Validar estado de conservação
        if (estadoConserv == null || estadoConserv.trim().isEmpty()) {
            return "O estado de conservação é obrigatório.";
        }
        String[] estadosValidos = {"BOM", "OTIMA", "EXCELENTE"};
        boolean estadoValido = false;
        for (String estadoValidoItem : estadosValidos) {
            if (estadoValidoItem.equalsIgnoreCase(estadoConserv.trim())) {
                estadoValido = true;
                break;
            }
        }
        if (!estadoValido) {
            return "Estado de conservação inválido. Selecione um estado válido.";
        }
        
        // Validar local de entrega
        if (localEntr == null || localEntr.trim().isEmpty()) {
            return "O local de entrega é obrigatório.";
        }
        if (localEntr.trim().length() < 10) {
            return "O local de entrega deve ser mais detalhado (pelo menos 10 caracteres).";
        }
        
        return null; // Todos os dados básicos estão válidos
    }
}
