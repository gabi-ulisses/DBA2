SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE pr_nome_empregado(
    p_id IN hr.employees.employee_id%type)
IS
    f_name hr.employees.first_name%type;
    l_name hr.employees.last_name%type;
BEGIN
        SELECT first_name, last_name -- parâmetro da table
        INTO f_name, l_name -- parâmetro do procedure
        FROM employees
        WHERE employee_id = p_id;
        DBMS_OUTPUT.PUT_LINE(f_name || ' ' || l_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ID não encontrado!');
END;
/
