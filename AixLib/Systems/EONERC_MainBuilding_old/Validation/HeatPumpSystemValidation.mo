within AixLib.Systems.EONERC_MainBuilding_old.Validation;
model HeatPumpSystemValidation "Validation of HeatpumpSystem"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);

  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    nPorts=1,
    T=303.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-100,20})));
  Fluid.Sources.MassFlowSource_T        boundary5(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    m_flow=1,
    T=300.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,-20})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={100,-22})));
  Fluid.Sources.MassFlowSource_T        boundary3(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=4,
    use_T_in=true,
    T=291.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,20})));
  HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium,
    T_start_hot=311.15,
    T_start_cold=284.15)
    annotation (Placement(transformation(extent={{-80,-40},{80,28}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-126,-14})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1 annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={126,30})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Controller.HeatPumpSystemDataInput heatPumpSystemDataInput
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-70,-70})));
  DataHPSystem dataHPSystem
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(boundary5.ports[1], heatpumpSystem.port_a2) annotation (Line(points={
          {-90,-20},{-80,-20},{-80,-9.77778}}, color={0,127,255}));
  connect(boundary.ports[1], heatpumpSystem.port_b2) annotation (Line(points={{
          -90,20},{-80,20},{-80,5.33333}}, color={0,127,255}));
  connect(toKelvin.Kelvin, boundary5.T_in)
    annotation (Line(points={{-126,-20.6},{-116,-20.6},{-116,-16},{-112,-16}},
                                                       color={0,0,127}));
  connect(toKelvin1.Kelvin, boundary3.T_in) annotation (Line(points={{126,23.4},
          {126,16},{112,16}},          color={0,0,127}));
  connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
      Line(points={{-20,-70},{-20,-54},{0,-54},{0,-36.2222}}, color={191,0,0}));
  connect(boundary3.ports[1], heatpumpSystem.port_a1) annotation (Line(points={{90,20},
          {88,20},{88,5.33333},{80,5.33333}},        color={0,127,255}));
  connect(heatpumpSystem.port_b1, boundary2.ports[1]) annotation (Line(points={{80,
          -9.77778},{80,0.11111},{90,0.11111},{90,-22}},     color={0,127,255}));
  connect(heatPumpSystemDataInput.heatPumpSystemBus1, heatpumpSystem.heatPumpSystemBus)
    annotation (Line(
      points={{-80,70.1},{0,70.1},{0,28}},
      color={255,204,51},
      thickness=0.5));
  connect(heatPumpSystemDataInput.m_flow_cold_side, boundary3.m_flow_in)
    annotation (Line(points={{-94,59},{-94,58},{134,58},{134,12},{112,12}},
        color={0,0,127}));
  connect(heatPumpSystemDataInput.m_flow_hot_side, boundary5.m_flow_in)
    annotation (Line(points={{-90,59},{-92,59},{-92,42},{-112,42},{-112,-12}},
        color={0,0,127}));
  connect(heatPumpSystemDataInput.T_in_cold_side, toKelvin1.Celsius)
    annotation (Line(points={{-86,59},{-86,48},{126,48},{126,37.2}}, color={0,0,
          127}));
  connect(heatPumpSystemDataInput.T_in_hot_side, toKelvin.Celsius) annotation (
      Line(points={{-82,59},{-84,59},{-84,28},{-126,28},{-126,-6.8}}, color={0,
          0,127}));
  connect(heatPumpSystemDataInput.Toutside, toKelvin2.Celsius) annotation (Line(
        points={{-98,59},{-112,59},{-112,52},{-134,52},{-134,-70},{-79.6,-70}},
        color={0,0,127}));
  connect(toKelvin2.Kelvin, prescribedTemperature.T)
    annotation (Line(points={{-61.2,-70},{-42,-70}}, color={0,0,127}));
  annotation (experiment(StopTime=23400), __Dymola_Commands(file(
          ensureSimulated=true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpSystemValidation.mos"
        "Simulate and plot"));
end HeatPumpSystemValidation;
