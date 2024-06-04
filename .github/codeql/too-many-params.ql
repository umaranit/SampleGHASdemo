/**
 * @id cs/examples/too-many-params
 * @name Methods with many parameters
 * @description Finds methods with more than ten parameters.
 * @kind problem
 * @tags method
 *       parameter
 *       argument
 */

 
import csharp

from Method m
where m.getNumberOfParameters() > 10
select m, "This method has more than 10 parameters."