within AixLib.Fluid.HeatExchangers.Radiators.Examples;
model PumpRadiatorThermostaticValve
  import AixLib;
  extends Modelica.Icons.Example;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  AixLib.Fluid.Movers.Pump
             pump(MinMaxCharacteristics = AixLib.DataBase.Pumps.Pump1(), V_flow_max = 2, ControlStrategy = 2, V_flow(fixed = false),
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                                                                                                     annotation(Placement(transformation(extent = {{-54, 10}, {-34, 30}})));
  AixLib.Fluid.FixedResistances.StaticPipe
                   pipe(l = 10, D = 0.01,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                    annotation(Placement(transformation(extent = {{4, 10}, {24, 30}})));
  AixLib.Fluid.FixedResistances.StaticPipe
                   pipe1(l = 10, D = 0.01,
    redeclare package Medium = Medium,
    m_flow_small=1e-4)                     annotation(Placement(transformation(extent = {{-10, -30}, {-30, -10}})));
  Modelica.Blocks.Sources.BooleanConstant NightSignal(k = false) annotation(Placement(transformation(extent = {{-76, 50}, {-56, 70}})));
  inner AixLib.HVAC.BaseParameters baseParameters
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  AixLib.Fluid.Sources.FixedBoundary
                     PointFixedPressure(nPorts=1, redeclare package Medium =
        Medium)                                           annotation(Placement(transformation(extent = {{-98, 10}, {-78, 30}})));
  AixLib.Fluid.Actuators.Valves.ThermostaticValve simpleValve(
    Influence_PressureDrop=0.15,
    Kvs=0.4,
    Kv_setT=0.12,
    leakageOpening=0,
    redeclare package Medium = Medium,
    m_flow_small=1e-4,
    dp(start=20000))
    annotation (Placement(transformation(extent={{32,10},{52,30}})));
  AixLib.Fluid.HeatExchangers.Radiators.Radiator radiator(
    RadiatorType=AixLib.DataBase.Radiators.ThermX2_ProfilV_979W(),
    redeclare package Medium = Medium,
    m_flow_nominal=0.01)
    annotation (Placement(transformation(extent={{112,10},{134,30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature AirTemp annotation(Placement(transformation(extent = {{100, 58}, {112, 70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RadTemp annotation(Placement(transformation(extent = {{148, 58}, {136, 70}})));
  Modelica.Blocks.Sources.Constant Source_Temp(k = 273.15 + 20) annotation(Placement(transformation(extent = {{56, 80}, {76, 100}})));
  Modelica.Blocks.Sources.Sine Source_opening(freqHz = 1 / 86400, amplitude = 1, startTime = 0, offset = 273.15 + 18.5) annotation(Placement(transformation(extent = {{10, 60}, {30, 80}})));
  AixLib.Fluid.HeatExchangers.Boiler
                        boiler(redeclare package Medium = Medium,
      m_flow_nominal=0.01)     annotation(Placement(transformation(extent = {{-26, 10}, {-6, 30}})));
  Modelica.Blocks.Sources.Constant Source_TempSet_Boiler(k = 273.15 + 75) annotation(Placement(transformation(extent = {{0, 60}, {-20, 80}})));
equation
  connect(pipe1.port_b, pump.port_a) annotation(Line(points = {{-30, -20}, {-60, -20}, {-60, 20}, {-54, 20}}, color = {0, 127, 255}));
  connect(NightSignal.y, pump.IsNight) annotation(Line(points = {{-55, 60}, {-44, 60}, {-44, 30.2}}, color = {255, 0, 255}));
  connect(pipe.port_b, simpleValve.port_a) annotation(Line(points = {{24, 20}, {32, 20}}, color = {0, 127, 255}));
  connect(simpleValve.port_b, radiator.port_a) annotation(Line(points={{52,20},{
          112,20}},                                                                               color = {0, 127, 255}));
  connect(radiator.port_b, pipe1.port_a) annotation(Line(points={{134,20},{160,20},
          {160,-20},{-10,-20}},                                                                                      color = {0, 127, 255}));
  connect(AirTemp.port, radiator.convPort) annotation(Line(points = {{112, 64}, {118.38, 64}, {118.38, 27.6}}, color = {191, 0, 0}));
  connect(radiator.radPort, RadTemp.port) annotation(Line(points = {{127.4, 27.8}, {127.4, 64}, {136, 64}}, color = {0, 0, 0}));
  connect(Source_Temp.y, AirTemp.T) annotation(Line(points = {{77, 90}, {98.8, 90}, {98.8, 64}}, color = {0, 0, 127}));
  connect(Source_Temp.y, RadTemp.T) annotation(Line(points = {{77, 90}, {150, 90}, {150, 64}, {149.2, 64}}, color = {0, 0, 127}));
  connect(pump.port_b, boiler.port_a) annotation(Line(points = {{-34, 20}, {-26, 20}}, color = {0, 127, 255}));
  connect(boiler.port_b, pipe.port_a) annotation(Line(points = {{-6, 20}, {4, 20}}, color = {0, 127, 255}));
  connect(Source_TempSet_Boiler.y, boiler.T_set) annotation(Line(points = {{-21, 70}, {-34, 70}, {-34, 26}, {-26.8, 26}, {-26.8, 27}}, color = {0, 0, 127}));
  connect(Source_Temp.y, simpleValve.T_room) annotation(Line(points = {{77, 90}, {80, 90}, {80, 44}, {35.6, 44}, {35.6, 29.8}}, color = {0, 0, 127}));
  connect(Source_opening.y, simpleValve.T_setRoom) annotation(Line(points = {{31, 70}, {47.6, 70}, {47.6, 29.8}}, color = {0, 0, 127}));
  connect(PointFixedPressure.ports[1], pump.port_a) annotation (Line(
      points={{-78,20},{-54,20}},
      color={0,127,255}));
  annotation(Diagram(coordinateSystem(extent={{-100,-100},{160,100}},      preserveAspectRatio=false),   graphics), Icon(coordinateSystem(extent = {{-100, -100}, {160, 100}})), experiment(StopTime = 86400, Interval = 60, __Dymola_Algorithm = "Lsodar"), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>Pump, boiler, thernostatic valve and radiator in a closed loop.</p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>The example ilustrates how the thermostatic valve reacts.</p>
 <p>The valve doesn&apos;t fully close, because as the radiator it is connected
 to fixed temperatures the temperature difference between flow and return become
 infinite at zero mass flow in order to satisfy the power equation. </p>
 <p>Make sure you initialise the temperatures correctly in order to have flow
 temperature &gt; return temperature &gt; room temperature in order for the
 equation for over temperature to be correctly calculated.</p>
 </html>", revisions="<html>
 <ul>
 <li><i>November 2014&nbsp;</i>
    by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class</li>
 </ul>
</html>"));
end PumpRadiatorThermostaticValve;
