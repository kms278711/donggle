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
-- Table structure for table `education`
--

DROP TABLE IF EXISTS `education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `education` (
  `education_id` bigint NOT NULL AUTO_INCREMENT,
  `category` enum('PICTURE','ACTION','EXPRESSION') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gubun` enum('WORD','NOWORD') COLLATE utf8mb4_general_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `word_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `book_page_sentence_id` bigint DEFAULT NULL,
  `trace_image_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`education_id`),
  UNIQUE KEY `UK_rd79svmriffwpe7s0tw70y85d` (`book_page_sentence_id`),
  CONSTRAINT `FKdup6von6ve4svqsqk4wvsn0t4` FOREIGN KEY (`book_page_sentence_id`) REFERENCES `book_page_sentence` (`book_page_sentence_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `education`
--

LOCK TABLES `education` WRITE;
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
INSERT INTO `education` VALUES (1,'PICTURE','WORD','word/note/axe.png','도끼',2,'book/GoldAndSliverAxe/1page/axe.png'),(2,'PICTURE','WORD','word/note/pond.png','연못',5,'book/GoldAndSliverAxe/3page/pond.png'),(3,'EXPRESSION','WORD','word/note/Happy.png','웃음',24,NULL),(4,NULL,'NOWORD','X','이 금도끼가 나무꾼의 도끼인가요?',10,'book/GoldAndSliverAxe/5page/gold_axe.png'),(5,NULL,'NOWORD','O','이 쇠도끼가 나무꾼의 도끼인가요?',19,'book/GoldAndSliverAxe/7page/iron_axe.png'),(6,'PICTURE','WORD','word/note/cloud.png','바람',26,'book/SunAndWind/1page/wind.png'),(7,'ACTION','WORD','word/note/cold.png','추위',44,NULL),(8,'PICTURE','WORD','word/note/sun.png','해',47,'book/SunAndWind/6page/sun.png'),(9,'ACTION','WORD','word/note/hot.png','더위',55,NULL);
/*!40000 ALTER TABLE `education` ENABLE KEYS */;
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
