within AixLib.BoundaryConditions.InternalGains.Humans.BaseClasses;
model TemperatureDependentMoistureOutputSIA2024
  "Model for temperature dependent moisture output based on formulas of SIA 2024"

  parameter Real activityDegree=1.0 "Activity degree of persons in room in met";

  Modelica.Blocks.Interfaces.RealInput T
    "Room temperature used for heat output calculation"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.RealOutput moistOutput "Moisture output in g/h"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  TemperatureDependentHeatOutputSIA2024 temperatureDependentHeatOutput_SIA2024(activityDegree=activityDegree)
    "Temperature dependent heat output"
    annotation (Placement(transformation(extent={{-74,32},{-54,52}})));
protected
  constant Real HeatPerMet(unit="W/(m.m)") = 58 "Heat per m² for 1 met";
  constant Modelica.Units.SI.Area BodySurface=1.8 "Body surface of one person";
  constant Real MoistGain(unit="g/h") = 10/7 "Gain for moisture output";
equation

  moistOutput = max(0,MoistGain*((activityDegree*HeatPerMet*BodySurface)-temperatureDependentHeatOutput_SIA2024.heatOutput));

  connect(T, temperatureDependentHeatOutput_SIA2024.T) annotation (Line(points=
          {{-120,0},{-86,0},{-86,42},{-76,42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-58,22},{46,-26}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="m = f(T)"), Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5)}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  <b><span style=\"color: #008000\">Overview</span></b>
</p>
<p>
  Model for moisture output depending on temperature according to SIA
  2024. This model calculates the moisture output depending on the room
  temperature.
</p>
<p>
  <b><span style=\"color: #008000\">Concept</span></b>
</p>
<p>
  This model uses the <a href=
  \"AixLib.Utilities.Sources.InternalGains.Humans.BaseClasses.TemperatureDependentHeatOutput_SIA2024\">
  TemperatureDependenHeatOutput_SIA2024</a> to calculate the heat
  output <i>q<sub>Person</sub></i> of a person depending on the
  temperature.
</p>
<p>
  The heat output is used to calculate the corresponding moisture
  output of a person.
</p>
<p>
  An activity degree <i>M</i> (in met) can be set to consider different
  types of acitivty of the person.
</p>
<p>
  The moisture output <i>m</i> is calculated by the following
  equation[1]:
</p>
<p style=\"text-align:center;\">
  <i>m = 10.7</i> g/h <i>· ((M · 58</i> W/m² <i>· 1.8</i> m²<i>)-
  q<sub>Person</sub>)</i>
</p>
<p>
  <b><span style=\"color: #008000\">References</span></b>
</p>
<p>
  [1]: SIA 2024: Space usage data for energy and building services
  engineering - 2015
</p>
<ul>
  <li>
    <i>July 10, 2019&#160;</i> by Martin Kremer:<br/>
    Implemented
  </li>
</ul>
</html>"));
end TemperatureDependentMoistureOutputSIA2024;
