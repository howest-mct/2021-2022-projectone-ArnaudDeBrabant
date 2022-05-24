-- MySQL dump 10.13  Distrib 5.7.37, for Win64 (x86_64)
--
-- Host: localhost    Database: projectOne
-- ------------------------------------------------------
-- Server version	5.5.5-10.5.15-MariaDB-0+deb11u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acties`
--

DROP TABLE IF EXISTS `acties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acties` (
  `ActieID` int(11) NOT NULL,
  `Actiebeschrijving` varchar(145) DEFAULT NULL,
  PRIMARY KEY (`ActieID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acties`
--

LOCK TABLES `acties` WRITE;
/*!40000 ALTER TABLE `acties` DISABLE KEYS */;
INSERT INTO `acties` VALUES (1,'snelheid'),(2,'wachtwoord'),(3,'0/1'),(4,'count'),(5,'RGB');
/*!40000 ALTER TABLE `acties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `DeviceID` int(11) NOT NULL,
  `Naam` varchar(45) DEFAULT NULL,
  `Merk` varchar(45) DEFAULT NULL,
  `beschrijving` varchar(150) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `Aankoopkost` int(11) DEFAULT NULL,
  `Meeteenheid` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`DeviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,'GY-521 (MPU-6050)','null','accelerometer','sensor',5,'km/h'),(2,'RFID-RC522-v2','null','null','sensor',5,'null'),(3,'RGB Strip LED','null','null','actuator',15,'null'),(4,'KY-002 Vibration Switch Module','null','telt aantal keren jongleren','sensor',2,'count'),(5,'MOSFET-NCHANNEL','null','null','actuator',3,'null');
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gebruiker`
--

DROP TABLE IF EXISTS `gebruiker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gebruiker` (
  `gebruikersID` int(11) NOT NULL,
  `Naam` varchar(45) DEFAULT NULL,
  `leeftijd` varchar(45) DEFAULT NULL,
  `wachtwoord` varchar(45) DEFAULT NULL,
  `laatst_ingelogd` date DEFAULT NULL,
  `RFID_tag` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`gebruikersID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gebruiker`
--

LOCK TABLES `gebruiker` WRITE;
/*!40000 ALTER TABLE `gebruiker` DISABLE KEYS */;
/*!40000 ALTER TABLE `gebruiker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historiek`
--

DROP TABLE IF EXISTS `historiek`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historiek` (
  `historiekID` int(11) NOT NULL,
  `Actiedatum` date DEFAULT NULL,
  `waarde` float DEFAULT NULL,
  `commentaar` varchar(160) DEFAULT NULL,
  `DeviceID` int(11) NOT NULL,
  `ActieID` int(11) NOT NULL,
  PRIMARY KEY (`historiekID`,`DeviceID`,`ActieID`),
  KEY `fk_historiek_Device_idx` (`DeviceID`),
  KEY `fk_historiek_Acties1_idx` (`ActieID`),
  CONSTRAINT `fk_historiek_Acties1` FOREIGN KEY (`ActieID`) REFERENCES `acties` (`ActieID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_historiek_Device` FOREIGN KEY (`DeviceID`) REFERENCES `device` (`DeviceID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historiek`
--

LOCK TABLES `historiek` WRITE;
/*!40000 ALTER TABLE `historiek` DISABLE KEYS */;
INSERT INTO `historiek` VALUES (1,'2022-05-23',21.89,'lorum ipsum',4,4),(2,'2022-05-24',105.63,'lorum ipsum',4,4),(3,'2022-05-25',70.1,'lorum ipsum',4,4),(4,'2022-05-26',94.64,'lorum ipsum',4,4),(5,'2022-05-27',39.35,'lorum ipsum',4,4),(6,'2022-05-28',104.29,'lorum ipsum',4,4),(7,'2022-05-29',18.1,'lorum ipsum',4,4),(8,'2022-05-30',33.39,'lorum ipsum',4,4),(9,'2022-05-31',92.66,'lorum ipsum',4,4),(10,'2022-06-01',42.43,'lorum ipsum',4,4),(11,'2022-06-02',64.83,'lorum ipsum',4,4),(12,'2022-06-03',100.01,'lorum ipsum',4,4),(13,'2022-06-04',46.39,'lorum ipsum',4,4),(14,'2022-06-05',3.6,'lorum ipsum',1,1),(15,'2022-06-06',66.11,'lorum ipsum',1,1),(16,'2022-06-07',51.94,'lorum ipsum',1,1),(17,'2022-06-08',21.21,'lorum ipsum',1,1),(18,'2022-06-09',35.3,'lorum ipsum',1,1),(19,'2022-06-10',54.97,'lorum ipsum',1,1),(20,'2022-06-11',11.19,'lorum ipsum',1,1),(21,'2022-06-12',74.64,'lorum ipsum',1,1),(22,'2022-06-13',74.86,'lorum ipsum',1,1),(23,'2022-06-14',2.9,'lorum ipsum',1,1),(24,'2022-06-15',49.34,'lorum ipsum',1,1),(25,'2022-06-16',70.59,'lorum ipsum',1,1),(26,'2022-06-17',15.93,'lorum ipsum',1,1),(27,'2022-06-18',31.74,'lorum ipsum',1,1),(28,'2022-06-19',13.65,'lorum ipsum',1,1),(29,'2022-06-20',40.62,'lorum ipsum',1,1),(30,'2022-06-21',43.52,'lorum ipsum',1,1),(31,'2022-06-22',97.51,'lorum ipsum',1,1),(32,'2022-06-23',70.85,'lorum ipsum',1,1),(33,'2022-06-24',69,'lorum ipsum',1,1),(34,'2022-06-25',107.09,'lorum ipsum',1,1),(35,'2022-06-26',110.71,'lorum ipsum',1,1),(36,'2022-06-27',75.73,'lorum ipsum',1,1),(37,'2022-06-28',22.01,'lorum ipsum',1,1),(38,'2022-06-29',76.19,'lorum ipsum',1,1),(39,'2022-06-30',16.54,'lorum ipsum',1,1),(40,'2022-07-01',48,'lorum ipsum',1,1),(41,'2022-07-02',19.52,'lorum ipsum',1,1),(42,'2022-07-03',108.25,'lorum ipsum',1,1),(43,'2022-07-04',43.19,'lorum ipsum',1,1),(44,'2022-07-05',60.76,'lorum ipsum',1,1),(45,'2022-07-06',41.78,'lorum ipsum',1,1),(46,'2022-07-07',24.75,'lorum ipsum',1,1),(47,'2022-07-08',17.81,'lorum ipsum',4,4),(48,'2022-07-09',35.65,'lorum ipsum',4,4),(49,'2022-07-10',26.79,'lorum ipsum',4,4),(50,'2022-07-11',2.15,'lorum ipsum',4,4);
/*!40000 ALTER TABLE `historiek` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `record` (
  `highscore` int(11) NOT NULL,
  `snelheid_snelheid_metingID` int(11) NOT NULL,
  `gebruiker_gebruikersID` int(11) NOT NULL,
  `score_scoreID` int(11) NOT NULL,
  PRIMARY KEY (`highscore`,`snelheid_snelheid_metingID`,`gebruiker_gebruikersID`,`score_scoreID`),
  KEY `fk_record_snelheid1_idx` (`snelheid_snelheid_metingID`),
  KEY `fk_record_gebruiker1_idx` (`gebruiker_gebruikersID`),
  KEY `fk_record_score1_idx` (`score_scoreID`),
  CONSTRAINT `fk_record_gebruiker1` FOREIGN KEY (`gebruiker_gebruikersID`) REFERENCES `gebruiker` (`gebruikersID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_record_score1` FOREIGN KEY (`score_scoreID`) REFERENCES `score` (`scoreID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_record_snelheid1` FOREIGN KEY (`snelheid_snelheid_metingID`) REFERENCES `snelheid` (`snelheid_metingID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record`
--

LOCK TABLES `record` WRITE;
/*!40000 ALTER TABLE `record` DISABLE KEYS */;
/*!40000 ALTER TABLE `record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `score`
--

DROP TABLE IF EXISTS `score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `score` (
  `scoreID` int(11) NOT NULL,
  `aantal` int(11) DEFAULT NULL,
  `gebruikersID` int(11) NOT NULL,
  PRIMARY KEY (`scoreID`,`gebruikersID`),
  KEY `fk_score_gebruiker1_idx` (`gebruikersID`),
  CONSTRAINT `fk_score_gebruiker1` FOREIGN KEY (`gebruikersID`) REFERENCES `gebruiker` (`gebruikersID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score`
--

LOCK TABLES `score` WRITE;
/*!40000 ALTER TABLE `score` DISABLE KEYS */;
/*!40000 ALTER TABLE `score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snelheid`
--

DROP TABLE IF EXISTS `snelheid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snelheid` (
  `snelheid_metingID` int(11) NOT NULL,
  `meting` int(11) DEFAULT NULL,
  `gebruiker_gebruikersID` int(11) NOT NULL,
  PRIMARY KEY (`snelheid_metingID`,`gebruiker_gebruikersID`),
  KEY `fk_snelheid_gebruiker1_idx` (`gebruiker_gebruikersID`),
  CONSTRAINT `fk_snelheid_gebruiker1` FOREIGN KEY (`gebruiker_gebruikersID`) REFERENCES `gebruiker` (`gebruikersID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snelheid`
--

LOCK TABLES `snelheid` WRITE;
/*!40000 ALTER TABLE `snelheid` DISABLE KEYS */;
/*!40000 ALTER TABLE `snelheid` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-24 10:41:45
