within AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop;
model SourceIdealPreturn
  "Simple supply node model with ideal flow source and pressure control at return port"
  extends BaseClasses.Supplies.OpenLoop.PartialSupplyAdj(senT_return(
        allowFlowReversal=true));

  parameter Modelica.SIunits.AbsolutePressure pReturn
    "Fixed return pressure";

  parameter Modelica.SIunits.Temperature TReturn
    "Fixed return temperature";

  AixLib.Fluid.Sources.Boundary_pT source(          redeclare package Medium =
        Medium,
    nPorts=1,
    use_T_in=true,
    use_p_in=true)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={18,0})));

  Sources.Boundary_pT   sink(redeclare package Medium = Medium,
    use_p_in=true,
    T=TReturn,
    nPorts=1)
    "Ideal sink for return from the network" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-18,0})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow
    annotation (Placement(transformation(extent={{98,70},{118,90}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{57,-93},{71,-79}})));
  Modelica.Blocks.Sources.Constant pReturn_2(k=pReturn)
                                                       annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={24,-46})));
  Modelica.Blocks.Continuous.PID PID(
    k=100,
    Ti=0.001,
    Td=0,
    Nd=100) annotation (Placement(transformation(extent={{14,-96},{34,-76}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-38,-96},{-18,-76}})));
equation
  Q_flow =(senT_supply.T - senT_return.T)*4180*senMasFlo_supply.m_flow;

  connect(source.ports[1], senT_supply.port_a)
    annotation (Line(points={{28,0},{40,0}},       color={0,127,255}));
  connect(TIn, source.T_in)
    annotation (Line(points={{-106,70},{2,70},{2,4},{6,4}},
                                                       color={0,0,127}));
  connect(pReturn_2.y, add.u1) annotation (Line(points={{35,-46},{44.7,-46},{
          44.7,-81.8},{55.6,-81.8}},   color={0,0,127}));
  connect(senMasFlo_supply.m_flow, feedback.u1) annotation (Line(points={{80,11},
          {80,22},{-56,22},{-56,-86},{-36,-86}}, color={0,0,127}));
  connect(feedback.y, PID.u)
    annotation (Line(points={{-19,-86},{12,-86}}, color={0,0,127}));
  connect(PID.y, add.u2) annotation (Line(points={{35,-86},{46.7,-86},{46.7,
          -90.2},{55.6,-90.2}}, color={0,0,127}));
  connect(senT_return.port_a, sink.ports[1])
    annotation (Line(points={{-34,0},{-28,0}}, color={0,127,255}));
  connect(senMasFlo_return.m_flow, feedback.u2) annotation (Line(points={{-72,11},
          {-94,11},{-94,-94},{-28,-94}},     color={0,0,127}));
  connect(sink.p_in, add.y) annotation (Line(points={{-6,-8},{82,-8},{82,-86},{
          71.7,-86}}, color={0,0,127}));
  connect(source.p_in, dpIn) annotation (Line(points={{6,8},{-48,8},{-48,-70},{-106,
          -70}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{98,50},{118,70}})),
              Icon(graphics={Ellipse(
          extent={{-78,40},{2,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html><ul>
  <li>March 3, 2018, by Marcus Fuchs:<br/>
    Implemented for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 403</a>.
  </li>
</ul>
</html>", info="<html>
<p>
  This model represents the supply node with an ideal pressure source
  and sink. It provides a prescribed supply pressure and supply
  temperature to the network.
</p>
</html>"));
end SourceIdealPreturn;
