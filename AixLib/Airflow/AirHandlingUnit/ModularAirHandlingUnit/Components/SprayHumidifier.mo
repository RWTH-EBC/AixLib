within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model SprayHumidifier "Idealized model of a spray humidifier"

  // parameters
  parameter Modelica.SIunits.SpecificHeatCapacity c_wat = 4180 "specific heat capacity of water";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.SIunits.Density rho_air = 1.2 "Density of air";

  parameter Boolean simplify_m_wat_flow = false "If set to true, mass flow rate and enthalpy of water are not considered in the mass and energy balance";
  parameter Boolean use_X_set = false "if true, a set humidity is used to calculate the necessary mass flow rate";
  parameter Real k = 500 "exponent for humidification degree";

  // constants
  constant Modelica.SIunits.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  // Variables
  Modelica.SIunits.SpecificEnthalpy h_airIn "specific enthalpy of incoming air";
  Modelica.SIunits.SpecificEnthalpy h_airOut "specific enthalpy of outgoing air";
  Modelica.SIunits.SpecificEnthalpy h_watIn "specific enthalpy of incoming water";

  Modelica.SIunits.HeatFlowRate Q_flow "heat flow";
  Real eta_B "humidification degree";


  replaceable model PartialPressureDrop =
      Components.PressureDrop.BaseClasses.partialPressureDrop annotation(choicesAllMatching=true);

      PartialPressureDrop partialPressureDrop(m_flow = m_flow_airIn,
      rho = rho_air);

  Modelica.Blocks.Interfaces.RealInput m_flow_airIn(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of incoming air"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airIn(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of incoming air"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airIn(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of incoming air"
    annotation (Placement(transformation(extent={{-140,-10},{-100,30}}),
        iconTransformation(extent={{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOut(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of outgoing air"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of outgoing air"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOut(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of outgoing air"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_watIn(
    final quantity = "MassFlowRate",
    final unit = "kg/s") if not use_X_set
    "mass flow rate of water"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-110})));

  Modelica.Blocks.Interfaces.RealInput T_watIn(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "mass flow rate of water"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-110})));
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
  Real WLN "water to air ratio";
  Modelica.Blocks.Interfaces.RealInput X_intern "internal mass fraction";
  Modelica.Blocks.Interfaces.RealInput m_flow_watIntern "internal mass flow rate of water";
equation

  // mass balance
  if simplify_m_wat_flow then
    m_flow_airIn - m_flow_airOut = 0;
  else
    m_flow_airIn + m_flow_watIntern * eta_B - m_flow_airOut = 0;
  end if;

  if not use_X_set then
  m_flow_airIn * X_airIn + m_flow_watIntern * eta_B - m_flow_airOut * X_intern = 0;
  else
  m_flow_watIntern = m_flow_airIn / (1+X_airIn) * (X_intern-X_airIn);
  end if;

  // energy balance
  if simplify_m_wat_flow then
    h_airIn - h_airOut = 0;
  else
    m_flow_airIn * h_airIn + m_flow_watIntern * eta_B * h_watIn - m_flow_airOut * h_airOut = 0;
  end if;

  // specific enthalpies
  h_airIn = cp_air * (T_airIn - 273.15) + X_airIn * (cp_steam * (T_airIn - 273.15) + r0);
  h_airOut = cp_air * (T_airOut - 273.15) + X_intern * (cp_steam * (T_airOut - 273.15) + r0);
  h_watIn = c_wat * (T_watIn - 273.15);

  // heat flow
  Q_flow = m_flow_airOut * h_airOut - m_flow_airIn * h_airIn;

  // water to air ratio
  WLN = m_flow_watIntern/m_flow_airIn;

  // humidification degree
  eta_B = 1 - exp(-k * WLN);

  X_airOut = X_intern;

  partialPressureDrop.dp = dp;

  // conditional connectors
  connect(max.y,X_intern);
  connect(m_flow_watIn,m_flow_watIntern);

  connect(X_set, max.u1) annotation (Line(points={{0,110},{0,88},{-50,88},{-50,76},
          {-42,76}}, color={0,0,127}));
  connect(X_airIn, max.u2) annotation (Line(points={{-120,10},{-80,10},{-80,64},
          {-42,64}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,94},{100,-94}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-90,84},{-14,66}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Polygon(
          points={{-100,-68},{-94,-66},{-84,-64},{-66,-66},{-54,-64},{-34,-68},{
              -18,-64},{4,-68},{26,-66},{40,-68},{56,-66},{66,-68},{82,-68},{90,
              -66},{100,-66},{100,-94},{-100,-94},{-100,-68}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{48,-68},{48,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{48,40},{30,50}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{48,40},{30,40}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{48,40},{30,30}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{86,94},{86,-94}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{82,94},{82,-94}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-100,94},{100,-94}},
          lineColor={0,0,0},
          lineThickness=0.5)}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model provides a idealized spray humidifier. The output air humidity is calculated using the input air humidity and the mass flow rate of water:</P>
<p align=\"center\"><i>m<sub>air,in</sub>  X<sub>air,in</sub> + m<sub>wat,in</sub> &eta;<sub>B</sub> = m<sub>air,out</sub> X<sub>air,out</sub> </i></p>
<p>The energy balance is formulated using the enthalpy of the air streams and the enthalpy of the water:</p>
<p align=\"center\"><i>m<sub>air,in</sub> h<sub>air,in</sub> + m<sub>wat,in</sub> h<sub>wat,in</sub> &eta;<sub>B</sub> = m<sub>air,out</sub> h<sub>air,out</sub> </i></p>
<p>The humidifying degree <i>&eta;<sub>B</sub></i> is calculated using the water to air ratio <i>E</i>:</p>
<p align=\"center\"><i>&eta;<sub>B</sub> = 1 - exp(-k E) </i></p>
<p align=\"center\"><i>E = m<sub>wat,in</sub> &frasl; m<sub>air,in</sub> </i></p>
<p>If the boolean variable <i>simplify_m_wat_flow</i> is set to true, the mass flow rate of the water is not considered for the mass balance. Moreover the enthalpy of the water is neglected for the energy balance.</p>
<p>The equations are based on [1].
<h4>References</h4>
<p>[1]: Baumgarth, Hörner, Reeker (Hrsg.): <i>Handbuch der Klimatechnik</i>, Band 2, 5. Auflage, VDE Verlag GmbH, 2011 (pp.304-306)</p>
</html>", revisions="<html>
<ul>
<li>April, 2019, by Martin Kremer:<br>First Implementation.</li>
</ul>
</html>"));
end SprayHumidifier;
