-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.11.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `hospital_detail`
--

DROP TABLE IF EXISTS `hospital_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_detail` (
  `hospital_code` varchar(255) NOT NULL,
  `parking_capacity` double DEFAULT NULL,
  `day_emergency` varchar(1) DEFAULT NULL,
  `weekday_lunch` text DEFAULT NULL,
  `weekday_reception` text DEFAULT NULL,
  `saturday_reception` text DEFAULT NULL,
  `night_emergency` varchar(1) DEFAULT NULL,
  `mon_open` int(11) DEFAULT NULL,
  `tues_open` int(11) DEFAULT NULL,
  `wed_open` int(11) DEFAULT NULL,
  `thurs_open` int(11) DEFAULT NULL,
  `fri_open` int(11) DEFAULT NULL,
  `mon_end` int(11) DEFAULT NULL,
  `tues_end` int(11) DEFAULT NULL,
  `wed_end` int(11) DEFAULT NULL,
  `thurs_end` int(11) DEFAULT NULL,
  `fri_end` int(11) DEFAULT NULL,
  KEY `idx_hospital_code` (`hospital_code`),
  CONSTRAINT `fk_hospital_detail_hospital_code` FOREIGN KEY (`hospital_code`) REFERENCES `hospital_main` (`hospital_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital_detail`
--

LOCK TABLES `hospital_detail` WRITE;
/*!40000 ALTER TABLE `hospital_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `hospital_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital_main`
--

DROP TABLE IF EXISTS `hospital_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_main` (
  `hospital_code` varchar(255) NOT NULL,
  `hospital_name` text DEFAULT NULL,
  `province_name` text DEFAULT NULL,
  `district_name` text DEFAULT NULL,
  `hospital_address` text DEFAULT NULL,
  `hospital_tel` text DEFAULT NULL,
  `hospital_homepage` varchar(255) DEFAULT NULL,
  `doctor_num` bigint(20) DEFAULT NULL,
  `coordinate_x` double DEFAULT NULL,
  `coordinate_y` double DEFAULT NULL,
  PRIMARY KEY (`hospital_code`),
  KEY `idx_hospital_code` (`hospital_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital_main`
--

LOCK TABLES `hospital_main` WRITE;
/*!40000 ALTER TABLE `hospital_main` DISABLE KEYS */;
/*!40000 ALTER TABLE `hospital_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_subject`
--

DROP TABLE IF EXISTS `medical_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hospital_code` varchar(50) DEFAULT NULL,
  `subject_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hospital_code` (`hospital_code`),
  CONSTRAINT `medical_subject_ibfk_1` FOREIGN KEY (`hospital_code`) REFERENCES `hospital_main` (`hospital_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_subject`
--

LOCK TABLES `medical_subject` WRITE;
/*!40000 ALTER TABLE `medical_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy`
--

DROP TABLE IF EXISTS `pharmacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacy` (
  `pharmacy_code` varchar(128) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `district_name` varchar(50) DEFAULT NULL,
  `Administrative units` varchar(50) DEFAULT NULL,
  `mail_address` int(11) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `Establishment Date` varchar(50) DEFAULT NULL,
  `coordinate_x` double DEFAULT NULL,
  `coordinate_y` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy`
--

LOCK TABLES `pharmacy` WRITE;
/*!40000 ALTER TABLE `pharmacy` DISABLE KEYS */;
/*!40000 ALTER TABLE `pharmacy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pro_doc`
--

DROP TABLE IF EXISTS `pro_doc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pro_doc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hospital_code` varchar(50) DEFAULT NULL,
  `subject_name` varchar(100) DEFAULT NULL,
  `pro_doc_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hospital_code` (`hospital_code`),
  CONSTRAINT `pro_doc_ibfk_1` FOREIGN KEY (`hospital_code`) REFERENCES `hospital_main` (`hospital_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pro_doc`
--

LOCK TABLES `pro_doc` WRITE;
/*!40000 ALTER TABLE `pro_doc` DISABLE KEYS */;
/*!40000 ALTER TABLE `pro_doc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hospital_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-27  2:55:23
