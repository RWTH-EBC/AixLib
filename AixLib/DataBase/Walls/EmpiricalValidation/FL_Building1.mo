within AixLib.DataBase.Walls.EmpiricalValidation;
record FL_Building1
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 2 "Number of wall layers",
    d={0.5,0.3} "Thickness of wall layers",
    rho={2200,2400} "Density of wall layers",
    lambda={2,2.5} "Thermal conductivity of wall layers",
    c={1000,880} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">References</font></h4>
<p>For ASHRAE 140 see Bibtexkey: ASHRAE-140-2007</p>
</html>"));
end FL_Building1;
