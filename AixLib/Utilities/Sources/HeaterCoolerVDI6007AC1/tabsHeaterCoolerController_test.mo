within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model tabsHeaterCoolerController_test
  parameter Modelica.SIunits.Time timeAverage = 24*3600
    "Time span used to calculate the average ambient air temperature";
  parameter Real power_Heater_Tabs = 1000
    "Fixed available heating power of TABS"  annotation (Dialog(tab="Heater", enable=not recOrSep));
  parameter Real power_Cooler_Tabs = 500
    "Fixed available cooling power of TABS"  annotation (Dialog(tab="Cooler", enable=not recOrSep));
  parameter Real TThreshold_Heat_Tabs = 273.15 + 14
    "Threshold temperature below which heating is activated"  annotation (Dialog(tab="Heater", enable=not recOrSep));
  parameter Real TThreshold_Cool_Tabs = 273.15 + 20
    "Threshold temperature above which cooling is activated"  annotation (Dialog(tab="Cooler", enable=not recOrSep));
  parameter Boolean recOrSep = false "Use record if true or seperate parameters if false" annotation(choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));

Modelica.Blocks.Sources.Constant TAirThresholdHeatingTabs(k=TThreshold_Heat_Tabs)
    "Threshold temperature below which heating is activated"
    annotation (Placement(transformation(extent={{-86,6},{-74,18}})));
  Modelica.Blocks.Logical.Less less
  "check if outside temperature below threshold"
                                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-42,20})));
  Modelica.Blocks.Logical.Greater greater
  "check if outside temperature above threshold"
                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-42,-20})));
Modelica.Blocks.Sources.Constant TAirThresholdCoolingTabs(k=TThreshold_Cool_Tabs)
    "Threshold temperature above which cooling is activated"
    annotation (Placement(transformation(extent={{-86,-34},{-74,-22}})));
  Math.MovingAverage movingAverage(aveTime=timeAverage)
    "Calculates the moving average of ambient air temperature"
    annotation (Placement(transformation(extent={{-88,58},{-70,76}})));
  Modelica.Blocks.Logical.Switch switchHeater
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Logical.Switch switchCooler
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Blocks.Sources.Constant off(k=0)
    annotation (Placement(transformation(extent={{-16,-6},{-2,8}})));
  Modelica.Blocks.Sources.Constant heatingPower(k=power_Heater_Tabs)
    "Fixed available heating power of TABS"
    annotation (Placement(transformation(extent={{-14,38},{0,52}})));
  Modelica.Blocks.Sources.Constant coolingPower(k=power_Cooler_Tabs)
    "Fixed available cooling power of TABS"
    annotation (Placement(transformation(extent={{-14,-46},{0,-32}})));
  Modelica.Blocks.Interfaces.RealOutput tabsHeatingPower "Power for heating"
    annotation (Placement(transformation(extent={{100,10},
          {120,30}}),      iconTransformation(extent={{72,10},{92,30}})));
  Modelica.Blocks.Interfaces.RealOutput tabsCoolingPower "Power for cooling"
    annotation (Placement(transformation(extent={{100,-30},
          {120,-10}}),       iconTransformation(extent={{72,-30},{92,-10}})));
  Modelica.Blocks.Interaction.Show.BooleanValue heaterActive
    "true if heater is active"
    annotation (Placement(transformation(extent={{-24,58},{-4,78}})));
  Modelica.Blocks.Interaction.Show.BooleanValue coolerActive
    "true if cooler is active"
    annotation (Placement(transformation(extent={{-18,-78},{2,-58}})));
  Modelica.Blocks.Interfaces.RealInput TOpe "Operative indoor air temperature"
    annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={2,108}), iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={2,108})));
  Modelica.Blocks.Logical.Hysteresis hysteresisHeating(
    uLow=273.15 + 25,
    uHigh=273.15 + 18,
    pre_y_start=false) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={40,66})));
  Modelica.Blocks.Logical.Switch switchHeater1
    annotation (Placement(transformation(extent={{68,32},{88,52}})));
  Math.MovingAverage movingAverage1(aveTime=timeAverage)
    "Calculates the moving average of operative indoor air temperature"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={20,92})));
  Modelica.Blocks.Logical.Switch switchCooler1
    annotation (Placement(transformation(extent={{68,-52},{88,-32}})));
  Modelica.Blocks.Logical.Hysteresis hysteresisCooling(
    uLow=273.15 + 20,
    uHigh=273.15 + 25,
    pre_y_start=false) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={20,66})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-136,70},{-96,110}})));
equation

  connect(TAirThresholdHeatingTabs.y, less.u2)
    annotation (Line(points={{-73.4,12},{-54,12}}, color={0,0,127}));
  connect(TAirThresholdCoolingTabs.y, greater.u2)
    annotation (Line(points={{-73.4,-28},{-54,-28}}, color={0,0,127}));
  connect(movingAverage.y, less.u1) annotation (Line(points={{-69.1,67},{-69.1,
          68},{-66,68},{-66,20},{-54,20}},
                                       color={0,0,127}));
  connect(movingAverage.y, greater.u1) annotation (Line(points={{-69.1,67},{
          -69.1,68},{-66,68},{-66,-20},{-54,-20}},
                                             color={0,0,127}));
  connect(off.y, switchHeater.u3) annotation (Line(points={{-1.3,1},{8,1},{8,12},
          {18,12}},     color={0,0,127}));
  connect(off.y, switchCooler.u3) annotation (Line(points={{-1.3,1},{8,1},{8,-28},
          {18,-28}},      color={0,0,127}));
  connect(heatingPower.y, switchHeater.u1) annotation (Line(points={{0.7,45},{7.5,
          45},{7.5,28},{18,28}},  color={0,0,127}));
  connect(coolingPower.y, switchCooler.u1) annotation (Line(points={{0.7,-39},{0,
          -39},{0,-12},{18,-12}},  color={0,0,127}));
  connect(less.y, heaterActive.activePort) annotation (Line(points={{-31,20},{-25.5,
          20},{-25.5,68}}, color={255,0,255}));
  connect(less.y, switchHeater.u2)
    annotation (Line(points={{-31,20},{18,20}}, color={255,0,255}));
  connect(greater.y, switchCooler.u2)
    annotation (Line(points={{-31,-20},{18,-20}}, color={255,0,255}));
  connect(coolerActive.activePort, greater.y) annotation (Line(points={{-19.5,-68},
          {-26,-68},{-26,-20},{-31,-20}}, color={255,0,255}));
  connect(switchHeater.y, switchHeater1.u1) annotation (Line(points={{41,20},{52,
          20},{52,50},{66,50}}, color={0,0,127}));
  connect(hysteresisHeating.y, switchHeater1.u2)
    annotation (Line(points={{40,59.4},{40,42},{66,42}}, color={255,0,255}));
  connect(TOpe, movingAverage1.u) annotation (Line(points={{2,108},{1.5,108},{1.5,
          92},{12.8,92}}, color={0,0,127}));
  connect(movingAverage1.y, hysteresisHeating.u)
    annotation (Line(points={{26.6,92},{40,92},{40,73.2}}, color={0,0,127}));
  connect(switchHeater1.y, tabsHeatingPower) annotation (Line(points={{89,42},{94,
          42},{94,20},{110,20}}, color={0,0,127}));
  connect(off.y, switchHeater1.u3) annotation (Line(points={{-1.3,1},{62,1},{62,
          34},{66,34}}, color={0,0,127}));
  connect(off.y, switchCooler1.u3) annotation (Line(points={{-1.3,1},{8,1},{8,-50},
          {66,-50}}, color={0,0,127}));
  connect(switchCooler.y, switchCooler1.u1) annotation (Line(points={{41,-20},{52,
          -20},{52,-34},{66,-34}}, color={0,0,127}));
  connect(movingAverage1.y, hysteresisCooling.u) annotation (Line(points={{26.6,
          92},{30,92},{30,78},{20,78},{20,73.2}}, color={0,0,127}));
  connect(hysteresisCooling.y, switchCooler1.u2) annotation (Line(points={{20,59.4},
          {20,36},{48,36},{48,-42},{66,-42}}, color={255,0,255}));
  connect(switchCooler1.y, tabsCoolingPower) annotation (Line(points={{89,-42},{
          94,-42},{94,-20},{110,-20}}, color={0,0,127}));
  connect(u, movingAverage.u) annotation (Line(points={{-116,90},{-104,90},{-104,
          67},{-89.8,67}}, color={0,0,127}));
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
end tabsHeaterCoolerController_test;
