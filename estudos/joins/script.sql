-- By Gabrielle Ulisses in 12/09

/*  1. Consultar sobrenome e salário dos empregados cujo título do cargo é ‘Sales Representative’ou‘Stock Clerk’; */

    SELECT e.LAST_NAME, e.SALARY
    FROM EMPLOYEES e
    INNER JOIN JOBS j USING (JOB_ID)
    WHERE JOB_TITLE = 'Sales Representative' OR JOB_TITLE = 'Stock Clerk';

/*  2. Consultar os nomes dos países e os nomes das regiões onde estão localizados; */

    SELECT c.COUNTRY_NAME, r.REGION_NAME
    FROM COUNTRIES c
    INNER JOIN REGIONS r ON c.REGION_ID = r.REGION_ID;

/*  3. Consultar o nome do departamento e o sobrenome de seu gerente. Caso o departamento não 
    tenha gerente, liste o nome do departamento e indique null para o gerente. */

    SELECT d.DEPARTMENT_NAME, e.LAST_NAME
    FROM DEPARTMENTS d
    LEFT JOIN EMPLOYEES e ON d.MANAGER_ID = e.MANAGER_ID;

/*  4. Consultar primeiro nome e sobrenome dos empregados que trabalham em departamentos
    localizados em cidades cujo nome inicia-se com a letra S; */

    SELECT e.FIRST_NAME || '' || e.LAST_NAME AS EMPREGADO
    FROM EMPLOYEES e
    INNER JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
    INNER JOIN LOCATIONS l ON l.LOCATION_ID = d.LOCATION_ID
    WHERE l.CITY LIKE 'S%';


/*  5. Faça uma consulta para elaborar um relatório dos empregados e seus respectivos gerentes
    contendo sobrenome do empregado, id de seu cargo (job_id), sobrenome do seu gerente e id do
    cargo (job_id) do gerente. Caso o empregado não tenha gerente, exiba null como sobrenome do
    gerente. */
    
    SELECT e.LAST_NAME AS NOME_EMPREGADO, e.JOB_ID AS CARGO_EMPREGADO, g.LAST_NAME AS NOME_GERENTE, g.JOB_ID AS CARGO_GERENTE
    FROM EMPLOYEES e
    LEFT JOIN EMPLOYEES g ON e.MANAGER_ID = g.EMPLOYEE_ID;
    
/*  6. Liste o nome de todos os departamentos cadastrados e, caso tenha, exiba o nome e o sobrenome
de seu gerente; */

    SELECT d.DEPARTMENT_NAME, e.FIRST_NAME || ' ' || e.LAST_NAME AS GERENTE
    FROM DEPARTMENTS d
    LEFT JOIN EMPLOYEES e ON e.EMPLOYEE_ID = d.MANAGER_ID;


/*  7. Considerando o histórico de cargos (tabela JOB_HISTORY), consulte sobrenome do
    empregado, id de cargo (job_id), data de início e data de encerramento registrados no histórico,
    considerando todos empregados cadastrados, incluindo também aqueles que não possuem
    registro no histórico de cargos. */
    
    
    SELECT e.LAST_NAME, j.JOB_ID, j.START_DATE, j.END_DATE
    FROM EMPLOYEES e
    FULL OUTER JOIN JOB_HISTORY j ON e.EMPLOYEE_ID = j.EMPLOYEE_ID
    ORDER BY j.START_DATE;
    
    