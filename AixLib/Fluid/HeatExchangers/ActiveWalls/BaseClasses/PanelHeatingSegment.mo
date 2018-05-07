within AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses;
model PanelHeatingSegment
  "One segment of the discretized panel heating"

extends Modelica.Fluid.Interfaces.PartialTwoPort;

parameter Boolean isFloor = true;

parameter Modelica.SIunits.Area A "Area of Floor part";

parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity";

parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius";

parameter Modelica.SIunits.Volume VWater "Volume of Water in m^3";

parameter Modelica.SIunits.CoefficientOfHeatTransfer kTop;
parameter Modelica.SIunits.CoefficientOfHeatTransfer kDown;

parameter HeatCapacityPerArea cTop;
parameter HeatCapacityPerArea cDown;

  parameter Integer calcMethodConvection = 1
    "Calculation Method for convection at surface"
    annotation (Dialog(group = "Heat convection",
        descriptionLabel=true), choices(
        choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
        choice=2 "By Bernd Glueck",
        choice=3 "Constant alpha",
        radioButtons=true));

  parameter Modelica.SIunits.CoefficientOfHeatTransfer convCoeffCustom = 2.5
    "Constant heat transfer coefficient"
    annotation (Dialog(group = "Heat convection",
    descriptionLabel=true,
        enable=if calcMethodConvection == 3 then true else false));

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
  AixLib.Utilities.HeatTransfer.HeatToStar twoStar_RadEx(A=A, eps=eps)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,74})));
  Utilities.HeatTransfer.HeatConv_inside HeatConv(
    final A = A,
    final calcMethod = calcMethodConvection,
    final alpha_custom = convCoeffCustom,
    surfaceOrientation = if isFloor then 2 else 1)                 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={1.77636e-015,74})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermConvRoom
    annotation (Placement(transformation(extent={{-12,90},{8,110}})));
  AixLib.Utilities.Interfaces.Star starRad
    annotation (Placement(transformation(extent={{-38,92},{-18,112}})));
  HeatConductionSegment panel_Segment1(
    kA=kTop*A,
    mc_p=cTop*A,
    T0=T0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,30})));
  HeatConductionSegment panel_Segment2(
    T0=T0,
    kA=kDown*A,
    mc_p=cDown*A) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-12,-56})));
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
  connect(HeatConv.port_a, thermConvRoom) annotation (Line(
      points={{3.60822e-015,84},{3.60822e-015,92.5},{-2,92.5},{-2,100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(twoStar_RadEx.Star,starRad)
                                     annotation (Line(
      points={{-30,83.1},{-30,102},{-28,102}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(thermConvWall, thermConvWall) annotation (Line(
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
  connect(panel_Segment1.port_a, vol.heatPort) annotation (Line(
      points={{-16.9,20.9},{-16.9,2},{-14,2},{-14,-15}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panel_Segment2.port_b, thermConvWall) annotation (Line(
      points={{-11.1,-65.1},{-11.1,-81.55},{-12,-81.55},{-12,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(panel_Segment2.port_a, vol.heatPort) annotation (Line(
      points={{-11.1,-46.9},{-11.1,-31.45},{-14,-31.45},{-14,-15}},
      color={191,0,0},
      smooth=Smooth.None));
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
