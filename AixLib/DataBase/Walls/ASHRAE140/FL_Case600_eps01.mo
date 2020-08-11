within AixLib.DataBase.Walls.ASHRAE140;
record FL_Case600_eps01 "Floor for Case 600"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 2 "Number of wall layers",
    d={1.003,0.025} "Thickness of wall layers",
    rho={0.0001,650} "Density of wall layers",
    lambda={0.04,0.140} "Thermal conductivity of wall layers",
    c={0.0001,1200} "Specific heat capacity of wall layers",
    eps=0.1 "Emissivity of inner wall surface");
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  For ASHRAE 140 see Bibtexkey: ASHRAE-140-2007
</p>
</html>"));
end FL_Case600_eps01;
