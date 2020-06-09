-- STORED PROCEDURES
-- new_user
DROP PROCEDURE IF EXISTS new_user;
DELIMITER //
CREATE PROCEDURE new_user(username_p VARCHAR(30), password_p VARCHAR(40), firstname_p VARCHAR(30), lastname_p VARCHAR(30), email_p VARCHAR(30), token_p VARCHAR(40))
BEGIN

	INSERT INTO users (username, password, firstname, lastname, email, verified, token)
		VALUES (username_p, password_p, firstname_p, lastname_p, email_p, 0, token_p);

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

-- insert_solution

DROP PROCEDURE IF EXISTS insert_solution;
DELIMITER //
CREATE PROCEDURE insert_solution(solution_description_p VARCHAR(1024), id_contest_p INT(9), id_user_p INT(9))
BEGIN

	DECLARE lastinsertid INT(9);

	INSERT INTO solutions (solution, solution_description, solution_state, id_contest, id_user)
		VALUES ("null", solution_description_p, 0, id_contest_p, id_user_p);

	SELECT LAST_INSERT_ID() INTO lastinsertid;

	UPDATE solutions
			SET solution = CONCAT("code", lastinsertid, ".txt")
			WHERE id_solution = lastinsertid;

	SELECT solution FROM solutions
	WHERE id_solution = lastinsertid;


END//
DELIMITER ;

-- solution_check

DROP PROCEDURE IF EXISTS solution_check;
DELIMITER //
CREATE PROCEDURE solution_check(id_solution_p INT(9), solution_state_p TINYINT(1))
BEGIN

	DECLARE userid INT(9);

	UPDATE solutions
		SET solution_state = solution_state_p
		WHERE id_solution = id_solution_p;

	SELECT id_user INTO userid
		FROM solutions
		WHERE id_solution = id_solution_p;

	IF solution_state_p = 2 THEN
		UPDATE ratings
			SET dislikes = dislikes + 1
			WHERE id_user = userid;
	ELSEIF solution_state_p = 3 THEN
		UPDATE ratings
			SET likes = likes + 1
			WHERE id_user = userid;
	END IF;

END//
DELIMITER ;

