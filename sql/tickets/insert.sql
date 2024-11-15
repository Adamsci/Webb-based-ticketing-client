--
-- Lägg till innehåll med csv
--

DELETE FROM ticket_comment;
DELETE FROM ticket;
DELETE FROM article;
DELETE FROM category;
DELETE FROM current_session;
DELETE FROM user;

--
-- Insert csv
--
INSERT INTO user (id, name, email, is_agent, role)
VALUES
(31, "Bosse", "bosse.bossesson@gmail.com", 0, "user"),
(61, "Nisse", "nisse.nissesson@gmail.com", 0, "user"),
(56, "Kalle", "kalle.kallesson@gmail.com", 0, "user"),
(19, "Pelle", "pelle.pellesson@gmail.com", 0, "user"),
(2, "Agent", "agent.agentsson@gmail.com", 1, "agent"),
(3, "olle", "olle.ollesson@gmail.com", 1, "agent"),
(1, "Admin", "admin@gmail.com", 1, "admin")
;

INSERT INTO current_session (user_email)
VALUES
("none");

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

LOAD DATA LOCAL INFILE 'article.csv'
INTO TABLE article
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(title, content, user_id, category_name)
;

LOAD DATA LOCAL INFILE 'ticket_comment.csv'
INTO TABLE ticket_comment
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(ticket_id,user_id,title,comment)
;

UPDATE ticket
    SET agent_id = 3
WHERE id = 4;

UPDATE ticket
    SET agent_id = 2
WHERE id = 2;

SELECT * FROM category;
SELECT * FROM ticket;
SELECT * FROM ticket_comment;
SHOW WARNINGS;
