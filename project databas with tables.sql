CREATE DATABASE  IF NOT EXISTS `project2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `project2`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: project2
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `password_` varchar(45) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admins_uq` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'ahmed','y','admin_1','123456'),(2,'mohamed','m','admin_2','123456'),(3,'salem','s','admin_3','123456');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `claims`
--

DROP TABLE IF EXISTS `claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `claims` (
  `claim_id` int NOT NULL AUTO_INCREMENT,
  `service_description` varchar(200) DEFAULT NULL,
  `claim_state` varchar(15) DEFAULT NULL,
  `hospital_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `admin_id` int DEFAULT NULL,
  `total_service_price` float NOT NULL,
  `claim_date` date DEFAULT NULL,
  PRIMARY KEY (`claim_id`),
  KEY `customers_claims_fk` (`customer_id`),
  KEY `hospitals_claims_fk` (`hospital_id`),
  KEY `admins_claims_fk` (`admin_id`),
  CONSTRAINT `admins_claims_fk` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`),
  CONSTRAINT `customers_claims_fk` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `hospitals_claims_fk` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`hospital_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claims`
--

LOCK TABLES `claims` WRITE;
/*!40000 ALTER TABLE `claims` DISABLE KEYS */;
INSERT INTO `claims` VALUES (1,'uu76','Reject',1,1,NULL,1200,'2021-12-01'),(3,'qqqqq','Accept',1,1,NULL,1222,'2021-12-16'),(5,'ffff','Accept',1,1,NULL,13333,'2021-12-10'),(6,'cfcffc','Accept',2,1,NULL,1444,'2021-12-17'),(7,'ewqd','Reject',3,2,NULL,1233,'2021-12-20'),(8,'hghjgh','Reject',3,1,NULL,288,'2021-12-09'),(11,'fedf','Reject',5,1,NULL,22221,'2022-01-04'),(12,'fdsfd','',59,1,NULL,33444,'2021-12-14'),(13,'hfgh','Accept',59,1,NULL,5000,'2021-12-16'),(14,'hgfhgf','',54,2,NULL,2009,'2021-12-29'),(15,'fdf','',63,1,NULL,20003,'2022-01-20'),(16,'jgjjjjj',NULL,62,2,NULL,4000,'2022-01-12'),(17,'jjy',NULL,62,1,NULL,4747,'2022-01-16'),(18,'gfhfgh',NULL,56,1,NULL,15000,'2022-01-20'),(19,'fdgfd',NULL,58,1,NULL,15000,'2022-01-18'),(20,'fbvbvcbvcb','Accept',1,1,NULL,50045,'2022-02-04'),(21,'ggfklddjl',NULL,55,3,NULL,15000,'2022-01-20'),(22,'bfgfgh',NULL,64,2,NULL,15555,'2022-01-12'),(23,'nngfh',NULL,68,1,NULL,66666,'2022-01-26'),(24,'gfhfgh',NULL,58,1,NULL,55555,'2022-01-06'),(25,'5o;i;io',NULL,62,1,NULL,50000,'2021-12-29'),(26,'fgghfgh',NULL,61,1,NULL,12333,'2022-01-18'),(27,'hfghf',NULL,56,1,NULL,2324,'2022-01-18'),(28,'fjgfh',NULL,67,2,NULL,1523,'2022-01-28');
/*!40000 ALTER TABLE `claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `parent_id` int DEFAULT NULL,
  `phone` int DEFAULT NULL,
  `governorate` varchar(200) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `user_name` varchar(30) NOT NULL,
  `password_` varchar(45) NOT NULL,
  `credit_card_number` varchar(16) DEFAULT NULL,
  `exp_date` varchar(5) DEFAULT NULL,
  `cvv` int DEFAULT NULL,
  `plan_id` tinyint NOT NULL,
  `admin_id` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customers_uk` (`user_name`,`phone`),
  UNIQUE KEY `credit_card_number_UNIQUE` (`credit_card_number`),
  KEY `plans_customers_fk` (`plan_id`),
  KEY `admins_customers_fk` (`admin_id`),
  CONSTRAINT `admins_customers_fk` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`),
  CONSTRAINT `plans_customers_fk` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'ahmed','yousry',NULL,NULL,'b','k','user_1','123456',NULL,NULL,NULL,1,1),(2,'mohamed','alqblawi',NULL,NULL,'g','m','user_2','123456',NULL,NULL,NULL,2,1),(3,'abdelrahman','ezzat',NULL,NULL,'g','t','user_3','123456',NULL,NULL,NULL,3,1),(4,'ah','ahmed',1,NULL,'b','k','user_4','123456',NULL,NULL,NULL,3,1),(5,'mo','mohamed',2,NULL,'g','m','user_5','123456',NULL,NULL,NULL,2,1),(6,'abd','abdelrahman',3,NULL,'g','t','user-6','123456',NULL,NULL,NULL,1,1);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital_has_plans`
--

DROP TABLE IF EXISTS `hospital_has_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_has_plans` (
  `hospital_id` int NOT NULL,
  `plan_id` tinyint NOT NULL,
  PRIMARY KEY (`hospital_id`,`plan_id`),
  KEY `plans_hospital_has_plans_fk` (`plan_id`),
  CONSTRAINT `hospitals_hospital_has_plans_fk` FOREIGN KEY (`hospital_id`) REFERENCES `hospitals` (`hospital_id`),
  CONSTRAINT `plans_hospital_has_plans_fk` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital_has_plans`
--

LOCK TABLES `hospital_has_plans` WRITE;
/*!40000 ALTER TABLE `hospital_has_plans` DISABLE KEYS */;
INSERT INTO `hospital_has_plans` VALUES (1,1),(2,1),(3,1),(5,1),(6,1),(49,1),(50,1),(54,1),(55,1),(56,1),(58,1),(59,1),(60,1),(61,1),(62,1),(66,1),(69,1),(71,1),(1,2),(2,2),(4,2),(5,2),(54,2),(55,2),(56,2),(58,2),(59,2),(60,2),(62,2),(64,2),(65,2),(66,2),(67,2),(68,2),(69,2),(70,2),(2,3),(5,3),(55,3),(56,3),(58,3),(61,3),(64,3),(65,3),(67,3),(68,3);
/*!40000 ALTER TABLE `hospital_has_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospitals`
--

DROP TABLE IF EXISTS `hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospitals` (
  `hospital_id` int NOT NULL AUTO_INCREMENT,
  `hospital_name` varchar(50) NOT NULL,
  `hospital_kind` varchar(25) DEFAULT NULL,
  `hospital_Specialties` varchar(100) DEFAULT NULL,
  `governorate` varchar(200) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `admin_id` int NOT NULL,
  PRIMARY KEY (`hospital_id`),
  KEY `admins_hospitals_fk` (`admin_id`),
  CONSTRAINT `admins_hospitals_fk` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospitals`
--

LOCK TABLES `hospitals` WRITE;
/*!40000 ALTER TABLE `hospitals` DISABLE KEYS */;
INSERT INTO `hospitals` VALUES (1,'H1','1','X','G','T',1),(2,'H2','0','B','G','M',1),(3,'H3','0','X','B','D',1),(4,'H4','0','X','B','K',1),(5,'H5','1','X','C','C',1),(6,'erer','rere','rere','rere','erer',2),(7,'ffffffffffff','ffffffffff','ffffffffffffff','North Sinai Governorate','ffffffffff',2),(48,'cscs','ssssaaa','asa','Monufia Governorate','sddss',2),(49,'fdfdfdc','fddd','dfdfd','Minya Governorate','fdfdfdddd',2),(50,'dsxxx','xxxx','xxx','Qena Governorate','xa',2),(51,'fdfccccxx','zcxz','xxcxc','North Sinai Governorate','cxzzx',2),(54,'wwwwwwwq','eweq','qqqqqqqqqqw','New Valley Governorate','dssd',2),(55,'csscsdd','asdsad','dddsda','North Sinai Governorate','scscs',2),(56,'asq','sqq','sqsq','Minya Governorate','ccxz',2),(58,'qqwwwwww','sasas','saaaa','Minya Governorate','dsds',2),(59,'dsdvvv','vdvd','dddvd','Minya Governorate','sddsd',2),(60,'wdwqqq','dsad','sasa','Monufia Governorate','ds',2),(61,'fdfsq','cxzxcxz','sdcx','Matruh Governorate','cxzzxaa',2),(62,'gggg','fgfg','ggg','Alexandria Governorate','gfd',2),(63,'ds','dsd','dsd','sd','dsd',2),(64,'mjjum','nhnh','jujunn','Matruh Governorate','njnj',2),(65,'ngn','ngb','ngh','Luxor Governorate','ngng',2),(66,'ndsfk','dfsdf','dhfdls','Minya Governorate','sdsa',2),(67,'jghj','jghghj','jgh','Minya Governorate','tanta',2),(68,'vfgdf','gdfgdf','gfdg','Minya Governorate','gdf',2),(69,'mjh','hmj','mjh','Matruh Governorate','jthj',2),(70,'hfgh','hfgh','fghf','Matruh Governorate','hfghfgh',1),(71,'hgngh','ngh','nghnh','Port Said Governorate[5]','ngnhg',2);
/*!40000 ALTER TABLE `hospitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `plan_id` tinyint NOT NULL AUTO_INCREMENT,
  `plan_name` varchar(45) NOT NULL,
  `total_price` float NOT NULL,
  `discount_percentage` float NOT NULL,
  `admin_id` int NOT NULL,
  PRIMARY KEY (`plan_id`),
  KEY `admins_plans_fk` (`admin_id`),
  CONSTRAINT `admins_plans_fk` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,'Basic',5000,30,1),(2,'Premium',8000,40,1),(3,'Golden',10000,50,1);
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'project2'
--
/*!50003 DROP PROCEDURE IF EXISTS `accept_reject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `accept_reject`(
IN _f_name varchar(100),
IN id varchar(100)
)
BEGIN
START TRANSACTION;
UPDATE project2.claims 
SET 
    claim_state =(_f_name)
WHERE
    claim_id = (id);
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `adduser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `adduser`(
IN _f_name VARCHAR(100),
IN _l_name VARCHAR(100),
IN _plan VARCHAR(100),
IN _name VARCHAR(100),
IN _password VARCHAR(100),
IN _gv VARCHAR(200),
IN _city VARCHAR(100),
IN _adminid INT,
IN _phone int
)
BEGIN
if ( select exists (select 1 from customers where user_name = _name) ) THEN
        select 'Username Exists !!';
    ELSE
    insert into customers
        (first_name, last_name,plan_id, Governorate, city,user_name,password_,admin_id ,phone)
        values
        (_f_name,_l_name,_plan,_gv, _city,_name, _password,_adminid,_phone);
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `call_admin_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `call_admin_name`(IN _adminid int )
BEGIN
select concat(first_name,' ',last_name)  AS fullname from admins where admin_id = _adminid  ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `call_all_parent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `call_all_parent`()
BEGIN
select customer_id, first_name, last_name , user_name  from customers
where parent_id is null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `call_dependent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `call_dependent`()
BEGIN
SELECT  first_name, last_name, parent_id, phone, governorate, city, user_name,plan_name
 from customers c
 join plans p on p.plan_id = c.plan_id
 where parent_id is not null;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `call_users` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `call_users`()
BEGIN
SELECT  first_name, last_name, parent_id, phone, governorate, city, user_name, plan_name
 from customers c
 join plans p on p.plan_id = c.plan_id
 where parent_id is null;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `call_user_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `call_user_name`(IN _userid int )
BEGIN
select concat(first_name,' ',last_name)  AS fullname from customers where customer_id = _userid  ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `claim_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `claim_all`()
BEGIN
SELECT  first_name, last_name, user_name, service_description ,claim_date ,total_service_price,claim_state
 from customers c
 join claims p on p.customer_id = c.customer_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `claim_unsolved` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `claim_unsolved`()
BEGIN
SELECT  first_name, last_name, user_name, service_description ,claim_date ,total_service_price,claim_id,claim_state
 from customers c
 join claims p on p.customer_id = c.customer_id
 where claim_state is NUll;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createclaim1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createclaim1`(
IN _price int,
IN _date VARCHAR(50),
IN _description VARCHAR(200),
IN _hospitalid INT,
IN _customerid INT
)
BEGIN

		insert into claims
        (total_service_price, claim_date, service_description,hospital_id,customer_id)
        values
        (_price,_date,_description,_hospitalid,_customerid);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createdepnt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createdepnt`(
IN _f_name VARCHAR(100),
IN _l_name VARCHAR(100),
IN _plan VARCHAR(100),
IN _parent VARCHAR(100),
IN _name VARCHAR(100),
IN _password VARCHAR(100),
IN _gv VARCHAR(200),
IN _city VARCHAR(100),
IN _adminid int,
IN _phone int
)
BEGIN
if ( select exists (select 1 from customers where user_name = _name) ) THEN
        select 'parent_id Exists !!';
    ELSE
    insert into customers
        (first_name, last_name,plan_id,parent_id, governorate, city,user_name,password_,admin_id ,phone)
        values
        (_f_name,_l_name,_plan,_parent,_gv, _city,_name, _password,_adminid,_phone);
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createhosp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createhosp`(
IN _name VARCHAR(100),
IN _HospitalKind VARCHAR(100),
IN _Specialities VARCHAR(100),
IN _gv VARCHAR(200),
IN _city VARCHAR(100),
IN _adminid INT
)
BEGIN
if ( select exists (select 1 from hospitals where hospital_name = _name) ) THEN
        select 'Hospital Exists !!';
    ELSE
    insert into hospitals
        (hospital_name,hospital_kind,hospital_Specialties,governorate, city,admin_id)
        values
        (_name,_HospitalKind,_Specialities,_gv, _city,_adminid);
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createhospitalhas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createhospitalhas`(
IN _planid INT,
IN hospitall_id INT
)
BEGIN
    insert into hospital_has_plans
        (plan_id , hospital_id )
        values
        (_planid,hospitall_id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createUser1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createUser1`(
IN _f_name VARCHAR(100),
IN _l_name VARCHAR(100),
IN _plan VARCHAR(100),
IN _name VARCHAR(100),
IN _password VARCHAR(100),
IN _gv VARCHAR(200),
IN _city VARCHAR(100),
IN _card VARCHAR(16),
IN _exp_date VARCHAR(5),
IN _cvs VARCHAR(3),
IN _phone int
)
BEGIN
if ( select exists (select 1 from customers where user_name = _name) ) THEN
        select 'Username Exists !!';
    ELSE
    insert into customers
        (first_name, last_name,plan_id, Governorate, city,user_name,password_,credit_card_number,exp_date,cvs,phone)
        values
        (_f_name,_l_name,_plan,_gv, _city,_name, _password,_card,_exp_date,_cvs,_phone);
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_users` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_users`()
BEGIN
SELECT * FROM customers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `hospital_plans` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `hospital_plans`(IN _planid varchar(10))
BEGIN

SELECT DISTINCT hospital_name ,hospital_kind,hospital_Specialties,city 
 from hospitals c 
 join hospital_has_plans n on c.hospital_id = n.hospital_id
 join plans p on p.plan_id = n.plan_id
 where p.plan_id = (_planid);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `hospital_with_plans` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `hospital_with_plans`()
BEGIN
SELECT *
 from hospitals c 
 join hospital_has_plans n on c.hospital_id = n.hospital_id
 join plans p on p.plan_id = n.plan_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `plans_review` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `plans_review`(IN _planid int)
BEGIN
select *  from plans where plan_id = (_planid);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `signup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `signup`(
IN _f_name VARCHAR(100),
IN _l_name VARCHAR(100),
IN _plan VARCHAR(100),
IN _name VARCHAR(100),
IN _password VARCHAR(100),
IN _gv VARCHAR(200),
IN _city VARCHAR(100),
IN _card VARCHAR(16),
IN _exp_date VARCHAR(5),
IN _cvv int,
IN _phone VARCHAR(11)
)
BEGIN
if ( select exists (select 1 from customers where user_name = _name) ) THEN
        select 'Username Exists !!';
    ELSE
    insert into customers
        (first_name, last_name,plan_id, Governorate, city,user_name,password_,credit_card_number,exp_date,cvv,phone)
        values
        (_f_name,_l_name,_plan,_gv, _city,_name, _password,_card,_exp_date,_cvv,_phone);
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usolved` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usolved`(
IN _f_name varchar(100),
IN id varchar(100)
)
BEGIN
START TRANSACTION;
UPDATE project2.claims 
SET 
    claim_state =(_f_name)
WHERE
    claim_id = (id);
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `val_admin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `val_admin`(IN userName VARCHAR(40),IN Passsword VARCHAR(40))
BEGIN
select * from admins where user_name = userName and password_ =Passsword ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `val_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `val_user`(IN userName VARCHAR(40) ,IN Passsword VARCHAR(40))
BEGIN
select * from customers where user_name = userName and password_=Passsword ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vew_hospital` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `vew_hospital`( in cust INT )
BEGIN
SELECT DISTINCT h.hospital_id,hospital_name , hospital_kind , hospital_Specialties,h.governorate ,h.city
 from customers c JOIN plans p ON c.plan_id = p.plan_id 
 JOIN hospital_has_plans hp ON p.plan_id = hp.plan_id
 JOIN hospitals h ON hp.hospital_id = h.hospital_id
 WHERE c.customer_id = cust ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-09  0:19:32
