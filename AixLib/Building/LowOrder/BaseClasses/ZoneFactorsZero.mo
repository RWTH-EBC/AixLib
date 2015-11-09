within AixLib.Building.LowOrder.BaseClasses;
function ZoneFactorsZero
  "Calculates the air volume ratio of a zone from a given vector of zones"
  input Integer dimension "Number of zones";
  input AixLib.DataBase.Buildings.ZoneBaseRecord zoneParam[dimension]
    "Zone parameter";
  output Real zoneFactor[dimension] "Calculated zone factors";

protected
  Real VairRes "Resulting air volume in zones supplied by the AHU";

algorithm
  for i in 1:dimension loop
    if zoneParam[i].withAHU then
      VairRes :=VairRes + zoneParam[i].Vair;
    end if;
  end for;
  for i in 1:dimension loop
    if zoneParam[i].withAHU then
      zoneFactor[i] :=zoneParam[i].Vair/VairRes;
    else
      zoneFactor[i] :=0;
    end if;
  end for;
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib</li>
</ul></p>
</html>",
        info="<html>
<p>The function calculates the ratio of air volume of a zone from a given vector of zones. If withAHU for this zone is false, its share is set to zero.</p>
</html>"));
end ZoneFactorsZero;
