within AixLib.Fluid.BoilerCHP.Examples;
model BoilerGeneric
    extends Modelica.Icons.Example;

      package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);

  AixLib.Fluid.BoilerCHP.BoilerGeneric boiGen(
    T_start=293.15,
    QNom=20000,
    TSupNom=353.15,
    TRetNom=333.15)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    use_m_flow_in=false,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=20/4.18/20,
    T=313.15,
    nPorts=1)
    "Source"
    annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=40,
    duration=500,
    offset=293.15,
    startTime=60) "Return temperature"
    annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1, redeclare package Medium =
        Medium)
    "Sink"
    annotation (Placement(transformation(extent={{68,-10},{48,10}})));
  Controls.Continuous.LimPID conPID(u_m(unit="K"),
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=5,
    Td=1,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-44,58},{-24,78}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    f=1/(3600*24),
    phase=0,
    offset=273.15 + 75,
    startTime=700) "Ambient air temperature"
    annotation (Placement(transformation(extent={{-100,58},{-80,78}})));
  Controls.Interfaces.BoilerControlBus boilerControlBus1
    annotation (Placement(transformation(extent={{-8,12},{12,32}})));
equation
  connect(boiGen.port_b, sink.ports[1])
    annotation (Line(points={{12,0},{48,0}}, color={0,127,255}));
  connect(ramp.y, source.T_in)
    annotation (Line(points={{-79,4},{-64,4}}, color={0,0,127}));
  connect(sine.y, conPID.u_s)
    annotation (Line(points={{-79,68},{-46,68}}, color={0,0,127}));
  connect(boiGen.boilerControlBus, boilerControlBus1) annotation (Line(
      points={{2,10},{2,22}},
      color={255,204,51},
      thickness=0.5));
  connect(conPID.y, boilerControlBus1.FirRatSet) annotation (Line(points={{-23,68},
          {2,68},{2,22}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus1.TSupMea, conPID.u_m) annotation (Line(
      points={{2,22},{-32,22},{-32,56},{-34,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boiGen.port_a, source.ports[1])
    annotation (Line(points={{-8,0},{-42,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2000, __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="Resources/Scripts/Dymola/Fluid/BoilerCHP/Examples/BoilerGeneric.mos"
        "Simulate and Plot"));
end BoilerGeneric;
