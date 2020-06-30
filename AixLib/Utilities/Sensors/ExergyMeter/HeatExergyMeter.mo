within AixLib.Utilities.Sensors.ExergyMeter;
model HeatExergyMeter

  extends Modelica.Icons.RotationalSensor;

  parameter Boolean useConvectiveHeatFlow=true
    "Set to 'true' in order to connect the meter to a convective heat port";
  parameter Boolean useRadiativeHeatFlow=false
    "Set to 'true' in order to connect the meter to a radiative heat port";
  parameter Boolean solarRadiation=false
    "Set to 'true' in order to connect the meter to a solar radiation port"
    annotation (Dialog(enable=if useRadiativeHeatFlow then true else false));
  parameter Modelica.SIunits.ThermodynamicTemperature sunTemperature=6000
    "Temperature assumption for the solar radiation";
  Modelica.Blocks.Math.Add add(k2=-1) "Subtract the temperature ratio from one"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant const(k=1) "Constant one in Carnot factor"
    annotation (Placement(transformation(extent={{-12,0},{0,12}})));
  Modelica.Blocks.Math.Division division
    "Ratio of reference temperature and temperature"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.Product product
    "Product of heat flow rate and Carnot factor"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=400, uMin=1)
    "Limits the temperature of the heat flux"
    annotation (Placement(transformation(extent={{-66,-56},{-54,-44}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a if
     useConvectiveHeatFlow
    "Entering convective heat"
    annotation (Placement(transformation(extent={{-110,82},{-90,102}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b if
     useConvectiveHeatFlow
    "Outgoing convective heat"
    annotation (Placement(transformation(extent={{90,82},{110,102}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor if
     useConvectiveHeatFlow
    "Heat flow sensor used for convective heat"
    annotation (Placement(transformation(extent={{-10,82},{10,102}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensorConv if
     useConvectiveHeatFlow
    "Temperature sensor for convective heat"
    annotation (Placement(transformation(extent={{-94,58},{-74,78}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a radPort_a if
     useRadiativeHeatFlow
    "Entering radiation"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b radPort_b if
     useRadiativeHeatFlow
    "Outgoing radiation"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorRad if
     useRadiativeHeatFlow "Heat flow sensor used for radiative heat"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={0,-74})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensorRad if
     useRadiativeHeatFlow
    "Temperature sensor for radiative heat"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));

  Modelica.Blocks.Interfaces.RealInput T_ref(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature",
    min=0) "Reference temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput exergyFlow(final quantity="Power",
      final unit="W") "Exergy content of the heat flux" annotation (Placement(
        transformation(
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
    connect(temperatureSensorConv.T, limiter.u);
    connect(heatFlowSensor.Q_flow, product.u1);
    connect(port_a, heatFlowSensor.port_a);
    connect(heatFlowSensor.port_b, port_b);
    connect(port_a, temperatureSensorConv.port);

  end if;

  if useRadiativeHeatFlow then

    if solarRadiation then
      limiter.u = sunTemperature;
    else
      connect(temperatureSensorRad.T, limiter.u);
    end if;

    connect(heatFlowSensorRad.Q_flow, product.u1);
    connect(temperatureSensorRad.port, radPort_a);
    connect(heatFlowSensorRad.port_a, radPort_a);
    connect(heatFlowSensorRad.port_b, radPort_b);
  end if;

  connect(T_ref, division.u1) annotation (Line(points={{-100,0},{-40,0},{-40,-24},
          {-22,-24}}, color={0,0,127}));
  connect(product.y, exergyFlow) annotation (Line(points={{81,30},{86,30},{86,-92},
          {20,-92},{0,-92},{0,-110}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={
    {-100,-100},{100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={
    {-100,-100},{100,100}})),
    Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>The model calculates the exergy flow rate of a radiaitive or convective heat
flux. The reference environment is variable.</p>
</html>
",        revisions="<html>
 <ul>
 <li>by Marc Baranski and Roozbeh Sangi:<br/>implemented</li>
 </ul>
</html>"));
end HeatExergyMeter;
