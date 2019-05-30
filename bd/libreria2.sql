-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: libreria
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `carrito` (
  `cliente` int(11) NOT NULL,
  `libro` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `preUnit` double DEFAULT NULL,
  PRIMARY KEY (`cliente`,`libro`),
  KEY `libro` (`libro`),
  CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`libro`) REFERENCES `libro` (`NumSerie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
INSERT INTO `carrito` VALUES (2,158762,5,258),(2,568941,8,700.5);
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `Genero` varchar(1) DEFAULT NULL,
  `Nombre` varchar(20) DEFAULT NULL,
  `ap` varchar(25) DEFAULT NULL,
  `am` varchar(25) DEFAULT NULL,
  `dir` varchar(45) DEFAULT NULL,
  `calle` varchar(40) DEFAULT NULL,
  `colonia` varchar(45) DEFAULT NULL,
  `CP` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `Tel` varchar(10) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `contraseña` varchar(45) NOT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'F','null','Cabello','Hermos','Hidalgo','lomas mur','la mas',56841,21,'554781234','camiloquis@gmail.com','12345'),(2,'F','Daniela','Cortes','Castillo','Ecatepec','Mexico','Jardines de Morelos',89562,32,'5564581342','danyylv@outlook.com','12345'),(3,'M','Ramon','Flores','Rosas','Estado de mexico','Continentes','Atizapan',89132,182,'5564359781','rmf@outlook.com','12345'),(4,'F','Guadalupe','Bejarano','Moreno','CDMX','E. Coahuila','rovidencia',7550,87,'5564335691','abjea.alpha@outlook.com','12345'),(5,'M','jose','Mendes','lopes','Estado de mexico','Romero','R1',26489,95,'5564355123','jml@outlook.com','12345'),(6,'M','Hector','Perez','Barajas','Estado de mexico','Continentes','Tlalpan',85432,46,'556404051','hpb@outlook.com','12345'),(7,'F','Gabriel','Hernadez','Tello','Mexico','vacas','locas',5568,23,'11671452','vac@gmail.com','12345'),(8,'M','Dian','Perza','López','sss','lolo','sdf',89652,56,'116145','dsfs@gmail.com','12345'),(9,'F','Jimena','La','Buapa','Mexico','mexico','lopasm',52164,23,'11671545','dsfdvf@gmail.com','124578');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desctick`
--

DROP TABLE IF EXISTS `desctick`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `desctick` (
  `Folio` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`Folio`,`descripcion`),
  CONSTRAINT `desctick_ibfk_1` FOREIGN KEY (`Folio`) REFERENCES `ticket` (`folio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desctick`
--

LOCK TABLES `desctick` WRITE;
/*!40000 ALTER TABLE `desctick` DISABLE KEYS */;
/*!40000 ALTER TABLE `desctick` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `empleado` (
  `idEmpleado` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `Appaterno` varchar(45) DEFAULT NULL,
  `apmaterno` varchar(45) DEFAULT NULL,
  `puesto` varchar(20) DEFAULT NULL,
  `idsuccursal` int(11) DEFAULT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `idsuccursal` (`idsuccursal`),
  CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`idsuccursal`) REFERENCES `succursal` (`idsuccursal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,'Jose','Perez','Perez','Gerente',2),(2,'Maria','Gonzales','Randon','Cajero',2),(3,'Mario','Saldiva','Suari','Cajero',2),(4,'Luis','Pacheco','gonzales','Gerente',3),(5,'Andrea','Gomez','Venegas','Cajero',3),(6,'Esteban','Lunet','Contreras','Cajero',3),(7,'Gerzon','blake','Perez','Gerente',1),(8,'ian','rangel','vazquez','Cajero',1),(9,'Pedro','Solano','lopez','Cajero',1);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envio`
--

DROP TABLE IF EXISTS `envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `envio` (
  `Codigo` int(11) NOT NULL,
  `destino` varchar(100) DEFAULT NULL,
  `FechaEnvio` varchar(45) DEFAULT NULL,
  `idcliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`Codigo`),
  KEY `idcliente` (`idcliente`),
  CONSTRAINT `envio_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envio`
--

LOCK TABLES `envio` WRITE;
/*!40000 ALTER TABLE `envio` DISABLE KEYS */;
INSERT INTO `envio` VALUES (1,'Calle mexico numero 32','2018-11-25',2),(2,'Ecatepec,Jardines de Morelos,MexicoNO. 32, C.P.89562','2018-10-25',2),(3,'Ecatepec,Jardines de Morelos,MexicoNO. 32, C.P.89562','2018-10-25',2),(4,'Ecatepec,Jardines de Morelos,MexicoNO. 32, C.P.89562','2018-10-25',2),(5,'Ecatepec,Jardines de Morelos,MexicoNO. 32, C.P.89562','2018-10-25',2),(6,'Ecatepec,Jardines de Morelos,MexicoNO. 32, C.P.89562','2018-10-25',2),(7,'callemexico 32','2018-10-25',3),(8,'CDMX,rovidencia,E. CoahuilaNO. 87, C.P.7550','2018-10-25',4),(9,'Estado de mexico,Atizapan,ContinentesNO. 182, C.P.89132','2018-10-25',3),(10,'Estado de mexico,Atizapan,ContinentesNO. 182, C.P.89132','2018-10-25',3),(11,'Estado de mexico,R1,RomeroNO. 95, C.P.26489','2018-10-25',5),(12,'Hidalgo,la mas,lomas murNO. 21, C.P.56841','2018-10-27',1),(13,'Hidalgo,la mas,lomas murNO. 21, C.P.56841','2018-10-27',1),(14,'Hidalgo,la mas,lomas murNO. 21, C.P.56841','2018-10-27',1);
/*!40000 ALTER TABLE `envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enviotrans`
--

DROP TABLE IF EXISTS `enviotrans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `enviotrans` (
  `costo` double DEFAULT NULL,
  `Codigo` int(11) NOT NULL,
  `Numtrans` int(11) NOT NULL,
  PRIMARY KEY (`Codigo`,`Numtrans`),
  KEY `Numtrans` (`Numtrans`),
  CONSTRAINT `enviotrans_ibfk_1` FOREIGN KEY (`Numtrans`) REFERENCES `trans` (`numtrans`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `enviotrans_ibfk_2` FOREIGN KEY (`Codigo`) REFERENCES `envio` (`Codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enviotrans`
--

LOCK TABLES `enviotrans` WRITE;
/*!40000 ALTER TABLE `enviotrans` DISABLE KEYS */;
INSERT INTO `enviotrans` VALUES (1096,2,9),(300,3,10),(0,4,11),(0,5,12),(921,6,13),(1745.5,7,14),(738.5,8,15),(0,9,16),(0,10,17),(3601,11,18),(3200.5,12,36),(3187.5,14,38);
/*!40000 ALTER TABLE `enviotrans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libaut`
--

DROP TABLE IF EXISTS `libaut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `libaut` (
  `Autor` varchar(100) NOT NULL,
  `NumSerie` int(11) NOT NULL,
  PRIMARY KEY (`NumSerie`,`Autor`),
  CONSTRAINT `libaut_ibfk_1` FOREIGN KEY (`NumSerie`) REFERENCES `libro` (`numserie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libaut`
--

LOCK TABLES `libaut` WRITE;
/*!40000 ALTER TABLE `libaut` DISABLE KEYS */;
INSERT INTO `libaut` VALUES ('Luis Serrano',124789),('Catalina Aguilar Mastretta',156898),('Svetlana Alexievich',158762),('Glukhovsky Dmitry',564241),('Daniela Cortes',568941),('Saul Andre',568941),('J.L.Bourne',653121),('J.L.Bourne',653122),('J.L.Bourne',653123),('Angeles MAstretta',964321),('Andy Weir',984181);
/*!40000 ALTER TABLE `libaut` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libcli`
--

DROP TABLE IF EXISTS `libcli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `libcli` (
  `Cantidad` int(11) DEFAULT NULL,
  `Calif` int(11) DEFAULT NULL,
  `NumSerie` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  PRIMARY KEY (`idcliente`,`NumSerie`),
  KEY `NumSerie` (`NumSerie`),
  CONSTRAINT `libcli_ibfk_1` FOREIGN KEY (`NumSerie`) REFERENCES `libro` (`numserie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `libcli_ibfk_2` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libcli`
--

LOCK TABLES `libcli` WRITE;
/*!40000 ALTER TABLE `libcli` DISABLE KEYS */;
INSERT INTO `libcli` VALUES (3,NULL,124789,1),(1,NULL,156898,1),(1,NULL,568941,1),(1,NULL,653122,1),(2,NULL,984181,1),(3,NULL,156898,2),(1,NULL,156898,3),(1,NULL,156898,4),(1,NULL,564241,4),(1,NULL,984181,4),(3,NULL,564241,5),(1,NULL,653123,5),(2,NULL,984181,5);
/*!40000 ALTER TABLE `libcli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libenv`
--

DROP TABLE IF EXISTS `libenv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `libenv` (
  `NumSerie` int(11) NOT NULL,
  `Codigo` int(11) NOT NULL,
  PRIMARY KEY (`Codigo`,`NumSerie`),
  KEY `NumSerie` (`NumSerie`),
  CONSTRAINT `libenv_ibfk_1` FOREIGN KEY (`NumSerie`) REFERENCES `libro` (`numserie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `libenv_ibfk_2` FOREIGN KEY (`Codigo`) REFERENCES `envio` (`Codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libenv`
--

LOCK TABLES `libenv` WRITE;
/*!40000 ALTER TABLE `libenv` DISABLE KEYS */;
INSERT INTO `libenv` VALUES (156898,2),(156898,14),(564241,7),(564241,8),(564241,11),(568941,12),(653122,7),(653122,14),(653123,6),(653123,11),(984181,6),(984181,8),(984181,13);
/*!40000 ALTER TABLE `libenv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libgen`
--

DROP TABLE IF EXISTS `libgen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `libgen` (
  `Genero` varchar(50) NOT NULL,
  `NumSerie` int(11) NOT NULL,
  PRIMARY KEY (`NumSerie`,`Genero`),
  CONSTRAINT `libgen_ibfk_1` FOREIGN KEY (`NumSerie`) REFERENCES `libro` (`numserie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libgen`
--

LOCK TABLES `libgen` WRITE;
/*!40000 ALTER TABLE `libgen` DISABLE KEYS */;
INSERT INTO `libgen` VALUES ('Historia',158762),('Ciencia Ficcion',564241),('Ficcion',653121),('Ficcion',653122),('Ficcion',653123),('Literatura',964321),('Ciencia Ficcion',984181);
/*!40000 ALTER TABLE `libgen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libro`
--

DROP TABLE IF EXISTS `libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `libro` (
  `NumSerie` int(11) NOT NULL,
  `Editorial` varchar(45) DEFAULT NULL,
  `titulo` varchar(45) DEFAULT NULL,
  `numpag` int(11) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  PRIMARY KEY (`NumSerie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libro`
--

LOCK TABLES `libro` WRITE;
/*!40000 ALTER TABLE `libro` DISABLE KEYS */;
INSERT INTO `libro` VALUES (124789,'PID','Piedras plugh',158,189.5),(156898,'OCEANO','Todos los dias son nuestros',250,398),(158762,'DEBATE','La guerra no tiene Rostro de Mujer',264,258),(564241,'CreateSpace','Metro 2033',320,288.5),(568941,'OCEANO','Como morir',520,700.5),(653121,'Timun Mas','Diario de una invasion zombie',230,300.5),(653122,'Timun Mas','Exilio:Diario de una invasion zombie',278,289.5),(653123,'Timun Mas','Rescate:Diario de una invasion zombie',290,235.5),(964321,'Seix Barral','Arrancame la vida',340,290.5),(984181,'Ediciones B','El marciano',255,150);
/*!40000 ALTER TABLE `libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `librocom`
--

DROP TABLE IF EXISTS `librocom`;
/*!50001 DROP VIEW IF EXISTS `librocom`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `librocom` AS SELECT 
 1 AS `Numserie`,
 1 AS `titulo`,
 1 AS `editorial`,
 1 AS `autor`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `succursal`
--

DROP TABLE IF EXISTS `succursal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `succursal` (
  `Telefono` varchar(12) DEFAULT NULL,
  `dir` varchar(40) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `idSuccursal` int(11) NOT NULL,
  `CP` int(11) DEFAULT NULL,
  `Colonia` varchar(45) DEFAULT NULL,
  `Calle` varchar(45) DEFAULT NULL,
  `contra` varchar(45) NOT NULL,
  PRIMARY KEY (`idSuccursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `succursal`
--

LOCK TABLES `succursal` WRITE;
/*!40000 ALTER TABLE `succursal` DISABLE KEYS */;
INSERT INTO `succursal` VALUES ('57465019','Ciudad de mexico',65,1,86537,'Industrial','revolucion','contraseña'),('61432461','Nuevo Leon',31,2,62497,'San miguel','Romero Rubio','contraseña'),('57469461','Morelos',76,3,66137,'Insurgentes','Cobre','contraseña'),('57468124',NULL,NULL,4,NULL,NULL,NULL,'contraseña');
/*!40000 ALTER TABLE `succursal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sulib`
--

DROP TABLE IF EXISTS `sulib`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sulib` (
  `idSuccursal` int(11) NOT NULL,
  `NumSerie` int(11) NOT NULL,
  `Numdisponible` int(11) DEFAULT NULL,
  KEY `idSuccursal` (`idSuccursal`),
  KEY `NumSerie` (`NumSerie`),
  CONSTRAINT `sulib_ibfk_1` FOREIGN KEY (`idSuccursal`) REFERENCES `succursal` (`idSuccursal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sulib_ibfk_2` FOREIGN KEY (`NumSerie`) REFERENCES `libro` (`NumSerie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sulib`
--

LOCK TABLES `sulib` WRITE;
/*!40000 ALTER TABLE `sulib` DISABLE KEYS */;
INSERT INTO `sulib` VALUES (1,124789,191),(2,124789,200),(3,124789,200),(4,124789,200),(1,156898,200),(2,156898,200),(3,156898,200),(4,156898,199),(1,158762,200),(2,158762,200),(3,158762,200),(4,158762,200),(1,564241,200),(2,564241,200),(3,564241,200),(4,564241,200),(1,568941,200),(2,568941,200),(3,568941,200),(4,568941,199),(1,653121,200),(2,653121,200),(3,653121,200),(4,653121,200),(1,653122,200),(2,653122,200),(3,653122,200),(4,653122,199),(1,653123,200),(2,653123,200),(3,653123,200),(4,653123,200),(1,964321,200),(2,964321,200),(3,964321,200),(4,964321,200),(1,984181,198),(2,984181,200),(3,984181,200),(4,984181,200);
/*!40000 ALTER TABLE `sulib` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ticket` (
  `Folio` int(11) NOT NULL,
  `Fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `idEmpleado` int(11) DEFAULT NULL,
  PRIMARY KEY (`Folio`),
  KEY `idEmpleado` (`idEmpleado`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`idEmpleado`) REFERENCES `empleado` (`idEmpleado`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,'2018-11-25','12:47:00',1),(2,'2018-11-25','12:48:00',NULL),(3,'2018-10-25','02:05:45',NULL),(4,'2018-10-25','02:07:24',NULL),(5,'2018-10-25','02:09:46',NULL),(6,'2018-10-25','02:14:50',NULL),(7,'2018-10-25','02:15:41',NULL),(8,'2018-10-25','02:19:06',NULL),(9,'2018-10-25','02:21:13',NULL),(10,'2018-10-25','02:25:01',NULL),(11,'2018-10-25','02:26:56',NULL),(12,'2018-10-25','03:11:17',NULL),(13,'2018-10-25','03:12:50',NULL),(14,'2018-10-25','03:14:01',NULL),(15,'2018-10-25','14:04:09',NULL),(16,'2018-10-25','14:09:39',NULL),(17,'2018-10-25','14:17:32',NULL),(18,'2018-10-25','14:32:29',NULL),(19,'2018-10-25','14:38:58',NULL),(20,'2018-10-25','14:59:23',NULL),(21,'2018-10-25','18:39:37',8),(22,'2018-10-25','18:42:38',9),(23,'2018-10-25','18:50:11',8),(24,'2018-10-25','18:51:15',8),(25,'2018-10-25','18:54:13',8),(26,'2018-10-25','18:59:45',8),(27,'2018-10-25','19:03:00',8),(28,'2018-10-25','20:23:07',2),(29,'2018-10-25','20:26:11',2),(30,'2018-10-25','20:38:43',8),(31,'2018-10-25','20:40:21',2),(32,'2018-10-27','20:17:48',9),(33,'2018-10-27','20:23:28',8),(34,'2018-10-27','20:25:14',8),(35,'2018-10-27','20:30:21',8),(36,'2018-10-27','20:33:54',8),(37,'2018-10-27','20:35:37',8),(38,'2018-10-27','20:37:27',8),(39,'2018-10-27','20:40:41',NULL),(40,'2018-10-27','22:06:08',NULL),(41,'2018-10-27','22:11:43',NULL);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoenv`
--

DROP TABLE IF EXISTS `tipoenv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipoenv` (
  `Codigo1` int(11) NOT NULL,
  `Codigo2` int(11) NOT NULL,
  `Tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Codigo1`,`Codigo2`),
  KEY `Codigo2` (`Codigo2`),
  CONSTRAINT `tipoenv_ibfk_1` FOREIGN KEY (`Codigo1`) REFERENCES `envio` (`Codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tipoenv_ibfk_2` FOREIGN KEY (`Codigo2`) REFERENCES `envio` (`Codigo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoenv`
--

LOCK TABLES `tipoenv` WRITE;
/*!40000 ALTER TABLE `tipoenv` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipoenv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipotrans`
--

DROP TABLE IF EXISTS `tipotrans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipotrans` (
  `Tipo` varchar(25) DEFAULT NULL,
  `Numtrans1` int(11) NOT NULL,
  `Numtrans2` int(11) NOT NULL,
  PRIMARY KEY (`Numtrans1`,`Numtrans2`),
  KEY `Numtrans2` (`Numtrans2`),
  CONSTRAINT `tipotrans_ibfk_1` FOREIGN KEY (`Numtrans1`) REFERENCES `trans` (`numtrans`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tipotrans_ibfk_2` FOREIGN KEY (`Numtrans2`) REFERENCES `trans` (`numtrans`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipotrans`
--

LOCK TABLES `tipotrans` WRITE;
/*!40000 ALTER TABLE `tipotrans` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipotrans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trans`
--

DROP TABLE IF EXISTS `trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `trans` (
  `Numtrans` int(11) NOT NULL,
  `Total` double DEFAULT NULL,
  `Idcliente` int(11) NOT NULL,
  `Folio` int(11) NOT NULL,
  PRIMARY KEY (`Numtrans`,`Idcliente`,`Folio`),
  KEY `Idcliente` (`Idcliente`),
  KEY `Folio` (`Folio`),
  CONSTRAINT `trans_ibfk_1` FOREIGN KEY (`Idcliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `trans_ibfk_2` FOREIGN KEY (`Folio`) REFERENCES `ticket` (`Folio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trans`
--

LOCK TABLES `trans` WRITE;
/*!40000 ALTER TABLE `trans` DISABLE KEYS */;
INSERT INTO `trans` VALUES (1,250,2,1),(2,1214,2,3),(3,1384.5,2,4),(4,771,2,5),(5,771,2,6),(6,1096,2,7),(7,698,2,8),(8,3296,2,10),(9,1096,2,11),(10,300,2,12),(11,0,2,13),(12,0,2,14),(13,921,2,15),(14,1745.5,3,16),(15,738.5,4,17),(16,0,3,18),(17,0,3,19),(18,3601,5,20),(19,398,2,21),(20,398,2,23),(21,398,3,24),(22,398,3,25),(23,398,4,26),(24,300,5,27),(25,398,2,28),(26,398,2,29),(27,398,2,30),(28,398,2,31),(29,1175,1,32),(30,777,1,33),(31,339.5,1,34),(32,339.5,1,35),(33,339.5,1,36),(34,489.5,1,37),(35,189.5,1,38),(36,3200.5,1,39),(37,3350.5,1,40),(38,3187.5,1,41);
/*!40000 ALTER TABLE `trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transban`
--

DROP TABLE IF EXISTS `transban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `transban` (
  `IVA` int(11) DEFAULT NULL,
  `NumTarjeta` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `Folio` int(11) NOT NULL,
  PRIMARY KEY (`NumTarjeta`,`Folio`,`idcliente`),
  KEY `idcliente` (`idcliente`),
  KEY `Folio` (`Folio`),
  CONSTRAINT `transban_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transban_ibfk_2` FOREIGN KEY (`Folio`) REFERENCES `ticket` (`Folio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transban`
--

LOCK TABLES `transban` WRITE;
/*!40000 ALTER TABLE `transban` DISABLE KEYS */;
INSERT INTO `transban` VALUES (16,5555,3,19),(16,66666,2,13),(16,154785,1,39),(16,222333,3,18),(16,556656,2,12),(16,594581,5,27),(16,1568452,4,26),(16,1632589,5,20),(16,1654821,2,15),(16,1684156,2,11),(16,6589126,3,16),(16,9999999,2,14),(16,15231245,1,41),(16,85565412,4,17);
/*!40000 ALTER TABLE `transban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `librocom`
--

/*!50001 DROP VIEW IF EXISTS `librocom`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `librocom` AS select `l`.`NumSerie` AS `Numserie`,`l`.`titulo` AS `titulo`,`l`.`Editorial` AS `editorial`,`la`.`Autor` AS `autor` from (`libro` `l` join `libaut` `la`) where (`l`.`NumSerie` = `la`.`NumSerie`) order by `l`.`titulo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-30  6:00:14
