within AixLib.BoundaryConditions.InternalGains.Humans.BaseClasses;
model TemperatureDependentHeatOutputSIA2024
  "Model for temperature dependent heat output based on formulas of SIA 2024"

  parameter Real activityDegree=1.0 "Activity degree of persons in room in met";

  Modelica.Blocks.Interfaces.RealInput T
    "Room temperature used for heat output calculation"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.RealOutput heatOutput
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  constant Real HeatPerMet(unit="W/(m.m)") = 58 "Heat per m² for 1 met";
  constant Modelica.Units.SI.Area BodySurface=1.8 "Body surface of one person";
  constant Real TemperatureCoefficient(unit="1/K") = 0.025
    "Parameter for temperature dependency";
  constant Modelica.Units.SI.HeatFlowRate MinimumHeat=35 "Minimum heat output";
equation

  heatOutput =max(0, (0.865 - (TemperatureCoefficient*T))*(activityDegree*
    HeatPerMet*BodySurface) + MinimumHeat);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-58,22},{46,-26}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q = f(T)"), Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5)}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  <b><span style=\"color: #008000\">Overview</span></b>
</p>
<p>
  Model for heat output depending on temperature according to SIA 2024.
  This model calculates the heat output depending on the room
  temperature.
</p>
<p>
  <b><span style=\"color: #008000\">Concept</span></b>
</p>
<p>
  This model calculates the heat output of a person depending on an
  acitivity degree and the room temperature.
</p>
<p>
  The activity degree <i>M</i> (in met) can be set to consider
  different types of acitivty of the person.
</p>
<p>
  The heat output <i>q<sub>Person</sub></i> is calculated by the
  following equation[1]:
</p>
<p style=\"text-align:center;\">
  <i>q<sub>Person</sub> = (0.865 - (0.025</i> 1/K <i>·
  θ<sub>room</sub>) ·(M · 58</i> W/m² <i>· 1.8</i> m²<i>) + 35</i> W
</p>
<p>
  <b><span style=\"color: #008000\">References</span></b>
</p>
<p>
  [1]: SIA 2024: Space usage data for energy and building services
  engineering - 2015
</p>
<ul>
  <li>July 10, 2019, by Martin Kremer:<br/>
    Implemented
  </li>
</ul>
</html>"));
end TemperatureDependentHeatOutputSIA2024;
