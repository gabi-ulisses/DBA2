-- Gabrielle Ulisses | AQ3030512
-- Data: 19/09
-- Atividade: Lista de Exercícios Views


/*
    1. Criar uma view EMP_ST_CLERK que contenha dados dos empregados com função
    ‘ST_CLERK’
        Colunas: employee_id, last_name, email, hire_date, job_id
*/

    CREATE OR REPLACE VIEW EMP_ST_CLERK (id_funcionario, sobrenome, email, data_contratacao, id_cargo) AS
    SELECT employee_id, last_name, email, hire_date, job_id
    FROM employees
    WHERE job_id = 'ST_CLERK';
    
    DESC EMP_ST_CLERK;
    
    SELECT * FROM EMP_ST_CLERK;


/*
    2. Criar (ou alterar) a view de modo que não seja possível alterar seu conteúdo com funções de
    empregado diferentes de ‘ST_CLERK’
*/

    CREATE OR REPLACE VIEW EMP_ST_CLERK (id_funcionario, sobrenome, email, data_contratacao, id_cargo) AS
    SELECT employee_id, last_name, email, hire_date, job_id
    FROM employees
    WHERE job_id = 'ST_CLERK'
    WITH CHECK OPTION;
    
/*
    3. Adicione um novo empregado na view EMP_ST_CLERK, com a função ‘ST_CLERK’
*/

    INSERT INTO EMP_ST_CLERK VALUES(1234, 'Ulisses', 'gulisses', '01/01/2025', 'ST_CLERK');
    SELECT * FROM EMP_ST_CLERK;

/*
    4. Explique o que aconteceu na tabela Employees
*/

    SELECT * FROM employees;
    -- Ocorreu a adição de um novo empregado na tabela employees inserindo somente os valores passados na 
    -- view, preenchendo as colunas employee_id, last_name, email, hire_date, job_id e deixando as outras colunas como 'null'.
/*
    5. Atualize EMP_ST_CLERK de modo que o empregado adicionado tenha a função ‘IT_PROG’
*/

    UPDATE EMP_ST_CLERK
    SET id_cargo = 'IT_PROG'
    WHERE id_funcionario = 1234;
    

/*
    6. Explique o que aconteceu
*/
    
    SELECT * FROM EMP_ST_CLERK;
    -- Não foi possível atualizar a função do empregado devido a mesma não condizer com a cláusula WHERE da view (WHERE job_id = 'ST_CLERK'). 
    -- Isso ocorreu devido a condição CHECK OPTION estar presente na view.

/*
    7. Remova da view o empregado adicionado anteriormente
*/

    DELETE FROM EMP_ST_CLERK WHERE id_funcionario = 1234;

/*
    8. Explique o que aconteceu na tabela Employees
*/

    SELECT * FROM employees;
    -- O empregado foi removida da tabela, assim como foi removido da View  'EMP_ST_CLERK'. 
    -- Isso ocorreu devido o alias presente na view localizar o 'employee_id' por meio de 'id_funcionario'

/*
    9. Criar uma visão DEPT_MAN_VIEW que contenha dados dos gerentes de departamento
        
        Colunas: nome do gerente, título de sua função, salário anual, nome do departamento, cidade
*/


    CREATE OR REPLACE VIEW DEPT_MAN_VIEW (nome_gerente, funcao, salario_anual, departamento, cidade) AS
    SELECT e.first_name, j.job_title, e.salary, d.department_name, 


/*
    10. É possível atualizar DEPT_MAN_VIEW? Justifique.
*/




/*
    11. Criar uma visão DEPT_JOB_VIEW que contenha uma relação da quantidade de empregados
    por função e por nome de departamento
    Colunas: nome do departamento, nome da função, quantidade de empregados que
    exercem a função no referido departamento
*/




/*
    12. É possível atualizar DEPT_JOB_VIEW? Justifique.
*/

