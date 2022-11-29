within AixLib.DataBase.Pools.SwimmingPoolWalls;
record ConcreteIsulationConstruction "Concrete pool construction with isolation"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 3 "Number of wall layers",
    d={0.05,0.2,0.1} "Thickness of wall layers",
    rho={1940,2330,30} "Density of wall layers",
    lambda={1.4,2.1,0.035} "Thermal conductivity of wall layers",
    c={0.0001,0.001,0.00138} "Specific heat capacity of wall layers",
    eps=0.9 "Emissivity of inner wall surface");
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ConcreteIsulationConstruction;
