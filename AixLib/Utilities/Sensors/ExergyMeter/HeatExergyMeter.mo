within AixLib.Utilities.Sensors.ExergyMeter;
model HeatExergyMeter

    extends Modelica.Icons.RotationalSensor;

  parameter Boolean useConvectiveHeatFlow = true
    "Set to 'true' in order to connect the meter to a convective heat port";
  parameter Boolean useRadiativeHeatFlow = false
    "Set to 'true' in order to connect the meter to a radiative heat port";
  parameter Boolean solarRadiation = false
    "Set to 'true' in order to connect the meter to a solar radiation port" annotation(Dialog(enable = if useRadiativeHeatFlow then true else false));
  parameter Modelica.SIunits.ThermodynamicTemperature sunTemperature = 6000
    "Temperature assumption for the solar radiation";
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-12,0},{0,12}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=400, uMin=1)
    annotation (Placement(transformation(extent={{-66,-56},{-54,-44}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a if useConvectiveHeatFlow
    annotation (Placement(transformation(extent={{-110,82},{-90,102}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b if useConvectiveHeatFlow
    annotation (Placement(transformation(extent={{90,82},{110,102}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor if useConvectiveHeatFlow
    annotation (Placement(transformation(extent={{-10,82},{10,102}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor if useConvectiveHeatFlow
    annotation (Placement(transformation(extent={{-94,58},{-74,78}})));
  AixLib.HVAC.Interfaces.RadPort radPort_a if
                                            useRadiativeHeatFlow
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  AixLib.HVAC.Interfaces.RadPort radPort_b if
                                             useRadiativeHeatFlow
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor1 if useRadiativeHeatFlow
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={0,-74})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1 if
                                                                               useRadiativeHeatFlow
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
public
  Modelica.Blocks.Interfaces.RealInput T_ref(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature",
    min=0) "Reference temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput exergy_flow(final quantity="Power",
      final unit="W") "Exergy content of the medium flow"
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
equation
  connect(const.y, add.u1) annotation (Line(
      points={{0.6,6},{18,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(division.y, add.u2) annotation (Line(
      points={{1,-30},{6,-30},{6,-6},{18,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, product.u2) annotation (Line(
      points={{41,0},{52,0},{52,24},{58,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(limiter.y, division.u2) annotation (Line(
      points={{-53.4,-50},{-40,-50},{-40,-36},{-22,-36}},
      color={0,0,127},
      smooth=Smooth.None));

   if useConvectiveHeatFlow then
     connect(temperatureSensor.T, limiter.u);
     connect(heatFlowSensor.Q_flow, product.u1);
     connect(port_a, heatFlowSensor.port_a);
     connect(heatFlowSensor.port_b, port_b);
     connect(port_a, temperatureSensor.port);

   end if;

   if useRadiativeHeatFlow then

     if solarRadiation then
       limiter.u = sunTemperature;
     else
       connect(temperatureSensor1.T, limiter.u);
     end if;

    connect(heatFlowSensor1.Q_flow, product.u1);
    connect(temperatureSensor1.port, radPort_a);
    connect(heatFlowSensor1.port_a, radPort_a);
    connect(heatFlowSensor1.port_b, radPort_b);
   end if;

  connect(T_ref, division.u1) annotation (Line(points={{-100,0},{-40,0},{-40,-24},
          {-22,-24}}, color={0,0,127}));
  connect(product.y, exergy_flow) annotation (Line(points={{81,30},{86,30},{86,-92},
          {20,-92},{0,-92},{0,-110}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),                Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The model calculates the exergy flow rate of a radiaitive or convective heat flux. The reference environment (subscript </span><img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-cS0ZTQMt.png\" alt=\"_ref\"/><span style=\"font-family: MS Shell Dlg 2;\">) is variable. The basic equation is</span></p>
<p><img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-CrfkEVcN.png\" alt=\"dE/dt=dQ/dt*(1-T_ref/T)\"/></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">with </span><img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-yPjky8qR.png\" alt=\"dE/dt\"/><span style=\"font-family: MS Shell Dlg 2;\">: exergy flow rate, </span><img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-MqENWR2W.png\" alt=\"dQ/dt\"/><span style=\"font-family: MS Shell Dlg 2;\">: heat flow rate, </span><img src=\"modelica://ExergyBasedControl/Resources/Images/equations/equation-XHmUQrbT.png\" alt=\"T\"/><span style=\"font-family: MS Shell Dlg 2;\">: temperature</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Level of Development</span></b> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\"><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\"/></span></p>
</html>", revisions="<html>
<ul>
<li><i><span style=\"font-family: Arial,sans-serif;\">November 10, 2016&nbsp;</i> by Marc Baranski and Roozbeh Sangi:<br>Implemented.</span></li>
</ul>
</html>"));
end HeatExergyMeter;
