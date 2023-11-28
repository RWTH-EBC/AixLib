within AixLib.Systems.EONERC_Testhall.BaseClass.JetNozzle;
model JN_approxAirflow
  Fluid.Sources.MassFlowSource_T              boundary1(
    redeclare package Medium = Media.Air,
    use_m_flow_in=true,
    nPorts=1)       annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={30,-4})));
  Modelica.Blocks.Sources.CombiTimeTable JN_mflow(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/JNmflow.txt"),
    columns=2:9,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-62,-12},{-42,8}})));
  Modelica.Blocks.Math.MultiSum mflow_jn_total(nu=10)
    annotation (Placement(transformation(extent={{-26,-8},{-16,2}})));
  Modelica.Fluid.Interfaces.FluidPort_a jn_vl_air(redeclare package Medium =
        Media.Air) annotation (Placement(transformation(extent={{92,-14},{112,6}}),
        iconTransformation(extent={{88,-54},{108,-34}})));
  Modelica.Fluid.Interfaces.FluidPort_b jn_rl_air(redeclare package Medium =
        Media.Air) annotation (Placement(transformation(extent={{90,24},{110,44}}),
        iconTransformation(extent={{86,22},{106,42}})));
  Fluid.Sources.MassFlowSource_T              boundary2(
    use_m_flow_in=true,
    redeclare package Medium = Media.Air,
    use_T_in=true,
    nPorts=1)       annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={46,36})));
  Modelica.Blocks.Sources.CombiTimeTable Hall1_Temp(
    tableOnFile=true,
    tableName="measurement",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Hall1Temp.txt"),
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-40,28},{-20,48}})));

  Fluid.FixedResistances.HydraulicDiameter res_vl_air(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=2.64,
    length=3) annotation (Placement(transformation(extent={{68,-14},{48,6}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-4,-10},{8,2}})));
  Fluid.FixedResistances.HydraulicDiameter res_rl_air(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=2.64,
    length=3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={72,34})));
equation
  connect(JN_mflow.y[1],mflow_jn_total. u[1]) annotation (Line(points={{-41,-2},
          {-28.5,-2},{-28.5,-4.575},{-26,-4.575}},    color={0,0,127}));
  connect(JN_mflow.y[2],mflow_jn_total. u[2]) annotation (Line(points={{-41,-2},
          {-41,-4.225},{-26,-4.225}},   color={0,0,127}));
  connect(JN_mflow.y[3],mflow_jn_total. u[3]) annotation (Line(points={{-41,-2},
          {-41,-3.875},{-26,-3.875}},   color={0,0,127}));
  connect(JN_mflow.y[4],mflow_jn_total. u[4]) annotation (Line(points={{-41,-2},
          {-41,-3.525},{-26,-3.525}},   color={0,0,127}));
  connect(JN_mflow.y[5],mflow_jn_total. u[5]) annotation (Line(points={{-41,-2},
          {-41,-3.175},{-26,-3.175}},   color={0,0,127}));
  connect(JN_mflow.y[6],mflow_jn_total. u[6]) annotation (Line(points={{-41,-2},
          {-41,-2.825},{-26,-2.825}},   color={0,0,127}));
  connect(JN_mflow.y[7],mflow_jn_total. u[7]) annotation (Line(points={{-41,-2},
          {-41,-2.475},{-26,-2.475}},   color={0,0,127}));
  connect(JN_mflow.y[8],mflow_jn_total. u[8]) annotation (Line(points={{-41,-2},
          {-41,-2.125},{-26,-2.125}},   color={0,0,127}));
  connect(JN_mflow.y[1],mflow_jn_total. u[9]) annotation (Line(points={{-41,-2},
          {-41,-1.775},{-26,-1.775}},   color={0,0,127}));
  connect(JN_mflow.y[2],mflow_jn_total. u[10]) annotation (Line(points={{-41,-2},
          {-41,-1.425},{-26,-1.425}},   color={0,0,127}));
  connect(gain1.y,boundary1. m_flow_in) annotation (Line(points={{8.6,-4},{8.6,
          -8.8},{22.8,-8.8}},    color={0,0,127}));
  connect(res_vl_air.port_b, boundary1.ports[1])
    annotation (Line(points={{48,-4},{36,-4}}, color={0,127,255}));
  connect(boundary2.ports[1], res_rl_air.port_a)
    annotation (Line(points={{52,36},{52,34},{62,34}}, color={0,127,255}));
  connect(res_rl_air.port_b, jn_rl_air)
    annotation (Line(points={{82,34},{100,34}}, color={0,127,255}));
  connect(gain1.u, mflow_jn_total.y)
    annotation (Line(points={{-5.2,-4},{-5.2,-3},{-15.15,-3}},
                                                             color={0,0,127}));
  connect(mflow_jn_total.y, boundary2.m_flow_in) annotation (Line(points={{-15.15,
          -3},{-12,-3},{-12,26},{38.8,26},{38.8,31.2}},
                                                    color={0,0,127}));
  connect(Hall1_Temp.y[1], boundary2.T_in) annotation (Line(points={{-19,38},{
          30,38},{30,33.6},{38.8,33.6}}, color={0,0,127}));
  connect(jn_vl_air, res_vl_air.port_a)
    annotation (Line(points={{102,-4},{68,-4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-52,18},{58,-48}},
          textColor={28,108,200},
          textString="JN
")}),                                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end JN_approxAirflow;
