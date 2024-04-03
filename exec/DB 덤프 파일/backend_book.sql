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
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `book_id` bigint NOT NULL AUTO_INCREMENT,
  `price` int NOT NULL,
  `summary` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `cover_path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,5000,'어느 날, 한 가난한 나무꾼이 강가에서 나무를 하다가 실수로 도끼를 물에 빠뜨립니다. 그가 도끼를 잃어버린 것을 슬퍼하자, 산신령이 나타나 금도끼와 은도끼를 들고 나무꾼 앞에 나타납니다. 산신령은 나무꾼에게 이 금도끼와 은도끼 중 어느 것이 자신의 도끼냐고 묻습니다. 나무꾼은 정직하게 자신의 도끼는 둘 다 아니라고 대답합니다. 이에 감동한 산신령은 나무꾼의 정직함을 칭찬하며, 그에게 금도끼와 은도끼 뿐만 아니라 그의 원래 도끼도 함께 돌려줍니다. ','금도끼와 은도끼','book/GoldAndSliverAxe/cover.png'),(2,8500,'\"햇님과 바람\" 이야기에서 햇님과 바람은 자신들 중 누가 더 강한지를 결정하기 위해 한 여행자의 겉옷을 벗길 수 있는지로 경쟁을 합니다. 바람이 먼저 시도하지만, 여행자는 오히려 겉옷을 더 꽉 잡습니다. 실패한 바람에 이어, 햇님은 부드럽게 빛을 비추어 여행자로 하여금 스스로 겉옷을 벗게 만듭니다. 이를 통해, 부드러움과 친절함이 거친 힘보다 더 강력할 수 있음을 보여줍니다.','해님과 바람','book/SunAndWind/cover.png'),(3,8000,'개미와 베짱이','개미와 베짱이','book/AntAndGrasshopper/cover.png'),(4,7500,'소가 된 게으름뱅이','소가 된 게으름뱅이','book/LazyPersonTurnedCow/cover.png'),(5,10000,'싸우기 좋아하는 아들들','싸우기 좋아하는 아들들','book/SonWhoLikeToFight/cover.png'),(6,8500,'엄마 게와 아기 게','엄마 게와 아기 게','book/MotherCrabAndBabyCrab/cover.png'),(7,7500,'이슬 먹은 나귀','이슬 먹은 나귀','book/DewCoveredDonkey/cover.png'),(8,6000,'임금님 귀는 당나귀 귀','임금님 귀는 당나귀 귀','book/TheKingEars/cover.png'),(9,11000,'토끼와 거북이','토끼와 거북이','book/RabbitAndTurtle/cover.png'),(10,12000,'호랑이와 곶감','호랑이와 곶감','book/TigerAndDriedPersimmon/cover.png'),(11,9500,'황금알을 낳는 거위','황금알을 낳는 거위','book/GoldenEggs/cover.png'),(12,9000,'여우와 신 포도','여우와 신 포도','book/FoxAndSourGrapes/cover.png');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
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

-- Dump completed on 2024-04-03 12:10:25
