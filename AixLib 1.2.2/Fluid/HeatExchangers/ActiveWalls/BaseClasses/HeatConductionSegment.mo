within AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses;
model HeatConductionSegment

  parameter Modelica.Units.SI.ThermalConductance kA
    "Constant thermal conductance of material";
  parameter Modelica.Units.SI.HeatCapacity mc_p
    "Heat capacity of element (= cp*m)";
  parameter Modelica.Units.SI.Temperature T0 "Initial Temperature of element";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-108,-8},{-74,26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
    annotation (Placement(transformation(extent={{74,-8},{108,26}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=2*kA)
    annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    thermalConductor2(                                                        G=
       2*kA) annotation (Placement(transformation(extent={{28,-2},{48,18}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
    heatCapacitor(                                                     T(start=
          T0), C=mc_p)
    annotation (Placement(transformation(extent={{-12,34},{8,54}})));
equation
  connect(port_a, thermalConductor1.port_a) annotation (Line(
      points={{-91,9},{-46,9},{-46,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalConductor1.port_b, heatCapacitor.port) annotation (Line(
      points={{-26,10},{-24,10},{-24,28},{-2,28},{-2,34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalConductor2.port_a, heatCapacitor.port) annotation (Line(
      points={{28,8},{20,8},{20,28},{-2,28},{-2,34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermalConductor2.port_b, port_b) annotation (Line(
      points={{48,8},{86,8},{86,10},{88,10},{88,9},{91,9}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={
      Rectangle(
        extent={{-100,-45.5},{100,45.5}},
        lineColor={166,166,166},
        pattern=LinePattern.None,
        fillColor={190,190,190},
        fillPattern=FillPattern.Solid,
          origin={0.5,0},
          rotation=90),
      Rectangle(
        extent={{100,30},{-100,-30}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid,
          origin={-70,0},
          rotation=270),
      Rectangle(
        extent={{100,30},{-100,-30}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid,
          origin={76,0},
          rotation=270),
        Line(
          points={{-72,-1},{72,-1}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled},
          origin={4,47},
          rotation=360),
        Line(
          points={{-72,-1},{72,-1}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled},
          origin={2,-33},
          rotation=180)}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for heat conduction using elements from the MSL.
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>February 06, 2017&#160;</i> by Philipp Mehrfeld:<br/>
    Naming according to AixLib standards.
  </li>
  <li>
    <i>June 15, 2017&#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>March 25, 2015&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL
  </li>
  <li>
    <i>November 06, 2014&#160;</i> by Ana Constantin:<br/>
    Added documentation.
  </li>
</ul>
</html>"));
end HeatConductionSegment;
