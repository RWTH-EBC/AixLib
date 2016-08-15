within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
function SumCondition
  "Returns the sum of entries of a vector and their share if a condition is true"

  input Real vector[dimension] "Input vector";

  input Boolean condition[dimension] "Vector of conditions";

  input Integer dimension "dimension of inputs";

  output Real vectorSum = 0 "Sum of vector elements where condition is true";

  output Real vectorShare[dimension]
    "Share of vector elements where condition is true, entries with conditon is false are set to zero";

algorithm
  for i in 1:dimension loop
    if condition[i] then
      vectorSum :=vectorSum + vector[i];
    end if;
  end for;
  for i in 1:dimension loop
    if condition[i] and vectorSum > 0 then
      vectorShare[i] :=vector[i]/vectorSum;
    else
      vectorShare[i] := 0;
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
<li>Share of vector elements where condition is true</li>
</ol>
</html>", revisions="<html>
<ul>
<li><i>February 26, 2016&nbsp;</i> by Moritz Lauster:<br/>Added share of volume for each zone as output.</li>
</ul>
<ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib</li>
</ul>
<ul>
<li><i>March 7, 2014&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>"));
end SumCondition;
