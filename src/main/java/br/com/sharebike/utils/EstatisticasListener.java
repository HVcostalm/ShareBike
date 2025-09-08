package br.com.sharebike.utils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import br.com.sharebike.dao.FeedbackDAO;
import br.com.sharebike.dao.RankingDAO;
import br.com.sharebike.dao.ReservaDAO;

@WebListener
public class EstatisticasListener implements ServletContextListener {
	
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        
        try {
            // Carregar estatísticas na inicialização da aplicação
            ReservaDAO reservaDAO = new ReservaDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            RankingDAO rankingDAO = new RankingDAO();
            
            int bicicletasCompartilhadas = reservaDAO.contarReservasFinalizadas();
            int usuariosSatisfeitos = feedbackDAO.contarFeedbacksSatisfatorios();
            float kmPedalados = rankingDAO.somarTodosPontos();
            
            // Armazenar as estatísticas no contexto da aplicação
            context.setAttribute("bicicletasCompartilhadas", bicicletasCompartilhadas);
            context.setAttribute("usuariosSatisfeitos", usuariosSatisfeitos);
            context.setAttribute("kmPedalados", kmPedalados);
            
            System.out.println("Estatísticas carregadas: " + bicicletasCompartilhadas + " bicicletas, " + 
                             usuariosSatisfeitos + " usuários satisfeitos, " + kmPedalados + " km pedalados");
            
        } catch (Exception e) {
            System.err.println("Erro ao carregar estatísticas: " + e.getMessage());
            e.printStackTrace();
            
            // Valores padrão em caso de erro
            context.setAttribute("bicicletasCompartilhadas", 0);
            context.setAttribute("usuariosSatisfeitos", 0);
            context.setAttribute("kmPedalados", 0.0f);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup se necessário
    }
}
