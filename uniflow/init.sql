CREATE DATABASE IF NOT EXISTS uniflow;
USE uniflow;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table client
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client`;

CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_480f88a019346eae487a0cd7f0` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;

INSERT INTO `client` (`id`, `uid`, `name`, `created`, `updated`)
VALUES
	(1,'34b21fcb-b77d-4c7e-a3f5-21e290d7a056','uniflow','2021-10-02 17:25:40.207987','2021-10-02 17:25:40.207987'),
	(2,'0f63cbd0-aeb8-4f32-82dc-db67d8da88dd','node','2021-10-02 17:25:40.218839','2021-10-02 17:25:40.218839'),
	(3,'d67214a1-c17b-4c52-a3d8-3a0a1daba72b','vscode','2021-10-02 17:25:40.225155','2021-10-02 17:25:40.225155');

/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `config`;

CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `created` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table contact
# ------------------------------------------------------------

DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table folder
# ------------------------------------------------------------

DROP TABLE IF EXISTS `folder`;

CREATE TABLE `folder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `created` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `userId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_a0ef64d088bc677d66b9231e90b` (`userId`),
  KEY `FK_9ee3bd0f189fb242d488c0dfa39` (`parentId`),
  CONSTRAINT `FK_9ee3bd0f189fb242d488c0dfa39` FOREIGN KEY (`parentId`) REFERENCES `folder` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_a0ef64d088bc677d66b9231e90b` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table lead
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lead`;

CREATE TABLE `lead` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `email` varchar(255) NOT NULL,
  `githubUsername` varchar(255) DEFAULT NULL,
  `optinNewsletter` tinyint(4) NOT NULL DEFAULT '0',
  `optinBlog` tinyint(4) NOT NULL DEFAULT '0',
  `optinGithub` tinyint(4) NOT NULL DEFAULT '0',
  `created` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_82927bc307d97fe09c616cd3f5` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table migration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migration`;

CREATE TABLE `migration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table program
# ------------------------------------------------------------

DROP TABLE IF EXISTS `program`;

CREATE TABLE `program` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text,
  `isPublic` tinyint(4) NOT NULL DEFAULT '0',
  `data` text,
  `created` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `userId` int(11) DEFAULT NULL,
  `folderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_d593ec621c4a47fd51ab7f9a23d` (`userId`),
  KEY `FK_2165fa69087713182f1be8720bc` (`folderId`),
  CONSTRAINT `FK_2165fa69087713182f1be8720bc` FOREIGN KEY (`folderId`) REFERENCES `folder` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_d593ec621c4a47fd51ab7f9a23d` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table program_client
# ------------------------------------------------------------

DROP TABLE IF EXISTS `program_client`;

CREATE TABLE `program_client` (
  `programId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  PRIMARY KEY (`programId`,`clientId`),
  KEY `FK_78366ad186809dbba54265ab381` (`clientId`),
  CONSTRAINT `FK_78366ad186809dbba54265ab381` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_bc56fa1950c46adc2786154599b` FOREIGN KEY (`programId`) REFERENCES `program` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table program_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `program_tag`;

CREATE TABLE `program_tag` (
  `programId` int(11) NOT NULL,
  `tagId` int(11) NOT NULL,
  PRIMARY KEY (`programId`,`tagId`),
  KEY `FK_7b566c884ac4a5f97d80d98638f` (`tagId`),
  CONSTRAINT `FK_7b566c884ac4a5f97d80d98638f` FOREIGN KEY (`tagId`) REFERENCES `tag` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_8b479c92ab9068d8606faa3a57e` FOREIGN KEY (`programId`) REFERENCES `program` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tag`;

CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_6a9775008add570dc3e5a0bab7` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `username` varchar(32) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(64) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `facebookId` varchar(255) DEFAULT NULL,
  `githubId` varchar(255) DEFAULT NULL,
  `apiKey` varchar(255) DEFAULT NULL,
  `role` varchar(255) NOT NULL,
  `created` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_e12875dfb3b1d92d7d7c5377e2` (`email`),
  UNIQUE KEY `IDX_78a916df40e02a9deb1c4b75ed` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `uid`, `username`, `email`, `password`, `salt`, `firstname`, `lastname`, `facebookId`, `githubId`, `apiKey`, `role`, `created`, `updated`)
VALUES
	(1,'c02869d7-ed19-4eec-b77f-c4fa7ccd4eb1',NULL,'admin@uniflow.io','$argon2i$v=19$m=4096,t=3,p=1$qbkVJUoVmPmzEq7turhGSSJ28+BYO4UQ+eiBkPiw0TA$CtfpYsqQ4t5g6Gls942c6ZcVYSzMi3mN1N6rtMzFT/o','a9b915254a1598f9b312aeedbab846492276f3e0583b8510f9e88190f8b0d130','Admin','Admin',NULL,NULL,NULL,'ROLE_SUPER_ADMIN','2021-10-02 17:25:39.987410','2021-10-02 17:25:39.987410');

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
