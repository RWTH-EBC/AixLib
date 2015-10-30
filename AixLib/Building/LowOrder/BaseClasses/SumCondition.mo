within AixLib.Building.LowOrder.BaseClasses;
function SumCondition "Sums up the entries of a vector if a condition is true"

  input Real vector[:];

  input Boolean condition[:];

  input Integer Dimension "Number of Zones";

  output Real vectorSum = 0;

algorithm
  for i in 1:Dimension loop
    if condition[i] then
      vectorSum :=vectorSum + vector[i];
    end if;
  end for;

  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Inputs: </p>
<ol>
<li>Vector</li>
<li>Condition (Vector with boolean values)</li>
<li>Dimension (Dimension of vectors)</li>
</ol>
<p>Output:</p>
<ol>
<li>Sum of Vector entries where condition is true</li>
</ol>
<p><h4><span style=\"color:#008000\">Level of Development</span></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>", revisions="<html>
<p><ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib</li>
</ul></p>
<p><ul>
<li><i>March 7, 2014&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end SumCondition;
