CREATE DATABASE  IF NOT EXISTS `projectOne` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `projectOne`;
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
  `Beschrijving` varchar(150) DEFAULT NULL,
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
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gebruiker`
--

DROP TABLE IF EXISTS `gebruiker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gebruiker` (
  `gebruikersID` int(11) NOT NULL AUTO_INCREMENT,
  `Naam` varchar(45) DEFAULT NULL,
  `RFID_tag` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`gebruikersID`),
  UNIQUE KEY `RFID_tag_UNIQUE` (`RFID_tag`)
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gebruiker`
--

LOCK TABLES `gebruiker` WRITE;
/*!40000 ALTER TABLE `gebruiker` DISABLE KEYS */;
INSERT INTO `gebruiker` VALUES (2,'pimylifeup                                   ','947283367991'),(4,'Arnaud                                       ','563188400644'),(5,'Laat u website ke zien                       ','192942590415'),(107,'Lily                                         ','384896101681');
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
  `DeviceID` int(11) DEFAULT NULL,
  `ActieID` int(11) DEFAULT NULL,
  PRIMARY KEY (`historiekID`),
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
/*!40000 ALTER TABLE `historiek` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `score`
--

DROP TABLE IF EXISTS `score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `score` (
  `scoreID` int(11) NOT NULL AUTO_INCREMENT,
  `waarde` int(11) DEFAULT NULL,
  `tijdstip` datetime DEFAULT NULL,
  `gebruikersID` int(11) NOT NULL,
  PRIMARY KEY (`scoreID`),
  KEY `fk_score_gebruiker1_idx` (`gebruikersID`),
  CONSTRAINT `fk_score_gebruiker1` FOREIGN KEY (`gebruikersID`) REFERENCES `gebruiker` (`gebruikersID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score`
--

LOCK TABLES `score` WRITE;
/*!40000 ALTER TABLE `score` DISABLE KEYS */;
INSERT INTO `score` VALUES (1,13,'2022-06-14 15:07:32',2),(2,3,'2022-06-14 17:16:42',2),(3,3,'2022-06-17 10:27:44',2),(4,4,'2022-06-17 10:34:39',2),(5,24,'2022-06-17 13:29:05',2),(6,11,'2022-06-19 17:55:16',2);
/*!40000 ALTER TABLE `score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `versnelling`
--

DROP TABLE IF EXISTS `versnelling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `versnelling` (
  `versnellingID` int(11) NOT NULL AUTO_INCREMENT,
  `x-meting` float DEFAULT NULL,
  `y-meting` float DEFAULT NULL,
  `z-meting` float DEFAULT NULL,
  `totaal_versnelling` float DEFAULT NULL,
  `tijdstip` datetime DEFAULT NULL,
  `gebruikersID` int(11) NOT NULL,
  PRIMARY KEY (`versnellingID`),
  KEY `gebruikersID_idx` (`gebruikersID`),
  CONSTRAINT `gebruikersID` FOREIGN KEY (`gebruikersID`) REFERENCES `gebruiker` (`gebruikersID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `versnelling`
--

LOCK TABLES `versnelling` WRITE;
/*!40000 ALTER TABLE `versnelling` DISABLE KEYS */;
INSERT INTO `versnelling` VALUES (1,0.17,0.79,-10.67,0.07,'2022-06-14 15:10:28',2),(2,0.6,0.02,-10.69,0.01,'2022-06-15 14:37:50',2),(3,1.04,0.32,-10.68,0.17,'2022-06-15 14:37:57',2),(4,0.51,0.83,-10.74,0.21,'2022-06-15 14:38:00',2),(5,0.51,0.06,-10.7,0.01,'2022-06-15 14:41:10',2),(6,0.51,0.17,-10.68,0.04,'2022-06-15 14:41:12',2),(7,0.47,1.99,-10.77,0.47,'2022-06-15 14:41:17',2),(8,0.6,0.03,-10.71,0.01,'2022-06-15 14:43:39',2),(9,0.56,0.44,-10.63,0.12,'2022-06-15 14:43:41',2),(10,1.34,1.11,-10.68,0.74,'2022-06-15 14:43:43',2),(11,0.26,0.98,10.03,0.13,'2022-06-16 10:34:41',2),(12,-0.16,-6.14,7.03,0.49,'2022-06-16 10:34:49',2),(13,-2.84,-3.73,7.13,5.31,'2022-06-16 10:34:50',2),(14,3.78,3.41,5.29,6.44,'2022-06-16 10:35:01',2),(15,-3.03,-9.56,0.08,14.47,'2022-06-16 10:35:59',2),(16,0.24,9.76,0.53,1.19,'2022-06-17 09:55:06',2),(17,2.56,-3.78,7.53,4.83,'2022-06-17 09:55:10',2),(18,-2.48,-3.94,8.15,4.88,'2022-06-17 09:55:11',2),(19,-2.22,-4.42,7.78,4.9,'2022-06-17 09:55:13',2),(20,-6.57,-13.22,8.95,43.47,'2022-06-17 09:55:14',2),(21,2.42,6.79,-7.58,8.2,'2022-06-17 09:56:10',2),(22,2.57,6.68,-7.47,8.59,'2022-06-17 09:56:11',2),(23,9.09,2.12,-4.77,9.63,'2022-06-17 09:56:13',2),(24,5.85,9.73,-4.74,28.47,'2022-06-17 09:56:15',2),(25,10.14,0.1,-2,0.49,'2022-06-17 10:01:28',2),(26,7.37,3.35,-7.2,12.35,'2022-06-17 10:01:29',2),(27,3.78,9.15,-1.46,17.28,'2022-06-17 10:01:47',2),(28,4.1,0.35,-10.46,0.72,'2022-06-17 10:04:29',2),(29,-0.66,-1.39,-11.24,0.46,'2022-06-17 10:07:34',2),(30,2.76,0.42,-10.38,0.58,'2022-06-17 13:24:41',2),(31,2.76,0.43,-10.39,0.59,'2022-06-17 13:24:42',2),(32,2.78,0.41,-10.38,0.58,'2022-06-17 13:26:54',2),(33,2.79,0.43,-10.37,0.6,'2022-06-17 13:27:04',2),(34,3.89,1.58,-9.78,3.07,'2022-06-17 13:27:30',2),(35,8.6,1.77,-7.94,7.63,'2022-06-17 13:27:33',2),(36,4.94,4.95,-17.87,12.23,'2022-06-17 13:27:38',2),(37,2.2,0.17,-10.5,0.19,'2022-06-17 15:43:24',2),(38,2.19,0.18,-10.51,0.2,'2022-06-17 15:43:30',2),(39,2.2,0.2,-10.5,0.22,'2022-06-17 15:44:23',2),(40,2.19,0.17,-10.5,0.18,'2022-06-17 15:45:47',2),(41,2.19,0.17,-10.51,0.19,'2022-06-17 15:45:48',2),(42,2.19,0.18,-10.5,0.19,'2022-06-17 15:47:22',2),(43,2.18,0.16,-10.5,0.17,'2022-06-17 15:50:21',2),(44,2.19,0.17,-10.5,0.18,'2022-06-17 15:50:25',2),(45,2.19,0.17,-10.5,0.19,'2022-06-17 15:50:32',2),(46,2.19,0.15,-10.49,0.17,'2022-06-17 15:53:59',2),(47,2.19,0.17,-10.48,0.18,'2022-06-17 15:54:00',2),(48,2.2,0.17,-10.5,0.19,'2022-06-17 15:54:07',2),(49,2.19,0.16,-10.5,0.17,'2022-06-17 15:54:34',2),(50,2.2,0.16,-10.49,0.18,'2022-06-17 15:54:38',2),(51,2.19,0.17,-10.51,0.19,'2022-06-17 15:54:50',2),(52,2.5,0.7,-10.28,0.88,'2022-06-17 15:55:32',2),(53,4.66,0.9,-9.34,2.1,'2022-06-17 16:21:58',2),(54,-0.81,-9.98,-1,4.04,'2022-06-19 17:54:35',2),(55,-0.85,-9.99,-1.06,4.26,'2022-06-19 17:54:37',2),(56,-1.65,-8.76,0.08,7.22,'2022-06-19 17:54:38',2),(57,6.58,7.56,1.3,24.88,'2022-06-19 17:55:48',2),(58,7.79,6.58,0.08,25.61,'2022-06-19 17:55:51',2),(59,-0.09,-9.65,1.39,0.44,'2022-06-19 18:18:45',2),(60,-2.61,-9.65,-0.38,12.61,'2022-06-19 18:18:50',2),(61,2.86,9.4,0.72,13.45,'2022-06-19 18:19:14',2);
/*!40000 ALTER TABLE `versnelling` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-20 14:29:11
