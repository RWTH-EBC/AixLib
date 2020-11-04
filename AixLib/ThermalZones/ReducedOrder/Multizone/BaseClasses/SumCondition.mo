within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
function SumCondition
  "Conditional sum and share"

  input Real vector[dimension]
    "Input vector";
  input Boolean condition[dimension]
    "Vector of conditions";
  input Integer dimension
    "Dimension of inputs";
  output Real vectorSum = 0
    "Sum of vector elements where condition is true";
  output Real vectorShare[dimension]
    "Share of vector elements where condition is true, entries with conditon is
    false are set to zero";

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

  annotation (Documentation(info="<html><p>
  Returns the sum of entries of a vector and their share if a condition
  is true.
</p>
<p>
  Inputs:
</p>
<ol>
  <li>Vector
  </li>
  <li>Condition (vector with boolean values)
  </li>
  <li>Dimension (dimension of vectors)
  </li>
</ol>
<p>
  Output:
</p>
<ol>
  <li>Sum of vector elements where condition is true
  </li>
  <li>Share of vector elements where condition is true
  </li>
</ol>
<ul>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Moved to fit to new Annex60 structure.
  </li>
  <li>February 26, 2016, by Moritz Lauster:<br/>
    Added share of volume for each zone as output.
  </li>
  <li>October 30, 2015, by Moritz Lauster:<br/>
    Moved and adapted to AixLib.
  </li>
  <li>March 7, 2014, by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end SumCondition;
