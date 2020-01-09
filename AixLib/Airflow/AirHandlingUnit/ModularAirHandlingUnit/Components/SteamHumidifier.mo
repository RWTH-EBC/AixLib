within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model SteamHumidifier

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
  Modelica.SIunits.SpecificEnthalpy h_steam "specific enthalpy of steam";

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
  Modelica.Blocks.Interfaces.RealInput m_flow_steam(
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
  Modelica.Blocks.Interfaces.RealInput T_steamIn(
    final quantity = "ThermodynamicTemperature",
    final unit = "K",
    displayUnit = "degC")
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-40,-104}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-30,-94})));
  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealInput X_set if use_X_set annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,110})));
protected
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Interfaces.RealInput X_intern "internal mass fraction";
  Modelica.Blocks.Interfaces.RealInput m_flow_steamIntern "internal mass flow rate of water";
equation

  //mass balances
  m_flow_airIn + m_flow_steamIntern - m_flow_airOut = 0;

  //mass balance moisture
  if not use_X_set then
  m_flow_airIn * X_airIn + m_flow_steamIntern - m_flow_airOut * X_intern = 0;
  else
  m_flow_steamIntern = m_flow_airIn / (1+X_airIn) * (X_intern-X_airIn);
  end if;

  //heat flows
  Q_flow = m_flow_steamIntern * h_steam;
  Q_flow = m_flow_airIn * (h_airOut - h_airIn);

  // specific enthalpies
   h_airIn = cp_air * (T_airIn - 273.15) + X_airIn * (cp_steam * (T_airIn - 273.15) + r0);
   h_airOut = cp_air * (T_airOut - 273.15) + X_intern * (cp_steam * (T_airOut - 273.15) + r0);

   assert(T_steamIn >= 373.15, "Steam temperature T has to be higher than 100 degC");
   h_steam = cp_water * (373.15 - 273.15) + cp_steam * (T_steamIn - 373.15) + r100;

   X_airOut = X_intern;

   partialPressureDrop.dp = dp;

    // conditional connectors
   connect(max.y,X_intern);
   connect(m_flow_steam,m_flow_steamIntern);

  connect(X_set, max.u1) annotation (Line(points={{0,110},{0,86},{-48,86},{-48,76},
          {-42,76}}, color={0,0,127}));
  connect(X_airIn, max.u2) annotation (Line(points={{-120,20},{-80,20},{-80,64},
          {-42,64}}, color={0,0,127}));
        annotation (
    preferredView="info",
    Documentation(info="<html>    
<p>This model describes an idealized steam humidifier.The enthalpy of the steam is considered by its temperature. All steam added to the air flow is binded in the air and leads to an increas of the absolute humidity.</p>
<p>The heat flow is calculated using the specific steam enthalpy and mass flow rate of the steam.</p>
</html>", revisions="<html>
<ul>
<li>May 2019, by Ervin Lejlic:<br>First implementation.</li>
<li>May 2019, by Martin Kremer:<br>Changed variable names for naming convention and deleting efficiency.</li>
<li>June 2019, by Martin Kremer:<br>Fixed bug in calculation of heat flow due to wrong calculation of steam enthalpy. Added assertion for steam temperature.</li>
</ul>
</html>"),                  Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-100,94},{100,-92}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-8,-78},{-12,68}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{4,-50},{-8,-58},{-8,-58},{4,-64},{4,-62},{-4,-58},{-4,-58},{
              4,-52},{4,-50}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,-50},{-12,-58},{-12,-58},{-24,-64},{-24,-62},{-16,-58},{
              -16,-58},{-24,-52},{-24,-50}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,-14},{-12,-22},{-12,-22},{-24,-28},{-24,-26},{-16,-22},{
              -16,-22},{-24,-16},{-24,-14}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{4,-14},{-8,-22},{-8,-22},{4,-28},{4,-26},{-4,-22},{-4,-22},{
              4,-16},{4,-14}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{4,18},{-8,10},{-8,10},{4,4},{4,6},{-4,10},{-4,10},{4,16},{4,
              18}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,18},{-12,10},{-12,10},{-24,4},{-24,6},{-16,10},{-16,10},
              {-24,16},{-24,18}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,46},{-12,38},{-12,38},{-24,32},{-24,34},{-16,38},{-16,38},
              {-24,44},{-24,46}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-24,74},{-12,66},{-12,66},{-24,60},{-24,62},{-16,66},{-16,66},
              {-24,72},{-24,74}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{4,46},{-8,38},{-8,38},{4,32},{4,34},{-4,38},{-4,38},{4,44},{
              4,46}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{4,74},{-8,66},{-8,66},{4,60},{4,62},{-4,66},{-4,66},{4,72},{
              4,74}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{54,-78},{50,68}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,-50},{54,-58},{54,-58},{66,-64},{66,-62},{58,-58},{58,-58},
              {66,-52},{66,-50}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,-50},{50,-58},{50,-58},{38,-64},{38,-62},{46,-58},{46,-58},
              {38,-52},{38,-50}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,-14},{50,-22},{50,-22},{38,-28},{38,-26},{46,-22},{46,-22},
              {38,-16},{38,-14}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,-14},{54,-22},{54,-22},{66,-28},{66,-26},{58,-22},{58,-22},
              {66,-16},{66,-14}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,18},{54,10},{54,10},{66,4},{66,6},{58,10},{58,10},{66,16},
              {66,18}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,18},{50,10},{50,10},{38,4},{38,6},{46,10},{46,10},{38,16},
              {38,18}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,46},{50,38},{50,38},{38,32},{38,34},{46,38},{46,38},{38,
              44},{38,46}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{38,74},{50,66},{50,66},{38,60},{38,62},{46,66},{46,66},{38,
              72},{38,74}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,46},{54,38},{54,38},{66,32},{66,34},{58,38},{58,38},{66,
              44},{66,46}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{66,74},{54,66},{54,66},{66,60},{66,62},{58,66},{58,66},{66,
              72},{66,74}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})}),                                                Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SteamHumidifier;
