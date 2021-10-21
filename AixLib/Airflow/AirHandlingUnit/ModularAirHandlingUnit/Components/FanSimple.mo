within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model FanSimple "model of a simple fan"

  // parameters
  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.SIunits.Density rho_air = 1.2 "density of air";
  parameter Real eta = 0.7 "efficiency of fan";

  // constants
  constant Modelica.SIunits.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  // variables
  Modelica.SIunits.Power P_el "electrical power of fan";
  Modelica.SIunits.HeatFlowRate Q_flow "heat flow rate added to air flow";
  Modelica.SIunits.SpecificEnthalpy h_airIn "specific enthalpy of incoming air";
  Modelica.SIunits.SpecificEnthalpy h_airOut "specific enthalpy of outgoing air";

  // objects
  Modelica.Blocks.Interfaces.RealInput m_flow_airIn(final quantity="MassFlowRate",
      final unit="kg/s")
    "mass flow rate of incoming air"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airIn(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Temperature of incoming air"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airIn(final quantity="MassFraction",
      final unit="kg/kg")
    "absolute humidity of incoming air"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOut(final quantity="MassFlowRate",
      final unit="kg/s") "mass flow rate of outgoing air"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of outgoing air"
    annotation (Placement(transformation(extent={{100,40},{120,60}}),
        iconTransformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOut(final quantity="MassFraction",
      final unit="kg/kg") "absolute humidity of outgoing air"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
        iconTransformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealInput dpIn "Prescribed pressure rise"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,110})));
  Modelica.Blocks.Interfaces.RealOutput PelFan(final quantity="Power",
      final unit="W") "electrical power of fan" annotation (Placement(
        transformation(extent={{100,-90},{120,-70}}), iconTransformation(extent={{100,-90},
            {120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput dT_fan(
    final quantity="ThermodynamicTemperatureDifference",
    final unit="K") "temperature increase over fan" annotation (Placement(
        transformation(extent={{100,-50},{120,-30}}), iconTransformation(extent={{100,-60},
            {120,-40}})));
equation
  // mass balance
  m_flow_airIn - m_flow_airOut = 0;
  X_airIn = X_airOut;

  // Power of fan
  P_el = m_flow_airIn/rho_air * dpIn / eta;
  PelFan = P_el;

  // heat added to air
  Q_flow = P_el;

  // energy balance
  Q_flow = m_flow_airOut * h_airOut - m_flow_airIn * h_airIn;

  // specific enthalpies
  h_airIn = cp_air * (T_airIn - 273.15) + X_airIn * (cp_steam * (T_airIn - 273.15) + r0);
  h_airOut = cp_air * (T_airOut - 273.15) + X_airOut * (cp_steam * (T_airOut - 273.15) + r0);

  // temperature increase
  dT_fan = T_airOut - T_airIn;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-50,62},{78,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-48,-64},{78,-20}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FanSimple;
