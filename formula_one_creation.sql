DROP DATABASE formula_one;

CREATE DATABASE formula_one;

USE formula_one;

-- SELECT * FROM formula_one;

CREATE TABLE Campeonato (
    ID_Campeonato INTEGER PRIMARY KEY,
    Ano DATE,
    Informacaoes VARCHAR(50)
);

CREATE TABLE Pilotos (
    ID_Pilotos INTEGER PRIMARY KEY,
    Nome_piloto VARCHAR(50),
    Equipe VARCHAR(50),
    Pontos INTEGER,
    Salario DECIMAL
);

CREATE TABLE Equipes (
    Nome_Equipe VARCHAR(50) PRIMARY KEY,
    Piloto_1 INTEGER,
    Piloto_2 INTEGER,
    Carro VARCHAR(50),
    FOREIGN KEY (Piloto_1) REFERENCES Pilotos(ID_Pilotos),
    FOREIGN KEY (Piloto_2) REFERENCES Pilotos(ID_Pilotos),
    CHECK (Piloto_1 <> Piloto_2)
);

CREATE TABLE Piloto_campeonato (
    Piloto_no_campeonato VARCHAR(50) PRIMARY KEY,
    Campeonato VARCHAR(50),
    Pilotos VARCHAR(50),
    ID_Campeonato INTEGER,
    ID_Pilotos INTEGER,
    FOREIGN KEY (ID_Campeonato) REFERENCES campeonato(ID_Campeonato),
    FOREIGN KEY (ID_Pilotos) REFERENCES Pilotos(ID_Pilotos)
);

CREATE TABLE Fabricante_de_motores (
    ID_fabricante_motor INTEGER PRIMARY KEY,
    About_we VARCHAR(50)
);

-- ALTER TABLE FabricanteDeCarros ADD COLUMN 

CREATE TABLE FabricanteDeCarros (
Nome_fabricante VARCHAR(50),
    ID_fabricante_motor INTEGER PRIMARY KEY,
    ID_carro INTEGER
    
);
CREATE TABLE Motor (
    ID_motor INTEGER PRIMARY KEY,
    Especificacoes VARCHAR(50),
    Fabricante VARCHAR(50),
    ID_fabricante INTEGER,
    FOREIGN KEY (ID_fabricante) REFERENCES Fabricante_de_motores(ID_fabricante_motor)
);

CREATE TABLE Carros (
    ID_carro INTEGER PRIMARY KEY,
    Especificacoes VARCHAR(50),
    Fabricante INT,
    ID_motor INTEGER,
    FOREIGN KEY (ID_motor) REFERENCES Motor(ID_motor),
    FOREIGN KEY (Fabricante) REFERENCES FabricanteDeCarros(ID_fabricante_motor)
);

CREATE TABLE Corridas (
    ID_Corrida INTEGER PRIMARY KEY,
    Localidade VARCHAR(50),
    Autodromo VARCHAR(50),
    Tempo VARCHAR(50),
    Volta_rapida decimal,
    Primeiro VARCHAR(50),
    Segundo VARCHAR(50),
    Terceiro VARCHAR(50),
    Quarto VARCHAR(50),
    Quinto VARCHAR(50),
    Sexto VARCHAR(50),
    Setmo VARCHAR(50),
    Oitavo VARCHAR(50),
    Nono VARCHAR(50),
    Decimo VARCHAR(50),
    Championship INTEGER,
    FOREIGN KEY (Championship) REFERENCES Campeonato(ID_Campeonato)
);

CREATE TABLE Classificacao (
    Championship INTEGER PRIMARY KEY,
    Primeiro VARCHAR(50),
    Segundo VARCHAR(50),
    Terceiro VARCHAR(50),
    Quarto VARCHAR(50),
    Quinto VARCHAR(50),
    Sexto VARCHAR(50),
    Setimo VARCHAR(50),
    Oitavo VARCHAR(50),
    Nono VARCHAR(50),
    Decimo VARCHAR(50),
    FOREIGN KEY (Championship) REFERENCES Campeonato(ID_Campeonato)
);

CREATE TABLE Equipe_campeonato (
    Equipe_no_campeonato VARCHAR(50) PRIMARY KEY,
    Campeonato VARCHAR(50),
    Equipe VARCHAR(50),
    ID_Campeonato INTEGER,
    FOREIGN KEY (Equipe_no_campeonato) REFERENCES Equipes(Nome_Equipe),
    FOREIGN KEY (ID_Campeonato) REFERENCES Campeonato(ID_Campeonato)
);

CREATE TABLE Participam (
    Equipe VARCHAR(50),
    ID_Corrida INTEGER
);
ALTER TABLE Participam ADD CONSTRAINT FK_Participam_1
    FOREIGN KEY (Equipe) REFERENCES Equipes (Nome_Equipe) ON DELETE RESTRICT;
ALTER TABLE Participam ADD CONSTRAINT FK_Participam_2
    FOREIGN KEY (ID_Corrida) REFERENCES Corridas (ID_Corrida) ON DELETE SET NULL;

CREATE TABLE estao (
    ID_Pilotos INTEGER,
    Campeonato INTEGER
);
ALTER TABLE estao ADD CONSTRAINT FK_estao_1
    FOREIGN KEY (ID_Pilotos) REFERENCES Pilotos (ID_Pilotos) ON DELETE SET NULL;
ALTER TABLE estao ADD CONSTRAINT FK_estao_2
    FOREIGN KEY (Campeonato) REFERENCES Classificacao (Championship) ON DELETE SET NULL;

CREATE TABLE tem (
    Equipe VARCHAR(50),
    ID_carro INTEGER
);
ALTER TABLE tem ADD CONSTRAINT FK_tem_1
    FOREIGN KEY (Equipe) REFERENCES Equipes (Nome_Equipe) ON DELETE SET NULL;
ALTER TABLE tem ADD CONSTRAINT FK_tem_2
    FOREIGN KEY (ID_carro) REFERENCES Carros (ID_carro) ON DELETE SET NULL;
    

 

 