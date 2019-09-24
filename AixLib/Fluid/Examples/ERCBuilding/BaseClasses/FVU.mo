within AixLib.Fluid.Examples.ERCBuilding.BaseClasses;
model FVU
  extends FVUBase(
    heater(tau_m=5*60),
    cooler(tau_m=5*60),
    recuperator(tau_m=5*60));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening Flap_FreshAir(
    m_flow_nominal=0.05,
    dpValve_nominal=500,
    redeclare package Medium = Air,
    riseTime=90)                    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-142,-32})));
  Modelica.Blocks.Interfaces.RealInput InputSignal_FreshAirFlap
    "Real Input to control the revolving speed of the exhaust air fan"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-52,100}), iconTransformation(
        extent={{-17,-17},{17,17}},
        rotation=270,
        origin={-45,97})));
equation
  connect(T_FreshAir.port, case1.ports[2]) annotation (Line(points={{-124,-42},
          {-124,-32},{-100,-32}},color={0,127,255}));
  connect(exhaustAir, T_OutgoingExhaustAir.port) annotation (Line(points={{
          -200,26},{-190,26},{-180,26},{-180,-6},{-124,-6}}, color={0,127,255}));
  connect(T_OutgoingExhaustAir.port, exhaustAirFan.port_b) annotation (Line(
        points={{-124,-6},{-96,-6},{-96,14},{-66,14}}, color={0,127,255}));
  connect(add5.y, electricalPower) annotation (Line(points={{-180,33.4},{-180,
          28},{-164,28},{-164,-68},{-78,-68},{-78,-86},{90,-86},{90,-104}},
        color={0,0,127}));
  connect(T_FreshAir.port, Flap_FreshAir.port_b) annotation (Line(points={{
          -124,-42},{-124,-42},{-124,-30},{-124,-32},{-133,-32}}, color={0,
          127,255}));
  connect(Flap_FreshAir.port_a, freshAir) annotation (Line(points={{-151,-32},
          {-200,-32},{-200,-80}}, color={0,127,255}));
  connect(InputSignal_FreshAirFlap, Flap_FreshAir.y) annotation (Line(points={{
          -52,100},{-52,76},{-70,76},{-70,-8},{-142,-8},{-142,-21.2}}, color={0,
          0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -200,-100},{200,100}})));
end FVU;
