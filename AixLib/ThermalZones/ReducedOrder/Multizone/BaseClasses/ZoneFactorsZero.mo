within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
function ZoneFactorsZero
  "Air volume ratio of a zone from a vector of zones"
  input Integer dimension "Number of zones";
  input Boolean withAHU[dimension] "AHU states of zones";
  input Modelica.SIunits.Volume VAir[dimension] "Indoor air volume of zones";
  output Real zoneFactor[dimension,1] "Calculated zone factors";

protected
  Real VAirRes "Resulting air volume in zones supplied by the AHU";

algorithm
  for i in 1:dimension loop
    if withAHU[i] then
      VAirRes :=VAirRes + VAir[i];
    end if;
  end for;
  for i in 1:dimension loop
    if withAHU[i] then
      zoneFactor[i,1] :=VAir[i]/VAirRes;
    else
      zoneFactor[i,1] :=0;
    end if;
  end for;
  annotation (Documentation(revisions="<html>
<ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib</li>
</ul>
</html>",
        info="<html>
<p>The function calculates the ratio of air volume of a zone from a given vector of zones. If withAHU for this zone is false, its share is set to zero.</p>
</html>"));
end ZoneFactorsZero;
