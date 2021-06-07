within AixLib.DataBase.Walls.EmpiricalValidation;
record DummyDefinition
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
  n(min=1) = 1 "Number of wall layers",
    d={1} "Thickness of wall layers",
    rho={1} "Density of wall layers",
    lambda={1} "Thermal conductivity of wall layers",
    c={1} "Specific heat capacity of wall layers",
    eps=1 "Emissivity of inner wall surface");
                                                        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>August 4, 2020</i> by Konstantina Xanthopoulou:<br/>
    implemented
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Dummy Wall record/p&gt;
</p>
</html>"));
end DummyDefinition;
