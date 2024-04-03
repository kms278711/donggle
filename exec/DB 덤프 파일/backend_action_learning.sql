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
-- Table structure for table `action_learning`
--

DROP TABLE IF EXISTS `action_learning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action_learning` (
  `action_id` bigint NOT NULL AUTO_INCREMENT,
  `user_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `education_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`action_id`),
  KEY `FKir4t2v7ur9rf99xe8q3xjm3tt` (`education_id`),
  KEY `FK7nw5mmbsvjns1mk4x4ehhp832` (`user_id`),
  CONSTRAINT `FK7nw5mmbsvjns1mk4x4ehhp832` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKir4t2v7ur9rf99xe8q3xjm3tt` FOREIGN KEY (`education_id`) REFERENCES `education` (`education_id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_learning`
--

LOCK TABLES `action_learning` WRITE;
/*!40000 ALTER TABLE `action_learning` DISABLE KEYS */;
INSERT INTO `action_learning` VALUES (78,'word/user/73/1/9db72fab-5870-4da1-9cc0-5a5a6a156299',1,73),(79,'word/user/73/2/3a65f8d4-daf7-4b37-babc-09bb5dc3b800',2,73),(80,'word/user/73/3/8e35560f-7326-4742-bfb6-247dd1e19396',3,73),(81,'word/user/73/1/39bbcf04-83b2-4cd7-8b74-dfba70567b79',1,73),(82,'word/user/73/1/3216d7f6-1ff1-41cc-a508-a31f9f310e2a',1,73),(83,'word/user/73/6/7518b3dc-2fed-405d-bfc6-ca7e26bf92db',6,73),(84,'word/user/73/8/3f2e0851-0d08-42b5-a3bf-5dec6e8c256b',8,73),(85,'word/user/73/1/3d13efe6-f1dc-4971-8701-e9a4d4ab1733',1,73),(86,'word/user/73/2/59aaf495-7076-440c-adfe-8bb2db591c76',2,73),(87,'word/user/73/3/28caffea-28e8-4a62-83f0-7eeb48800e52',3,73),(88,'word/user/73/1/9079c389-fd79-4def-9a6c-00ff41b63a82',1,73),(89,'word/user/73/1/b15bf985-5bc7-423a-b3f1-d6aa0c273938',1,73),(90,'word/user/73/2/a734fa1a-adc1-42e3-aad9-d770a168781c',2,73),(129,'word/user/77/1/ed9667c1-9d60-43d0-b991-aa181cced06d',1,77),(130,'word/user/78/1/21e309a6-d86b-4eef-b002-341ec14ed289',1,78),(131,'word/user/78/1/f9d55607-e5f2-4d7d-9ea1-6e0443774b6f',1,78),(132,'word/user/78/2/4502efa9-a8ba-4ded-b1aa-d435411f1f1f',2,78),(133,'word/user/77/1/68ac2b65-bdf0-4aab-bdbd-2686743f29d4',1,77),(134,'word/user/78/2/bf05d518-109a-4829-bf5d-0ff887e4a3f3',2,78),(135,'word/user/77/1/2ba51078-0f0d-4324-a8ec-413beae5a9bb',1,77),(136,'word/user/78/3/5d09ce72-d0f2-4a31-ae0f-7357f5e6622e',3,78),(137,'word/user/77/6/59710d4f-01f4-499b-ba0c-a173cee7cd89',6,77),(138,'word/user/78/6/1b4f42d3-e851-4652-b954-88bb86792caa',6,78),(139,'word/user/77/8/47be473c-8a20-415e-8d11-ab1550da7e80',8,77),(140,'word/user/78/6/4e2f222c-08f9-4394-b979-f7bfb84f5543',6,78),(141,'word/user/78/8/48bb7db6-cc05-4b07-9b36-57097fc971ae',8,78),(142,'word/user/78/8/21c62655-d39e-42bc-bd21-b374ac1360f2',8,78),(143,'word/user/78/8/05fbcb41-bcb8-46e5-bcc8-938db7777eaf',8,78),(144,'word/user/77/1/e052de8c-bf00-4b9b-8276-873c51a989ad',1,77),(145,'word/user/77/1/78271f54-22fb-427e-a8d5-40f05249b372',1,77),(146,'word/user/77/1/ff51a932-5f85-455c-a510-1e1fbca7f051',1,77),(147,'word/user/77/2/0a3bb2bc-6149-4107-a7cc-b56f5581f093',2,77),(148,'word/user/78/8/01ceaef1-38ba-4c57-b205-ec2b725a3f44',8,78),(149,'word/user/78/6/5d1017eb-3203-4da3-a925-239a45168195',6,78),(150,'word/user/78/6/3be75c90-bb9d-416d-90a4-6418fd859643',6,78),(151,'word/user/77/3/fa3563ac-eeb5-4224-a280-95302db60560',3,77),(152,'word/user/78/6/a4c8efc9-c88a-4e38-9bb1-b2e03f6186e1',6,78),(153,'word/user/77/3/5aa0ae89-9ca4-415e-842e-43bd446eae95',3,77),(154,'word/user/77/8/9b1f3335-f1d3-431d-8e00-16d1a6a74771',8,77),(155,'word/user/78/3/7f5bf2cc-51fb-47f3-84ee-004a11889f82',3,78),(156,'word/user/78/3/25da8c6a-366a-453f-9730-ca94424bb116',3,78),(157,'word/user/78/8/f0bd9cf6-108b-4b16-916c-78d2b958ac77',8,78),(158,'word/user/78/1/c29357e7-3299-4280-ac99-6b560115db96',1,78),(159,'word/user/77/3/cd0a2771-2d7f-4e9f-b029-a249afcc2596',3,77);
/*!40000 ALTER TABLE `action_learning` ENABLE KEYS */;
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
