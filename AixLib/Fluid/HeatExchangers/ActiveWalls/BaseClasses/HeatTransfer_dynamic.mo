within AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses;
model HeatTransfer_dynamic
  "the heat transfer coefficient changes according to operation mode: heating of cooling"

parameter Modelica.SIunits.ThermalConductance kA_up
    "Constant thermal conductance of material heat flow upwards: floorheating and ceiling cooling";
parameter Modelica.SIunits.ThermalConductance kA_down
    "Constant thermal conductance of material for heat flow down: floor cooling and ceiling heating";
parameter Modelica.SIunits.HeatCapacity mc_p
    "Heat capacity of element (= cp*m)";

parameter Modelica.SIunits.Temperature T0 "Initial Temperature of element";

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
    heatCapacitor(                                                     T(start=
          T0), C=mc_p)
    annotation (Placement(transformation(extent={{-18,26},{2,46}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
      annotation (Placement(transformation(extent={{-104,-10},{-84,10}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
      annotation (Placement(transformation(extent={{82,-10},{102,10}})));
  Modelica.Blocks.Interfaces.BooleanInput IsUp annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-26,100})));
    Modelica.Thermal.HeatTransfer.Components.Convection convection
      annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
    Modelica.Thermal.HeatTransfer.Components.Convection convection1
      annotation (Placement(transformation(extent={{28,-10},{48,10}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=2*kA)
      annotation (Placement(transformation(extent={{-98,42},{-78,62}})));
  //Variables
      Modelica.SIunits.ThermalConductance kA "Heat transfer coefficient";

equation
  kA = smooth(1, if IsUp then kA_up else kA_down);

    connect(port_a, convection.solid) annotation (Line(
        points={{-94,0},{-62,0}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(convection.fluid, heatCapacitor.port) annotation (Line(
        points={{-42,0},{-8,0},{-8,26}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(heatCapacitor.port, convection1.solid) annotation (Line(
        points={{-8,26},{-8,0},{28,0}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(convection1.fluid, port_b) annotation (Line(
        points={{48,0},{92,0}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(realExpression.y, convection.Gc) annotation (Line(
        points={{-77,52},{-52,52},{-52,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression.y, convection1.Gc) annotation (Line(
        points={{-77,52},{38,52},{38,40},{38,40},{38,10}},
        color={0,0,127},
        smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
                      graphics), Icon(graphics={
      Rectangle(
        extent={{-100,-45.5},{100,45.5}},
        lineColor={166,166,166},
        pattern=LinePattern.None,
        fillColor={190,190,190},
        fillPattern=FillPattern.Solid,
          origin={-3.5,0},
          rotation=90),
      Rectangle(
        extent={{100,30},{-100,-30}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid,
          origin={70,0},
          rotation=270),
      Rectangle(
        extent={{100,30},{-100,-30}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid,
          origin={-70,0},
          rotation=270),
        Line(
          points={{-72,-1},{72,-1}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled},
          origin={4,-33},
          rotation=180),
        Line(
          points={{-72,-1},{72,-1}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled},
          origin={6,45},
          rotation=360)}),
      Documentation(revisions="<html>
<ul>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>August 03, 2014&nbsp;</i> by Ana Constantin:<br/>
Implemented.</li>
</ul>
</html>"));
end HeatTransfer_dynamic;
