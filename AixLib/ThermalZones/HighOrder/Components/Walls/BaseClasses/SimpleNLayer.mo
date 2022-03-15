within AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses;
model SimpleNLayer "Wall consisting of n layers"
  parameter Modelica.SIunits.Area A "Area" annotation(Dialog(group = "Geometry"));

  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition
    wallRec constrainedby AixLib.DataBase.Walls.WallBaseDataDefinition
    annotation (choicesAllMatching=true, Placement(transformation(extent={{48,-98},{68,-78}})));
  parameter Modelica.SIunits.Temperature T_start[wallRec.n]=fill(Modelica.SIunits.Conversions.from_degC(16), wallRec.n) "Initial temperature"
                                                                                                               annotation(Dialog(group="Thermal"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  // 1st port = port_a
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent={{-110,
          -10},{-90,10}}),                                                                                                        iconTransformation(extent={{-110,
          -10},{-90,10}})));
  // n HeatConds
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatCond_a[wallRec.n](G = A .* wallRec.lambda ./ (wallRec.d / 2)) "Heat conduction element (side a)" annotation(Placement(transformation(extent={{-52,-10},{-32,10}})));
  // n Loads (port_a = 1, port_b = n)
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap[wallRec.n](
    final C=wallRec.c .* wallRec.rho .* A .* wallRec.d,
    final T(
      each stateSelect=StateSelect.always,
      each fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=T_start),
    final der_T(
      each fixed=(energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial),
      each start=0))
    if not (energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));

  // n HeatConds
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatCond_b[wallRec.n](G = A .* wallRec.lambda ./ (wallRec.d / 2)) "Heat conduction element (side b)" annotation(Placement(transformation(extent={{30,-10},{50,10}})));

  // nth port = port_b
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent={{90,-10},
            {110,10}}),                                                                                                           iconTransformation(extent={{90,-10},
            {110,10}})));

equation
  // connecting inner elements HeatCondb[i]--Load[i]--HeatConda[i] to n groups
  for i in 1:wallRec.n loop
    connect(heatCond_a[i].port_b, cap[i].port) annotation (Line(
        points={{-32,0},{-18,0},{-18,-42},{0,-42}},
        color={191,0,0},
        pattern=LinePattern.DashDotDot));
    connect(cap[i].port, heatCond_b[i].port_a) annotation (Line(
        points={{0,-42},{18,-42},{18,0},{30,0}},
        color={191,0,0},
        pattern=LinePattern.DashDotDot));
    if energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState then
        connect(heatCond_a[i].port_b, heatCond_b[i].port_a) annotation (Line(points={{-32,0},{-20,0},{-20,6},{20,6},{20,0},{30,0}}, color={191,0,0}, pattern=LinePattern.Dash));
    end if;
  end for;
  // establishing n-1 connections of HeatCondb--Load--HeatConda groups
  for i in 1:wallRec.n - 1 loop
    connect(heatCond_b[i].port_b, heatCond_a[i + 1].port_a) annotation (Line(
        points={{50,0},{58,0},{58,24},{-58,24},{-58,0},{-52,0}},
        color={191,0,0},
        pattern=LinePattern.DashDotDot));
  end for;
  // connecting outmost elements to connectors: port_a--HeatCondb[1]...HeatConda[n]--port_b
  connect(heatCond_a[1].port_a, port_a) annotation (Line(
      points={{-52,0},{-100,0}},
      color={191,0,0},
      pattern=LinePattern.DashDotDot));
  connect(heatCond_b[wallRec.n].port_b, port_b) annotation (Line(
      points={{50,0},{100,0}},
      color={191,0,0},
      pattern=LinePattern.DashDotDot));

  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),                                                                                  Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent={{-80,80},{80,-80}},       lineColor = {0, 0, 0}), Rectangle(extent={{-32,80},{32,-80}},       lineColor = {166, 166, 166}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid),                                                                           Rectangle(extent={{-48,80},{-32,-80}},       lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{-64,80},{-48,-80}},       lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{-80,80},{-64,-80}},       lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{64,80},{80,-80}},       lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {156, 156, 156},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{32,80},{48,-80}},       lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {208, 208, 208},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{48,80},{64,-80}},       lineColor = {0, 0, 255}, pattern = LinePattern.None, fillColor = {190, 190, 190},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{-80,40},{80,-40}},        lineColor={0,0,0},
          textString="1..n"),                                                                                                                   Rectangle(extent={{-80,80},{80,-80}},       lineColor = {135, 135, 135})}),         Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>SimpleNLayer</b> model represents a simple wall, consisting of
  n different layers.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  There is one inner and one outer <b><a href=
  \"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b>-connector
  to simulate one-dimensional heat transfer through the wall and heat
  storage within the wall.
</p>
<p>
  <b><span style=\"color: #ff0000\">Attention:</span></b> The first
  element in each vector represents the layer connected to
  <code>HeatPort_a</code>, the last element represents the layer
  connected to <code>HeatPort_b</code>.
</p>
</html>
 ", revisions="<html><ul>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/891\">#891</a>:
    Add energyDynamics. Apply T_start as vector. <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>: Use only
    records.
  </li>
  <li>
    <i>Mai 19, 2014</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>May 02, 2013</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>March 14, 2005</i> by Timo Haase:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end SimpleNLayer;
