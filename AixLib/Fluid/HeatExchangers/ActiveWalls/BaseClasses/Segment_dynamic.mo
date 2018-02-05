within AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses;
model Segment_dynamic
  "heat tranfer coefficient changes according to operation mode"

extends Modelica.Fluid.Interfaces.PartialTwoPort;

parameter Boolean Floor = true;

parameter Modelica.SIunits.Area A = 10 "Area of Floor part";

parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity";

parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius";

parameter Modelica.SIunits.Volume Watervolume = 0.02 "Volume of Water in m^3";

parameter Modelica.SIunits.CoefficientOfHeatTransfer k_top[2];
parameter Modelica.SIunits.CoefficientOfHeatTransfer k_down[2];

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
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                           ThermDown
    annotation (Placement(transformation(extent={{-24,-104},{-4,-84}})));
  AixLib.Utilities.HeatTransfer.HeatToStar twoStar_RadEx(A=A, eps=eps)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,74})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                           ThermTop
    annotation (Placement(transformation(extent={{-10,84},{12,106}})));
  AixLib.Utilities.Interfaces.Star StarTop
    annotation (Placement(transformation(extent={{-38,92},{-18,112}})));
  HeatTransfer_dynamic Segment_top(
    T0=T0,
    mc_p=C_top*A,
    kA_up=k_top[1]*A,
    kA_down=k_top[2]*A) annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-14,29})));
  HeatTransfer_dynamic Segment_bottom(
    T0=T0,
    mc_p=C_down*A,
    kA_up=k_down[1]*A,
    kA_down=k_down[2]*A)
                   annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-15,-55})));
  Utilities.HeatTransfer.HeatConv_inside            heatConv_inside(
    A=A,
    surfaceOrientation=if Floor then 2 else 3,
    alpha_custom=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={4,70})));
equation

   if (Floor and t_flow.T > ThermTop.T) or ((not Floor) and t_flow.T < ThermTop.T) then // heat flow goes up as in the case of floor heating ad ceiling cooling
    Segment_top.IsUp = true;
    Segment_bottom.IsUp = true;
   else
    Segment_top.IsUp = false;
    Segment_bottom.IsUp = false;
   end if;

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
  connect(twoStar_RadEx.Star, StarTop)
                                     annotation (Line(
      points={{-30,83.1},{-30,102},{-28,102}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(ThermDown, Segment_bottom.port_a) annotation (Line(
      points={{-14,-94},{-15,-94},{-15,-65.34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Segment_bottom.port_b, Volume.heatPort) annotation (Line(
      points={{-15,-44.88},{-15,-30.44},{-14,-30.44},{-14,-15}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Volume.heatPort, Segment_top.port_a) annotation (Line(
      points={{-14,-15},{-14,18.66}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Segment_top.port_b, twoStar_RadEx.Therm) annotation (Line(
      points={{-14,39.12},{-22,39.12},{-22,64.8},{-30,64.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Segment_top.port_b, heatConv_inside.port_b) annotation (Line(
      points={{-14,39.12},{6,39.12},{6,60},{4,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatConv_inside.port_a, ThermTop) annotation (Line(
      points={{4,80},{6,80},{6,95},{1,95}},
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
<li><i>August 03, 2014&nbsp;</i> by Ana Constantin:<br/>
Implemented.</li>
</ul>
</html>"));
end Segment_dynamic;
