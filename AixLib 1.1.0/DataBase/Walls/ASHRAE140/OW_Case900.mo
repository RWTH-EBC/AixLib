within AixLib.DataBase.Walls.ASHRAE140;
record OW_Case900 "Outside Wall for Case 900"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 3 "Number of wall layers",
    d={0.009,0.0615,0.1} "Thickness of wall layers",
    rho={530,10,1400} "Density of wall layers",
    lambda={0.14,0.040,0.51} "Thermal conductivity of wall layers",
    c={900,1400,1000} "Specific heat capacity of wall layers",
    eps=0.9 "Emissivity of inner wall surface");
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  For ASHRAE 140 see Bibtexkey: ASHRAE-140-2007
</p>
</html>"));
end OW_Case900;
