within ControlUnity.Modules;
package TesterFinal

  model BoilerTesterAdmixture
    "Test model for the controller model of the boiler"

    parameter Integer p=modularBoiler_AdmixNEW.k;

  package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);
       parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
    parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
     parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";
     parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Thermal dimension power";

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=4)
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

    ModularBoiler_Admix                       modularBoiler_AdmixNEW(
      TColdNom=333.15,
      QNom=100000,
      n=1,
      simpleTwoPosition=true,
      use_advancedControl=true,
      k=2,
      TBoiler=348.15,
      severalHeatcurcuits=true,
      m_flow_nominalCon={0.5,0.7},
      dp_nominalCon(displayUnit="kPa") = {5000000,10000000},
      QNomCon={10000,7000})
      annotation (Placement(transformation(extent={{-34,18},{-14,38}})));
    flowTemperatureController.renturnAdmixture.BoilerControlBus_admixture
      boilerControlBus_admixture
      annotation (Placement(transformation(extent={{-82,40},{-62,60}})));
    parameter Integer n=2 "Number of layers in the buffer storage";
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-124,38},{-104,58}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-112,24},{-100,38}})));
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
      nPorts=2)
      annotation (Placement(transformation(extent={{-72,-70},{-58,-54}})));
    AixLib.Fluid.Sources.Boundary_pT
                        boundary_ph1(redeclare package Medium = Medium, nPorts=3)
                                                       annotation(Placement(transformation(extent={{8,-8},{
              -8,8}},                                                                                                       rotation=0,     origin={-24,-70})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{-68,-88},{-54,-74}})));
    flowTemperatureController.renturnAdmixture.AdmixtureBus admixtureBus[p]
      annotation (Placement(transformation(extent={{2,2},{22,22}})));
    parameter Integer k=2 "Number of heat curcuits";

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
      annotation (Placement(transformation(extent={{-30,-40},{-52,-20}})));
    Modelica.Fluid.Pipes.StaticPipe pipe1(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      allowFlowReversal=true,
      length=5,
      isCircular=true,
      diameter=0.03,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=0, m_flow_nominal=0.4785))
      annotation (Placement(transformation(extent={{36,-18},{14,2}})));
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
    connect(RPM.y, boilerControlBus_admixture.pumpBus.rpmSet) annotation (Line(
          points={{-93,8},{-71.95,8},{-71.95,50.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(boundary_ph5.ports[1], vol.ports[2])
      annotation (Line(points={{104,22},{61,22}},      color={0,127,255}));
    connect(boilerControlBus_admixture, modularBoiler_AdmixNEW.boilerControlBus) annotation (Line(
        points={{-72,50},{-56,50},{-56,48},{-38,48},{-38,37.8},{-30.4,37.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, modularBoiler_AdmixNEW.TCon[1]) annotation (Line(points={{-32,46.4},{
            -32,40},{-24.8,40},{-24.8,39}}, color={0,0,127}));
    connect(heater1.port, vol1.heatPort) annotation (Line(points={{-82,-58},{
            -82,-62},{-72,-62}}, color={191,0,0}));
    connect(temperatureSensor1.port, vol1.heatPort) annotation (Line(points={{
            -68,-81},{-70,-81},{-70,-82},{-72,-82},{-72,-62}}, color={191,0,0}));
    connect(boundary_ph1.ports[1], vol1.ports[1])
      annotation (Line(points={{-32,-67.8667},{-50,-67.8667},{-50,-70},{-66.4,
            -70}},                                        color={0,127,255}));
    connect(sine1.y, heater1.Q_flow) annotation (Line(points={{-87.5,-65},{-86,
            -65},{-86,-38},{-82,-38},{-82,-42}}, color={0,0,127}));
    connect(modularBoiler_AdmixNEW.TCon[2], realExpression1.y) annotation (Line(points={{-24.8,37},
            {-24.8,44},{-12,44},{-12,46.4}}, color={0,0,127}));
    connect(admixtureBus, modularBoiler_AdmixNEW.admixtureBus) annotation (Line(
        points={{12,12},{-2,12},{-2,21.4},{-16.8,21.4}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(vol.ports[2], pipe1.port_a)
      annotation (Line(points={{61,22},{52,22},{52,-8},{36,-8}}, color={0,127,255}));
    connect(pipe1.port_b, modularBoiler_AdmixNEW.port_a) annotation (Line(points={{14,-8},{-14,-8},
            {-14,-12},{-34,-12},{-34,28}}, color={0,127,255}));
    connect(vol1.ports[2], pipe.port_a) annotation (Line(points={{-63.6,-70},{-38,-70},{-38,-38},{-22,
            -38},{-22,-30},{-30,-30}}, color={0,127,255}));
    connect(pipe.port_b, modularBoiler_AdmixNEW.port_a) annotation (Line(points={{-52,-30},{-56,-30},
            {-56,-26},{-60,-26},{-60,-2},{-42,-2},{-42,28},{-34,28}}, color={0,127,255}));
    connect(modularBoiler_AdmixNEW.ports_b[1], vol.ports[1])
      annotation (Line(points={{-14,28},{24,28},{24,22},{59,22}}, color={0,127,255}));
    connect(modularBoiler_AdmixNEW.ports_b[2], boundary_ph1.ports[2]) annotation (Line(points={{-14,28},
            {-10,28},{-10,-56},{-32,-56},{-32,-70}},          color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterAdmixture;

  model BoilerTesterAdmixtureNEW "Test model for the controller model of the boiler"

    parameter Integer p=modularBoiler_AdmixNEW.k;

  package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);
       parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
    parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
     parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";
     parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Thermal dimension power";

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=4)
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

    ModularBoiler                             modularBoiler_AdmixNEW(
      TColdNom=333.15,
      QNom=100000,
      n=1,
      simpleTwoPosition=true,
      use_advancedControl=true,
      k=2,
      TBoiler=348.15,
      severalHeatcurcuits=true)
      annotation (Placement(transformation(extent={{-34,18},{-14,38}})));
    flowTemperatureController.renturnAdmixture.BoilerControlBus_admixture
      boilerControlBus_admixture
      annotation (Placement(transformation(extent={{-82,40},{-62,60}})));
    parameter Integer n=2 "Number of layers in the buffer storage";
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-124,38},{-104,58}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-112,24},{-100,38}})));
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
                        boundary_ph1(redeclare package Medium = Medium, nPorts=3)
                                                       annotation(Placement(transformation(extent={{8,-8},{
              -8,8}},                                                                                                       rotation=0,     origin={-24,-70})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{-68,-88},{-54,-74}})));
    parameter Integer k=2 "Number of heat curcuits";

    flowTemperatureController.renturnAdmixture.ModularAdmixture modularAdmixture(
      k=2,
      m_flow_nominalCon={0.5,0.7},
      dp_nominalCon(displayUnit="kPa") = {5000000,10000000},
      QNomCon={20,15}) annotation (Placement(transformation(extent={{10,-30},{30,-10}})));
    flowTemperatureController.renturnAdmixture.AdmixtureBus admixtureBus[2]
      annotation (Placement(transformation(extent={{10,-6},{30,14}})));
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
    connect(RPM.y, boilerControlBus_admixture.pumpBus.rpmSet) annotation (Line(
          points={{-93,8},{-71.95,8},{-71.95,50.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(boundary_ph5.ports[1], vol.ports[2])
      annotation (Line(points={{104,22},{61,22}},      color={0,127,255}));
    connect(boilerControlBus_admixture, modularBoiler_AdmixNEW.boilerControlBus) annotation (Line(
        points={{-72,50},{-56,50},{-56,48},{-38,48},{-38,37.8},{-30.4,37.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(realExpression.y, modularBoiler_AdmixNEW.TCon[1]) annotation (Line(points={{-32,46.4},{
            -32,40},{-24.8,40},{-24.8,39}}, color={0,0,127}));
    connect(heater1.port, vol1.heatPort) annotation (Line(points={{-82,-58},{
            -82,-62},{-72,-62}}, color={191,0,0}));
    connect(temperatureSensor1.port, vol1.heatPort) annotation (Line(points={{
            -68,-81},{-70,-81},{-70,-82},{-72,-82},{-72,-62}}, color={191,0,0}));
    connect(boundary_ph1.ports[1], vol1.ports[1])
      annotation (Line(points={{-32,-67.8667},{-48,-67.8667},{-48,-70},{
            -66.8667,-70}},                               color={0,127,255}));
    connect(sine1.y, heater1.Q_flow) annotation (Line(points={{-87.5,-65},{-86,
            -65},{-86,-38},{-82,-38},{-82,-42}}, color={0,0,127}));
    connect(modularBoiler_AdmixNEW.TCon[2], realExpression1.y) annotation (Line(points={{-24.8,37},
            {-24.8,44},{-12,44},{-12,46.4}}, color={0,0,127}));
    connect(admixtureBus, modularAdmixture.admixtureBus) annotation (Line(
        points={{20,4},{20,-4},{20,-10.5},{20.5,-10.5}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(modularBoiler_AdmixNEW.port_b, modularAdmixture.port_a[1]) annotation (Line(points={{-14,
            28},{-4,28},{-4,-16.5},{10.2,-16.5}}, color={0,127,255}));
    connect(modularBoiler_AdmixNEW.port_b, modularAdmixture.port_a[2])
      annotation (Line(points={{-14,28},{-14,-15.5},{10.2,-15.5}}, color={0,127,255}));
    connect(modularAdmixture.port_b[1], vol.ports[1]) annotation (Line(points={{29.8,-16.5},{44,-16.5},
            {44,-12},{59,-12},{59,22}},color={0,127,255}));
    connect(vol.ports[3], modularAdmixture.port_a1[1]) annotation (Line(points={{63,22},{64,22},{64,
            -24.65},{29.8,-24.65}},
                                  color={0,127,255}));
    connect(modularAdmixture.port_b[2], boundary_ph1.ports[2]) annotation (Line(points={{29.8,-15.5},
            {34,-15.5},{34,-56},{-32,-56},{-32,-70}},   color={0,127,255}));
    connect(vol1.ports[3], modularAdmixture.port_a1[2]) annotation (Line(points={{
            -63.1333,-70},{-52,-70},{-52,-50},{32,-50},{32,-23.55},{29.8,-23.55}},
                                                              color={0,127,255}));
    connect(modularAdmixture.port_b1[1], modularBoiler_AdmixNEW.port_a)
      annotation (Line(points={{10.2,-24.5},{-34,-24.5},{-34,28}}, color={0,127,
            255}));
    connect(modularAdmixture.port_b1[2], modularBoiler_AdmixNEW.port_a)
      annotation (Line(points={{10.2,-23.5},{-6,-23.5},{-6,-18},{-44,-18},{-44,
            28},{-34,28}}, color={0,127,255}));
    connect(modularBoiler_AdmixNEW.TMeaCon, admixtureBus.Tsen_b1) annotation (
        Line(points={{-14,31.4},{20.05,31.4},{20.05,4.05}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(modularBoiler_AdmixNEW.valPos, admixtureBus.valveSet) annotation (
        Line(points={{-14,34.8},{-4,34.8},{-4,38},{20.05,38},{20.05,4.05}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BoilerTesterAdmixtureNEW;

  model Admix "Test for admix circuit"
    extends Modelica.Icons.Example;

    package Medium = AixLib.Media.Water
      annotation (choicesAllMatching=true);

    AixLib.Systems.HydraulicModules.Admix Admix[2](
      parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1_5(),
      valveCharacteristic=
          AixLib.Fluid.Actuators.Valves.Data.LinearEqualPercentage(),
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
      redeclare package Medium = Medium,
      m_flow_nominal=0.1,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      length=1,
      Kv=10,
      T_amb=293.15) annotation (Placement(transformation(
          extent={{-30,-30},{30,30}},
          rotation=90,
          origin={10,10})));

    AixLib.Fluid.Sources.Boundary_pT   boundary(
      T=343.15,
      redeclare package Medium = Medium,
      nPorts=2) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={-8,-50})));
    AixLib.Fluid.Sources.Boundary_pT   boundary1(
      T=323.15,
      redeclare package Medium = Medium,
      nPorts=2) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={28,-50})));

    AixLib.Fluid.FixedResistances.PressureDrop hydRes[2](
      m_flow_nominal=8*996/3600,
      dp_nominal=8000,
      m_flow(start=hydRes.m_flow_nominal),
      dp(start=hydRes.dp_nominal),
      redeclare package Medium = Medium)
      "Hydraulic resistance in distribution cirquit (shortcut pipe)"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={10,60})));
    Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
        startTime=180)
      annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
    Modelica.Blocks.Sources.Constant RPM(k=2000)
      annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
    AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus[2]
      annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
    AixLib.Fluid.Sources.Boundary_pT   boundary2(
      T=333.15,
      redeclare package Medium = Medium,
      nPorts=2) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={66,-28})));
    AixLib.Fluid.Sources.Boundary_pT   boundary3(
      T=343.15,
      redeclare package Medium = Medium,
      nPorts=2) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=-90,
          origin={-44,-28})));
    Modelica.Blocks.Sources.Constant RPM1(k=2000)
      annotation (Placement(transformation(extent={{-76,66},{-56,86}})));
    Modelica.Blocks.Sources.Ramp valveOpening1(duration=250, startTime=180)
      annotation (Placement(transformation(extent={{-100,-38},{-80,-18}})));
  equation

    connect(Admix.port_a2, hydRes.port_b)
      annotation (Line(points={{28,40},{28,60},{20,60}}, color={0,127,255}));
    connect(Admix.port_b1, hydRes.port_a)
      annotation (Line(points={{-8,40},{-8,60},{0,60}}, color={0,127,255}));
    connect(hydraulicBus, Admix.hydraulicBus) annotation (Line(
        points={{-42,10},{-20,10}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(RPM.y, hydraulicBus[1].pumpBus.rpmSet) annotation (Line(points={{
            -79,50},{-64,50},{-64,34},{-41.95,34},{-41.95,10.025}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(RPM1.y, hydraulicBus[2].pumpBus.rpmSet) annotation (Line(points={{
            -55,76},{-46,76},{-46,74},{-41.95,74},{-41.95,10.075}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(valveOpening.y, hydraulicBus[1].valveSet) annotation (Line(points={
            {-79,10},{-60,10},{-60,10.025},{-41.95,10.025}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(valveOpening1.y, hydraulicBus[2].valveSet) annotation (Line(points=
            {{-79,-28},{-66,-28},{-66,-4},{-41.95,-4},{-41.95,10.075}}, color={
            0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(boundary3.ports, Admix.port_a1) annotation (Line(points={{-44,-18},
            {-42,-18},{-42,-8},{-26,-8},{-26,-28},{-8,-28},{-8,-20}}, color={0,
            127,255}));
    connect(boundary.ports, Admix.port_a1) annotation (Line(points={{-8,-40},{
            -8,-20},{-8,-20}}, color={0,127,255}));
    connect(boundary1.ports, Admix.port_b2) annotation (Line(points={{28,-40},{
            28,-40},{28,-20}}, color={0,127,255}));
    connect(boundary2.ports, Admix.port_b2) annotation (Line(points={{66,-18},{
            66,-6},{52,-6},{52,-26},{28,-26},{28,-20}}, color={0,127,255}));
    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=800),
      Documentation(revisions="<html><ul>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib.
  </li>
</ul>
</html>"),
      __Dymola_Commands(file(ensureSimulated=true)=
          "Resources/Scripts/Dymola/Systems/HydraulicModules/Examples/Admix.mos"
          "Simulate and plot"));
  end Admix;
end TesterFinal;
