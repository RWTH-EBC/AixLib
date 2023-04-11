within AixLib.DataBase.Pools.SwimmingPoolWalls;
record StainlessSteelConstruction
  "Stainless steel pool construction without insulation"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 1 "Number of wall layers",
    d={0.05} "Thickness of wall layers",
    rho={7900} "Density of wall layers",
    lambda={15} "Thermal conductivity of wall layers",
    c={500} "Specific heat capacity of wall layers",
    eps=0.9 "Emissivity of inner wall surface");
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end StainlessSteelConstruction;
