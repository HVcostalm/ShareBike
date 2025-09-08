package br.com.sharebike.utils;

/**
 * Classe utilitária para validação de CPF e CNPJ
 * Implementa os algoritmos oficiais de validação dos dígitos verificadores
 */
public class ValidadorCpfCnpj {
    
    /**
     * Valida CPF ou CNPJ automaticamente baseado no tamanho
     * @param documento CPF (11 dígitos) ou CNPJ (14 dígitos)
     * @return true se válido, false caso contrário
     */
    public static boolean validarDocumento(String documento) {
        if (documento == null || documento.trim().isEmpty()) {
            return false;
        }
        
        // Remove caracteres especiais (pontos, traços, barras)
        String documentoLimpo = documento.replaceAll("[^0-9]", "");
        
        // Verifica o tamanho e chama o método apropriado
        if (documentoLimpo.length() == 11) {
            return validarCPF(documentoLimpo);
        } else if (documentoLimpo.length() == 14) {
            return validarCNPJ(documentoLimpo);
        } else {
            return false; // Tamanho inválido
        }
    }
    
    /**
     * Valida CPF usando o algoritmo oficial
     * @param cpf String com 11 dígitos numéricos
     * @return true se válido, false caso contrário
     */
    private static boolean validarCPF(String cpf) {
        if (cpf == null || cpf.length() != 11 || !cpf.matches("[0-9]{11}")) {
            return false;
        }

        if (cpf.matches("(\\d)\\1{10}")) {
            return false; // Não permite CPFs com números repetidos
        }

        int soma = 0;
        int peso = 10;
        for (int i = 0; i < 9; i++) {
            soma += Character.getNumericValue(cpf.charAt(i)) * peso--;
        }

        int digito1 = 11 - (soma % 11);
        if (digito1 == 10 || digito1 == 11) digito1 = 0;

        soma = 0;
        peso = 11;
        for (int i = 0; i < 10; i++) {
            soma += Character.getNumericValue(cpf.charAt(i)) * peso--;
        }

        int digito2 = 11 - (soma % 11);
        if (digito2 == 10 || digito2 == 11) digito2 = 0;

        return digito1 == Character.getNumericValue(cpf.charAt(9)) && digito2 == Character.getNumericValue(cpf.charAt(10));
    }

    /**
     * Valida CNPJ usando o algoritmo oficial
     * @param cnpj String com 14 dígitos numéricos
     * @return true se válido, false caso contrário
     */
    private static boolean validarCNPJ(String cnpj) {
        if (cnpj == null || cnpj.length() != 14 || !cnpj.matches("[0-9]{14}")) {
            return false;
        }

        if (cnpj.matches("(\\d)\\1{13}")) {
            return false; // Não permite CNPJs com números repetidos
        }

        int soma = 0;
        int[] peso1 = {5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};
        for (int i = 0; i < 12; i++) {
            soma += Character.getNumericValue(cnpj.charAt(i)) * peso1[i];
        }

        int digito1 = 11 - (soma % 11);
        if (digito1 == 10 || digito1 == 11) digito1 = 0;

        soma = 0;
        int[] peso2 = {6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};
        for (int i = 0; i < 13; i++) {
            soma += Character.getNumericValue(cnpj.charAt(i)) * peso2[i];
        }

        int digito2 = 11 - (soma % 11);
        if (digito2 == 10 || digito2 == 11) digito2 = 0;

        return digito1 == Character.getNumericValue(cnpj.charAt(12)) && digito2 == Character.getNumericValue(cnpj.charAt(13));
    }
    
    /**
     * Verifica se o documento é um CPF (11 dígitos)
     * @param documento documento a ser verificado
     * @return true se for CPF, false caso contrário
     */
    public static boolean isCPF(String documento) {
        if (documento == null) return false;
        String documentoLimpo = documento.replaceAll("[^0-9]", "");
        return documentoLimpo.length() == 11;
    }
    
    /**
     * Verifica se o documento é um CNPJ (14 dígitos)
     * @param documento documento a ser verificado
     * @return true se for CNPJ, false caso contrário
     */
    public static boolean isCNPJ(String documento) {
        if (documento == null) return false;
        String documentoLimpo = documento.replaceAll("[^0-9]", "");
        return documentoLimpo.length() == 14;
    }
    
    /**
     * Formata CPF para exibição (000.000.000-00)
     * @param cpf CPF sem formatação
     * @return CPF formatado
     */
    public static String formatarCPF(String cpf) {
        if (cpf == null || cpf.length() != 11) return cpf;
        return cpf.substring(0, 3) + "." + cpf.substring(3, 6) + "." + 
               cpf.substring(6, 9) + "-" + cpf.substring(9, 11);
    }
    
    /**
     * Formata CNPJ para exibição (00.000.000/0000-00)
     * @param cnpj CNPJ sem formatação
     * @return CNPJ formatado
     */
    public static String formatarCNPJ(String cnpj) {
        if (cnpj == null || cnpj.length() != 14) return cnpj;
        return cnpj.substring(0, 2) + "." + cnpj.substring(2, 5) + "." + 
               cnpj.substring(5, 8) + "/" + cnpj.substring(8, 12) + "-" + cnpj.substring(12, 14);
    }
}
