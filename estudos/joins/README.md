# 🔗 JOIN em Banco de Dados (SQL)

O comando **JOIN** permite combinar dados de duas ou mais tabelas com base em uma condição de relacionamento.  
A sintaxe padrão foi definida pelo **ANSI SQL:1999**.

---

## 📌 Tipos de JOIN
- **INNER JOIN**
- **NATURAL JOIN**
- **SELF JOIN**
- **CROSS JOIN**
- **OUTER JOIN** (LEFT, RIGHT, FULL)

---

## 🔹 INNER JOIN
- Também chamado de **JOIN** ou **EQUIJOIN**.
- Retorna apenas as linhas que possuem correspondência na condição.

Exemplo: sobrenome dos empregados e nome do departamento:
```sql
SELECT E.last_name, D.department_name
FROM employees E
INNER JOIN departments D
ON E.department_id = D.department_id;
````

---

## 🔹 NATURAL JOIN

* Faz a junção automaticamente considerando **todas as colunas com mesmo nome e tipo** em ambas as tabelas.
* Deve ser usado com cautela para evitar ambiguidades.

Exemplo: empregados e suas funções:

```sql
SELECT E.last_name, J.job_title
FROM employees E
NATURAL JOIN jobs J;
```

---

## 🔹 Cláusula USING

* Usada quando as colunas envolvidas no `JOIN` possuem o mesmo nome.
* Simplifica a sintaxe.

```sql
SELECT E.last_name, D.department_name
FROM employees E
INNER JOIN departments D
USING (department_id);
```

---

## 🔹 SELF JOIN

* É um **INNER JOIN aplicado na mesma tabela**.
* Útil para relacionamentos hierárquicos (ex.: empregados e seus gerentes).

```sql
SELECT E.last_name AS Empregado, G.last_name AS Gerente
FROM employees E
INNER JOIN employees G
ON E.manager_id = G.employee_id;
```

---

## 🔹 CROSS JOIN

* Produz o **produto cartesiano** entre as tabelas.
* Número de linhas = linhas(T1) × linhas(T2).
* Deve ser usado com cuidado.

```sql
SELECT C.country_id, R.region_id
FROM countries C
CROSS JOIN regions R;
```

---

## 🔹 OUTER JOIN

* Retorna as tuplas que **possuem ou não correspondência**.
* Tipos:

  * **LEFT OUTER JOIN** → mantém todas as linhas da tabela à esquerda.
  * **RIGHT OUTER JOIN** → mantém todas as linhas da tabela à direita.
  * **FULL OUTER JOIN** → mantém todas as linhas de ambas as tabelas.

Exemplos:

### LEFT OUTER JOIN

```sql
SELECT D.department_name, E.last_name
FROM departments D
LEFT OUTER JOIN employees E
ON D.department_id = E.department_id;
```

### RIGHT OUTER JOIN

```sql
SELECT D.department_name, E.last_name
FROM departments D
RIGHT OUTER JOIN employees E
ON D.department_id = E.department_id;
```

### FULL OUTER JOIN

```sql
SELECT D.department_name, E.last_name
FROM departments D
FULL OUTER JOIN employees E
ON D.department_id = E.department_id;
```

---

## 🔹 INNER JOIN vs OUTER JOIN

* **INNER JOIN** → só retorna linhas com correspondência.
* **OUTER JOIN** → retorna também as linhas sem correspondência (com valores `NULL`).

---

## ⚠️ Observação (Oracle)

* No Oracle, OUTER JOIN também pode ser escrito com o símbolo `(+)`.

Exemplo:

```sql
SELECT D.department_name, E.last_name
FROM departments D, employees E
WHERE D.department_id = E.department_id(+);
```

---

✅ **Resumo:**
Os **JOINS** permitem relacionar tabelas em consultas SQL.

* Use `INNER JOIN` quando só precisar de correspondências.
* Use `OUTER JOIN` para incluir registros sem correspondência.
* `SELF JOIN` é útil para hierarquias.
* `CROSS JOIN` gera todas as combinações possíveis.
* `NATURAL JOIN` e `USING` simplificam a sintaxe, mas exigem cuidado.