CREATE DATABASE LOCADORA;


USE LOCADORA;


CREATE TABLE CLIENTE(
      ID_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
      NOME VARCHAR(60) NOT NULL,
      GENERO ENUM('M', 'F'),
      IDADE TINYINT(3) NOT NULL,
      CPF BIGINT(11) UNIQUE NOT NULL,
      CHECK (IDADE <= 100),
      CHECK (CPF <= 99999999999)
);


CREATE TABLE EMAIL_CLIENTE(
      ID_EMAIL_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
      ENDERECO_EMAIL VARCHAR(60),
      ID_CLIENTE INT NOT NULL,
      CONSTRAINT fk_ID_EMAIL_CLIENTE FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE ENDERECO_CLIENTE(
      ID_ENDERECO_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
      LOGRADOURO VARCHAR(60) NOT NULL,
      NUMERO VARCHAR(6) NOT NULL,
      COMPLEMENTO VARCHAR(30),
      BAIRRO VARCHAR(30) NOT NULL,
      CIDADE VARCHAR(30) NOT NULL,
      ESTADO CHAR(2) NOT NULL,
      CEP INT(8) NOT NULL,
      ID_CLIENTE INT NOT NULL,
      CONSTRAINT fk_ID_ENDERECO_CLIENTE FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE) ON DELETE CASCADE ON UPDATE CASCADE,
      CHECK (CEP <= 99999999)
);


CREATE TABLE TELEFONE_CLIENTE(
      ID_TELEFONE_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
      TIPO ENUM('RESIDENCIAL', 'COMERCIAL', 'CELULAR') NOT NULL,
      DDD TINYINT(2) NOT NULL,
      NUMERO BIGINT(11) NOT NULL,
      ID_CLIENTE INT NOT NULL,
      CONSTRAINT fk_ID_TELEFONE_CLIENTE FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE) ON DELETE CASCADE ON UPDATE CASCADE,
      CHECK (DDD <= 99),
      CHECK (NUMERO <= 99999999999)
);


CREATE TABLE FUNCIONARIO(
      ID_FUNCIONARIO INT PRIMARY KEY AUTO_INCREMENT,
      NOME VARCHAR(60) NOT NULL,
      GENERO ENUM('M', 'F'),
      IDADE TINYINT(3) NOT NULL,
      CPF BIGINT(11) UNIQUE NOT NULL,
      CARGO VARCHAR(30) NOT NULL,
      CHECK (IDADE <= 100),
      CHECK (CPF <= 99999999999)
);


CREATE TABLE EMAIL_FUNCIONARIO(
      ID_EMAIL_FUNCIONARIO INT PRIMARY KEY AUTO_INCREMENT,
      ENDERECO_EMAIL VARCHAR(60) UNIQUE NOT NULL,
      ID_FUNCIONARIO INT NOT NULL,
      CONSTRAINT fk_ID_EMAIL_FUNCIONARIO FOREIGN KEY(ID_FUNCIONARIO) REFERENCES FUNCIONARIO(ID_FUNCIONARIO) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE ENDERECO_FUNCIONARIO(
      ID_ENDERECO_FUNCIONARIO INT PRIMARY KEY AUTO_INCREMENT,
      LOGRADOURO VARCHAR(60) NOT NULL,
      NUMERO VARCHAR(6) NOT NULL,
      COMPLEMENTO VARCHAR(30),
      BAIRRO VARCHAR(30) NOT NULL,
      CIDADE VARCHAR(30) NOT NULL,
      ESTADO CHAR(2) NOT NULL,
      CEP INT(8) NOT NULL,
      ID_FUNCIONARIO INT NOT NULL,
      CONSTRAINT fk_ID_ENDERECO_FUNCIONARIO FOREIGN KEY(ID_FUNCIONARIO) REFERENCES FUNCIONARIO(ID_FUNCIONARIO) ON DELETE CASCADE ON UPDATE CASCADE,
      CHECK (CEP <= 99999999)
);


CREATE TABLE TELEFONE_FUNCIONARIO(
      ID_TELEFONE_FUNCIONARIO INT PRIMARY KEY AUTO_INCREMENT,
      TIPO ENUM('RESIDENCIAL', 'COMERCIAL', 'CELULAR') NOT NULL,
      DDD TINYINT(2) NOT NULL,
      NUMERO BIGINT(11) NOT NULL,
      ID_FUNCIONARIO INT NOT NULL,
      CONSTRAINT fk_ID_TELEFONE_FUNCIONARIO FOREIGN KEY(ID_FUNCIONARIO) REFERENCES FUNCIONARIO(ID_FUNCIONARIO) ON DELETE CASCADE ON UPDATE CASCADE,
      CHECK (DDD <= 99),
      CHECK (NUMERO <= 99999999999)
);


CREATE TABLE VEICULO(
      ID_VEICULO INT PRIMARY KEY AUTO_INCREMENT,
      MODELO VARCHAR(20) NOT NULL,
      MONTADORA VARCHAR(20) NOT NULL,
      ANO SMALLINT(4) NOT NULL,
      PLACA VARCHAR(7) NOT NULL,
      CIDADE_ORIGEM VARCHAR(30) NOT NULL,
      ESTADO CHAR(2) NOT NULL,
      VALOR_POR_PERIODO DECIMAL(5, 2) NOT NULL,
      CHECK (
            ANO <= 2200
            AND ANO >= 2010
      )
);


CREATE TABLE ALUGUEL(
      ID_ALUGUEL INT PRIMARY KEY AUTO_INCREMENT,
      PERIODO SMALLINT(3),
      ID_CLIENTE INT NOT NULL,
      CONSTRAINT fk_ID_CLIENTE_ALUGUEL FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE) ON UPDATE CASCADE,
      ID_VEICULO INT NOT NULL,
      CONSTRAINT fk_ID_VEICULO_ALUGUEL FOREIGN KEY(ID_VEICULO) REFERENCES VEICULO(ID_VEICULO) ON UPDATE CASCADE,
      CHECK (PERIODO <= 999)
);


CREATE TABLE MOVIMENTO(
      ID_MOVIMENTO INT PRIMARY KEY AUTO_INCREMENT,
      TIPO ENUM('RETIRADA', 'ENTREGA') NOT NULL,
      DIA DATE NOT NULL,
      HORA TIME NOT NULL,
      ID_ALUGUEL INT NOT NULL,
      CONSTRAINT fk_ID_MOVIMENTO FOREIGN KEY(ID_ALUGUEL) REFERENCES ALUGUEL(ID_ALUGUEL) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE OFICINA(
      ID_OFICINA INT PRIMARY KEY AUTO_INCREMENT,
      NOME VARCHAR(30) NOT NULL
);


CREATE TABLE EMAIL_OFICINA(
      ID_EMAIL_OFICINA INT PRIMARY KEY AUTO_INCREMENT,
      ENDERECO_EMAIL VARCHAR(60) UNIQUE NOT NULL,
      ID_OFICINA INT NOT NULL,
      CONSTRAINT fk_ID_EMAIL_OFICINA FOREIGN KEY(ID_OFICINA) REFERENCES OFICINA(ID_OFICINA) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE ENDERECO_OFICINA(
      ID_ENDERECO_OFICINA INT PRIMARY KEY AUTO_INCREMENT,
      LOGRADOURO VARCHAR(60) NOT NULL,
      NUMERO VARCHAR(5) NOT NULL,
      COMPLEMENTO VARCHAR(30),
      BAIRRO VARCHAR(30) NOT NULL,
      CIDADE VARCHAR(30) NOT NULL,
      ESTADO CHAR(2) NOT NULL,
      CEP INT(8) NOT NULL,
      ID_OFICINA INT UNIQUE NOT NULL,
      CONSTRAINT fk_ID_ENDERECO_OFICINA FOREIGN KEY(ID_OFICINA) REFERENCES OFICINA(ID_OFICINA) ON DELETE CASCADE ON UPDATE CASCADE,
      CHECK (CEP <= 99999999)
);


CREATE TABLE TELEFONE_OFICINA(
      ID_TELEFONE_OFICINA INT PRIMARY KEY AUTO_INCREMENT,
      TIPO ENUM('RESIDENCIAL', 'COMERCIAL', 'CELULAR') NOT NULL,
      DDD TINYINT(2) NOT NULL,
      NUMERO BIGINT(11) UNIQUE NOT NULL,
      ID_OFICINA INT NOT NULL,
      CONSTRAINT fk_ID_TELEFONE_OFICINA FOREIGN KEY(ID_OFICINA) REFERENCES OFICINA(ID_OFICINA) ON DELETE CASCADE ON UPDATE CASCADE,
      CHECK (DDD <= 99),
      CHECK (NUMERO <= 99999999999)
);


CREATE TABLE SERVICO(
      ID_SERVICO INT PRIMARY KEY AUTO_INCREMENT,
      TIPO ENUM('LAVAGEM', 'MANUTENCAO') NOT NULL,
      DIA DATE NOT NULL,
      HORA TIME NOT NULL,
      ID_VEICULO INT NOT NULL,
      CONSTRAINT fk_ID_VEICULO_SERVICO FOREIGN KEY(ID_VEICULO) REFERENCES VEICULO(ID_VEICULO) ON UPDATE CASCADE,
      ID_OFICINA INT NOT NULL,
      CONSTRAINT fk_ID_OFICINA_SERVICO FOREIGN KEY(ID_OFICINA) REFERENCES OFICINA(ID_OFICINA) ON UPDATE CASCADE
);


INSERT INTO CLIENTE
VALUES (
            NULL,
            "Luiz Gustavo Moraes",
            "M",
            35,
            03315189118
      );


INSERT INTO CLIENTE
VALUES (NULL, "Ana Sophia da Mata", "F", 53, 13515313510);


INSERT INTO CLIENTE
VALUES (
            NULL,
            "José Fernando da Luz",
            "M",
            33,
            01513289180
      );


INSERT INTO CLIENTE
VALUES (NULL, "Ian Pacheco Souza", "M", 29, 12310189399);


INSERT INTO CLIENTE
VALUES (
            NULL,
            "Isabella Farias Macedo",
            "F",
            31,
            50355581139
      );


INSERT INTO CLIENTE
VALUES (
            NULL,
            "Pedro Rafael Miguel Campos",
            "M",
            55,
            03234198332
      );


INSERT INTO CLIENTE
VALUES (
            NULL,
            "Jacqueline dos Santos",
            "F",
            34,
            10821500001
      );


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "anasophia@email.com", 2);


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "luizg@email.com", 1);


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "ianps@email.com", 4);


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "josefdaluz@email.com", 3);


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "isabellafmacedo@email.com", 5);


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "prmcampos@email.com", 6);


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "joseluz@gmail.com", 3);


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "lgmoraes@gmail.com", 1);


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "ifm91@gmail.com", 5);


INSERT INTO EMAIL_CLIENTE
VALUES (NULL, "jacab@gmail.com", 7);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'CELULAR', 79, 988012811, 1);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'RESIDENCIAL', 79, 32491815, 1);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'CELULAR', 79, 999510018, 2);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'RESIDENCIAL', 79, 32101510, 5);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'CELULAR', 79, 988011561, 5);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'COMERCIAL', 75, 30012000, 1);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'CELULAR', 79, 999012811, 3);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'COMERCIAL', 79, 20055519, 3);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'CELULAR', 79, 991323300, 4);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'CELULAR', 75, 988010155, 6);


INSERT INTO TELEFONE_CLIENTE
VALUES (NULL, 'CELULAR', 79, 999170299, 7);


INSERT INTO ENDERECO_CLIENTE
VALUES (
            NULL,
            "Rua Porto da Folha",
            "355",
            NULL,
            "Getúlio Vargas",
            "Aracaju",
            "SE",
            "49185016",
            1
      );


INSERT INTO ENDERECO_CLIENTE
VALUES (
            NULL,
            "Avenida Beira Mar",
            "2219",
            NULL,
            "13 de Julho",
            "Aracaju",
            "SE",
            "49735910",
            2
      );


INSERT INTO ENDERECO_CLIENTE
VALUES (
            NULL,
            "Rua Prefeito Horácio Souza Melo",
            "116",
            NULL,
            "Centro",
            "Itabaiana",
            "SE",
            "49500000",
            3
      );


INSERT INTO ENDERECO_CLIENTE
VALUES (
            NULL,
            "Rua Panificador Souza Santos",
            "53",
            NULL,
            "Centro",
            "Lagarto",
            "SE",
            "49400000",
            4
      );


INSERT INTO ENDERECO_CLIENTE
VALUES (
            NULL,
            "Avenida Ayrton Senna",
            "19",
            "Conjunto Eduardo Gomes",
            "Rosa Elze",
            "São Cristóvão",
            "SE",
            "49100000",
            5
      );


INSERT INTO ENDERECO_CLIENTE
VALUES (
            NULL,
            "Rua Major Hunaldo dos Santos",
            "251",
            NULL,
            "Farolândia",
            "Aracaju",
            "SE",
            "49015100",
            6
      );


INSERT INTO ENDERECO_CLIENTE
VALUES (
            NULL,
            "Rua 23",
            "19",
            "Conjunto Laodelino Freire",
            "Novo Horizonte",
            "Lagarto",
            "SE",
            "49400000",
            7
      );


INSERT INTO FUNCIONARIO
VALUES (
            NULL,
            "Amanda de Barros Silva",
            "F",
            25,
            10199981057,
            "Atendente"
      );


INSERT INTO FUNCIONARIO
VALUES (
            NULL,
            "Luiz Marcos Oliveira Silva",
            "M",
            55,
            10678922178,
            "Gerente"
      );


INSERT INTO FUNCIONARIO
VALUES (
            NULL,
            "Mateus Barbosa Ramos",
            "M",
            29,
            35055541014,
            "Auxiliar de frota"
      );


INSERT INTO FUNCIONARIO
VALUES (
            NULL,
            "Rosimeire de Santana",
            "F",
            39,
            29100080819,
            "Analista comercial"
      );


INSERT INTO FUNCIONARIO
VALUES (
            NULL,
            "Renato Fonseca Brito",
            "M",
            21,
            98810019512,
            "Estagiário"
      );


INSERT INTO EMAIL_FUNCIONARIO
VALUES (NULL, "amandabs@email.com", 1);


INSERT INTO EMAIL_FUNCIONARIO
VALUES (NULL, "luizmosilva@email.com", 2);


INSERT INTO EMAIL_FUNCIONARIO
VALUES (NULL, "mateusbr@email.com", 3);


INSERT INTO EMAIL_FUNCIONARIO
VALUES (NULL, "rosimeires@email.com", 4);


INSERT INTO EMAIL_FUNCIONARIO
VALUES (NULL, "rfonsecabrito@email.com", 5);


INSERT INTO TELEFONE_FUNCIONARIO
VALUES (NULL, "CELULAR", 79, 988410990, 1);


INSERT INTO TELEFONE_FUNCIONARIO
VALUES (NULL, "CELULAR", 79, 999599991, 2);


INSERT INTO TELEFONE_FUNCIONARIO
VALUES (NULL, "CELULAR", 79, 981870178, 3);


INSERT INTO TELEFONE_FUNCIONARIO
VALUES (NULL, "CELULAR", 79, 99288911, 4);


INSERT INTO TELEFONE_FUNCIONARIO
VALUES (NULL, "CELULAR", 79, 991982288, 5);


INSERT INTO ENDERECO_FUNCIONARIO
VALUES (
            NULL,
            "Rua Lagarto",
            "156",
            NULL,
            "São José",
            "Aracaju",
            "SE",
            49819100,
            1
      );


INSERT INTO ENDERECO_FUNCIONARIO
VALUES (
            NULL,
            "Avenida Euclides Figueiredo",
            "1456",
            NULL,
            "Santos Dumont",
            "Aracaju",
            "SE",
            49531100,
            2
      );


INSERT INTO ENDERECO_FUNCIONARIO
VALUES (
            NULL,
            "Rua Maruim",
            "27",
            NULL,
            "Centro",
            "Aracaju",
            "SE",
            49813789,
            3
      );


INSERT INTO ENDERECO_FUNCIONARIO
VALUES (
            NULL,
            "Rua Vereador José Carlos Mota",
            "912",
            NULL,
            "Luzia",
            "Aracaju",
            "SE",
            49222400,
            4
      );


INSERT INTO ENDERECO_FUNCIONARIO
VALUES (
            NULL,
            "Rua Alagoas",
            "83",
            NULL,
            "José Conrado de Araújo",
            "Aracaju",
            "SE",
            49119200,
            5
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "HB20",
            "Hyundai",
            2022,
            "LSN4I49",
            "Salvador",
            "BA",
            130.00
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "HB20",
            "Hyundai",
            2022,
            "IAN8O11",
            "Salvador",
            "BA",
            130.00
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "Argo",
            "Fiat",
            2022,
            "IAQ8A13",
            "Aracaju",
            "SE",
            127.50
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "Cronos",
            "Fiat",
            2022,
            "LIA9A88",
            "Aracaju",
            "SE",
            135.00
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "Corolla",
            "Toyota",
            2022,
            "IOA2B88",
            "Salvador",
            "BA",
            250.00
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "Yaris",
            "Toyota",
            2022,
            "QIA2C81",
            "Salvador",
            "BA",
            155.50
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "Fit",
            "Honda",
            2020,
            "OIA9C10",
            "Aracaju",
            "SE",
            142.50
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "Fit",
            "Honda",
            2020,
            "PEA9L19",
            "Salvador",
            "BA",
            142.50
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "208",
            "Peugeot",
            2022,
            "WAC2Z99",
            "Salvador",
            "BA",
            125.00
      );


INSERT INTO VEICULO
VALUES (
            NULL,
            "208",
            "Peugeot",
            2022,
            "OCI4X92",
            "Salvador",
            "BA",
            125.00
      );


INSERT INTO ALUGUEL
VALUES (NULL, 1, 1, 1);


INSERT INTO ALUGUEL
VALUES (NULL, 2, 3, 5);


INSERT INTO ALUGUEL
VALUES (NULL, 3, 2, 10);


INSERT INTO ALUGUEL
VALUES (NULL, 2, 4, 8);


INSERT INTO ALUGUEL
VALUES (NULL, 1, 6, 7);


INSERT INTO ALUGUEL
VALUES (NULL, 1, 5, 4);


INSERT INTO ALUGUEL
VALUES (NULL, 2, 4, 3);


INSERT INTO MOVIMENTO
VALUES (NULL, "RETIRADA", "2022-06-02", "15:10", 1);


INSERT INTO MOVIMENTO
VALUES (NULL, "RETIRADA", "2022-06-02", "09:30", 2);


INSERT INTO MOVIMENTO
VALUES (NULL, "ENTREGA", "2022-06-03", "15:00", 1);


INSERT INTO MOVIMENTO
VALUES (NULL, "ENTREGA", "2022-06-03", "14:00", 2);


INSERT INTO MOVIMENTO
VALUES (NULL, "RETIRADA", "2022-06-02", "15:30", 3);


INSERT INTO MOVIMENTO
VALUES (NULL, "RETIRADA", "2022-06-04", "08:00", 4);


INSERT INTO MOVIMENTO
VALUES (NULL, "ENTREGA", "2022-05-31", "17:30", 3);


INSERT INTO OFICINA
VALUES (NULL, "PORTO SEGURO");


INSERT INTO OFICINA
VALUES (NULL, "TOP CAR AUTO CENTER");


INSERT INTO OFICINA
VALUES (NULL, "AUTO MIX CENTER");


INSERT INTO OFICINA
VALUES (NULL, "WASH CAR");


INSERT INTO OFICINA
VALUES (NULL, "JARDINS LAVAGEM E ESTÉTICA");


INSERT INTO EMAIL_OFICINA
VALUES (NULL, "portosegurooficina@email.com", 1);


INSERT INTO EMAIL_OFICINA
VALUES (NULL, "topcarcenter@email.com", 2);


INSERT INTO EMAIL_OFICINA
VALUES (NULL, "mixcenter@email.com", 3);


INSERT INTO EMAIL_OFICINA
VALUES (NULL, "washcarcenter@email.com", 4);


INSERT INTO EMAIL_OFICINA
VALUES (NULL, "jardinslavagem@email.com", 5);


INSERT INTO TELEFONE_OFICINA
VALUES (NULL, "COMERCIAL", 79, 32115050, 1);


INSERT INTO TELEFONE_OFICINA
VALUES (NULL, "COMERCIAL", 79, 32185151, 2);


INSERT INTO TELEFONE_OFICINA
VALUES (NULL, "COMERCIAL", 79, 32444849, 3);


INSERT INTO TELEFONE_OFICINA
VALUES (NULL, "COMERCIAL", 79, 32355111, 4);


INSERT INTO TELEFONE_OFICINA
VALUES (NULL, "COMERCIAL", 79, 32442929, 5);


INSERT INTO ENDERECO_OFICINA
VALUES (
            NULL,
            "Avenida Heráclito Rollemberg",
            "1038",
            NULL,
            "São Conrado",
            "Aracaju",
            "SE",
            49805350,
            1
      );


INSERT INTO ENDERECO_OFICINA
VALUES (
            NULL,
            "Rua Nestor Sampaio",
            "935",
            NULL,
            "Ponto Novo",
            "Aracaju",
            "SE",
            49153300,
            2
      );


INSERT INTO ENDERECO_OFICINA
VALUES (
            NULL,
            "Rua Francisco Moreira",
            "559",
            NULL,
            "Luzia",
            "Aracaju",
            "SE",
            49329100,
            3
      );


INSERT INTO ENDERECO_OFICINA
VALUES (
            NULL,
            "Avenida Hermes Fontes",
            "1135",
            NULL,
            "Grageru",
            "Aracaju",
            "SE",
            49135398,
            4
      );


INSERT INTO ENDERECO_OFICINA
VALUES (
            NULL,
            "Avenida Ivo do Prado",
            "802",
            NULL,
            "São José",
            "Aracaju",
            "SE",
            49153100,
            5
      );


INSERT INTO SERVICO
VALUES (NULL, "LAVAGEM", "2022-05-27", "16:00", 3, 4);


INSERT INTO SERVICO
VALUES (NULL, "LAVAGEM", "2022-05-28", "11:00", 5, 5);


INSERT INTO SERVICO
VALUES (NULL, "LAVAGEM", "2022-05-25", "11:00", 2, 5);


INSERT INTO SERVICO
VALUES (NULL, "MANUTENCAO", "2022-05-30", "09:00", 4, 3);


INSERT INTO SERVICO
VALUES (NULL, "MANUTENCAO", "2022-05-24", "16:00", 1, 2);


INSERT INTO SERVICO
VALUES (NULL, "MANUTENCAO", "2022-05-24", "16:00", 2, 2);


CREATE USER atendente @localhost IDENTIFIED BY '1234';


GRANT SELECT,
      INSERT,
      UPDATE ON LOCADORA.ALUGUEL TO atendente @localhost;


GRANT SELECT (ID_CLIENTE, NOME, CPF),
      INSERT (ID_CLIENTE, NOME, CPF),
      UPDATE (ID_CLIENTE, NOME, CPF) ON LOCADORA.CLIENTE TO atendente @localhost;


GRANT SELECT,
      INSERT,
      UPDATE ON LOCADORA.EMAIL_CLIENTE TO atendente @localhost;


GRANT SELECT,
      INSERT,
      UPDATE ON LOCADORA.TELEFONE_CLIENTE TO atendente @localhost;


GRANT SELECT,
      INSERT,
      UPDATE ON LOCADORA.MOVIMENTO TO atendente @localhost;


GRANT SELECT (
            ID_VEICULO,
            MODELO,
            MONTADORA,
            ANO,
            PLACA,
            VALOR_POR_PERIODO
      ),
      INSERT (
            ID_VEICULO,
            MODELO,
            MONTADORA,
            ANO,
            PLACA,
            VALOR_POR_PERIODO
      ),
      UPDATE (
            ID_VEICULO,
            MODELO,
            MONTADORA,
            ANO,
            PLACA,
            VALOR_POR_PERIODO
      ) ON LOCADORA.VEICULO TO atendente @localhost;


CREATE USER gerente IDENTIFIED BY '1234';


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.* TO gerente;


CREATE USER auxiliar_frota IDENTIFIED BY '1234';


GRANT SELECT ON LOCADORA.ALUGUEL TO auxiliar_frota;


GRANT SELECT (ID_CLIENTE, NOME, CPF) ON LOCADORA.CLIENTE TO auxiliar_frota;


GRANT SELECT ON LOCADORA.EMAIL_CLIENTE TO auxiliar_frota;


GRANT SELECT ON LOCADORA.TELEFONE_CLIENTE TO auxiliar_frota;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.VEICULO TO auxiliar_frota;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.MOVIMENTO TO auxiliar_frota;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.SERVICO TO auxiliar_frota;


GRANT SELECT ON LOCADORA.OFICINA TO auxiliar_frota;


GRANT SELECT ON LOCADORA.TELEFONE_OFICINA TO auxiliar_frota;


GRANT SELECT ON LOCADORA.EMAIL_OFICINA TO auxiliar_frota;


GRANT SELECT ON LOCADORA.ENDERECO_OFICINA TO auxiliar_frota;


CREATE USER analista_comercial @localhost IDENTIFIED BY '1234';


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.ALUGUEL TO analista_comercial @localhost;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.CLIENTE TO analista_comercial @localhost;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.EMAIL_CLIENTE TO analista_comercial @localhost;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.ENDERECO_CLIENTE TO analista_comercial @localhost;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.TELEFONE_CLIENTE TO analista_comercial @localhost;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.MOVIMENTO TO analista_comercial @localhost;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.SERVICO TO analista_comercial @localhost;


GRANT SELECT ON LOCADORA.VEICULO TO analista_comercial @localhost;


GRANT SELECT,
      INSERT,
      UPDATE,
      DELETE ON LOCADORA.MOVIMENTO TO analista_comercial @localhost;


CREATE USER estagiario @localhost IDENTIFIED BY '1234';


GRANT SELECT (NOME, CPF) ON LOCADORA.CLIENTE TO estagiario @localhost;


GRANT SELECT (ENDERECO_EMAIL, ID_CLIENTE) ON LOCADORA.EMAIL_CLIENTE TO estagiario @localhost;


GRANT SELECT (
            LOGRADOURO,
            NUMERO,
            COMPLEMENTO,
            BAIRRO,
            CIDADE,
            ESTADO,
            CEP,
            ID_CLIENTE
      ) ON LOCADORA.ENDERECO_CLIENTE TO estagiario @localhost;


GRANT SELECT (TIPO, DDD, NUMERO, ID_CLIENTE) ON LOCADORA.TELEFONE_CLIENTE TO estagiario @localhost;


GRANT SELECT (PERIODO, ID_CLIENTE, ID_VEICULO) ON LOCADORA.ALUGUEL TO estagiario @localhost;


GRANT SELECT (
            MODELO,
            MONTADORA,
            ANO,
            PLACA,
            CIDADE_ORIGEM,
            ESTADO,
            VALOR_POR_PERIODO
      ) ON LOCADORA.VEICULO TO estagiario @localhost;


GRANT SELECT (TIPO, DIA, HORA, ID_ALUGUEL) ON LOCADORA.MOVIMENTO TO estagiario @localhost;


GRANT SELECT (TIPO, DIA, HORA, ID_VEICULO, ID_OFICINA) ON LOCADORA.SERVICO TO estagiario @localhost;


GRANT SELECT (NOME) ON LOCADORA.OFICINA TO estagiario @localhost;


GRANT SELECT (ENDERECO_EMAIL, ID_OFICINA) ON LOCADORA.EMAIL_OFICINA TO estagiario @localhost;


GRANT SELECT (
            LOGRADOURO,
            NUMERO,
            COMPLEMENTO,
            BAIRRO,
            CIDADE,
            ESTADO,
            CEP,
            ID_OFICINA
      ) ON LOCADORA.ENDERECO_OFICINA TO estagiario @localhost;


GRANT SELECT (TIPO, DDD, NUMERO, ID_OFICINA) ON LOCADORA.TELEFONE_OFICINA TO estagiario @localhost;
