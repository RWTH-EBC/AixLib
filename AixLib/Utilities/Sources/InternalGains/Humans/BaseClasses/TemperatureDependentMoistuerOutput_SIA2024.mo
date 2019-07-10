within AixLib.Utilities.Sources.InternalGains.Humans.BaseClasses;
model TemperatureDependentMoistuerOutput_SIA2024
  "Model for temperature dependent moisture output based on formulas of SIA 2024"

  parameter Real ActivityDegree = 1.0 "activity degree of persons in room in met";

  Modelica.Blocks.Interfaces.RealInput Temperature
    "room temperature used for heat output calculation"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));

  Modelica.Blocks.Interfaces.RealOutput moistOutput "moisture output in g/h"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  TemperatureDependentHeatOutput_SIA2024
    temperatureDependentHeatOutput_SIA2024
    annotation (Placement(transformation(extent={{-74,32},{-54,52}})));
protected
  constant Real heatPerMet(unit="W/(m.m)") = 58 "heat per m² for 1 met";
  constant Modelica.SIunits.Area bodySurface = 1.8 "body surface of one person";
  constant Real moistGain(unit="g/h") = 10/7 "gain for moistuer output";
equation

  moistOutput = moistGain*((ActivityDegree*heatPerMet*bodySurface)-temperatureDependentHeatOutput_SIA2024.heatOutput);

  connect(Temperature, temperatureDependentHeatOutput_SIA2024.Temperature)
    annotation (Line(points={{-120,0},{-86,0},{-86,42},{-75,42}}, color={0,0,127}));
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
        coordinateSystem(preserveAspectRatio=false)));
end TemperatureDependentMoistuerOutput_SIA2024;
