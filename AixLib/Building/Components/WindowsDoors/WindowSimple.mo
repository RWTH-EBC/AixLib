within AixLib.Building.Components.WindowsDoors;
model WindowSimple "Window with radiation and U-Value"

//  parameter Modelica.SIunits.Area windowarea=2 "Total fenestration area";
  parameter Real windowarea=2 "Total fenestration area";
    parameter Modelica.SIunits.Temperature T0= 293.15 "Initial temperature";
  parameter Boolean selectable = true "Select window type" annotation (Dialog(group="Window type", descriptionLabel = true));
  parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple
WindowType=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "Window type"
              annotation (Dialog(
  group="Window type",
  enable=selectable,
  descriptionLabel=true));
  parameter Real frameFraction(max=1.0) = if selectable then WindowType.frameFraction else 0.2
    "Frame fraction"
                 annotation (Dialog(
  group="Window type",
  enable=not selectable,
  descriptionLabel=true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw=if selectable then WindowType.Uw else 1.50
    "Thermal transmission coefficient of whole window"
annotation (Dialog(group="Window type", enable=not selectable));

  parameter Real g= if selectable then WindowType.g else 0.60
    "Coefficient of solar energy transmission"
annotation (Dialog(group="Window type", enable=not selectable));

  Utilities.Interfaces.SolarRad_in solarRad_in annotation (Placement(
    transformation(extent={{-100,50},{-80,70}}, rotation=0)));
  Utilities.HeatTransfer.SolarRadToHeat RadCondAdapt(coeff=g, A=
    windowarea*(1 - frameFraction)) annotation (Placement(
    transformation(extent={{-50,52},{-30,72}}, rotation=0)));
  Utilities.HeatTransfer.HeatToStar twoStar_RadEx(
Therm(T(start=T0)),
Star(T(start=T0)),
A=(1 - frameFraction)*windowarea,
eps=WindowType.Emissivity) annotation (Placement(transformation(
      extent={{30,50},{50,70}}, rotation=0)));
  Utilities.Interfaces.Star Star annotation (Placement(transformation(
      extent={{80,50},{100,70}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside
annotation (Placement(transformation(extent={{-100,-20},{-80,0}},
      rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatTrans(
  G=windowarea*Uw) annotation (Placement(transformation(extent={{-10,-20},
        {10,0}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_inside
annotation (
 Placement(transformation(extent={{80,-20},{100,0}}, rotation=0)));
equation
  connect(RadCondAdapt.heatPort, twoStar_RadEx.Therm)
annotation (Line(points={{-31,60},{30.8,60}}));
  connect(solarRad_in, RadCondAdapt.solarRad_in)
annotation (Line(points={{-90,60},{-50.1,60}}, color={0,0,0}));
  connect(twoStar_RadEx.Star,Star)
    annotation (Line(points={{49.1,60},{90,60}}, pattern=LinePattern.None));
  connect(port_outside, HeatTrans.port_a)
annotation (Line(points={{-90,-10},{-49.5,-10},{-10,-10}}));
  connect(HeatTrans.port_b, port_inside)
annotation (Line(points={{10,-10},{10,-10},{90,-10}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
      Line(
        points={{-66,18},{-62,18}},
        color={255,255,0},
        smooth=Smooth.None),
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
        points={{2,40},{2,-76},{76,-76},{76,40},{2,40}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{-76,40},{-76,-76},{-2,-76},{-2,40},{-76,40}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{-76,76},{-76,44},{76,44},{76,76},{-76,76}},
        color={0,0,0},
        smooth=Smooth.None),
      Rectangle(
        extent={{4,-8},{6,-20}},
        lineColor={0,0,0},
        fillColor={215,215,215},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-72,72},{-72,48},{72,48},{72,72},{-72,72}},
        color={0,0,0},
        smooth=Smooth.None),
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
        points={{-8,36},{-8,-72},{-72,-72},{-72,36},{-8,36}},
        color={0,0,0},
        smooth=Smooth.None),
      Line(
        points={{72,36},{72,-72},{10,-72},{10,36},{72,36}},
        color={0,0,0},
        smooth=Smooth.None),
      Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}),
    Window(
      x=0.26,
      y=0.21,
      width=0.49,
      height=0.55),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>The <b>WindowSimple</b> model represents a window described by the thermal transmission coefficient and the coefficient of solar energy transmission. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Phenomena being simulated: </p>
<p><ul>
<li>Solar energy transmission through the glass</li>
<li>Heat transmission through the whole window</li>
</ul></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Exemplary U-Values for windows from insulation standards</p>
<p><ul>
<li>WschV 1984: specified &QUOT;two panes&QUOT; assumed 2,5 W/m2K</li>
<li>WschV 1995: 1,8 W/m2K</li>
<li>EnEV 2002: 1,7 W/m2K</li>
<li>EnEV 2009: 1,3 W/m2K</li>
</ul></p>
<p><h4><font color=\"#008000\">Example Results</font></h4></p>
<p><a href=\"AixLib.Building.Components.Examples.WindowsDoors.WindowSimple\">AixLib.Building.Components.Examples.WindowsDoors.WindowSimple</a></p>
</html>",
 revisions="<html>
<p><ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>March 30, 2012&nbsp;</i> by Ana Constantin and Corinna Leonhardt:<br/>Implemented.</li>
</ul></p>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(extent={{-80,80},{80,-80}},
            lineColor={0,0,0})}),
    DymolaStoredErrors);
end WindowSimple;
