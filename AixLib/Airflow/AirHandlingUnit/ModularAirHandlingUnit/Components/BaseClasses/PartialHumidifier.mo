within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses;
model PartialHumidifier "partial model of a humidifier"

  // parameters
  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_water = 4180 "specific heat capacity of water";
  parameter Modelica.SIunits.Density rho_air = 1.2 "Density of air";
  parameter Boolean use_X_set = false "if true, a set humidity is used to calculate the necessary mass flow rate";

  // constants
  constant Modelica.SIunits.SpecificEnthalpy r100 = 2257E3 "specific heat of vaporization at 100°C";
  constant Modelica.SIunits.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  // Variables
  Modelica.SIunits.SpecificEnthalpy h_airIn "specific enthalpy of incoming air";
  Modelica.SIunits.SpecificEnthalpy h_airOut "specific enthalpy of outgoing air";

  Modelica.SIunits.HeatFlowRate Q_flow "heat flow";

  replaceable model PartialPressureDrop =
      Components.PressureDrop.BaseClasses.partialPressureDrop annotation(choicesAllMatching=true);

      PartialPressureDrop partialPressureDrop(m_flow = m_flow_airIn,
      rho = rho_air);

  Modelica.Blocks.Interfaces.RealInput m_flow_airIn(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of incoming air"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airIn(
    final quantity = "ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC")
    "temperature of incoming air"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airIn(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of incoming air"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOut(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of outgoing air"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOut(
    final quantity = "ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC")
    "temperature of outgoing air"
    annotation (Placement(transformation(extent={{100,40},{120,60}}),
        iconTransformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOut(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of outgoing air"
    annotation (Placement(transformation(extent={{100,10},{120,30}}),
        iconTransformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealInput m_wat_flow(
    final quantity = "MassFlowRate",
    final unit = "kg/s") if not use_X_set
                                         "mass flow rate of steam"
    annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-70,-104}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-60,-94})));
  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealInput X_set if use_X_set annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,102})));
  Modelica.Blocks.Interfaces.RealInput T_watIn(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "mass flow rate of water"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-106}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-94})));
protected
  Modelica.Blocks.Math.Max max if use_X_set
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Interfaces.RealInput X_intern "internal mass fraction";
  Modelica.Blocks.Interfaces.RealInput m_wat_flow_intern "internal mass flow rate of water";
equation

  //heat flows
  Q_flow = m_flow_airIn * (h_airOut - h_airIn);

  // specific enthalpies
   h_airIn = cp_air * (T_airIn - 273.15) + X_airIn * (cp_steam * (T_airIn - 273.15) + r0);
   h_airOut = cp_air * (T_airOut - 273.15) + X_airOut * (cp_steam * (T_airOut - 273.15) + r0);

   // X_airOut = X_intern;

   partialPressureDrop.dp = dp;

    // conditional connectors
   // connect(max.y,X_intern);
   connect(m_wat_flow,m_wat_flow_intern);

  connect(X_set, max.u1) annotation (Line(points={{0,110},{0,86},{-48,86},{-48,76},
          {-42,76}}, color={0,0,127}));
  connect(X_airIn, max.u2) annotation (Line(points={{-120,20},{-80,20},{-80,64},
          {-42,64}}, color={0,0,127}));
        annotation (
    preferredView="info",
    Documentation(info="<html><p>
  This model provides a partial humidifier. All water added to the air
  flow is binded in the air and leads to an increase of the absolute
  humidity.
</p>
</html>", revisions="<html>
<ul>
  <li>April 2020, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"),                  Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-100,94},{100,-92}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5)}),                                                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialHumidifier;
