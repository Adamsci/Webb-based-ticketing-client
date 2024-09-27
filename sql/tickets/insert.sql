--
-- Lägg till innehåll med csv
--

DELETE FROM ticket;
DELETE FROM category;
DELETE FROM user;

--
-- Insert csv
--
INSERT INTO user (id, name, username, password, is_agent)
VALUES
(31, "Bosse", "bosse231", "aiwlj", 0),
(61, "Nisse", "Nisse31", "oiawdlk", 0),
(56, "Kalle", "K4ll3", "ldkas", 0),
(19, "Pelle", "PelleBelle", "jn,sad", 0);

LOAD DATA LOCAL INFILE 'category.csv'
INTO TABLE category
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(name)
;

LOAD DATA LOCAL INFILE 'ticket.csv'
INTO TABLE ticket
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(title, description, status, user_id, category_name)
;

SELECT * FROM category;
SELECT * FROM ticket;
