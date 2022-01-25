within ControlUnity.Modules;
package Tester_NEW "Tester models for the modules"
  model Boiler
     extends
      AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer.SimpleConsumer(
      vol(
        T_start=293.15,
        m_flow_nominal=1, nPorts=2),
      bou(nPorts=1),
      TSpeicher(y=60 + 273.15),
      sine(
        amplitude=-30000,
        freqHz=1/3600,
        offset=-50000));
    ModularBoiler_TwoPositionController modularBoiler_1_1(TColdNom=333.15, QNom=
          100000)
      annotation (Placement(transformation(extent={{-38,-8},{-18,12}})));
    AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
      annotation (Placement(transformation(extent={{-98,8},{-78,28}})));
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
    connect(boilerControlBus, modularBoiler_1_1.boilerControlBus) annotation (
        Line(
        points={{-88,18},{-72,18},{-72,8},{-52,8},{-52,11.8},{-32,11.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(boilerControlBus.PLR, switch1.y) annotation (Line(
        points={{-87.95,18.05},{-87.95,-8},{-52,-8},{-52,-29},{-59.1,-29}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(modularBoiler_1_1.port_b, vol.ports[1]) annotation (Line(points={{-18,
            2},{-12,2},{-12,0},{0,0},{0,4},{46,4}}, color={0,127,255}));
    connect(bou.ports[1], modularBoiler_1_1.port_a) annotation (Line(points={{0,-40},
            {6,-40},{6,-38},{8,-38},{8,-20},{-36,-20},{-36,2},{-38,2}}, color={0,
            127,255}));
    connect(vol.ports[2], pipe.port_a) annotation (Line(points={{46,4},{46,-16},
            {46,-34},{44,-34}}, color={0,127,255}));
    connect(pipe.port_b, modularBoiler_1_1.port_a) annotation (Line(points={{22,-34},
            {16,-34},{16,-18},{-48,-18},{-48,2},{-38,2}}, color={0,127,255}));
    connect(temperatureSensor.T, modularBoiler_1_1.TLayers[1]) annotation (Line(
          points={{62,-14},{70,-14},{70,52},{-25.9,52},{-25.9,11.1}}, color={0,0,
            127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=10000));
  end Boiler;

  model BoilerTesterTwoPositionController
    "Test model for the controller model of the boiler"

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      nPorts=2,
      redeclare package Medium = AixLib.Media.Water,
      V=3)
      annotation (Placement(transformation(extent={{52,22},{72,42}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={16,48})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-50000)
      annotation (Placement(transformation(extent={{-68,66},{-48,86}})));
    AixLib.Fluid.Sources.Boundary_pT
                        bou(
      use_T_in=false,
      redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
      annotation (Placement(transformation(extent={{-4,-32},{16,-12}})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-104,26},{-92,46}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{58,-6},{78,14}})));
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
      annotation (Placement(transformation(extent={{60,-26},{38,-6}})));

    AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
                                         boilerControlBus
      annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
    ModularBoiler                       modularBoiler_Controller(
      TColdNom=333.15,
      QNom=100000,
      simpleTwoPosition=true,
      use_advancedControl=false,
      Tref=343.15,
      bandwidth=4,
      severalHeatcurcuits=false,
      TVar=false)
           annotation (Placement(transformation(extent={{-32,14},{-12,34}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-104,2},{-84,22}})));
  equation
    connect(heater.port,vol. heatPort) annotation (Line(points={{16,38},{16,32},{
            52,32}},                    color={191,0,0}));
    connect(sine.y,heater. Q_flow)
      annotation (Line(points={{-47,76},{16,76},{16,58}},
                                                        color={0,0,127}));
    connect(vol.heatPort,temperatureSensor. port)
      annotation (Line(points={{52,32},{52,4},{58,4}},     color={191,0,0}));
    connect(vol.ports[1],pipe. port_a) annotation (Line(points={{60,22},{60,-16},
            {60,-16}},          color={0,127,255}));
    connect(boilerControlBus, modularBoiler_Controller.boilerControlBus)
      annotation (Line(
        points={{-72,36},{-50,36},{-50,33.8},{-28.4,33.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-91.4,36},{-82,
            36},{-82,36.05},{-71.95,36.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(vol.ports[2], modularBoiler_Controller.port_b) annotation (Line(
          points={{64,22},{26,22},{26,24},{-12,24}}, color={0,127,255}));
    connect(pipe.port_b, modularBoiler_Controller.port_a) annotation (Line(points=
           {{38,-16},{30,-16},{30,6},{-42,6},{-42,24},{-32,24}}, color={0,127,255}));
    connect(bou.ports[1], modularBoiler_Controller.port_a) annotation (Line(
          points={{16,-22},{18,-22},{18,0},{-32,0},{-32,24}}, color={0,127,255}));
    connect(isOn.y, boilerControlBus.isOn) annotation (Line(points={{-83,12},{
            -71.95,12},{-71.95,36.05}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterTwoPositionController;

  model BoilerTesterFlowtemperatureControl
    "Test model for the controller model of the boiler"

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      nPorts=2,
      redeclare package Medium = AixLib.Media.Water,
      V=3)
      annotation (Placement(transformation(extent={{52,22},{72,42}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={16,48})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-50000)
      annotation (Placement(transformation(extent={{-68,68},{-48,88}})));
    AixLib.Fluid.Sources.Boundary_pT
                        bou(
      use_T_in=false,
      redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
      annotation (Placement(transformation(extent={{-4,-32},{16,-12}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{58,-6},{78,14}})));
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
      annotation (Placement(transformation(extent={{60,-26},{38,-6}})));

    AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
                                         boilerControlBus
      annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
    ModularBoiler                                 modularBoiler_Controller(
      TColdNom=333.15,
      QNom=100000,
      m_flowVar=false,
      Advanced=false,
      dTWaterSet=20,
      n=1,
      simpleTwoPosition=true,
      use_advancedControl=true,
      severalHeatcurcuits=false,
      declination=2.3,
      TMax=378.15)
      annotation (Placement(transformation(extent={{-28,12},{-8,32}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=-20,
      duration=20000,
      offset=273.15,
      startTime=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={84,84})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-118,24},{-98,44}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-98,-14},{-78,6}})));
  equation
    connect(heater.port,vol. heatPort) annotation (Line(points={{16,38},{16,32},{52,
            32}},                       color={191,0,0}));
    connect(sine.y,heater. Q_flow)
      annotation (Line(points={{-47,78},{16,78},{16,58}},
                                                        color={0,0,127}));
    connect(vol.heatPort,temperatureSensor. port)
      annotation (Line(points={{52,32},{52,4},{58,4}},     color={191,0,0}));
    connect(vol.ports[1],pipe. port_a) annotation (Line(points={{60,22},{60,-16},{
            60,-16}},           color={0,127,255}));
    connect(vol.ports[2], modularBoiler_Controller.port_b) annotation (Line(
          points={{64,22},{-8,22}},                  color={0,127,255}));
    connect(pipe.port_b, modularBoiler_Controller.port_a) annotation (Line(points={{38,-16},
            {30,-16},{30,6},{-42,6},{-42,22},{-28,22}},          color={0,127,255}));
    connect(bou.ports[1], modularBoiler_Controller.port_a) annotation (Line(
          points={{16,-22},{18,-22},{18,0},{-28,0},{-28,22}}, color={0,127,255}));
    connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-97,34},{-86,
            34},{-86,36.05},{-71.95,36.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(isOn.y, boilerControlBus.isOn) annotation (Line(points={{-77,-4},{
            -71.95,-4},{-71.95,36.05}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(boilerControlBus, modularBoiler_Controller.boilerControlBus)
      annotation (Line(
        points={{-72,36},{-48,36},{-48,31.8},{-24.4,31.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(ramp.y, boilerControlBus.Tamb) annotation (Line(points={{84,73},{84,
            62},{-44,62},{-44,50},{-72,50},{-72,36}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterFlowtemperatureControl;

  model BoilerTesterFlowtemperatureControl_admixture
    "Test model for the controller model of the boiler"

  package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);
    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=3)
      annotation (Placement(transformation(extent={{52,22},{72,42}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={16,48})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=-20000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{-32,66},{-12,86}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{66,-8},{86,12}})));

    ModularBoiler                             modularBoiler_Controller(
      TColdNom=333.15,
      QNom=200000,
      n=1,
      simpleTwoPosition=true,
      use_advancedControl=true,
      k=2,
      TBoiler=348.15,
      severalHeatcurcuits=true,
      TVar=true)
      annotation (Placement(transformation(extent={{-34,18},{-14,38}})));
    flowTemperatureController.renturnAdmixture.BoilerControlBus_admixture
      boilerControlBus_admixture
      annotation (Placement(transformation(extent={{-82,40},{-62,60}})));
    parameter Integer n=2 "Number of layers in the buffer storage";
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-124,38},{-104,58}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-112,24},{-100,38}})));
    flowTemperatureController.renturnAdmixture.Admix_modularBoiler admix_modularBoiler(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
      valveCharacteristic=
          AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
      redeclare package Medium = Medium,
      m_flow_nominal=0.1,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      length=1,
      Kv=10,
      T_amb=293.15,
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)))
      annotation (Placement(transformation(
          extent={{-13,-13},{13,13}},
          rotation=270,
          origin={25,-19})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 60)
      annotation (Placement(transformation(
          extent={{-6,-5},{6,5}},
          rotation=-90,
          origin={-32,53})));
    Modelica.Blocks.Sources.Constant RPM(k=2000)
      annotation (Placement(transformation(extent={{-114,-2},{-94,18}})));
    AixLib.Fluid.Sources.Boundary_pT
                        boundary_ph5(redeclare package Medium = Medium, nPorts=1)
                                                       annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={114,22})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 67)
      annotation (Placement(transformation(
          extent={{-6,-5},{6,5}},
          rotation=-90,
          origin={-12,53})));
    flowTemperatureController.renturnAdmixture.Admix_modularBoiler admix_modularBoiler1(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
      valveCharacteristic=
          AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
      redeclare package Medium = Medium,
      m_flow_nominal=0.1,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      length=1,
      Kv=10,
      T_amb=293.15,
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)))
      annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=270,
          origin={-48,-26})));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=-25000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{-98,-70},{-88,-60}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater1
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-82,-50})));
    AixLib.Fluid.MixingVolumes.MixingVolume vol1(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=3)
      annotation (Placement(transformation(extent={{-72,-70},{-58,-54}})));
    AixLib.Fluid.Sources.Boundary_pT
                        boundary_ph1(redeclare package Medium = Medium, nPorts=
          1)                                           annotation(Placement(transformation(extent={{8,-8},{
              -8,8}},                                                                                                       rotation=0,     origin={-24,-70})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{-68,-88},{-54,-74}})));
    Modelica.Blocks.Sources.Constant RPM1(k=2000)
      annotation (Placement(transformation(extent={{4,-86},{16,-74}})));
    Modelica.Blocks.Sources.RealExpression PLR1(y=1)
      annotation (Placement(transformation(extent={{-2,-70},{12,-56}})));
    Modelica.Blocks.Sources.BooleanExpression isOn1(y=true)
      annotation (Placement(transformation(extent={{4,-114},{16,-100}})));
    flowTemperatureController.renturnAdmixture.BoilerControlBus_admixture
      boilerControlBus_admixture1
      annotation (Placement(transformation(extent={{40,-88},{60,-68}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=15,
      duration=60000,
      offset=273.15 + 75)
      annotation (Placement(transformation(extent={{-58,62},{-44,76}})));
  equation
    connect(heater.port,vol. heatPort) annotation (Line(points={{16,38},{16,32},{52,
            32}},                       color={191,0,0}));
    connect(sine.y,heater. Q_flow)
      annotation (Line(points={{-11,76},{16,76},{16,58}},
                                                        color={0,0,127}));
    connect(vol.heatPort,temperatureSensor. port)
      annotation (Line(points={{52,32},{52,2},{66,2}},     color={191,0,0}));
    connect(PLR.y, boilerControlBus_admixture.PLR) annotation (Line(points={{-103,
            48},{-88,48},{-88,50.05},{-71.95,50.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(isOn.y, boilerControlBus_admixture.isOn) annotation (Line(points={{-99.4,
            31},{-90,31},{-90,32},{-80,32},{-80,46},{-76,46},{-76,50.05},{-71.95,50.05}},
          color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(boilerControlBus_admixture, admix_modularBoiler.boilerControlBus_admixture)
      annotation (Line(
        points={{-72,50},{-70,50},{-70,98},{130,98},{130,-18},{114,-18},{114,
            -19},{38,-19}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(modularBoiler_Controller.port_b, admix_modularBoiler.port_a1)
      annotation (Line(points={{-14,28},{8,28},{8,2},{32.8,2},{32.8,-6}},
                                                                       color={0,
            127,255}));
    connect(admix_modularBoiler.port_b2, modularBoiler_Controller.port_a)
      annotation (Line(points={{17.2,-6},{17.2,6},{-42,6},{-42,28},{-34,28}},
                                                                         color={0,
            127,255}));
    connect(RPM.y, boilerControlBus_admixture.pumpBus.rpmSet) annotation (Line(
          points={{-93,8},{-71.95,8},{-71.95,50.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(admix_modularBoiler.port_b1, vol.ports[1]) annotation (Line(points={{32.8,
            -32},{32.8,-38},{59.3333,-38},{59.3333,22}},
                                                color={0,127,255}));
    connect(vol.ports[2], admix_modularBoiler.port_a2) annotation (Line(points={{62,22},
            {62,-44},{17.2,-44},{17.2,-32}},          color={0,127,255}));
    connect(boundary_ph5.ports[1], vol.ports[3])
      annotation (Line(points={{104,22},{64.6667,22}}, color={0,127,255}));
    connect(boilerControlBus_admixture, modularBoiler_Controller.boilerControlBus)
      annotation (Line(
        points={{-72,50},{-56,50},{-56,48},{-38,48},{-38,37.8},{-30.4,37.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, modularBoiler_Controller.TCon[1]) annotation (
        Line(points={{-32,46.4},{-32,40},{-24.8,40},{-24.8,39}}, color={0,0,127}));
    connect(realExpression1.y, modularBoiler_Controller.TCon[2]) annotation (
        Line(points={{-12,46.4},{-12,37},{-24.8,37}}, color={0,0,127}));
    connect(temperatureSensor.T, modularBoiler_Controller.TMeaCon[1])
      annotation (Line(points={{86,2},{94,2},{94,16},{28,16},{28,30.4},{-14,
            30.4}}, color={0,0,127}));
    connect(modularBoiler_Controller.valPos[1], admix_modularBoiler.valveSet)
      annotation (Line(points={{-14,34.3},{-8,34.3},{-8,32},{12,32},{12,8},{50,
            8},{50,-14.32},{41.12,-14.32}}, color={0,0,127}));
    connect(modularBoiler_Controller.valPos[2], admix_modularBoiler1.valveSet)
      annotation (Line(points={{-14,35.3},{-10,35.3},{-10,36},{-4,36},{-4,
            -20.96},{-30.64,-20.96}}, color={0,0,127}));
    connect(heater1.port, vol1.heatPort) annotation (Line(points={{-82,-58},{
            -82,-62},{-72,-62}}, color={191,0,0}));
    connect(temperatureSensor1.port, vol1.heatPort) annotation (Line(points={{
            -68,-81},{-70,-81},{-70,-82},{-72,-82},{-72,-62}}, color={191,0,0}));
    connect(boundary_ph1.ports[1], vol1.ports[1])
      annotation (Line(points={{-32,-70},{-66.8667,-70}}, color={0,127,255}));
    connect(modularBoiler_Controller.port_b, admix_modularBoiler1.port_a1)
      annotation (Line(points={{-14,28},{-16,28},{-16,-8},{-39.6,-8},{-39.6,-12}},
          color={0,127,255}));
    connect(admix_modularBoiler1.port_b2, modularBoiler_Controller.port_a)
      annotation (Line(points={{-56.4,-12},{-56.4,28},{-34,28}}, color={0,127,
            255}));
    connect(admix_modularBoiler1.port_b1, vol1.ports[2]) annotation (Line(
          points={{-39.6,-40},{-39.6,-54},{-54,-54},{-54,-70},{-65,-70}}, color=
           {0,127,255}));
    connect(sine1.y, heater1.Q_flow) annotation (Line(points={{-87.5,-65},{-86,
            -65},{-86,-38},{-82,-38},{-82,-42}}, color={0,0,127}));
    connect(vol1.ports[3], admix_modularBoiler1.port_a2) annotation (Line(
          points={{-63.1333,-70},{-84,-70},{-84,-76},{-102,-76},{-102,-32},{-68,
            -32},{-68,-44},{-56.4,-44},{-56.4,-40}}, color={0,127,255}));
    connect(temperatureSensor1.T, modularBoiler_Controller.TMeaCon[2])
      annotation (Line(points={{-54,-81},{-30,-81},{-30,-82},{-10,-82},{-10,
            32.4},{-14,32.4}}, color={0,0,127}));
    connect(RPM1.y,boilerControlBus_admixture1. pumpBus.rpmSet) annotation (Line(
          points={{16.6,-80},{34,-80},{34,-77.95},{50.05,-77.95}},      color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(PLR1.y,boilerControlBus_admixture1. PLR) annotation (Line(points={{12.7,
            -63},{50.05,-63},{50.05,-77.95}},          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(isOn1.y,boilerControlBus_admixture1. isOn) annotation (Line(points={{16.6,
            -107},{50.05,-107},{50.05,-77.95}},        color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(boilerControlBus_admixture1, admix_modularBoiler1.boilerControlBus_admixture)
      annotation (Line(
        points={{50,-78},{78,-78},{78,-48},{-4,-48},{-4,-26},{-34,-26}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ramp.y, modularBoiler_Controller.TBoilerVar) annotation (Line(
          points={{-43.3,69},{-36,69},{-36,44},{-20.8,44},{-20.8,38}}, color={0,
            0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterFlowtemperatureControl_admixture;

  model BoilerTesterTwoPositionControllerStorageBuffer
    "Test model for the controller model of the boiler"
    replaceable package Medium =
       Modelica.Media.Water.ConstantPropertyLiquidWater
       constrainedby Modelica.Media.Interfaces.PartialMedium;

         parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
            parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
              parameter Modelica.SIunits.HeatFlowRate QNom=modularBoiler_Controller.QNom "Thermal dimension power";
              parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
               parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";
               parameter Modelica.SIunits.Time t=60*60 "Time until the buffer storage is fully loaded" annotation(Dialog(enable= advancedVolume, group="Control"));
       parameter Modelica.SIunits.Density rhoW=997 "Density of water";
       parameter Modelica.SIunits.HeatCapacity cW=4180 "Heat Capacity of water";
       parameter Modelica.SIunits.TemperatureDifference dT=20;
       parameter Real l=1.73 "Relation between height and diameter of the buffer storage" annotation(Dialog(group="Control"));
        parameter Modelica.SIunits.Height hTank=(QNom*t*1.73^2/( Modelica.Constants.pi/4*rhoW*cW*dT))^(1/3) annotation(Evaluate=true, Dialog(group="Control"));
       parameter Modelica.SIunits.Diameter dTank=hTank/1.73 annotation(Evaluate=true, Dialog(group="Control"));
       parameter Modelica.SIunits.Height hUpperPortDemand=hTank - 0.1;
       parameter Modelica.SIunits.Height hUpperPortSupply=hTank - 0.1;


       //Consumer pump parametrizing
       parameter Modelica.SIunits.VolumeFlowRate V_flow_nominalC1=m_flow_nominalC1/Medium.d_const;
       parameter Modelica.SIunits.MassFlowRate m_flow_nominalC1=abs(sine.offset+sine.amplitude)/(Medium.cp_const*dTWaterNom);
        parameter Modelica.SIunits.VolumeFlowRate V_flow_nominalC2=m_flow_nominalC2/Medium.d_const;
         parameter Modelica.SIunits.MassFlowRate m_flow_nominalC2=abs(sine1.offset+sine1.amplitude)/(Medium.cp_const*dTWaterNom);

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=3)
      annotation (Placement(transformation(extent={{30,28},{50,48}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-6,54})));

    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{-44,68},{-24,88}})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-96,32},{-84,52}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{36,0},{56,20}})));

    AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
                                         boilerControlBus
      annotation (Placement(transformation(extent={{-78,32},{-58,52}})));
    ModularBoiler                                    modularBoiler_Controller(
      TColdNom=333.15,
      QNom=200000,
      n=modularBufferStorage.n,
      simpleTwoPosition=false,
      use_advancedControl=false,
      Tref=348.15,
      bandwidth=5,
      severalHeatcurcuits=false)
           annotation (Placement(transformation(extent={{-52,18},{-32,38}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
    AixLib.Fluid.Movers.SpeedControlled_y fan1(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_small=0.001,
      per(pressure(V_flow={0,V_flow_nominalC1,2*V_flow_nominalC1}, dp={dp_nominal/0.8,dp_nominal,0})),
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{72,-24},{52,-4}})));

    parameter AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data=
        AixLib.DataBase.Storage.Generic_New_2000l(hTank=hTank, dTank=dTank)
                                                    "Data record for Storage" annotation(Dialog(group="Control"));
    AixLib.Fluid.MixingVolumes.MixingVolume vol1(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=1,
      V=3,
      nPorts=2)
      annotation (Placement(transformation(extent={{36,-66},{52,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater1
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=-90,
          origin={23,-47})));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=-10000,
      freqHz=1/3600,
      offset=-20000)
      annotation (Placement(transformation(extent={{6,-42},{20,-28}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{42,-88},{56,-74}})));
    AixLib.Fluid.Movers.SpeedControlled_y fan2(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_small=0.001,
      per(pressure(V_flow={0,V_flow_nominalC2,2*V_flow_nominalC2}, dp={dp_nominal/0.8,dp_nominal,0})),
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{14,-90},{-2,-74}})));
    twoPositionController.ModularBufferStorage modularBufferStorage(
      QNom=QNom,
      dTWaterNom=modularBoiler_Controller.dTWaterNom,
      t(displayUnit="min") = 3600,
      hTank=2.4,
      dTank=1.2,
      advancedVolume=false,
      n=10,
      x=9,
      m2_flow_nominal=abs(sine.offset + sine.amplitude + sine1.offset + sine1.amplitude)/(Medium.cp_const
          *dTWaterNom))
           annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
    AixLib.Fluid.Sources.Boundary_pT
                        boundary_ph1(redeclare package Medium = Medium, nPorts=1)
                                                       annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={106,32})));
    AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
          AixLib.Media.Water, m_flow_nominal=1)
      annotation (Placement(transformation(extent={{12,4},{32,24}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=0.5)
      annotation (Placement(transformation(extent={{84,2},{70,16}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=0.5)
      annotation (Placement(transformation(extent={{-30,-72},{-16,-58}})));
  equation


    connect(heater.port,vol. heatPort) annotation (Line(points={{-6,44},{-6,38},{30,
            38}},                       color={191,0,0}));
    connect(sine.y,heater. Q_flow)
      annotation (Line(points={{-23,78},{-6,78},{-6,64}},
                                                        color={0,0,127}));
    connect(vol.heatPort,temperatureSensor. port)
      annotation (Line(points={{30,38},{30,10},{36,10}},   color={191,0,0}));
    connect(boilerControlBus, modularBoiler_Controller.boilerControlBus)
      annotation (Line(
        points={{-68,42},{-60,42},{-60,38},{-56,38},{-56,37.8},{-48.4,37.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(isOn.y, boilerControlBus.isOn) annotation (Line(points={{-79,20},{-67.95,
            20},{-67.95,42.05}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(vol.ports[1], fan1.port_a) annotation (Line(points={{37.3333,28},{
            56,28},{56,22},{84,22},{84,-14},{72,-14}},color={0,127,255}));
    connect(heater1.port,vol1. heatPort)
      annotation (Line(points={{23,-54},{23,-58},{36,-58}}, color={191,0,0}));
    connect(sine1.y,heater1. Q_flow)
      annotation (Line(points={{20.7,-35},{23,-35},{23,-40}}, color={0,0,127}));
    connect(vol1.heatPort,temperatureSensor1. port)
      annotation (Line(points={{36,-58},{36,-81},{42,-81}}, color={191,0,0}));
    connect(vol1.ports[1],fan2. port_a) annotation (Line(points={{42.4,-66},{42,-66},{42,-76},{20,-76},
            {20,-82},{14,-82}},                        color={0,127,255}));
    connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-83.4,42},{-76,
            42},{-76,42.05},{-67.95,42.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(modularBoiler_Controller.port_b, modularBufferStorage.fluidportTop1)
      annotation (Line(points={{-32,28},{6,28},{6,8}}, color={0,127,255}));
    connect(modularBufferStorage.fluidportBottom1, modularBoiler_Controller.port_a)
      annotation (Line(points={{6,-12},{6,-20},{-62,-20},{-62,28},{-52,28}}, color={0,127,255}));
    connect(fan1.port_b, modularBufferStorage.fluidportBottom2) annotation (Line(points={{52,
            -14},{40,-14},{40,-16},{-6,-16},{-6,-12}}, color={0,127,255}));
    connect(fan2.port_b, modularBufferStorage.fluidportBottom2)
      annotation (Line(points={{-2,-82},{-6,-82},{-6,-12}}, color={0,127,255}));
    connect(modularBufferStorage.TLayer, modularBoiler_Controller.TLayers) annotation (Line(
          points={{-11,3},{-24,3},{-24,44},{-39.9,44},{-39.9,37.1}}, color={0,0,127}));
    connect(boundary_ph1.ports[1], vol.ports[2])
      annotation (Line(points={{96,32},{70,32},{70,28},{40,28}}, color={0,127,255}));
    connect(senTem.port_a, modularBufferStorage.fluidportTop2)
      annotation (Line(points={{12,14},{4,14},{4,8},{-6,8}}, color={0,127,255}));
    connect(senTem.port_b, vol.ports[3]) annotation (Line(points={{32,14},{38,
            14},{38,28},{42.6667,28}},
                  color={0,127,255}));
    connect(realExpression.y, fan1.y)
      annotation (Line(points={{69.3,9},{62,9},{62,-2}}, color={0,0,127}));
    connect(realExpression1.y, fan2.y)
      annotation (Line(points={{-15.3,-65},{6,-65},{6,-72.4}}, color={0,0,127}));
    connect(modularBufferStorage.fluidportTop2, vol1.ports[2]) annotation (Line(points={{-6,8},{-6,
            12},{16,12},{16,-10},{46,-10},{46,-50},{62,-50},{62,-66},{45.6,-66}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterTwoPositionControllerStorageBuffer;

  model BoilerTesterTwoPositionControllerStorageBufferOLD
    "Test model for the controller model of the boiler"
    replaceable package Medium =
       Modelica.Media.Water.ConstantPropertyLiquidWater
       constrainedby Modelica.Media.Interfaces.PartialMedium;

         parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
            parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
              parameter Modelica.SIunits.HeatFlowRate QNom=modularBoiler_Controller.QNom "Thermal dimension power";
              parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
               parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";
               parameter Modelica.SIunits.Time t=60*60 "Time until the buffer storage is fully loaded" annotation(Dialog(group="Control"));
       parameter Modelica.SIunits.Density rhoW=997 "Density of water";
       parameter Modelica.SIunits.HeatCapacity cW=4180 "Heat Capacity of water";
       parameter Modelica.SIunits.TemperatureDifference dT=20;
       parameter Real l=1.73 "Relation between height and diameter of the buffer storage" annotation(Dialog(group="Control"));
        parameter Modelica.SIunits.Height hTank=(QNom*t*1.73^2/( Modelica.Constants.pi/4*rhoW*cW*dT))^(1/3) annotation(Evaluate=true, Dialog(group="Control"));
       parameter Modelica.SIunits.Diameter dTank=hTank/1.73 annotation(Evaluate=true, Dialog(group="Control"));
       //parameter Modelica.SIunits.Height hUpperPortDemand=hTank - 0.1;
      // parameter Modelica.SIunits.Height hUpperPortSupply=hTank - 0.1;

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=3)
      annotation (Placement(transformation(extent={{30,28},{50,48}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-6,54})));

    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{-44,68},{-24,88}})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-96,32},{-84,52}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{36,0},{56,20}})));

    AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
                                         boilerControlBus
      annotation (Placement(transformation(extent={{-78,32},{-58,52}})));
    ModularBoiler                                    modularBoiler_Controller(
      TColdNom=333.15,
      QNom=100000,
      n=bufferStorage.n,
      simpleTwoPosition=false,
      use_advancedControl=false,
      Tref=328.15,
      bandwidth=2,
      severalHeatcurcuits=false)
           annotation (Placement(transformation(extent={{-54,18},{-34,38}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{-50,-4},
              {-38,8}})));
    AixLib.Fluid.Sources.Boundary_pT
                        boundary_ph5(redeclare package Medium = Medium, nPorts=1)
                                                       annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={92,36})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=1)
      annotation (Placement(transformation(extent={{82,6},{68,16}})));
    AixLib.Fluid.Movers.SpeedControlled_y fan1(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_small=0.001,
      per(pressure(V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/
              0.7,dp_nominal,0})),
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{72,-24},{52,-4}})));

    AixLib.Fluid.Storage.BufferStorage bufferStorage(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      m1_flow_nominal=1,
      m2_flow_nominal=1,
      mHC1_flow_nominal=boundary3.m_flow,
      n=10,
      redeclare package Medium = Medium,
      data=data,
      useHeatingCoil1=false,
      useHeatingCoil2=false,
      upToDownHC1=false,
      upToDownHC2=false,
      useHeatingRod=false,
      redeclare model HeatTransfer =
          AixLib.Fluid.Storage.BaseClasses.HeatTransferBuoyancyWetter,
      redeclare package MediumHC1 = Medium,
      redeclare package MediumHC2 = Medium,
      TStart=303.15,
      x=5)           annotation (Placement(transformation(extent={{6,-10},{-14,14}})));
    parameter AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data=
        AixLib.DataBase.Storage.Generic_New_2000l(hTank=hTank, dTank=dTank)
                                                    "Data record for Storage" annotation(Dialog(group="Control"));
    AixLib.Fluid.MixingVolumes.MixingVolume vol1(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=1,
      V=3,
      nPorts=2)
      annotation (Placement(transformation(extent={{36,-66},{50,-50}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater1
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=-90,
          origin={23,-47})));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=0,
      freqHz=1/3600,
      offset=0)
      annotation (Placement(transformation(extent={{4,-44},{18,-30}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{42,-88},{56,-74}})));
    AixLib.Fluid.Movers.SpeedControlled_y fan2(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_small=0.001,
      per(pressure(V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/0.7,
              dp_nominal,0})),
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{14,-88},{-2,-72}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=1)
      annotation (Placement(transformation(extent={{20,-64},{8,-56}})));
  equation

    ///Determination of storage volume

  //bufferStorage.data.dTank
  //bufferStorage.data.hTank

    connect(heater.port,vol. heatPort) annotation (Line(points={{-6,44},{-6,38},{30,
            38}},                       color={191,0,0}));
    connect(sine.y,heater. Q_flow)
      annotation (Line(points={{-23,78},{-6,78},{-6,64}},
                                                        color={0,0,127}));
    connect(vol.heatPort,temperatureSensor. port)
      annotation (Line(points={{30,38},{30,10},{36,10}},   color={191,0,0}));
    connect(boilerControlBus, modularBoiler_Controller.boilerControlBus)
      annotation (Line(
        points={{-68,42},{-60,42},{-60,38},{-56,38},{-56,37.8},{-50.4,37.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(isOn.y, boilerControlBus.isOn) annotation (Line(points={{-79,20},{-67.95,
            20},{-67.95,42.05}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(boundary_ph5.ports[1], vol.ports[1]) annotation (Line(points={{82,36},
            {62,36},{62,28},{37.3333,28}},
                                      color={0,127,255}));
    connect(vol.ports[2], fan1.port_a) annotation (Line(points={{40,28},{56,28},{56,
            22},{84,22},{84,-14},{72,-14}},           color={0,127,255}));
    connect(realExpression.y, fan1.y)
      annotation (Line(points={{67.3,11},{62,11},{62,-2}},    color={0,0,127}));
    connect(modularBoiler_Controller.port_b, bufferStorage.fluidportTop1)
      annotation (Line(points={{-34,28},{-0.5,28},{-0.5,14.12}}, color={0,127,255}));
    connect(bufferStorage.fluidportTop2, vol.ports[3]) annotation (Line(points={{-7.125,
            14.12},{-7.125,28},{42.6667,28}}, color={0,127,255}));
    connect(fan1.port_b, bufferStorage.fluidportBottom2) annotation (Line(points={{52,-14},
            {-6.875,-14},{-6.875,-10.12}},          color={0,127,255}));
    connect(bufferStorage.fluidportBottom1, modularBoiler_Controller.port_a)
      annotation (Line(points={{-0.625,-10.24},{-0.625,-16},{-60,-16},{-60,28},{-54,
            28}}, color={0,127,255}));
    connect(fixedTemperature.port, bufferStorage.heatportOutside) annotation (
        Line(points={{-38,2},{-24,2},{-24,2.72},{-13.75,2.72}},     color={191,0,0}));
    connect(heater1.port,vol1. heatPort)
      annotation (Line(points={{23,-54},{23,-58},{36,-58}}, color={191,0,0}));
    connect(sine1.y,heater1. Q_flow)
      annotation (Line(points={{18.7,-37},{23,-37},{23,-40}}, color={0,0,127}));
    connect(vol1.heatPort,temperatureSensor1. port)
      annotation (Line(points={{36,-58},{36,-81},{42,-81}}, color={191,0,0}));
    connect(vol1.ports[1],fan2. port_a) annotation (Line(points={{41.6,-66},{42,-66},{42,
            -76},{20,-76},{20,-80},{14,-80}},          color={0,127,255}));
    connect(realExpression1.y,fan2. y) annotation (Line(points={{7.4,-60},{6,-60},
            {6,-70.4}},       color={0,0,127}));
    connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-83.4,42},{-76,
            42},{-76,42.05},{-67.95,42.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(fan2.port_b, bufferStorage.fluidportBottom2) annotation (Line(points={
            {-2,-80},{-6.875,-80},{-6.875,-10.12}}, color={0,127,255}));
    connect(bufferStorage.port_b, vol1.ports[2]) annotation (Line(points={{8.25,2},{36,
            2},{36,-38},{60,-38},{60,-66},{44.4,-66}}, color={0,127,255}));
    connect(bufferStorage.TLayer, modularBoiler_Controller.TLayers) annotation
      (Line(points={{-15.25,8.72},{-18,8.72},{-18,14},{-28,14},{-28,46},{-41.9,
            46},{-41.9,37.1}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterTwoPositionControllerStorageBufferOLD;

  model BoilerTesterTwoPositionControllerBufferStorage
    "Test model for the controller model of the boiler"
    replaceable package Medium =
       Modelica.Media.Water.ConstantPropertyLiquidWater
       constrainedby Modelica.Media.Interfaces.PartialMedium;

         parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
            parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
              parameter Modelica.SIunits.HeatFlowRate QNom=100000 "Thermal dimension power";
              parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
               parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";

               //
                parameter Modelica.SIunits.Time t=60*80 "Time until the buffer storage is fully loaded";
       parameter Modelica.SIunits.Density rhoW=997 "Density of water";
       parameter Modelica.SIunits.HeatCapacity cW=4180 "Heat Capacity of water";
       parameter Modelica.SIunits.TemperatureDifference dT=20;
       //parameter Real l=1.73 "Relation between height and diameter of the buffer storage";

       parameter Modelica.SIunits.Height h=QNom*t/( Modelica.Constants.pi/4*d^2*rhoW*cW*dT);
       parameter Modelica.SIunits.Diameter d=h/1.73;
       parameter Modelica.SIunits.Volume V=Modelica.Constants.pi/4*d^2*h;

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=3)
      annotation (Placement(transformation(extent={{52,22},{72,42}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={16,48})));

    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-50000)
      annotation (Placement(transformation(extent={{-68,68},{-48,88}})));
    AixLib.Fluid.Sources.Boundary_pT
                        bou(
      use_T_in=false,
      redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
      annotation (Placement(transformation(extent={{-74,-26},{-54,-6}})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-104,26},{-92,46}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{58,-6},{78,14}})));

    AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
                                         boilerControlBus
      annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
    ModularBoiler_TwoPositionControllerBufferStorage modularBoiler_Controller(
      TColdNom=333.15,
      QNom=100000,
      n=1,
      Tref=333.15)
           annotation (Placement(transformation(extent={{-32,12},{-12,32}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-104,2},{-84,22}})));
    twoPositionController.Storage_modularBoiler storage_modularBoiler(
      x=5,
      n=10,
      d=d,
      h=h,
      lambda_ins=0.02,
      s_ins=0.1,
      hConIn=1500,
      hConOut=15,
      V_HE=0.1,
      k_HE=1500,
      A_HE=20,
      beta=0.00035,
      kappa=0.4,
      m_flow_nominal_layer=1,
      m_flow_nominal_HE=1)
      annotation (Placement(transformation(extent={{-2,-30},{18,-10}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{-26,-56},
              {-14,-44}})));
    AixLib.Fluid.Sources.Boundary_pT
                        boundary_ph5(redeclare package Medium = Medium, nPorts=1)
                                                       annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={114,30})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=1)
      annotation (Placement(transformation(extent={{100,-22},{86,-12}})));
    AixLib.Fluid.Movers.SpeedControlled_y fan1(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_small=0.001,
      per(pressure(V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/
              0.7,dp_nominal,0})),
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{78,-58},{58,-38}})));
  equation
    connect(heater.port,vol. heatPort) annotation (Line(points={{16,38},{16,32},{52,
            32}},                       color={191,0,0}));
    connect(sine.y,heater. Q_flow)
      annotation (Line(points={{-47,78},{16,78},{16,58}},
                                                        color={0,0,127}));
    connect(vol.heatPort,temperatureSensor. port)
      annotation (Line(points={{52,32},{52,4},{58,4}},     color={191,0,0}));
    connect(boilerControlBus, modularBoiler_Controller.boilerControlBus)
      annotation (Line(
        points={{-72,36},{-50,36},{-50,31.8},{-26,31.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-91.4,36},{-82,
            36},{-82,36.05},{-71.95,36.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(bou.ports[1], modularBoiler_Controller.port_a) annotation (Line(
          points={{-54,-16},{-20,-16},{-20,-2},{-32,-2},{-32,22}},
                                                              color={0,127,255}));
    connect(isOn.y, boilerControlBus.isOn) annotation (Line(points={{-83,12},{-71.95,
            12},{-71.95,36.05}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(modularBoiler_Controller.port_b, storage_modularBoiler.port_a_heatGenerator)
      annotation (Line(points={{-12,22},{10,22},{10,6},{28,6},{28,-11.2},{16.4,
            -11.2}},
          color={0,127,255}));
    connect(storage_modularBoiler.port_b_heatGenerator, modularBoiler_Controller.port_a)
      annotation (Line(points={{16.4,-28},{20,-28},{20,-30},{-40,-30},{-40,22},{
            -32,22}},
                  color={0,127,255}));
    connect(fixedTemperature.port, storage_modularBoiler.heatPort) annotation (
        Line(points={{-14,-50},{-6,-50},{-6,-20},{0,-20}}, color={191,0,0}));
    connect(vol.ports[1], storage_modularBoiler.port_b_consumer) annotation (Line(
          points={{59.3333,22},{59.3333,16},{12,16},{12,-4},{8,-4},{8,-10}},color=
           {0,127,255}));
    connect(boundary_ph5.ports[1], vol.ports[2]) annotation (Line(points={{104,30},
            {84,30},{84,22},{62,22}}, color={0,127,255}));
    connect(fan1.port_b, storage_modularBoiler.port_a_consumer)
      annotation (Line(points={{58,-48},{8,-48},{8,-30}}, color={0,127,255}));
    connect(vol.ports[3], fan1.port_a) annotation (Line(points={{64.6667,22},{
            78,22},{78,16},{106,16},{106,-48},{78,-48}},
                                                      color={0,127,255}));
    connect(realExpression.y, fan1.y)
      annotation (Line(points={{85.3,-17},{68,-17},{68,-36}}, color={0,0,127}));
    connect(storage_modularBoiler.TTop, modularBoiler_Controller.TLayers[1])
      annotation (Line(points={{19,-12.4},{34,-12.4},{34,30},{-12,30},{-12,40},{
            -19.9,40},{-19.9,31.1}},
                               color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterTwoPositionControllerBufferStorage;

  model BoilerTesterTwoPositionControllerBufferStorage2HeatCurcuits
    "Test model for the controller model of the boiler"
    replaceable package Medium =
       Modelica.Media.Water.ConstantPropertyLiquidWater
       constrainedby Modelica.Media.Interfaces.PartialMedium;

         parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
            parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
              parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Thermal dimension power";
              parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
               parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=3)
      annotation (Placement(transformation(extent={{48,48},{68,68}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={12,74})));

    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
    AixLib.Fluid.Sources.Boundary_pT
                        bou(
      use_T_in=false,
      redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
      annotation (Placement(transformation(extent={{-78,0},{-58,20}})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-108,52},{-96,72}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{54,20},{74,40}})));

    AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
                                         boilerControlBus
      annotation (Placement(transformation(extent={{-86,52},{-66,72}})));
    ModularBoiler_TwoPositionControllerBufferStorage modularBoiler_Controller(
      TColdNom=333.15,
      QNom=100000,
      n=1) annotation (Placement(transformation(extent={{-36,38},{-16,58}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-108,28},{-88,48}})));
    twoPositionController.Storage_modularBoiler storage_modularBoiler(
      x=5,
      n=10,
      d=1.5,
      h=3,
      lambda_ins=0.02,
      s_ins=0.1,
      hConIn=1500,
      hConOut=15,
      V_HE=0.1,
      k_HE=1500,
      A_HE=20,
      beta=0.00035,
      kappa=0.4,
      m_flow_nominal_layer=1,
      m_flow_nominal_HE=1)
      annotation (Placement(transformation(extent={{-8,-2},{12,18}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)   annotation(Placement(transformation(extent={{-30,-22},
              {-18,-10}})));
    AixLib.Fluid.Sources.Boundary_pT
                        boundary_ph5(redeclare package Medium = Medium, nPorts=1)
                                                       annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={110,56})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=1)
      annotation (Placement(transformation(extent={{96,4},{82,14}})));
    AixLib.Fluid.Movers.SpeedControlled_y fan1(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_small=0.001,
      per(pressure(V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/
              0.7,dp_nominal,0})),
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{74,-20},{54,0}})));
    AixLib.Fluid.MixingVolumes.MixingVolume vol1(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=1,
      V=3,
      nPorts=2)
      annotation (Placement(transformation(extent={{48,-74},{62,-58}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater1
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=-90,
          origin={35,-55})));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=-10000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{16,-46},{30,-32}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{54,-96},{68,-82}})));
    AixLib.Fluid.Movers.SpeedControlled_y fan2(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_small=0.001,
      per(pressure(V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/
              0.7,dp_nominal,0})),
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{26,-96},{10,-80}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=1)
      annotation (Placement(transformation(extent={{32,-72},{20,-64}})));
  equation
    connect(heater.port,vol. heatPort) annotation (Line(points={{12,64},{12,58},{
            48,58}},                    color={191,0,0}));
    connect(sine.y,heater. Q_flow)
      annotation (Line(points={{-9,90},{12,90},{12,84}},color={0,0,127}));
    connect(vol.heatPort,temperatureSensor. port)
      annotation (Line(points={{48,58},{48,30},{54,30}},   color={191,0,0}));
    connect(boilerControlBus, modularBoiler_Controller.boilerControlBus)
      annotation (Line(
        points={{-76,62},{-54,62},{-54,57.8},{-30,57.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-95.4,62},{-86,
            62},{-86,62.05},{-75.95,62.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(bou.ports[1], modularBoiler_Controller.port_a) annotation (Line(
          points={{-58,10},{-24,10},{-24,24},{-36,24},{-36,48}},
                                                              color={0,127,255}));
    connect(isOn.y, boilerControlBus.isOn) annotation (Line(points={{-87,38},{
            -75.95,38},{-75.95,62.05}},
                                 color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(modularBoiler_Controller.port_b, storage_modularBoiler.port_a_heatGenerator)
      annotation (Line(points={{-16,48},{6,48},{6,32},{24,32},{24,16.8},{10.4,
            16.8}},
          color={0,127,255}));
    connect(storage_modularBoiler.port_b_heatGenerator, modularBoiler_Controller.port_a)
      annotation (Line(points={{10.4,0},{16,0},{16,-4},{-44,-4},{-44,48},{-36,
            48}}, color={0,127,255}));
    connect(fixedTemperature.port, storage_modularBoiler.heatPort) annotation (
        Line(points={{-18,-16},{-10,-16},{-10,8},{-6,8}},  color={191,0,0}));
    connect(vol.ports[1], storage_modularBoiler.port_b_consumer) annotation (Line(
          points={{55.3333,48},{55.3333,42},{8,42},{8,22},{2,22},{2,18}},   color=
           {0,127,255}));
    connect(boundary_ph5.ports[1], vol.ports[2]) annotation (Line(points={{100,56},
            {80,56},{80,48},{58,48}}, color={0,127,255}));
    connect(fan1.port_b, storage_modularBoiler.port_a_consumer)
      annotation (Line(points={{54,-10},{2,-10},{2,-2}},  color={0,127,255}));
    connect(vol.ports[3], fan1.port_a) annotation (Line(points={{60.6667,48},{
            74,48},{74,42},{102,42},{102,-10},{74,-10}},
                                                      color={0,127,255}));
    connect(realExpression.y, fan1.y)
      annotation (Line(points={{81.3,9},{64,9},{64,2}},       color={0,0,127}));
    connect(storage_modularBoiler.TTop, modularBoiler_Controller.TLayers[1])
      annotation (Line(points={{13,15.6},{30,15.6},{30,56},{-16,56},{-16,66},{
            -23.9,66},{-23.9,57.1}}, color={0,0,127}));
    connect(heater1.port, vol1.heatPort)
      annotation (Line(points={{35,-62},{35,-66},{48,-66}}, color={191,0,0}));
    connect(sine1.y, heater1.Q_flow)
      annotation (Line(points={{30.7,-39},{35,-39},{35,-48}}, color={0,0,127}));
    connect(vol1.heatPort, temperatureSensor1.port)
      annotation (Line(points={{48,-66},{48,-89},{54,-89}}, color={191,0,0}));
    connect(vol1.ports[1], fan2.port_a) annotation (Line(points={{53.6,-74},{54,
            -74},{54,-84},{32,-84},{32,-88},{26,-88}}, color={0,127,255}));
    connect(fan2.port_b, storage_modularBoiler.port_a_consumer) annotation (Line(
          points={{10,-88},{6,-88},{6,-2},{2,-2}}, color={0,127,255}));
    connect(realExpression1.y, fan2.y) annotation (Line(points={{19.4,-68},{18,
            -68},{18,-78.4}}, color={0,0,127}));
    connect(storage_modularBoiler.port_b, vol1.ports[2]) annotation (Line(points={{12.6,
            7.8},{46,7.8},{46,-50},{66,-50},{66,-74},{56.4,-74}},        color={0,
            127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterTwoPositionControllerBufferStorage2HeatCurcuits;

  model BoilerTesterFlowtemperatureControl_admixture2HeatCurcuits
    "Test model for the controller model of the boiler"

  package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);
    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=3)
      annotation (Placement(transformation(extent={{52,22},{72,42}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={16,48})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{-60,66},{-40,86}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{66,-8},{86,12}})));

    flowTemperatureController.renturnAdmixture.BoilerControlBus_admixture
      boilerControlBus_admixture
      annotation (Placement(transformation(extent={{-82,40},{-62,60}})));
    ModularBoiler_FlowTemperatureControlAdmix modularBoiler_Controller(
      TColdNom=333.15,
      QNom=100000,
      m_flowVar=false,
      n=1,
      use_advancedControl=true,
      severalHeatcurcuits=true,
      k=2,
      Tset={(273.15 + 60) + 273.15,(273.15 + 67) + 273.15})
      annotation (Placement(transformation(extent={{-34,14},{-14,34}})));
    parameter Integer n=2 "Number of layers in the buffer storage";
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-124,38},{-104,58}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-112,24},{-100,38}})));
    flowTemperatureController.renturnAdmixture.Admix_modularBoiler admix_modularBoiler(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
      valveCharacteristic=
          AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
      redeclare package Medium = Medium,
      m_flow_nominal=0.1,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      length=1,
      Kv=10,
      T_amb=293.15,
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)))
      annotation (Placement(transformation(
          extent={{-12,-12},{12,12}},
          rotation=270,
          origin={18,-16})));
    Modelica.Blocks.Sources.Constant RPM(k=2000)
      annotation (Placement(transformation(extent={{-114,-2},{-94,18}})));
    AixLib.Fluid.Sources.Boundary_pT
                        boundary_ph5(redeclare package Medium = Medium, nPorts=1)
                                                       annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={114,22})));
    flowTemperatureController.renturnAdmixture.Admix_modularBoiler admix_modularBoiler1(
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
      valveCharacteristic=
          AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
      redeclare package Medium = Medium,
      m_flow_nominal=0.1,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      length=1,
      Kv=10,
      T_amb=293.15,
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)))
      annotation (Placement(transformation(
          extent={{-12,-12},{12,12}},
          rotation=270,
          origin={-44,-74})));
    AixLib.Fluid.MixingVolumes.MixingVolume vol1(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=1,
      V=3,
      nPorts=3)
      annotation (Placement(transformation(extent={{-2,-72},{12,-58}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater1
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-6,-48})));
    Modelica.Blocks.Sources.Sine sine1(
      amplitude=-10000,
      freqHz=1/7200,
      offset=-30000)
      annotation (Placement(transformation(extent={{-24,-42},{-10,-28}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{2,-88},{14,-76}})));
    AixLib.Fluid.Sources.Boundary_pT
                        boundary_ph1(redeclare package Medium = Medium, nPorts=1)
                                                       annotation(Placement(transformation(extent={{6,-6},{
              -6,6}},                                                                                                       rotation=0,     origin={24,-72})));
    flowTemperatureController.renturnAdmixture.BoilerControlBus_admixture
      boilerControlBus_admixture1
      annotation (Placement(transformation(extent={{-80,-56},{-60,-36}})));
    Modelica.Blocks.Sources.Constant RPM1(k=2000)
      annotation (Placement(transformation(extent={{-116,-54},{-104,-42}})));
    Modelica.Blocks.Sources.RealExpression PLR1(y=1)
      annotation (Placement(transformation(extent={{-122,-38},{-108,-24}})));
    Modelica.Blocks.Sources.BooleanExpression isOn1(y=true)
      annotation (Placement(transformation(extent={{-116,-82},{-104,-68}})));
  equation
    connect(heater.port,vol. heatPort) annotation (Line(points={{16,38},{16,32},{52,
            32}},                       color={191,0,0}));
    connect(sine.y,heater. Q_flow)
      annotation (Line(points={{-39,76},{16,76},{16,58}},
                                                        color={0,0,127}));
    connect(vol.heatPort,temperatureSensor. port)
      annotation (Line(points={{52,32},{52,2},{66,2}},     color={191,0,0}));
    connect(boilerControlBus_admixture, modularBoiler_Controller.boilerControlBus_Control)
      annotation (Line(
        points={{-72,50},{-28,50},{-28,33.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(PLR.y, boilerControlBus_admixture.PLR) annotation (Line(points={{-103,
            48},{-88,48},{-88,50.05},{-71.95,50.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(isOn.y, boilerControlBus_admixture.isOn) annotation (Line(points={{-99.4,
            31},{-90,31},{-90,32},{-80,32},{-80,46},{-76,46},{-76,50.05},{-71.95,50.05}},
          color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(boilerControlBus_admixture, admix_modularBoiler.boilerControlBus_admixture)
      annotation (Line(
        points={{-72,50},{-70,50},{-70,98},{130,98},{130,-18},{114,-18},{114,-16},
            {30,-16}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(modularBoiler_Controller.port_b, admix_modularBoiler.port_a1)
      annotation (Line(points={{-14,24},{8,24},{8,2},{25.2,2},{25.2,-4}},
                                                                       color={0,
            127,255}));
    connect(admix_modularBoiler.port_b2, modularBoiler_Controller.port_a)
      annotation (Line(points={{10.8,-4},{10.8,6},{-42,6},{-42,24},{-34,24}},
                                                                         color={0,
            127,255}));
    connect(RPM.y, boilerControlBus_admixture.pumpBus.rpmSet) annotation (Line(
          points={{-93,8},{-71.95,8},{-71.95,50.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(admix_modularBoiler.port_b1, vol.ports[1]) annotation (Line(points={{25.2,
            -28},{25.2,-34},{59.3333,-34},{59.3333,22}},
                                                color={0,127,255}));
    connect(vol.ports[2], admix_modularBoiler.port_a2) annotation (Line(points={{
            62,22},{66,22},{66,-38},{10.8,-38},{10.8,-28}}, color={0,127,255}));
    connect(boundary_ph5.ports[1], vol.ports[3])
      annotation (Line(points={{104,22},{64.6667,22}}, color={0,127,255}));
    connect(heater1.port, vol1.heatPort)
      annotation (Line(points={{-6,-56},{-6,-65},{-2,-65}}, color={191,0,0}));
    connect(sine1.y, heater1.Q_flow)
      annotation (Line(points={{-9.3,-35},{-6,-35},{-6,-40}}, color={0,0,127}));
    connect(vol1.heatPort, temperatureSensor1.port)
      annotation (Line(points={{-2,-65},{-2,-82},{2,-82}}, color={191,0,0}));
    connect(boundary_ph1.ports[1], vol1.ports[1])
      annotation (Line(points={{18,-72},{3.13333,-72}}, color={0,127,255}));
    connect(modularBoiler_Controller.valPos[1], admix_modularBoiler.valveSet)
      annotation (Line(points={{-13.8,30.8},{40,30.8},{40,-11.68},{32.88,-11.68}},
          color={0,0,127}));
    connect(modularBoiler_Controller.valPos[2], admix_modularBoiler1.valveSet)
      annotation (Line(points={{-13.8,31.6},{-2,31.6},{-2,-22},{-32,-22},{-32,-56},
            {-18,-56},{-18,-69.68},{-29.12,-69.68}}, color={0,0,127}));
    connect(modularBoiler_Controller.port_b, admix_modularBoiler1.port_a1)
      annotation (Line(points={{-14,24},{-12,24},{-12,-18},{-36.8,-18},{-36.8,-62}},
          color={0,127,255}));
    connect(admix_modularBoiler1.port_b1, vol1.ports[2]) annotation (Line(points=
            {{-36.8,-86},{-36,-86},{-36,-94},{2,-94},{2,-72},{5,-72}}, color={0,
            127,255}));
    connect(vol1.ports[3], admix_modularBoiler1.port_a2) annotation (Line(points=
            {{6.86667,-72},{6,-72},{6,-98},{-51.2,-98},{-51.2,-86}}, color={0,127,
            255}));
    connect(admix_modularBoiler1.port_b2, modularBoiler_Controller.port_a)
      annotation (Line(points={{-51.2,-62},{-50,-62},{-50,24},{-34,24}}, color={0,
            127,255}));
    connect(temperatureSensor.T, modularBoiler_Controller.TMeaCon[1]) annotation (
       Line(points={{86,2},{92,2},{92,0},{94,0},{94,18},{24,18},{24,26.35},{-13.9,
            26.35}}, color={0,0,127}));
    connect(temperatureSensor1.T, modularBoiler_Controller.TMeaCon[2])
      annotation (Line(points={{14,-82},{46,-82},{46,-44},{4,-44},{4,27.85},{
            -13.9,27.85}}, color={0,0,127}));
    connect(boilerControlBus_admixture1, admix_modularBoiler1.boilerControlBus_admixture)
      annotation (Line(
        points={{-70,-46},{-46,-46},{-46,-52},{-24,-52},{-24,-74},{-32,-74}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(RPM1.y, boilerControlBus_admixture1.pumpBus.rpmSet) annotation (Line(
          points={{-103.4,-48},{-86,-48},{-86,-45.95},{-69.95,-45.95}}, color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(PLR1.y, boilerControlBus_admixture1.PLR) annotation (Line(points={{
            -107.3,-31},{-69.95,-31},{-69.95,-45.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(isOn1.y, boilerControlBus_admixture1.isOn) annotation (Line(points={{
            -103.4,-75},{-69.95,-75},{-69.95,-45.95}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterFlowtemperatureControl_admixture2HeatCurcuits;
end Tester_NEW;
