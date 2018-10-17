within AixLib.ThermalZones.HighOrder.Components.WindowsDoors;
model WindowSimple "Window with radiation and U-Value"
  //  parameter Modelica.SIunits.Area windowarea=2 "Total fenestration area";
  parameter Modelica.SIunits.Area windowarea=2 "Total fenestration area";
  parameter Modelica.SIunits.Temperature T0=293.15 "Initial temperature";
  parameter Boolean selectable=true "Select window type"
    annotation (Dialog(group="Window type", descriptionLabel=true));
  parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple WindowType=
     DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009() "Window type"
    annotation (Dialog(
      group="Window type",
      enable=selectable,
      descriptionLabel=true), choicesAllMatching=true);
  parameter Real frameFraction(
    min=0.0,
    max=1.0) = if selectable then WindowType.frameFraction else 0.2
    "Frame fraction" annotation (Dialog(
      group="Window type",
      enable=not selectable,
      descriptionLabel=true));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer Uw=if selectable then
      WindowType.Uw else 1.50
    "Thermal transmission coefficient of whole window"
    annotation (Dialog(group="Window type", enable=not selectable));
  parameter Real g=if selectable then WindowType.g else 0.60
    "Coefficient of solar energy transmission"
    annotation (Dialog(group="Window type", enable=not selectable));

  replaceable model correctionSolarGain =
      BaseClasses.CorrectionSolarGain.NoCorG constrainedby
    BaseClasses.CorrectionSolarGain.PartialCorG
    "Model for correction of solar gain factor" annotation (Dialog(
        descriptionLabel=true), choicesAllMatching=true);
  Utilities.Interfaces.SolarRad_in solarRad_in
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  correctionSolarGain corG(
    final Uw=Uw,
    final n=1)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Utilities.HeatTransfer.HeatToStar twoStar_RadEx(
    Therm(T(start=T0)),
    Star(T(start=T0)),
    final A=(1 - frameFraction)*windowarea,
    final eps=WindowType.Emissivity)
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Utilities.Interfaces.Star Star
    annotation (Placement(transformation(extent={{80,50},{100,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_outside
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatTrans(
    final G=windowarea*Uw)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_inside
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Math.Gain Ag(
    final k(unit="m2", min=0.0) = (1 - frameFraction)*windowarea*g)
    annotation (Placement(transformation(extent={{-16,54},{-4,66}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{2,50},{22,70}})));
equation
  connect(twoStar_RadEx.Star, Star)
    annotation (Line(points={{49.1,60},{90,60}}, pattern=LinePattern.Solid));
  connect(port_outside, HeatTrans.port_a)
    annotation (Line(points={{-90,-10},{-49.5,-10},{-10,-10}}));
  connect(HeatTrans.port_b, port_inside)
    annotation (Line(points={{10,-10},{10,-10},{90,-10}}));
  connect(corG.SR_input[1], solarRad_in)
    annotation (Line(points={{-49.8,59.9},{
          -66.9,59.9},{-66.9,60},{-90,60}}, color={255,128,0}));
  connect(corG.solarRadWinTrans[1], Ag.u)
    annotation (Line(points={{-31,60},{-17.2,60}}, color={0,0,127}));
  connect(Ag.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-3.4,60},{2,60}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, twoStar_RadEx.Therm)
    annotation (Line(points={{22,60},{30.8,60}}, color={191,0,0}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-66,18},{-62,18}}, color={255,255,0}),
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
        Line(points={{2,40},{2,-76},{76,-76},{76,40},{2,40}}, color={0,0,0}),
        Line(points={{-76,40},{-76,-76},{-2,-76},{-2,40},{-76,40}}, color={0,0,0}),
        Line(points={{-76,76},{-76,44},{76,44},{76,76},{-76,76}}, color={0,0,0}),
        Rectangle(
          extent={{4,-8},{6,-20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{-72,72},{-72,48},{72,48},{72,72},{-72,72}}, color={0,0,0}),
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
        Line(points={{-8,36},{-8,-72},{-72,-72},{-72,36},{-8,36}}, color={0,0,0}),
        Line(points={{72,36},{72,-72},{10,-72},{10,36},{72,36}}, color={0,0,0}),
        Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}),
    Documentation(info="<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>WindowSimple</b> model represents a window described by the thermal transmission coefficient and the coefficient of solar energy transmission. </p>
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
 <h4><font color=\"#008000\">Example Results</font></h4>
 <p><a href=\"AixLib.Building.Components.Examples.WindowsDoors.WindowSimple\">AixLib.Building.Components.Examples.WindowsDoors.WindowSimple</a></p>
 </html>", revisions="<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
 <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
 <li><i>March 30, 2012&nbsp;</i> by Ana Constantin and Corinna Leonhardt:<br/>Implemented.</li>
 </ul>
 </html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(extent={{-80,80},{80,-80}}, lineColor={
              0,0,0})}));
end WindowSimple;
