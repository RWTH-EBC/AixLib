within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Sensors;
model TemperatureSensor " Temperature sensor"
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  Modelica.Blocks.Interfaces.RealOutput T( final quantity="ThermodynamicTemperature",
                                          final unit = "K", displayUnit = "degC", min=0)
    "Output value which contains the measured temperature of the fluid"
                                                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,90}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,110})));
  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a "Input connector"
    annotation (Placement(transformation(extent={{-100,-12},{-78,10}}),
        iconTransformation(extent={{-100,-12},{-76,10}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b "Output connector"
    annotation (Placement(transformation(extent={{80,-12},{102,10}}),
        iconTransformation(extent={{78,-12},{102,10}})));
equation
  T = enthalpyPort_a.T;

  connect(enthalpyPort_a, enthalpyPort_b) annotation (Line(
      points={{-89,-1},{91,-1}},
      color={176,0,0},
      smooth=Smooth.None));
  annotation (defaultComponentName="temperature",
        Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},
            {100,100}}),
                   graphics={
        Ellipse(
          extent={{-10,-96},{30,-58}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,42},{22,-66}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,42},{-2,82},{0,88},{4,90},{10,92},{16,90},{20,88},{22,82},
              {22,42},{-2,42}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-2,42},{-2,-62}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{22,42},{22,-62}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-30,-18},{-2,-18}}, color={0,0,0}),
        Line(points={{-30,22},{-2,22}}, color={0,0,0}),
        Line(points={{-30,62},{-2,62}}, color={0,0,0}),
        Text(
          extent={{120,-12},{20,-112}},
          lineColor={0,0,0},
          textString="K"),
        Text(
          extent={{134,126},{-26,96}},
          lineColor={0,0,0},
          textString="T"),
        Polygon(
          points={{20,-102},{64,-118},{20,-132},{20,-102}},
          lineColor={176,0,0},
          smooth=Smooth.None,
          fillColor={176,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,-107},{52,-118},{20,-128},{20,-107}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{52,-118},{-60,-118}},
          color={176,0,0},
          smooth=Smooth.None),
          Text(
          extent={{-138,-126},{162,-166}},
          textString="%name",
          lineColor={0,0,255})}),
                             Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Temperature sensor measures the absolute temperature.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.FastHVAC.Examples.Sensors.SensorVerification\">SensorVerification</a>
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>April 15, 2017&#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>December 16, 2014&#160;</i> by Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html> "));
end TemperatureSensor;
