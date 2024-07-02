within AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses;
partial model BaseThermalZone "Base model for thermal zone models"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter DataBase.ThermalZones.ZoneBaseRecord zoneParam
    "Choose setup for this zone" annotation (choicesAllMatching=true);
  parameter Integer nPorts=0
    "Number of fluid ports"
    annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));
  parameter Boolean use_C_flow=false
    "Set to true to enable input connector for trace substance"
    annotation (Dialog(tab="CO2"));
  parameter Boolean use_moisture_balance=false
    "If true, input connector QLat_flow is enabled and room air computes moisture balance"
    annotation (Dialog(tab="Moisture"));
  Modelica.Blocks.Interfaces.RealInput intGains[3]
    "Input profiles for internal gains persons, machines, light"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={80,-100}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={80,-84})));

  Modelica.Blocks.Interfaces.RealOutput TAir(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ATot > 0 or zoneParam.VAir > 0
    "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,70},{120,90}}),
        iconTransformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput TRad(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ATot > 0
    "Mean indoor radiation temperature"
    annotation (Placement(transformation(
          extent={{100,50},{120,70}}), iconTransformation(extent={{100,50},{120,
            70}})));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-117,18},{-83,50}}), iconTransformation(
    extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
    redeclare each final package Medium = Medium)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{-49,-108},{49,-84}}),
        iconTransformation(extent={{-47,-84},{47,-60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv
 if ATot > 0 or zoneParam.VAir > 0
    "Convective internal gains"
    annotation (Placement(transformation(extent={{94,10},{114,30}}),
                              iconTransformation(extent={{92,-6},{112,14}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad if ATot > 0
    "Radiative internal gains"
    annotation (Placement(transformation(extent={{94,30},{114,50}}),
                            iconTransformation(extent={{92,24},{112,44}})));

protected
  parameter Real ATot = (sum(zoneParam.AExt) + sum(zoneParam.AWin) +
  zoneParam.AInt + zoneParam.ARoof+zoneParam.AFloor);

equation
  connect(TRad, TRad)
    annotation (Line(points={{110,60},{110,60}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,  extent={{-100,-100},
            {100,100}}),graphics={Text(extent={{
              -80,114},{92,64}},lineColor=
              {0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-100,-72},{100,70}},
          lineColor={95,95,95},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,32},{-18,-26}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,32},{-10,38}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{18,32},{68,-26}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,32},{76,38}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
          Documentation(info="<html><p>
  Partial for <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  models. It defines connectors and a <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>
  model. Most connectors are conditional to allow conditional
  modifications according to parameters or to pass-through conditional
  removements in <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  All parameters are collected in one <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  record. Further parameters for medium, initialization and dynamics
  originate from <a href=
  \"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
</p>
<ul>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation based on Annex60 and MSL models.
  </li>
  <li>March, 2012, by Moritz Lauster:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
  Rectangle(
    extent={{32,100},{90,52}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid)}));
end BaseThermalZone;
