within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model RecircFlap "model for recirculating flap"

  // parameters
  parameter Modelica.Units.SI.SpecificHeatCapacity cpAir = 1005
    "specific heat capacity of dry air"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cpSteam = 1860
    "specific heat capacity of steam"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.Density rhoAir = 1.2
    "Density of air"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "nominal mass flow rate"
    annotation(Dialog(group="Nominal conditions"));
  parameter Modelica.Units.SI.PressureDifference dp_nominal
    "pressure drop at nominal mass flow rate"
    annotation(Dialog(group="Nominal conditions"));

  replaceable model PartialPressureDrop =
      Components.PressureDrop.BaseClasses.partialPressureDrop annotation(choicesAllMatching=true);

  PartialPressureDrop partialPressureDrop(
    final m_flow=mAirInOda_flow,
    final rho=rhoAir,
    final m_flow_nominal = m_flow_nominal,
    final dp_nominal = dp_nominal);

  PartialPressureDrop partialPressureDrop2(
    final m_flow=mAirInEta_flow,
    final rho=rhoAir,
    final m_flow_nominal = m_flow_nominal,
    final dp_nominal = dp_nominal);

  Modelica.Blocks.Interfaces.RealInput flapPos "position of recirculating flap"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-100})));
  Modelica.Blocks.Interfaces.RealInput mAirInEta_flow(final quantity="MassFlowRate",
      final unit="kg/s") "mass flow rate of incoming exhaust air" annotation (
      Placement(transformation(extent={{140,60},{100,100}}), iconTransformation(
          extent={{120,70},{100,90}})));
  Modelica.Blocks.Interfaces.RealInput TAirInEta(
    start=293.15,
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "mass flow rate of incoming exhaust air" annotation (
      Placement(transformation(extent={{140,30},{100,70}}), iconTransformation(
          extent={{120,40},{100,60}})));
  Modelica.Blocks.Interfaces.RealInput XAirInEta(final quantity="MassFraction",
      final unit="kg/kg") "mass flow rate of incoming exhaust air" annotation (
      Placement(transformation(extent={{140,0},{100,40}}), iconTransformation(
          extent={{120,10},{100,30}})));
  Modelica.Blocks.Interfaces.RealOutput mAirOutEta_flow(final quantity="MassFlowRate",
      final unit="kg/s") "mass flow rate of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Interfaces.RealOutput TAirOutEta(
    start=293.15,
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,42},{-120,62}})));
  Modelica.Blocks.Interfaces.RealOutput XAirOutEta(final quantity="MassFraction",
      final unit="kg/kg") "absolute humidity of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,10},{-120,30}})));
 Modelica.Blocks.Interfaces.RealInput mAirInOda_flow(final quantity="MassFlowRate",
      final unit="kg/s") "mass flow rate of incoming outdoor air" annotation (
      Placement(transformation(extent={{-140,-100},{-100,-60}}),
        iconTransformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Blocks.Interfaces.RealInput TAirInOda(
    start=293.15,
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Temperature of incoming outdoor air" annotation (
      Placement(transformation(extent={{-140,-70},{-100,-30}}),
        iconTransformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput XAirInOda(final quantity="MassFraction",
      final unit="kg/kg") "absolute humidity of incoming outdoor air"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}}),
        iconTransformation(extent={{-120,-30},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealOutput mAirOutOda_flow(final quantity="MassFlowRate",
      final unit="kg/s") "mass flow rate of outgoing mixed air"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput TAirOutOda(
    start=293.15,
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of outgoing mixed air" annotation (
      Placement(transformation(extent={{100,-60},{120,-40}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput XAirOutOda(final quantity="MassFraction",
      final unit="kg/kg") "absolute humidity of outgoing mixed air" annotation (
     Placement(transformation(extent={{100,-30},{120,-10}}), iconTransformation(
          extent={{100,-30},{120,-10}})));

  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  // variables
protected
  Modelica.Units.SI.SpecificHeatCapacity cpAirInOda
    "specific heat capacity of incoming outdoor air";
  Modelica.Units.SI.SpecificHeatCapacity cpAirInEta
    "specific heat capacity of incoming exhaust air";

  Real splitFactor
    "factor that describes portion of exhaust air, that is mixed into the outdoor air";
equation

  //mass balances
  mAirInOda_flow + mAirInEta_flow * splitFactor - mAirOutOda_flow = 0;
  mAirInEta_flow * (1 - splitFactor) - mAirOutEta_flow = 0;

  //mass balance moisture
  XAirInEta = XAirOutEta;
  XAirOutOda = (mAirInOda_flow * XAirInOda
    + mAirInEta_flow * XAirInEta * splitFactor) / mAirOutOda_flow;

   //energy balance
  TAirInEta = TAirOutEta;
  TAirOutOda = (mAirInOda_flow * cpAirInOda * TAirInOda
    + mAirInEta_flow * cpAirInEta * TAirInEta * splitFactor)
    /(mAirInOda_flow * cpAirInOda + mAirInEta_flow * cpAirInEta * splitFactor);

   //specific heat capacities
   cpAirInOda =cpSteam*XAirInOda + cpAir*(1 - XAirInOda);
   cpAirInEta =cpSteam*XAirInEta + cpAir*(1 - XAirInEta);

   //splitFactor
   splitFactor =flapPos;

   partialPressureDrop.dp + partialPressureDrop2.dp = dp;

annotation (
    preferredView="info",
    Documentation(info="<html><p>
  This model describes an idealized model for a recirculation flap.
  Depending on the flap position the outdoor air is mixed with the
  exhaust air.
</p>
<p>
  The flap position can be set by the input parameter
  <code>flapPosition</code> where 0 means the flap is fully closed and
  1 means fully open.
</p>
<p>
  The mixture of the streams is calculated using the Richmann's mixing
  rule.
</p>
<p style=\"text-align:center;\">
  <i>T<sub>OdaOut</sub>=(ṁ<sub>OdaIn</sub> · c<sub>p,OdaIn</sub> ·
  T<sub>OdaIn</sub>+ ṁ<sub>EtaRecirc</sub> · c<sub>p,EtaIn</sub> ·
  T<sub>EtaIn</sub>) ⁄ (ṁ<sub>OdaIn</sub> · c<sub>p,OdaIn</sub> +
  ṁ<sub>EtaRecirc</sub> · c<sub>p,EtaIn</sub>)</i>
</p>
<p style=\"text-align:center;\">
  <i>X<sub>OdaOut</sub>=(ṁ<sub>OdaIn</sub> · X<sub>OdaIn</sub>+
  ṁ<sub>EtaRecirc</sub> · X<sub>EtaIn</sub>) ⁄ (ṁ<sub>OdaIn</sub> +
  ṁ<sub>EtaRecirc</sub>)</i>
</p>
<p>
  The recirculating mass flow rate of the exhaust air is calculated
  using a parameter <code>splitFactor</code>. The
  <code>splitFactor</code> is calculated by the
  <code>flapPosition</code> depending on the calculation mode. By
  default the relation between these is linear.
</p>
<p style=\"text-align:center;\">
  <i>ṁ<sub>EtaRecirc</sub>=ṁ<sub>EtaIn</sub> · splitFactor</i>
</p>
</html>", revisions="<html>
<ul>
  <li>May 2019, by Ervin Lejlic:<br/>
    First implementation.
  </li>
  <li>May 2019, by Martin Kremer:<br/>
    Changing variable names. Adding possibility for other relation
    between flap position and volume flow through flap than linear.
  </li>
</ul>
</html>"),                  Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          pattern=LinePattern.Dash,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,0},{-54,0},{-80,20},{-30,4}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-68,78},{-68,-8}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{-8,0},{-42,-16},{-42,-28},{-26,-30},{-24,-24},{-22,
              -8},{-40,16},{-64,42},{-70,46},{-74,50},{-74,54}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-100,0},{-40,0}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{40,0},{100,0}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-32,12},{-6,-14}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{6,14},{32,-12}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{-22,2},{-18,-2}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{18,2},{22,-2}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,100},{100,100}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-100,-100},{100,-100}},
          color={0,0,0},
          thickness=0.5)}),                                                    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RecircFlap;
