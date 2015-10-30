within AixLib.Building.LowOrder.BaseClasses;
function ZoneFactorsZero
  "Calculates the zone factors for the real splitter optional setting a value to zero determined by an input record"
  input Integer Dimension "Number of zones";
  input AixLib.DataBase.Buildings.ZoneBaseRecord zoneParam[Dimension]
    "Zone parameter";
  output Real ZoneFactor[Dimension] "Calculated zone factors";

protected
  Real VairRes "Resulting air volume in zones supplied by the AHU";

algorithm
  for i in 1:Dimension loop
    if zoneParam[i].withAHU then
      VairRes :=VairRes + zoneParam[i].Vair;
    end if;
  end for;
  for i in 1:Dimension loop
    if zoneParam[i].withAHU then
      ZoneFactor[i] :=zoneParam[i].Vair/VairRes;
    else
      ZoneFactor[i] :=0;
    end if;
  end for;
  annotation (Documentation(revisions="<html>
<p><ul>
<li><i>October 30, 2015&nbsp;</i> by Moritz Lauster:<br/>Moved and adapted to AixLib</li>
</ul></p>
</html>"));
end ZoneFactorsZero;
