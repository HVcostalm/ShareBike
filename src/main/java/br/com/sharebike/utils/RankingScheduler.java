package br.com.sharebike.utils;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import br.com.sharebike.dao.RankingDAO;

public class RankingScheduler {
	private static Timer scheduler;

	public static void iniciar() {
		if (scheduler != null) {
			scheduler.cancel(); // evita agendamentos duplicados
		}

		scheduler = new Timer();
		RankingDAO rankingDAO = new RankingDAO();

		// Definir o próximo domingo à meia-noite
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);

		// Se já passou o horário de hoje, agenda para o próximo domingo
		Date primeiraExecucao = calendar.getTime();
		if (primeiraExecucao.before(new Date())) {
			calendar.add(Calendar.DAY_OF_YEAR, 7);
			primeiraExecucao = calendar.getTime();
		}

		long intervaloSemanal = 7L * 24 * 60 * 60 * 1000; // 7 dias

		scheduler.scheduleAtFixedRate(new TimerTask() {
			@Override
			public void run() {
				int linhasAfetadas = rankingDAO.resetarPontosSemana();
				System.out.println("[RankingScheduler] Reset semanal executado. Linhas afetadas: " + linhasAfetadas);
			}
		}, primeiraExecucao, intervaloSemanal);
	}

	public static void parar() {
		if (scheduler != null) {
			scheduler.cancel();
			scheduler = null;
			System.out.println("[RankingScheduler] Scheduler parado.");
		}
	}
}
