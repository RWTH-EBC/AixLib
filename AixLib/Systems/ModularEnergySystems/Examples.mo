within AixLib.Systems.ModularEnergySystems;
package Examples "Holds examples for the modular energy system units"
  extends Modelica.Icons.ExamplesPackage;
  model HeatPump
      extends AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer.SimpleConsumer(
      vol(
        T_start=343.15,
        m_flow_nominal=1,
        V=0.4,
        nPorts=2),
      bou(use_T_in=true, nPorts=1),
      TSpeicher(y=70 + 273.15),
      sine(f=1/(12*3600), offset=-7000),
      PLR(y=0.6));
    Modules.ModularHeatPump.ModularHeatPumpNew
                                            modularHeatPumpNew(
      dTConFix=false,
      HighTemp=true,
      THotNom=353.15,
      TSourceNom=293.15,
      QNom=14000,
      PLRMin=0.5,
      T_Start_Condenser=333.15,
      TSourceInternal=true,
      redeclare package MediumEvap = AixLib.Media.Water)
      annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
    .AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus
      annotation (Placement(transformation(extent={{-96,0},{-66,34}}),
          iconTransformation(extent={{-84,8},{-66,34}})));

    inner Modelica.Fluid.System system(p_start=system.p_ambient)
      annotation (Placement(transformation(extent={{80,80},{100,100}})));
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
    bou.T_in=vol.T;
    connect(sigBus, modularHeatPumpNew.sigBus) annotation (Line(
        points={{-81,17},{-13.9,17},{-13.9,10.3}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(switch1.y, sigBus.PLR) annotation (Line(points={{-59.1,-29},{-52,
            -29},{-52,-4},{-80.925,-4},{-80.925,17.085}},
                                                     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(modularHeatPumpNew.port_b, vol.ports[1])
      annotation (Line(points={{-4,0},{46,0},{46,4}}, color={0,127,255}));
    connect(bou.ports[1], modularHeatPumpNew.port_a) annotation (Line(points={{
            0,-40},{2,-40},{2,-38},{4,-38},{4,-22},{-24,-22},{-24,0}}, color={0,
            127,255}));
    connect(vol.ports[2], pipe.port_a) annotation (Line(points={{46,4},{48,4},{
            48,-34},{44,-34}}, color={0,127,255}));
    connect(pipe.port_b, modularHeatPumpNew.port_a) annotation (Line(points={{
            22,-34},{18,-34},{18,-32},{14,-32},{14,-18},{-40,-18},{-40,0},{-24,
            0}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=5000));
  end HeatPump;

  model Boiler
     extends AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer.SimpleConsumer(
      vol(
        T_start=293.15,
        m_flow_nominal=1, nPorts=2),
      bou(nPorts=1),
      TSpeicher(y=60 + 273.15),
      sine(
        amplitude=-30000,
        freqHz=1/3600,
        offset=-50000));
    Modules.ModularBoiler.ModularBoiler
      modularBoilerNotManufacturer(TColdNom=333.15, QNom=100000)
      annotation (Placement(transformation(extent={{-38,-8},{-18,12}})));
    Interfaces.BoilerControlBus          boilerControlBus
      annotation (Placement(transformation(extent={{-92,0},{-72,20}})));
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
    connect(boilerControlBus, modularBoilerNotManufacturer.boilerControlBus)
      annotation (Line(
        points={{-82,10},{-72,10},{-72,8},{-52,8},{-52,12},{-28.2,12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(boilerControlBus.PLR, switch1.y) annotation (Line(
        points={{-81.95,10.05},{-81.95,-4},{-52,-4},{-52,-29},{-59.1,-29}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(modularBoilerNotManufacturer.port_b, vol.ports[1]) annotation (Line(
          points={{-18,2},{-12,2},{-12,0},{0,0},{0,4},{46,4}}, color={0,127,255}));
    connect(bou.ports[1], modularBoilerNotManufacturer.port_a) annotation (Line(
          points={{0,-40},{6,-40},{6,-38},{8,-38},{8,-20},{-36,-20},{-36,2},{-38,2}},
          color={0,127,255}));
    connect(vol.ports[2], pipe.port_a) annotation (Line(points={{46,4},{46,-16},
            {46,-34},{44,-34}}, color={0,127,255}));
    connect(pipe.port_b, modularBoilerNotManufacturer.port_a) annotation (Line(
          points={{22,-34},{16,-34},{16,-18},{-48,-18},{-48,2},{-38,2}}, color=
            {0,127,255}));
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
    Modules.ModularCHP.ModularCHP modularCHP(PelNom(displayUnit="kW") = 100000)
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

  model ModularBoiler
    extends Modelica.Icons.Example;
    extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

    package MediumWater = AixLib.Media.Water;

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(min=0) = 0.5
      "Nominal mass flow rate";
    parameter Modelica.Units.SI.Volume V_Water = 0.1;
    parameter Boolean Boiler=true;

    Fluid.Sources.Boundary_pT
                        bou(
      use_T_in=false,
      redeclare package Medium = MediumWater,
      nPorts=1)
      annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
    Fluid.Sensors.TemperatureTwoPort senTReturn(
      redeclare package Medium = MediumWater,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_nominal,
      T_start=293.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-60,-34})));
    Fluid.Sensors.TemperatureTwoPort senTFlow(
      redeclare package Medium = MediumWater,
      allowFlowReversal=false,
      m_flow_nominal=m_flow_nominal,
      T_start=293.15) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={44,-30})));
    Fluid.MixingVolumes.MixingVolume              vol(
      redeclare package Medium = MediumWater,
      energyDynamics=energyDynamics,
      massDynamics=massDynamics,
      p_start=p_start,
      T_start=T_start,
      X_start=X_start,
      C_start=C_start,
      C_nominal=C_nominal,
      mSenFac=mSenFac,
      allowFlowReversal=false,
      V=V_Water,
      m_flow_nominal=m_flow_nominal,
      nPorts=2)
      annotation (Placement(transformation(extent={{-8,-60},{8,-44}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-34,-74})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      f=1/3600,
      offset=-50000)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={58,-90})));
    Modules.ModularBoiler.ModularBoiler modularBoiler(
      redeclare package Medium = MediumWater,
      TColdNom=333.15,
      QNom=100000) if Boiler
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-9,-9},{9,9}},
          rotation=0,
          origin={11,59})));
    Modelica.Blocks.Sources.RealExpression TSpeicher(y=60 + 273.15)
      annotation (Placement(transformation(extent={{-94,26},{-62,46}})));
    Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=2.5)
      annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
    Modelica.Blocks.Sources.RealExpression zero(y=0)
      annotation (Placement(transformation(extent={{-62,42},{-50,62}})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-60,58},{-48,78}})));
    Interfaces.BoilerControlBus          boilerControlBus  if Boiler
      annotation (Placement(transformation(extent={{44,22},{64,42}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{62,-62},{82,-42}})));
  equation
    connect(senTFlow.port_b, vol.ports[1]) annotation (Line(points={{44,-40},{44,-60},
            {-0.8,-60}}, color={0,127,255}));
    connect(vol.ports[2], senTReturn.port_a) annotation (Line(points={{0.8,-60},{-60,
            -60},{-60,-44}}, color={0,127,255}));
    connect(sine.y,heater. Q_flow)
      annotation (Line(points={{47,-90},{-34,-90},{-34,-84}},
                                                        color={0,0,127}));
    connect(heater.port, vol.heatPort)
      annotation (Line(points={{-34,-64},{-34,-52},{-8,-52}}, color={191,0,0}));
    if Boiler then
      connect(modularBoiler.port_b, senTFlow.port_a)
        annotation (Line(points={{10,0},{44,0},{44,-20}}, color={0,127,255}));
      connect(modularBoiler.port_a, senTReturn.port_b)
        annotation (Line(points={{-10,0},{-60,0},{-60,-24}}, color={0,127,255}));
      connect(bou.ports[1], modularBoiler.port_a)
        annotation (Line(points={{-92,0},{-10,0}}, color={0,127,255}));
      connect(boilerControlBus, modularBoiler.boilerControlBus)
        annotation (Line(
          points={{54,32},{54,16},{42,16},{42,10},{-0.2,10}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(boilerControlBus.PLR,switch1. y) annotation (Line(
        points={{54.05,32.05},{54.05,80},{28,80},{28,59},{20.9,59}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    else
    end if;
    connect(TSpeicher.y,onOffController. reference)
      annotation (Line(points={{-60.4,36},{-52,36}},     color={0,0,127}));
    connect(onOffController.y,switch1. u2) annotation (Line(points={{-29,30},{-22,
            30},{-22,59},{0.2,59}},       color={255,0,255}));
    connect(zero.y,switch1. u3) annotation (Line(points={{-49.4,52},{-24,52},{-24,
            51.8},{0.2,51.8}},          color={0,0,127}));
    connect(PLR.y,switch1. u1) annotation (Line(points={{-47.4,68},{0.2,68},{0.2,66.2}},
                           color={0,0,127}));
    connect(temperatureSensor.T, onOffController.u) annotation (Line(points={{83,-52},
            {92,-52},{92,18},{-80,18},{-80,24},{-52,24}}, color={0,0,127}));
    connect(vol.heatPort, temperatureSensor.port) annotation (Line(points={{-8,-52},
            {-8,-68},{62,-68},{62,-52}}, color={191,0,0}));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ModularBoiler;
end Examples;
