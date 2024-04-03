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
-- Table structure for table `word_quiz`
--

DROP TABLE IF EXISTS `word_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word_quiz` (
  `quiz_id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `theme` enum('WORD','STORY') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `book_id` bigint DEFAULT NULL,
  `education_id` bigint DEFAULT NULL,
  PRIMARY KEY (`quiz_id`),
  KEY `FK6p0n4220d5bd9f59ar7752hop` (`book_id`),
  KEY `FKqu11th9s19r1re138u3pwhv8j` (`education_id`),
  CONSTRAINT `FK6p0n4220d5bd9f59ar7752hop` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`),
  CONSTRAINT `FKqu11th9s19r1re138u3pwhv8j` FOREIGN KEY (`education_id`) REFERENCES `education` (`education_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word_quiz`
--

LOCK TABLES `word_quiz` WRITE;
/*!40000 ALTER TABLE `word_quiz` DISABLE KEYS */;
INSERT INTO `word_quiz` VALUES (1,'다음 중 도끼인 것을 고르세요.','WORD',NULL,1),(2,'다음 중 연못을 고르세요.','WORD',NULL,2),(3,'동화 금도끼 은도끼에서 나무꾼이 잃어버린 도끼는 어느 도끼일까요?','STORY',1,NULL),(4,'동화 금도끼 은도끼에서 산신령이 나타난 곳은?','STORY',1,NULL),(5,'다음 중 해인 것을 고르세요.','WORD',NULL,8),(6,'다음 중 더위에 해당하는 것을 고르세요.','WORD',NULL,9),(7,'다음 중 더위에 반대되는 말을 고르세요.','WORD',NULL,7),(8,'동화 해님과 바람에서 해님은 누구와 내기를 할까요?','STORY',2,NULL),(9,'동화 해님과 바람에서 바람이 입으로 바람을 세게 불었을 때 남자는 어떤 행동을 취했나요?','STORY',2,NULL),(10,'동화 금도끼 은도끼에서 나무꾼이 받게된 총 도끼의 개수는?','STORY',1,NULL),(11,'동화 해님과 바람에서 남자의 코트를 벗긴 것은 누구인가요?','STORY',2,NULL);
/*!40000 ALTER TABLE `word_quiz` ENABLE KEYS */;
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

-- Dump completed on 2024-04-03 12:10:23
