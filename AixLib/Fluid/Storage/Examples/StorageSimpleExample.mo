within AixLib.Fluid.Storage.Examples;
model StorageSimpleExample "Example model with simple storage"
  extends Modelica.Icons.Example;
  StorageSimple storageSimple(
    redeclare package Medium = Medium,
    n=3,
    d=0.7,
    h=0.78,
    lambda_ins=0.032,
    s_ins=0.01,
    hConIn=1500,
    hConOut=15,
    V_HE=0.04,
    k_HE=1500,
    A_HE=10,
    m_flow_nominal_layer=m_flow_nominal_gen,
    m_flow_nominal_HE=m_flow_nominal_gen,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_start=308.15)
    "300 l storage"
    annotation (Placement(transformation(extent={{22,-22},{-20,22}})));
  HeatExchangers.HeatingRod heatingRod(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_gen,
    dp_nominal=dp_nominal_hr,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    Q_flow_nominal=8000,
    V=0.01,
    eta=0.98,
    use_countNumSwi=false)
              annotation (Placement(transformation(extent={{-70,12},{-50,32}})));
  replaceable package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_gen=
  heatingRod.Q_flow_nominal/(dT_gen*Medium.cp_const)
  "Nominal mass flow rate in generation cycle";

  parameter Modelica.Units.SI.PressureDifference dp_nominal_hr = 1000
    "Pressure difference in heating rod";

  parameter Modelica.Units.SI.TemperatureDifference dT_gen = 8
  "Temperature difference in generation cycle";
  Systems.HydraulicModules.SimpleConsumer simpleConsumer(
    redeclare package Medium = Medium,
    kA=heatingRod.Q_flow_nominal/dT_gen,
    V=0.2,
    m_flow_nominal=m_flow_nominal_gen,
    functionality="Q_flow_input") annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={62,4})));
  Sources.Boundary_pT pressureBoundary(
    redeclare package Medium = Medium,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-24,-52},{-38,-38}})));
  Movers.SpeedControlled_y pumpGen(redeclare package Medium = Medium,
      redeclare
      AixLib.Fluid.Movers.Data.Pumps.Wilo.CronolineIL80slash220dash4slash4 per)
    annotation (Placement(transformation(extent={{-48,-20},{-68,-40}})));
  Movers.SpeedControlled_y pumpCon(redeclare package Medium = Medium,
      redeclare
      AixLib.Fluid.Movers.Data.Pumps.Wilo.CronolineIL80slash220dash4slash4 per)
    "Consumer pump"
    annotation (Placement(transformation(extent={{44,-20},{24,-40}})));
  Sources.Boundary_pT pressureBoundary1(
    redeclare package Medium = Medium,
    p=200000,
    nPorts=1) annotation (Placement(transformation(extent={{70,-52},{56,-38}})));
  Modelica.Blocks.Logical.OnOffController storageHysteresis(bandwidth=bandwidth,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-72,54},{-60,66}})));
  Modelica.Blocks.Continuous.LimPID PID_hr(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=10,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=1)
    annotation (Placement(transformation(extent={{-54,78},{-38,94}})));
  Modelica.Blocks.Logical.Switch HROffOrPI
    annotation (Placement(transformation(extent={{-22,62},{-12,72}})));
  Modelica.Blocks.Sources.Constant TUpperHysteresis(k=273.15 + 40)
    annotation (Placement(transformation(extent={{-98,60},{-84,74}})));
  Modelica.Blocks.Interfaces.RealOutput PelHR
    "Electrical power used to provide current heat flow"
    annotation (Placement(transformation(extent={{76,46},{96,66}})));
  Modelica.Blocks.Sources.Cosine dailyHeatDemand(
    amplitude=-2000,
    f=1/86400,
    phase=3.1415926535898,
    offset=-4000)
                 annotation (Placement(transformation(extent={{96,10},{82,24}})));
  Modelica.Blocks.Sources.Constant Off(k=0)
    annotation (Placement(transformation(extent={{-44,52},{-36,60}})));
  Modelica.Thermal.HeatTransfer.Celsius.FixedTemperature fixedTemperature(T=18)
    annotation (Placement(transformation(extent={{40,-6},{28,6}})));
  Modelica.Blocks.Logical.LessThreshold    greaterZero
    annotation (Placement(transformation(extent={{18,-88},{30,-76}})));
  Sensors.MassFlowRate senMasFlo_gen(redeclare package Medium = Medium)
    "Mass flow rate sensor at generation side" annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-87,-17})));
  Modelica.Blocks.Continuous.LimPID PID_pump_gen(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.5,
    Ti=10,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=1)
    annotation (Placement(transformation(extent={{-68,-86},{-56,-74}})));
  Sensors.MassFlowRate senMasFlo_con(redeclare package Medium = Medium)
    "Mass fow rate sensor at consumer side" annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={47,37})));
  Modelica.Blocks.Sources.Constant m_flow_set(k=m_flow_nominal_gen)
    "Set mass flow rate"
    annotation (Placement(transformation(extent={{-96,-88},{-82,-74}})));
  Modelica.Blocks.Continuous.LimPID PID_pump_gen1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=1)
    annotation (Placement(transformation(extent={{44,-64},{56,-76}})));
  Modelica.Blocks.Logical.Switch PumpOnOffCon
    annotation (Placement(transformation(extent={{70,-90},{84,-76}})));
  Modelica.Blocks.Sources.Constant Offpump(k=0)
    annotation (Placement(transformation(extent={{48,-94},{56,-86}})));
  Modelica.Blocks.Logical.Switch PumpOnOffGen
    annotation (Placement(transformation(extent={{-28,-90},{-14,-76}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-72,80},{-62,90}})));
  Modelica.Blocks.Sources.Constant addToSetTemp(k=bandwidth/2)
    annotation (Placement(transformation(extent={{-96,82},{-88,90}})));
  parameter Real bandwidth=5 "Bandwidth around reference signal";
equation
  connect(heatingRod.port_b, storageSimple.port_a_heatGenerator) annotation (
      Line(points={{-50,22},{-30,22},{-30,19.36},{-16.64,19.36}}, color={0,127,255}));
  connect(pumpGen.port_a, storageSimple.port_b_heatGenerator) annotation (Line(
        points={{-48,-30},{-26,-30},{-26,-17.6},{-16.64,-17.6}}, color={0,127,255}));
  connect(pressureBoundary.ports[1], pumpGen.port_a) annotation (Line(points={{-38,
          -45},{-42,-45},{-42,-30},{-48,-30}}, color={0,127,255}));
  connect(pumpCon.port_b, storageSimple.port_a_consumer)
    annotation (Line(points={{24,-30},{1,-30},{1,-22}}, color={0,127,255}));
  connect(pressureBoundary1.ports[1], pumpCon.port_a)
    annotation (Line(points={{56,-45},{56,-30},{44,-30}}, color={0,127,255}));
  connect(simpleConsumer.port_b, pumpCon.port_a)
    annotation (Line(points={{62,-6},{62,-30},{44,-30}}, color={0,127,255}));
  connect(storageSimple.TTopLayer, PID_hr.u_m) annotation (Line(points={{16.96,19.36},
          {16.96,20},{38,20},{38,46},{-46,46},{-46,76.4}}, color={0,0,127}));
  connect(storageSimple.TTopLayer, storageHysteresis.u) annotation (Line(points={{16.96,
          19.36},{38,19.36},{38,46},{-90,46},{-90,56.4},{-73.2,56.4}},
        color={0,0,127}));
  connect(storageHysteresis.y, HROffOrPI.u2) annotation (Line(points={{-59.4,60},
          {-59.4,67},{-23,67}}, color={255,0,255}));
  connect(HROffOrPI.y, heatingRod.u) annotation (Line(points={{-11.5,67},{-8,67},
          {-8,38},{-84,38},{-84,28},{-72,28}}, color={0,0,127}));
  connect(PID_hr.y, HROffOrPI.u1) annotation (Line(points={{-37.2,86},{-32,86},{
          -32,71},{-23,71}}, color={0,0,127}));
  connect(TUpperHysteresis.y, storageHysteresis.reference) annotation (Line(
        points={{-83.3,67},{-83.3,64},{-74,64},{-74,63.6},{-73.2,63.6}},
                                                                color={0,0,127}));
  connect(heatingRod.Pel, PelHR) annotation (Line(points={{-49,28},{-2,28},{-2,56},
          {86,56}}, color={0,0,127}));
  connect(dailyHeatDemand.y, simpleConsumer.Q_flow) annotation (Line(points={{81.3,17},
          {75.65,17},{75.65,10},{72,10}},   color={0,0,127}));
  connect(Off.y, HROffOrPI.u3) annotation (Line(points={{-35.6,56},{-35.6,63},{-23,
          63}}, color={0,0,127}));
  connect(fixedTemperature.port, storageSimple.heatPort)
    annotation (Line(points={{28,0},{17.8,0}}, color={191,0,0}));
  connect(dailyHeatDemand.y, greaterZero.u) annotation (Line(points={{81.3,17},{
          68,17},{68,34},{100,34},{100,-100},{12,-100},{12,-82},{16.8,-82}},
        color={0,0,127}));
  connect(senMasFlo_gen.port_b, heatingRod.port_a) annotation (Line(points={{-81,
          0},{-80,0},{-80,22},{-70,22}}, color={0,127,255}));
  connect(pumpGen.port_b, senMasFlo_gen.port_a) annotation (Line(points={{-68,-30},
          {-81,-30},{-81,-14}}, color={0,127,255}));
  connect(storageSimple.port_b_consumer, senMasFlo_con.port_a)
    annotation (Line(points={{1,22},{1,35},{40,35}}, color={0,127,255}));
  connect(senMasFlo_con.port_b, simpleConsumer.port_a)
    annotation (Line(points={{54,35},{62,35},{62,14}}, color={0,127,255}));
  connect(m_flow_set.y, PID_pump_gen.u_s) annotation (Line(points={{-81.3,-81},{
          -76,-81},{-76,-80},{-69.2,-80}}, color={0,0,127}));
  connect(senMasFlo_gen.m_flow, PID_pump_gen.u_m) annotation (Line(points={{-88.7,
          -7},{-100,-7},{-100,-100},{-62,-100},{-62,-87.2}}, color={0,0,127}));
  connect(m_flow_set.y, PID_pump_gen1.u_s) annotation (Line(points={{-81.3,-81},
          {-40,-81},{-40,-66},{2,-66},{2,-70},{42.8,-70}}, color={0,0,127}));
  connect(PID_pump_gen1.y, PumpOnOffCon.u1) annotation (Line(points={{56.6,-70},
          {60,-70},{60,-77.4},{68.6,-77.4}}, color={0,0,127}));
  connect(greaterZero.y, PumpOnOffCon.u2) annotation (Line(points={{30.6,-82},{68.6,
          -82},{68.6,-83}}, color={255,0,255}));
  connect(Offpump.y, PumpOnOffCon.u3) annotation (Line(points={{56.4,-90},{62,-90},
          {62,-88.6},{68.6,-88.6}}, color={0,0,127}));
  connect(PumpOnOffCon.y, pumpCon.y) annotation (Line(points={{84.7,-83},{90,-83},
          {90,-60},{34,-60},{34,-42}}, color={0,0,127}));
  connect(senMasFlo_con.m_flow, PID_pump_gen1.u_m) annotation (Line(points={{47,
          42.7},{47,40},{100,40},{100,-60},{50,-60},{50,-62.8}}, color={0,0,127}));
  connect(PID_pump_gen.y, PumpOnOffGen.u1) annotation (Line(points={{-55.4,-80},
          {-52,-80},{-52,-72},{-38,-72},{-38,-76},{-29.4,-76},{-29.4,-77.4}},
        color={0,0,127}));
  connect(storageHysteresis.y, PumpOnOffGen.u2) annotation (Line(points={{-59.4,
          60},{-58,60},{-58,50},{-100,50},{-100,-100},{-40,-100},{-40,-83},{-29.4,
          -83}}, color={255,0,255}));
  connect(PumpOnOffGen.y, pumpGen.y) annotation (Line(points={{-13.3,-83},{-8,-83},
          {-8,-60},{-58,-60},{-58,-42}}, color={0,0,127}));
  connect(Offpump.y, PumpOnOffGen.u3) annotation (Line(points={{56.4,-90},{60,-90},
          {60,-100},{-44,-100},{-44,-88.6},{-29.4,-88.6}}, color={0,0,127}));
  connect(add.y, PID_hr.u_s) annotation (Line(points={{-61.5,85},{-61.5,86},{-55.6,
          86}}, color={0,0,127}));
  connect(TUpperHysteresis.y, add.u2) annotation (Line(points={{-83.3,67},{-82,67},
          {-82,82},{-73,82}}, color={0,0,127}));
  connect(addToSetTemp.y, add.u1) annotation (Line(points={{-87.6,86},{-87.6,88},
          {-73,88}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-60},{100,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-98,-60},{-68,-66}},
          textString="Pump control",
          textColor={0,0,0}),
        Rectangle(
          extent={{-100,100},{0,52}},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Text(
          extent={{-96,98},{-66,92}},
          textColor={0,0,0},
          textString="HR control")}),
    experiment(
      StopTime=86400,
      Interval=900,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end StorageSimpleExample;
