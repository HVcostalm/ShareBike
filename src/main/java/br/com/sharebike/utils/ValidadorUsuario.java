package br.com.sharebike.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Classe utilitária para validações relacionadas ao usuário
 */
public class ValidadorUsuario {
    
    /**
     * Verifica se um email já está cadastrado no sistema
     * @param email O email a ser verificado
     * @return true se o email já existe, false caso contrário
     * @throws SQLException em caso de erro na consulta ao banco
     */
    public static boolean emailJaExiste(String email) throws SQLException {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        
        Connection conexao = null;
        PreparedStatement sql = null;
        ResultSet resultado = null;
        
        try {
            // Obter conexão com o banco
            conexao = Conexao.getConnection();
            
            // Query para verificar se o email existe
            String query = "SELECT COUNT(*) as total FROM Usuario WHERE email_user = ?";
            sql = conexao.prepareStatement(query);
            sql.setString(1, email.trim().toLowerCase()); // Normalizar email para minúsculo
            
            resultado = sql.executeQuery();
            
            if (resultado.next()) {
                int total = resultado.getInt("total");
                return total > 0; // Se total > 0, email já existe
            }
            
            return false;
            
        } catch (SQLException e) {
            System.err.println("Erro ao verificar email duplicado: " + e.getMessage());
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
     * Verifica se um CPF/CNPJ já está cadastrado no sistema
     * @param cpfCnpj O CPF ou CNPJ a ser verificado
     * @return true se o CPF/CNPJ já existe, false caso contrário
     * @throws SQLException em caso de erro na consulta ao banco
     */
    public static boolean cpfCnpjJaExiste(String cpfCnpj) throws SQLException {
        if (cpfCnpj == null || cpfCnpj.trim().isEmpty()) {
            return false;
        }
        
        Connection conexao = null;
        PreparedStatement sql = null;
        ResultSet resultado = null;
        
        try {
            // Obter conexão com o banco
            conexao = Conexao.getConnection();
            
            // Limpar formatação do CPF/CNPJ para comparação (mesmo método usado em ValidadorCpfCnpj)
            String cpfCnpjLimpo = cpfCnpj.replaceAll("[^0-9]", "");
            
            // Validar se tem o tamanho correto antes de pesquisar
            if (cpfCnpjLimpo.length() != 11 && cpfCnpjLimpo.length() != 14) {
                return false; // Tamanho inválido, não pode estar duplicado
            }
            
            // Query robusta para verificar se o CPF/CNPJ existe (remove formatação tanto do input quanto do banco)
            String query = "SELECT COUNT(*) as total FROM Usuario WHERE REPLACE(REPLACE(REPLACE(cpfCnpj_user, '.', ''), '-', ''), '/', '') = ?";
            sql = conexao.prepareStatement(query);
            sql.setString(1, cpfCnpjLimpo);
            
            resultado = sql.executeQuery();
            
            if (resultado.next()) {
                int total = resultado.getInt("total");
                System.out.println("DEBUG CPF/CNPJ: " + cpfCnpjLimpo + " encontrado " + total + " vez(es)");
                return total > 0; // Se total > 0, CPF/CNPJ já existe
            }
            
            return false;
            
        } catch (SQLException e) {
            System.err.println("Erro ao verificar CPF/CNPJ duplicado: " + e.getMessage());
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
     * Valida todos os dados únicos do usuário (email e CPF/CNPJ)
     * @param email O email a ser verificado
     * @param cpfCnpj O CPF/CNPJ a ser verificado
     * @return String com mensagem de erro ou null se estiver válido
     */
    public static String validarDadosUnicos(String email, String cpfCnpj) {
        try {
            System.out.println("=== VALIDANDO DADOS ÚNICOS ===");
            System.out.println("Email: " + email);
            System.out.println("CPF/CNPJ: " + cpfCnpj);
            
            // Verificar CPF/CNPJ duplicado
            if (cpfCnpjJaExiste(cpfCnpj)) {
            	// Determinar se é CPF ou CNPJ para mensagem específica
            	String cpfCnpjLimpo = cpfCnpj.replaceAll("[^0-9]", "");
            	String tipoDoc;
            	if (cpfCnpjLimpo.length() == 11) {
            		tipoDoc = "CPF";
            	} else if (cpfCnpjLimpo.length() == 14) {
            		tipoDoc = "CNPJ";
            	} else {
            		tipoDoc = "documento";
            	}

            	System.out.println(tipoDoc + " duplicado encontrado!");
            	return "Este " + tipoDoc + " já está cadastrado no sistema. Cada pessoa/empresa pode ter apenas uma conta.";
            }
            
            
            // Verificar email duplicado primeiro
            if (emailJaExiste(email)) {
                System.out.println("Email duplicado encontrado!");
                return "Este email já está cadastrado no sistema. Utilize outro email ou faça login com sua conta existente.";
            }
            
            
            System.out.println("Dados únicos validados com sucesso!");
            return null; // Nenhum erro encontrado
            
        } catch (SQLException e) {
            System.err.println("Erro ao validar dados únicos: " + e.getMessage());
            e.printStackTrace();
            return "Erro interno do sistema ao verificar dados duplicados. Tente novamente mais tarde.";
        } catch (Exception e) {
            System.err.println("Erro inesperado ao validar dados únicos: " + e.getMessage());
            e.printStackTrace();
            return "Erro inesperado no sistema. Tente novamente mais tarde.";
        }
    }
    
    /**
     * Método específico para verificar apenas CPF duplicado
     * @param cpf O CPF a ser verificado (formato: XXX.XXX.XXX-XX ou apenas números)
     * @return true se o CPF já existe, false caso contrário
     */
    public static boolean cpfJaExiste(String cpf) {
        try {
            if (cpf == null || cpf.trim().isEmpty()) {
                return false;
            }
            
            String cpfLimpo = cpf.replaceAll("[^0-9]", "");
            if (cpfLimpo.length() != 11) {
                return false; // CPF deve ter exatamente 11 dígitos
            }
            
            return cpfCnpjJaExiste(cpf);
        } catch (SQLException e) {
            System.err.println("Erro ao verificar CPF duplicado: " + e.getMessage());
            return false; // Em caso de erro, assume que não existe para não bloquear cadastro
        }
    }
    
    /**
     * Método específico para verificar apenas CNPJ duplicado
     * @param cnpj O CNPJ a ser verificado (formato: XX.XXX.XXX/XXXX-XX ou apenas números)
     * @return true se o CNPJ já existe, false caso contrário
     */
    public static boolean cnpjJaExiste(String cnpj) {
        try {
            if (cnpj == null || cnpj.trim().isEmpty()) {
                return false;
            }
            
            String cnpjLimpo = cnpj.replaceAll("[^0-9]", "");
            if (cnpjLimpo.length() != 14) {
                return false; // CNPJ deve ter exatamente 14 dígitos
            }
            
            return cpfCnpjJaExiste(cnpj);
        } catch (SQLException e) {
            System.err.println("Erro ao verificar CNPJ duplicado: " + e.getMessage());
            return false; // Em caso de erro, assume que não existe para não bloquear cadastro
        }
    }
}
