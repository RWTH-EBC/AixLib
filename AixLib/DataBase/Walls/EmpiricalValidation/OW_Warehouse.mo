within AixLib.DataBase.Walls.EmpiricalValidation;
record OW_Warehouse "Outside Wall for Empirical Validation of Warehouse example"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 3 "Number of wall layers",
    d={0.001,0.1,0.001} "Thickness of wall layers",
    rho={100,100,100} "Density of wall layers",
    lambda={10,0.035,10} "Thermal conductivity of wall layers",
    c={1000,830,1000} "Specific heat capacity of wall layers",
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
end OW_Warehouse;
