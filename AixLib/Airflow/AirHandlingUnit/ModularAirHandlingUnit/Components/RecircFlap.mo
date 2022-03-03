within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model RecircFlap "model for recirculating flap"

  // parameters
  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.SIunits.Density rho_air = 1.2 "Density of air";
  parameter Boolean exponential = false "= true for exponential opening of flap";

  // variables
  Modelica.SIunits.SpecificHeatCapacity cp_airInOda "specific heat capacity of incoming outdoor air";
  Modelica.SIunits.SpecificHeatCapacity cp_airInEta "specific heat capacity of incoming exhaust air";

  Real splitFactor "factor that describes portion of exhaust air, that is mixed into the outdoor air";

  replaceable model PartialPressureDrop =
      Components.PressureDrop.BaseClasses.partialPressureDrop annotation(choicesAllMatching=true);

      PartialPressureDrop partialPressureDrop(m_flow = m_flow_airInOda,
      rho = rho_air);

      PartialPressureDrop partialPressureDrop2(m_flow = m_flow_airInEta,
      rho = rho_air);

  Modelica.Blocks.Interfaces.RealInput flapPosition "position of recirculating flap" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-100})));
  Modelica.Blocks.Interfaces.RealInput m_flow_airInEta(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,60},{100,100}}),
        iconTransformation(extent={{120,70},{100,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airInEta(
    final quantity = "ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC")
    "mass flow rate of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,30},{100,70}}),
        iconTransformation(extent={{120,40},{100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airInEta(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "mass flow rate of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,0},{100,40}}),
        iconTransformation(extent={{120,10},{100,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutEta(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutEta(
    final quantity = "ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC")
    "temperature of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,42},{-120,62}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutEta(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,10},{-120,30}})));
 Modelica.Blocks.Interfaces.RealInput m_flow_airInOda(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of incoming outdoor air" annotation (Placement(
        transformation(extent={{-140,-100},{-100,-60}}), iconTransformation(
          extent={{-120,-90},{-100,-70}})));
  Modelica.Blocks.Interfaces.RealInput T_airInOda(
    final quantity = "ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC")
    "Temperature of incoming outdoor air" annotation (Placement(transformation(
          extent={{-140,-70},{-100,-30}}), iconTransformation(extent={{-120,-60},
            {-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput X_airInOda(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of incoming outdoor air" annotation (Placement(
        transformation(extent={{-140,-40},{-100,0}}), iconTransformation(extent=
           {{-120,-30},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutOda(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of outgoing mixed air"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutOda(
    final quantity = "ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC")
    "temperature of outgoing mixed air" annotation (Placement(transformation(extent={{100,-60},
            {120,-40}}),        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutOda(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of outgoing mixed air" annotation (Placement(transformation(
          extent={{100,-30},{120,-10}}),
                                       iconTransformation(extent={{100,-30},{
            120,-10}})));

  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  //mass balances
  m_flow_airInOda + m_flow_airInEta * splitFactor - m_flow_airOutOda = 0;
  m_flow_airInEta * (1 - splitFactor) - m_flow_airOutEta = 0;

  //mass balance moisture
   X_airInEta = X_airOutEta;
   X_airOutOda = (m_flow_airInOda * X_airInOda + m_flow_airInEta * X_airInEta * splitFactor) / m_flow_airOutOda;

   //energy balance
   T_airInEta = T_airOutEta;
   T_airOutOda = (m_flow_airInOda * cp_airInOda * T_airInOda + m_flow_airInEta * cp_airInEta * T_airInEta * splitFactor) / (m_flow_airInOda * cp_airInOda + m_flow_airInEta * cp_airInEta * splitFactor);

   //specific heat capacities
   cp_airInOda = cp_steam * X_airInOda + cp_air * (1 - X_airInOda);
   cp_airInEta = cp_steam * X_airInEta + cp_air * (1 - X_airInEta);

   //splitFactor
   if exponential == true then
     splitFactor = 1 - exp(flapPosition); // ToDo: add realistic function!!!
   else
     splitFactor = flapPosition;
   end if;

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
