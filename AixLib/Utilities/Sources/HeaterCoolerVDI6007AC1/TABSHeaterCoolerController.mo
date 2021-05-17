within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model tabsHeaterCoolerController
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam
    "Zone definition";
  parameter Modelica.SIunits.Time timeAverage = 24*3600
    "Time span used to calculate the average ambient air temperature";
  parameter Real power_Heater_Tabs = 0
    "Fixed available heating power of TABS"  annotation (Dialog(tab="Heater", enable=not recOrSep));
  parameter Real power_Cooler_Tabs = 0
    "Fixed available cooling power of TABS"  annotation (Dialog(tab="Cooler", enable=not recOrSep));
  parameter Real TThreshold_Heat_Tabs = 273.15 + 14
    "Threshold temperature below which heating is activated"  annotation (Dialog(tab="Heater", enable=not recOrSep));
  parameter Real TThreshold_Cool_Tabs = 273.15 + 18
    "Threshold temperature above which cooling is activated"  annotation (Dialog(tab="Cooler", enable=not recOrSep));
  parameter Boolean recOrSep = false "Use record if true or seperate parameters if false" annotation(choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));
  parameter Boolean tabsRoomTempControl = false "TABS room temperature control" annotation(choices(choice =  false
        "without room temperature control",choice = true "with room temperature control",radioButtons = true));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus" annotation (Placement(
    transformation(extent={{-111,75},{-77,107}}),iconTransformation(
    extent={{-92,28},{-62,58}})));

Modelica.Blocks.Sources.Constant TAirThresholdHeatingTabs(k=if not recOrSep then TThreshold_Heat_Tabs else zoneParam.TThresholdHeaterTabs)
    "Threshold temperature below which heating is activated" annotation (Placement(transformation(extent={{-86,6},{-74,18}})));
  Modelica.Blocks.Logical.Less less
  "check if outside temperature below threshold" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-42,20})));
  Modelica.Blocks.Logical.Greater greater
  "check if outside temperature above threshold" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-42,-20})));
Modelica.Blocks.Sources.Constant TAirThresholdCoolingTabs(k=if not recOrSep then TThreshold_Cool_Tabs else zoneParam.TThresholdCoolerTabs)
    "Threshold temperature above which cooling is activated" annotation (Placement(transformation(extent={{-86,-34},{-74,-22}})));
  Math.MovingAverage movingAverageTOutdoor(aveTime=timeAverage)
    "Calculates the moving average of ambient air temperature"
    annotation (Placement(transformation(extent={{-88,58},{-70,76}})));
  Modelica.Blocks.Logical.Switch switchHeater annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Logical.Switch switchCooler annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Blocks.Sources.Constant off(k=0) annotation (Placement(transformation(extent={{-16,-6},{-2,8}})));
  Modelica.Blocks.Interfaces.RealOutput tabsHeatingPower "Power for heating"
    annotation (Placement(transformation(extent={{100,10},
          {120,30}}),      iconTransformation(extent={{72,10},{92,30}})));
  Modelica.Blocks.Interfaces.RealOutput tabsCoolingPower "Power for cooling"
    annotation (Placement(transformation(extent={{100,-30},
          {120,-10}}),       iconTransformation(extent={{72,-30},{92,-10}})));
  Modelica.Blocks.Interaction.Show.BooleanValue heaterActive
    "true if heater is active" annotation (Placement(transformation(extent={{-28,80},
            {-8,100}})));
  Modelica.Blocks.Interaction.Show.BooleanValue coolerActive
    "true if cooler is active" annotation (Placement(transformation(extent={{-22,-98},
            {-2,-78}})));

  // Room temperature control
  Modelica.Blocks.Interfaces.RealInput TOpe if ((recOrSep and zoneParam.withTabsRoomTempControl) or (not recOrSep
     and tabsRoomTempControl)) "Operative indoor air temperature"
    annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={2,108}), iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={2,108})));
  Modelica.Blocks.Logical.Hysteresis hysteresisHeating(
    uLow=273.15 + 21.1,
    uHigh=273.15 + 22,
    pre_y_start=true) if ((recOrSep and zoneParam.withTabsRoomTempControl) or (not recOrSep
     and tabsRoomTempControl)) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={40,66})));
  Modelica.Blocks.Logical.Switch switchHeater1 if ((recOrSep and zoneParam.withTabsRoomTempControl) or (not recOrSep
     and tabsRoomTempControl))
    annotation (Placement(transformation(extent={{68,32},{88,52}})));
  Math.MovingAverage movingAverageTOpe(aveTime=timeAverage) if
                                                            ((recOrSep and zoneParam.withTabsRoomTempControl) or (not recOrSep
     and tabsRoomTempControl))
    "Calculates the moving average of operative indoor air temperature"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={22,92})));
  Modelica.Blocks.Logical.Switch switchCooler1 if ((recOrSep and zoneParam.withTabsRoomTempControl) or (not recOrSep
     and tabsRoomTempControl))
    annotation (Placement(transformation(extent={{68,-52},{88,-32}})));
  Modelica.Blocks.Logical.Hysteresis hysteresisCooling(
    uLow=273.15 + 22,
    uHigh=273.15 + 24,
    pre_y_start=false) if ((recOrSep and zoneParam.withTabsRoomTempControl) or (not recOrSep
     and tabsRoomTempControl)) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={20,66})));
  tabsHeatingCurve tabs_HeatingCurve(
    power_high=if not recOrSep then power_Heater_Tabs else zoneParam.powerHeatTabs,
    T_upperlimit=273.15 + 15,
    T_lowerlimit=273.15 + 0)
    annotation (Placement(transformation(extent={{-12,32},{8,52}})));

  tabsHeatingCurve tabsCoolingCurve(
    power_high=if not recOrSep then power_Cooler_Tabs else zoneParam.powerCoolTabs,
    T_upperlimit=273.15 + 25,
    T_lowerlimit=273.15 + 18,
    heatingOrCooling=false)
    annotation (Placement(transformation(extent={{-18,-56},{2,-36}})));

equation

  connect(TAirThresholdHeatingTabs.y, less.u2) annotation (Line(points={{-73.4,12},{-54,12}}, color={0,0,127}));
  connect(TAirThresholdCoolingTabs.y, greater.u2) annotation (Line(points={{-73.4,-28},{-54,-28}}, color={0,0,127}));
  connect(weaBus.TDryBul, movingAverageTOutdoor.u) annotation (Line(
      points={{-94,91},{-94,67},{-89.8,67}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(movingAverageTOutdoor.y, less.u1) annotation (Line(points={{-69.1,67},
          {-69.1,68},{-66,68},{-66,20},{-54,20}}, color={0,0,127}));
  connect(movingAverageTOutdoor.y, greater.u1) annotation (Line(points={{-69.1,
          67},{-69.1,68},{-66,68},{-66,-20},{-54,-20}}, color={0,0,127}));
  connect(off.y, switchHeater.u3) annotation (Line(points={{-1.3,1},{8,1},{8,12},
          {18,12}},     color={0,0,127}));
  connect(off.y, switchCooler.u3) annotation (Line(points={{-1.3,1},{8,1},{8,
          -28},{18,-28}}, color={0,0,127}));
  connect(less.y, heaterActive.activePort) annotation (Line(points={{-31,20},{-29.5,
          20},{-29.5,90}}, color={255,0,255}));
  connect(less.y, switchHeater.u2) annotation (Line(points={{-31,20},{18,20}}, color={255,0,255}));
  connect(greater.y, switchCooler.u2) annotation (Line(points={{-31,-20},{18,-20}}, color={255,0,255}));
  connect(coolerActive.activePort, greater.y) annotation (Line(points={{-23.5,-88},
          {-26,-88},{-26,-20},{-31,-20}}, color={255,0,255}));

  if ((recOrSep and zoneParam.withTabsRoomTempControl) or (not recOrSep
     and tabsRoomTempControl)) then
  connect(hysteresisHeating.y, switchHeater1.u2) annotation (Line(points={{40,59.4},{40,42},{66,42}}, color={255,0,255}));
    connect(TOpe, movingAverageTOpe.u) annotation (Line(points={{2,108},{1.5,
            108},{1.5,92},{14.8,92}}, color={0,0,127}));
    connect(movingAverageTOpe.y, hysteresisHeating.u)
      annotation (Line(points={{28.6,92},{40,92},{40,73.2}}, color={0,0,127}));
  connect(switchHeater1.y, tabsHeatingPower) annotation (Line(points={{89,42},{
          94,42},{94,20},{110,20}}, color={0,0,127}));
  connect(off.y, switchCooler1.u3) annotation (Line(points={{-1.3,1},{8,1},{8,
          -50},{66,-50}}, color={0,0,127}));
  connect(switchCooler.y, switchCooler1.u1) annotation (Line(points={{41,-20},{
          52,-20},{52,-34},{66,-34}}, color={0,0,127}));
    connect(movingAverageTOpe.y, hysteresisCooling.u) annotation (Line(points={
            {28.6,92},{30,92},{30,78},{20,78},{20,73.2}}, color={0,0,127}));
  connect(hysteresisCooling.y, switchCooler1.u2) annotation (Line(points={{20,
          59.4},{20,36},{48,36},{48,-42},{66,-42}}, color={255,0,255}));
  connect(switchCooler1.y, tabsCoolingPower) annotation (Line(points={{89,-42},
          {94,-42},{94,-20},{110,-20}}, color={0,0,127}));
  connect(switchHeater.y, switchHeater1.u3) annotation (Line(points={{41,20},{54,
          20},{54,34},{66,34}}, color={0,0,127}));
  connect(off.y, switchHeater1.u1) annotation (Line(points={{-1.3,1},{56,1},{56,
          50},{66,50}}, color={0,0,127}));
  else
  connect(switchCooler.y, tabsCoolingPower) annotation (Line(
      points={{41,-20},{110,-20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(switchHeater.y, tabsHeatingPower) annotation (Line(
      points={{41,20},{110,20}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  end if;

  connect(tabs_HeatingCurve.powerOutput, switchHeater.u1) annotation (Line(
        points={{9,42},{12,42},{12,28},{18,28}}, color={0,0,127}));
  connect(movingAverageTOutdoor.y, tabs_HeatingCurve.tDryBul) annotation (Line(
        points={{-69.1,67},{-40.55,67},{-40.55,42},{-12,42}}, color={0,0,127}));
  connect(tabsCoolingCurve.powerOutput, switchCooler.u1) annotation (Line(
        points={{3,-46},{4,-46},{4,-12},{18,-12}}, color={0,0,127}));
  connect(movingAverageTOutdoor.y, tabsCoolingCurve.tDryBul)
    annotation (Line(points={{-69.1,67},{-18,67},{-18,-46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  This is a simple controller which sets a threshold for heating and
  cooling based on the moving average of the outside temperature. 
</p>
<p>
  Use multiples of 3600 for <span style=\"font-family: Courier New;\">timeAverage</span> to 
  calculate the moving average of the ambient air temperature.
</p>
<h4>
<span style=\"color: #008000\">Future improvements</span>
</h4>
<p>
In the future the option to use a heating curve instead of a fixed power limit 
could be added.
</p>

</html>",
        revisions="<html><ul>
  <li>
  <i>March, 2021&#160;</i> by Christian Wenzel:<br/>
    First implementation
  </li>
</ul>
</html>"));
end tabsHeaterCoolerController;
