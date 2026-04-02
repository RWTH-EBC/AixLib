within AixLib.Fluid.HeatPumps.ModularReversible.Controls.Defrost.BaseClasses;
partial model PartialDefrost "Partial model for defrost control"

  AixLib.Fluid.HeatPumps.ModularReversible.BaseClasses.RefrigerantMachineControlBus
    sigBus "Bus with the most relevant information for hp frosting calculation"
    annotation (Placement(transformation(extent={{-122,-20},{-82,20}}),
        iconTransformation(extent={{-122,-20},{-82,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput hea "Heating mode for heat pump"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          lineColor={0,0,255},
          extent={{-148,97},{152,137}},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
Partial model to decide whether to heat or cool with the heat pump, depeneding on the signal bus information.
</html>"));
end PartialDefrost;
