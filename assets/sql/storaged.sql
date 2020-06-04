-- STORED PROCEDURES
-- new_user
DROP PROCEDURE IF EXISTS new_user;
DELIMITER //
CREATE PROCEDURE new_user(username_p VARCHAR(30), password_p VARCHAR(40), firstname_p VARCHAR(30), lastname_p VARCHAR(30), email_p VARCHAR(30))
BEGIN

	INSERT INTO users (username, password, firstname, lastname, email)
		VALUES (username_p, password_p, firstname_p, lastname_p, email_p);

	INSERT INTO ratings (likes, dislikes, id_user)
			VALUES (0, 0, LAST_INSERT_ID());

END//
DELIMITER ;

-- CALL new_user();

-- change_solution_state
DROP PROCEDURE IF EXISTS change_solution_state;
DELIMITER //
CREATE PROCEDURE change_solution_state(id_solution_p INT(9))
BEGIN

	DECLARE state TINYINT(1);

	SELECT solution_state INTO state
	FROM solutions
	WHERE id_solution = id_solution_p;

	CASE state
		WHEN 0 THEN
			UPDATE solutions
			SET solution_state = 1
			WHERE id_solution = id_solution_p;
			SELECT 1 AS "state";
		WHEN 1 THEN
			UPDATE solutions
			SET solution_state = 0
			WHERE id_solution = id_solution_p;
			SELECT 0 AS "state";
		WHEN 2 THEN
			DELETE FROM solutions
			WHERE solutions.id_solution = id_solution_p;
			SELECT 2 AS "state";
		WHEN 3 THEN
			SELECT 3 AS "state";
	END CASE;

END//
DELIMITER ;