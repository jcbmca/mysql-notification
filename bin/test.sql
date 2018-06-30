DROP DATABASE IF EXISTS mysql_note;

CREATE DATABASE mysql_note;

USE mysql_note;

CREATE TABLE post (
	id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(64) NOT NULL,
	content TEXT DEFAULT NULL,
	image VARCHAR(260) DEFAULT NULL
);

DROP FUNCTION IF EXISTS MySQLNotification;
CREATE FUNCTION MySQLNotification RETURNS INTEGER SONAME 'mysql_notification.so';

DELIMITER @@

CREATE TRIGGER trigger1 AFTER INSERT ON post
FOR EACH ROW
BEGIN
  SELECT MySQLNotification(NEW.id, 2) INTO @x;
END@@

CREATE TRIGGER trigger2 AFTER UPDATE ON post
FOR EACH ROW
BEGIN
  SELECT MySQLNotification(NEW.id, 3) INTO @x;
END@@

CREATE TRIGGER trigger3 AFTER DELETE ON post
FOR EACH ROW
BEGIN
  SELECT MySQLNotification(OLD.id, 4) INTO @x;
END@@

DELIMITER ;