within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Validation;
model Cooler
  extends Modelica.Icons.Example;
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Cooler CooRea(
    use_T_set=true,
    Q_flow_nominal=-8000,
    m_flow_nominal=4500/3600*1.2,
    dp_nominal(displayUnit="Pa") = 20,
    redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-16,-28},{4,-8}})));
  Fluid.Sources.Boundary_pT sin(redeclare package Medium = AixLib.Media.Air,
      nPorts=1)
    annotation (Placement(transformation(extent={{110,-70},{90,-50}})));
  Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = AixLib.Media.Air,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-48,-70},{-28,-50}})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=4500/3600*1.2)
    annotation (Placement(transformation(extent={{62,-70},{82,-50}})));
  Modelica.Blocks.Sources.Ramp ramT(
    height=10,
    duration=1800,
    offset=298.15,
    startTime=3600)
    annotation (Placement(transformation(extent={{-90,2},{-70,22}})));
  Modelica.Blocks.Sources.Ramp ramXi(
    height=0.003,
    duration=1800,
    offset=0.01,
    startTime=7200)
    annotation (Placement(transformation(extent={{-92,-30},{-72,-10}})));
  Modelica.Blocks.Sources.Ramp ramMasFlo(
    height=1500/3600*1.2,
    duration=1800,
    offset=3000/3600*1.2,
    startTime=10800)
    annotation (Placement(transformation(extent={{-88,36},{-68,56}})));
  Modelica.Blocks.Sources.Constant TSet(k=293.15)
    annotation (Placement(transformation(extent={{-4,70},{-24,90}})));
  Modelica.Blocks.Math.Feedback resT
    annotation (Placement(transformation(extent={{46,-22},{66,-2}})));
  Modelica.Blocks.Sources.Constant XSet(k=0.008)
    annotation (Placement(transformation(extent={{-88,74},{-68,94}})));
  Modelica.Blocks.Math.Feedback resX
    annotation (Placement(transformation(extent={{44,12},{64,32}})));
  Fluid.HeatExchangers.PrescribedOutlet preOut(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=4500/3600*1.2,
    dp_nominal=20)
    annotation (Placement(transformation(extent={{-6,-70},{14,-50}})));
  Controler.ControlerCooler controlerCooler(activeDehumidifying=true)
    annotation (Placement(transformation(extent={{-28,30},{-8,50}})));
  Modelica.Blocks.Math.Feedback resPow
    annotation (Placement(transformation(extent={{42,44},{62,64}})));
  Fluid.Sensors.MassFractionTwoPort senMasFra(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=4500/3600*1.2)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
equation
  connect(senTem.port_b, sin.ports[1])
    annotation (Line(points={{82,-60},{90,-60}}, color={0,127,255}));
  connect(ramT.y, CooRea.TAirIn) annotation (Line(points={{-69,12},{-62,12},{-62,
          -13},{-17,-13}}, color={0,0,127}));
  connect(ramT.y, sou.T_in) annotation (Line(points={{-69,12},{-62,12},{-62,-56},
          {-50,-56}}, color={0,0,127}));
  connect(ramXi.y, CooRea.XAirIn) annotation (Line(points={{-71,-20},{-30,-20},
          {-30,-16},{-17,-16}}, color={0,0,127}));
  connect(ramXi.y, sou.Xi_in[1]) annotation (Line(points={{-71,-20},{-62,-20},{
          -62,-64},{-50,-64}}, color={0,0,127}));
  connect(ramMasFlo.y, CooRea.mAirIn_flow) annotation (Line(points={{-67,46},{-62,
          46},{-62,-8},{-40,-8},{-40,-10},{-17,-10}}, color={0,0,127}));
  connect(ramMasFlo.y, sou.m_flow_in) annotation (Line(points={{-67,46},{-62,46},
          {-62,-52},{-50,-52}}, color={0,0,127}));
  connect(senTem.T, resT.u1) annotation (Line(points={{72,-49},{72,-30},{40,-30},
          {40,-12},{48,-12}}, color={0,0,127}));
  connect(CooRea.TAirOut, resT.u2) annotation (Line(points={{5,-13},{30,-13},{
          30,-28},{56,-28},{56,-20}}, color={0,0,127}));
  connect(sou.ports[1], preOut.port_a)
    annotation (Line(points={{-28,-60},{-6,-60}}, color={0,127,255}));
  connect(XSet.y, controlerCooler.xSupSet) annotation (Line(points={{-67,84},{
          -40,84},{-40,46},{-29,46}}, color={0,0,127}));
  connect(TSet.y, controlerCooler.TsupSet) annotation (Line(points={{-25,80},{
          -40,80},{-40,38},{-29,38}}, color={0,0,127}));
  connect(CooRea.XAirOut, controlerCooler.XIn) annotation (Line(points={{5,-16},
          {14,-16},{14,6},{-38,6},{-38,34},{-29,34}}, color={0,0,127}));
  connect(controlerCooler.TcoolerSet, CooRea.T_set) annotation (Line(points={{
          -7,40},{0,40},{0,14},{-6,14},{-6,-8}}, color={0,0,127}));
  connect(controlerCooler.TcoolerSet, preOut.TSet) annotation (Line(points={{-7,
          40},{0,40},{0,14},{-22,14},{-22,-52},{-8,-52}}, color={0,0,127}));
  connect(XSet.y, preOut.X_wSet) annotation (Line(points={{-67,84},{-38,84},{
          -38,-38},{-22,-38},{-22,-56},{-8,-56}}, color={0,0,127}));
  connect(CooRea.XAirOut, resX.u2) annotation (Line(points={{5,-16},{26,-16},{
          26,6},{54,6},{54,14}}, color={0,0,127}));
  connect(preOut.Q_flow, resPow.u1) annotation (Line(points={{15,-52},{26,-52},
          {26,54},{44,54}}, color={0,0,127}));
  connect(CooRea.Q_flow, resPow.u2) annotation (Line(points={{5,-24},{26,-24},{
          26,36},{52,36},{52,46}}, color={0,0,127}));
  connect(senMasFra.port_b, senTem.port_a)
    annotation (Line(points={{50,-60},{62,-60}}, color={0,127,255}));
  connect(preOut.port_b, senMasFra.port_a)
    annotation (Line(points={{14,-60},{30,-60}}, color={0,127,255}));
  connect(senMasFra.X, resX.u1)
    annotation (Line(points={{40,-49},{40,22},{46,22}}, color={0,0,127}));
  annotation (experiment(
      StopTime=14400,
      Interval=5,
      __Dymola_Algorithm="Dassl"));
end Cooler;
