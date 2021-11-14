within ControlUnity.Modules.Tester;
model BoilerTesterFlowtemperatureControl_admixture
  "Test model for the controller model of the boiler"


  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    T_start=293.15,
    m_flow_nominal=1,
    nPorts=1,
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
    annotation (Placement(transformation(extent={{-58,-36},{-38,-16}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{58,-6},{78,14}})));

  flowTemperatureController.renturnAdmixture.BoilerControlBus_admixture
    boilerControlBus_admixture
    annotation (Placement(transformation(extent={{-82,40},{-62,60}})));
  ModularBoiler_FlowTemperatureControl modularBoiler_Controller(
    TColdNom=333.15,
    QNom=100000,
    n=2,
    use_advancedControl=true,
    severalHeatcurcuits=true)
    annotation (Placement(transformation(extent={{-32,14},{-12,34}})));
  flowTemperatureController.renturnAdmixture.Admix_modularBoiler admix_modularBoiler[2]
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={22,-38})));
  parameter Integer n=2 "Number of layers in the buffer storage";
  AixLib.Fluid.HeatExchangers.ActiveWalls.Distributor distributor(n=2)
    annotation (Placement(transformation(extent={{14,-12},{26,0}})));
equation
  connect(heater.port,vol. heatPort) annotation (Line(points={{16,38},{16,32},{52,
          32}},                       color={191,0,0}));
  connect(sine.y,heater. Q_flow)
    annotation (Line(points={{-47,78},{16,78},{16,58}},
                                                      color={0,0,127}));
  connect(vol.heatPort,temperatureSensor. port)
    annotation (Line(points={{52,32},{52,4},{58,4}},     color={191,0,0}));
  connect(vol.ports[1], modularBoiler_Controller.port_b) annotation (Line(
        points={{62,22},{26,22},{26,24},{-12,24}}, color={0,127,255}));
  connect(bou.ports[1], modularBoiler_Controller.port_a) annotation (Line(
        points={{-38,-26},{-12,-26},{-12,0},{-32,0},{-32,24}},
                                                            color={0,127,255}));
  connect(boilerControlBus_admixture, modularBoiler_Controller.boilerControlBus_Control)
    annotation (Line(
      points={{-72,50},{-26,50},{-26,33.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(modularBoiler_Controller.port_b, distributor.mainFlow) annotation (
      Line(points={{-12,24},{-4,24},{-4,20},{2,20},{2,-2.8},{14,-2.8}}, color={
          0,127,255}));
  connect(distributor.flowPorts, admix_modularBoiler.port_a1) annotation (Line(
        points={{20,0},{26,0},{26,6},{28,6},{28,-28}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerTesterFlowtemperatureControl_admixture;
