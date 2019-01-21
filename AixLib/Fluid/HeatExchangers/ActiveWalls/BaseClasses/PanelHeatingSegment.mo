within AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses;
model PanelHeatingSegment
  "One segment of the discretized panel heating"

extends Modelica.Fluid.Interfaces.PartialTwoPort;

parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius";

parameter Modelica.SIunits.Volume VWater "Volume of Water in m^3";

  Modelica.Fluid.Vessels.ClosedVolume vol(
    redeclare package Medium = Medium,
    energyDynamics=system.energyDynamics,
    use_HeatTransfer=true,
    T_start=T0,
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
    use_portsData=false,
    V=VWater,
    nPorts=2) annotation (Placement(transformation(extent={{-14,-26},{8,-4}})));

  Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermConvWall
    annotation (Placement(transformation(extent={{-22,-110},{-2,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermConvRoom
    annotation (Placement(transformation(extent={{-12,90},{8,110}})));
equation

  connect(port_a, TFlow.port_a) annotation (Line(
      points={{-100,0},{-88,0},{-88,-26},{-70,-26}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(TFlow.port_b, vol.ports[1]) annotation (Line(
      points={{-50,-26},{-5.2,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.ports[2], TReturn.port_a) annotation (Line(
      points={{-0.8,-26},{50,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TReturn.port_b, port_b) annotation (Line(
      points={{70,-26},{84,-26},{84,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(thermConvWall, thermConvWall) annotation (Line(
      points={{-12,-100},{-12,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(vol.heatPort, thermConvRoom) annotation (Line(points={{-14,-15},{-14,
          40},{-2,40},{-2,100}}, color={191,0,0}));
  connect(vol.heatPort, thermConvWall) annotation (Line(points={{-14,-15},{-14,
          -100},{-12,-100}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={
        Rectangle(
          extent={{-100,20},{100,-22}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
      Rectangle(
        extent={{-100,66},{100,40}},
        lineColor={166,166,166},
        pattern=LinePattern.None,
        fillColor={190,190,190},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{100,100},{-100,66}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{100,40},{-100,20}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{100,-22},{-100,-56}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-100,-56},{100,-82}},
        lineColor={166,166,166},
        pattern=LinePattern.None,
        fillColor={190,190,190},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{100,-82},{-100,-102}},
        lineColor={0,0,255},
        pattern=LinePattern.None,
        fillColor={156,156,156},
        fillPattern=FillPattern.Solid),
        Line(
          points={{-22,26},{-22,82}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-20,62},{62,40}},
          lineColor={255,0,0},
          textString="Q_flow"),
        Text(
          extent={{-20,-46},{62,-68}},
          lineColor={255,0,0},
          textString="Q_flow"),
        Line(
          points={{0,-28},{0,28}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled},
          origin={-22,-54},
          rotation=180)}),
    Documentation(revisions="<html>
<ul>
<li><i>February 06, 2017&nbsp;</i> by Philipp Mehrfeld:<br/>
Naming according to AixLib standards.</li>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>Added documentation.</li>
</ul>
</html>",
      info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a panel heating element, consisting of a water volume, heat conduction upwards and downwards through the wall layers, convection and radiation exchange at the room facing side.</p>
</html>"));
end PanelHeatingSegment;
