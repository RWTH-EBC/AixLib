within AixLib.Utilities.Interfaces;
model ThermalRadiationCollector "Collects m radiation heat flows"
  parameter Integer m(min=1)=3 "Number of collected heat flows";

  Utilities.Interfaces.Star Star_a[m]
    "The input connector: m different radiation heat flows can be put in
    as a vector."
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Utilities.Interfaces.Star Star_b
    "The output connector: the m radiation heat flows are merged to one heat
    flow."
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));
equation
  Star_b.Q_flow + sum(Star_a.Q_flow) = 0;
  Star_a.T = fill(Star_b.T, m);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-30},{150,-70}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Text(
          extent={{-150,80},{150,50}},
          lineColor={0,0,0},
          textString="m=%m"),
        Line(
          points={{0,90},{0,40}},
          color={95,95,95}),
        Rectangle(
          extent={{-60,40},{60,30}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,30},{0,-30},{0,-90}},
          color={95,95,95}),
        Line(
          points={{0,-30},{-20,30}},
          color={95,95,95}),
        Line(
          points={{0,-30},{20,30}},
          color={95,95,95}),
        Line(
          points={{0,-30},{60,30}},
          color={95,95,95})}),
    Documentation(info="<html>
    <p>This is a model to collect the radiation heat flows from <i>m</i> 
    star points to one single star point.</p>
    <p>The model is based on the 
    <a href=\"Modelica.Thermal.HeatTransfer.Components.ThermalCollector\">
    Modelica.Thermal.HeatTransfer.Components.ThermalCollector </a> model
    and works in the same way.</p>
    </html>"));
end ThermalRadiationCollector;
