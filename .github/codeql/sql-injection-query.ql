/**
 * @name SQL injection
 * @description Building an SQL query from user-controlled sources is vulnerable to insertion of malicious SQL code by the user.
 * @kind path-problem
 * @problem.severity error
 * @precision high
 * @id csharp/sql-injection
 * @tags security
 *       external/cwe/cwe-089
 */
import csharp
import DataFlow::PathGraph

class SqlInjectionConfiguration extends TaintTracking::Configuration {
  SqlInjectionConfiguration() { this = "SqlInjectionConfiguration" }

  override predicate isSource(DataFlow::Node source) {
    source instanceof PublicCallableParameter
  }

  override predicate isSink(DataFlow::Node sink) {
    sink instanceof ExecSqlCommand
  }
}

class ExecSqlCommand extends DataFlow::Node {
  ExecSqlCommand() {
    exists(MethodCall mc |
      mc = this.asExpr() and
      mc.getTarget().hasQualifiedName("System.Data.SqlClient.SqlCommand", "ExecuteNonQuery")
    )
  }
}

class PublicCallableParameter extends DataFlow::ParameterNode {
  PublicCallableParameter() {
    exists(Method m |
      m = this.getParameter().getCallable() and
      m.isPublic()
    )
  }
}

from SqlInjectionConfiguration config, DataFlow::Node source, DataFlow::Node sink
where config.hasFlowPath(source, sink)
select sink, source, sink, "SQL injection vulnerability due to user-provided input in method '$@'.", sink, sink.toString()