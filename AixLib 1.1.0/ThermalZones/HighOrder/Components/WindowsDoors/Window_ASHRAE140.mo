within AixLib.ThermalZones.HighOrder.Components.WindowsDoors;
model Window_ASHRAE140
  "Window with transmission correction factor, modelling of window panes"
  extends AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow(
    redeclare replaceable model CorrSolGain = BaseClasses.CorrectionSolarGain.CorG_ASHRAE140,
    final use_solarRadWinTrans=true,
    final use_windSpeedPort=true);

  replaceable parameter AixLib.DataBase.WindowsDoors.ASHRAE140WithPanes.Default
    winPaneRec constrainedby AixLib.DataBase.Walls.WallBaseDataDefinition "Record containing parameters of window pane(s)"
    annotation (choicesAllMatching=true, Placement(transformation(extent={{-8,82},{8,98}})));

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
                              AirGap(G=windowarea*6.297)    annotation (
      Placement(transformation(extent={{-10,-20},{10,0}})));
  Utilities.HeatTransfer.HeatConvOutside heatConv_outside(
    final A=windowarea,
    calcMethod=2,
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Glass()) annotation (Placement(transformation(extent={{-66,-20},{-46,0}})));
  Utilities.HeatTransfer.HeatConvInside heatConv_inside(
    calcMethod=2,
    hCon_const=2,
    final A=windowarea)
                  annotation (Placement(transformation(extent={{68,-20},{48,2}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer pane1(
    final wallRec=winPaneRec,
    final T_start=fill(T0, winPaneRec.n),
    final energyDynamics=energyDynamics,
    final A=windowarea)
           annotation (Placement(transformation(extent={{-38,-18},{-18,2}})));
  Utilities.HeatTransfer.HeatToRad twoStar_RadEx(final eps=winPaneRec.eps, final A=windowarea)
    annotation (Placement(transformation(extent={{44,22},{64,42}})));
  AixLib.ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer pane2(
    final wallRec=winPaneRec,
    final T_start=fill(T0, winPaneRec.n),
    final A=windowarea,
    final energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{18,-18},{38,2}})));
  Modelica.Blocks.Sources.Constant constFixShoRadPar[6](k={WindowType.g,1 -
        WindowType.g,0,sqrt(windowarea),sqrt(windowarea),0}) if
    use_solarRadWinTrans
    "Parameteres used for the short radiaton models. See connections to check which array corresponds to which parameter"
    annotation (Placement(transformation(extent={{68,96},{78,106}})));
equation
  connect(heatConv_outside.port_b, pane1.port_a) annotation (Line(
  points={{-46,-10},{-46,-8},{-38,-8}},
  color={191,0,0}));
  connect(pane2.port_b, heatConv_inside.port_b) annotation (Line(
  points={{38,-8},{44,-8},{44,-9},{48,-9}},
  color={191,0,0}));
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
  connect(twoStar_RadEx.radPort, radPort) annotation (Line(
      points={{64.1,32},{80,32},{80,60},{90,60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(pane2.port_b, twoStar_RadEx.convPort) annotation (Line(points={{38,-8},{42,-8},{42,32},{44,32}}, color={191,0,0}));
  connect(WindSpeedPort, heatConv_outside.WindSpeedPort) annotation (Line(points={{-99,-59},{-70,-59},{-70,-17},{-65,-17}}, color={0,0,127}));
  connect(solarRad_in, corrSolGain.SR_input[1]) annotation (Line(points={{-90,60},{-70,60},{-70,59.9},{-49.8,59.9}}, color={255,128,0}));
  connect(corrSolGain.solarRadWinTrans[1], Ag.u) annotation (Line(points={{-31,60},{-17.2,60}}, color={0,0,127}));
  connect(Ag.y, shortRadWin.Q_flow_ShoRadFroSur) annotation (Line(points={{-3.4,60},{50,60},{50,88.05},{90.05,88.05}},
                                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constFixShoRadPar[1].y, shortRadWin.g) annotation (Line(points={{78.5,
          101},{90.05,101},{90.05,88.05}}, color={0,0,127}));
  connect(constFixShoRadPar[2].y, shortRadWin.solar_absorptance) annotation (
      Line(points={{78.5,101},{90.05,101},{90.05,88.05}}, color={0,0,127}));
  connect(constFixShoRadPar[3].y, shortRadWin.solar_reflectance) annotation (
      Line(points={{78.5,101},{90.05,101},{90.05,88.05}}, color={0,0,127}));
  connect(constFixShoRadPar[4].y, shortRadWin.length) annotation (Line(points={
          {78.5,101},{90.05,101},{90.05,88.05}}, color={0,0,127}));
  connect(constFixShoRadPar[5].y, shortRadWin.height) annotation (Line(points={
          {78.5,101},{90.05,101},{90.05,88.05}}, color={0,0,127}));
  connect(constFixShoRadPar[6].y, shortRadWin.Q_flow_ShoRadOnSur) annotation (
      Line(points={{78.5,101},{90.05,101},{90.05,88.05}}, color={0,0,127}));
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
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>WindowSimple</b> model represents a window described by the
  thermal transmission coefficient and the coefficient of solar energy
  transmission( with correction factors).
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Phenomena being simulated:
</p>
<ul>
  <li>Solar energy transmission through the glass
  </li>
  <li>Heat transmission through the whole window
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Exemplary U-Values for windows from insulation standards
</p>
<ul>
  <li>WschV 1984: specified \"two panes\" assumed 2,5 W/m2K
  </li>
  <li>WschV 1995: 1,8 W/m2K
  </li>
  <li>EnEV 2002: 1,7 W/m2K
  </li>
  <li>EnEV 2009: 1,3 W/m2K
  </li>
</ul>
</html>",
 revisions="<html><ul>
  <li>
    <i>June, 18, 2020</i> by Fabian Wuellhorst:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/918\">#918</a>:
    Add short wave connector to pass window parameters.
  </li>
  <li>
    <i>April 23, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/752\">#752</a>:
    Add records for window panes.
  </li>
  <li>
    <i>November 11, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    Removed parameters phi and eps_out. This is for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/651\">#651</a>.
  </li>
  <li>
    <i>March 30, 2015&#160;</i> by Ana Constantin:<br/>
    Improved implementation of transmitted solar radiation
  </li>
  <li>
    <i>February 24, 2014&#160;</i> by Reza Tavakoli:<br/>
    First implementation
  </li>
</ul>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(extent={{-80,80},{80,-80}},
            lineColor={0,0,0})}));
end Window_ASHRAE140;
