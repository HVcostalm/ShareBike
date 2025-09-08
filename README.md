# 🚲 ShareBike - Plataforma de Compartilhamento de Bicicletas

<div align="center">
  <img src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white" alt="Java"/>
  <img src="https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white" alt="JSP"/>
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL"/>
  <img src="https://img.shields.io/badge/Servlet-ED8B00?style=for-the-badge&logo=java&logoColor=white" alt="Servlet"/>
  <img src="https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white" alt="Bootstrap"/>
</div>

<div align="center">
  <h3>🌱 Mobilidade Urbana Sustentável através do Compartilhamento de Bicicletas</h3>
  <p>Uma plataforma completa que conecta proprietários de bicicletas com usuários, promovendo mobilidade sustentável e economia colaborativa.</p>
</div>

---

## 📋 Índice

- [🎯 Visão Geral](#-visão-geral)
- [✨ Funcionalidades](#-funcionalidades)
- [🏗️ Arquitetura](#️-arquitetura)
- [🛠️ Tecnologias](#️-tecnologias)
- [📦 Instalação](#-instalação)
- [🚀 Como Usar](#-como-usar)
- [👥 Tipos de Usuários](#-tipos-de-usuários)
- [📊 Banco de Dados](#-banco-de-dados)
- [🔧 Configuração](#-configuração)
- [🤝 Contribuição](#-contribuição)
- [📄 Licença](#-licença)

---

## 🎯 Visão Geral

O **ShareBike** é uma plataforma web inovadora que facilita o compartilhamento de bicicletas entre usuários, promovendo a mobilidade urbana sustentável. O sistema permite que proprietários de bicicletas disponibilizem seus veículos para aluguel, enquanto locatários podem encontrar e reservar bicicletas próximas às suas necessidades.

### 🌟 Principais Benefícios

- **🌍 Sustentabilidade**: Redução da pegada de carbono através da mobilidade compartilhada
- **💰 Economia**: Acesso econômico ao transporte sustentável
- **🏙️ Mobilidade Urbana**: Solução para o trânsito urbano e última milha
- **🤝 Comunidade**: Conexão entre pessoas com valores sustentáveis comuns

---

## ✨ Funcionalidades

### 👤 **Gestão de Usuários**
- ✅ Cadastro completo com validação CPF/CNPJ
- ✅ Sistema de login/logout seguro  
- ✅ Perfis personalizados com fotos
- ✅ Sistema de avaliações e reputação
- ✅ Controle de permissões por administradores

### 🚲 **Gestão de Bicicletas**
- ✅ Cadastro detalhado de bicicletas (modelo, tipo, estado)
- ✅ Upload de fotos das bicicletas
- ✅ Sistema de avaliações de bicicletas
- ✅ Validação de chassi único
- ✅ Filtros avançados de busca

### 📅 **Sistema de Disponibilidade**
- ✅ Agendamento flexível de horários
- ✅ Validação automática de conflitos
- ✅ Bloqueio inteligente durante reservas
- ✅ Calendário visual de disponibilidade

### 📋 **Gestão de Reservas**
- ✅ Processo de reserva intuitivo
- ✅ Aprovação/negação por locadores
- ✅ Controle de status em tempo real
- ✅ Histórico completo de reservas
- ✅ Sistema de notificações

### 💬 **Sistema de Feedback**
- ✅ Avaliações bidirecionais (locador ↔ locatário)
- ✅ Avaliações específicas de bicicletas
- ✅ Comentários detalhados sobre experiências
- ✅ Métricas de satisfação

### 🏆 **Sistema de Ranking**
- ✅ Pontuação por quilometragem pedalada
- ✅ Rankings regionais (cidade/estado/país)
- ✅ Sistema de bike própria com controle diário
- ✅ Reset automático semanal
- ✅ Relatórios estatísticos

### 👨‍💼 **Painel Administrativo**
- ✅ Gestão completa de usuários
- ✅ Aprovação de acessos e rankings
- ✅ Revogação de permissões
- ✅ Monitoramento de atividades
- ✅ Relatórios gerenciais

---

## 🏗️ Arquitetura

O projeto segue o padrão **MVC (Model-View-Controller)** com arquitetura em camadas:

```
📁 src/main/java/br/com/sharebike/
├── 🎮 controller/          # Servlets Controllers
│   ├── UsuarioController.java
│   ├── BicicletaController.java
│   ├── ReservaController.java
│   ├── DisponibilidadeController.java
│   ├── FeedbackController.java
│   └── RankingController.java
├── 📊 dao/                 # Data Access Objects
│   ├── BaseDAO.java
│   ├── UsuarioDAO.java
│   ├── BicicletaDAO.java
│   ├── ReservaDAO.java
│   ├── DisponibilidadeDAO.java
│   ├── FeedbackDAO.java
│   └── RankingDAO.java
├── 📋 model/               # Entidades do Domínio
│   ├── Usuario.java
│   ├── Bicicleta.java
│   ├── Reserva.java
│   ├── Disponibilidade.java
│   ├── Feedback.java
│   └── Ranking.java
└── 🔧 utils/              # Utilitários e Validações
    ├── Conexao.java
    ├── ValidadorUsuario.java
    ├── ValidadorBicicleta.java
    ├── ValidadorDisponibilidade.java
    ├── RankingScheduler.java
    └── DisponibilidadeScheduler.java
```

```
📁 src/main/webapp/
├── 🏠 index.jsp            # Página inicial
├── 📱 pages/               # Páginas JSP
├── 🎨 assets/              # CSS, JS, Images
└── ⚙️ WEB-INF/            # Configurações
```

### 🔄 Fluxo de Dados

1. **Cliente** → Requisição HTTP
2. **Controller** → Processa requisição e regras de negócio
3. **DAO** → Acessa e manipula dados no banco
4. **Model** → Representa entidades do domínio
5. **View (JSP)** → Renderiza resposta para o cliente

---

## 🛠️ Tecnologias

### **Backend**
- ☕ **Java 11+** - Linguagem principal
- 🌐 **Java Servlets** - Controllers web
- 📄 **JSP (JavaServer Pages)** - Templates dinâmicos
- 🗃️ **MySQL 8.0** - Banco de dados
- 🔌 **JDBC** - Conectividade com banco
- 📅 **Schedulers** - Tarefas automatizadas

### **Frontend**
- 🎨 **HTML5 + CSS3** - Estrutura e estilo
- ⚡ **JavaScript** - Interatividade
- 🎨 **Bootstrap/Tailwind** - Framework CSS
- 🔤 **Font Awesome** - Ícones
- 📱 **Design Responsivo** - Multi-dispositivos

### **Ferramentas de Desenvolvimento**
- 🛠️ **Eclipse IDE** - Ambiente de desenvolvimento
- 🐱‍💻 **Git** - Controle de versão
- 🖥️ **Apache Tomcat** - Servidor de aplicação
- 📦 **Maven** (opcional) - Gerenciamento de dependências

---

## 📦 Instalação

### **Pré-requisitos**

- ☕ Java Development Kit (JDK) 11 ou superior
- 🗃️ MySQL Server 8.0 ou superior
- 🖥️ Apache Tomcat 9.0 ou superior
- 🛠️ IDE Eclipse/IntelliJ/VS Code

### **Passo a Passo**

1. **📥 Clone o repositório**
   ```bash
   git clone https://github.com/HVcostalm/ShareBike.git
   cd ShareBike
   ```

2. **🗃️ Configure o banco de dados**
   ```sql
   -- Abra o MySQL Workbench e execute o script SQL
   -- Arquivo: src/main/java/br/com/sharebike/utils/banco.sql
   ```

3. **⚙️ Configure a conexão**
   ```java
   // Edite: src/main/java/br/com/sharebike/utils/Conexao.java
   private static final String URL = "jdbc:mysql://localhost:3306/sharebike_20250526";
   private static final String USUARIO = "seu_usuario";
   private static final String SENHA = "sua_senha";
   ```

4. **📚 Adicione as dependências**
   - Baixe o [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/)
   - No Eclipse, clique com botão direito no projeto → Properties
   - Vá em "Java Build Path" → "Libraries" → "Add External JARs"
   - Selecione o arquivo `mysql-connector-j-9.3.0.jar`
   - O arquivo também deve estar em `src/main/webapp/WEB-INF/lib/`

5. **🚀 Deploy no Tomcat**
   - Importe o projeto no Eclipse
   - Configure o servidor Tomcat
   - Execute o projeto

6. **🌐 Acesse a aplicação**
   ```
   http://localhost:8080/ShareBike
   ```

---

## 🚀 Como Usar

### **1️⃣ Primeira Execução**

1. Acesse `http://localhost:8080/ShareBike`
2. Clique em "Cadastrar" para criar sua conta
3. Aguarde aprovação do administrador
4. Faça login com suas credenciais

### **2️⃣ Como Locador (Proprietário)**

1. **Cadastre sua bicicleta**
   - Acesse "Minhas Bicicletas" → "Cadastrar Nova"
   - Preencha informações detalhadas
   - Faça upload de fotos

2. **Defina disponibilidade**
   - Clique na bicicleta → "Definir Disponibilidade"
   - Configure horários e datas
   - Confirme a programação

3. **Gerencie reservas**
   - Acesse "Reservas Recebidas"
   - Aprove ou negue solicitações
   - Acompanhe status das reservas

### **3️⃣ Como Locatário (Cliente)**

1. **Busque bicicletas**
   - Use filtros por cidade, tipo, estado
   - Visualize avaliações e fotos
   - Escolha a bicicleta ideal

2. **Faça uma reserva**
   - Clique em "Ver Detalhes" → "Reservar"
   - Selecione horário disponível
   - Confirme a reserva

3. **Após o uso**
   - Informe a distância percorrida
   - Avalie a bicicleta e proprietário
   - Ganhe pontos no ranking

### **4️⃣ Como Administrador**

1. **Gestão de usuários**
   - Aprove novos cadastros
   - Gerencie permissões
   - Revogue acessos quando necessário

2. **Monitoramento**
   - Acompanhe estatísticas
   - Monitore feedbacks
   - Gerencie rankings

---

## 👥 Tipos de Usuários

### 🏠 **Locador (Proprietário de Bicicleta)**
**Responsabilidades:**
- Cadastrar bicicletas com informações precisas
- Definir horários de disponibilidade
- Aprovar/negar reservas de forma responsável
- Manter bicicletas em bom estado
- Fornecer localização clara para entrega

**Benefícios:**
- Contribuir com mobilidade sustentável
- Receber avaliações e construir reputação
- Ajudar a comunidade com transporte alternativo

### 🚴 **Locatário (Cliente)**
**Responsabilidades:**
- Fazer reservas respeitando horários
- Cuidar bem da bicicleta durante uso
- Devolver no prazo e local combinados
- Informar problemas ou danos
- Avaliar experiência honestamente

**Benefícios:**
- Acesso econômico a bicicletas
- Variedade de opções por região
- Sistema de pontuação gamificado
- Contribuir com meio ambiente

### 👨‍💼 **Administrador**
**Responsabilidades:**
- Aprovar novos usuários
- Monitorar atividades suspeitas
- Gerenciar permissões de acesso
- Resolver conflitos entre usuários
- Manter qualidade da plataforma

**Poderes:**
- Acesso total ao sistema
- Gestão de usuários e permissões
- Visualização de relatórios
- Controle de rankings

---

## 📊 Banco de Dados

### **Modelo Entidade-Relacionamento**

```
Usuario ||--o{ Bicicleta : possui
Usuario ||--o{ Reserva : faz
Usuario ||--o{ Feedback : avalia
Usuario ||--o{ Ranking : participa
Bicicleta ||--o{ Disponibilidade : tem
Bicicleta ||--o{ Reserva : eh_reservada
Reserva ||--|| Feedback : gera
```

### **Tabelas Principais**

| Tabela | Descrição | Registros Típicos |
|--------|-----------|------------------|
| **Usuario** | Dados pessoais e configurações | ~1000 usuários |
| **Bicicleta** | Informações das bicicletas | ~500 bicicletas |
| **Reserva** | Histórico de reservas | ~5000 reservas |
| **Disponibilidade** | Horários disponíveis | ~2000 slots |
| **Feedback** | Avaliações e comentários | ~3000 avaliações |
| **Ranking** | Pontuações por região | ~800 rankings |

### **Constraints e Validações**

- ✅ CPF/CNPJ únicos e válidos
- ✅ Email único por usuário
- ✅ Chassi único por bicicleta
- ✅ Status de reserva controlado
- ✅ Datas de disponibilidade consistentes
- ✅ Avaliações dentro do range 1-5

---

## 🔧 Configuração

### ** Configuração de Schedulers**

```java
// Execução automática de tarefas
- Reset de pontos semanais: Domingo 00:00
- Limpeza de arquivos temporários: Diário 02:00
- Atualização de disponibilidades: A cada hora
```

---

##  Fluxos de Uso Principais

### **🚴 Fluxo de Reserva**
```
1. Locatário busca bicicleta
2. Sistema lista bicicletas disponíveis
3. Locatário seleciona e reserva
4. Sistema notifica proprietário
5. Proprietário aprova/nega reserva
6. Sistema confirma status para locatário
7. Locatário usa bicicleta
8. Locatário avalia experiência
```

### **🏆 Fluxo de Pontuação**
```
1. Usuário informa distância percorrida
2. Sistema calcula pontos baseado na quilometragem
3. Sistema atualiza ranking do usuário
4. Sistema recalcula posições regionais
5. Sistema exibe nova pontuação para usuário
```

---

## 📈 Roadmap Futuro

### **🚀 Versão 2.0**
- [ ] Upload de fotos usando input type="file"
- [ ] API REST para aplicativo móvel
- [ ] Sistema de monetização (taxas de serviço)
- [ ] Integração com pagamentos (PIX, cartão)
- [ ] Integração com sistema de emails automáticos
- [ ] Notificações por email (aprovação/negação de cadastros)
- [ ] Chat em tempo real entre usuários
- [ ] Sistema de pontos resgatáveis
- [ ] Integração com mapas (Google Maps)

---

## 🤝 Contribuição

Contribuições são sempre bem-vindas! Siga estes passos:

### **🔧 Como Contribuir**

1. **Fork** o projeto
2. **Clone** seu fork localmente
3. **Crie** uma branch para sua feature
   ```bash
   git checkout -b feature/nova-funcionalidade
   ```
4. **Desenvolva** sua funcionalidade
5. **Teste** thoroughly
6. **Commit** suas mudanças
   ```bash
   git commit -m "feat: adiciona nova funcionalidade"
   ```
7. **Push** para sua branch
   ```bash
   git push origin feature/nova-funcionalidade
   ```
8. **Abra** um Pull Request

### **📋 Padrões de Código**

- ✅ Use nomes descritivos para variáveis e métodos
- ✅ Comente código complexo
- ✅ Siga as convenções Java
- ✅ Teste todas as funcionalidades
- ✅ Mantenha arquitetura MVC

### **🐛 Reportando Bugs**

Use nossa template de issue incluindo:
- Descrição detalhada do problema
- Passos para reproduzir
- Screenshots se aplicável
- Ambiente (SO, navegador, versão Java)

---

## 📄 Licença

Este projeto está licenciado sob a [MIT License](LICENSE) - veja o arquivo LICENSE para detalhes.

```
MIT License

Copyright (c) 2025 ShareBike Project

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

---

## 👨‍💻 Equipe de Desenvolvimento

<div align="center">

### **Desenvolvido com ❤️ pela equipe ShareBike**

**Heitor Vinícius** - Desenvolvedor Principal  
**GitHub**: [HVcostalm](https://github.com/HVcostalm)

</div>

---

## 📞 Suporte e Contato

### **🆘 Precisa de Ajuda?**

- 🐛 **Issues**: [GitHub Issues](https://github.com/HVcostalm/ShareBike/issues)
- 📖 **Documentação**: [Wiki do Projeto](https://github.com/HVcostalm/ShareBike/wiki)
- 💬 **Discussões**: [GitHub Discussions](https://github.com/HVcostalm/ShareBike/discussions)

### **🌐 Links Úteis**

- 🏠 [Repositório GitHub](https://github.com/HVcostalm/ShareBike)

---

<div align="center">
  <h3>🌍 Juntos por uma mobilidade mais sustentável! 🚲</h3>
  <p><em>ShareBike - Conectando pessoas, transformando cidades.</em></p>
  
  [![GitHub Stars](https://img.shields.io/github/stars/HVcostalm/ShareBike?style=social)](https://github.com/HVcostalm/ShareBike/stargazers)
  [![GitHub Forks](https://img.shields.io/github/forks/HVcostalm/ShareBike?style=social)](https://github.com/HVcostalm/ShareBike/network)
  [![GitHub Issues](https://img.shields.io/github/issues/HVcostalm/ShareBike)](https://github.com/HVcostalm/ShareBike/issues)
  [![GitHub Pull Requests](https://img.shields.io/github/issues-pr/HVcostalm/ShareBike)](https://github.com/HVcostalm/ShareBike/pulls)
</div>

---

<div align="center">
  <sub>⭐ Se este projeto te ajudou, considere dar uma estrela!</sub>
</div>