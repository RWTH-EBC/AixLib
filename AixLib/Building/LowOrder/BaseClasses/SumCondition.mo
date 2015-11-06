within AixLib.Building.LowOrder.BaseClasses;
function SumCondition "Sums up the entries of a vector if a condition is true"

  input Real vector[:] "Input vector";

  input Boolean condition[:] "Vector of conditions";

  input Integer dimension "Number of Zones";

  output Real vectorSum = 0 "Sum of vector elements where condition is true";

algorithm
  for i in 1:dimension loop
    if condition[i] then
      vectorSum :=vectorSum + vector[i];
    end if;
  end for;

  annotation (Documentation(info="<html>
<p>Inputs: </p>
<ol>
<li>Vector</li>
<li>Condition (vector with boolean values)</li>
<li>Dimension (dimension of vectors)</li>
</ol>
<p>Output:</p>
<ol>
<li>Sum of vector elements where condition is true</li>
</ol>
</html>", revisions="<html>
<p><ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib</li>
</ul></p>
<p><ul>
<li><i>March 7, 2014&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end SumCondition;
