-- Uma função para retornar o sobrenome a partir do nome

-- Possíveis resultados:
    -- um só
    -- não achar
    -- retornar varios

CREATE OR REPLACE FUNCTION f_sobrenome_empregado(
    p_first_name IN employees.first_name%type)
RETURN VARCHAR2 IS
    l_name hr.employees.last_name%type;
BEGIN
        SELECT last_name 
        INTO l_name 
        FROM employees
        WHERE first_name = p_first_name;
        RETURN(l_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN('Sobrenome não encontrado!');
    WHEN TOO_MANY_ROWS THEN
        RETURN('Mais de um resultado encontrado.');        
END;
/

SELECT f_sobrenome_empregado('Pat') FROM dual; -- 1 resultado
SELECT f_sobrenome_empregado('Gabi') FROM dual; -- Não encontrado
SELECT f_sobrenome_empregado('Alexander') FROM dual; -- Mais de um 
