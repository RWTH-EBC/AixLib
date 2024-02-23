within AixLib.DataBase.Walls.ASHRAE140;
record RO_Case600_eps01 "Roof for Case 600"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 3 "Number of wall layers",
    d={0.019,0.1118,0.010} "Thickness of wall layers",
    rho={530,12,950} "Density of wall layers",
    lambda={0.14,0.040,0.160} "Thermal conductivity of wall layers",
    c={900,840,840} "Specific heat capacity of wall layers",
    eps=0.1 "Emissivity of inner wall surface");
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  For ASHRAE 140 see Bibtexkey: ASHRAE-140-2007
</p>
</html>"));
end RO_Case600_eps01;
