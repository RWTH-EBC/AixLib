within AixLib.Systems.EONERC_MainBuilding.Validation;
model GTFValidation "Validation of geothermal field"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  parameter DataGTF Data;
  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={42,40})));
  Fluid.Sources.MassFlowSource_T        boundary5(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=1,
    use_T_in=true,
    T=300.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-22,40})));

  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=Data.October2015,
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
                                                          annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-50,70})));
  GeothermalFieldSimple geothermalFieldSimple(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    T_start=286.65,
    T_amb=289.65,
    pump(T_start=288.15),
    throttle(T_start=288.15),
    vol(T_start=288.15))
    annotation (Placement(transformation(extent={{-6,-66},{40,0}})));
  BaseClasses.TwoCircuitBus twoCircuitBus1 annotation (Placement(transformation(
          extent={{-30,-30},{-10,-10}}), iconTransformation(extent={{-80,-38},{
            -60,-18}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Blocks.Sources.Constant const1(k=2100)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-80,-62},{-70,-52}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1
    annotation (Placement(transformation(extent={{-80,-50},{-70,-40}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation
  connect(toKelvin1.Kelvin, boundary5.T_in)
    annotation (Line(points={{-43.4,70},{-18,70},{-18,52}}, color={0,0,127}));
  connect(geothermalFieldSimple.port_a, boundary5.ports[1]) annotation (Line(
        points={{-2.16667,0},{-2,0},{-2,20},{-22,20},{-22,30}},     color={0,
          127,255}));
  connect(geothermalFieldSimple.port_b, boundary.ports[1]) annotation (Line(
        points={{36.1667,0},{36.1667,20},{42,20},{42,30}},  color={0,127,255}));
  connect(geothermalFieldSimple.twoCircuitBus, twoCircuitBus1) annotation (Line(
      points={{-6.19167,-20.8312},{-20,-20.8312},{-20,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boundary5.m_flow_in, combiTimeTable.y[3]) annotation (Line(points={{-14,52},
          {-14,84},{-76,84},{-76,70},{-79,70}},         color={0,0,127}));
  connect(combiTimeTable.y[1], toKelvin1.Celsius)
    annotation (Line(points={{-79,70},{-57.2,70}}, color={0,0,127}));
  connect(const1.y, twoCircuitBus1.primBus.pumpBus.rpmSet) annotation (Line(
        points={{-39,10},{-19.95,10},{-19.95,-19.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, twoCircuitBus1.secBus.valveSet) annotation (Line(points={{-39,
          -20},{-26,-20},{-26,-19.95},{-19.95,-19.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold.u, combiTimeTable.y[7]) annotation (Line(points={{
          -81,-57},{-90,-57},{-90,40},{-74,40},{-74,70},{-79,70}}, color={0,0,
          127}));
  connect(greaterThreshold1.u, combiTimeTable.y[8]) annotation (Line(points={{
          -81,-45},{-90,-45},{-90,40},{-74,40},{-74,70},{-79,70}}, color={0,0,
          127}));
  connect(greaterThreshold.y, or1.u2) annotation (Line(points={{-69.5,-57},{
          -64.75,-57},{-64.75,-58},{-62,-58}}, color={255,0,255}));
  connect(greaterThreshold1.y, or1.u1) annotation (Line(points={{-69.5,-45},{
          -64.75,-45},{-64.75,-50},{-62,-50}}, color={255,0,255}));
  connect(or1.y, twoCircuitBus1.primBus.pumpBus.onSet) annotation (Line(
        points={{-39,-50},{-19.95,-50},{-19.95,-19.95}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (experiment(StopTime=2246400, __Dymola_Algorithm="Dassl"),
                                         __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_GTFValidation.mos"
        "Simulate and plot"));
end GTFValidation;
