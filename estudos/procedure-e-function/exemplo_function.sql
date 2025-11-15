-- Exibir funcionários do departamento 100

SELECT COUNT(*) 
FROM employees
WHERE department_id = 100;


-- Transformando em Função:

CREATE OR REPLACE FUNCTION conta_funcionario(p_d IN employees.department_id%type) 
RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO v_total
    FROM employees
    WHERE department_id = p_d;
    RETURN v_total;
END;
/

SELECT conta_funcionario(1) FROM dual;


-- Transformando em Função com condicional:

CREATE OR REPLACE FUNCTION conta_funcionario(p_d IN employees.department_id%type) 
RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    IF p_d = 0 THEN
        SELECT COUNT(*) 
        INTO v_total
        FROM employees;
    ELSE 
        SELECT COUNT(*) 
        INTO v_total
        FROM employees    
        WHERE department_id = p_d;
    END IF;
    RETURN v_total;
END;
/

SELECT conta_funcionario(900) FROM dual;


SELECT conta_funcionario(1) FROM dual;