/**
 * @name SQL injection
 * @description Writing user-controlled input directly to a SQL query can allow an attacker to change the structure of the query.
 * @kind problem
 * @problem.severity error
 * @precision high
 * @id csharp/sql-injection
 * @tags security
 *       external/cwe/cwe-089
 */
import csharp

from Method m, StringLiteral sl
where m.getName() = "RunQuery"
  and m.getBody().getAChild*() = sl
  and sl.getValue().matches("%' + %")
select sl, "Potential SQL injection vulnerability."