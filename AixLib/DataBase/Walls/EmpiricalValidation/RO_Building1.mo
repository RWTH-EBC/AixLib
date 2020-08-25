within AixLib.DataBase.Walls.EmpiricalValidation;
record RO_Building1 "Roof for Empirical Validation Building1"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 3 "Number of wall layers",
    d={0.001,0.1,0.001} "Thickness of wall layers",
    rho={980,100,100} "Density of wall layers",
    lambda={0.5,0.035,10} "Thermal conductivity of wall layers",
    c={1800,830,1000} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">References</font></h4>
<p>For Empirical Validation: Building 1</p>
</html>", revisions="<html>
<ul>
<li><i>August 4, 2020</i> by Konstantina Xanthopoulou:<br/>implemented</li>
</ul>
</html>"));
end RO_Building1;
