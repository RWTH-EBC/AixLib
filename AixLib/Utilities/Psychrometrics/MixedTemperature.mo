within AixLib.Utilities.Psychrometrics;
model MixedTemperature
  "Calculates the air temperature of the mixed flow of infiltration and ventilation air weighted by volume flow rate"

  parameter Modelica.SIunits.Volume vAir = 50 "Volume of the zone";

  Modelica.Blocks.Interfaces.RealInput ventilationTemperatureIn
    "Input for the ventilation Temperature"
    annotation (Placement(transformation(extent={{-120,54},{-80,94}}),
        iconTransformation(extent={{-112,62},{-80,94}})));
  Modelica.Blocks.Interfaces.RealInput infiltrationTemperatureIn
    "Input for the infiltration temperature"
    annotation (Placement(transformation(extent={{-120,-44},{-80,-4}}),
        iconTransformation(extent={{-112,-36},{-80,-4}})));
  Modelica.Blocks.Interfaces.RealOutput mixedTemperatureOut
    "Output for the mixed temperature"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealInput ventilationFlowIn(unit="m3/h")
    "Input for <b>absolute</b> ventilation flow rate m3/h"
    annotation (Placement(transformation(extent={{-120,6},{-80,46}}),
        iconTransformation(extent={{-112,14},{-80,46}})));
  Modelica.Blocks.Interfaces.RealInput infiltrationFlowIn(unit="h-1")
    "Input for <b>relative</b> infiltration flow rate 1/h"
    annotation (Placement(transformation(extent={{-120,-94},{-80,-54}}),
        iconTransformation(extent={{-112,-86},{-80,-54}})));
equation
  mixedTemperatureOut = (infiltrationTemperatureIn * infiltrationFlowIn * vAir + ventilationTemperatureIn * ventilationFlowIn)/(infiltrationFlowIn * vAir + ventilationFlowIn)
    "Calculation of the air temperature of the mixed air stream";

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
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
          textString="Vent"),
        Text(
          extent={{-46,-38},{14,-62}},
          lineColor={0,0,255},
          textString="Infil"),
        Text(
          extent={{44,-26},{104,-50}},
          lineColor={0,0,255},
          textString="T mix"),
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
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>This model calculates the weighted mixed temperature of two different air flows. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The air flows are weighted by the volume flow they provide to the output and the temperature is calculated accordingly. </p>
<p>Due to different standards in the use of the input units the volume flows have to be provided in the following pattern:</p>
<p><ul>
<li>Ventilation in m3/h</li>
<li>Infiltration in 1/h </li>
</ul></p>
<p>Furthermore is the total air volume of the room needed as an input parameter to calculate the infiltration volume flow depending of the size of the room.</p>
</html>", revisions="<html>
<p><ul>
<li><i>October 28, 20145nbsp;</i> by Moritz Lauster:<br/>Moved to AixLib</li>
</ul></p>
<p><ul>
<li><i>February 6, 2014&nbsp;</i> by Ole Odendahl:<br/>Model created and tested</li>
</ul></p>
</html>"));
end MixedTemperature;
