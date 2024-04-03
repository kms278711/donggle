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
-- Table structure for table `book_page_sentence`
--

DROP TABLE IF EXISTS `book_page_sentence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_page_sentence` (
  `book_page_sentence_id` bigint NOT NULL AUTO_INCREMENT,
  `sentence` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sentence_sound_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sequence` int NOT NULL,
  `book_page_id` bigint DEFAULT NULL,
  `education_education_id` bigint DEFAULT NULL,
  `education_id` bigint DEFAULT NULL,
  PRIMARY KEY (`book_page_sentence_id`),
  UNIQUE KEY `UK_s9cd4agd6truufoda6p4dbr5p` (`education_education_id`),
  UNIQUE KEY `UK_6q8opvtq5qnbc2ksnfs73gxp0` (`education_id`),
  KEY `FKkujo0p91f456na7jcqkmj4l8s` (`book_page_id`),
  CONSTRAINT `FK6mqxfl9e942b644i06olfxd56` FOREIGN KEY (`education_education_id`) REFERENCES `education` (`education_id`),
  CONSTRAINT `FKhbs66l7dlcslakllpexut5b3p` FOREIGN KEY (`education_id`) REFERENCES `education` (`education_id`),
  CONSTRAINT `FKkujo0p91f456na7jcqkmj4l8s` FOREIGN KEY (`book_page_id`) REFERENCES `book_page` (`book_page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_page_sentence`
--

LOCK TABLES `book_page_sentence` WRITE;
/*!40000 ALTER TABLE `book_page_sentence` DISABLE KEYS */;
INSERT INTO `book_page_sentence` VALUES (1,'옛날옛날에 나무꾼이 살았어요. ','book/GoldAndSliverAxe/1page/sound/1.mp3',1,1,NULL,NULL),(2,'어느날 나무꾼은 나무를 하다가 도끼를 연못에 빠뜨렸어요.  ','book/GoldAndSliverAxe/1page/sound/2.mp3',2,1,NULL,NULL),(3,'\'아이구, 큰일 났구나. 하나밖에 없는 도끼인데... 새 도끼를 살 돈도 없는데 이제는 어떻게 나무를 하지?\'','book/GoldAndSliverAxe/2page/sound/3.mp3',1,2,NULL,NULL),(4,'나무꾼은 눈물이 났어요. 그때였어요.','book/GoldAndSliverAxe/2page/sound/4.mp3',2,2,NULL,NULL),(5,'\'펑\' 소리가 나더니 연못에서 산신령이 나타났어요.','book/GoldAndSliverAxe/3page/sound/5.mp3',1,3,NULL,NULL),(6,'\"나무꾼아, 왜 울고 있니?\"','book/GoldAndSliverAxe/4page/sound/6.mp3',1,4,NULL,NULL),(7,'\"하나밖에 없는 제 도끼가 연못에 빠졌어요.\"','book/GoldAndSliverAxe/4page/sound/7.mp3',2,4,NULL,NULL),(8,'산신령은 연못 속으로 사라졌어요.','book/GoldAndSliverAxe/4page/sound/8.mp3',3,4,NULL,NULL),(9,'얼마 후에 산신령이 금도끼를 들고 나타났어요.','book/GoldAndSliverAxe/5page/sound/9.mp3',1,5,NULL,NULL),(10,'\"나무꾼아, 이 금도끼가 네 것이니?\"','book/GoldAndSliverAxe/5page/sound/10.mp3',2,5,NULL,NULL),(11,'\"아니요, 그 도끼는 제 것이 아니에요.\"','book/GoldAndSliverAxe/5page/sound/11.mp3',3,5,NULL,NULL),(12,'산신령은 다시 연못 속으로 사라졌어요.','book/GoldAndSliverAxe/5page/sound/12.mp3',4,5,NULL,NULL),(13,'이번에는 은도끼를 들고 나타났어요.','book/GoldAndSliverAxe/6page/sound/13.mp3',1,6,NULL,NULL),(14,'\"나무꾼아, 이 은도끼가 네 것이니?\"','book/GoldAndSliverAxe/6page/sound/14.mp3',2,6,NULL,NULL),(15,'\"아니요. 그 도끼도 제 것이 아니에요. 제 도끼는 낡은 쇠도끼에요.\"','book/GoldAndSliverAxe/6page/sound/15.mp3',3,6,NULL,NULL),(16,'나무꾼은 정직하게 대답했어요.','book/GoldAndSliverAxe/6page/sound/16.mp3',4,6,NULL,NULL),(17,'산신령이 또다시 연못 속으로 사라졌어요.','book/GoldAndSliverAxe/6page/sound/17.mp3',5,6,NULL,NULL),(18,'이번에는 낡은 쇠도끼를 들고 나타났어요.','book/GoldAndSliverAxe/7page/sound/18.mp3',1,7,NULL,NULL),(19,'\"나무꾼아, 이 낡은 쇠도끼가 네 것이니?\"','book/GoldAndSliverAxe/7page/sound/19.mp3',2,7,NULL,NULL),(20,'\"네, 맞아요. 그 도끼가 제 것입니다.\"','book/GoldAndSliverAxe/7page/sound/20.mp3',3,7,NULL,NULL),(21,'나무꾼은 낡은 쇠도끼를 받고 기뻐했어요.','book/GoldAndSliverAxe/7page/sound/21.mp3',4,7,NULL,NULL),(22,'\"산신령님, 정말 감사합니다.\"','book/GoldAndSliverAxe/7page/sound/22.mp3',5,7,NULL,NULL),(23,'\"너는 참 정직하구나. 착하고 정직한 너에게 이 금도끼와 은도끼를 상으로 주겠다.\"','book/GoldAndSliverAxe/8page/sound/23.mp3',1,8,NULL,NULL),(24,'정직한 나무꾼은 금도끼와 은도끼를 산신령께 상으로 받았어요.','book/GoldAndSliverAxe/8page/sound/24.mp3',2,8,NULL,NULL),(25,'옛날 옛날에 해님과 바람이 만났어요.','book/SunAndWind/1page/sound/25.mp3',1,9,NULL,NULL),(26,'바람이 말했어요.','book/SunAndWind/1page/sound/26.mp3',2,9,NULL,NULL),(27,'\"내가 힘이 제일 세.\"','book/SunAndWind/1page/sound/27.mp3',3,9,NULL,NULL),(28,'그러자 해님이 말했어요.','book/SunAndWind/1page/sound/28.mp3',4,9,NULL,NULL),(29,'\"아니야. 내가 힘이 제일 세.\"','book/SunAndWind/1page/sound/29.mp3',5,9,NULL,NULL),(30,'바람과 해님은 서로 힘이 세다고 싸웠어요.','book/SunAndWind/1page/sound/30.mp3',6,9,NULL,NULL),(31,'그때 한 남자가 길을 가고 있었어요.','book/SunAndWind/2page/sound/31.mp3',1,10,NULL,NULL),(32,'그 남자는 코트를 입고 있었어요.','book/SunAndWind/2page/sound/32.mp3',2,10,NULL,NULL),(33,'바람이 말했어요.','book/SunAndWind/2page/sound/33.mp3',3,10,NULL,NULL),(34,'\"우리 누가 힘이 더 센지 내기하자. 저 남자의 코트를 먼저 벗기면 이기는 거다.\"','book/SunAndWind/2page/sound/34.mp3',4,10,NULL,NULL),(35,'해님이 말했어요.','book/SunAndWind/2page/sound/35.mp3',5,10,NULL,NULL),(36,'\"그래, 좋아!\"','book/SunAndWind/2page/sound/36.mp3',6,10,NULL,NULL),(37,'바람이 말했어요.','book/SunAndWind/3page/sound/37.mp3',1,11,NULL,NULL),(38,'\"내가 먼저 해 볼게.\"','book/SunAndWind/3page/sound/38.mp3',2,11,NULL,NULL),(39,'바람이 입으로 바람을 불었어요.','book/SunAndWind/3page/sound/39.mp3',3,11,NULL,NULL),(40,'남자가 말했어요.','book/SunAndWind/3page/sound/40.mp3',4,11,NULL,NULL),(41,'\"바람이 시원하군.\"','book/SunAndWind/3page/sound/41.mp3',5,11,NULL,NULL),(42,'바람은 바람을 더욱 세게 불었어요.','book/SunAndWind/4page/sound/42.mp3',1,12,NULL,NULL),(43,'남자가 말했어요.','book/SunAndWind/4page/sound/43.mp3',2,12,NULL,NULL),(44,'\"오늘 날씨는 춥군.\"','book/SunAndWind/4page/sound/44.mp3',3,12,NULL,NULL),(45,'남자의 코트가 바람에 날아가려고 했어요.','book/SunAndWind/5page/sound/45.mp3',1,13,NULL,NULL),(46,'그래서 남자는 손으로 코트를 꽉 붙잡았어요.','book/SunAndWind/5page/sound/46.mp3',2,13,NULL,NULL),(47,'해님이 말했어요.','book/SunAndWind/6page/sound/47.mp3',1,14,NULL,NULL),(48,'\"바람아, 이제 내가 해 볼게.\"','book/SunAndWind/6page/sound/48.mp3',2,14,NULL,NULL),(49,'해님이 남자에게 해를 비췄어요.','book/SunAndWind/7page/sound/49.mp3',1,15,NULL,NULL),(50,'그러자 남자가 말했어요.','book/SunAndWind/7page/sound/50.mp3',2,15,NULL,NULL),(51,'\"이제는 따뜻하군.\"','book/SunAndWind/7page/sound/51.mp3',3,15,NULL,NULL),(52,'남자는 코트를 붙잡고 있던 손을 놓았어요.','book/SunAndWind/7page/sound/52.mp3',4,15,NULL,NULL),(53,'해님이 해를 더욱 세게 비췄어요.','book/SunAndWind/8page/sound/53.mp3',1,16,NULL,NULL),(54,'남자가 말했어요.','book/SunAndWind/8page/sound/54.mp3',2,16,NULL,NULL),(55,'\"이제는 덥군.\"','book/SunAndWind/8page/sound/55.mp3',3,16,NULL,NULL),(56,'남자는 땀을 닦으면서 코트를 벗었어요.','book/SunAndWind/8page/sound/56.mp3',4,16,NULL,NULL);
/*!40000 ALTER TABLE `book_page_sentence` ENABLE KEYS */;
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
