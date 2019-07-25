within AixLib.Building.Components.WindowsDoors;
model Window_ASHRAE140
  "Window with transmission correction factor, modelling of window panes"
  extends AixLib.Building.Components.WindowsDoors.BaseClasses.PartialWindow;

//  parameter Modelica.SIunits.Area windowarea=2 "Total fenestration area";
  parameter Real windowarea=2 "Total fenestration area";
    parameter Modelica.SIunits.Temperature T0= 293.15 "Initial temperature";
  parameter Boolean selectable = true "Select window type" annotation (Dialog(group="Window type", descriptionLabel = true));
  parameter AixLib.DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType=
      AixLib.DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "Window type"
    annotation (Dialog(
      group="Window type",
      enable=selectable,
      descriptionLabel=true), choicesAllMatching=true);
  parameter Real frameFraction(max=1.0) = if selectable then WindowType.frameFraction else 0.2
    "Frame fraction"                                                                                            annotation (Dialog(group="Window type", enable = not selectable, descriptionLabel = true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw=if selectable then WindowType.Uw else 1.50
    "Thermal transmission coefficient of whole window"                                                                                                 annotation (Dialog(group="Window type", enable = not selectable));

  parameter Real g= if selectable then WindowType.g else 0.60
    "Coefficient of solar energy transmission"                                                            annotation (Dialog(group="Window type", enable = not selectable));
  parameter Real eps_out=0.9 "emissivity of the outer surface"
                                       annotation(Dialog(group = "Outside surface", enable = outside));
                                       parameter Real phi= 90
    "surface tilted angle in [degree]"                                                           annotation(Dialog(group = "Outside surface", enable = outside));

  BaseClasses.CorrectionSolarGain.CorG_VDI6007
    RadCondAdapt(Uw=Uw) annotation (Placement(transformation(extent={{-52,48},{
            -30,72}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
                              AirGap(G=windowarea*6.297)    annotation (
      Placement(transformation(extent={{-10,-20},{10,0}})));
  Utilities.HeatTransfer.HeatConv_outside
                                        heatConv_outside(
A=windowarea,
Model=2,
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Glass())
annotation (Placement(transformation(extent={{-66,-20},{-46,0}})));
  Utilities.HeatTransfer.HeatConv_inside
                                       heatConv_inside(
calcMethod=2,
alpha_custom=2,
A=windowarea)
annotation (Placement(transformation(extent={{68,-20},{48,2}})));
  AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer                     pane1(
n=1,
lambda={1.06},
c={750},
d={0.003175},
rho={2500},
A=windowarea,
T0=T0)
annotation (Placement(transformation(extent={{-38,-18},{-18,2}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort
annotation (Placement(transformation(extent={{-116,-76},{-82,-42}}),
    iconTransformation(extent={{-100,-60},{-80,-40}})));
  Utilities.HeatTransfer.HeatToStar
                                  twoStar_RadEx(
Therm(T(start=T0)),
Star(T(start=T0)),
eps=WindowType.Emissivity,
A=windowarea)              annotation (Placement(transformation(extent={{36,22},
        {56,42}})));
  AixLib.Building.Components.Walls.BaseClasses.SimpleNLayer pane2(
n=1,
lambda={1.06},
c={750},
d={0.003175},
rho={2500},
T0=T0,
A=windowarea)
annotation (Placement(transformation(extent={{18,-18},{38,2}})));
  Modelica.Blocks.Math.Gain Ag(k=(1 - frameFraction)*windowarea*g)
    "multiplication with area and solar gain factor"
    annotation (Placement(transformation(extent={{-4,54},{8,66}})));
  Modelica.Blocks.Interfaces.RealOutput solarRadWinTrans
    "Output signal connector"
    annotation (Placement(transformation(extent={{82,70},{102,90}})));
equation
  connect(heatConv_outside.WindSpeedPort, WindSpeedPort) annotation (Line(
  points={{-65.2,-17.2},{-80,-17.2},{-80,-59},{-99,-59}},
  color={0,0,127}));
  connect(heatConv_outside.port_b, pane1.port_a) annotation (Line(
  points={{-46,-10},{-46,-8},{-38,-8}},
  color={191,0,0}));
  connect(pane2.port_b, heatConv_inside.port_b) annotation (Line(
  points={{38,-8},{44,-8},{44,-9},{48,-9}},
  color={191,0,0}));
  connect(twoStar_RadEx.Therm, pane2.port_b) annotation (Line(
  points={{36.8,32},{36,32},{36,-8},{38,-8}},
  color={191,0,0}));
  connect(Ag.y, solarRadWinTrans) annotation (Line(
      points={{8.6,60},{50,60},{50,80},{92,80}},
      color={0,0,127}));
  connect(RadCondAdapt.solarRadWinTrans[1], Ag.u) annotation (Line(
      points={{-31.1,60},{-5.2,60}},
      color={0,0,127}));
  connect(pane1.port_b, AirGap.port_a) annotation (Line(
      points={{-18,-8},{-15.5,-8},{-15.5,-10},{-10,-10}},
      color={191,0,0}));
  connect(AirGap.port_b, pane2.port_a) annotation (Line(
      points={{10,-10},{14,-10},{14,-8},{18,-8}},
      color={191,0,0}));
  connect(port_outside, heatConv_outside.port_a) annotation (Line(
      points={{-90,-10},{-66,-10}},
      color={191,0,0}));
  connect(heatConv_inside.port_a, port_inside) annotation (Line(
      points={{68,-9},{78,-9},{78,-10},{90,-10}},
      color={191,0,0}));
  connect(twoStar_RadEx.Star, Star) annotation (Line(
      points={{55.1,32},{80,32},{80,60},{90,60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(solarRad_in, RadCondAdapt.SR_input[1]) annotation (Line(
      points={{-90,60},{-72,60},{-72,59.88},{-51.78,59.88}},
      color={255,128,0}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
      Line(
        points={{-66,18},{-62,18}},
        color={255,255,0}),
      Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),
      Rectangle(
        extent={{-80,80},{80,-80}},
        lineColor={0,0,255},
         pattern=LinePattern.None,
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-4,42},{10,-76}},
        lineColor={0,0,255},
         pattern=LinePattern.None,
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-76,46},{74,38}},
        lineColor={0,0,255},
         pattern=LinePattern.None,
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Line(
        points={{2,40},{2,-76},{76,-76},{76,40},{2,40}}),
      Line(
        points={{-76,40},{-76,-76},{-2,-76},{-2,40},{-76,40}}),
      Line(
        points={{-76,76},{-76,44},{76,44},{76,76},{-76,76}}),
      Rectangle(
        extent={{4,-8},{6,-20}},
        lineColor={0,0,0},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-72,72},{-72,48},{72,48},{72,72},{-72,72}}),
      Rectangle(
        extent={{-72,72},{72,48}},
        lineColor={0,0,0},
        fillColor={211,243,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{10,36},{72,-72}},
        lineColor={0,0,0},
        fillColor={211,243,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-72,36},{-8,-72}},
        lineColor={0,0,0},
        fillColor={211,243,255},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-8,36},{-8,-72},{-72,-72},{-72,36},{-8,36}}),
      Line(
        points={{72,36},{72,-72},{10,-72},{10,36},{72,36}}),
      Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}),
    Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>The <b>WindowSimple</b> model represents a window described by the thermal transmission coefficient and the coefficient of solar energy transmission( with correction factors). </p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>Phenomena being simulated: </p>
<ul>
<li>Solar energy transmission through the glass</li>
<li>Heat transmission through the whole window</li>
</ul>
<h4><font color=\"#008000\">References</font></h4>
<p>Exemplary U-Values for windows from insulation standards</p>
<ul>
<li>WschV 1984: specified &quot;two panes&quot; assumed 2,5 W/m2K</li>
<li>WschV 1995: 1,8 W/m2K</li>
<li>EnEV 2002: 1,7 W/m2K</li>
<li>EnEV 2009: 1,3 W/m2K</li>
</ul>
</html>",
 revisions="<html>
 <ul>
 <li><i>March 30, 2015&nbsp;</i> by Ana Constantin:Improved implementation of transmitted solar radiation<br/></li>
 <li><i>February 24, 2014&nbsp;</i> by Reza Tavakoli:<br/>First implementation</li>
</ul>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(extent={{-80,80},{80,-80}},
            lineColor={0,0,0})}));
end Window_ASHRAE140;
