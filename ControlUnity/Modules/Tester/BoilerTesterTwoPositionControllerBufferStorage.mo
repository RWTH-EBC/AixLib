within ControlUnity.Modules.Tester;
model BoilerTesterTwoPositionControllerBufferStorage
  "Test model for the controller model of the boiler"
  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    T_start=293.15,
    m_flow_nominal=1,
    redeclare package Medium = AixLib.Media.Water,
    V=3,
    nPorts=1)
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
    n=1) annotation (Placement(transformation(extent={{-32,12},{-12,32}})));
  Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
    annotation (Placement(transformation(extent={{-104,2},{-84,22}})));
  twoPositionController.Storage_modularBoiler storage_modularBoiler(
    n=3,
    d=1,
    h=2,
    lambda_ins=0.04,
    s_ins=0.1,
    hConIn=1500,
    hConOut=15,
    V_HE=0.05,
    k_HE=1500,
    A_HE=20,
    beta=0.00035,
    kappa=0.4,
    m_flow_nominal_layer=1,
    m_flow_nominal_HE=1)
    annotation (Placement(transformation(extent={{-2,-28},{18,-8}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)
                                                                                      annotation(Placement(transformation(extent={{-26,-56},
            {-14,-44}})));
  AixLib.Fluid.Sources.Boundary_pT
                      boundary_ph5(redeclare package Medium = Medium, nPorts=1)
                                                     annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation=0,     origin={80,-62})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    m_flow=0.5,
    redeclare package Medium = Medium,
    use_m_flow_in=false,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={108,-40})));
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
    annotation (Line(points={{-12,22},{10,22},{10,6},{28,6},{28,-9.2},{16.4,
          -9.2}}, color={0,127,255}));
  connect(storage_modularBoiler.port_b_heatGenerator, modularBoiler_Controller.port_a)
    annotation (Line(points={{16.4,-26},{20,-26},{20,-30},{-40,-30},{-40,22},{
          -32,22}}, color={0,127,255}));
  connect(fixedTemperature.port, storage_modularBoiler.heatPort) annotation (
      Line(points={{-14,-50},{-8,-50},{-8,-18},{0,-18}}, color={191,0,0}));
  connect(storage_modularBoiler.TTop, modularBoiler_Controller.TLayers[1])
    annotation (Line(points={{19,-12.6},{34,-12.6},{34,30},{-10,30},{-10,31.1},
          {-19.9,31.1}}, color={0,0,127}));
  connect(vol.ports[1], storage_modularBoiler.port_b_consumer) annotation (Line(
        points={{62,22},{62,16},{12,16},{12,-4},{8,-4},{8,-8}}, color={0,127,
          255}));
  connect(boundary_ph5.ports[1], storage_modularBoiler.port_a_consumer)
    annotation (Line(points={{70,-62},{42,-62},{42,-58},{8,-58},{8,-28}}, color
        ={0,127,255}));
  connect(boundary.ports[1], storage_modularBoiler.port_a_consumer)
    annotation (Line(points={{98,-40},{8,-40},{8,-28}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerTesterTwoPositionControllerBufferStorage;
