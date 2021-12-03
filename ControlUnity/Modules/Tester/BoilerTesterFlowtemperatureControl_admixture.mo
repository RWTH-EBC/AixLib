within ControlUnity.Modules.Tester;
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
    amplitude=-30000,
    freqHz=1/3600,
    offset=-50000)
    annotation (Placement(transformation(extent={{-60,68},{-40,88}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{66,-8},{86,12}})));

  flowTemperatureController.renturnAdmixture.BoilerControlBus_admixture
    boilerControlBus_admixture
    annotation (Placement(transformation(extent={{-82,40},{-62,60}})));
  ModularBoiler_FlowTemperatureControlAdmix modularBoiler_Controller(
    TColdNom=333.15,
    QNom=100000,
    n=1,
    use_advancedControl=true,
    severalHeatcurcuits=true)
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
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={20,-30})));
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
equation
  connect(heater.port,vol. heatPort) annotation (Line(points={{16,38},{16,32},{52,
          32}},                       color={191,0,0}));
  connect(sine.y,heater. Q_flow)
    annotation (Line(points={{-39,78},{16,78},{16,58}},
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
      points={{-72,50},{-70,50},{-70,98},{130,98},{130,-18},{114,-18},{114,-30},
          {40,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler_Controller.port_b, admix_modularBoiler.port_a1)
    annotation (Line(points={{-14,24},{8,24},{8,2},{32,2},{32,-10}}, color={0,
          127,255}));
  connect(admix_modularBoiler.port_b2, modularBoiler_Controller.port_a)
    annotation (Line(points={{8,-10},{8,6},{-42,6},{-42,24},{-34,24}}, color={0,
          127,255}));
  connect(modularBoiler_Controller.valPos, admix_modularBoiler.valveSet)
    annotation (Line(points={{-13.8,31.2},{48,31.2},{48,48},{90,48},{90,-22.8},
          {44.8,-22.8}}, color={0,0,127}));
  connect(realExpression.y, modularBoiler_Controller.Tset) annotation (Line(
        points={{-20,58.4},{-22,58.4},{-22,32.8},{-22.2,32.8}}, color={0,0,127}));
  connect(RPM.y, boilerControlBus_admixture.pumpBus.rpmSet) annotation (Line(
        points={{-93,8},{-71.95,8},{-71.95,50.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(admix_modularBoiler.port_b1, vol.ports[1]) annotation (Line(points={{32,-50},
          {32,-74},{59.3333,-74},{59.3333,22}},
                                              color={0,127,255}));
  connect(vol.ports[2], admix_modularBoiler.port_a2) annotation (Line(points={{
          62,22},{64,22},{64,-86},{8,-86},{8,-50}}, color={0,127,255}));
  connect(boundary_ph5.ports[1], vol.ports[3])
    annotation (Line(points={{104,22},{64.6667,22}}, color={0,127,255}));
  connect(temperatureSensor.T, modularBoiler_Controller.TMeaCon) annotation (
      Line(points={{86,2},{96,2},{96,16},{16,16},{16,27.1},{-13.9,27.1}}, color
        ={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerTesterFlowtemperatureControl_admixture;
