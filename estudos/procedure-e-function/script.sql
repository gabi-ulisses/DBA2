/* 1. Elabore uma função que, dado o id do empregado, retorne quantos empregados são mais antigos
que ele na empresa.*/

    CREATE OR REPLACE FUNCTION contar_empregados_mais_antigos (
        p_employee_id IN employees.employee_id%TYPE
    )
    RETURN NUMBER
    IS
        v_hire_date employees.hire_date%TYPE;
        v_count     NUMBER;
    BEGIN
        SELECT hire_date
        INTO v_hire_date
        FROM employees
        WHERE employee_id = p_employee_id;
    
        SELECT COUNT(*)
        INTO v_count
        FROM employees
        WHERE hire_date < v_hire_date;
    
        RETURN v_count;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Empregado com ID ' || p_employee_id || ' não encontrado.');
    END;
    /

/* 2. Faça uma função que, dados first_name, last_name e nome da empresa, retorne um endereço de
email com o seguinte formato: first_name.last_name@nome_empresa.com */

    CREATE OR REPLACE FUNCTION gerar_email (
        p_first_name IN employees.first_name%TYPE,
        p_last_name  IN employees.last_name%TYPE,
        p_empresa    IN VARCHAR2
    )
    RETURN VARCHAR2
    IS
        v_email VARCHAR2(100);
    BEGIN
        v_email := LOWER(p_first_name) || '.' || LOWER(p_last_name) || '@' || LOWER(REPLACE(p_empresa, ' ', '_')) || '.com';
        
        RETURN v_email;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro ao gerar e-mail: ' || SQLERRM);
    END;
    /

/* 3. Faça um procedimento para atualizar o email de um determinado empregado, com os parâmetros:
id do empregado e nome da empresa. Utilize a função criada no exercício anterior para gerar o
endereço de e-mail. */

    CREATE OR REPLACE PROCEDURE atualizar_email_empregado (
        p_employee_id IN employees.employee_id%TYPE,
        p_nome_empresa IN VARCHAR2
    )
    IS
        v_first_name employees.first_name%TYPE;
        v_last_name  employees.last_name%TYPE;
        v_novo_email employees.email%TYPE;
    BEGIN
        SELECT first_name, last_name
        INTO v_first_name, v_last_name
        FROM employees
        WHERE employee_id = p_employee_id;
        
        v_novo_email := gerar_email(v_first_name, v_last_name, p_nome_empresa);
        
        UPDATE employees
        SET email = v_novo_email
        WHERE employee_id = p_employee_id;
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('E-mail do empregado ' || p_employee_id || ' atualizado para: ' || v_novo_email);
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Empregado com ID ' || p_employee_id || ' não encontrado.');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Erro ao atualizar e-mail: ' || SQLERRM);
    END;
    /

/* 4. Criar a função emp_status (emp_id) RETURN varchar2, que retorne o status de um funcionário
com relação aos anos de trabalho na empresa:

    Maior que 12 anos: status = ‘master’
    Entre 8 e 12 anos: status = ‘senior’
    Menor que 8 anos: status = ‘pleno’
    
Executar a function

    SELECT first_name, last_name, emp_status(employee_id)
    FROM employees; 
*/

    CREATE OR REPLACE FUNCTION emp_status (
        p_emp_id IN employees.employee_id%TYPE
    )
    RETURN VARCHAR2
    IS
        v_hire_date employees.hire_date%TYPE;
        v_anos_servico NUMBER;
        v_status       VARCHAR2(10);
    BEGIN
        SELECT hire_date
        INTO v_hire_date
        FROM employees
        WHERE employee_id = p_emp_id;
        
        v_anos_servico := MONTHS_BETWEEN(SYSDATE, v_hire_date) / 12;
        
        IF v_anos_servico > 12 THEN
            v_status := 'master';
        ELSIF v_anos_servico >= 8 THEN
            v_status := 'senior';
        ELSE
            v_status := 'pleno';
        END IF;
    
        RETURN v_status;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'Empregado com ID ' || p_emp_id || ' não encontrado.');
    END;
    /

/* 5. Criar o procedimento aumento_salario (emp_id) que aumente o salário de um determinado
empregado com relação ao seu status

    Master aumento de 10%
    Senior aumento de 5%
    Pleno sem aumento
    
Use a função emp_status para saber qual o status do empregado */

    CREATE OR REPLACE PROCEDURE aumento_salario (
        p_emp_id IN employees.employee_id%TYPE
    )
    IS
        v_status  VARCHAR2(10);
        v_aumento NUMBER := 0;
    BEGIN
        v_status := emp_status(p_emp_id);
        
        CASE v_status
            WHEN 'master' THEN
                v_aumento := 0.10;
            WHEN 'senior' THEN
                v_aumento := 0.05;
            WHEN 'pleno' THEN
                v_aumento := 0.00;
        END CASE;
        
        IF v_aumento > 0 THEN
            UPDATE employees
            SET salary = salary * (1 + v_aumento)
            WHERE employee_id = p_emp_id;
            
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Salário do empregado ' || p_emp_id || ' (' || v_status || ') aumentado em ' || (v_aumento * 100) || '%.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Salário do empregado ' || p_emp_id || ' (' || v_status || ') não teve aumento (Pleno).');
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            IF SQLCODE = -20005 THEN
                 RAISE_APPLICATION_ERROR(SQLCODE, 'Erro: ' || SUBSTR(SQLERRM, INSTR(SQLERRM, ':') + 1));
            ELSE
                 RAISE_APPLICATION_ERROR(-20006, 'Erro ao aplicar aumento de salário: ' || SQLERRM);
            END IF;
    END;
    /

/* 6. Elabore um procedimento para alterar o gerente de um departamento, passando o id do
departamento e o id do empregado que será seu novo gerente.

- Um empregado somente pode ser gerente do departamento ao qual pertence. Caso o empregado
pertença a outro departamento, exiba uma mensagem na tela dizendo que não é possível alterar o
gerente, pois ele deve pertencer ao mesmo departamento que gerencia. 

*/
    CREATE OR REPLACE PROCEDURE alterar_gerente_departamento (
        p_department_id  IN departments.department_id%TYPE,
        p_new_manager_id IN employees.employee_id%TYPE
    )
    IS
        v_emp_dept_id employees.department_id%TYPE;
    BEGIN
        SELECT department_id
        INTO v_emp_dept_id
        FROM employees
        WHERE employee_id = p_new_manager_id;
    
        IF v_emp_dept_id = p_department_id THEN
            
            UPDATE departments
            SET manager_id = p_new_manager_id
            WHERE department_id = p_department_id;
            
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Gerente do Departamento ' || p_department_id || ' alterado com sucesso para o Empregado ' || p_new_manager_id || '.');
            
        ELSE
            DBMS_OUTPUT.PUT_LINE('NÃO É POSSÍVEL ALTERAR O GERENTE.');
            DBMS_OUTPUT.PUT_LINE('O empregado ' || p_new_manager_id || ' deve pertencer ao Departamento ' || p_department_id || ' para gerenciá-lo.');
            DBMS_OUTPUT.PUT_LINE('Atualmente, ele pertence ao Departamento ' || v_emp_dept_id || '.');
        END IF;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            ROLLBACK;
            DECLARE
                temp_dept_name departments.department_name%TYPE;
            BEGIN
                SELECT department_name INTO temp_dept_name FROM departments WHERE department_id = p_department_id;
                RAISE_APPLICATION_ERROR(-20007, 'Empregado com ID ' || p_new_manager_id || ' não encontrado.');
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20008, 'Departamento com ID ' || p_department_id || ' não encontrado.');
            END;
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20009, 'Erro ao alterar o gerente: ' || SQLERRM);
    END;
    /
