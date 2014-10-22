within AixLib.HVAC.Sensors;
model TemperatureSensor "Sensor which outputs the fluid temperature"
  extends BaseClasses.PartialSensor;

  parameter Modelica.SIunits.Temperature T_ref = baseParameters.T_ref;

equation
  signal = actualStream(port_a.h_outflow) / cp + T_ref;

  annotation (Icon(graphics={
        Line(points={{0,100},{0,50}}, color={0,0,127}),
        Line(points={{-92,0},{100,0}}, color={0,128,255}),
        Ellipse(
          extent={{-20,-68},{20,-30}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,50},{12,-34}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,50},{-12,70},{-10,76},{-6,78},{0,80},{6,78},{10,76},{12,
              70},{12,50},{-12,50}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-12,50},{-12,-35}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{12,50},{12,-34}},
          color={0,0,0},
          thickness=0.5),
        Line(points={{-40,-10},{-12,-10}}, color={0,0,0}),
        Line(points={{-40,20},{-12,20}}, color={0,0,0}),
        Line(points={{-40,50},{-12,50}}, color={0,0,0})}), Documentation(
        info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p><br>This component monitors the temperature of the mass flow flowing from port_a to port_b. The sensor is ideal, i.e., it does not influence the fluid. </p>
<p><br>This model is based on the simple assumption of h = c_p * (T - T_ref) with a constant c_p from BaseParameters.</p>
<p><br><b><font style=\"color: #008000; \">Example Results</font></b></p>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst</a></p>
</html>",
      revisions="<html>
<p>02.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end TemperatureSensor;
