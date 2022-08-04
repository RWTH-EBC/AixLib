within AixLib.DataBase.Walls.EmpiricalValidation;
record IW_LightMass_TwinHouses
  "Interior Wall(LightMass) for Empirical Validation TwinHouses Holzkirchen"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 3 "Number of wall layers",
    d={0.01,0.115,0.01} "Thickness of wall layers, first=outside; last=inside",
    rho={1200,1000,1200} "Density of wall layers",
    lambda={0.35,0.331,0.35} "Thermal conductivity of wall layers",
    c={1000,1000,1000} "Specific heat capacity of wall layers",
    eps=0.9 "Emissivity of inner wall surface");
  annotation (Documentation(info="<html>
</html>", revisions="<html>
<ul>
  <li>
    <i>August 4, 2020</i> by Konstantina Xanthopoulou:<br/>
    implemented
  </li>
</ul>
</html>"));
end IW_LightMass_TwinHouses;
