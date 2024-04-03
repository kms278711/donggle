-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: ssafyrds.cjw2k0eykv8p.ap-northeast-2.rds.amazonaws.com    Database: backend
-- ------------------------------------------------------
-- Server version	8.0.35

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `quiz_answer`
--

DROP TABLE IF EXISTS `quiz_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_answer` (
  `choice_id` bigint NOT NULL AUTO_INCREMENT,
  `choice` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `choice_image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quiz_id` bigint DEFAULT NULL,
  `answer` bit(1) NOT NULL,
  PRIMARY KEY (`choice_id`),
  KEY `FKg60v23ica8w0rs6qy7u91dip0` (`quiz_id`),
  CONSTRAINT `FKg60v23ica8w0rs6qy7u91dip0` FOREIGN KEY (`quiz_id`) REFERENCES `word_quiz` (`quiz_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_answer`
--

LOCK TABLES `quiz_answer` WRITE;
/*!40000 ALTER TABLE `quiz_answer` DISABLE KEYS */;
INSERT INTO `quiz_answer` VALUES (1,'도끼','quiz/axe.png',1,_binary ''),(2,'삽','quiz/shovel.png',1,_binary '\0'),(3,'칼','quiz/knife.png',1,_binary '\0'),(4,'망치','quiz/hammer.png',1,_binary '\0'),(5,'연못','quiz/pond.png',2,_binary ''),(6,'산','quiz/mountain.png',2,_binary '\0'),(7,'나무','quiz/tree.png',2,_binary '\0'),(8,'바다','quiz/ocean.png',2,_binary '\0'),(9,'쇠도끼','quiz/iron_axe.png',3,_binary ''),(10,'금도끼','quiz/gold_axe.png',3,_binary '\0'),(11,'구리도끼','quiz/copper_axe.png',3,_binary '\0'),(12,'은도끼','quiz/silver_axe.png',3,_binary '\0'),(13,'연못','quiz/pond.png',4,_binary ''),(14,'하늘','quiz/sky.png',4,_binary '\0'),(15,'나무','quiz/tree.png',4,_binary '\0'),(16,'벽','quiz/brick.png',4,_binary '\0'),(17,'해','quiz/sun.png',5,_binary ''),(18,'달','quiz/moon.png',5,_binary '\0'),(19,'별','quiz/star.png',5,_binary '\0'),(20,'바람','quiz/cloud.png',5,_binary '\0'),(21,'더위','quiz/hot.png',6,_binary ''),(22,'추위','quiz/cold.png',6,_binary '\0'),(23,'잠','quiz/sleep.png',6,_binary '\0'),(24,'웃음','quiz/Happy.png',6,_binary '\0'),(25,'추위','quiz/cold.png',7,_binary ''),(26,'더위','quiz/hot.png',7,_binary '\0'),(27,'웃음','quiz/Happy.png',7,_binary '\0'),(28,'슬픔','quiz/Sad.png',7,_binary '\0'),(29,'바람','quiz/cloud.png',8,_binary ''),(30,'나무','quiz/tree.png',8,_binary '\0'),(31,'산','quiz/mountain.png',8,_binary '\0'),(32,'달','quiz/moon.png',8,_binary '\0'),(33,'추위','quiz/cold.png',9,_binary ''),(34,'더위','quiz/hot.png',9,_binary '\0'),(35,'변화 없음','quiz/nothing.png',9,_binary '\0'),(36,'잠','quiz/sleep.png',9,_binary '\0'),(38,'1개','quiz/one.png',10,_binary '\0'),(39,'2개','quiz/two.png',10,_binary '\0'),(40,'3개','quiz/three.png',10,_binary ''),(41,'4개','quiz/four.png',10,_binary '\0'),(43,'해님','quiz/sun.png',11,_binary ''),(44,'바람','quiz/cloud.png',11,_binary '\0'),(45,'남자','quiz/man.png',11,_binary '\0'),(46,'여자','quiz/woman.png',11,_binary '\0');
/*!40000 ALTER TABLE `quiz_answer` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-03 12:10:27
