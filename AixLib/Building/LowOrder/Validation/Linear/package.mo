within AixLib.Building.LowOrder.Validation;
package Linear 
  extends Modelica.Icons.ExamplesPackage;


  annotation(conversion(noneFromVersion = "", noneFromVersion = "1"),
    Documentation(info="<html>
<p align=\"justify\">The Package &QUOT;Linear&QUOT; provides 12 Test Cases which are described in the German Guideline VDI 6007. The Test cases are used to validate our simplified models. To validate the Models we must comply the following conditions: </p>
<ul>
<li align=\"justify\">room air temperature &plusmn;0.1 K (for test cases 1, 2, 3, 4, 5, 8, 9, 10 and 12)</li>
<li align=\"justify\">heating and cooling loads &plusmn;1 W (for test cases 6, 7 and 11)</li>
</ul>
<p align=\"justify\">The test cases 1 and 2 comply the condition of 0.1 K. The results of test cases 3, 4, 5, 8, 9 and 12 are 0.2 K with the exception of test case 4 which has the result of 0.3 K. Which these results, we are already very close to the desired result of 0.1 K. The result of test case 10 is 0.4 K, which represents an excessive deviation. This is probably possible to the regulators. This problem needs to be fixed. </p>
<p align=\"justify\">For the remaining test cases 6, 7 and 11, the condition of 1 W cannot be complied. </p>
</html>", revisions="<html>
<p><b>2015-04-29: Version 1.1</b>: by Steffen Riebling </p>
<ul>
<li>Revised documentation </li>
</ul>
</html>"));
end Linear;
