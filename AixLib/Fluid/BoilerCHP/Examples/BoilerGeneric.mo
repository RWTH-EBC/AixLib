within AixLib.Fluid.BoilerCHP.Examples;
model BoilerGeneric
    extends Modelica.Icons.Example;

     parameter Modelica.Units.SI.TemperatureDifference dTNom=20
    "Nominal temperature difference of supply and return";
  parameter Modelica.Units.SI.Temperature TRetNom(displayUnit="degC")=333.15
    "Nominal return temperature";
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000
    "Nominal thermal capacity";

      package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);

  AixLib.Fluid.BoilerCHP.BoilerGeneric boilerGeneric(
    m_flow_nominal=QNom/Medium.cp_const/dTNom,
    dTNom=dTNom,
    TRetNom=TRetNom,
    QNom=QNom) annotation (Placement(transformation(extent={{6,-10},{26,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    use_m_flow_in=false,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=QNom/Medium.cp_const/dTNom,
    T=313.15,
    nPorts=1)
    "Source"
    annotation (Placement(transformation(extent={{-54,-10},{-34,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=40,
    duration=500,
    offset=293.15,
    startTime=60) "Return temperature"
    annotation (Placement(transformation(extent={{-96,-6},{-76,14}})));
  Modelica.Fluid.Sources.Boundary_pT sink(nPorts=1, redeclare package Medium =
        Medium)
    "Sink"
    annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  Controls.Interfaces.BoilerControlBus                     boilerControlBus
    annotation (Placement(transformation(extent={{4,14},{24,34}})));
  Sensors.TemperatureTwoPort              senTReturn(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/Medium.cp_const/dTNom,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=293.15,
    final transferHeat=false,
    final allowFlowReversal=true,
    final m_flow_small=0.001) "Temperature sensor return flow" annotation (
      Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=0,
        origin={-16,0})));
  Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=5,
    Td=1,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-30,58},{-10,78}})));
  Modelica.Blocks.Sources.RealExpression temSupSet(y=70 + 273.15)
    "Setpoint supply temperature"
    annotation (Placement(transformation(extent={{-84,56},{-48,80}})));

equation
  connect(boilerGeneric.port_b, sink.ports[1])
    annotation (Line(points={{26,0},{62,0}}, color={0,127,255}));
  connect(ramp.y, source.T_in)
    annotation (Line(points={{-75,4},{-56,4}}, color={0,0,127}));
  connect(boilerControlBus, boilerGeneric.boilerControlBus) annotation (Line(
      points={{14,24},{14,10},{13.2,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerGeneric.port_a, senTReturn.port_b)
    annotation (Line(points={{6,0},{-10,0}},  color={0,127,255}));
  connect(senTReturn.port_a, source.ports[1])
    annotation (Line(points={{-22,0},{-34,0}}, color={0,127,255}));
  connect(conPID.y, boilerControlBus.FirRatSet) annotation (Line(points={{-9,68},
          {14,68},{14,24}},
                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.TSupplyMea, conPID.u_m) annotation (Line(
      points={{14,24},{-20,24},{-20,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(conPID.u_s, temSupSet.y)
    annotation (Line(points={{-32,68},{-46.2,68}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
end BoilerGeneric;
