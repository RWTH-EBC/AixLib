within AixLib.DataBase.Walls.ASHRAE140;
record DummyDefinition
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
  n(min=1) = 1 "Number of wall layers",
    d={1} "Thickness of wall layers",
    rho={1} "Density of wall layers",
    lambda={1} "Thermal conductivity of wall layers",
    c={1} "Specific heat capacity of wall layers",
    eps=1 "Emissivity of inner wall surface");
                                                        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DummyDefinition;
