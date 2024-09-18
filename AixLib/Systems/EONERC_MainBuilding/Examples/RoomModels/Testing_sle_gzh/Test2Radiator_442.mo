within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels.Testing_sle_gzh;
model Test2Radiator_442
    extends Modelica.Icons.Example;
 package Medium = AixLib.Media.Water "Medium model";
  parameter Modelica.Units.SI.Temperature TRoo=20 + 273.15 "Room temperature"
    annotation (Evaluate=false);
  parameter Modelica.Units.SI.Power Q_flow_nominal=500 "Nominal power";
  parameter Modelica.Units.SI.Temperature T_a_nominal=313.15
    "Radiator inlet temperature at nominal condition";
  parameter Modelica.Units.SI.Temperature T_b_nominal=303.15
    "Radiator outlet temperature at nominal condition";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=Q_flow_nominal/(
      T_a_nominal - T_b_nominal)/Medium.cp_const "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal=3000
    "Pressure drop at m_flow_nominal";
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad442(
    redeclare package Medium = Medium,
    T_a_nominal=313.15,
    T_b_nominal=303.15,
    Q_flow_nominal=500,
    TAir_nominal=293.15,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) "Radiator"
    annotation (Placement(transformation(extent={{-22,0},{-2,20}})));
  Fluid.FixedResistances.PressureDrop
                                res1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=3000)
    annotation (Placement(transformation(extent={{48,0},{68,20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature convTemp442(T=293.15)
    "Convetive heat"
    annotation (Placement(transformation(extent={{-42,52},{-22,72}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature radTemp442(T=293.15)
    "Radiative heat"
    annotation (Placement(transformation(extent={{18,52},{-2,72}})));
  Fluid.Sources.MassFlowSource_T
                           source(
    redeclare package Medium = AixLib.Media.Water,
    use_T_in=true,
    m_flow=0.01,
    T=328.15,
    nPorts=1) annotation (Placement(transformation(extent={{-58,-2},{-38,18}})));
  Fluid.Sources.Boundary_pT
                        sink(redeclare package Medium = Media.Water, nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{102,0},{82,20}})));
  Fluid.Sensors.TemperatureTwoPort ReturnTemperature442(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal) "Return temperature"
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Modelica.Blocks.Sources.Step step(
    startTime=7200,
    offset=313.15,
    height=5)
    annotation (Placement(transformation(extent={{-98,-12},{-78,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression43(y=source.ports[1].h_outflow)
    annotation (Placement(transformation(extent={{-252,-36},{-232,-16}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-206,-50},{-186,-30}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-242,-70},{-222,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression44(y=rad442.port_b.h_outflow)
    annotation (Placement(transformation(extent={{-284,-70},{-264,-50}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=2)
    annotation (Placement(transformation(extent={{-166,-52},{-154,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression45(y=source.m_flow)
    annotation (Placement(transformation(extent={{-192,-82},{-172,-62}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_sum442 "Value of Real output"
    annotation (Placement(transformation(extent={{-118,-70},{-98,-50}})));
equation
  connect(rad442.heatPortCon, convTemp442.port)
    annotation (Line(points={{-14,17.2},{-14,62},{-22,62}}, color={191,0,0}));
  connect(rad442.heatPortRad, radTemp442.port)
    annotation (Line(points={{-10,17.2},{-10,62},{-2,62}}, color={191,0,0}));
  connect(res1.port_b, sink.ports[1])
    annotation (Line(points={{68,10},{82,10}}, color={0,127,255}));
  connect(rad442.port_a, source.ports[1])
    annotation (Line(points={{-22,10},{-22,8},{-38,8}}, color={0,127,255}));
  connect(rad442.port_b, ReturnTemperature442.port_a)
    annotation (Line(points={{-2,10},{10,10}}, color={0,127,255}));
  connect(ReturnTemperature442.port_b, res1.port_a)
    annotation (Line(points={{30,10},{48,10}}, color={0,127,255}));
  connect(step.y, source.T_in) annotation (Line(points={{-77,-2},{-68,-2},{-68,
          12},{-60,12}}, color={0,0,127}));
  connect(realExpression43.y,add. u1) annotation (Line(points={{-231,-26},{-218,
          -26},{-218,-34},{-208,-34}},         color={0,0,127}));
  connect(realExpression44.y,gain. u)
    annotation (Line(points={{-263,-60},{-244,-60}},   color={0,0,127}));
  connect(gain.y,add. u2) annotation (Line(points={{-221,-60},{-214,-60},{-214,
          -54},{-216,-54},{-216,-46},{-208,-46}},          color={0,0,127}));
  connect(add.y,multiProduct. u[1]) annotation (Line(points={{-185,-40},{-172,
          -40},{-172,-47.05},{-166,-47.05}},    color={0,0,127}));
  connect(realExpression45.y,multiProduct. u[2]) annotation (Line(points={{-171,
          -72},{-166,-72},{-166,-56},{-170,-56},{-170,-44.95},{-166,-44.95}},
                     color={0,0,127}));
  connect(multiProduct.y, Q_flow_sum442) annotation (Line(points={{-152.98,-46},
          {-124,-46},{-124,-60},{-108,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test2Radiator_442;
