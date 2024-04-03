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
-- Table structure for table `donggle`
--

DROP TABLE IF EXISTS `donggle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donggle` (
  `message_id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dg_sound_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `situation` enum('BOOKLIST','BOOK','QUIZ','QUIZRESULT_WRONG','QUIZRESULT_CORRECT','WORDLIST','WORD') COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donggle`
--

LOCK TABLES `donggle` WRITE;
/*!40000 ALTER TABLE `donggle` DISABLE KEYS */;
INSERT INTO `donggle` VALUES (1,'동화책을 선택해봐','donggle/%EB%8F%99%ED%99%94%EC%B1%85%EC%9D%84+%EC%84%A0%ED%83%9D%ED%95%B4%EB%B4%90.mp3','BOOKLIST'),(2,'이 동화책을 읽어볼까?','donggle/%EC%9D%B4%EB%8F%99%ED%99%94%EC%B1%85%EC%9D%84+%EC%9D%BD%EC%96%B4%EB%B3%BC%EA%B9%8C.mp3','BOOK'),(3,'정답을 골라봐','donggle/%EC%A0%95%EB%8B%B5%EC%9D%84+%EA%B3%A8%EB%9D%BC%EB%B4%90.mp3','QUIZ'),(4,'잘했어!','donggle/%EC%9E%98%ED%96%88%EC%96%B4.mp3','QUIZRESULT_CORRECT'),(5,'단어카드를 골라봐','donggle/%EB%8B%A8%EC%96%B4%EC%B9%B4%EB%93%9C%EB%A5%BC+%EA%B3%A8%EB%9D%BC%EB%B4%90.mp3','WORDLIST'),(6,'이런 단어구나','donggle/%EC%9D%B4%EB%9F%B0+%EB%8B%A8%EC%96%B4%EA%B5%AC%EB%82%98.mp3','WORD'),(7,'다음에는 더 잘할 수 있을 거야!','donggle/%EB%8B%A4%EC%9D%8C%EC%97%94+%EB%8D%94+%EC%9E%98%ED%95%A0%EC%88%98%EC%9E%88%EC%9D%84%EA%B1%B0%EC%95%BC.mp3','QUIZRESULT_WRONG');
/*!40000 ALTER TABLE `donggle` ENABLE KEYS */;
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

-- Dump completed on 2024-04-03 12:10:22
