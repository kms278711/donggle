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
-- Table structure for table `book_page`
--

DROP TABLE IF EXISTS `book_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_page` (
  `book_page_id` bigint NOT NULL AUTO_INCREMENT,
  `book_image_path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `page` int NOT NULL,
  `book_id` bigint DEFAULT NULL,
  PRIMARY KEY (`book_page_id`),
  KEY `FKs20ajladoyi0gay1t6dtosfue` (`book_id`),
  CONSTRAINT `FKs20ajladoyi0gay1t6dtosfue` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_page`
--

LOCK TABLES `book_page` WRITE;
/*!40000 ALTER TABLE `book_page` DISABLE KEYS */;
INSERT INTO `book_page` VALUES (1,'book/GoldAndSliverAxe/1page/page1.png','옛날옛날에 나무꾼이 살았어요. 어느날 나무꾼은 나무를 하다가 도끼를 연못에 빠뜨렸어요.  ',1,1),(2,'book/GoldAndSliverAxe/2page/page2.png','\"아이구, 큰일 났구나. 하나밖에 없는 도끼인데... 새 도끼를 살 돈도 없는데 이제는 어떻게 나무를 하지?\' 나무꾼은 눈물이 났어요. 그때였어요. ',2,1),(3,'book/GoldAndSliverAxe/3page/page3.png','\'펑\' 소리가 나더니 연못에서 산신령이 나타났어요.',3,1),(4,'book/GoldAndSliverAxe/4page/page4.png','\"나무꾼아, 왜 울고 있니?\" \"하나밖에 없는 제 도끼가 연못에 빠졌어요.\" 산신령은 연못 속으로 사라졌어요.',4,1),(5,'book/GoldAndSliverAxe/5page/page5.png','얼마 후에 산신령이 금도끼를 들고 나타났어요. \"나무꾼아, 이 금도끼가 네 것이니?\" \"아니요, 그 도끼는 제 것이 아니에요.\" 산신령은 다시 연못 속으로 사라졌어요.',5,1),(6,'book/GoldAndSliverAxe/6page/page6.png','이번에는 은도끼를 들고 나타났어요. \"나무꾼아, 이 은도끼가 네 것이니?\" \"아니요. 그 도끼도 제 것이 아니에요. 제 도끼는 낡은 쇠도끼에요.\" 나무꾼은 정직하게 대답했어요. 산신령이 또다시 연못 속으로 사라졌어요.',6,1),(7,'book/GoldAndSliverAxe/7page/page7.png','이번에는 낡은 쇠도끼를 들고 나타났어요. \"나무꾼아, 이 낡은 쇠도끼가 네 것이니?\" \"네, 맞아요. 그 도끼가 제 것입니다.\" 나무꾼은 낡은 쇠도끼를 받고 기뻐했어요. \"산신령님, 정말 감사합니다.\"',7,1),(8,'book/GoldAndSliverAxe/8page/page8.png','\"너는 참 정직하구나. 착하고 정직한 너에게 이 금도끼와 은도끼를 상으로 주겠다.\" 정직한 나무꾼은 금도끼와 은도끼를 산신령께 상으로 받았어요.',8,1),(9,'book/SunAndWind/1page/page1.png','옛날 옛날에 해님과 바람이 만났어요. 바람이 말했어요. \"내가 힘이 제일 세.\" 그러자 해님이 말했어요. \"아니야. 내가 힘이 제일 세.\" 바람과 해님은 서로 힘이 세다고 싸웠어요.  ',1,2),(10,'book/SunAndWind/2page/page2.png','그때 한 남자가 길을 가고 있었어요. 그 남자는 코트를 입고 있었어요. 바람이 말했어요. \"우리 누가 힘이 더 센지 내기하자. 저 남자의 코트를 먼저 벗기면 이기는 거다.\" 해님이 말했어요. \"그래, 좋아!\"  ',2,2),(11,'book/SunAndWind/3page/page3.png','바람이 말했어요. \"내가 먼저 해 볼게.\" 바람이 입으로 바람을 불었어요. 남자가 말했어요. \"바람이 시원하군.\" ',3,2),(12,'book/SunAndWind/4page/page4.png','바람은 바람을 더욱 세게 불었어요. 남자가 말했어요. \"오늘 날씨는 춥군.\"',4,2),(13,'book/SunAndWind/5page/page5.png','남자의 코트가 바람에 날아가려고 했어요. 그래서 남자는 손으로 코트를 꽉 붙잡았어요.',5,2),(14,'book/SunAndWind/6page/page6.png','해님이 말했어요. \"바람아, 이제 내가 해 볼게.\"',6,2),(15,'book/SunAndWind/7page/page7.png','해님이 남자에게 해를 비췄어요. 그러자 남자가 말했어요. \"이제는 따뜻하군.\" 남자는 코트를 붙잡고 있던 손을 놓았어요.',7,2),(16,'book/SunAndWind/8page/page8.png','해님이 해를 더욱 세게 비췄어요. 남자가 말했어요. \"이제는 덥군.\" 남자는 땀을 닦으면서 코트를 벗었어요.',8,2);
/*!40000 ALTER TABLE `book_page` ENABLE KEYS */;
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

-- Dump completed on 2024-04-03 12:10:24
