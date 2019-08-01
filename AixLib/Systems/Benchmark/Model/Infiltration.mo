within AixLib.Systems.Benchmark.Model;
model Infiltration
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
    parameter Modelica.SIunits.Volume room_V_openplanoffice = 50;
    parameter Modelica.SIunits.Volume room_V_conferenceroom = 50;
    parameter Modelica.SIunits.Volume room_V_multipersonoffice = 50;
    parameter Modelica.SIunits.Volume room_V_canteen = 50;
    parameter Modelica.SIunits.Volume room_V_workshop = 50;
    parameter Real n50(unit = "h-1") = 4
    "Air exchange rate at 50 Pa pressure difference";
    parameter Real e = 0.03 "Coefficient of windshield";
    parameter Real eps = 1.0 "Coefficient of height";
    parameter Modelica.SIunits.Density rho = 1.25 "Air density";
  Fluid.Sources.MassFlowSource_T Openplanoffice(
    use_T_in=true,
    use_X_in=true,
    redeclare package Medium = Medium_Air,
    use_m_flow_in=false,
    nPorts=1,
    m_flow=2*n50*e*eps*room_V_openplanoffice*rho/3600)
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
  BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
           {{-120,-20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,
            10}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-32,66},{-12,86}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-68,68},{-56,84}})));
  Fluid.Sources.MassFlowSource_T Conferenceroom(
    use_T_in=true,
    use_X_in=true,
    nPorts=1,
    redeclare package Medium = Medium_Air,
    use_m_flow_in=false,
    m_flow=2*n50*e*eps*room_V_conferenceroom*rho/3600)
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{-32,26},{-12,46}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(
                                                        y=1)
    annotation (Placement(transformation(extent={{-68,28},{-56,44}})));
  Fluid.Sources.MassFlowSource_T Multipersonoffice(
    use_T_in=true,
    use_X_in=true,
    nPorts=1,
    redeclare package Medium = Medium_Air,
    use_m_flow_in=false,
    m_flow=2*n50*e*eps*room_V_multipersonoffice*rho/3600)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Math.Feedback feedback2
    annotation (Placement(transformation(extent={{-32,-14},{-12,6}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(
                                                        y=1)
    annotation (Placement(transformation(extent={{-68,-12},{-56,4}})));
  Fluid.Sources.MassFlowSource_T Canteen(
    use_T_in=true,
    use_X_in=true,
    nPorts=1,
    redeclare package Medium = Medium_Air,
    use_m_flow_in=false,
    m_flow=2*n50*e*eps*room_V_canteen*rho/3600)
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Math.Feedback feedback3
    annotation (Placement(transformation(extent={{-32,-54},{-12,-34}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(
                                                        y=1)
    annotation (Placement(transformation(extent={{-68,-52},{-56,-36}})));
  Fluid.Sources.MassFlowSource_T Workshop(
    use_T_in=true,
    use_X_in=true,
    nPorts=1,
    redeclare package Medium = Medium_Air,
    use_m_flow_in=false,
    m_flow=2*n50*e*eps*room_V_workshop*rho/3600)
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Modelica.Blocks.Math.Feedback feedback4
    annotation (Placement(transformation(extent={{-32,-94},{-12,-74}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(
                                                        y=1)
    annotation (Placement(transformation(extent={{-68,-92},{-56,-76}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out[5](redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Fluid.FixedResistances.PressureDrop pip(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=2*n50*e*eps*room_V_openplanoffice*rho,
    allowFlowReversal=false,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Fluid.FixedResistances.PressureDrop pip1(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=2*n50*e*eps*room_V_conferenceroom*rho,
    allowFlowReversal=false,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Fluid.FixedResistances.PressureDrop pip2(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=2*n50*e*eps*room_V_multipersonoffice*rho,
    allowFlowReversal=false,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Fluid.FixedResistances.PressureDrop pip3(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=2*n50*e*eps*room_V_canteen*rho,
    allowFlowReversal=false,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Fluid.FixedResistances.PressureDrop pip4(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=2*n50*e*eps*room_V_workshop*rho,
    allowFlowReversal=false,
    dp_nominal=1)
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
equation
  connect(Openplanoffice.T_in, measureBus.AirTemp) annotation (Line(points={{-2,
          84},{-40,84},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(feedback.y, Openplanoffice.X_in[2])
    annotation (Line(points={{-13,76},{-2,76}}, color={0,0,127}));
  connect(Openplanoffice.X_in[1], measureBus.WaterInAir) annotation (Line(
        points={{-2,76},{-10,76},{-10,84},{-40,84},{-40,0.1},{-99.9,0.1}},
        color={0,0,127}));
  connect(realExpression.y, feedback.u1)
    annotation (Line(points={{-55.4,76},{-30,76}}, color={0,0,127}));
  connect(feedback.u2, measureBus.WaterInAir) annotation (Line(points={{-22,68},
          {-22,60},{-40,60},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(Conferenceroom.T_in, measureBus.AirTemp) annotation (Line(points={{-2,
          44},{-40,44},{-40,0},{-70,0},{-70,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(feedback1.y, Conferenceroom.X_in[2]) annotation (Line(points={{-13,36},
          {-8,36},{-8,36},{-2,36},{-2,36}}, color={0,0,127}));
  connect(Conferenceroom.X_in[1], measureBus.WaterInAir) annotation (Line(
        points={{-2,36},{-8,36},{-8,44},{-40,44},{-40,0},{-70,0},{-70,0.1},{-99.9,
          0.1}}, color={0,0,127}));
  connect(realExpression1.y, feedback1.u1) annotation (Line(points={{-55.4,36},{
          -46,36},{-46,36},{-38,36},{-38,36},{-30,36}}, color={0,0,127}));
  connect(feedback1.u2, measureBus.WaterInAir) annotation (Line(points={{-22,28},
          {-22,20},{-40,20},{-40,0},{-40,0},{-40,0},{-40,0},{-40,0},{-40,0},{-40,
          0},{-40,0.1},{-70,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(Multipersonoffice.T_in, measureBus.AirTemp) annotation (Line(points={{
          -2,4},{-40,4},{-40,0},{-70,0},{-70,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(feedback2.y, Multipersonoffice.X_in[2]) annotation (Line(points={{-13,
          -4},{-8,-4},{-8,-4},{-2,-4},{-2,-4}}, color={0,0,127}));
  connect(Multipersonoffice.X_in[1], measureBus.WaterInAir) annotation (Line(
        points={{-2,-4},{-10,-4},{-10,4},{-20,4},{-20,4},{-40,4},{-40,0},{-70,0},
          {-70,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(realExpression2.y, feedback2.u1) annotation (Line(points={{-55.4,-4},{
          -46,-4},{-46,-4},{-40,-4},{-40,-4},{-30,-4}}, color={0,0,127}));
  connect(feedback2.u2, measureBus.WaterInAir) annotation (Line(points={{-22,-12},
          {-22,-20},{-40,-20},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(Canteen.T_in, measureBus.AirTemp) annotation (Line(points={{-2,-36},{-40,
          -36},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(feedback3.y, Canteen.X_in[2]) annotation (Line(points={{-13,-44},{-10,
          -44},{-10,-44},{-2,-44},{-2,-44}}, color={0,0,127}));
  connect(Canteen.X_in[1], measureBus.WaterInAir) annotation (Line(points={{-2,-44},
          {-8,-44},{-8,-36},{-40,-36},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(realExpression3.y, feedback3.u1) annotation (Line(points={{-55.4,-44},
          {-46,-44},{-46,-44},{-38,-44},{-38,-44},{-30,-44}}, color={0,0,127}));
  connect(feedback3.u2, measureBus.WaterInAir) annotation (Line(points={{-22,-52},
          {-22,-60},{-40,-60},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(Workshop.T_in, measureBus.AirTemp) annotation (Line(points={{-2,-76},{
          -40,-76},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(feedback4.y, Workshop.X_in[2]) annotation (Line(points={{-13,-84},{-8,
          -84},{-8,-84},{-2,-84},{-2,-84}}, color={0,0,127}));
  connect(Workshop.X_in[1], measureBus.WaterInAir) annotation (Line(points={{-2,
          -84},{-8,-84},{-8,-76},{-40,-76},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(realExpression4.y, feedback4.u1) annotation (Line(points={{-55.4,-84},
          {-46,-84},{-46,-84},{-38,-84},{-38,-84},{-30,-84}}, color={0,0,127}));
  connect(feedback4.u2, measureBus.WaterInAir) annotation (Line(points={{-22,-92},
          {-22,-100},{-40,-100},{-40,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(Openplanoffice.ports[1], pip.port_a)
    annotation (Line(points={{20,80},{40,80}}, color={0,127,255}));
  connect(pip.port_b, Air_out[1]) annotation (Line(points={{60,80},{70,80},{70,
          -8},{100,-8}}, color={0,127,255}));
  connect(Conferenceroom.ports[1], pip1.port_a)
    annotation (Line(points={{20,40},{40,40}}, color={0,127,255}));
  connect(Multipersonoffice.ports[1], pip2.port_a)
    annotation (Line(points={{20,0},{40,0}}, color={0,127,255}));
  connect(Canteen.ports[1], pip3.port_a)
    annotation (Line(points={{20,-40},{40,-40}}, color={0,127,255}));
  connect(Workshop.ports[1], pip4.port_a)
    annotation (Line(points={{20,-80},{40,-80}}, color={0,127,255}));
  connect(pip1.port_b, Air_out[2]) annotation (Line(points={{60,40},{70,40},{70,
          -4},{100,-4}}, color={0,127,255}));
  connect(pip2.port_b, Air_out[3])
    annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
  connect(pip3.port_b, Air_out[4]) annotation (Line(points={{60,-40},{70,-40},{
          70,4},{100,4}}, color={0,127,255}));
  connect(pip4.port_b, Air_out[5]) annotation (Line(points={{60,-80},{70,-80},{
          70,8},{100,8}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Infiltration;
