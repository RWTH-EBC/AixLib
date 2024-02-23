within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses;
class RadiatorWall "Simple one layer wall"

  parameter Modelica.Fluid.Types.Dynamics initDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial "Like energyDynamics, but SteadyState leeds to same behavior as DynamicFreeInitial"
    annotation(Evaluate=true, Dialog(tab="Initialization"));

  parameter Modelica.Units.SI.Thickness d "Thickness"
    annotation (Dialog(group="Structure"));
  parameter Modelica.Units.SI.ThermalConductivity lambda "Thermal conductivity"
    annotation (Dialog(group="Structure"));
  parameter Modelica.Units.SI.HeatCapacity C "Heat capacity of radiator wall";
  parameter Modelica.Units.SI.SpecificHeatCapacity c "Specific heat capacity"
    annotation (Dialog(group="Structure"));
  parameter Modelica.Units.SI.Temperature T0 "Initial temperature"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.Units.SI.Area A "Area of radiator surface";
  parameter Modelica.Units.SI.ThermalConductance G=lambda*A/d;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-104,-8},{-84,12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{84,-10},{104,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
    C=C,
    final T(
      stateSelect=StateSelect.always,
      fixed=(initDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial),
      start=T0),
    final der_T(fixed=(initDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial), start=0)) annotation (Placement(transformation(
        origin={-6,-62},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    thermalConductor(G=G/2)
    annotation (Placement(transformation(extent={{-56,-30},{-36,-10}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    thermalConductor1(G=G/2)
    annotation (Placement(transformation(extent={{32,-30},{52,-10}},
          rotation=0)));
equation
  connect(port_a, thermalConductor.port_a) annotation (Line(
      points={{-94,2},{-73,2},{-73,-20},{-56,-20}},
      color={191,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(thermalConductor.port_b, heatCapacitor.port) annotation (Line(
      points={{-36,-20},{-6,-20},{-6,-52}},
      color={191,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(thermalConductor.port_b, thermalConductor1.port_a) annotation (Line(
      points={{-36,-20},{32,-20}},
      color={191,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  connect(thermalConductor1.port_b, port_b) annotation (Line(
      points={{52,-20},{71,-20},{71,0},{94,0}},
      color={191,0,0},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics),
                       Icon(graphics={
        Rectangle(
          extent={{-80,60},{-50,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,60},{-20,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,60},{20,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,60},{50,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,60},{80,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html><ul>
  <li>
    <i>October, 2016&#160;</i> by Peter Remmen:<br/>
    Transfer to AixLib.
  </li>
  <li>
    <i>October 7, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>
", info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Simple one layer wall for a radiator
</p>
</html>"));
end RadiatorWall;
