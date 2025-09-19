-- Created by Gabrielle Ulisses in 19/09

--Example 1:

    CREATE VIEW funcionarios AS -- Como boa prática usar v_funcionarios ou view_funcionarios
    SELECT 
        employee_id AS ID_FUNCIONARIO, 
        first_name || ' ' || last_name AS NOME
    FROM employees;
    
    
    DROP VIEW funcionarios;
    
--Example 1.1: OR REPLACE = OU ATUALIZAR
    
    CREATE OR REPLACE VIEW view_funcionarios AS 
    SELECT 
        employee_id AS ID_FUNCIONARIO, 
        first_name || ' ' || last_name AS NOME,
        email
    FROM employees;


--  Example 2:

    CREATE VIEW EMP80_VIEW
    AS SELECT 
        employee_id, 
        last_name, 
        salary
    FROM Employees
    WHERE department_id = 80;
    
    
--  Example 3:

    CREATE VIEW EMP50_VIEW(Nome, Sal_anual) AS 
    SELECT 
        first_name || ' ' || last_name,
        salary*12
    FROM Employees
    WHERE department_id = 50;
    
--  Example 4:

    CREATE VIEW EMP_IT_VIEW AS 
        SELECT 
            last_name, 
            hire_date, 
            salary
        FROM Employees
        WHERE job_id = 'IT_PROG';
        
-- Example 5: Atualizando EMP80_VIEW  

    CREATE OR REPLACE VIEW EMP80_VIEW AS 
        SELECT 
            employee_id, 
            last_name, 
            email,
            hire_date, 
            job_id, 
            department_id
        FROM Employees
        WHERE department_id = 80;
        
-- Example 6: Visão complexa - envolvendo 2 tabelas

    CREATE OR REPLACE VIEW Emp_Dept_View(nome, qtd_emp, min_sal, max_sal, avg_sal) AS 
        SELECT 
            department_name,
            COUNT(*),
            MIN(salary),
            MAX(salary),
            ROUND(AVG(salary),2)
        FROM EMPLOYEES E 
        JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        GROUP BY department_name;
        
-- Example 7:

    CREATE OR REPLACE VIEW DEPT_ADDRESS_VIEW (nome, rua, cidade, cep, estado, pais) AS 
        SELECT 
            department_name, 
            street_address, 
            city,
            postal_code, 
            state_province, 
            country_name
        FROM DEPARTMENTS D 
        JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
        JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID;
        
-- Example 8        
        
    CREATE OR REPLACE VIEW EMP80_VIEW AS 
        SELECT 
            employee_id, 
            last_name, 
            email,
            hire_date, 
            job_id, 
            department_id
        FROM Employees
        WHERE department_id = 80
    WITH CHECK OPTION;
    
-- Example 9: Impede atualizações sobre a view que contrariem suas condições - WITH CHECK OPTION 

    CREATE OR REPLACE VIEW EMP80_VIEW AS 
        SELECT 
            employee_id, 
            last_name, 
            email,
            hire_date, 
            job_id, 
            department_id
        FROM Employees
        WHERE department_id = 80
    WITH CHECK OPTION;
    
-- Example 10: Impede que comandos de atualização de escrita sejam executados na view - WITH READ ONLY

    CREATE OR REPLACE VIEW EMP80_VIEW AS 
        SELECT 
            employee_id, 
            last_name, 
            email,
            hire_date, 
            job_id, 
            department_id
        FROM Employees
        WHERE department_id = 80
    WITH READ ONLY;
