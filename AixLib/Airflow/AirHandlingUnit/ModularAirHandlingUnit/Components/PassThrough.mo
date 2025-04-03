within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model PassThrough
  "model representing an empty part of an air handling unit (used for modularity)"
  Modelica.Blocks.Interfaces.RealInput m_flow_airIn(
    final quantity="MassFlowRate",
    final unit="kg/s")
    "mass flow rate of incoming air"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
        iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput T_airIn(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    start=288.15,
    displayUnit="degC")
    "Temperature of incoming air"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealInput X_airIn(final quantity="MassFraction",
      final unit="kg/kg")
    "absolute humidity of incoming air"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}}),
        iconTransformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOut(final quantity="MassFraction",
      final unit="kg/kg") "absolute humidity of outgoing air"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOut(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    start=288.15,
    displayUnit="degC") "Temperature of outgoing air"
     annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOut(
    final quantity="MassFlowRate",
    final unit="kg/s") "mass flow rate of outgoing air"
     annotation (Placement(
        transformation(extent={{100,40},{120,60}}), iconTransformation(extent={{100,40},
            {120,60}})));
equation
  connect(X_airIn, X_airOut)
    annotation (Line(points={{-120,-50},{110,-50}}, color={0,0,127}));
  connect(T_airIn, T_airOut)
    annotation (Line(points={{-120,0},{110,0}}, color={0,0,127}));
  connect(m_flow_airIn, m_flow_airOut)
    annotation (Line(points={{-120,50},{110,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>April, 2020 by Martin Kremer:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end PassThrough;
