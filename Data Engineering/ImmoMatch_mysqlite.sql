-- -----------------------------------------------------
-- Table `Anrede`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Anrede`;

CREATE TABLE IF NOT EXISTS `Anrede` (
  `idAnrede` INT NOT NULL,
  `Anrede` VARCHAR(20) NULL,
  PRIMARY KEY (`idAnrede`));



-- -----------------------------------------------------
-- Table `Kontaktarten`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Kontaktarten`;

CREATE TABLE IF NOT EXISTS `Kontaktarten` (
  `idKontaktarten` INT NOT NULL,
  `Art` VARCHAR(45) NULL,
  PRIMARY KEY (`idKontaktarten`));



-- -----------------------------------------------------
-- Table `Kundentypen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Kundentypen`;

CREATE TABLE IF NOT EXISTS `Kundentypen` (
  `idKundentypen` INT NOT NULL,
  `Typ` VARCHAR(65) NULL,
  PRIMARY KEY (`idKundentypen`));



-- -----------------------------------------------------
-- Table `DataSources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DataSources`;

CREATE TABLE IF NOT EXISTS `DataSources` (
  `idDataSources` INT NOT NULL,
  `Source` VARCHAR(65) NULL,
  PRIMARY KEY (`idDataSources`));



-- -----------------------------------------------------
-- Table `Kunden`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Kunden`;

CREATE TABLE IF NOT EXISTS `Kunden` (
  `idKunden` INT NOT NULL,
  `DataSources_id` INT NOT NULL,
  `Data_Load` DATETIME NULL,
  `Anrede_id` INT NOT NULL,
  `Firmenname` VARCHAR(65) NULL,
  `Titel` VARCHAR(45) NULL,
  `Vorname` VARCHAR(45) NULL,
  `Nachname` VARCHAR(45) NULL,
  `Strasse` VARCHAR(45) NULL,
  `Hausnummer` VARCHAR(25) NULL,
  `Plz` VARCHAR(25) NULL,
  `Ort` VARCHAR(65) NULL,
  `Telfon geschaeftlich` VARCHAR(25) NULL,
  `Telefon privat` VARCHAR(25) NULL,
  `Telefon mobil` VARCHAR(25) NULL,
  `Fax` VARCHAR(25) NULL,
  `eMail` VARCHAR(65) NULL,
  `sonstige Bemerkungen` VARCHAR(500) NULL,
  `KontaktwunschDatZeit` VARCHAR(500) NULL,
  `Kontaktarten_id` INT NULL,
  `Kundentypen_id` INT NOT NULL,
  PRIMARY KEY (`idKunden`),
  CONSTRAINT `fk_Kunden_Anrede1`
    FOREIGN KEY (`Anrede_id`)
    REFERENCES `Anrede` (`idAnrede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kunden_Kontaktarten1`
    FOREIGN KEY (`Kontaktarten_id`)
    REFERENCES `Kontaktarten` (`idKontaktarten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kunden_Kundentypen1`
    FOREIGN KEY (`Kundentypen_id`)
    REFERENCES `Kundentypen` (`idKundentypen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kunden_DataSources1`
    FOREIGN KEY (`DataSources_id`)
    REFERENCES `DataSources` (`idDataSources`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Kaeufer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Kaeufer`;

CREATE TABLE IF NOT EXISTS `Kaeufer` (
  `idKunden` INT NOT NULL,
  `aktiv_suchend` TINYINT NULL,
  PRIMARY KEY (`idKunden`),
  CONSTRAINT `fk_Kaeufer_Kunden1`
    FOREIGN KEY (`idKunden`)
    REFERENCES `Kunden` (`idKunden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Verkaeufer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Verkaeufer`;

CREATE TABLE IF NOT EXISTS `Verkaeufer` (
  `idKunden` INT NOT NULL,
  PRIMARY KEY (`idKunden`),
  CONSTRAINT `fk_Verkaeufer_Kunden`
    FOREIGN KEY (`idKunden`)
    REFERENCES `Kunden` (`idKunden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Objektarten`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Objektarten`;

CREATE TABLE IF NOT EXISTS `Objektarten` (
  `idObjektarten` INT NOT NULL,
  `Typ` VARCHAR(45) NULL,
  PRIMARY KEY (`idObjektarten`));



-- -----------------------------------------------------
-- Table `Lagen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Lagen`;

CREATE TABLE IF NOT EXISTS `Lagen` (
  `idLagen` INT NOT NULL,
  `Plz` VARCHAR(25) NULL,
  `Ort` VARCHAR(65) NULL,
  `Lage` VARCHAR(65) NULL,
  PRIMARY KEY (`idLagen`));



-- -----------------------------------------------------
-- Table `Exposes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Exposes`;

CREATE TABLE IF NOT EXISTS `Exposes` (
  `idExposes` INT NOT NULL,
  `Dateipfad` VARCHAR(255) NULL,
  PRIMARY KEY (`idExposes`));



-- -----------------------------------------------------
-- Table `Objekte`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Objekte`;

CREATE TABLE IF NOT EXISTS `Objekte` (
  `idObjekte` INT NOT NULL,
  `Verkaeufer_id` INT NOT NULL,
  `Objektarten_id` INT NOT NULL,
  `Lagen_id` INT NOT NULL,
  `Data_Load` DATETIME NULL,
  `Mindestpreis` DECIMAL(11,2) NULL,
  `Zimmeranzahl` INT NULL,
  `Groesse_in_qm` INT NULL,
  `Bemerkung` VARCHAR(500) NULL,
  `Strasse` VARCHAR(45) NULL,
  `Hausnummer` VARCHAR(25) NULL,
  `Exposes_id` INT NOT NULL,
  `aktuell` TINYINT NULL,
  `verkauft` TINYINT NULL,
  PRIMARY KEY (`idObjekte`),
  CONSTRAINT `fk_Objekte_Verkaeufer1`
    FOREIGN KEY (`Verkaeufer_id`)
    REFERENCES `Verkaeufer` (`idKunden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Objekte_Objektarten1`
    FOREIGN KEY (`Objektarten_id`)
    REFERENCES `Objektarten` (`idObjektarten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Objekte_Lagen1`
    FOREIGN KEY (`Lagen_id`)
    REFERENCES `Lagen` (`idLagen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Objekte_Exposes1`
    FOREIGN KEY (`Exposes_id`)
    REFERENCES `Exposes` (`idExposes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Mitarbeiter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mitarbeiter`;

CREATE TABLE IF NOT EXISTS `Mitarbeiter` (
  `idMitarbeiter` INT NOT NULL,
  `Vornamen` VARCHAR(45) NULL,
  `Nachnamen` VARCHAR(45) NULL,
  PRIMARY KEY (`idMitarbeiter`));



-- -----------------------------------------------------
-- Table `KaufBeteiligteArten`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KaufBeteiligteArten`;

CREATE TABLE IF NOT EXISTS `KaufBeteiligteArten` (
  `idKaufBeteiligteArten` INT NOT NULL,
  `Art` VARCHAR(65) NULL,
  PRIMARY KEY (`idKaufBeteiligteArten`));



-- -----------------------------------------------------
-- Table `KaufBeteiligte`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KaufBeteiligte`;

CREATE TABLE IF NOT EXISTS `KaufBeteiligte` (
  `idKaufBeteiligte` INT NOT NULL,
  `KaufBeteiligteArten_id` INT NOT NULL,
  `Firmenname` VARCHAR(65) NULL,
  `Anrede_id` INT NOT NULL,
  `Titel` VARCHAR(45) NULL,
  `Vorname` VARCHAR(45) NULL,
  `Nachname` VARCHAR(45) NULL,
  `Strasse` VARCHAR(45) NULL,
  `Hausnummer` VARCHAR(25) NULL,
  `Plz` VARCHAR(25) NULL,
  `Ort` VARCHAR(65) NULL,
  ` Telefon geschaeftlich` VARCHAR(25) NULL,
  `Telefon privat` VARCHAR(25) NULL,
  `Telefon mobil` VARCHAR(25) NULL,
  `Fax` VARCHAR(25) NULL,
  `eMail` VARCHAR(65) NULL,
  `Bemerkung` VARCHAR(500) NULL,
  PRIMARY KEY (`idKaufBeteiligte`),
  CONSTRAINT `fk_KaufBeteiligte_KaufBeteiligteArten1`
    FOREIGN KEY (`KaufBeteiligteArten_id`)
    REFERENCES `KaufBeteiligteArten` (`idKaufBeteiligteArten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_KaufBeteiligte_Anrede1`
    FOREIGN KEY (`Anrede_id`)
    REFERENCES `Anrede` (`idAnrede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Besichtigungen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Besichtigungen`;

CREATE TABLE IF NOT EXISTS `Besichtigungen` (
  `idBesichtigungen` INT NOT NULL,
  `Objekte_id` INT NOT NULL,
  `Mitarbeiter_id` INT NOT NULL,
  `Kaeufer_id` INT NOT NULL,
  `Datum_Uhrzeit` DATETIME NULL,
  `stattgefunden` TINYINT NULL,
  PRIMARY KEY (`idBesichtigungen`),
  CONSTRAINT `fk_Besichtigungen_Objekte1`
    FOREIGN KEY (`Objekte_id`)
    REFERENCES `Objekte` (`idObjekte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Besichtigungen_Mitarbeiter1`
    FOREIGN KEY (`Mitarbeiter_id`)
    REFERENCES `Mitarbeiter` (`idMitarbeiter`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Besichtigungen_Kaeufer1`
    FOREIGN KEY (`Kaeufer_id`)
    REFERENCES `Kaeufer` (`idKunden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Kaeuferwuensche`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Kaeuferwuensche`;

CREATE TABLE IF NOT EXISTS `Kaeuferwuensche` (
  `idKaeuferwuensche` INT NOT NULL,
  `Objektarten_id` INT NOT NULL,
  `Kaeufer_id` INT NOT NULL,
  `Zimmeranzahl` INT NULL,
  `PreisMin` DECIMAL(11,2) NULL,
  `PreisMax` DECIMAL(11,2) NULL,
  `Groesse_in_qm` INT NULL,
  `Bemerkung` VARCHAR(500) NULL,
  `Datum` DATETIME NULL,
  PRIMARY KEY (`idKaeuferwuensche`),
  CONSTRAINT `fk_Kundenwuensche_Objektarten1`
    FOREIGN KEY (`Objektarten_id`)
    REFERENCES `Objektarten` (`idObjektarten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kundenwuensche_Kaeufer1`
    FOREIGN KEY (`Kaeufer_id`)
    REFERENCES `Kaeufer` (`idKunden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Kaeuferwuensche_Lagen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Kaeuferwuensche_Lagen`;

CREATE TABLE IF NOT EXISTS `Kaeuferwuensche_Lagen` (
  `idKaeuferwuensche` INT NOT NULL,
  `idLagen` INT NOT NULL,
  PRIMARY KEY (`idKaeuferwuensche`, `idLagen`),
  CONSTRAINT `fk_Kundenwuensche_has_Lagen_Kundenwuensche1`
    FOREIGN KEY (`idKaeuferwuensche`)
    REFERENCES `Kaeuferwuensche` (`idKaeuferwuensche`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kundenwuensche_has_Lagen_Lagen1`
    FOREIGN KEY (`idLagen`)
    REFERENCES `Lagen` (`idLagen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Aktionstypen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Aktionstypen`;

CREATE TABLE IF NOT EXISTS `Aktionstypen` (
  `idAktionstypen` INT NOT NULL,
  `Typ` VARCHAR(45) NULL,
  PRIMARY KEY (`idAktionstypen`));



-- -----------------------------------------------------
-- Table `Kundenkontakt_Protokolle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Kundenkontakt_Protokolle`;

CREATE TABLE IF NOT EXISTS `Kundenkontakt_Protokolle` (
  `idKundenkontakt_Protokolle` INT NOT NULL,
  `Kunde_id` INT NOT NULL,
  `Mitarbeiter_id` INT NOT NULL,
  `Kontaktarten_id` INT NOT NULL,
  `Aktionstypen_id` INT NOT NULL,
  `ist_Verkauefer` TINYINT NULL,
  `Datum` DATETIME NULL,
  `Bermerkung` VARCHAR(500) NULL,
  PRIMARY KEY (`idKundenkontakt_Protokolle`),
  CONSTRAINT `fk_Kunden_has_Mitarbeiter_Kunden1`
    FOREIGN KEY (`Kunde_id`)
    REFERENCES `Kunden` (`idKunden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kunden_has_Mitarbeiter_Mitarbeiter1`
    FOREIGN KEY (`Mitarbeiter_id`)
    REFERENCES `Mitarbeiter` (`idMitarbeiter`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kundenkontakte_Kontaktarten1`
    FOREIGN KEY (`Kontaktarten_id`)
    REFERENCES `Kontaktarten` (`idKontaktarten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kundenkontakt_Protokolle_Aktionstypen1`
    FOREIGN KEY (`Aktionstypen_id`)
    REFERENCES `Aktionstypen` (`idAktionstypen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Kaeufer_Exposes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Kaeufer_Exposes`;

CREATE TABLE IF NOT EXISTS `Kaeufer_Exposes` (
  `idKaeufer_Exposescol` INT NOT NULL,
  `Kaeufer_id` INT NOT NULL,
  `Exposes_id` INT NOT NULL,
  `Mitarbeiter_id` INT NOT NULL,
  `Kontaktarten_id` INT NOT NULL,
  `Datum` DATETIME NULL,
  PRIMARY KEY (`idKaeufer_Exposescol`),
  CONSTRAINT `fk_Kaeufer_has_Exposes_Kaeufer1`
    FOREIGN KEY (`Kaeufer_id`)
    REFERENCES `Kaeufer` (`idKunden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kaeufer_has_Exposes_Exposes1`
    FOREIGN KEY (`Exposes_id`)
    REFERENCES `Exposes` (`idExposes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kaeufer_Exposes_Mitarbeiter1`
    FOREIGN KEY (`Mitarbeiter_id`)
    REFERENCES `Mitarbeiter` (`idMitarbeiter`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kaeufer_Exposes_Kontaktarten1`
    FOREIGN KEY (`Kontaktarten_id`)
    REFERENCES `Kontaktarten` (`idKontaktarten`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Verkaeufe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Verkaeufe`;

CREATE TABLE IF NOT EXISTS `Verkaeufe` (
  `idVerkaeufe` INT NOT NULL,
  `Objekte_id` INT NOT NULL,
  `Kaeufer_id` INT NOT NULL,
  `Mitarbeiter_id` INT NOT NULL,
  `Verkaufsendpreis` DECIMAL(11,2) NULL,
  `Notartermin` DATETIME NULL,
  `Kauftermin` DATETIME NULL,
  `Provision_in_Pronzent` DECIMAL(3,2) NULL,
  PRIMARY KEY (`idVerkaeufe`),
  CONSTRAINT `fk_Kaeufer_has_Objekte_Kaeufer1`
    FOREIGN KEY (`Kaeufer_id`)
    REFERENCES `Kaeufer` (`idKunden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kaeufer_has_Objekte_Objekte1`
    FOREIGN KEY (`Objekte_id`)
    REFERENCES `Objekte` (`idObjekte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kaeufe_Mitarbeiter1`
    FOREIGN KEY (`Mitarbeiter_id`)
    REFERENCES `Mitarbeiter` (`idMitarbeiter`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `Kaeufe_KaufBeteiligte`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Kaeufe_KaufBeteiligte`;

CREATE TABLE IF NOT EXISTS `Kaeufe_KaufBeteiligte` (
  `Kaeufe_id` INT NOT NULL,
  `KaufBeteiligte_id` INT NOT NULL,
  PRIMARY KEY (`Kaeufe_id`, `KaufBeteiligte_id`),
  CONSTRAINT `fk_Kaeufe_has_KaufBeteiligte_Kaeufe1`
    FOREIGN KEY (`Kaeufe_id`)
    REFERENCES `Verkaeufe` (`idVerkaeufe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kaeufe_has_KaufBeteiligte_KaufBeteiligte1`
    FOREIGN KEY (`KaufBeteiligte_id`)
    REFERENCES `KaufBeteiligte` (`idKaufBeteiligte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `KaeuferLeadDatas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KaeuferLeadDatas`;

CREATE TABLE IF NOT EXISTS `KaeuferLeadDatas` (
  `idKunden_KLead_Datas` INT NOT NULL,
  `Data_Source` VARCHAR(65) NULL,
  `DS_LoadDate` DATETIME NULL,
  `Kontaktdatum` DATETIME NULL,
  `Kontaktversuche_Anzahl` INT NULL,
  `Kunden_id` INT NULL,
  `Daten_unbrauchbar` TINYINT NULL,
  `Anrede` VARCHAR(45) NULL,
  `Firmenname` VARCHAR(65) NULL,
  `Vorname` VARCHAR(45) NULL,
  `Nachname` VARCHAR(45) NULL,
  `Strasse` VARCHAR(45) NULL,
  `Hausnummer` VARCHAR(45) NULL,
  `Plz` VARCHAR(45) NULL,
  `Ort` VARCHAR(45) NULL,
  `Telfonnummer` VARCHAR(45) NULL,
  `eMail` VARCHAR(45) NULL,
  `Art des Objektes` VARCHAR(45) NULL,
  `Preisvorstellung_Min` DECIMAL(11,2) NULL,
  `Preisvorstellung_Max` DECIMAL(11,2) NULL,
  `Groesse_in_qm` INT NULL,
  `Ort_Objekt` VARCHAR(45) NULL,
  `Zimmeranzahl` VARCHAR(45) NULL,
  `sonstige Bemerkungen` VARCHAR(500) NULL,
  PRIMARY KEY (`idKunden_KLead_Datas`));



-- -----------------------------------------------------
-- Table `Lead_Exposes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Lead_Exposes`;

CREATE TABLE IF NOT EXISTS `Lead_Exposes` (
  `idLead_Exposes` INT NOT NULL,
  `Dateipfad` VARCHAR(255) NULL,
  PRIMARY KEY (`idLead_Exposes`));



-- -----------------------------------------------------
-- Table `VerkaeuferLeadDatas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VerkaeuferLeadDatas`;

CREATE TABLE IF NOT EXISTS `VerkaeuferLeadDatas` (
  `idKunden_VLead_Datas` INT NOT NULL,
  `Data_Source` VARCHAR(45) NULL,
  `DS_LoadDate` DATETIME NULL,
  `Kontaktversuche_Anzahl` INT NULL,
  `Kunden_id` INT NULL,
  `Daten_unbrauchbar` TINYINT NULL,
  `Kontaktdatum` DATETIME NULL,
  `Firmenname` VARCHAR(45) NULL,
  `Anrede` VARCHAR(45) NULL,
  `Vorname` VARCHAR(45) NULL,
  `Nachname` VARCHAR(45) NULL,
  `Strasse` VARCHAR(45) NULL,
  `Hausnummer` VARCHAR(45) NULL,
  `Plz` VARCHAR(45) NULL,
  `Ort` VARCHAR(45) NULL,
  `Telfonnummer` VARCHAR(45) NULL,
  `eMail` VARCHAR(45) NULL,
  `Art des Objektes` VARCHAR(45) NULL,
  `Preisvorstellung_Min` DECIMAL(11,2) NULL,
  `Groesse_in_qm` INT NULL,
  `Ort_des_Objekts` VARCHAR(65) NULL,
  `Lage_des_Objekts` VARCHAR(65) NULL,
  `Zimmeranzahl` INT NULL,
  `sonstige Bemerkungen` VARCHAR(500) NULL,
  `Lead_Exposes_id` INT NULL,
  PRIMARY KEY (`idKunden_VLead_Datas`),
  CONSTRAINT `fk_VerkaeuferLeadDatas_Lead_Exposes1`
    FOREIGN KEY (`Lead_Exposes_id`)
    REFERENCES `Lead_Exposes` (`idLead_Exposes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Data for table `Anrede`
-- -----------------------------------------------------
INSERT INTO `Anrede` (`idAnrede`, `Anrede`) VALUES (1, 'Frau');
INSERT INTO `Anrede` (`idAnrede`, `Anrede`) VALUES (2, 'Herr');
INSERT INTO `Anrede` (`idAnrede`, `Anrede`) VALUES (3, 'Firma');


-- -----------------------------------------------------
-- Data for table `Kontaktarten`
-- -----------------------------------------------------
INSERT INTO `Kontaktarten` (`idKontaktarten`, `Art`) VALUES (1, 'telefonisch');
INSERT INTO `Kontaktarten` (`idKontaktarten`, `Art`) VALUES (2, 'eMail');
INSERT INTO `Kontaktarten` (`idKontaktarten`, `Art`) VALUES (3, 'WhatsApp');


-- -----------------------------------------------------
-- Data for table `Kundentypen`
-- -----------------------------------------------------
INSERT INTO `Kundentypen` (`idKundentypen`, `Typ`) VALUES (1, 'Privat');
INSERT INTO `Kundentypen` (`idKundentypen`, `Typ`) VALUES (2, 'Makler');
INSERT INTO `Kundentypen` (`idKundentypen`, `Typ`) VALUES (3, 'Bautraeger');


-- -----------------------------------------------------
-- Data for table `DataSources`
-- -----------------------------------------------------
INSERT INTO `DataSources` (`idDataSources`, `Source`) VALUES (1, 'Internetformular');
INSERT INTO `DataSources` (`idDataSources`, `Source`) VALUES (2, 'Telefonanruf');
INSERT INTO `DataSources` (`idDataSources`, `Source`) VALUES (3, 'Lead1');
INSERT INTO `DataSources` (`idDataSources`, `Source`) VALUES (4, 'Lead2');
INSERT INTO `DataSources` (`idDataSources`, `Source`) VALUES (5, 'Lead3');


-- -----------------------------------------------------
-- Data for table `Objektarten`
-- -----------------------------------------------------
INSERT INTO `Objektarten` (`idObjektarten`, `Typ`) VALUES (1, '1 FH');
INSERT INTO `Objektarten` (`idObjektarten`, `Typ`) VALUES (2, '2-3 FH');
INSERT INTO `Objektarten` (`idObjektarten`, `Typ`) VALUES (3, 'MFH');
INSERT INTO `Objektarten` (`idObjektarten`, `Typ`) VALUES (4, 'Gewerbe');
INSERT INTO `Objektarten` (`idObjektarten`, `Typ`) VALUES (5, 'Wohnung');
INSERT INTO `Objektarten` (`idObjektarten`, `Typ`) VALUES (6, 'Loft');


-- -----------------------------------------------------
-- Data for table `KaufBeteiligteArten`
-- -----------------------------------------------------
INSERT INTO `KaufBeteiligteArten` (`idKaufBeteiligteArten`, `Art`) VALUES (1, 'Notar');
INSERT INTO `KaufBeteiligteArten` (`idKaufBeteiligteArten`, `Art`) VALUES (2, 'Rechtsanwalt');
INSERT INTO `KaufBeteiligteArten` (`idKaufBeteiligteArten`, `Art`) VALUES (3, 'Objektteilbesitzer');


-- -----------------------------------------------------
-- Data for table `Aktionstypen`
-- -----------------------------------------------------
INSERT INTO `Aktionstypen` (`idAktionstypen`, `Typ`) VALUES (1, 'Anfrage');
INSERT INTO `Aktionstypen` (`idAktionstypen`, `Typ`) VALUES (2, 'Aufnahme als Kunde');
INSERT INTO `Aktionstypen` (`idAktionstypen`, `Typ`) VALUES (3, 'Expose Anfrage');
INSERT INTO `Aktionstypen` (`idAktionstypen`, `Typ`) VALUES (4, 'Terminanfrage');

