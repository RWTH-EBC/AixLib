within AixLib.HVAC;
package Sensors "Contains sensors "
  extends Modelica.Icons.SensorsPackage;
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

  model MassFlowSensor "Sensor which outputs the fluid mass flow rate"
    extends BaseClasses.PartialSensor;
    extends Modelica.Icons.RotationalSensor;

  equation
    signal = port_a.m_flow;

    annotation (Icon(graphics={
          Line(
            points={{-70,0},{-94,0},{-96,0}},
            color={0,127,255},
            smooth=Smooth.None),
          Line(
            points={{0,38},{0,90}},
            color={135,135,135},
            smooth=Smooth.None),
          Line(
            points={{70,0},{100,0}},
            color={0,127,255},
            smooth=Smooth.None)}),                           Documentation(
          info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p><br>This component monitors the mass flow rate from port_a to port_b. The sensor is ideal, i.e., it does not influence the fluid. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst</a></p>
</html>",
        revisions="<html>
<p>07.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics));
  end MassFlowSensor;

  model ComfortSensor "calculates the operative temperature"

    Interfaces.RadPort radPort
      annotation (Placement(transformation(extent={{-90,-54},{-70,-34}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPort
      annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
    Modelica.Blocks.Interfaces.RealOutput OperativeTemperature annotation (
        Placement(transformation(extent={{80,0},{100,20}}), iconTransformation(
            extent={{80,0},{100,20}})));

  equation
    // No influence on system
    convPort.Q_flow = 0;
    radPort.Q_flow = 0;

    // Calculate the output
    OperativeTemperature = (convPort.T + radPort.T) * 0.5;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={Ellipse(
            extent={{-60,66},{66,-58}},
            lineThickness=1,
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            lineColor={0,0,0})}), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple model for a comfort sensor, by computing the operative temperature. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The operative temperature is the mean value between the air temperature and the radiative (walls) temperature. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
</html>", revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>"));
  end ComfortSensor;

  model RelativeHumiditySensor
    "Sensor which outputs the relative Humidity of Moist Air"
    extends Interfaces.TwoPortMoistAirTransportFluidprops;
    outer BaseParameters baseParameters "System properties";
    Modelica.Blocks.Interfaces.RealOutput Humidity "Output signal from sensor"
                                  annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,100})));
  equation

    dp = 0;
    Humidity = p_Steam/p_Saturation;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}),
                     graphics={
          Line(points={{0,100},{0,50}}, color={0,0,127}),
          Line(points={{-92,0},{100,0}}, color={0,128,255}),
          Ellipse(
            extent={{-54,4},{46,-96}},
            lineColor={0,128,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-51,-28},{0,84},{42,-28},{-51,-28}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}),                Documentation(
          info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This component monitors the relative Humidity of the mass flow flowing from port_a to port_b. The sensor is ideal, i.e., it does not influence the fluid. </p>
<p><br>If there is liquid water in the air, the relative humidity is limited to 1.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer\">AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer</a></p>
</html>",
        revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics));
  end RelativeHumiditySensor;

  model PropertySensorMoistAir
    "Sensor which outputs some properties of Moist Air"
    extends Interfaces.TwoPortMoistAirTransportFluidprops;
    outer BaseParameters baseParameters "System properties";

    Modelica.Blocks.Interfaces.RealOutput X_S annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-90,-100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-90,-90})));
    Modelica.Blocks.Interfaces.RealOutput X_W annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-58,-100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,-90})));
    Modelica.Blocks.Interfaces.RealOutput Temperature   annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,-100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-30,-90})));
    Modelica.Blocks.Interfaces.RealOutput rho annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={14,-100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-90})));

    Modelica.Blocks.Interfaces.RealOutput DynamicViscosity
                                              annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,-90})));
    Modelica.Blocks.Interfaces.RealOutput VolumeFlow
                                              annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={94,-100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={60,-90})));
    Modelica.Blocks.Interfaces.RealOutput MassFlow
                                              annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={94,-100}), iconTransformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={90,-90})));
  equation

  dp = 0;

  rho = rho_MoistAir;
  Temperature = T;
  X_S = X_Steam;
  X_W = X_Water;
  DynamicViscosity = dynamicViscosity;
  VolumeFlow = abs(portMoistAir_a.m_flow/rho_Air);
  MassFlow= abs(portMoistAir_a.m_flow);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}),
                     graphics={
          Line(points={{0,68},{0,50}},  color={0,0,127}),
          Line(points={{-92,0},{100,0}}, color={0,128,255}),
          Ellipse(
            extent={{-70,68},{70,-72}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{0,68},{0,38}}, color={0,0,0}),
          Line(points={{22.9,30.8},{40.2,55.3}}, color={0,0,0}),
          Line(points={{-22.9,30.8},{-40.2,55.3}}, color={0,0,0}),
          Line(points={{37.6,11.7},{65.8,21.9}}, color={0,0,0}),
          Line(points={{-37.6,11.7},{-65.8,21.9}}, color={0,0,0}),
          Line(points={{0,-2},{9.02,26.6}},color={0,0,0}),
          Polygon(
            points={{-0.48,29.6},{18,24},{18,55.2},{-0.48,29.6}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-5,3},{5,-7}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),                Documentation(
          info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This component monitors some properties of the mass flow flowing from port_a to port_b. The sensor is ideal, i.e., it does not influence the fluid.</p>
</html>",
        revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),     graphics));
  end PropertySensorMoistAir;

  package BaseClasses "Contains base classes for sensors"
    extends Modelica.Icons.BasesPackage;
    partial model PartialSensor "Base class for sensors"
      extends Interfaces.TwoPort;

      Modelica.Blocks.Interfaces.RealOutput signal "Output signal from sensor"
                                    annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,100})));
    equation
      port_a.p = port_b.p;

      inStream(port_a.h_outflow) = port_b.h_outflow;
      inStream(port_b.h_outflow) = port_a.h_outflow;
      annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>This sensor base class defines a fluid model which does not affect the fluid properties. The signal output can be used to generate a signal of the measured value.</p>
</html>",
        revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end PartialSensor;

  end BaseClasses;
end Sensors;
