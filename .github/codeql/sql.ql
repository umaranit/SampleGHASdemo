import csharp

from Method m, StringLiteral sl
where m.getName() = "RunQuery"
  and m.getBody().getAChild*() = sl
  and sl.getValue().matches("%' + %")
select sl, "Potential SQL injection vulnerability."