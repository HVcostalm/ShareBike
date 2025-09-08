package br.com.sharebike.utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import br.com.sharebike.dao.UsuarioDAO;
import br.com.sharebike.model.Usuario;

@WebListener
public class StartupListener implements ServletContextListener{
	
	@Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            Usuario adm = new Usuario("70700111000196","ShareBike Inc","","Salvador","BA","Brasil","71989001571",
                    "contato@sharebikeinc.com","@ShareBike5202",null,true,false,false,"");
            
            // Só cadastra se ainda não existir
            if (usuarioDAO.exibirUsuario(adm.getCpfCnpj_user()) == null) {
                usuarioDAO.cadastrarUsuario(adm);
                System.out.println("Administrador criado com sucesso!");
            } else {
                System.out.println("Administrador já existe, não será recriado.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // nada a fazer no shutdown
    }
}
