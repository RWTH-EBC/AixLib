within AixLib.Systems.Benchmark.Model.Transfer;
model SupplyAir_RLT
  Fluid.Sources.Boundary_pT Air_in_bou(
    redeclare package Medium =AixLib.Media.Air,
    p=100000,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-52,-40})));
  Fluid.Sources.MassFlowSource_T boundary(
    use_m_flow_in=true,
    use_T_in=true,
    use_X_in=true,
    nPorts=1,
    redeclare package Medium = AixLib.Media.Air)
    annotation (Placement(transformation(extent={{-44,-30},{-64,-10}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-14,-30},{-34,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{22,-48},{10,-32}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      table=[-1,0.05,0; 0,0.05,0; 1,3.375,10125; 2,3.375,10125])
    annotation (Placement(transformation(extent={{-32,-78},{-12,-58}})));
  Modelica.Blocks.Math.Gain gain3(k=10090/(4*3600))
    annotation (Placement(transformation(extent={{-70,10},{-78,18}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=30, y_start=1)
    annotation (Placement(transformation(extent={{-16,-18},{-28,-6}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-54,-74},{-42,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression1
    annotation (Placement(transformation(extent={{-76,-84},{-64,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=1)
    annotation (Placement(transformation(extent={{-76,-68},{-64,-52}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        AixLib.Media.Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        AixLib.Media.Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
           {{-90,-120},{-50,-80}}), iconTransformation(extent={{-70,-110},{-50,
            -90}})));
  BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
           {{-52,-120},{-12,-80}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput RLT_Velocity
    "Connector of Real output signals"
    annotation (Placement(transformation(extent={{-96,4},{-116,24}})));
  Modelica.Blocks.Interfaces.RealInput AirTemp annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={104,-16})));
  Modelica.Blocks.Interfaces.RealInput WaterInAir annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={104,22})));
equation
  connect(boundary.ports[1],Air_out)
    annotation (Line(points={{-64,-20},{-100,-20}}, color={0,127,255}));
  connect(realExpression.y,feedback. u1)
    annotation (Line(points={{9.4,-40},{-16,-40}}, color={0,0,127}));
  connect(Air_in,Air_in_bou. ports[1])
    annotation (Line(points={{-100,-60},{-92,-60},{-92,-40},{-62,-40}},
                                                    color={0,127,255}));
  connect(RLT_Velocity,gain3. y)
    annotation (Line(points={{-106,14},{-78.4,14}}, color={0,0,127}));
  connect(gain3.u,combiTable1Ds. y[1]) annotation (Line(points={{-69.2,14},{-60,
          14},{-60,0},{-8,0},{-8,-68},{-11,-68}}, color={0,0,127}));
  connect(combiTable1Ds.y[2],measureBus. Fan_RLT) annotation (Line(points={{-11,
          -68},{0,-68},{0,-84},{-31.9,-84},{-31.9,-99.9}}, color={0,0,127}));
  connect(boundary.m_flow_in,firstOrder. y)
    annotation (Line(points={{-42,-12},{-28.6,-12}}, color={0,0,127}));
  connect(firstOrder.u,combiTable1Ds. y[1]) annotation (Line(points={{-14.8,-12},
          {-8,-12},{-8,-68},{-11,-68}}, color={0,0,127}));
  connect(realExpression1.y,switch1. u3) annotation (Line(points={{-63.4,-76},{
          -60,-76},{-60,-72.8},{-55.2,-72.8}}, color={0,0,127}));
  connect(switch1.y,combiTable1Ds. u)
    annotation (Line(points={{-41.4,-68},{-34,-68}}, color={0,0,127}));
  connect(realExpression2.y,switch1. u1) annotation (Line(points={{-63.4,-60},{
          -58,-60},{-58,-63.2},{-55.2,-63.2}}, color={0,0,127}));
  connect(switch1.u2,controlBus. OnOff_RLT) annotation (Line(points={{-55.2,-68},
          {-88,-68},{-88,-99.9},{-69.9,-99.9}}, color={255,0,255}));
  connect(RLT_Velocity, RLT_Velocity)
    annotation (Line(points={{-106,14},{-106,14}}, color={0,0,127}));
  connect(AirTemp, measureBus.AirTemp) annotation (Line(points={{104,-16},{30,
          -16},{30,-99.9},{-31.9,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(AirTemp, boundary.T_in)
    annotation (Line(points={{104,-16},{-42,-16}}, color={0,0,127}));
  connect(WaterInAir, measureBus.WaterInAir) annotation (Line(points={{104,22},
          {30,22},{30,-99.9},{-31.9,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(WaterInAir, feedback.u2) annotation (Line(points={{104,22},{30,22},{
          30,-32},{-24,-32}}, color={0,0,127}));
  connect(feedback.y, boundary.X_in[2]) annotation (Line(points={{-33,-40},{-38,
          -40},{-38,-24},{-42,-24}}, color={0,0,127}));
  connect(WaterInAir, boundary.X_in[1]) annotation (Line(points={{104,22},{30,
          22},{30,-24},{-42,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SupplyAir_RLT;
