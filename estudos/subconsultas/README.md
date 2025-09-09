# 📊 Subconsultas em Banco de Dados (SQL)

As **subconsultas** (ou consultas aninhadas) permitem utilizar o resultado de uma consulta dentro de outra.

---

## 🔹 Introdução
- Uma **subconsulta** é usada dentro da cláusula `WHERE`, `HAVING` ou até no `FROM`.
- Exemplo: buscar empregados que recebem salário maior que o do empregado de sobrenome **Gates**:

```sql
SELECT last_name, salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Gates'
);
````

---

## 🔹 Tipos de Subconsultas

1. **Single-row subquery (única linha)**

   * Retorna **apenas um valor**.
   * Usam operadores: `=`, `<`, `>`, `<=`, `>=`, `<>`.

   Exemplo: empregado com **menor salário**:

   ```sql
   SELECT first_name, last_name, job_id, salary
   FROM employees
   WHERE salary = (
       SELECT MIN(salary)
       FROM employees
   );
   ```

2. **Multiple-row subquery (múltiplas linhas)**

   * Retorna **conjunto de valores**.
   * Usam operadores: `IN`, `ANY`, `ALL`.

   Exemplo: salários iguais aos de empregados com função `IT_PROG`:

   ```sql
   SELECT last_name, salary
   FROM employees
   WHERE job_id <> 'IT_PROG'
   AND salary IN (
       SELECT salary
       FROM employees
       WHERE job_id = 'IT_PROG'
   );
   ```

---

## 🔹 Operadores em Subconsultas

* **IN** → valor pertence ao conjunto.
* **NOT IN** → valor não pertence ao conjunto.
* **ANY** → verdadeiro se **algum valor** satisfizer a condição.
* **ALL** → verdadeiro se **todos os valores** satisfizerem a condição.
* **EXISTS** → verdadeiro se a subconsulta retornar pelo menos uma linha.
* **NOT EXISTS** → verdadeiro se a subconsulta **não retornar nada**.

---

## 🔹 Exemplos de Operadores

* **ANY** → salário menor que **algum** `IT_PROG`:

```sql
SELECT last_name, salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ANY (
    SELECT salary
    FROM employees
    WHERE job_id = 'IT_PROG'
);
```

* **ALL** → salário maior que **todos** de Southlake:

```sql
SELECT last_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees E, departments D, locations L
    WHERE E.department_id = D.department_id
      AND D.location_id = L.location_id
      AND L.city = 'Southlake'
);
```

* **EXISTS** → departamentos que possuem empregados:

```sql
SELECT department_name
FROM departments D
WHERE EXISTS (
    SELECT *
    FROM employees E
    WHERE D.department_id = E.department_id
);
```

* **NOT EXISTS** → departamentos **sem empregados**:

```sql
SELECT department_name
FROM departments D
WHERE NOT EXISTS (
    SELECT *
    FROM employees E
    WHERE D.department_id = E.department_id
);
```

---

## 🔹 Subconsultas Correlacionadas

* Dependem da consulta externa.
* Exemplo: empregados que ganham mais que seus gerentes:

```sql
SELECT E.last_name, E.salary
FROM employees E
WHERE E.salary > (
    SELECT G.salary
    FROM employees G
    WHERE E.manager_id = G.employee_id
);
```

---

## ⚠️ Cuidados

* Subconsultas com `NOT IN` podem falhar com valores `NULL`.
* Operadores equivalentes:

  * `IN` ≡ `= ANY`
  * `NOT IN` ≡ `<> ALL`

---

✅ **Resumo:**
As subconsultas são ferramentas poderosas para criar consultas complexas, permitindo comparar valores, verificar existência de dados e correlacionar resultados entre tabelas de forma eficiente.
