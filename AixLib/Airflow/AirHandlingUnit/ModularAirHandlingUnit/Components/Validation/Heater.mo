within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Validation;
model Heater
  extends Modelica.Icons.Example;
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Heater
    heaRea(
    Q_flow_nominal=8000,
    m_flow_nominal=4500/3600*1.2,
    dp_nominal(displayUnit="Pa") = 20,
    redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-16,-28},{4,-8}})));
  Fluid.HeatExchangers.HeaterCooler_u heaFlu(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=4500/3600*1.2,
    dp_nominal=20,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Q_flow_nominal=8000)
    annotation (Placement(transformation(extent={{-4,-70},{16,-50}})));
  Fluid.Sources.Boundary_pT sin(redeclare package Medium = AixLib.Media.Air,
      nPorts=1)
    annotation (Placement(transformation(extent={{98,-68},{78,-48}})));
  Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = AixLib.Media.Air,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-48,-70},{-28,-50}})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        AixLib.Media.Air, m_flow_nominal=4500/3600*1.2)
    annotation (Placement(transformation(extent={{32,-70},{52,-50}})));
  Modelica.Blocks.Sources.Ramp ramT(
    height=15,
    duration=1800,
    offset=268.15,
    startTime=3600)
    annotation (Placement(transformation(extent={{-90,2},{-70,22}})));
  Modelica.Blocks.Sources.Ramp ramXi(
    height=0.003,
    duration=1800,
    offset=0.003,
    startTime=7200)
    annotation (Placement(transformation(extent={{-92,-30},{-72,-10}})));
  Modelica.Blocks.Sources.Ramp ramMasFlo(
    height=1500/3600*1.2,
    duration=1800,
    offset=3000/3600*1.2,
    startTime=10800)
    annotation (Placement(transformation(extent={{-88,36},{-68,56}})));
  Modelica.Blocks.Sources.Constant powSet(k=1)
    annotation (Placement(transformation(extent={{-94,-94},{-74,-74}})));
  Modelica.Blocks.Math.Feedback resT
    annotation (Placement(transformation(extent={{46,-22},{66,-2}})));
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Heater
    heaRea1(
    use_T_set=true,
    m_flow_nominal=4500/3600*1.2,
    dp_nominal(displayUnit="Pa") = 20,
    redeclare model PartialPressureDrop = PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-10,68},{10,88}})));
  Fluid.HeatExchangers.Heater_T heaFlu1(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=4500/3600*1.2,
    dp_nominal=20,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = Media.Air,
      m_flow_nominal=4500/3600*1.2)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Modelica.Blocks.Sources.Constant TSet(k=293.15)
    annotation (Placement(transformation(extent={{-88,74},{-68,94}})));
  Modelica.Blocks.Math.Feedback resPow
    annotation (Placement(transformation(extent={{42,64},{62,84}})));
  Fluid.Sources.Boundary_pT sin1(redeclare package Medium = Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{90,30},{70,50}})));
  Fluid.Sources.MassFlowSource_T sou1(
    redeclare package Medium = Media.Air,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-42,20},{-22,40}})));
equation
  connect(sou.ports[1], heaFlu.port_a) annotation (Line(points={{-28,-60},{-16,
          -60},{-16,-60},{-4,-60}}, color={0,127,255}));
  connect(heaFlu.port_b, senTem.port_a)
    annotation (Line(points={{16,-60},{32,-60}}, color={0,127,255}));
  connect(senTem.port_b, sin.ports[1]) annotation (Line(points={{52,-60},{60,-60},
          {60,-58},{78,-58}}, color={0,127,255}));
  connect(ramT.y, heaRea.TAirIn) annotation (Line(points={{-69,12},{-62,12},{-62,
          -13},{-17,-13}}, color={0,0,127}));
  connect(ramT.y, sou.T_in) annotation (Line(points={{-69,12},{-62,12},{-62,-56},
          {-50,-56}}, color={0,0,127}));
  connect(ramXi.y, heaRea.XAirIn) annotation (Line(points={{-71,-20},{-30,-20},
          {-30,-16},{-17,-16}}, color={0,0,127}));
  connect(ramXi.y, sou.Xi_in[1]) annotation (Line(points={{-71,-20},{-62,-20},{
          -62,-64},{-50,-64}}, color={0,0,127}));
  connect(ramMasFlo.y, heaRea.mAirIn_flow) annotation (Line(points={{-67,46},{-62,
          46},{-62,-8},{-40,-8},{-40,-10},{-17,-10}}, color={0,0,127}));
  connect(ramMasFlo.y, sou.m_flow_in) annotation (Line(points={{-67,46},{-62,46},
          {-62,-52},{-50,-52}}, color={0,0,127}));
  connect(powSet.y, heaFlu.u) annotation (Line(points={{-73,-84},{-14,-84},{-14,
          -54},{-6,-54}}, color={0,0,127}));
  connect(powSet.y, heaRea.u) annotation (Line(points={{-73,-84},{-14,-84},{-14,
          -40},{20,-40},{20,-2},{-6,-2},{-6,-8}}, color={0,0,127}));
  connect(senTem.T, resT.u1)
    annotation (Line(points={{42,-49},{42,-12},{48,-12}}, color={0,0,127}));
  connect(heaRea.TAirOut, resT.u2) annotation (Line(points={{5,-13},{30,-13},{
          30,-28},{56,-28},{56,-20}}, color={0,0,127}));
  connect(heaFlu1.port_b, senTem1.port_a)
    annotation (Line(points={{10,40},{30,40}}, color={0,127,255}));
  connect(TSet.y, heaFlu1.TSet) annotation (Line(points={{-67,84},{-56,84},{-56,
          48},{-12,48}}, color={0,0,127}));
  connect(ramMasFlo.y, heaRea1.mAirIn_flow) annotation (Line(points={{-67,46},{
          -48,46},{-48,86},{-11,86}}, color={0,0,127}));
  connect(ramT.y, heaRea1.TAirIn) annotation (Line(points={{-69,12},{-48,12},{-48,
          83},{-11,83}}, color={0,0,127}));
  connect(ramXi.y, heaRea1.XAirIn) annotation (Line(points={{-71,-20},{-48,-20},
          {-48,80},{-11,80}}, color={0,0,127}));
  connect(heaFlu1.Q_flow, resPow.u1) annotation (Line(points={{11,48},{22,48},{
          22,74},{44,74}}, color={0,0,127}));
  connect(heaRea1.Q_flow, resPow.u2) annotation (Line(points={{11,72},{22,72},{
          22,60},{52,60},{52,66}}, color={0,0,127}));
  connect(TSet.y, heaRea1.T_set) annotation (Line(points={{-67,84},{-56,84},{
          -56,96},{0,96},{0,88}}, color={0,0,127}));
  connect(senTem1.port_b,sin1. ports[1])
    annotation (Line(points={{50,40},{70,40}}, color={0,127,255}));
  connect(sou1.ports[1], heaFlu1.port_a) annotation (Line(points={{-22,30},{-16,
          30},{-16,40},{-10,40}}, color={0,127,255}));
  connect(ramXi.y, sou1.Xi_in[1]) annotation (Line(points={{-71,-20},{-62,-20},
          {-62,26},{-44,26}}, color={0,0,127}));
  connect(ramT.y, sou1.T_in) annotation (Line(points={{-69,12},{-62,12},{-62,34},
          {-44,34}}, color={0,0,127}));
  connect(ramMasFlo.y, sou1.m_flow_in) annotation (Line(points={{-67,46},{-62,
          46},{-62,38},{-44,38}}, color={0,0,127}));
  annotation (experiment(
      StopTime=14400,
      Interval=5,
      Tolerance=1e-04,
      __Dymola_Algorithm="Dassl"));
end Heater;
