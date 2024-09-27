/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.18-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: AdamsDator.local    Database: eshop
-- ------------------------------------------------------
-- Server version	11.4.0-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bild`
--

DROP TABLE IF EXISTS `bild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bild` (
  `id` varchar(45) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bild_produkt1_idx` (`produkt_id`),
  CONSTRAINT `fk_bild_produkt1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bild`
--

LOCK TABLES `bild` WRITE;
/*!40000 ALTER TABLE `bild` DISABLE KEYS */;
/*!40000 ALTER TABLE `bild` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faktura`
--

DROP TABLE IF EXISTS `faktura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faktura` (
  `id` int(11) NOT NULL,
  `kund` varchar(40) DEFAULT NULL,
  `totalbelopp` int(11) DEFAULT NULL,
  `kund_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_faktura_kund1_idx` (`kund_id`),
  CONSTRAINT `fk_faktura_kund1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura`
--

LOCK TABLES `faktura` WRITE;
/*!40000 ALTER TABLE `faktura` DISABLE KEYS */;
/*!40000 ALTER TABLE `faktura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fakturaprodukt`
--

DROP TABLE IF EXISTS `fakturaprodukt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fakturaprodukt` (
  `faktura_id` int(11) NOT NULL,
  `produktradpris` int(11) DEFAULT NULL,
  `antal` int(6) DEFAULT NULL,
  `produkt_id` int(11) NOT NULL,
  PRIMARY KEY (`faktura_id`),
  KEY `fk_fakturaprodukt_faktura1_idx` (`faktura_id`),
  KEY `fk_fakturaprodukt_produkt1_idx` (`produkt_id`),
  CONSTRAINT `fk_fakturaprodukt_faktura1` FOREIGN KEY (`faktura_id`) REFERENCES `faktura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fakturaprodukt_produkt1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fakturaprodukt`
--

LOCK TABLES `fakturaprodukt` WRITE;
/*!40000 ALTER TABLE `fakturaprodukt` DISABLE KEYS */;
/*!40000 ALTER TABLE `fakturaprodukt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategori` (
  `typ` char(20) NOT NULL,
  PRIMARY KEY (`typ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori`
--

LOCK TABLES `kategori` WRITE;
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` VALUES ('Kaffe'),('Kaffebryggare'),('Kaffekopp'),('Te'),('Trepack'),('Tvåpack');
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategoriprodukt`
--

DROP TABLE IF EXISTS `kategoriprodukt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategoriprodukt` (
  `produkt_id` int(11) NOT NULL,
  `kategori_typ` char(20) NOT NULL,
  KEY `fk_kategoriprodukt_kategori1_idx` (`kategori_typ`),
  KEY `fk_kategoriprodukt_produkt1_idx` (`produkt_id`),
  CONSTRAINT `fk_kategoriprodukt_kategori1` FOREIGN KEY (`kategori_typ`) REFERENCES `kategori` (`typ`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_kategoriprodukt_produkt1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategoriprodukt`
--

LOCK TABLES `kategoriprodukt` WRITE;
/*!40000 ALTER TABLE `kategoriprodukt` DISABLE KEYS */;
INSERT INTO `kategoriprodukt` VALUES (1,'Kaffe'),(2,'Kaffe'),(3,'Kaffe'),(4,'Kaffe'),(5,'Te'),(6,'Te'),(7,'Kaffekopp'),(8,'Kaffekopp'),(9,'Kaffebryggare'),(10,'Kaffebryggare'),(11,'Kaffebryggare'),(12,'Tvåpack'),(12,'Kaffe'),(12,'Te'),(13,'Tvåpack'),(13,'Kaffe'),(13,'Kaffekopp'),(14,'Trepack'),(14,'Kaffebryggare'),(14,'Kaffe'),(14,'Kaffekopp');
/*!40000 ALTER TABLE `kategoriprodukt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `namn` varchar(40) DEFAULT NULL,
  `address` varchar(40) DEFAULT NULL,
  `telefon` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_namn` (`namn`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES (1,'Adam Larsson','Blåportsgatan 2B','0703804851'),(2,'Jonas Larsson','Gröna Ängar 12A','0739876543'),(3,'Linn Larsson','Bergvägen 89','0724567890'),(4,'Ella Larsson','Havsutsikten 3B','0763215432'),(5,'Cecilia Larsson','Skogsgläntan 27','0791122334'),(6,'Gunnel Larsson','Stjärngatan 14','0744455678'),(7,'Östen Larsson','Lönnvägen 45','0719987654'),(8,'Birgitta Karlsson','Kullerstensvägen 8','0783456789'),(9,'Harald Karlsson','Mjölnargatan 22C','0758765432'),(10,'Mattias Rubensson','Sjöviksvägen 19','0702345678'),(11,'Magnus Trulsson','Fyrvägen 12','0736789012'),(12,'Maria Andersson','Rosenstigen 6A','0765432109'),(13,'Anna Kvist','Ekhagsvägen 55B','0718129300');
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lager`
--

DROP TABLE IF EXISTS `lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lager` (
  `hylla` int(3) NOT NULL,
  `antal` int(6) DEFAULT NULL,
  PRIMARY KEY (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lager`
--

LOCK TABLES `lager` WRITE;
/*!40000 ALTER TABLE `lager` DISABLE KEYS */;
INSERT INTO `lager` VALUES (1,317),(2,230),(3,82),(4,104),(5,68);
/*!40000 ALTER TABLE `lager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lagerhylla`
--

DROP TABLE IF EXISTS `lagerhylla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lagerhylla` (
  `hylla` int(3) NOT NULL,
  `antal` int(6) DEFAULT NULL,
  `produkt_id` int(11) NOT NULL,
  KEY `fk_lagerhylla_lager1_idx` (`hylla`),
  KEY `fk_lagerhylla_produkt1_idx` (`produkt_id`),
  CONSTRAINT `fk_lagerhylla_lager1` FOREIGN KEY (`hylla`) REFERENCES `lager` (`hylla`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_lagerhylla_produkt1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lagerhylla`
--

LOCK TABLES `lagerhylla` WRITE;
/*!40000 ALTER TABLE `lagerhylla` DISABLE KEYS */;
INSERT INTO `lagerhylla` VALUES (1,151,1),(1,71,2),(1,95,3),(2,109,4),(2,73,5),(2,48,6),(3,44,7),(3,38,8),(4,26,9),(4,37,10),(4,41,11),(5,28,12),(5,22,13),(5,18,14);
/*!40000 ALTER TABLE `lagerhylla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logg`
--

DROP TABLE IF EXISTS `logg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `when` timestamp NULL DEFAULT current_timestamp(),
  `handelse` varchar(200) DEFAULT NULL,
  `produkt_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
INSERT INTO `logg` VALUES (1,'2024-08-29 21:59:17','ny produkt skapas',1),(2,'2024-08-29 21:59:17','ny produkt skapas',2),(3,'2024-08-29 21:59:17','ny produkt skapas',3),(4,'2024-08-29 21:59:17','ny produkt skapas',4),(5,'2024-08-29 21:59:17','ny produkt skapas',5),(6,'2024-08-29 21:59:17','ny produkt skapas',6),(7,'2024-08-29 21:59:17','ny produkt skapas',7),(8,'2024-08-29 21:59:17','ny produkt skapas',8),(9,'2024-08-29 21:59:17','ny produkt skapas',9),(10,'2024-08-29 21:59:17','ny produkt skapas',10),(11,'2024-08-29 21:59:17','ny produkt skapas',11),(12,'2024-08-29 21:59:17','ny produkt skapas',12),(13,'2024-08-29 21:59:17','ny produkt skapas',13),(14,'2024-08-29 21:59:17','ny produkt skapas',14);
/*!40000 ALTER TABLE `logg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skapad_datum` timestamp NULL DEFAULT current_timestamp(),
  `uppdaterad_datum` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `raderad_datum` timestamp NULL DEFAULT NULL,
  `bestalld_datum` timestamp NULL DEFAULT NULL,
  `skickad_datum` timestamp NULL DEFAULT NULL,
  `kund_id` int(11) NOT NULL,
  `totalbelopp` int(11) DEFAULT NULL,
  `antal` int(3) DEFAULT NULL,
  `status` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_kund1_idx` (`kund_id`),
  CONSTRAINT `fk_order_kund1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2024-08-29 21:59:17',NULL,NULL,NULL,NULL,1,11322,49,'Skapad'),(2,'2024-08-29 21:59:17',NULL,NULL,NULL,NULL,5,180,4,'Beställd'),(3,'2024-08-29 21:59:17',NULL,NULL,NULL,NULL,7,113,2,'Skickad');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`%`*/ /*!50003 TRIGGER soft_delete
BEFORE UPDATE
ON `order` FOR EACH ROW
BEGIN
  IF NEW.status = "Raderad" THEN
    SET NEW.raderad_datum = CURRENT_TIMESTAMP;
  ELSE
    SET NEW.uppdaterad_datum = CURRENT_TIMESTAMP;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orderprodukt`
--

DROP TABLE IF EXISTS `orderprodukt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderprodukt` (
  `order_id` int(11) NOT NULL,
  `antal` int(3) DEFAULT NULL,
  `pris` int(11) DEFAULT NULL,
  `hylla` int(3) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  KEY `fk_orderprodukt_lager1_idx` (`hylla`),
  KEY `fk_orderprodukt_order1_idx` (`order_id`),
  KEY `fk_orderprodukt_produkt1_idx` (`produkt_id`),
  CONSTRAINT `fk_orderprodukt_lager1` FOREIGN KEY (`hylla`) REFERENCES `lager` (`hylla`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderprodukt_order1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderprodukt_produkt1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderprodukt`
--

LOCK TABLES `orderprodukt` WRITE;
/*!40000 ALTER TABLE `orderprodukt` DISABLE KEYS */;
INSERT INTO `orderprodukt` VALUES (1,1,54,1,1),(1,2,108,1,2),(1,4,192,1,3),(1,6,150,3,7),(1,18,1476,5,12),(1,18,9342,5,14),(2,2,108,1,1),(2,1,49,2,5),(2,1,23,3,8),(3,2,108,1,1),(3,1,49,2,5),(3,1,23,3,8);
/*!40000 ALTER TABLE `orderprodukt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt`
--

DROP TABLE IF EXISTS `produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produkt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `pris` int(11) DEFAULT NULL,
  `farg` varchar(40) DEFAULT NULL,
  `material` varchar(40) DEFAULT NULL,
  `beskrivning` varchar(255) DEFAULT NULL,
  `kategori_typ` char(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt`
--

LOCK TABLES `produkt` WRITE;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` VALUES (1,'Gevalia mellanrost',54,'Röd förpackning','Plastförpackning','Tillverkas vid Jacobs Douwe Egberts kafferosteri på Alderholmen i Gävle.',''),(2,'Gevalia mörkrost',54,'Mörkröd förpackning','Plastförpackning','Tillverkas vid Jacobs Douwe Egberts kafferosteri på Alderholmen i Gävle.',''),(3,'Skånerost',48,'Grön förpackning','Papper och plastförpackning','Zoégas Skånerost är ett mörkrostat kaffe med en stor och fyllig doft med inslag av jord, nöt och svarta vinbär.',''),(4,'Arvid Nordquist Mellanrost',52,'Brun förpackning','Plastförpackning','Arvid Nordquist HAB är en kaffeproducent och nordiskt sälj- och marknadsföringsbolag',''),(5,'Lipton vanilj',49,'Orange förpackning','Pappersförpackning','Lipton är ett företag som säljer te-produkter. Det grundades av skotten Thomas Lipton.',''),(6,'Lipton citron',49,'Orange förpackning','Pappersförpackning','Lipton är ett företag som säljer te-produkter. Det grundades av skotten Thomas Lipton.',''),(7,'3dl kaffekopp',25,'Vit','Porslin','Kaffekopp från IKEA.',''),(8,'2dl kaffekopp',23,'Genomskinlig','Glas','Kaffekopp från IKEA.',''),(9,'Melitta kaffebryggare',319,'Svart','Plast','Brygg den perfekta koppen kaffe med Melitta Easy II kaffebryggare 21871 som är enkel att manövrera.',''),(10,'Phillips kaffebryggare',447,'Silver','Plast','Stilren kaffebryggare med 15 koppars kapacitet.',''),(11,'Moccamaster kaffebryggare',2649,'Svart','Metall','Starta dagen med en härlig kopp nybryggt kaffe från Moccamaster Automatic, eller varför inte bjuda över vännerna på en trevlig fika.',''),(12,'Kaffe och Te',82,'Blandat','Plastförpackningar','En tesort och en kaffesort.',''),(13,'Kaffe med kaffekopp',65,'Blandat','Plastförpackning och porslin','Ett paket kaffe med kaffekopp.',''),(14,'Kaffebryggare, kaffe och kaffekopp',519,'Blandat','Plast, plastförpackning och porslin','Paket med kaffebryggare, kaffeförpackning och kaffekopp.','');
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`%`*/ /*!50003 TRIGGER insert_produkt
AFTER INSERT
ON produkt FOR EACH ROW
BEGIN
    INSERT INTO logg
        (`handelse`, `produkt_id`)
    VALUES
        ('ny produkt skapas', NEW.id)
    ;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dbadm`@`%`*/ /*!50003 TRIGGER update_produkt
AFTER UPDATE
ON produkt FOR EACH ROW
BEGIN
    INSERT INTO logg
        (`handelse`, `produkt_id`)
    VALUES
        ('produkt updateras', NEW.id)
    ;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produktbild`
--

DROP TABLE IF EXISTS `produktbild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produktbild` (
  `bild_id` varchar(45) NOT NULL,
  `objekt` char(20) DEFAULT NULL,
  `text` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`bild_id`),
  KEY `fk_produktbild_bild1_idx` (`bild_id`),
  CONSTRAINT `fk_produktbild_bild1` FOREIGN KEY (`bild_id`) REFERENCES `bild` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produktbild`
--

LOCK TABLES `produktbild` WRITE;
/*!40000 ALTER TABLE `produktbild` DISABLE KEYS */;
/*!40000 ALTER TABLE `produktbild` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produktkund`
--

DROP TABLE IF EXISTS `produktkund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produktkund` (
  `kund_id` int(11) NOT NULL,
  `produkt_id` int(11) NOT NULL,
  PRIMARY KEY (`kund_id`),
  KEY `fk_produktkund_produkt1_idx` (`produkt_id`),
  KEY `fk_produktkund_kund1_idx` (`kund_id`),
  CONSTRAINT `fk_produktkund_kund1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_produktkund_produkt1` FOREIGN KEY (`produkt_id`) REFERENCES `produkt` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produktkund`
--

LOCK TABLES `produktkund` WRITE;
/*!40000 ALTER TABLE `produktkund` DISABLE KEYS */;
/*!40000 ALTER TABLE `produktkund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'eshop'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_var` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` FUNCTION `get_var`(to_get VARCHAR(40),
  a_where VARCHAR(40)
) RETURNS int(11)
    DETERMINISTIC
BEGIN
  DECLARE result INT;

  IF to_get = 'pris' THEN
    SELECT pris INTO result
      FROM produkt
    WHERE
      id = a_where;
  ELSEIF to_get = 'hylla' THEN
    SELECT hylla INTO result
      FROM lagerhylla
    WHERE
      produkt_id = a_where
    LIMIT 1;
  ELSEIF to_get = 'produkt' THEN
    SELECT id INTO result
      FROM produkt
    WHERE
      name = a_where;
  END IF;

  RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP FUNCTION IF EXISTS `order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` FUNCTION `order_status`(skapad TIMESTAMP,
  uppdaterad TIMESTAMP,
  raderad TIMESTAMP,
  bestalld TIMESTAMP,
  skickad TIMESTAMP
) RETURNS char(20) CHARSET utf8mb3 COLLATE utf8mb3_general_ci
    DETERMINISTIC
BEGIN
    IF raderad > skickad OR raderad > bestalld OR raderad > skapad THEN
        RETURN 'Raderad';
    ELSEIF skickad < uppdaterad AND bestalld < uppdaterad AND skapad < uppdaterad THEN
        RETURN 'Uppdaterad';
    ELSEIF skickad > bestalld THEN
        RETURN 'Skickad';
    ELSEIF bestalld > skapad THEN
        RETURN 'Beställd';
    ELSEIF skapad IS NOT NULL THEN
        RETURN 'Skapad';
    END IF;
    RETURN 'Inget';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addProdukt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `addProdukt`(
    IN tprodukt_id INTEGER(3),
    IN thylla INTEGER(3),
    IN tantal INTEGER(3)
)
BEGIN
  DECLARE existing_row NUMERIC(4, 2);

  SELECT COUNT(*) INTO existing_row FROM lagerhylla WHERE hylla = thylla AND produkt_id = tprodukt_id;

  IF existing_row = 0 THEN
      INSERT INTO lagerhylla (hylla, antal, produkt_id) VALUES
      (thylla, tantal, tprodukt_id);
  ELSE
      UPDATE lagerhylla
        SET antal = antal + tantal
      WHERE hylla = thylla
        AND produkt_id = tprodukt_id;
  END IF;

  UPDATE lager
    SET
      antal = antal + tantal
    WHERE
      hylla = thylla
  ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_kund` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `create_kund`(
  a_namn VARCHAR(40),
  a_address VARCHAR(40),
  a_telefon VARCHAR(40)
)
BEGIN
  IF NOT EXISTS(SELECT 1 FROM kund WHERE namn = a_namn) THEN
    INSERT INTO kund (namn, address, telefon)
      VALUES (a_namn, a_address, a_telefon);
  ELSEIF EXISTS(SELECT 1 FROM kund WHERE namn = a_namn) THEN
    UPDATE kund
      SET address = a_address,
      telefon = a_telefon
    WHERE
      namn = a_namn;
  END IF;

  SELECT id
    FROM kund
  WHERE
    namn = a_namn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `create_order`(
  a_kund_id INT
)
BEGIN
  INSERT INTO `order` (kund_id, totalbelopp, antal, status)
  VALUES (a_kund_id, 0, 0, "Skapad");

  SELECT id
    FROM `order`
  WHERE
    kund_id = a_kund_id
  ORDER BY id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `create_produkt`(
  a_name VARCHAR(40),
  a_pris INTEGER(11)
)
BEGIN
    DECLARE a_produkt_id INT;

    INSERT INTO produkt
    (name, pris, farg, material, beskrivning, kategori_typ)
    VALUES
      (a_name, a_pris, '...', '...', '...', '...');

    SET a_produkt_id = get_var('produkt', a_name);

    INSERT INTO lagerhylla
    (hylla, antal, produkt_id)
    VALUES
      (5, 10, a_produkt_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `delete_produkt`(
  a_id CHAR(4)
)
BEGIN
  DELETE FROM lagerhylla
  WHERE
    `produkt_id` = a_id;
  DELETE FROM kategoriprodukt
  WHERE
    `produkt_id` = a_id;
  DELETE FROM produkt
  WHERE
    `id` = a_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `edit_produkt`(
  a_id INTEGER(4),
  a_name VARCHAR(40),
  a_pris INTEGER(11)
)
BEGIN
  UPDATE produkt SET
      `name` = a_name,
      `pris` = a_pris
  WHERE
      `id` = a_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `order_produkt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `order_produkt`(
  a_order_id INT,
  a_produkt_id INT,
  a_antal INT
)
BEGIN
  DECLARE v_pris INT;
  DECLARE v_hylla INT;

  SET v_pris = get_var('pris', a_produkt_id);
  SET v_hylla = get_var('hylla', a_produkt_id);

  INSERT INTO orderprodukt (order_id, antal, pris, hylla, produkt_id)
  VALUES (a_order_id, a_antal, v_pris * a_antal, v_hylla, a_produkt_id);

  UPDATE `order`
    SET antal = antal + a_antal,
    totalbelopp = totalbelopp + v_pris * a_antal
  WHERE
    id = a_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `removeProdukt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `removeProdukt`(
    IN tprodukt_id INTEGER(3),
    IN thylla INTEGER(3),
    IN tantal INTEGER(3)
)
BEGIN
  UPDATE lagerhylla
    SET antal = antal - tantal
  WHERE
    produkt_id = tprodukt_id AND
    hylla = thylla
  ;

  UPDATE lager
  SET
    antal = antal - tantal
  WHERE
    hylla = thylla
  ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_eshop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `select_eshop`(
    IN to_get CHAR(20),
    IN num INTEGER(3)
)
BEGIN
  IF to_get = 'log' THEN
    SELECT * FROM logg
      ORDER BY id DESC
      LIMIT num;
  ELSEIF to_get = 'product' THEN
    SELECT * FROM produkt;
  ELSEIF to_get = 'productkat' THEN
    SELECT
      produkt.id,
      produkt.name,
      produkt.pris,
      IFNULL(lagerhylla.antal, 0) AS antal,
      GROUP_CONCAT(DISTINCT kategoriprodukt.kategori_typ ORDER BY kategoriprodukt.kategori_typ SEPARATOR ', ') AS kategori
    FROM
      produkt
    LEFT JOIN
      kategoriprodukt ON kategoriprodukt.produkt_id = produkt.id
    LEFT JOIN
      lagerhylla ON lagerhylla.produkt_id = produkt.id
    GROUP BY produkt.id, produkt.name, produkt.pris, lagerhylla.antal;
  ELSEIF to_get = 'shelf' THEN
    SELECT * FROM lager;
  ELSEIF to_get = 'inv' THEN
    SELECT
      lagerhylla.hylla,
      lagerhylla.antal,
      produkt.id,
      produkt.name
    FROM
      lagerhylla
    INNER JOIN
      produkt ON lagerhylla.produkt_id = produkt.id;
  ELSEIF to_get = 'category' THEN
    SELECT
      * FROM kategori;
  ELSEIF to_get = 'customer' THEN
    SELECT
      * FROM kund;
  ELSEIF to_get = 'one_product' THEN
    SELECT id, name, pris FROM produkt
    WHERE
      id = num;
  ELSEIF to_get = 'one_productkat' THEN
    SELECT
      produkt.id,
      produkt.name,
      produkt.pris,
      lagerhylla.antal,
      GROUP_CONCAT(DISTINCT kategoriprodukt.kategori_typ ORDER BY kategoriprodukt.kategori_typ SEPARATOR ', ') as kategori
    FROM
      produkt
    INNER JOIN
      kategoriprodukt ON kategoriprodukt.produkt_id = produkt.id
    INNER JOIN
      lagerhylla ON lagerhylla.produkt_id = produkt.id
    WHERE
      produkt.id = num
    GROUP BY produkt.id, produkt.name, produkt.pris, lagerhylla.antal;
  ELSEIF to_get = 'order1' THEN
    SELECT *
      FROM `order`;
  ELSEIF to_get = 'order2' THEN
    SELECT *
      FROM orderprodukt
    WHERE
      order_id = num;
  ELSEIF to_get = 'order_status' THEN
    UPDATE `order`
      SET
        status = 'Beställd',
        bestalld_datum = CURRENT_TIMESTAMP
      WHERE
        id = num;
  ELSEIF to_get = 'order_sent' THEN
    UPDATE `order`
      SET
        status = 'Skickad',
        skickad_datum = CURRENT_TIMESTAMP
      WHERE
        id = num;
  ELSEIF to_get = 'last_orderid' THEN
    SELECT MAX(id) AS order_id
      FROM `order`;
  ELSEIF to_get = 'picklist' THEN
    SELECT
      orderprodukt.produkt_id,
      produkt.name,
      orderprodukt.antal AS order_antal,
      lagerhylla.antal AS lager_antal,
      lagerhylla.hylla
    FROM orderprodukt
    INNER JOIN
      produkt ON produkt.id = orderprodukt.produkt_id
    INNER JOIN
      lagerhylla ON lagerhylla.produkt_id = orderprodukt.produkt_id
    WHERE
      orderprodukt.order_id = num;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-30  0:01:53
