within AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses;
model PH_Segment

extends Modelica.Fluid.Interfaces.PartialTwoPort;

parameter Boolean Floor = true;

parameter Modelica.SIunits.Area A "Area of Floor part";

parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity";

parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius";

parameter Modelica.SIunits.Volume Watervolume = "Volume of Water in m^3";

parameter Modelica.SIunits.CoefficientOfHeatTransfer k_top;
parameter Modelica.SIunits.CoefficientOfHeatTransfer k_down;

parameter HeatCapacityPerArea C_top;
parameter HeatCapacityPerArea C_down;

  Modelica.Fluid.Vessels.ClosedVolume Volume(
    redeclare package Medium = Medium,
    energyDynamics=system.energyDynamics,
    use_HeatTransfer=true,
    T_start=T0,
    redeclare model HeatTransfer =
      Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
    use_portsData=false,
    V=Watervolume,
    nPorts=2)
    annotation (Placement(transformation(extent={{-14,-26},{8,-4}})));

  Modelica.Fluid.Sensors.TemperatureTwoPort t_flow(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort t_return(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermDown
    annotation (Placement(transformation(extent={{-22,-110},{-2,-90}})));
  AixLib.Utilities.HeatTransfer.HeatToStar twoStar_RadEx(A=A, eps=eps)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,74})));
  Utilities.HeatTransfer.HeatConv_inside            HeatConv(
    A=A, surfaceOrientation = if Floor then 2 else 1)                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={1.77636e-015,74})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermTop
    annotation (Placement(transformation(extent={{-12,90},{8,110}})));
  AixLib.Utilities.Interfaces.Star StarTop
    annotation (Placement(transformation(extent={{-38,92},{-18,112}})));
  Panel_Segment panel_Segment1(
    kA=k_top*A,
    mc_p=C_top*A,
    T0=T0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,30})));
  Panel_Segment panel_Segment2(
    T0=T0,
    kA=k_down*A,
    mc_p=C_down*A) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-12,-56})));
equation

  connect(port_a, t_flow.port_a) annotation (Line(
      points={{-100,0},{-88,0},{-88,-26},{-70,-26}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(t_flow.port_b, Volume.ports[1]) annotation (Line(
      points={{-50,-26},{-5.2,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Volume.ports[2], t_return.port_a) annotation (Line(
      points={{-0.8,-26},{50,-26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(t_return.port_b, port_b) annotation (Line(
      points={{70,-26},{84,-26},{84,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HeatConv.port_a, ThermTop)
                                   annotation (Line(
      points={{3.60822e-015,84},{3.60822e-015,92.5},{-2,92.5},{-2,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(twoStar_RadEx.Star, StarTop)
                                     annotation (Line(
      points={{-30,83.1},{-30,102},{-28,102}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(ThermDown, ThermDown) annotation (Line(
      points={{-12,-100},{-12,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panel_Segment1.port_b, twoStar_RadEx.Therm) annotation (Line(
      points={{-16.9,39.1},{-16.9,51.55},{-30,51.55},{-30,64.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panel_Segment1.port_b, HeatConv.port_b) annotation (Line(
      points={{-16.9,39.1},{-16.9,51.55},{0,51.55},{0,64}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panel_Segment1.port_a, Volume.heatPort) annotation (Line(
      points={{-16.9,20.9},{-16.9,2},{-14,2},{-14,-15}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panel_Segment2.port_b, ThermDown) annotation (Line(
      points={{-11.1,-65.1},{-11.1,-81.55},{-12,-81.55},{-12,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panel_Segment2.port_a, Volume.heatPort) annotation (Line(
      points={{-11.1,-46.9},{-11.1,-31.45},{-14,-31.45},{-14,-15}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(graphics={
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
end PH_Segment;
