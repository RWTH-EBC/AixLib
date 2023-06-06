within AixLib.Fluid.BoilerCHP.Examples;
model BoilerGeneric
    extends Modelica.Icons.Example;

      package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);

  AixLib.Fluid.BoilerCHP.BoilerGeneric boilerNotManufacturer(
    m_flow_nominal=50/4.18/20,
    dTNom=20,
    TRetNom=606.3,
    QNom=50000)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    use_m_flow_in=false,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=50/4.18/20,
    T=313.15,
    nPorts=1)
    "Source"
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=40,
    duration=500,
    offset=293.15,
    startTime=60) "Return temperature"
    annotation (Placement(transformation(extent={{-110,-6},{-90,14}})));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1, redeclare package Medium =
        Medium)
    "Sink"
    annotation (Placement(transformation(extent={{68,-10},{48,10}})));
  Controls.Interfaces.BoilerControlBus                     boilerControlBus
    annotation (Placement(transformation(extent={{-10,14},{10,34}})));
  Sensors.TemperatureTwoPort              senTReturn(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=50000/(Medium.cp_const*20),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=293.15,
    final transferHeat=false,
    final allowFlowReversal=true,
    final m_flow_small=0.001) "Temperature sensor return flow" annotation (
      Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=0,
        origin={-30,0})));
  Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=5,
    Td=1,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-44,58},{-24,78}})));
  Modelica.Blocks.Sources.RealExpression temSupSet(y=75 + 273.15)
    "Setpoint supply temperature"
    annotation (Placement(transformation(extent={{-98,56},{-62,80}})));
equation
  connect(boilerNotManufacturer.port_b, sink.ports[1])
    annotation (Line(points={{12,0},{48,0}}, color={0,127,255}));
  connect(ramp.y, source.T_in)
    annotation (Line(points={{-89,4},{-70,4}}, color={0,0,127}));
  connect(boilerControlBus, boilerNotManufacturer.boilerControlBus) annotation (
     Line(
      points={{0,24},{0,10},{-0.8,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerNotManufacturer.port_a, senTReturn.port_b)
    annotation (Line(points={{-8,0},{-24,0}}, color={0,127,255}));
  connect(senTReturn.port_a, source.ports[1])
    annotation (Line(points={{-36,0},{-48,0}}, color={0,127,255}));
  connect(conPID.y, boilerControlBus.FirRatSet) annotation (Line(points={{-23,68},
          {0,68},{0,24}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.TSupplyMea, conPID.u_m) annotation (Line(
      points={{0,24},{-34,24},{-34,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(conPID.u_s, temSupSet.y)
    annotation (Line(points={{-46,68},{-60.2,68}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
end BoilerGeneric;
