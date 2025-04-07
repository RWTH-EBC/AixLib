within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses;
partial model PartialComponent
  "BaseClass for components in air handling units with one air flow"

  // parameters
  parameter Modelica.Units.SI.SpecificHeatCapacity cpAir = 1006
    "specific heat capacity of dry air"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.SpecificHeatCapacity cpSteam = 1860
    "specific heat capacity of steam"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.Density rhoAir=1.2
    "Density of air"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal = 0.01
    "nominal mass flow rate"
    annotation(Dialog(group="Nominal conditions"));
  parameter Modelica.Units.SI.PressureDifference dp_nominal(displayUnit="Pa")=1
    "pressure drop at nominal mass flow rate"
    annotation(Dialog(group="Nominal conditions"));

  // Variables
  Modelica.Units.SI.SpecificEnthalpy hAirIn
    "specific enthalpy of incoming air";
  Modelica.Units.SI.SpecificEnthalpy hAirOut
    "specific enthalpy of outgoing air";

  Modelica.Blocks.Interfaces.RealInput mAirIn_flow(final quantity="MassFlowRate",
      final unit="kg/s") "mass flow rate of incoming air" annotation (Placement(
        transformation(extent={{-140,50},{-100,90}}), iconTransformation(extent=
           {{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput TAirIn(
    final start=283.15,
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "Temperature of incoming air" annotation (Placement(
        transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent=
           {{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput XAirIn(final quantity="MassFraction",
      final unit="kg/kg") "absolute humidity of incoming air" annotation (
      Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealOutput mAirOut_flow(final quantity="MassFlowRate",
      final unit="kg/s") "mass flow rate of outgoing air"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput TAirOut(
    final start=283.15,
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of outgoing air" annotation (Placement(
        transformation(extent={{100,40},{120,60}}), iconTransformation(extent={{
            100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput XAirOut(final quantity="MassFraction",
      final unit="kg/kg") "absolute humidity of outgoing air" annotation (
      Placement(transformation(extent={{100,10},{120,30}}), iconTransformation(
          extent={{100,10},{120,30}})));

  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));

  // constants
protected
  constant Modelica.Units.SI.SpecificEnthalpy r0 = 2500E3
    "specific heat of vaporization at 0°C";

  Modelica.Units.SI.MassFlowRate mDryAirIn_flow
    "mass flow rate of incoming dry air";
  Modelica.Units.SI.MassFlowRate mDryAirOut_flow
    "mass flow rate of outgoing dry air";
equation

  // specific enthalpies
   hAirIn = cpAir * (TAirIn - 273.15) + XAirIn *
     (cpSteam * (TAirIn - 273.15) + r0);
   hAirOut =cpAir * (TAirOut - 273.15) + XAirOut *
     (cpSteam * (TAirOut - 273.15) + r0);
  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,94},{100,-94}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-14,66},{62,48}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Documentation(info="<html><p>
  This partial model provides a idealized heat exchanger. The model
  considers the convective heat transfer from the heat transfer surface
  in the air stream. Moreover the heat capacity of the heating surface
  and the housing of the heat exchanger is considered.
</p>
</html>", revisions="<html>
<ul>
  <li>April, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
  <li>August, 2019, by Martin Kremer:<br/>
    Added possibility to use set temperature.
  </li>
  <li>December, 2019, by Martin Kremer:<br/>
    Removed internal PID. Output temperature is now directly set to set
    temperature.
  </li>
</ul>
</html>"));
end PartialComponent;
