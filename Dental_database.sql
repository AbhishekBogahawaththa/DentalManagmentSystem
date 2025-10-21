CREATE DATABASE  IF NOT EXISTS `dental` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dental`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dental
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `dentist_id` int NOT NULL,
  `appointment_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `status` enum('PENDING','CONFIRMED','CANCELLED','COMPLETED') DEFAULT 'PENDING',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `dentist_id` (`dentist_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`dentist_id`) REFERENCES `dentist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,5,2,'2025-10-11','09:00:00','09:30:00','COMPLETED','2025-10-10 09:41:06','Tooth pain'),(2,6,3,'2025-10-11','10:00:00','10:30:00','COMPLETED','2025-10-10 09:41:06','Checkup'),(3,7,2,'2025-10-12','13:00:00','13:30:00','COMPLETED','2025-10-10 09:41:06','Cleaning'),(4,8,4,'2025-10-13','09:30:00','10:00:00','COMPLETED','2025-10-10 09:41:06','Rescheduled'),(5,9,3,'2025-10-14','14:00:00','14:30:00','COMPLETED','2025-10-10 09:41:06','Filling');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dentist`
--

DROP TABLE IF EXISTS `dentist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dentist` (
  `id` int NOT NULL,
  `available_status` enum('AVAILABLE','UNAVAILABLE') DEFAULT 'AVAILABLE',
  PRIMARY KEY (`id`),
  CONSTRAINT `dentist_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dentist`
--

LOCK TABLES `dentist` WRITE;
/*!40000 ALTER TABLE `dentist` DISABLE KEYS */;
INSERT INTO `dentist` VALUES (2,'AVAILABLE'),(3,'AVAILABLE'),(4,'AVAILABLE');
/*!40000 ALTER TABLE `dentist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dentist_availability`
--

DROP TABLE IF EXISTS `dentist_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dentist_availability` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dentist_id` int NOT NULL,
  `available_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `slot_duration_minutes` int DEFAULT '30',
  PRIMARY KEY (`id`),
  KEY `dentist_id` (`dentist_id`),
  CONSTRAINT `dentist_availability_ibfk_1` FOREIGN KEY (`dentist_id`) REFERENCES `dentist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dentist_availability`
--

LOCK TABLES `dentist_availability` WRITE;
/*!40000 ALTER TABLE `dentist_availability` DISABLE KEYS */;
INSERT INTO `dentist_availability` VALUES (1,2,'2025-10-11','09:00:00','12:00:00',30),(2,2,'2025-10-12','13:00:00','16:00:00',30),(3,3,'2025-10-11','10:00:00','14:00:00',30),(4,4,'2025-10-13','09:30:00','12:30:00',30),(5,3,'2025-10-14','14:00:00','17:00:00',30);
/*!40000 ALTER TABLE `dentist_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `message` text NOT NULL,
  `type` enum('INFO','REMINDER','ALERT','SYSTEM') DEFAULT 'INFO',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,5,'Your dental appointment is tomorrow at 10 AM.','REMINDER','2025-10-14 10:11:12'),(2,2,'New patient record has been added to your list.','INFO','2025-10-14 10:14:36'),(3,3,'Reminder: You have an appointment scheduled for tomorrow at 9:00 AM.','REMINDER','2025-10-14 10:14:36'),(4,4,'Your availability for next week has been updated successfully.','INFO','2025-10-14 10:14:36'),(5,5,'Your recent payment of Rs. 5000.00 has been received.','INFO','2025-10-14 10:14:36'),(6,6,'Alert: Appointment with Dr. Bryan was cancelled by the patient.','ALERT','2025-10-14 10:14:36'),(7,7,'System maintenance will occur tonight from 11 PM to 2 AM.','SYSTEM','2025-10-14 10:14:36'),(8,8,'Reminder: Your dental cleaning appointment is today at 2:00 PM.','REMINDER','2025-10-14 10:14:36'),(9,9,'Alert: Please update your contact details to continue receiving notifications.','ALERT','2025-10-14 10:14:36');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `id` int NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(300) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (5,'+94774564622','206,Neligama,Mirigama','1991-02-01','Notes 1'),(6,'+94779685105','345/43,Kottawa,Colombo','1992-02-01','Notes 2'),(7,'+94724567858','34,Malabe road,Malabe','1993-02-01','Notes 3'),(8,'+94712345638','54/3,alawwa,Kurunegala','1994-02-01','Notes 4'),(9,'+94756783456','43/5,Polgasowita rd,horana','1995-02-01','Notes 5'),(10,'+94723425648','88,brisbane,southwales','1996-02-01','Notes 6');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_record`
--

DROP TABLE IF EXISTS `patient_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `dentist_id` int NOT NULL,
  `appointment_id` int DEFAULT NULL,
  `procedure_name` text,
  `status` text,
  `record_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `dentist_id` (`dentist_id`),
  KEY `appointment_id` (`appointment_id`),
  CONSTRAINT `patient_record_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `user` (`id`),
  CONSTRAINT `patient_record_ibfk_2` FOREIGN KEY (`dentist_id`) REFERENCES `user` (`id`),
  CONSTRAINT `patient_record_ibfk_3` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_record`
--

LOCK TABLES `patient_record` WRITE;
/*!40000 ALTER TABLE `patient_record` DISABLE KEYS */;
INSERT INTO `patient_record` VALUES (1,4,2,1,'Tooth Filling','Completed','2025-10-11 20:38:08'),(2,4,2,1,'Teeth Cleaning','Completed','2025-10-11 21:05:29'),(3,5,3,2,'Scaling','Completed','2025-10-11 21:05:29'),(4,6,2,3,'Tooth Extraction','Completed','2025-10-11 21:05:29'),(5,7,2,4,'Root Canal','Ongoing','2025-10-11 21:05:29'),(6,5,2,5,'Consultation','Scheduled','2025-10-11 21:05:29'),(7,5,3,2,'Tooth Cleaning','Scheduled','2025-10-11 21:12:30'),(8,7,2,3,'General Treatment','Recorded','2025-10-11 21:54:16'),(9,6,3,2,'General Treatment','Recorded','2025-10-11 21:57:47'),(10,8,4,4,'General Treatment','Recorded','2025-10-11 22:33:23'),(11,5,2,1,'General Treatment','Recorded','2025-10-12 17:32:49');
/*!40000 ALTER TABLE `patient_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `appointment_id` int DEFAULT NULL,
  `patient_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_method` varchar(100) DEFAULT NULL,
  `received_by` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `appointment_id` (`appointment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `received_by` (`received_by`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`id`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`),
  CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`received_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,1,5,50.00,'2025-10-10 09:42:17','CASH',1,'Consultation fee'),(2,2,6,30.00,'2025-10-10 09:42:17','CARD',1,'Deposit'),(3,3,7,75.00,'2025-10-10 09:42:17','CASH',1,'Cleaning'),(4,5,9,120.00,'2025-10-10 09:42:17','CARD',1,'Filling payment'),(5,NULL,10,20.00,'2025-10-10 09:42:17','CASH',1,'Walk-in fee'),(6,2,5,75.00,'2025-10-11 16:54:37','CASH',1,'Paid after treatment'),(7,4,8,7500.00,'2025-10-11 17:03:23','CASH',1,'Paid before the treatment'),(8,4,8,7500.00,'2025-10-11 17:03:32','CASH',1,'Paid before the treatment');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN'),(2,'DENTIST'),(3,'PATIENT');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  `role_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin1','admin1','admin@example.com','Abhi Admin',1,'2025-10-10 09:30:09'),(2,'dentist1','pass123','brayna23@gmail.com','Dr. Bryan',2,'2025-10-10 09:30:09'),(3,'dentist2','pass234','caravase@gmail.com','Dr. Cara',2,'2025-10-10 09:30:09'),(4,'dentist3','pass345','devpom@gmail.com','Dr. Dev',2,'2025-10-10 09:30:09'),(5,'patient1','pass123','chanuthiace@gmail.com','Chanuthi',3,'2025-10-10 09:30:09'),(6,'patient2','pass345','dilshan34@gmail','Thilakarathna dilshan',3,'2025-10-10 09:30:09'),(7,'patient3','pass567','kavindi@yahoo.com','Kavindi Nethma',3,'2025-10-10 09:30:09'),(8,'patient4','pass789','pula@gmail.com','Pulasthi Abhishek',3,'2025-10-10 09:30:09'),(9,'patient5','pass987','prabodha@gmail.com','Erandi prabodha',3,'2025-10-10 09:30:09'),(10,'patient6','pass341','ronaldo45@gmail.com','Sithmi ronaldo',3,'2025-10-10 09:30:09');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-21  9:11:06
