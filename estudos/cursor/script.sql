SET SERVEROUTPUT ON;

BEGIN
    UPDATE employees
    SET salary = salary * 1.10
    WHERE department_id = 50;
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' registros atualizados.');
    END IF;
END;



DECLARE
    CURSOR c_emp IS
        SELECT employee_id, first_name, salary
        FROM employees
        WHERE department_id = 50;
     
    v_id        employees.employee_id%TYPE;
    v_nome      employees.first_name%TYPE;
    v_sal       employees.salary%TYPE;
    v_media_sal employees.salary%TYPE;
    msg CHAR(20);

BEGIN

    SELECT AVG(salary)
    INTO v_media_sal
    FROM employees
    WHERE department_id = 50;
    DBMS_OUTPUT.PUT_LINE('Média Salarial do departamento: ' || v_media_sal);
    DBMS_OUTPUT.PUT_LINE('---------------------------------');

    OPEN c_emp; -- abre o cursor
    DBMS_OUTPUT.PUT_LINE('--- Empregados (Dept 50) ---');
    LOOP
        FETCH c_emp INTO v_id, v_nome, v_sal;
        EXIT WHEN c_emp%NOTFOUND;
        
        IF v_sal > v_media_sal THEN
            msg := 'Acima da média';
        ELSIF v_sal = v_media_sal THEN
            msg := 'Igual a média';
        ELSE
            msg := 'Abaixo da média';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(v_id || ' - ' || v_nome || ' - ' || v_sal || ' - ' || msg);
    
    END LOOP;
    CLOSE c_emp;  -- fecha o cursor
    
END;
/

BEGIN
    FOR r_emp IN (
        SELECT employee_id, first_name, salary
        FROM employees
        WHERE department_id = 50
    ) LOOP
    DBMS_OUTPUT.PUT_LINE(r_emp.employee_id || ' - ' || r_emp.first_name
    || ' - ' || r_emp.salary);
    END LOOP;
END;
