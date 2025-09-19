-- Created by Gabrielle Ulisses in 19/09

/* Comandos para view: 

    1. Listar views existentes
    
        SELECT view_name, text_length, text
        FROM user_views;
        
    2. Apagar view
    
        DROP VIEW Emp_Dept_View;
        
    3. Atualizar uma view
    
        Para uma view ser atualizável, não pode conter
            ◦ Operações de conjunto (UNION, INTERSECT,MINUS)
            ◦ DISTINCT
            ◦ Funções de agregação (COUNT, AVG, SUM, MAX,MIN)
            ◦ GROUP BY, ORDER BY
            ◦ Colunas definidas por expressões
            ◦ Subconsultas
            ◦ Joins (com algumas exceções)
        
        Não é possível inserir dados em uma view que contenha
            ◦ Funções de agregação
            ◦ GROUP BY
            ◦ DISTINCT
            ◦ Colunas definidas por expressões
            ◦ Quando a view não possui colunas que sejam NOT NULL na tabela base
            
            INSERT INTO emp_it_view values
            ('Cris', sysdate, 10000);
            
            Resultado: Emp_it_view não possui todas colunas NOT NULL de Employees 
                
        Resumindo: quando não atualizar views…
            ◦ Tentativa de inserção em uma view que não possua todos os campos obrigatórios da tabela base (chave primária e não nulos)
            ◦ Tentativa de atualização de um campo calculado (funções de agregação)
            ◦ Exclusão de registros que possuam outros relacionados

        Para verificar quais colunas são atualizáveis

            SELECT * FROM USER_UPDATABLE_COLUMNS;
    */
 
 --Example 1:


    SELECT * 
    FROM funcionarios
    WHERE nome LIKE 'D%';

--Example 1.1:

    SELECT * 
    FROM view_funcionarios
    WHERE nome LIKE 'D%';
    
--Example 2, 5, 8 and 9:

    DESCRIBE EMP80_VIEW;
    
    SELECT * FROM EMP80_VIEW;
    
    INSERT INTO EMP80_VIEW VALUES (123456, 'Cris', 'cris@email.com', sysdate,'IT_PROG', 80);
    
    SELECT * FROM employees;
    
    DELETE FROM EMP80_VIEW where EMPLOYEE_ID = 123456;
    
    INSERT INTO EMP80_VIEW VALUES (123456, 'Cris', 'cris2@email.com', sysdate, 'IT_PROG', 50);
    
    
--Example 3:
    
    SELECT * FROM EMP50_VIEW;
    
--Example 4:

    DESC EMP_IT_VIEW;
    
    SELECT * FROM EMP_IT_VIEW;
    
--Example 6:
    
    SELECT * FROM Emp_Dept_View;       
    
    SELECT qtd_emp
    FROM Emp_Dept_View
    WHERE nome = 'Sales';

--Example 7:
    
    SELECT * FROM DEPT_ADDRESS_VIEW;
    
    SELECT nome, rua, cidade, cep, estado, pais
    FROM DEPT_ADDRESS_VIEW
    WHERE cidade = 'Seattle';
    
