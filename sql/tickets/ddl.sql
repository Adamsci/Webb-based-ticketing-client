-- MySQL Script generated by MySQL Workbench
-- Sat Sep 21 08:02:28 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tickets
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tickets` ;

-- -----------------------------------------------------
-- Schema tickets
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tickets` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema tickets
-- -----------------------------------------------------
USE `tickets` ;

-- -----------------------------------------------------
-- Table `tickets`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tickets`.`user` ;

CREATE TABLE IF NOT EXISTS `tickets`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` CHAR(100) NULL,
  `username` CHAR(10) NULL,
  `email` CHAR(250) NOT NULL,
  `is_agent` TINYINT NOT NULL,
  `role` CHAR(20) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tickets`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tickets`.`category` ;

CREATE TABLE IF NOT EXISTS `tickets`.`category` (
  `name` CHAR(40) NOT NULL,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `tickets`.`ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tickets`.`ticket` ;

CREATE TABLE IF NOT EXISTS `tickets`.`ticket` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `description` TEXT(2000) NULL,
  `status` CHAR(12) NOT NULL,
  `user_id` INT NOT NULL,
  `agent_id` INT NULL,
  `category_name` CHAR(40) NOT NULL,
  `skapad_datum` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `file_data` LONGBLOB NULL,
  `file_name` BLOB NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ticket_agent_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_ticket_category1_idx` (`category_name` ASC) VISIBLE,
  INDEX `fk_ticket_user1_idx` (`agent_id` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_agent0`
    FOREIGN KEY (`user_id`)
    REFERENCES `tickets`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_category1`
    FOREIGN KEY (`category_name`)
    REFERENCES `tickets`.`category` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_user1`
    FOREIGN KEY (`agent_id`)
    REFERENCES `tickets`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `tickets`.`ticket_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tickets`.`ticket_comment` ;

CREATE TABLE IF NOT EXISTS `tickets`.`ticket_comment` (
  `ticket_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `title` CHAR(80) NULL,
  `comment` TEXT(1000) NULL,
  `comment_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_ticket_comment_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_file_ticket10`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `tickets`.`ticket` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `tickets`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `tickets`.`article`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tickets`.`article` ;

CREATE TABLE IF NOT EXISTS `tickets`.`article` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `content` TEXT(10000) NOT NULL,
  `created_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` INT NOT NULL,
  `category_name` CHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ticket_agent_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_ticket_category1_idx` (`category_name` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_agent00`
    FOREIGN KEY (`user_id`)
    REFERENCES `tickets`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_category10`
    FOREIGN KEY (`category_name`)
    REFERENCES `tickets`.`category` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `tickets`.`current_session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tickets`.`current_session` ;

CREATE TABLE IF NOT EXISTS `tickets`.`current_session` (
  `user_email` CHAR(250) NULL,
  PRIMARY KEY (`user_email`))
ENGINE = InnoDB;

-- Procedures

DROP PROCEDURE IF EXISTS select_from_db;

DELIMITER ;;

CREATE PROCEDURE select_from_db(
    IN to_get CHAR(20),
    IN num INTEGER(3),
    IN chr CHAR(250)
)
BEGIN
  IF to_get = 'categories' THEN
    SELECT * FROM category;
  ELSEIF to_get = 'ticket-info' THEN
    SELECT
      t.id,
      t.title,
      t.status,
      CONCAT(SUBSTRING(t.description, 1, 30), "...") AS description,
      t.category_name AS category,
      DATE_FORMAT(t.skapad_datum, '%Y-%m-%d %H:%i:%s') AS skapad_datum,
      t.status,
      user_user.email AS user_email,
      agent_user.email AS agent_email
    FROM ticket t
    INNER JOIN user user_user ON user_user.id = t.user_id
    LEFT JOIN user agent_user ON agent_user.id = t.agent_id;
  ELSEIF to_get = 'ticket-info-one' THEN
    SELECT
      t.id,
      t.title,
      t.status,
      t.description AS description,
      t.category_name AS category,
      DATE_FORMAT(t.skapad_datum, '%Y-%m-%d %H:%i:%s') AS skapad_datum,
      t.status,
      user_user.email AS user_email,
      agent_user.email AS agent_email,
      t.file_data,
      t.file_name
    FROM ticket t
    INNER JOIN user user_user ON user_user.id = t.user_id
    LEFT JOIN user agent_user ON agent_user.id = t.agent_id
    WHERE
      num = t.id;
  ELSEIF to_get = 'comments' THEN
    SELECT
      tc.ticket_id,
      tc.title AS c_title,
      tc.comment,
      tc.comment_date,
      u.name AS c_name,
      u.email AS email
    FROM
      ticket_comment tc
    INNER JOIN
      user u ON u.id = tc.user_id
    WHERE
      num = tc.ticket_id;
  ELSEIF to_get = 'users' THEN
    SELECT
      id AS user_id,
      name,
      email,
      is_agent,
      role
    FROM
      user
    WHERE email = chr;
  ELSEIF to_get = 'session2' THEN
    SELECT
      *
    FROM
      current_session;
  ELSEIF to_get = 'session' THEN
    SELECT
      cs.user_email,
      u.is_agent,
      u.role
    FROM
      current_session cs
    LEFT JOIN
      user u ON u.email = cs.user_email;
  ELSEIF to_get = 'all-users' THEN
    SELECT
      *
    FROM
      user;
  ELSEIF to_get = 'articles' THEN
    SELECT
      a.id,
      a.title,
      a.category_name,
      DATE_FORMAT(a.created_date, '%Y-%m-%d %H:%i:%s') AS created_date,
      CONCAT(SUBSTRING(a.content, 1, 30), "...") AS content,
      u.email
    FROM
      article a
    LEFT JOIN
      user u ON u.id = a.user_id;
  ELSEIF to_get = 'articles-one' THEN
    SELECT
      a.id,
      a.title,
      a.category_name,
      DATE_FORMAT(a.created_date, '%Y-%m-%d %H:%i:%s') AS created_date,
      a.content,
      u.email
    FROM
      article a
    LEFT JOIN
      user u ON u.id = a.user_id
    WHERE
      a.id = num;
  ELSEIF to_get = 'articles-category' THEN
    SELECT
      id,
      title,
      category_name
    FROM
      article
    WHERE
      category_name = chr;
  END IF;
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS createTicket;

DELIMITER ;;

CREATE PROCEDURE createTicket(
  user INTEGER(3),
  title VARCHAR(45),
  `desc` TEXT(2000),
  category CHAR(40),
  `file` LONGBLOB,
  `file_name` BLOB
)
BEGIN
  INSERT INTO ticket (title, description, status, user_id, category_name, file_data, file_name)
    VALUES
      (title, `desc`, 'Open', user, category, `file`, file_name);
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS createArticle;

DELIMITER ;;

CREATE PROCEDURE createArticle(
  a_user_id INTEGER(3),
  a_title VARCHAR(45),
  a_content TEXT(10000),
  a_category CHAR(40)
)
BEGIN
  INSERT INTO article (title, content, user_id, category_name)
    VALUES
      (a_title, a_content, a_user_id, a_category);
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS makeComment;

DELIMITER ;;

CREATE PROCEDURE makeComment(
  ticket_id INTEGER(5),
  user_id INTEGER(5),
  title VARCHAR(80),
  `desc` TEXT(1000)
)
BEGIN
  INSERT INTO ticket_comment (ticket_id, user_id, title, comment)
    VALUES
      (ticket_id, user_id, title, `desc`);
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS createCategory;

DELIMITER ;;

CREATE PROCEDURE createCategory(
  a_name CHAR(40)
)
BEGIN
  INSERT INTO category (name)
    VALUES
      (a_name);
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS make_user;

DELIMITER ;;

CREATE PROCEDURE make_user(
  a_email CHAR(250)
)
BEGIN
  INSERT INTO user (name, email, is_agent, role)
    VALUES
      ("", a_email, 0, "user");
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS changeTicket;

DELIMITER ;;

CREATE PROCEDURE changeTicket(
  ticket_id INTEGER(5),
  new_status CHAR(12)
)
BEGIN
  UPDATE ticket
    SET status = new_status
  WHERE id = ticket_id;
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS claimTicket;

DELIMITER ;;

CREATE PROCEDURE claimTicket(
  ticket_id INT(3),
  a_email CHAR(250)
)
BEGIN
  DECLARE a_agent_id INT;

  SELECT id INTO a_agent_id
  FROM user
  WHERE email = a_email;

  UPDATE ticket
    SET agent_id = a_agent_id
  WHERE id = ticket_id;
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS unclaimTicket;

DELIMITER ;;

CREATE PROCEDURE unclaimTicket(
  ticket_id INT(3)
)
BEGIN
  UPDATE ticket
    SET agent_id = NULL
  WHERE id = ticket_id;
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS changeRole;

DELIMITER ;;

CREATE PROCEDURE changeRole(
  a_email CHAR(250),
  a_role CHAR(20)
)
BEGIN
  UPDATE user
    SET role = a_role
  WHERE email = a_email;
  IF a_role = 'agent' THEN
    UPDATE user
      SET is_agent = 1
    WHERE
      email = a_email;
  ELSEIF a_role = 'user' THEN
    UPDATE user
      SET is_agent = 0
    WHERE
      email = a_email;
  END IF;
END
;;

DELIMITER ;

DROP PROCEDURE IF EXISTS update_session;

DELIMITER ;;

CREATE PROCEDURE update_session(
  user CHAR(250)
)
BEGIN
  UPDATE current_session
    SET user_email = user;
END
;;

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
