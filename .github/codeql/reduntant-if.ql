/**
 * @name Redundant if statement
 * @description An 'if' statement with an empty body is redundant and can be removed.
 * @kind problem
 * @problem.severity recommendation
 * @precision high
 * @id csharp/redundant-if-statement
 * @tags maintainability
 *       readability
 */
import csharp

from BlockStmt blk
where blk.isEmpty()
select blk, "This 'if' statement is redundant."