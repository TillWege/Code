-- Active: 1666860366437@@127.0.0.1@3306@Übung

Use Übung;

CREATE TABLE
    ausbildungsberuf(
        beruf_id INT PRIMARY KEY AUTO_INCREMENT,
        berufsbezeichnung VARCHAR(40) NOT NULL UNIQUE,
        dauer_jahr NUMERIC(3, 1) NOT NULL,
        CONSTRAINT check_berufbeteichnung CHECK (
            berufsbezeichnung IN ('XX', 'XY', 'YY')
        )
    );

INSERT into ausbildungsberuf values (12, 'XX', 2);

CREATE TABLE
    adresse (
        adresse_id INT PRIMARY KEY,
        strasse VARCHAR(40) NOT NULL,
        nummer VARCHAR(5) NOT NULL,
        plz VARCHAR(5) NOT NULL,
        ort VARCHAR(40) NOT NULL
    );

CREATE TABLE
    lehrfach (
        lehrfach_id INT PRIMARY KEY,
        lehrfachbezeichnung CHAR(40) NOT NULL
    );

CREATE TABLE
    ausbilder (
        ausbilder_id INT PRIMARY KEY,
        name CHAR(40) NOT NULL,
        vorname CHAR(40) NOT NULL
    );

CREATE TABLE
    auszubildende (
        aus_id INT AUTO_INCREMENT,
        name CHAR(40) NOT NULL,
        vorname CHAR(40) NOT NULL,
        geburtsdatum DATE,
        beruf_id INT NOT NULL,
        adresse_id INT NOT NULL,
        ausbilder_id INT NOT NULL,
        PRIMARY KEY (aus_id),
        FOREIGN KEY (beruf_id) REFERENCES ausbildungsberuf(beruf_id),
        FOREIGN KEY (adresse_id) REFERENCES adresse(adresse_id),
        FOREIGN KEY (ausbilder_id) REFERENCES ausbilder(ausbilder_id)
    );

CREATE TABLE
    ausbildungsberuf_lehrfach (
        beruf_id INT NOT NULL,
        lehrfach_id INT NOT NULL,
        PRIMARY KEY (beruf_id, lehrfach_id),
        FOREIGN KEY (beruf_id) REFERENCES ausbildungsberuf(beruf_id),
        FOREIGN KEY (lehrfach_id) REFERENCES lehrfach(lehrfach_id)
    )