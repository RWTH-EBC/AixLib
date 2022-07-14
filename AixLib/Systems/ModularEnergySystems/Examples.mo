within AixLib.Systems.ModularEnergySystems;
package Examples "Holds examples for the modular energy system units"
  extends Modelica.Icons.ExamplesPackage;
  model HeatPump
      extends
      AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer.SimpleConsumer(
      vol(
        T_start=303.15,
        m_flow_nominal=1,
        V=4,
        nPorts=2),
      bou(use_T_in=true, nPorts=1),
      TSpeicher(y=50 + 273.15),
      sine(f=1/3600, offset=-100000),
      PLR(y=1));
    Modules.ModularHeatPump.ModularHeatPumpNew
                                            modularHeatPumpNew(
      HighTemp=true,
      THotNom=333.15,
      TSourceNom=303.15,
      QNom=200000,
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
        amplitude=50000,
        f=1/3600,
        offset=-50000));
    Modules.ModularBoiler.ModularBoiler
      modularBoilerNotManufacturer(TColdNom=333.15, QNom=100000)
      annotation (Placement(transformation(extent={{-38,-8},{-18,12}})));
    AixLib.Controls.Interfaces.BoilerControlBus
                                         boilerControlBus
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
        points={{-82,10},{-82,-8},{-52,-8},{-52,-29},{-59.1,-29}},
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
end Examples;
