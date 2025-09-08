package br.com.sharebike.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.ArrayList;

import br.com.sharebike.dao.DisponibilidadeDAO;
import br.com.sharebike.model.Disponibilidade;

/**
 * Classe utilitária para validações relacionadas às disponibilidades de bicicletas
 */
public class ValidadorDisponibilidade {
    
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
    
    /**
     * Resultado da validação de disponibilidade
     */
    public static class ResultadoValidacao {
        private boolean valido;
        private String mensagemErro;
        private List<String> detalhesConflitos;
        
        public ResultadoValidacao(boolean valido, String mensagemErro) {
            this.valido = valido;
            this.mensagemErro = mensagemErro;
            this.detalhesConflitos = new ArrayList<>();
        }
        
        public boolean isValido() { return valido; }
        public String getMensagemErro() { return mensagemErro; }
        public List<String> getDetalhesConflitos() { return detalhesConflitos; }
        
        public void adicionarDetalheConflito(String detalhe) {
            this.detalhesConflitos.add(detalhe);
        }
    }
    
    /**
     * Valida os dados básicos de uma disponibilidade
     * @param dataHoraInicio Data/hora de início
     * @param dataHoraFim Data/hora de fim
     * @return ResultadoValidacao com resultado da validação
     */
    public static ResultadoValidacao validarDadosBasicos(String dataHoraInicio, String dataHoraFim) {
        // Validar se os campos não estão vazios
        if (dataHoraInicio == null || dataHoraInicio.trim().isEmpty()) {
            return new ResultadoValidacao(false, "A data/hora de início é obrigatória.");
        }
        
        if (dataHoraFim == null || dataHoraFim.trim().isEmpty()) {
            return new ResultadoValidacao(false, "A data/hora de fim é obrigatória.");
        }
        
        try {
            LocalDateTime inicio = LocalDateTime.parse(dataHoraInicio);
            LocalDateTime fim = LocalDateTime.parse(dataHoraFim);
            
            return validarLogicaTemporal(inicio, fim);
            
        } catch (DateTimeParseException e) {
            return new ResultadoValidacao(false, "Formato de data/hora inválido. Use o formato: AAAA-MM-DDTHH:MM");
        }
    }
    
    /**
     * Valida os dados básicos usando LocalDateTime
     * @param inicio Data/hora de início
     * @param fim Data/hora de fim
     * @return ResultadoValidacao com resultado da validação
     */
    public static ResultadoValidacao validarDadosBasicos(LocalDateTime inicio, LocalDateTime fim) {
        if (inicio == null) {
            return new ResultadoValidacao(false, "A data/hora de início é obrigatória.");
        }
        
        if (fim == null) {
            return new ResultadoValidacao(false, "A data/hora de fim é obrigatória.");
        }
        
        return validarLogicaTemporal(inicio, fim);
    }
    
    /**
     * Valida a lógica temporal das datas
     * @param inicio Data/hora de início
     * @param fim Data/hora de fim
     * @return ResultadoValidacao com resultado da validação
     */
    private static ResultadoValidacao validarLogicaTemporal(LocalDateTime inicio, LocalDateTime fim) {
        LocalDateTime agora = LocalDateTime.now();
        
        // Verificar se a data de início é no futuro
        if (inicio.isBefore(agora)) {
            return new ResultadoValidacao(false, 
                "A data/hora de início deve ser no futuro. Data informada: " + inicio.format(FORMATTER));
        }
        
        // Verificar se a data de fim é posterior à de início
        if (!fim.isAfter(inicio)) {
            return new ResultadoValidacao(false, 
                "A data/hora de fim deve ser posterior à data/hora de início.");
        }
        
        // Verificar duração mínima (ex: 1 hora)
        if (fim.isBefore(inicio.plusHours(1))) {
            return new ResultadoValidacao(false, 
                "A disponibilidade deve ter duração mínima de 1 hora.");
        }
        
        // Verificar duração máxima (ex: 30 dias)
        if (fim.isAfter(inicio.plusDays(30))) {
            return new ResultadoValidacao(false, 
                "A disponibilidade não pode ter duração superior a 30 dias.");
        }
        
        return new ResultadoValidacao(true, null);
    }
    
    /**
     * Verifica se há conflitos de horários com disponibilidades existentes
     * @param idBicicleta ID da bicicleta
     * @param inicio Data/hora de início da nova disponibilidade
     * @param fim Data/hora de fim da nova disponibilidade
     * @return ResultadoValidacao com resultado da verificação
     */
    public static ResultadoValidacao verificarConflitos(int idBicicleta, LocalDateTime inicio, LocalDateTime fim) {
        return verificarConflitos(idBicicleta, inicio, fim, -1);
    }
    
    /**
     * Verifica se há conflitos de horários com disponibilidades existentes (para edição)
     * @param idBicicleta ID da bicicleta
     * @param inicio Data/hora de início da nova disponibilidade
     * @param fim Data/hora de fim da nova disponibilidade
     * @param excluirIdDisp ID da disponibilidade a ser excluída da verificação (para edição)
     * @return ResultadoValidacao com resultado da verificação
     */
    public static ResultadoValidacao verificarConflitos(int idBicicleta, LocalDateTime inicio, LocalDateTime fim, int excluirIdDisp) {
        try {
            DisponibilidadeDAO dao = new DisponibilidadeDAO();
            
            // Buscar todas as disponibilidades da bicicleta
            List<Disponibilidade> disponibilidades = dao.listarPorBicicleta(idBicicleta);
            
            if (disponibilidades == null || disponibilidades.isEmpty()) {
                return new ResultadoValidacao(true, null);
            }
            
            ResultadoValidacao resultado = new ResultadoValidacao(true, null);
            List<String> conflitos = new ArrayList<>();
            
            for (Disponibilidade disp : disponibilidades) {
                // Pular a disponibilidade atual se estivermos editando
                if (excluirIdDisp != -1 && disp.getId_disp() == excluirIdDisp) {
                    continue;
                }
                
                LocalDateTime existeInicio = disp.getDataHoraIn_disp();
                LocalDateTime existeFim = disp.getDataHoraFim_disp();
                
                // Verificar sobreposição: nova.início < existente.fim AND nova.fim > existente.início
                if (inicio.isBefore(existeFim) && fim.isAfter(existeInicio)) {
                    String conflito = String.format("Conflito com disponibilidade ID %d (%s às %s)",
                        disp.getId_disp(),
                        existeInicio.format(FORMATTER),
                        existeFim.format(FORMATTER));
                    
                    conflitos.add(conflito);
                }
            }
            
            if (!conflitos.isEmpty()) {
                resultado = new ResultadoValidacao(false, 
                    "Já existe(m) " + conflitos.size() + " disponibilidade(s) que conflita(m) com este horário.");
                
                for (String conflito : conflitos) {
                    resultado.adicionarDetalheConflito(conflito);
                }
            }
            
            return resultado;
            
        } catch (Exception e) {
            System.err.println("Erro ao verificar conflitos de disponibilidade: " + e.getMessage());
            return new ResultadoValidacao(false, "Erro interno do sistema. Tente novamente mais tarde.");
        }
    }
    
    /**
     * Validação completa de uma nova disponibilidade
     * @param idBicicleta ID da bicicleta
     * @param dataHoraInicio Data/hora de início (String)
     * @param dataHoraFim Data/hora de fim (String)
     * @return ResultadoValidacao com resultado completo da validação
     */
    public static ResultadoValidacao validarNovaDisponibilidade(int idBicicleta, String dataHoraInicio, String dataHoraFim) {
        // Validar dados básicos primeiro
        ResultadoValidacao validacaoBasica = validarDadosBasicos(dataHoraInicio, dataHoraFim);
        if (!validacaoBasica.isValido()) {
            return validacaoBasica;
        }
        
        try {
            LocalDateTime inicio = LocalDateTime.parse(dataHoraInicio);
            LocalDateTime fim = LocalDateTime.parse(dataHoraFim);
            
            // Verificar conflitos
            return verificarConflitos(idBicicleta, inicio, fim);
            
        } catch (DateTimeParseException e) {
            return new ResultadoValidacao(false, "Formato de data/hora inválido.");
        }
    }
    
    /**
     * Validação completa para edição de disponibilidade
     * @param idBicicleta ID da bicicleta
     * @param dataHoraInicio Data/hora de início (String)
     * @param dataHoraFim Data/hora de fim (String)
     * @param idDisponibilidade ID da disponibilidade sendo editada
     * @return ResultadoValidacao com resultado completo da validação
     */
    public static ResultadoValidacao validarEdicaoDisponibilidade(int idBicicleta, String dataHoraInicio, 
                                                                String dataHoraFim, int idDisponibilidade) {
        // Validar dados básicos primeiro
        ResultadoValidacao validacaoBasica = validarDadosBasicos(dataHoraInicio, dataHoraFim);
        if (!validacaoBasica.isValido()) {
            return validacaoBasica;
        }
        
        try {
            LocalDateTime inicio = LocalDateTime.parse(dataHoraInicio);
            LocalDateTime fim = LocalDateTime.parse(dataHoraFim);
            
            // Verificar conflitos excluindo a disponibilidade atual
            return verificarConflitos(idBicicleta, inicio, fim, idDisponibilidade);
            
        } catch (DateTimeParseException e) {
            return new ResultadoValidacao(false, "Formato de data/hora inválido.");
        }
    }
    
    /**
     * Verifica se uma disponibilidade está em período válido (não expirada)
     * @param disponibilidade A disponibilidade a ser verificada
     * @return true se ainda é válida, false se expirou
     */
    public static boolean isDisponibilidadeValida(Disponibilidade disponibilidade) {
        if (disponibilidade == null || disponibilidade.getDataHoraFim_disp() == null) {
            return false;
        }
        
        return disponibilidade.getDataHoraFim_disp().isAfter(LocalDateTime.now());
    }
    
    /**
     * Filtra disponibilidades válidas (não expiradas)
     * @param disponibilidades Lista de disponibilidades
     * @return Lista apenas com disponibilidades válidas
     */
    public static List<Disponibilidade> filtrarDisponibilidadesValidas(List<Disponibilidade> disponibilidades) {
        List<Disponibilidade> validas = new ArrayList<>();
        
        if (disponibilidades != null) {
            for (Disponibilidade disp : disponibilidades) {
                if (isDisponibilidadeValida(disp)) {
                    validas.add(disp);
                }
            }
        }
        
        return validas;
    }
    
    /**
     * Formata período de disponibilidade para exibição
     * @param inicio Data/hora de início
     * @param fim Data/hora de fim
     * @return String formatada do período
     */
    public static String formatarPeriodo(LocalDateTime inicio, LocalDateTime fim) {
        if (inicio == null || fim == null) {
            return "Período não definido";
        }
        
        return String.format("De %s às %s", 
            inicio.format(FORMATTER), 
            fim.format(FORMATTER));
    }
    
    /**
     * Calcula duração em horas entre duas datas
     * @param inicio Data/hora de início
     * @param fim Data/hora de fim
     * @return Duração em horas
     */
    public static long calcularDuracaoHoras(LocalDateTime inicio, LocalDateTime fim) {
        if (inicio == null || fim == null) {
            return 0;
        }
        
        return java.time.Duration.between(inicio, fim).toHours();
    }
}
