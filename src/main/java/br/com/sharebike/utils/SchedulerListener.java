package br.com.sharebike.utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class SchedulerListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("[SchedulerListener] Inicializando schedulers...");

        try {
            RankingScheduler.iniciar();
            DisponibilidadeScheduler.iniciar();
            System.out.println("[SchedulerListener] Schedulers iniciados com sucesso!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("[SchedulerListener] Encerrando schedulers...");
        try {
            RankingScheduler.parar();
            DisponibilidadeScheduler.parar();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
