within AixLib.DataBase.WindowsDoors.ASHRAE140WithPanes;
record Default "Default ASHRAE140 double pane glazing"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 1 "Number of wall layers",
    d={0.003175} "Thickness of wall layers",
    rho={2500} "Density of wall layers",
    lambda={1.06} "Thermal conductivity of wall layers",
    c={750} "Specific heat capacity of wall layers",
    eps=0.84 "Emissivity of surface to interior");

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>January 9, 2020 by Philipp Mehrfeld:<br/>
    Model added to the AixLib library.
  </li>
</ul>
</html>"));
end Default;
