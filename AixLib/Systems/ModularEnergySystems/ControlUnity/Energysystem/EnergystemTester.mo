within AixLib.Systems.ModularEnergySystems.ControlUnity.Energysystem;
model EnergystemTester
  Modules.ModularBoiler               modularBoiler_Controller(
    TColdNom=333.15,
    QNom=100000,
    simpleTwoPosition=true,
    use_advancedControl=false,
    Tref=358.15,
    bandwidth=2.5,
    severalHeatcurcuits=false,
    TVar=false,
    manualTimeDelay=false,
    variablePLR=false,
    variableSetTemperature_admix=false,
    time_minOff=0,
    time_minOn=10000)
         annotation (Placement(transformation(extent={{-22,24},{-2,44}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    T_start=293.15,
    m_flow_nominal=1,
    redeclare package Medium = AixLib.Media.Water,
    V=3,
    nPorts=3)
    annotation (Placement(transformation(extent={{68,32},{88,52}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,64})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{90,-22},{110,-2}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    allowFlowReversal=true,
    length=5,
    isCircular=true,
    diameter=0.03,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=0, m_flow_nominal=0.4785))
    annotation (Placement(transformation(extent={{46,-20},{24,0}})));

  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
                                       boilerControlBus
    annotation (Placement(transformation(extent={{-54,30},{-34,50}})));
  Modelica.Blocks.Sources.RealExpression PLR(y=1)
    annotation (Placement(transformation(extent={{-102,22},{-90,42}})));
  Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
    annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  ModularCHP.ModularCHP
             modularCHP(
    PelNom(displayUnit="kW") = 100000,
    use_advancedControl=false,
    manualTimeDelay=false,
    time_minOff=0,
    time_minOn=10000,
    variableSetTemperature_admix=false,
    bandwidth=4,
    Tref=358.15,
    severalHeatcurcuits=true,
    simpleTwoPosition=true) annotation (Placement(transformation(extent={{-22,-52},
            {-2,-32}})));
  AixLib.Controls.Interfaces.CHPControlBus cHPControlBus
    annotation (Placement(transformation(extent={{-72,-44},{-50,-18}}),
        iconTransformation(extent={{-72,-44},{-50,-18}})));
  EnergySystem_Control energySystem_Control
    annotation (Placement(transformation(extent={{-38,66},{-18,86}})));
  AixLib.Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = AixLib.Media.Water,
    nPorts=1)
    annotation (Placement(transformation(extent={{128,10},{108,30}})));
  Modelica.Fluid.Pipes.StaticPipe pipe1(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    allowFlowReversal=true,
    length=5,
    isCircular=true,
    diameter=0.03,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=0, m_flow_nominal=0.4785))
    annotation (Placement(transformation(extent={{10,8},{32,28}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        AixLib.Media.Water, m_flow_nominal=1)
    annotation (Placement(transformation(extent={{44,8},{64,28}})));
  Modelica.Blocks.Sources.RealExpression PLREx(y=1)
    annotation (Placement(transformation(extent={{-92,8},{-80,28}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-150000,
    width=100,
    period=20000,
    nperiod=1,
    offset=-50000,
    startTime=10000)
    annotation (Placement(transformation(extent={{8,74},{28,94}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-102,44},{-82,64}})));
equation

  connect(pipe.port_b, modularBoiler_Controller.port_a) annotation (Line(
      points={{24,-10},{-30,-10},{-30,34},{-22,34}},
      color={0,127,255}));

  connect(heater.port, vol.heatPort)
    annotation (Line(points={{60,54},{60,42},{68,42}}, color={191,0,0}));
  connect(vol.heatPort, temperatureSensor.port)
    annotation (Line(points={{68,42},{68,-12},{90,-12}},
                                                     color={191,0,0}));
  connect(vol.ports[1], pipe.port_a)
    annotation (Line(points={{75.3333,32},{75.3333,-10},{46,-10}},
                                                         color={0,127,255}));
  connect(boilerControlBus, modularBoiler_Controller.boilerControlBus)
    annotation (Line(
      points={{-44,40},{-34,40},{-34,43.8},{-18.4,43.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-89.4,32},{-43.95,
          32},{-43.95,40.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(cHPControlBus, modularCHP.cHPControlBus) annotation (Line(
      points={{-61,-31},{-40.5,-31},{-40.5,-31.8},{-18,-31.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(PLR.y, cHPControlBus.PLR) annotation (Line(points={{-89.4,32},{-86,32},
          {-86,42},{-118,42},{-118,-20},{-60,-20},{-60,-30.935},{-60.945,-30.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(isOn.y, cHPControlBus.isOn) annotation (Line(points={{-79,4},{-60.945,
          4},{-60.945,-30.935}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(energySystem_Control.isOnBoiler, boilerControlBus.isOn) annotation (
      Line(points={{-18,76},{-12,76},{-12,52},{-43.95,52},{-43.95,40.05}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pipe.port_b, modularCHP.port_a) annotation (Line(points={{24,-10},{18,
          -10},{18,-72},{-34,-72},{-34,-42},{-22,-42}}, color={0,127,255}));
  connect(bou.ports[1], vol.ports[2]) annotation (Line(points={{108,20},{88,20},
          {88,32},{78,32}}, color={0,127,255}));

  connect(modularBoiler_Controller.port_b, pipe1.port_a) annotation (Line(
        points={{-2,34},{4,34},{4,18},{10,18}}, color={0,127,255}));
  connect(modularCHP.port_b, pipe1.port_a) annotation (Line(points={{-2,-42},{4,
          -42},{4,18},{10,18}}, color={0,127,255}));
  connect(pipe1.port_b, senTem.port_a)
    annotation (Line(points={{32,18},{44,18}}, color={0,127,255}));
  connect(senTem.port_b, vol.ports[3]) annotation (Line(points={{64,18},{68,18},
          {68,32},{80.6667,32}}, color={0,127,255}));
  connect(PLREx.y, boilerControlBus.PLREx) annotation (Line(points={{-79.4,18},
          {-43.95,18},{-43.95,40.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PLREx.y, cHPControlBus.PLREx) annotation (Line(points={{-79.4,18},{
          -60.945,18},{-60.945,-30.935}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pulse.y, heater.Q_flow)
    annotation (Line(points={{29,84},{60,84},{60,74}}, color={0,0,127}));
  connect(booleanExpression.y, boilerControlBus.internControl) annotation (Line(
        points={{-81,54},{-64,54},{-64,40.05},{-43.95,40.05}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanExpression.y, cHPControlBus.internControl) annotation (Line(
        points={{-81,54},{-76,54},{-76,72},{-154,72},{-154,-40},{-60.945,-40},{-60.945,
          -30.935}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(cHPControlBus.THot, energySystem_Control.T) annotation (Line(
      points={{-61,-31},{-134,-31},{-134,78.2},{-38.2,78.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Tester model for an energy system including the modular boiler and the modular CHP. The CHP is prioritized and runs with the internal control. The boiler is switched on when required and controlled via a control system. </p>
</html>"));
end EnergystemTester;
