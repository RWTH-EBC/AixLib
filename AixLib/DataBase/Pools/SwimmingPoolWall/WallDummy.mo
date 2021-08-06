within AixLib.DataBase.Pools.SwimmingPoolWall;
record WallDummy
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 1 "Number of wall layers",
    d={Modelica.Constants.eps,Modelica.Constants.eps,Modelica.Constants.eps} "Thickness of wall layers",
    rho={Modelica.Constants.eps,Modelica.Constants.eps,Modelica.Constants.eps} "Density of wall layers",
    lambda={Modelica.Constants.eps,Modelica.Constants.eps,Modelica.Constants.eps} "Thermal conductivity of wall layers",
    c={Modelica.Constants.inf,Modelica.Constants.inf,Modelica.Constants.inf} "Specific heat capacity of wall layers",
    eps=Modelica.Constants.eps "Emissivity of inner wall surface");
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WallDummy;
