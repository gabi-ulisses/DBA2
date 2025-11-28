SET SERVEROUTPUT ON;

-- Uma função para retornar o nome completo a partir do ID

CREATE OR REPLACE FUNCTION f_nome_empregado(
    p_id IN employees.employee_id%type)
RETURN VARCHAR2 IS
    f_name employees.first_name%type;
    l_name hr.employees.last_name%type;
BEGIN
        SELECT first_name, last_name 
        INTO f_name, l_name 
        FROM employees
        WHERE employee_id = p_id;
        RETURN(f_name || ' ' || l_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN('ID não encontrado!');
END;
/

SELECT f_nome_empregado(1) FROM dual;
