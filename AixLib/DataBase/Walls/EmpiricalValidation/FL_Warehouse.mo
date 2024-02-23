within AixLib.DataBase.Walls.EmpiricalValidation;
record FL_Warehouse "Floor for Empirical Validation of Warehouse example"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 2 "Number of wall layers",
    d={0.5,0.3} "Thickness of wall layers",
    rho={2200,2400} "Density of wall layers",
    lambda={2,2.5} "Thermal conductivity of wall layers",
    c={1000,880} "Specific heat capacity of wall layers",
    eps=0.95 "Emissivity of inner wall surface");
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  For Empirical Validation: Building 1
</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>August 4, 2020</i> by Konstantina Xanthopoulou:<br/>
    implemented
  </li>
</ul>
</html>"));
end FL_Warehouse;
