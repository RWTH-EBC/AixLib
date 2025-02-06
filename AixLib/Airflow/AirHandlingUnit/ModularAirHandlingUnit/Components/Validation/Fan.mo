within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Validation;
model Fan
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp ramMasFlo(
    height=1500/3600*1.2,
    duration=1800,
    offset=3000/3600*1.2,
    startTime=10800)
    annotation (Placement(transformation(extent={{-100,36},{-80,56}})));
  Fluid.Sources.Boundary_pT sin(redeclare package Medium = Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{100,-70},{80,-50}})));
  Fluid.Movers.FlowControlled_dp mov(
    redeclare package Medium = AixLib.Media.Air "Moist air",
    redeclare AixLib.Fluid.Movers.Data.Generic per(efficiency(eta={1})),
    m_flow_nominal=4500/3600*1.2,
    dp_nominal=800)
    annotation (Placement(transformation(extent={{-34,-70},{-14,-50}})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = AixLib.Media.Air "Moist air",
    m_flow_nominal=4500/3600*1.2,
    dp_nominal=800)
    annotation (Placement(transformation(extent={{52,-70},{72,-50}})));
  FanSimple fanSim(
    m_flow_nominal=4500/3600*1.2,
    dp_nominal(displayUnit="Pa") = 800,
    eta=0.49) annotation (Placement(transformation(extent={{-22,8},{-2,28}})));
  Modelica.Blocks.Sources.Ramp ramT(
    height=15,
    duration=1800,
    offset=268.15,
    startTime=3600)
    annotation (Placement(transformation(extent={{-100,2},{-80,22}})));
  Modelica.Blocks.Sources.Ramp ramXi(
    height=0.003,
    duration=1800,
    offset=0.003,
    startTime=7200)
    annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = Media.Air,
      m_flow_nominal=4500/3600*1.2)
    annotation (Placement(transformation(extent={{26,-70},{46,-50}})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        AixLib.Media.Air "Moist air")
    annotation (Placement(transformation(extent={{-2,-70},{18,-50}})));
  Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = AixLib.Media.Air "Moist air",
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-62,-70},{-42,-50}})));
  Modelica.Blocks.Sources.Constant dp(k=800)
    annotation (Placement(transformation(extent={{-58,54},{-38,74}})));
  Modelica.Blocks.Math.Feedback resPow
    annotation (Placement(transformation(extent={{34,0},{54,20}})));
  Modelica.Blocks.Math.Feedback resT
    annotation (Placement(transformation(extent={{50,-28},{70,-8}})));
equation
  connect(res.port_b, sin.ports[1])
    annotation (Line(points={{72,-60},{80,-60}}, color={0,127,255}));
  connect(ramMasFlo.y, fanSim.mAirIn_flow) annotation (Line(points={{-79,46},{
          -56,46},{-56,26},{-23,26}}, color={0,0,127}));
  connect(ramT.y, fanSim.TAirIn) annotation (Line(points={{-79,12},{-44,12},{
          -44,23},{-23,23}}, color={0,0,127}));
  connect(ramXi.y, fanSim.XAirIn) annotation (Line(points={{-79,-22},{-36,-22},
          {-36,20},{-23,20}}, color={0,0,127}));
  connect(senTem.port_b, res.port_a)
    annotation (Line(points={{46,-60},{52,-60}}, color={0,127,255}));
  connect(mov.port_b, senMasFlo.port_a)
    annotation (Line(points={{-14,-60},{-2,-60}}, color={0,127,255}));
  connect(senMasFlo.port_b, senTem.port_a)
    annotation (Line(points={{18,-60},{26,-60}}, color={0,127,255}));
  connect(sou.ports[1], mov.port_a)
    annotation (Line(points={{-42,-60},{-34,-60}}, color={0,127,255}));
  connect(ramXi.y, sou.Xi_in[1]) annotation (Line(points={{-79,-22},{-72,-22},{
          -72,-64},{-64,-64}}, color={0,0,127}));
  connect(ramT.y, sou.T_in) annotation (Line(points={{-79,12},{-72,12},{-72,-56},
          {-64,-56}}, color={0,0,127}));
  connect(ramMasFlo.y, sou.m_flow_in) annotation (Line(points={{-79,46},{-72,46},
          {-72,-52},{-64,-52}}, color={0,0,127}));
  connect(dp.y, fanSim.dpIn)
    annotation (Line(points={{-37,64},{-12,64},{-12,29}}, color={0,0,127}));
  connect(dp.y, mov.dp_in) annotation (Line(points={{-37,64},{-30,64},{-30,-34},
          {-24,-34},{-24,-48}}, color={0,0,127}));
  connect(mov.P, resPow.u1) annotation (Line(points={{-13,-51},{-2,-51},{-2,-34},
          {18,-34},{18,10},{36,10}}, color={0,0,127}));
  connect(fanSim.PelFan, resPow.u2) annotation (Line(points={{-1,10},{12,10},{
          12,-6},{44,-6},{44,2}}, color={0,0,127}));
  connect(senTem.T, resT.u1)
    annotation (Line(points={{36,-49},{36,-18},{52,-18}}, color={0,0,127}));
  connect(fanSim.TAirOut, resT.u2) annotation (Line(points={{-1,23},{84,23},{84,
          -36},{60,-36},{60,-26}}, color={0,0,127}));
  annotation (experiment(
      StopTime=14400,
      Interval=5,
      Tolerance=1e-04,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>This example compares the fan component to the mover model in the Fluid-package. </p>
</html>"));
end Fan;
