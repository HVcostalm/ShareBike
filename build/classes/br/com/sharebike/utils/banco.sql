-- Cria o banco de dados 'shareBike_20250526' se ele ainda não existir.
create database IF NOT EXISTS shareBike_20250526;

-- Usa o banco de dados 'shareBike_20250526' para as operações seguintes.
use shareBike_20250526;

-- Cria a tabela 'Usuario' para armazenar informações dos usuários.
create table IF NOT EXISTS Usuario(
	cpfCnpj_user 			varchar(14) primary key,
    nomeRazaoSocial_user 	varchar(100) not null,
    foto_user 				varchar(45) not null,
    cidade_user 			varchar(100) not null,
    estado_user 			varchar(2) not null,
    pais_user 				varchar(45) not null,
    telefone_user 			varchar(11) not null,
    email_user 				varchar(100) unique not null,
    senha_user 				varchar(20) not null, 
    avaliacao_user 			float,
    permissaoAcesso_user 	boolean not null,
    permissaoRank_user 		boolean not null,
    possuiBike_user 		boolean not null,
    fotoComprBike_user 		varchar(100)
);

-- Cria a tabela 'Bicicleta' para armazenar informações das bicicletas.    
create table IF NOT EXISTS Bicicleta(
	id_bike 				int primary key auto_increment,
    nome_bike				varchar(45) not null,
    foto_bike				varchar(45) not null,
	localEntr_bike 			varchar(200) not null,
    chassi_bike 			varchar(10) unique,
    estadoConserv_bike 		varchar(15) not null CHECK (estadoConserv_bike IN ('BOM', 'ÓTIMA', 'EXCELENTE')),
    tipo_bike 				varchar(15) not null CHECK (tipo_bike IN ('Urbana', 'Passeio', 'Dobrável', 'Mountain', 'BMX', 'Speed')),
    avaliacao_bike 			float,
    Usuario 				varchar(14)	not null,
    
    -- Definindo as chaves estrangeiras
	foreign key (Usuario) references Usuario(cpfCnpj_user)
);

-- Cria a tabela 'Disponibilidade' para gerenciar a disponibilidade das bicicletas.
create table IF NOT EXISTS Disponibilidade(
	id_disp 				int primary key auto_increment,
	dataHoraIn_disp 		datetime not null,
    dataHoraFim_disp 		datetime not null,
    disponivel_disp 		boolean null,
    Bicicleta 				int not null,
    
    -- Definindo as chaves estrangeiras
    foreign key (Bicicleta) references Bicicleta(id_bike)
);

-- Cria a tabela 'Reserva' para gerenciar as reservas de bicicletas.
create table IF NOT EXISTS Reserva(
	id_reserv 					int primary key auto_increment,
    dataCheckIn_reserv 			datetime not null,
    dataCheckOut_reserv 		datetime not null,
    status_reserv 				varchar(20) not null CHECK (status_reserv IN ('PENDENTE', 'CONFIRMADA', 'NEGADA', 'EM ANDAMENTO', 'FINALIZADA')),
    informada_reserv			boolean not null,
    Usuario 					varchar(14),
    Bicicleta 					int not null,
    
    -- Definindo as chaves estrangeiras
    foreign key (Usuario) references Usuario(cpfCnpj_user),
	foreign key (Bicicleta) references Bicicleta(id_bike)
);

-- Cria a tabela 'Feedback' para registrar avaliações e observações.
create table IF NOT EXISTS Feedback(
	id_feedb 					int primary key auto_increment,
    avaliacaoUser_feedb 		int not null,
    avaliacaoBike_feedb 		int not null,
    obsBike_feedb 				varchar(200),
    obsUser_feedb 				varchar(200),
    data_feedb 					datetime not null,
    confComp_feedb 				boolean not null,
    comunicBoa_feedb 			boolean not null,
	funcional_feedb 			boolean not null,
    manutencao_feedb 			boolean not null,
    Reserva 					int not null,
    avaliado_Usuario 			varchar(14) not null,
    avaliador_Usuario 			varchar(14) not null,
    
    -- Definindo as chaves estrangeiras
    foreign key (Reserva) references Reserva(id_reserv),
	foreign key (avaliado_Usuario) references Usuario(cpfCnpj_user),
	foreign key (avaliador_Usuario) references Usuario(cpfCnpj_user)
);

-- Cria a tabela 'Ranking' para armazenar os pontos dos usuários por localidade.
create table IF NOT EXISTS Ranking(
	id_rank 				int primary key auto_increment,
    cidade_rank 			varchar(100) not null,
    estado_rank 			varchar(2) not null,
    pais_rank 				varchar(45) not null,
    pontos_rank 			float not null,
    pontosSemana_rank 		float not null,
    Usuario 				varchar(15) not null,
    
    -- Definindo as chaves estrangeiras
    foreign key (Usuario) references Usuario(cpfCnpj_user)
);