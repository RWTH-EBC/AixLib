within ControlUnity.Modules.Tester;
model BoilerTesterFlowtemperatureControl
  "Test model for the controller model of the boiler"
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=-3,
    freqHz=1/3600,
    offset=273.15,
    startTime=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={44,90})));

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
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
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
  ModularBoiler_FlowTemperatureControl modularBoiler_Controller(
    TColdNom=333.15,
    QNom=100000,
    n=1,
    use_advancedControl=true)
    annotation (Placement(transformation(extent={{-30,14},{-10,34}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-30,
    duration=100,
    offset=274.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={82,86})));
  Modelica.Blocks.Sources.RealExpression PLR(y=1)
    annotation (Placement(transformation(extent={{-118,24},{-98,44}})));
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
  connect(boilerControlBus, modularBoiler_Controller.boilerControlBus_Control)
    annotation (Line(
      points={{-72,36},{-50,36},{-50,33.8},{-24,33.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(vol.ports[2], modularBoiler_Controller.port_b) annotation (Line(
        points={{64,22},{26,22},{26,24},{-10,24}}, color={0,127,255}));
  connect(pipe.port_b, modularBoiler_Controller.port_a) annotation (Line(points={{38,-16},
          {30,-16},{30,6},{-42,6},{-42,24},{-30,24}},          color={0,127,255}));
  connect(bou.ports[1], modularBoiler_Controller.port_a) annotation (Line(
        points={{16,-22},{18,-22},{18,0},{-30,0},{-30,24}}, color={0,127,255}));
  connect(PLR.y, boilerControlBus.PLR) annotation (Line(points={{-97,34},{-86,
          34},{-86,36.05},{-71.95,36.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ramp.y, modularBoiler_Controller.Tamb) annotation (Line(points={{82,
          75},{82,68},{-15.2,68},{-15.2,34}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerTesterFlowtemperatureControl;
