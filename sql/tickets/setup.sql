--
-- Creating database
--

DROP DATABASE IF EXISTS tickets;

-- Skapar databas
CREATE DATABASE IF NOT EXISTS tickets;

-- Använder databasen
USE tickets;

-- Visa databaser
SHOW DATABASES;

-- Visa databaser med namnet eshop
SHOW DATABASES LIKE "%tickets%";
