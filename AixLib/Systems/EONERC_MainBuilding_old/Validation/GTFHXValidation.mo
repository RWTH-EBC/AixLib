within AixLib.Systems.EONERC_MainBuilding_old.Validation;
model GTFHXValidation "Validation of heat exchanger of geothermal field"
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
        origin={66,50})));
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
  Fluid.Sources.MassFlowSource_T        boundary1(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=1,
    use_T_in=true,
    T=300.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-44})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
                                                          annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-58,-70})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=303.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-34,-30})));
  Fluid.HeatExchangers.DynamicHX dynamicHX(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=16,
    m2_flow_nominal=10,
    dp1_nominal=14000,
    dp2_nominal=48000,
    nNodes=3,
    tau1=5,
    tau2=5,
    redeclare Fluid.MixingVolumes.MixingVolume vol1,
    redeclare Fluid.MixingVolumes.MixingVolume vol2,
    tau_C=10,
    dT_nom=1,
    Q_nom=800000)                          annotation (Placement(transformation(
        extent={{21,22},{-21,-22}},
        rotation=0,
        origin={6,5})));
  Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare package Medium = Medium,
    m_flow_nominal=5,
    tau=0.01) annotation (Placement(transformation(extent={{38,8},{58,28}})));
  Fluid.Sensors.TemperatureTwoPort senTem1(
    redeclare package Medium = Medium,
    m_flow_nominal=5,
    tau=0.01) annotation (Placement(transformation(extent={{-20,-18},{-40,2}})));
equation
  connect(toKelvin1.Kelvin, boundary5.T_in)
    annotation (Line(points={{-43.4,70},{-18,70},{-18,52}}, color={0,0,127}));
  connect(boundary5.m_flow_in, combiTimeTable.y[3]) annotation (Line(points={{-14,52},
          {-14,84},{-76,84},{-76,70},{-79,70}},         color={0,0,127}));
  connect(combiTimeTable.y[1], toKelvin1.Celsius)
    annotation (Line(points={{-79,70},{-57.2,70}}, color={0,0,127}));
  connect(toKelvin2.Kelvin,boundary1. T_in)
    annotation (Line(points={{-51.4,-70},{26,-70},{26,-56}},color={0,0,127}));
  connect(boundary5.ports[1], dynamicHX.port_a2) annotation (Line(points={{-22,
          30},{-22,18.2},{-15,18.2}}, color={0,127,255}));
  connect(boundary1.m_flow_in, combiTimeTable.y[6]) annotation (Line(points={{
          22,-56},{-64,-56},{-64,-50},{-72,-50},{-72,70},{-79,70}}, color={0,0,
          127}));
  connect(boundary1.ports[1], dynamicHX.port_a1) annotation (Line(points={{30,
          -34},{30,-8.2},{27,-8.2}}, color={0,127,255}));
  connect(dynamicHX.port_b2, senTem.port_a) annotation (Line(points={{27,18.2},
          {32.5,18.2},{32.5,18},{38,18}}, color={0,127,255}));
  connect(senTem.port_b, boundary.ports[1])
    annotation (Line(points={{58,18},{66,18.2},{66,40}}, color={0,127,255}));
  connect(senTem1.port_a, dynamicHX.port_b1) annotation (Line(points={{-20,-8},
          {-22,-8},{-22,-8.2},{-15,-8.2}}, color={0,127,255}));
  connect(senTem1.port_b, boundary2.ports[1]) annotation (Line(points={{-40,-8},
          {-42,-8},{-42,-20},{-34,-20}}, color={0,127,255}));
  connect(toKelvin2.Celsius, combiTimeTable.y[5]) annotation (Line(points={{
          -65.2,-70},{-78,-70},{-78,70},{-79,70}}, color={0,0,127}));
  annotation (experiment(StopTime=604800, __Dymola_NumberOfIntervals=5000),
                                         __Dymola_Commands(file(ensureSimulated=
           true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpValidation.mos"
        "Simulate and plot"));
end GTFHXValidation;
