import csharp
import semmle.code.csharp.dataflow.flowsources.Public
import semmle.code.csharp.frameworks.system.Data
import DataFlow::PathGraph

class SqlInjectionConfiguration extends TaintTracking::Configuration {
  SqlInjectionConfiguration() { this = "SqlInjectionConfiguration" }

  override predicate isSource(DataFlow::Node source) {
    source instanceof PublicCallableParameter
  }

  override predicate isSink(DataFlow::Node sink) {
    exists(SqlCommandExecuteMethod cmd |
      sink.asExpr() = cmd.getCommand().getALocalUse().getAChildExpr()
    )
  }
}

from SqlInjectionConfiguration config, DataFlow::Node source, DataFlow::Node sink
where config.hasFlow(source, sink)
select sink, source, sink, "SQL injection vulnerability due to user-provided input in method '$@'.", sink, sink.toString()