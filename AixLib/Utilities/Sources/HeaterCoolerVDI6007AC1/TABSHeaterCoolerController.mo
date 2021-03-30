within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model tabsHeaterCoolerController
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam
    "Zone definition";
  parameter Modelica.SIunits.Power heatingPower = 0;
  parameter Modelica.SIunits.Power coolingPower = 0;

  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-111,75},{-77,107}}),iconTransformation(
    extent={{-92,28},{-62,58}})));
Modelica.Blocks.Sources.Constant TAirThresholdHeating(k=zoneParam.TThresholdHeaterTABS)
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
Modelica.Blocks.Sources.Constant TAirThresholdCooling(k=zoneParam.TThresholdCoolerTABS)
  "Threshold temperature above which cooling is activated"
  annotation (Placement(transformation(extent={{-86,-34},{-74,-22}})));
  Math.MovingAverage movingAverage
    annotation (Placement(transformation(extent={{-88,58},{-70,76}})));
  Modelica.Blocks.Logical.Switch switchHeater
    annotation (Placement(transformation(extent={{60,10},{80,30}})));
  Modelica.Blocks.Logical.Switch switchCooler
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Modelica.Blocks.Sources.Constant off(k=0)
    annotation (Placement(transformation(extent={{6,-6},{20,8}})));
  Modelica.Blocks.Sources.Constant heatingPower1(k=zoneParam.heatingPowerTABS)
    annotation (Placement(transformation(extent={{6,38},{20,52}})));
  Modelica.Blocks.Sources.Constant coolingPower1(k=zoneParam.coolingPowerTABS)
    annotation (Placement(transformation(extent={{6,-46},{20,-32}})));
  Modelica.Blocks.Interfaces.RealOutput tabsHeatingPower
    annotation (Placement(transformation(extent={{100,10},
          {120,30}}),      iconTransformation(extent={{72,10},{92,30}})));
  Modelica.Blocks.Interfaces.RealOutput tabsCoolingPower
    annotation (Placement(transformation(extent={{100,-30},
          {120,-10}}),       iconTransformation(extent={{72,-30},{92,-10}})));
  Modelica.Blocks.Interaction.Show.BooleanValue heaterActive
    "true if heater is active"
    annotation (Placement(transformation(extent={{-18,30},{2,50}})));
  Modelica.Blocks.Interaction.Show.BooleanValue coolerActive
    "true if cooler is active"
    annotation (Placement(transformation(extent={{-18,-50},{2,-30}})));
equation

  connect(TAirThresholdHeating.y, less.u2)
    annotation (Line(points={{-73.4,12},{-54,12}}, color={0,0,127}));
  connect(TAirThresholdCooling.y, greater.u2)
    annotation (Line(points={{-73.4,-28},{-54,-28}}, color={0,0,127}));
  connect(weaBus.TDryBul, movingAverage.u) annotation (Line(
      points={{-94,91},{-94,67},{-89.8,67}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(movingAverage.y, less.u1) annotation (Line(points={{-69.1,67},{-69.1,
          68},{-66,68},{-66,20},{-54,20}},
                                       color={0,0,127}));
  connect(movingAverage.y, greater.u1) annotation (Line(points={{-69.1,67},{
          -69.1,68},{-66,68},{-66,-20},{-54,-20}},
                                             color={0,0,127}));
  connect(switchHeater.y, tabsHeatingPower)
    annotation (Line(points={{81,20},{110,20}}, color={0,0,127}));
  connect(switchCooler.y, tabsCoolingPower)
    annotation (Line(points={{81,-20},{110,-20}}, color={0,0,127}));
  connect(off.y, switchHeater.u3) annotation (Line(points={{20.7,1},{44,1},{44,
          12},{58,12}}, color={0,0,127}));
  connect(off.y, switchCooler.u3) annotation (Line(points={{20.7,1},{44,1},{44,
          -28},{58,-28}}, color={0,0,127}));
  connect(heatingPower1.y, switchHeater.u1) annotation (Line(points={{20.7,45},
          {43.5,45},{43.5,28},{58,28}}, color={0,0,127}));
  connect(coolingPower1.y, switchCooler.u1) annotation (Line(points={{20.7,-39},
          {36,-39},{36,-12},{58,-12}}, color={0,0,127}));
  connect(less.y, heaterActive.activePort) annotation (Line(points={{-31,20},{-19.5,
          20},{-19.5,40}}, color={255,0,255}));
  connect(less.y, switchHeater.u2)
    annotation (Line(points={{-31,20},{58,20}}, color={255,0,255}));
  connect(greater.y, switchCooler.u2)
    annotation (Line(points={{-31,-20},{58,-20}}, color={255,0,255}));
  connect(coolerActive.activePort, greater.y) annotation (Line(points={{-19.5,-40},
          {-20,-40},{-20,-20},{-31,-20}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{-58, 32}, {62, -20}}, lineColor = {175, 175, 175}, textString = "%name")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  This is a simple controller which sets a threshold for heating and
  cooling based on the outside temperature. This should prevent heating
  in summer if the AHU lowers the temperature below set temperature of
  TABS heater and cooler and vice versa in winter.
</p>
</html>",
        revisions="<html><ul>
  <li>
  <i>March, 2021&#160;</i> by Christian Wenzel:<br/>
    Initial integration
  </li>
</ul>
</html>"));
end tabsHeaterCoolerController;
