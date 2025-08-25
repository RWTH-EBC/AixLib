within AixLib.Fluid.BoilerCHP.Examples;
model BoilerGeneric
    extends Modelica.Icons.Example;

      package Medium = AixLib.Media.Water annotation (choicesAllMatching=true);

  AixLib.Fluid.BoilerCHP.BoilerGeneric boilerNotManufacturer(
    T_start=293.15,
    QNom(displayUnit="kW") = 18000,
    THotNom=353.15,
    TColdNom=333.15)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Fluid.Sources.MassFlowSource_T source(
    use_m_flow_in=false,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=18/4.18/20,
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
  Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
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
  Modelica.Blocks.Sources.Sine sine(
    amplitude=5,
    f=1/(3600*24),
    phase=0,
    offset=273.15 + 75,
    startTime=700) "Ambient air temperature"
    annotation (Placement(transformation(extent={{-100,58},{-80,78}})));
  BoilerNoControl boilerNoControl(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=0.2,
    T_start=293.15,
    paramBoiler=AixLib.DataBase.Boiler.General.Boiler_Vitogas200F_18kW())
    annotation (Placement(transformation(extent={{-8,-58},{12,-38}})));
  Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=5,
    Td=1,
    yMax=1,
    yMin=0) annotation (Placement(transformation(extent={{-72,-42},{-52,-22}})));
  Modelica.Fluid.Sources.MassFlowSource_T source1(
    use_m_flow_in=false,
    redeclare package Medium = Medium,
    use_T_in=true,
    m_flow=0.2,
    T=313.15,
    nPorts=1)
    "Source"
    annotation (Placement(transformation(extent={{-70,-76},{-50,-56}})));
  Modelica.Fluid.Sources.Boundary_pT sink1(nPorts=1, redeclare package Medium =
        Medium)
    "Sink"
    annotation (Placement(transformation(extent={{76,-58},{56,-38}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = 293.15) "Temperature of environment around the boiler to account for heat losses"
    annotation (Placement(transformation(extent={{50,-82},{38,-70}})));
equation
  connect(boilerNotManufacturer.port_b, sink.ports[1])
    annotation (Line(points={{12,0},{48,0}}, color={0,127,255}));
  connect(ramp.y, source.T_in)
    annotation (Line(points={{-89,4},{-70,4}}, color={0,0,127}));
  connect(boilerControlBus, boilerNotManufacturer.boilerControlBus) annotation (
     Line(
      points={{0,24},{0,10},{2,10}},
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
  connect(sine.y, conPID.u_s)
    annotation (Line(points={{-79,68},{-46,68}}, color={0,0,127}));
  connect(boilerNoControl.port_b, sink1.ports[1])
    annotation (Line(points={{12,-48},{56,-48}}, color={0,127,255}));
  connect(source1.ports[1], boilerNoControl.port_a) annotation (Line(points={{
          -50,-66},{-28,-66},{-28,-48},{-8,-48}}, color={0,127,255}));
  connect(fixedTemperature.port, boilerNoControl.T_amb) annotation (Line(points
        ={{38,-76},{32,-76},{32,-70},{8.8,-70},{8.8,-53}}, color={191,0,0}));
  connect(conPID1.y, boilerNoControl.u_rel) annotation (Line(points={{-51,-32},
          {-30,-32},{-30,-42},{-5,-42},{-5,-41}}, color={0,0,127}));
  connect(boilerNoControl.T_out, conPID1.u_m) annotation (Line(points={{9.2,
          -44.8},{20,-44.8},{20,-26},{-38,-26},{-38,-48},{-62,-48},{-62,-44}},
        color={0,0,127}));
  connect(ramp.y, source1.T_in) annotation (Line(points={{-89,4},{-86,4},{-86,
          -62},{-72,-62},{-72,-62}}, color={0,0,127}));
  connect(sine.y, conPID1.u_s) annotation (Line(points={{-79,68},{-74,68},{-74,
          -32},{-74,-32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2000, __Dymola_Algorithm="Dassl"));
end BoilerGeneric;
