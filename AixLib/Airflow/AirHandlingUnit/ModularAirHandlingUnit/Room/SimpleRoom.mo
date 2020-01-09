within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Room;
model SimpleRoom
  "very simple model of room delivering temperature and humidity increase"

  parameter Modelica.SIunits.Area A_room = 980 "room area";
  parameter Modelica.SIunits.Volume V_room = 2940 "room volume";

  Modelica.SIunits.HeatFlowRate Q_flow "internal heat gain";
  Modelica.SIunits.MassFlowRate m_flow "internal moisture gain";

  Modelica.SIunits.SpecificEnthalpy h_air_in "enthalpy of incoming air";
  Modelica.SIunits.SpecificEnthalpy h_air_out "enthalpy of outgoing air";

protected
  constant Real Q_flow_people(unit="W/(m.m)") = 5 "specific heat output of people";
  constant Real m_wat_flow_people(unit="kg/(m.m.s)") = 1.587E-6 "specific water output of people";
  constant Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of air";
  constant Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  constant Modelica.SIunits.SpecificEnthalpy r_0 = 2500E3 "specific enthalpy of vaporization";
public
  Modelica.Blocks.Interfaces.RealInput TempIn(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Temperature of incoming air"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}}),
        iconTransformation(extent={{-120,-30},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput HumIn(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of incoming air"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}}),
        iconTransformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of incoming air"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}}),
        iconTransformation(extent={{-120,-90},{-100,-70}})));
  Modelica.Blocks.Interfaces.RealOutput TempOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Temperature of outgoing air"
    annotation (Placement(transformation(extent={{-100,10},{-120,30}})));
  Modelica.Blocks.Interfaces.RealOutput HumOut(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of outgoing air"
    annotation (Placement(transformation(extent={{-100,40},{-120,60}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of outgoing air"
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Interfaces.RealInput Schedule
    "Schedule of internal people gains (0..1)"
    annotation (Placement(
        transformation(
        extent={{-20,-10},{20,30}},
        rotation=90,
        origin={10,-120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-110})));
equation
  //internal gains
  Q_flow = Q_flow_people * A_room * Schedule;
  m_flow = m_wat_flow_people * A_room * Schedule;

  //enthalpies
  h_air_in = cp_air*(TempIn-273.15)+HumIn*(cp_steam*(TempIn-273.15)+r_0);
  h_air_out = cp_air*(TempOut-273.15)+HumOut*(cp_steam*(TempOut-273.15)+r_0);

  //energy balance
  0 = (m_flow_in * h_air_in - m_flow_out * h_air_out + Q_flow + m_flow*r_0);

  //mass balance
  m_flow_in = m_flow_out;

  0 = (m_flow_in * HumIn - m_flow_out * HumOut + m_flow)
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleRoom;
