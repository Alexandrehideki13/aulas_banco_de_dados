-- LOOP 

DELIMITER //
CREATE PROCEDURE acumula(limite INT) 
BEGIN
	DECLARE contador INT DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    
    loop_teste: LOOP
		SET contador = contador + 1;
        SET soma = soma + contador;
		IF contador >= limite THEN 
			LEAVE loop_teste;
		END IF;
	END LOOP;
    SELECT soma AS Soma;
END //
DELIMITER ;
CALL acumula(10);


-- REPEAT
-- Dando erro ao atribuir limite igual a zero pois está retornando 1
DELIMITER //
CREATE PROCEDURE acumula_repita(limite TINYINT UNSIGNED)
BEGIN 
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    
    REPEAT 
		IF limite = 0 THEN 
			SET contador = 0;
		ELSE
			SET contador = contador + 1;
			SET soma = soma + contador;
        END IF;
	UNTIL contador >= limite
    END REPEAT;
    SELECT soma AS Soma;
END //
DELIMITER ;
CALL acumula_repita(0);

-- Forma correta
DROP procedure IF EXISTS acumula_ui ;
DELIMITER //
CREATE PROCEDURE acumula_repita(limite TINYINT UNSIGNED)
main: BEGIN 
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    IF limite < 1 THEN 
		SELECT 'O valor deve ser maior que zero' AS zero;
        LEAVE main;
	END IF;
    REPEAT 
		IF limite = 0 THEN 
			SET contador = 0;
		ELSE
			SET contador = contador + 1;
			SET soma = soma + contador;
        END IF;
	UNTIL contador >= limite
    END REPEAT;
    SELECT soma AS Soma;
END //
DELIMITER ;
CALL acumula_repita(10);


-- WHILE
DELIMITER //
CREATE PROCEDURE acumula_while (limite TINYINT UNSIGNED)
BEGIN 
	DECLARE contador TINYINT UNSIGNED DEFAULT 0;
    DECLARE soma INT DEFAULT 0;
    WHILE contador < limite DO
		SET contador = contador + 1;
        SET soma = soma + contador;
	END WHILE;
    SELECT soma;
END //
DELIMITER ;
CALL acumula_while(0);