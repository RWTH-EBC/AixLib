within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Sensors;
model MassFlowSensor "Mass flow sensor"
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  Modelica.Blocks.Interfaces.RealOutput dotm( unit="kg/s")
    "Output value which contains the measured mass flow of the fluid"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,90}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,90})));
  Interfaces.EnthalpyPort_a enthalpyPort_a "Input connector"
    annotation (Placement(transformation(extent={{-100,-12},{-78,10}}),
        iconTransformation(extent={{-100,-12},{-76,10}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b "Output connector"
    annotation (Placement(transformation(extent={{80,-12},{102,10}}),
        iconTransformation(extent={{78,-12},{102,10}})));
equation
  dotm = enthalpyPort_a.m_flow;

  connect(enthalpyPort_a, enthalpyPort_b) annotation (Line(
      points={{-89,-1},{91,-1}},
      color={176,0,0},
      smooth=Smooth.None));
  annotation ( defaultComponentName="massFlowRate",
        Icon(graphics={
        Ellipse(
          extent={{-64,60},{76,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{6,-10},{15.02,18.6}},
                                         color={0,0,0}),
        Ellipse(
          extent={{1,-5},{11,-15}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{5.52,21.6},{24,16},{24,47.2},{5.52,21.6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{136,108},{-24,78}},
          lineColor={0,0,0},
          textString="dotm"),
          Text(
          extent={{-140,-74},{160,-114}},
          textString="%name",
          lineColor={0,0,255})}),
                             Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
   Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Mass flow sensor measures the mass flow rate.
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
end MassFlowSensor;
