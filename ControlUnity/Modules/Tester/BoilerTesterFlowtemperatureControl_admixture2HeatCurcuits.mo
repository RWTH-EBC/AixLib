within ControlUnity.Modules.Tester;
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
    k=2)
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
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 60)
    annotation (Placement(transformation(
        extent={{-6,-5},{6,5}},
        rotation=-90,
        origin={-20,65})));
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
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 67)
    annotation (Placement(transformation(
        extent={{-6,-5},{6,5}},
        rotation=-90,
        origin={-6,61})));
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
  connect(realExpression.y, modularBoiler_Controller.TCon[1])
    annotation (Line(points={{-20,58.4},{-20,35}}, color={0,0,127}));
  connect(realExpression1.y, modularBoiler_Controller.TCon[2])
    annotation (Line(points={{-6,54.4},{-6,33},{-20,33}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerTesterFlowtemperatureControl_admixture2HeatCurcuits;
