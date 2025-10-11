-- Date: 10/10/2025
-- Aula: Sequences

-- Examples:

    /* 1. Criando uma sequence DEPTID_SEQ para gerar
    valores de chave primária da tabela DEPARTMENTS: */
    
        CREATE SEQUENCE DEPTID_SEQ
        INCREMENT BY 10
        START WITH 500
        MAXVALUE 9999
        NOCACHE
        NOCYCLE;
        
        -- Testando a sequence em tabela:
        
        CREATE TABLE t (id int);
        
        INSERT INTO t(id) VALUES(DEPTID_SEQ.NEXTVAL);
        
        SELECT * FROM t;

        SELECT DEPTID_SEQ.NEXTVAL
        FROM DUAL;
        
        SELECT DEPTID_SEQ.CURRVAL
        FROM DUAL;
    
    /* 2. Criando uma sequence com a opção CYCLE geram valores
    repetidos
    
    Obs.: Não usado para gerar valores de chave primária */
    
        CREATE SEQUENCE seq_teste
        START WITH 5
        INCREMENT BY -1
        MAXVALUE 5
        MINVALUE 0
        NOCACHE
        CYCLE;

        SELECT seq_teste.nextval
        FROM DUAL;
        
-- Exercícios

    -- 1. 
          --  a) Criar uma tabela emp_copy como uma cópia da tabela employees
                
                CREATE TABLE emp_copy AS SELECT * FROM employees;
                SELECT * FROM emp_copy;
                
          --  b) Criar um SEQUENCE para gerar valores de employee_id da tabela emp_copy
          
                CREATE SEQUENCE emp_copyid_seq
                INCREMENT BY 1
                START WITH 1000
                MAXVALUE 9999
                NOCACHE
                NOCYCLE;

                
          --  c) Inserir um empregado na tabela emp_copy usando o SEQUENCE criado no item b)
            
                INSERT INTO emp_copy(employee_id,LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
                VALUES(emp_copyid_seq.NEXTVAL, 'Ulisses', 'ulisses@ifsp.edu.br', '02/01/2025', 'IT_PROG');
                
                SELECT * FROM emp_copy;
                
                
    -- 2. 
    
            CREATE TABLE emp_test(
            employee_id NUMBER(6) PRIMARY KEY,
            name VARCHAR2(50) NOT NULL,
            manager_id NUMBER(4)
                CONSTRAINT fk_mgr 
                REFERENCES employees ON DELETE SET NULL,
            salary NUMBER(8,2),
            department_id NUMBER(2)
                CONSTRAINT fk_deptno
                REFERENCES departments(department_id)
                ON DELETE CASCADE
            );
            
            -- a) Criar um SEQUENCE para gerar valores de employee_id da tabela emp_test
            
                CREATE SEQUENCE emp_testid_seq
                INCREMENT BY 1
                START WITH 100000
                MAXVALUE 999999
                NOCACHE
                NOCYCLE;
            
            -- b) Inserir um empregado na tabela emp_test usando o SEQUENCE criado no item a
      
                INSERT INTO emp_test(employee_id, name, manager_id, salary, department_id)
                VALUES(emp_testid_seq.NEXTVAL, 'Ulisses', 100, 2100, 80);
                
                SELECT * FROM emp_test;
                
