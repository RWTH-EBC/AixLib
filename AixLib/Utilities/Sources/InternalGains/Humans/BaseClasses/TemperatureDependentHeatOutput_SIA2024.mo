within AixLib.Utilities.Sources.InternalGains.Humans.BaseClasses;
model TemperatureDependentHeatOutput_SIA2024
  "Model for temperature dependent heat output based on formulas of SIA 2024"

  parameter Real ActivityDegree = 1.0 "activity degree of persons in room in met";

  Modelica.Blocks.Interfaces.RealInput Temperature
    "room temperature used for heat output calculation"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));

  Modelica.Blocks.Interfaces.RealOutput heatOutput
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  constant Real heatPerMet(unit="W/(m.m)") = 58 "heat per m² for 1 met";
  constant Modelica.SIunits.Area bodySurface = 1.8 "body surface of one person";
  constant Real TemperatureCoefficient(unit="1/K") = 0.025 "parameter for temperature dependency";
  constant Modelica.SIunits.HeatFlowRate minimumHeat = 35 "minimum heat output";
equation

  heatOutput = (0.865-(TemperatureCoefficient * Temperature))*(ActivityDegree*heatPerMet*bodySurface)+minimumHeat;

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
        coordinateSystem(preserveAspectRatio=false)));
end TemperatureDependentHeatOutput_SIA2024;
