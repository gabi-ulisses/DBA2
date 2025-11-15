CREATE TABLE tab1(
    id NUMBER PRIMARY KEY,
    nome VARCHAR(20)
);

CREATE OR REPLACE PROCEDURE insere_tab1 IS
BEGIN
    INSERT INTO tab1(id, nome) VALUES (1, 'EDU');
END;
/

EXEC insere_tab1;

SELECT * FROM tab1;


CREATE OR REPLACE PROCEDURE insere_tab1(p_id IN tab1.id%type, p_nome IN tab1.nome%type) IS
BEGIN
    INSERT INTO tab1(id, nome) VALUES (p_id, p_nome);
END;
/

EXEC insere_tab1(2, 'leal');
EXEC insere_tab1(3, 'gabi');

SELECT * FROM tab1;
