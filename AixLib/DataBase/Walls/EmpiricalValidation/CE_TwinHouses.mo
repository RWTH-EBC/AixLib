within AixLib.DataBase.Walls.EmpiricalValidation;
record CE_TwinHouses "Ceiling for Empirical Validation TwinHouses Holzkirchen"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 5 "Number of wall layers",
    d={0.22,0.029,0.03,0.033,0.065} "Thickness of wall layers, first=outside; last=inside",
    rho={2400,80,80,80,2000} "Density of wall layers",
    lambda={2.1,0.06,0.025,0.023,1.4} "Thermal conductivity of wall layers",
    c={1000,840,840,840,1000} "Specific heat capacity of wall layers",
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
end CE_TwinHouses;
