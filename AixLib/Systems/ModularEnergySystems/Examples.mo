within AixLib.Systems.ModularEnergySystems;
package Examples "Holds examples for the modular energy system units"
  extends Modelica.Icons.ExamplesPackage;
  model HeatPump

    Modules.ModularHeatPump.ModularHeatPump modularHeatPumpNew(
      THotNom=318.15,
      TSourceNom=278.15,
      QNom=1.5*QNom,
      PLRMin=0.4,
      DeltaTCon=DeltaTCon,
      TCon_start=313.15,
      TSourceInternal=true,
      redeclare package MediumEvap = AixLib.Media.Water,
      use_non_manufacturer=true,
      redeclare model PerDataMainHP =
          AixLib.DataBase.HeatPump.PerformanceData.LookUpTableNDNotManufacturerSlim)
      annotation (Placement(transformation(extent={{40,-16},{60,4}})));
    .AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus
      annotation (Placement(transformation(extent={{-20,-30},{10,4}}),
          iconTransformation(extent={{-8,-22},{10,4}})));

    inner Modelica.Fluid.System system(p_start=system.p_ambient)
      annotation (Placement(transformation(extent={{80,80},{100,100}})));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=QNom*0.15,
      f=1/(3600*24),
      offset=QNom*0.5)
      annotation (Placement(transformation(extent={{-34,40},{-14,60}})));
    parameter Modelica.Units.SI.HeatFlowRate QNom=300000
      "Nominal heat flow rate of heat pump";
    parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=5
      "Temperature difference heat sink condenser";
    Modules.ModularHeatPump.BaseClasses.ModularControl modularControl
      annotation (Placement(transformation(extent={{-100,16},{-58,42}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=5,
      f=1/(3600*24),
      offset=313.15)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    AixLib.Controls.Continuous.LimPID SetMFlow(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.001,
      Ti=1,
      yMax=1,
      Td=1,
      yMin=0.5,
      initType=Modelica.Blocks.Types.Init.NoInit,
      y_start=1) "Setpoint mass flow"
      annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
    Modules.ModularStorage.Consumer consumer(DeltaT=DeltaTCon, QNom=QNom)
      annotation (Placement(transformation(extent={{32,40},{52,60}})));
    Modules.ModularStorage.ScalableStorage scalableStorage(
      V=100,
      QNom=QNom,
      DeltaTCon=DeltaTCon,
      m_Flow=QNom/4180/DeltaTCon,
      T_start=313.15)
      annotation (Placement(transformation(extent={{72,38},{92,58}})));
    Fluid.Sources.Boundary_pT        bou(redeclare package Medium =
          AixLib.Media.Water, nPorts=1)
      annotation (Placement(transformation(extent={{20,4},{40,24}})));
  equation

    connect(sigBus, modularHeatPumpNew.sigBus) annotation (Line(
        points={{-5,-13},{34,-13},{34,-9.9},{40.1,-9.9}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(modularControl.sigBus, sigBus) annotation (Line(
        points={{-77.9,22.1},{-77.9,-13},{-5,-13}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sine.y, SetMFlow.u_s)
      annotation (Line(points={{-79,90},{-76,90},{-76,100},{-42,100},{-42,90}},
                                                   color={0,0,127}));
    connect(scalableStorage.port_b_Supply, consumer.port_a_Grid) annotation (
        Line(points={{72,56},{56,56},{56,52},{51.8,52}}, color={0,127,255}));
    connect(consumer.port_b_Grid, scalableStorage.port_a_Return) annotation (
        Line(points={{52,46},{72,46}},                 color={0,127,255}));
    connect(scalableStorage.port_b_Return, modularHeatPumpNew.port_a)
      annotation (Line(points={{72,40},{14,40},{14,-6},{40,-6}}, color={0,127,
            255}));
    connect(scalableStorage.tCold, modularControl.u2) annotation (Line(points={{71,42.4},
            {-24,42.4},{-24,42},{-120,42},{-120,22},{-102,22}},           color
          ={0,0,127}));
    connect(sine.y, consumer.tHotSet) annotation (Line(points={{-79,90},{-76,90},
            {-76,100},{-42,100},{-42,62},{-44,62},{-44,59},{30,59}},
                                                 color={0,0,127}));
    connect(sine1.y, consumer.thermalDemand)
      annotation (Line(points={{-13,50},{30,50},{30,49.2}}, color={0,0,127}));
    connect(modularHeatPumpNew.port_a, bou.ports[1])
      annotation (Line(points={{40,-6},{40,14}}, color={0,127,255}));
    connect(SetMFlow.y, sigBus.mFlowSetExternal) annotation (Line(points={{-19,
            90},{-4.925,90},{-4.925,-12.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sine.y, sigBus.THotSet) annotation (Line(points={{-79,90},{-76,90},
            {-76,100},{-42,100},{-42,76},{-48,76},{-48,40},{-4.925,40},{-4.925,
            -12.915}},                       color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(scalableStorage.tHot, SetMFlow.u_m) annotation (Line(points={{71,53},
            {70,53},{70,58},{58,58},{58,68},{-30,68},{-30,78}}, color={0,0,127}));
    connect(modularHeatPumpNew.port_b, scalableStorage.port_a_Supply)
      annotation (Line(points={{60,-6},{64,-6},{64,50},{72,50}}, color={0,127,
            255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=604800, __Dymola_Algorithm="Dassl"));
  end HeatPump;

  model Boiler
     extends
      AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer.SimpleConsumer(
      vol(
        T_start=293.15,
        m_flow_nominal=1, nPorts=2),
      TSpeicher(y=80 + 273.15),
      sine(
        amplitude=50000,
        f=1/9000,
        offset=-75000),
      bou(nPorts=1));
    Interfaces.BoilerControlBus boilerControlBus
      annotation (Placement(transformation(extent={{-122,8},{-102,28}})));
    Modules.ModularBoiler.ModularBoiler2 modularBoiler2_1(T_cold_nom=333.15,
        Q_nom=150000)
      annotation (Placement(transformation(extent={{-44,-2},{-24,18}})));
    Fluid.Sources.Boundary_pT
                        bou1(
      nPorts=1,
      use_T_in=false,
      redeclare package Medium = AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-70,-74},{-50,-54}})));
    Fluid.Sources.Boundary_pT
                        bou2(
      nPorts=1,
      use_T_in=false,
      redeclare package Medium = AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-24,-74},{-4,-54}})));
  equation
    connect(boilerControlBus, modularBoiler2_1.boilerControlBus) annotation (
        Line(
        points={{-112,18},{-34,18}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(modularBoiler2_1.port_b, vol.ports[1]) annotation (Line(points={{
            -24,8},{-12,8},{-12,6},{46,6},{46,4}}, color={0,127,255}));
    connect(bou.ports[1], modularBoiler2_1.port_a) annotation (Line(points={{0,
            -40},{8,-40},{8,-38},{12,-38},{12,-12},{-78,-12},{-78,8},{-44,8}},
          color={0,127,255}));
    connect(vol.ports[2], modularBoiler2_1.port_a) annotation (Line(points={{46,
            4},{46,-10},{-66,-10},{-66,8},{-44,8}}, color={0,127,255}));
    connect(bou1.ports[1], modularBoiler2_1.port_a1) annotation (Line(points={{
            -50,-64},{-44,-64},{-44,0}}, color={0,127,255}));
    connect(modularBoiler2_1.port_b1, bou2.ports[1]) annotation (Line(points={{
            -24,0},{-12,0},{-12,-2},{-4,-2},{-4,-64}}, color={0,127,255}));
    connect(TSpeicher.y, boilerControlBus.TSupplySet) annotation (Line(points={
            {-138.4,-58},{-138.4,18.05},{-111.95,18.05}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=10000));
  end Boiler;

  model CHP
    extends AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer.SimpleConsumer(
      vol(m_flow_nominal=1, nPorts=2),
      bou(nPorts=1),
      TSpeicher(y=60 + 273.15),
      sine(offset=0));
    Modules.ModularCHP.ModularCHP_ElDriven modularCHP(PelNom(displayUnit="kW")=
           100000)
      annotation (Placement(transformation(extent={{-26,-12},{-6,8}})));
    AixLib.Controls.Interfaces.CHPControlBus cHPControlBus
      annotation (Placement(transformation(extent={{-94,-4},{-54,36}})));
    Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      allowFlowReversal=true,
      length=5,
      isCircular=true,
      diameter=0.03,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=0, m_flow_nominal=0.4785))
      annotation (Placement(transformation(extent={{44,-44},{22,-24}})));

  equation
    connect(modularCHP.port_b, vol.ports[1]) annotation (Line(points={{-6,-2},{8,-2},
            {8,-4},{46,-4},{46,4}}, color={0,127,255}));
    connect(bou.ports[1], modularCHP.port_a) annotation (Line(points={{0,-40},{6,-40},
            {6,-38},{14,-38},{14,-20},{-36,-20},{-36,-2},{-26,-2}}, color={0,127,255}));
    connect(cHPControlBus, modularCHP.cHPControlBus) annotation (Line(
        points={{-74,16},{-54,16},{-54,14},{-16,14},{-16,8.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(switch1.y, cHPControlBus.PLR) annotation (Line(points={{-59.1,-29},
            {-54,-29},{-54,0},{-74,0},{-74,16}},  color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(vol.ports[2], pipe.port_a) annotation (Line(points={{46,4},{48,4},{48,
            -34},{44,-34}}, color={0,127,255}));
    connect(pipe.port_b, modularCHP.port_a) annotation (Line(points={{22,-34},{14,
            -34},{14,-32},{6,-32},{6,-24},{-26,-24},{-26,-2}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=5000));
  end CHP;

  model Test
    Modules.ModularStorage.GridStorage gridSstorage(
      m_Flow=2.78,
      T_start=323.15,
      TColdNom=313.15)
             annotation (Placement(transformation(extent={{56,-10},{76,10}})));
    Fluid.MixingVolumes.MixingVolume demand(
      redeclare package Medium = AixLib.Media.Water,
      T_start=323.15,
      m_flow_nominal=2.78,
      V=5,
      nPorts=2)
      annotation (Placement(transformation(extent={{-70,38},{-50,58}})));
    Fluid.MixingVolumes.MixingVolume producer(
      redeclare package Medium = AixLib.Media.Water,
      T_start=323.15,
      m_flow_nominal=2.78,
      V=0.1,
      nPorts=2)
      annotation (Placement(transformation(extent={{-70,-48},{-50,-28}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-116,-38})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater1
      "Prescribed heat flow" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-110,48})));
    Fluid.Sources.Boundary_pT bou(redeclare package Medium = AixLib.Media.Water,
        nPorts=1)
      annotation (Placement(transformation(extent={{-126,14},{-106,34}})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=50000,
      f=1/3600,
      offset=120000)
      annotation (Placement(transformation(extent={{-200,38},{-180,58}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{-210,-48},{-190,-28}})));
    Modelica.Blocks.Sources.Constant const1(k=323.15)
      annotation (Placement(transformation(extent={{50,-62},{70,-42}})));
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{-156,38},{-136,58}})));
    Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
          Media.Water, m_flow_nominal=2.78)
      annotation (Placement(transformation(extent={{-82,-20},{-98,0}})));
    Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
          Media.Water, m_flow_nominal=2.78)
      annotation (Placement(transformation(extent={{40,0},{24,16}})));
    Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
          AixLib.Media.Water,
                       m_flow_nominal=2.78)
      annotation (Placement(transformation(extent={{-8,-62},{6,-44}})));
    Fluid.Movers.FlowControlled_m_flow fan1(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=2.78,
      redeclare Fluid.Movers.Data.Generic per,
      inputType=AixLib.Fluid.Types.InputType.Constant,
      addPowerToMedium=false,
      nominalValuesDefineDefaultPressureCurve=false,
      constantMassFlowRate=2.78)
      annotation (Placement(transformation(extent={{-66,-12},{-46,10}})));
    AixLib.Controls.Continuous.LimPID conPID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=30,
      yMax=1,
      yMin=0)
      annotation (Placement(transformation(extent={{-228,-90},{-208,-70}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-174,-76},{-154,-56}})));
  equation
    connect(heater.port, producer.heatPort)
      annotation (Line(points={{-106,-38},{-70,-38}}, color={191,0,0}));
    connect(heater1.port, demand.heatPort)
      annotation (Line(points={{-100,48},{-70,48}}, color={191,0,0}));
    connect(const1.y, gridSstorage.T_Supply_Set) annotation (Line(points={{71,-52},
            {80,-52},{80,-32},{36,-32},{36,14},{54,14}},          color={0,0,
            127}));
    connect(heater1.Q_flow, gain.y)
      annotation (Line(points={{-120,48},{-135,48}}, color={0,0,127}));
    connect(sine.y, gain.u)
      annotation (Line(points={{-179,48},{-158,48}}, color={0,0,127}));
    connect(gridSstorage.port_b_Return, senTem1.port_a) annotation (Line(points=
           {{56,-8},{56,-6},{-72,-6},{-72,-10},{-82,-10}}, color={0,127,255}));
    connect(senTem1.port_b, producer.ports[1]) annotation (Line(points={{-98,-10},
            {-98,-56},{-61,-56},{-61,-48}},      color={0,127,255}));
    connect(gridSstorage.port_b_Supply, senTem2.port_a)
      annotation (Line(points={{56,8},{40,8}}, color={0,127,255}));
    connect(senTem2.port_b, demand.ports[1]) annotation (Line(points={{24,8},{
            12,8},{12,30},{-61.3333,30},{-61.3333,38},{-61,38}}, color={0,127,
            255}));
    connect(senTem3.port_b, gridSstorage.port_a_Supply) annotation (Line(points={{6,-53},
            {12,-53},{12,2},{56,2}},         color={0,127,255}));
    connect(producer.ports[2], senTem3.port_a) annotation (Line(points={{-59,-48},
            {-8,-48},{-8,-53}},        color={0,127,255}));
    connect(fan1.port_b, gridSstorage.port_a_Return)
      annotation (Line(points={{-46,-1},{56,-1},{56,-2}}, color={0,127,255}));
    connect(bou.ports[1], fan1.port_a) annotation (Line(points={{-106,24},{-76,
            24},{-76,-1},{-66,-1}}, color={0,127,255}));
    connect(demand.ports[2], fan1.port_a) annotation (Line(points={{-59,38},{
            -64,38},{-64,14},{-66,14},{-66,-1}}, color={0,127,255}));
    connect(conPID1.y, product1.u2) annotation (Line(points={{-207,-80},{-193,
            -80},{-193,-72},{-176,-72}}, color={0,0,127}));
    connect(product1.y, heater.Q_flow) annotation (Line(points={{-153,-66},{
            -150,-66},{-150,-38},{-126,-38}}, color={0,0,127}));
    connect(const.y, product1.u1) annotation (Line(points={{-189,-38},{-186,-38},
            {-186,-60},{-176,-60}}, color={0,0,127}));
    connect(const1.y, conPID1.u_s) annotation (Line(points={{71,-52},{78,-52},{
            78,-80},{-230,-80}}, color={0,0,127}));
    connect(senTem3.T, conPID1.u_m) annotation (Line(points={{-1,-43.1},{-1,-34},
            {-20,-34},{-20,-100},{-218,-100},{-218,-92}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=36000, __Dymola_Algorithm="Dassl"));
  end Test;

  model HeatPump_Basic
    Modules.ModularHeatPump.ModularHeatPump modularHeatPump(
      THotNom=318.15,
      PLRMin=0.3,
      DeltaTCon=5,
      TSourceInternal=false,
      dpInternal=10000,
      redeclare model PerDataMainHP =
          AixLib.DataBase.HeatPump.PerformanceData.LookUpTableNDNotManufacturerSlim)
      annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
    Fluid.Sources.Boundary_pT        bou(
      redeclare package Medium = AixLib.Media.Water,
      T=313.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
    AixLib.Controls.Interfaces.VapourCompressionMachineControlBus  sigBus
      annotation (Placement(transformation(extent={{-60,-62},{-30,-28}}),
          iconTransformation(extent={{-8,-22},{10,4}})));
    Fluid.Sources.Boundary_pT        bou1(redeclare package Medium =
          Media.Water, nPorts=1)
      annotation (Placement(transformation(extent={{98,-10},{78,10}})));
    Modelica.Blocks.Sources.RealExpression frequency(y=50)  annotation (
        Placement(transformation(
          extent={{-9,-12},{9,12}},
          rotation=0,
          origin={-123,-48})));
    Modelica.Blocks.Sources.RealExpression m_flow_set(y=1) "[0.1 ... 1]"
                                                           annotation (
        Placement(transformation(
          extent={{-9,-12},{9,12}},
          rotation=0,
          origin={-125,-72})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
      annotation (Placement(transformation(extent={{-116,-38},{-96,-18}})));
    Modelica.Blocks.Sources.RealExpression t_Hot_Set(y=45) annotation (
        Placement(transformation(
          extent={{-9,-12},{9,12}},
          rotation=0,
          origin={-125,-96})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
      annotation (Placement(transformation(extent={{-14,-110},{6,-90}})));
    Modelica.Blocks.Sources.RealExpression t_Source_Set(y=10) annotation (
        Placement(transformation(
          extent={{-9,-12},{9,12}},
          rotation=0,
          origin={-127,-120})));
    Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
      annotation (Placement(transformation(extent={{-86,-130},{-66,-110}})));
  equation
    connect(sigBus, modularHeatPump.sigBus) annotation (Line(
        points={{-45,-45},{-22,-45},{-22,-3.9},{-7.9,-3.9}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(bou.ports[1], modularHeatPump.port_a)
      annotation (Line(points={{-48,0},{-8,0}}, color={0,127,255}));
    connect(modularHeatPump.port_b, bou1.ports[1])
      annotation (Line(points={{12,0},{78,0}}, color={0,127,255}));
    connect(frequency.y, sigBus.frequency) annotation (Line(points={{-113.1,-48},
            {-44.925,-48},{-44.925,-44.915}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(m_flow_set.y, sigBus.mFlowSetExternal) annotation (Line(points={{-115.1,
            -72},{-44.925,-72},{-44.925,-44.915}},       color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sigBus.OnOff, booleanExpression.y) annotation (Line(
        points={{-44.925,-44.915},{-90,-44.915},{-90,-28},{-95,-28}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(t_Hot_Set.y, toKelvin.Celsius) annotation (Line(points={{-115.1,-96},
            {-90,-96},{-90,-94},{-16,-94},{-16,-100}}, color={0,0,127}));
    connect(toKelvin.Kelvin, sigBus.THotSet) annotation (Line(points={{7,-100},
            {22,-100},{22,-98},{32,-98},{32,-44.915},{-44.925,-44.915}}, color=
            {0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(t_Source_Set.y, toKelvin1.Celsius)
      annotation (Line(points={{-117.1,-120},{-88,-120}}, color={0,0,127}));
    connect(toKelvin1.Kelvin, sigBus.TSourceSet) annotation (Line(points={{-65,
            -120},{54,-120},{54,-44.915},{-44.925,-44.915}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=10000, __Dymola_Algorithm="Dassl"));
  end HeatPump_Basic;
end Examples;
