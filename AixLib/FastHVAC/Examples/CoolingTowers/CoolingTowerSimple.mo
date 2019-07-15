within AixLib.FastHVAC.Examples.CoolingTowers;
model CoolingTowerSimple
extends Modelica.Icons.Example;
  Components.HeatExchangers.CoolingTowers.CoolingTowerSimple
                                              coolingTowerSimple
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{78,-10},{98,10}})));
  Components.Sensors.MassFlowSensor massFlowRate
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Components.Sensors.TemperatureSensor temperature
    annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
  Components.Sensors.MassFlowSensor massFlowRate1
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Components.Sensors.TemperatureSensor temperature1
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
  BoundaryConditions.WeatherData.ReaderTMY3
    weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    filNam=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
    computeWetBulbTemperature=true,
    TDryBul(displayUnit="K"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-98,78},{-78,98}})));

  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-84,38},{-50,70}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Sources.Constant const(k=2)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=1.15e-5,
    startTime=0,
    amplitude=2,
    phase=0.17453292519943,
    offset=298.15)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Continuous.Integrator waterConsumption
    annotation (Placement(transformation(extent={{40,48},{50,58}})));
equation
  connect(fluidSource.enthalpyPort_b, massFlowRate.enthalpyPort_a) annotation (
      Line(points={{-68,1},{-63,1},{-63,-0.1},{-58.8,-0.1}}, color={176,0,0}));
  connect(massFlowRate.enthalpyPort_b, temperature.enthalpyPort_a) annotation (
      Line(points={{-41,-0.1},{-37.5,-0.1},{-37.5,-0.1},{-32.8,-0.1}}, color={
          176,0,0}));
  connect(temperature.enthalpyPort_b, coolingTowerSimple.enthalpyPort_a)
    annotation (Line(points={{-15,-0.1},{-4,-0.1},{-4,60},{0,60}}, color={176,0,
          0}));
  connect(coolingTowerSimple.enthalpyPort_b, massFlowRate1.enthalpyPort_a)
    annotation (Line(points={{20,60},{22,60},{22,-0.1},{31.2,-0.1}}, color={176,
          0,0}));
  connect(massFlowRate1.enthalpyPort_b, temperature1.enthalpyPort_a)
    annotation (Line(points={{49,-0.1},{52.5,-0.1},{52.5,-0.1},{55.2,-0.1}},
        color={176,0,0}));
  connect(temperature1.enthalpyPort_b, vessel.enthalpyPort_a) annotation (Line(
        points={{73,-0.1},{76.5,-0.1},{76.5,0},{81,0}}, color={176,0,0}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-78,88},{-67,88},{-67,54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const.y, fluidSource.dotm) annotation (Line(points={{-79,-50},{-62,
          -50},{-62,-32},{-96,-32},{-96,-2.6},{-86,-2.6}}, color={0,0,127}));
  connect(sine.y, fluidSource.T_fluid) annotation (Line(points={{-79,30},{-74,
          30},{-74,12},{-96,12},{-96,4.2},{-86,4.2}}, color={0,0,127}));
  connect(weaBus.TWetBul, coolingTowerSimple.TAirWetBulb) annotation (Line(
      points={{-67,54},{-20,54},{-20,64},{-1.8,64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, coolingTowerSimple.TAirDry) annotation (Line(
      points={{-67,54},{-20,54},{-20,68},{-1.8,68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(coolingTowerSimple.m_flow_water, waterConsumption.u) annotation (Line(
        points={{21,56},{30,56},{30,53},{39,53}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=31536000, Interval=900));
end CoolingTowerSimple;
