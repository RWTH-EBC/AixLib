within AixLib.Utilities.Psychrometrics;
model MixedTemperature
  "Calculates the air temperature of the mixed flow of infiltration and ventilation air weighted by air change per hour"

  Modelica.Blocks.Interfaces.RealInput temperature_flow1(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min=0) "Temperature volume flow 1"
                                annotation (Placement(transformation(extent={{-120,
            54},{-80,94}}), iconTransformation(extent={{-112,62},{-80,94}})));
  Modelica.Blocks.Interfaces.RealInput temperature_flow2(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Temperature volume flow 2"
                                annotation (Placement(transformation(extent={{-120,
            -44},{-80,-4}}), iconTransformation(extent={{-112,-36},{-80,-4}})));
  Modelica.Blocks.Interfaces.RealOutput mixedTemperatureOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Output for the mixed temperature"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput flowRate_flow1 "Flow rate volume flow 1"
    annotation (Placement(transformation(extent={{-120,6},{-80,46}}),
        iconTransformation(extent={{-112,14},{-80,46}})));
  Modelica.Blocks.Interfaces.RealInput flowRate_flow2 "Flow rate volume flow 2"
    annotation (Placement(transformation(extent={{-120,
            -94},{-80,-54}}), iconTransformation(extent={{-112,-86},{-80,-54}})));
equation
  mixedTemperatureOut = (temperature_flow1 * flowRate_flow1 + temperature_flow2 * flowRate_flow2)/(flowRate_flow1 + flowRate_flow2)
    "Calculation of the air temperature of the mixed air stream";

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{16,-6},{-114,-90}},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{16,92},{-114,8}},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-50,62},{10,38}},
          lineColor={0,0,255},
          textString="V_1"),
        Text(
          extent={{-46,-38},{14,-62}},
          lineColor={0,0,255},
          textString="V_2"),
        Text(
          extent={{44,-26},{104,-50}},
          lineColor={0,0,255},
          textString="T_mix"),
        Text(
          extent={{-78,88},{-54,60}},
          lineColor={0,0,255},
          textString="T"),
        Text(
          extent={{-78,-12},{-54,-40}},
          lineColor={0,0,255},
          textString="T"),
        Text(
          extent={{-78,44},{-54,16}},
          lineColor={0,0,255},
          textString="V"),
        Text(
          extent={{-78,-56},{-54,-84}},
          lineColor={0,0,255},
          textString="v"),
        Rectangle(
          extent={{18,12},{42,-20}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Ellipse(
          extent={{22,20},{38,16}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{34,18},{26,10}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Line(
          points={{44,0},{74,0},{78,0}},
          color={0,0,255},
          thickness=0.5,
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-34,-34},{10,-6},{14,-4}},
          color={0,0,255},
          thickness=0.5,
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-34,34},{10,6},{14,4}},
          color={0,0,255},
          thickness=0.5,
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{21,6},{40,-16}},
          lineColor={255,255,255},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="V")}),
    Documentation(info="<html><p>
  This model calculates the mixed temperature of two different air
  flows by weighting with the volume flows.
</p>
<ul>
  <li>
    <i>October 28, 2015&#160;</i> by Moritz Lauster:<br/>
    Moved to AixLib and renaming. Changed equations and simplified
    model. All unit conversions now need to be handled beforehand
  </li>
  <li>
    <i>February 6, 2014&#160;</i> by Ole Odendahl:<br/>
    Model created and tested
  </li>
</ul>
</html>"));
end MixedTemperature;
