within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_SetConditionsHeaterCooler
  "Simple test for input of set values for heater and cooler"
  extends Modelica.Icons.Example;

  Components.Heater heater(use_T_set=true, redeclare model
      PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-26,-14},{14,26}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=20,
    freqHz=1/7200,
    offset=293.15)
    annotation (Placement(transformation(extent={{-94,6},{-74,26}})));
  Modelica.Blocks.Sources.Constant const(k=293.15)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-94,38},{-74,58}})));
  Modelica.Blocks.Sources.Constant const2(k=0.003)
    annotation (Placement(transformation(extent={{-94,-30},{-74,-10}})));
  Components.Cooler cooler(
    use_T_set=true,
    use_X_set=true,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-24,-72},{12,-36}})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=0.004,
    freqHz=1/7200,
    offset=0.006)
    annotation (Placement(transformation(extent={{-94,-70},{-74,-50}})));
  Modelica.Blocks.Sources.Constant const3(k=0.006)
    annotation (Placement(transformation(extent={{68,-38},{48,-18}})));
  Modelica.Blocks.Sources.Constant const4(k=281.15)
    annotation (Placement(transformation(extent={{-60,-94},{-40,-74}})));
equation
  connect(sine.y, heater.T_airIn)
    annotation (Line(points={{-73,16},{-28,16}}, color={0,0,127}));
  connect(const.y, heater.T_set)
    annotation (Line(points={{-19,70},{-6,70},{-6,26}}, color={0,0,127}));
  connect(const1.y, heater.m_flow_airIn) annotation (Line(points={{-73,48},{-60,
          48},{-60,22},{-28,22}}, color={0,0,127}));
  connect(const2.y, heater.X_airIn) annotation (Line(points={{-73,-20},{-60,-20},
          {-60,10},{-28,10}}, color={0,0,127}));
  connect(const.y, cooler.T_set) annotation (Line(points={{-19,70},{32,70},{32,-24},
          {-6,-24},{-6,-36}}, color={0,0,127}));
  connect(sine.y, cooler.T_airIn) annotation (Line(points={{-73,16},{-60,16},{-60,
          -45},{-25.8,-45}}, color={0,0,127}));
  connect(sine1.y, cooler.X_airIn) annotation (Line(points={{-73,-60},{-40,-60},
          {-40,-50.4},{-25.8,-50.4}}, color={0,0,127}));
  connect(const1.y, cooler.m_flow_airIn) annotation (Line(points={{-73,48},{-60,
          48},{-60,-39.6},{-25.8,-39.6}}, color={0,0,127}));
  connect(const3.y, cooler.X_set)
    annotation (Line(points={{47,-28},{4.8,-28},{4.8,-36}}, color={0,0,127}));
  connect(const4.y, cooler.T_coolingSurf) annotation (Line(points={{-39,-84},{-14.82,
          -84},{-14.82,-71.82}}, color={0,0,127}));
  annotation (experiment(StopTime=14400, __Dymola_NumberOfIntervals=14400),
      Documentation(info="<html><p>
  Testing <a href=
  \"modelica://SimpleAHU.Components.Heater\">SimpleAHU.Components.Heater</a>
  and <a href=
  \"SimpleAHU.Components.Cooler\">SimpleAHU.Components.Cooler</a> with
  set temperature and set humidity (for cooler).
</p>
</html>"));
end Test_SetConditionsHeaterCooler;
