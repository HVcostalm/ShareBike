package br.com.sharebike.utils;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import br.com.sharebike.dao.DisponibilidadeDAO;

public class DisponibilidadeScheduler {
	private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private static final DisponibilidadeDAO disponibilidadeDAO = new DisponibilidadeDAO();

    public static void iniciar() {
        Runnable tarefa = () -> {
            try {
                int atualizadas = disponibilidadeDAO.tornarIndisponivel();
                System.out.println("Agendado: " + atualizadas + " disponibilidades tornadas indisponíveis.");
            } catch (Exception e) {
                e.printStackTrace();
            }
        };

        // Executar a cada 1 hora, com 0 de delay inicial
        scheduler.scheduleAtFixedRate(tarefa, 0, 1, TimeUnit.HOURS);
    }
    
    public static void parar() {
        try {
            scheduler.shutdownNow();
            System.out.println("[DisponibilidadeScheduler] Scheduler parado.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
