within AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost;
model NoDefrost "No defrost, always heating"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost.BaseClasses.PartialDefrost;
  Modelica.Blocks.Sources.BooleanConstant booCon(final k=true) "Always heating"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(booCon.y, hea)
    annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
  annotation (Icon(graphics={Text(
          extent={{-68,-50},{80,48}},
          lineColor={0,0,0},
          textString="hea")}), Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
Disables defrost control.
</html>"));
end NoDefrost;
