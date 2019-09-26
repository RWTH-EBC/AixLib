within AixLib.Systems.EONERC_MainBuilding;
model HeatPumpSystemValidation "Validation of HeatpumpSystem"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    parameter DataHPSystem Data;

  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    nPorts=1,
    T=303.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-102,20})));
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
        origin={104,-10})));
  Fluid.Sources.MassFlowSource_T        boundary3(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=4,
    use_T_in=true,
    T=291.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={104,16})));
  HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-80,-28},{80,40}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-126,-14})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1 annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={126,18})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-20,-78},{0,-58}})));
  HeatPumpSystemConstantControl heatPumpSystemConstantControl(table=Data.October2015)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-52,-68})));
equation
  connect(boundary5.ports[1], heatpumpSystem.fluidportBottom1) annotation (Line(
        points={{-90,-20},{-80,-20},{-80,2.22222}},            color={0,127,255}));
  connect(boundary.ports[1], heatpumpSystem.fluidportTop1) annotation (Line(
        points={{-92,20},{-80,20},{-80,17.3333}},          color={0,127,255}));
  connect(toKelvin.Kelvin, boundary5.T_in)
    annotation (Line(points={{-126,-20.6},{-116,-20.6},{-116,-16},{-112,-16}},
                                                       color={0,0,127}));
  connect(toKelvin1.Kelvin, boundary3.T_in) annotation (Line(points={{126,11.4},
          {126,12},{116,12}},          color={0,0,127}));
  connect(prescribedTemperature.port, heatpumpSystem.T_amb)
    annotation (Line(points={{0,-68},{0,-24.2222}}, color={191,0,0}));
  connect(boundary3.ports[1], heatpumpSystem.port_a1) annotation (Line(points={{94,16},
          {88,16},{88,17.3333},{80,17.3333}},        color={0,127,255}));
  connect(heatpumpSystem.port_b1, boundary2.ports[1]) annotation (Line(points={{
          80,2.22222},{80,-9.88889},{94,-9.88889},{94,-10}}, color={0,127,255}));
  connect(heatPumpSystemConstantControl.heatPumpSystemBus1, heatpumpSystem.heatPumpSystemBus)
    annotation (Line(
      points={{-80,70.1},{0,70.1},{0,40}},
      color={255,204,51},
      thickness=0.5));
  connect(heatPumpSystemConstantControl.m_flow_cold_side, boundary3.m_flow_in)
    annotation (Line(points={{-94,59},{-94,58},{134,58},{134,8},{116,8}}, color
        ={0,0,127}));
  connect(heatPumpSystemConstantControl.m_flow_hot_side, boundary5.m_flow_in)
    annotation (Line(points={{-90,59},{-92,59},{-92,42},{-112,42},{-112,-12}},
        color={0,0,127}));
  connect(heatPumpSystemConstantControl.T_in_cold_side, toKelvin1.Celsius)
    annotation (Line(points={{-86,59},{-86,48},{126,48},{126,25.2}}, color={0,0,
          127}));
  connect(heatPumpSystemConstantControl.T_in_hot_side, toKelvin.Celsius)
    annotation (Line(points={{-82,59},{-84,59},{-84,28},{-126,28},{-126,-6.8}},
        color={0,0,127}));
  connect(heatPumpSystemConstantControl.Toutside, toKelvin2.Celsius)
    annotation (Line(points={{-98,59},{-112,59},{-112,52},{-134,52},{-134,-68},
          {-59.2,-68}}, color={0,0,127}));
  connect(toKelvin2.Kelvin, prescribedTemperature.T)
    annotation (Line(points={{-45.4,-68},{-22,-68}}, color={0,0,127}));
  annotation (experiment(StopTime=864000));
end HeatPumpSystemValidation;
