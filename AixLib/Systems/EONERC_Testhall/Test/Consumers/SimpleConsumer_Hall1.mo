within AixLib.Systems.EONERC_Testhall.BaseClasses.Consumers;
model SimpleConsumer_Hall1

   replaceable package MediumWater =
      AixLib.Media.Water
    "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);


   AixLib.Systems.HydraulicModules.SimpleConsumer Hall1(
    redeclare package Medium = AixLib.Media.Air,
    capacity=1,
    Q_flow_fixed=20,
    m_flow_nominal=3.7,
    T_start=295.35,
    functionality="Q_flow_input") "Thermal zone"
    annotation (Placement(transformation(extent={{-64,116},{36,216}})));

  AixLib.Fluid.Sources.MassFlowSource_T Sup(
    redeclare package Medium = AixLib.Media.Air,
    m_flow=3.7,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-112,82},{-92,102}})));
  AixLib.Fluid.Sources.Boundary_pT Ret(
    redeclare package Medium = AixLib.Media.Air,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{90,76},{70,96}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 20)
    annotation (Placement(transformation(extent={{-170,90},{-150,110}})));
  Modelica.Blocks.Sources.Constant const(k=-100e3)
    annotation (Placement(transformation(extent={{-114,240},{-94,260}})));
equation

  connect(Sup.ports[1], Hall1.port_a) annotation (Line(points={{-92,92},{-80,92},
          {-80,166},{-64,166}}, color={0,127,255}));
  connect(Ret.ports[1], Hall1.port_b) annotation (Line(points={{70,86},{40,86},
          {40,166},{36,166}}, color={0,127,255}));
  connect(realExpression.y, Sup.T_in) annotation (Line(points={{-149,100},{-122,
          100},{-122,96},{-114,96}}, color={0,0,127}));
  connect(const.y, Hall1.Q_flow)
    annotation (Line(points={{-93,250},{-44,250},{-44,216}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -40},{120,280}}),
                          graphics={
        Rectangle(
          extent={{-58,262},{1448,0}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,252},{152,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{166,252},{326,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{340,252},{500,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{510,252},{670,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{682,252},{842,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{856,252},{1016,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{1032,252},{1192,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{1210,252},{1370,214}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-44,72},{130,8}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="Hall2"),
        Text(
          extent={{154,72},{328,8}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="Hall1"),
        Text(
          extent={{310,66},{584,8}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O1"),
        Text(
          extent={{528,66},{802,8}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O2"),
        Text(
          extent={{754,70},{1028,12}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O3"),
        Text(
          extent={{968,72},{1242,14}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O4"),
        Text(
          extent={{1192,72},{1466,14}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          fontSize=11,
          textString="O5")}),
                           Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-40},{120,280}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Dassl"));
end SimpleConsumer_Hall1;
