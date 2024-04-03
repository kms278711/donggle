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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profile_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` enum('ROLE_USER','ROLE_ADMIN') COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('MEMBER','WITHDRAWAL') COLLATE utf8mb4_general_ci NOT NULL,
  `provider` enum('GOOGLE','NAVER','KAKAO') COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UK_ob8kqyqqgmefl0aco34akdtpe` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (73,'2024-04-01 16:51:46.451496','2024-04-01 17:18:56.653924','ssafy@ssafy.com','나는 도끼','{bcrypt}$2a$10$ca/LqrVliJWfwKAqCwfUVOwQHx8bbMrmWNva4ZSylPogpO.zRzDrq','userprofile/73/461ad8e8-3650-4d0e-84e4-39b8db91a57e','ROLE_USER','MEMBER',NULL),(77,'2024-04-03 09:12:23.435280','2024-04-03 10:16:53.838542','1@test.com','qqq','{bcrypt}$2a$10$W90tE8H5v0.o/1bbyEwGDuxJeJb.wQwA8Xr8Nk2LDnEhnjTjML4r.','userprofile/77/4ae11f16-5ac5-4966-85d4-a139e7cb0c58','ROLE_USER','MEMBER',NULL),(78,'2024-04-03 09:12:56.537519','2024-04-03 10:29:04.914308','2@test.com','이민규짱','{bcrypt}$2a$10$IlOsG2ulTt6Jb1wCAl8DRuqY7GbbkY17YhLPYMvORYWRjvnU4nxTq','userprofile/78/8cc680b5-2638-46c9-8362-559fa96e8025','ROLE_USER','MEMBER',NULL),(79,'2024-04-03 09:13:18.416978','2024-04-03 09:13:18.416978','3@test.com','대담한 별자리','{bcrypt}$2a$10$gErpjXhR9i71/s7K3Qs0Je/BQm97XDsazKoeijDChOsuOIjF36DNK','userprofile/defaultImage.jpg','ROLE_USER','MEMBER',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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
