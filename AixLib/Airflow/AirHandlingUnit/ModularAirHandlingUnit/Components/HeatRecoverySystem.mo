within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model HeatRecoverySystem

  parameter Modelica.Units.SI.SpecificHeatCapacity cpAir = 1005
    "specific heat capacity of dry air"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cpSteam = 1860
    "specific heat capacity of steam"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.Density rhoAir = 1.2
    "Density of air"
    annotation(Dialog(tab="Advanced"));
  parameter Real effOn = 0.85
    "efficiency of the heat recovery system (0...1) if it is used";
  parameter Real effOff = 0.1
    "efficiency of the heat recovery system (0...1) if it is bypassed";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "nominal mass flow rate"
    annotation(Dialog(group="Nominal conditions"));
  parameter Modelica.Units.SI.PressureDifference dp_nominal
    "pressure drop at nominal mass flow rate"
    annotation(Dialog(group="Nominal conditions"));

  Modelica.Units.SI.MassFlowRate mDryAirInOda_flow
    "mass flow rate of incoming dry outdoor air";
  Modelica.Units.SI.MassFlowRate mDryAirInEta_flow
    "mass flow rate of incoming dry exhaust air";

  Modelica.Units.SI.MassFlowRate mDryAirOutOda_flow
    "mass flow rate of outgoing dry outdoor air";
  Modelica.Units.SI.MassFlowRate mDryAirOutEta_flow
    "mass flow rate of outgoing dry exhaust air";

  Modelica.Units.SI.SpecificEnthalpy hAirInOda
    "specific enthalpy of incoming outdoor air";
  Modelica.Units.SI.SpecificEnthalpy hAirOutOda
    "specific enthalpy of outgoing outdoor air";

  Modelica.Units.SI.SpecificEnthalpy hAirInEta
    "specific enthalpy of incoming exhaust air";
  Modelica.Units.SI.SpecificEnthalpy hAirOutEta
    "specific enthalpy of outgoing exhaust air";

  Modelica.Units.SI.Temperature TAirOutOdaMax
    "maximum temperature of outdoor air outlet if HRS is used";
  Modelica.Units.SI.Temperature TAirOutOdaMin
    "minimum temperature of outdoor air outlet if HRS is bypassed";

  Modelica.Units.SI.HeatFlowRate Q_flow "heat flow";

  replaceable model PartialPressureDrop =
    Components.PressureDrop.BaseClasses.partialPressureDrop
    annotation(choicesAllMatching=true);

  PartialPressureDrop partialPressureDrop(
    final m_flow=mAirInOda_flow,
    final rho=rhoAir,
    final m_flow_nominal=m_flow_nominal,
    final dp_nominal=dp_nominal);

  PartialPressureDrop partialPressureDrop2(
    final m_flow=mAirInEta_flow,
    final rho=rhoAir,
    final m_flow_nominal=m_flow_nominal,
    final dp_nominal=dp_nominal);

  Modelica.Blocks.Interfaces.RealInput mAirInEta_flow(
    final quantity="MassFlowRate",
    final unit="kg/s")
    "mass flow rate of incoming exhaust air"
    annotation (
      Placement(transformation(extent={{140,60},{100,100}}), iconTransformation(
          extent={{120,70},{100,90}})));
  Modelica.Blocks.Interfaces.RealInput TAirInEta(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of incoming exhaust air"
    annotation (
      Placement(transformation(extent={{140,30},{100,70}}), iconTransformation(
          extent={{120,40},{100,60}})));
  Modelica.Blocks.Interfaces.RealInput XAirInEta(
    final quantity="MassFraction",
    final unit="kg/kg")
    "absolute humidity of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,0},{100,40}}),
        iconTransformation(extent={{120,10},{100,30}})));
  Modelica.Blocks.Interfaces.RealInput mAirInOda_flow(
    final quantity="MassFlowRate",
    final unit="kg/s")
    "mass flow rate of incoming outdoor air"
    annotation (
      Placement(transformation(extent={{-140,50},{-100,90}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput TAirInOda(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of incoming otudoor air"
    annotation (
      Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput XAirInOda(
    final quantity="MassFraction",
    final unit="kg/kg")
    "absolute humidity of incoming outdoor air"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealOutput mAirOutEta_flow(
    final quantity="MassFlowRate",
    final unit="kg/s")
    "mass flow rate of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,-30},{-120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput TAirOutEta(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,-60},{-120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput XAirOutEta(
    final quantity="MassFraction",
    final unit="kg/kg")
    "absolute humidity of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput mAirOutOda_flow(
    final quantity="MassFlowRate",
    final unit="kg/s")
    "mass flow rate of outgoing outdoor air"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput TAirOutOda(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of outgoing outdoor air"
    annotation (
      Placement(transformation(extent={{100,-60},{120,-40}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput XAirOutOda(
    final quantity="MassFraction",
    final unit="kg/kg")
    "absolute humidity of outgoing outdoor air"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}}),
        iconTransformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealInput bypOpe
    "bypass opening (1: fully opened, 0: fully closed)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));

  Modelica.Blocks.Interfaces.RealOutput dpOda
    "pressure difference of outdoor air side"
    annotation (Placement(transformation(extent={{100,-112},{120,-92}})));
  Modelica.Blocks.Interfaces.RealOutput dpEta
    "pressure difference of exhaust air side"
    annotation (Placement(transformation(extent={{-100,-110},{-120,-90}})));
protected
  constant Modelica.Units.SI.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-26,42},{-6,22}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{12,32},{32,52}})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{50,8},{70,28}})));

  Modelica.Blocks.Sources.RealExpression TOutMax(y=TAirOutOdaMax)
    annotation (Placement(transformation(extent={{-60,4},{-48,20}})));
  Modelica.Blocks.Sources.RealExpression TOutMin(y=TAirOutOdaMin)
    annotation (Placement(transformation(extent={{-56,42},{-44,58}})));
equation

  //mass balances
  mAirInOda_flow - mAirOutOda_flow = 0;
  mAirInEta_flow - mAirOutEta_flow = 0;

  mDryAirInOda_flow*(1 + XAirInOda) = mAirInOda_flow;
  mDryAirInEta_flow*(1 + XAirInEta) = mAirInEta_flow;

  mDryAirOutOda_flow*(1 + XAirOutOda) = mAirOutOda_flow;
  mDryAirOutEta_flow*(1 + XAirOutEta) = mAirOutEta_flow;

  // mass balance moisture
  XAirInOda = XAirOutOda;
  XAirInEta = XAirOutEta;

  // sepcific enthalpies
  hAirInOda =cpAir*(TAirInOda - 273.15) + XAirInOda*(cpSteam*(TAirInOda - 273.15)
     + r0);
  hAirOutOda =cpAir*(TAirOutOda - 273.15) + XAirOutOda*(cpSteam*(TAirOutOda -
    273.15) + r0);

  hAirInEta =cpAir*(TAirInEta - 273.15) + XAirInEta*(cpSteam*(TAirInEta - 273.15)
     + r0);
  hAirOutEta =cpAir*(TAirOutEta - 273.15) + XAirOutEta*(cpSteam*(TAirOutEta -
    273.15) + r0);

  TAirOutOdaMax =effOn*(TAirInEta - TAirInOda) + TAirInOda;
  TAirOutOdaMin =effOff*(TAirInEta - TAirInOda) + TAirInOda;

  Q_flow = (mDryAirInEta_flow * hAirInEta - mDryAirOutEta_flow * hAirOutEta);
  Q_flow = -(mDryAirInOda_flow * hAirInOda - mDryAirOutOda_flow * hAirOutOda);

  partialPressureDrop.dp = dpOda;
  partialPressureDrop2.dp = dpEta;

  connect(TOutMax.y, add.u1) annotation (Line(points={{-47.4,12},{-36,12},{-36,
          26},{-28,26}},
                     color={0,0,127}));
  connect(TOutMin.y, add.u2) annotation (Line(points={{-43.4,50},{-36,50},{-36,
          38},{-28,38}},
                     color={0,0,127}));
  connect(add.y, product1.u2)
    annotation (Line(points={{-5,32},{2,32},{2,36},{10,36}}, color={0,0,127}));
  connect(bypOpe, product1.u1)
    annotation (Line(points={{0,120},{0,48},{10,48}}, color={0,0,127}));
  connect(product1.y, add1.u1) annotation (Line(points={{33,42},{42,42},{42,24},
          {48,24}}, color={0,0,127}));
  connect(add1.y, TAirOutOda) annotation (Line(points={{71,18},{82,18},{82,-50},
          {110,-50}}, color={0,0,127}));
  connect(TOutMax.y, add1.u2)
    annotation (Line(points={{-47.4,12},{48,12}}, color={0,0,127}));
      annotation (
    preferredView="info",
    Documentation(info="<html><p>
  This model describes two streams of moist air where the exit
  temperature is calculated over a user set parameter.
</p>
<p>
  If the maximum possible temperature at the outlet overshoots the set
  temperature for the supply air, it will be reduced to the set
  temperature for heating case. In summer it will be vice versa.
</p>
<h4>
  Main equations
</h4>The temperature of the outgoing outdoor air is defined as:
<p style=\"text-align:center;\">
  <i>T<sub>airOutOda</sub> = ε * (T<sub>airInEta</sub> -
  T<sub>airInOda</sub>) + T<sub>airInOda</sub></i>
</p>
<h4>
  Implementation
</h4>
<p>
  This model uses inputs that need to be set by models that extend or
  instantiate this model. The following inputs need to be assigned:
</p>
<ul>
  <li>
    <i>ε</i>, parameter to calculate exit temperature.
  </li>
</ul>
</html>", revisions="<html>
<ul>
  <li>May 2019, by Ervin Lejlic:<br/>
    First implementation.
  </li>
  <li>May 2019, by Martin Kremer:<br/>
    Changed variable names for naming convention.
  </li>
  <li>August 2019, by Martin Kremer:<br/>
    Added limitation for temperature at outdoor outlet.
  </li>
  <li>April 2020, by Martin Kremer:<br/>
    Added efficiency for bypassed HRS. Changed limitation of
    temperature at outdoor outlet.
  </li>
</ul>
</html>"),                  Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-100,94},{100,-94}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-100,94},{100,-94}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{98,94},{-100,-92}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{100,92},{-98,-94}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-14,12},{14,-14}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-58,86},{54,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatRecoverySystem;
