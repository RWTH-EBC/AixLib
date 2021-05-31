within AixLib.Systems.EONERC_MainBuilding.Examples.ForControllerTesting;
model HeatPumpSystemVolumeFlowControlled_Inputs "Validation of HeatpumpSystem"
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
        origin={-128,-28})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1 annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={126,30})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-70,-70})));
  Controller.HeatPumpSystemVolumeFlowControl heatPumpSystemVolumeFlowControl
    annotation (Placement(transformation(extent={{-24,66},{-4,98}})));
  Modelica.Blocks.Sources.Constant const8(k=100)
    annotation (Placement(transformation(extent={{-54,80},{-46,88}})));
  Modelica.Blocks.Interfaces.RealInput pElHP "Connector of Real input signal 1"
    annotation (Placement(transformation(extent={{-110,96},{-92,114}}),
        iconTransformation(extent={{-110,96},{-92,114}})));
  Modelica.Blocks.Interfaces.RealInput vSetHS
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-110,80},{-90,100}}), iconTransformation(extent=
           {{-110,80},{-90,100}})));
  Modelica.Blocks.Interfaces.RealInput vSetCold
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-110,52},{-92,70}}), iconTransformation(extent=
            {{-110,52},{-92,70}})));
  Modelica.Blocks.Interfaces.RealInput vSetRecool
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-110,68},{-92,86}}), iconTransformation(extent=
            {{-110,68},{-92,86}})));
  Modelica.Blocks.Interfaces.RealInput vSetFreeCool
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-108,40},{-92,56}}), iconTransformation(extent=
            {{-108,40},{-92,56}})));
  Modelica.Blocks.Interfaces.RealInput tHotIn
    annotation (Placement(transformation(extent={{-180,-34},{-140,6}})));
  Modelica.Blocks.Interfaces.RealInput mHotIn "Prescribed mass flow rate"
    annotation (Placement(transformation(extent={{-180,-4},{-140,36}})));
  Modelica.Blocks.Interfaces.RealInput tColdIn
    annotation (Placement(transformation(extent={{164,40},{124,80}})));
  Modelica.Blocks.Interfaces.RealInput mColdIn "Prescribed mass flow rate"
    annotation (Placement(transformation(extent={{176,-14},{136,26}})));
  Modelica.Blocks.Interfaces.RealInput tAmb
    annotation (Placement(transformation(extent={{-180,-90},{-140,-50}})));
  BaseClasses.HeatPumpSystemBus bus
    annotation (Placement(transformation(extent={{18,72},{38,92}})));
equation
  connect(boundary5.ports[1], heatpumpSystem.port_a2) annotation (Line(points={
          {-90,-20},{-80,-20},{-80,-9.77778}}, color={0,127,255}));
  connect(boundary.ports[1], heatpumpSystem.port_b2) annotation (Line(points={{
          -90,20},{-80,20},{-80,5.33333}}, color={0,127,255}));
  connect(toKelvin.Kelvin, boundary5.T_in)
    annotation (Line(points={{-128,-34.6},{-116,-34.6},{-116,-16},{-112,-16}},
                                                       color={0,0,127}));
  connect(toKelvin1.Kelvin, boundary3.T_in) annotation (Line(points={{126,23.4},
          {126,16},{112,16}},          color={0,0,127}));
  connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
      Line(points={{-20,-70},{-20,-54},{0,-54},{0,-36.2222}}, color={191,0,0}));
  connect(boundary3.ports[1], heatpumpSystem.port_a1) annotation (Line(points={{90,20},
          {88,20},{88,5.33333},{80,5.33333}},        color={0,127,255}));
  connect(heatpumpSystem.port_b1, boundary2.ports[1]) annotation (Line(points={{80,
          -9.77778},{80,0.11111},{90,0.11111},{90,-22}},     color={0,127,255}));
  connect(toKelvin2.Kelvin, prescribedTemperature.T)
    annotation (Line(points={{-61.2,-70},{-42,-70}}, color={0,0,127}));
  connect(heatPumpSystemVolumeFlowControl.heatPumpSystemBus1, heatpumpSystem.heatPumpSystemBus)
    annotation (Line(
      points={{-4,82.1},{0,82.1},{0,28}},
      color={255,204,51},
      thickness=0.5));
  connect(heatPumpSystemVolumeFlowControl.pElHP, pElHP) annotation (Line(points=
         {{-24.8,97},{-90,97},{-90,105},{-101,105}}, color={0,0,127}));
  connect(heatPumpSystemVolumeFlowControl.vSetHS, vSetHS) annotation (Line(
        points={{-24.9,91},{-86,91},{-86,90},{-100,90}}, color={0,0,127}));
  connect(heatPumpSystemVolumeFlowControl.vSetCold, vSetCold) annotation (Line(
        points={{-24.9,79},{-38.45,79},{-38.45,61},{-101,61}}, color={0,0,127}));
  connect(heatPumpSystemVolumeFlowControl.vSetRecool, vSetRecool) annotation (
      Line(points={{-24.9,73},{-62,73},{-62,77},{-101,77}}, color={0,0,127}));
  connect(heatPumpSystemVolumeFlowControl.vSetFreeCool, vSetFreeCool)
    annotation (Line(points={{-24.9,67},{-24.9,48},{-100,48}}, color={0,0,127}));
  connect(const8.y, heatPumpSystemVolumeFlowControl.vSetCS) annotation (Line(
        points={{-45.6,84},{-36,84},{-36,85},{-24.8,85}}, color={0,0,127}));
  connect(toKelvin.Celsius, tHotIn) annotation (Line(points={{-128,-20.8},{-144,
          -20.8},{-144,-14},{-160,-14}}, color={0,0,127}));
  connect(boundary5.m_flow_in, mHotIn) annotation (Line(points={{-112,-12},{
          -138,-12},{-138,18},{-160,18},{-160,16}}, color={0,0,127}));
  connect(toKelvin1.Celsius, tColdIn)
    annotation (Line(points={{126,37.2},{126,60},{144,60}}, color={0,0,127}));
  connect(boundary3.m_flow_in, mColdIn) annotation (Line(points={{112,12},{128,
          12},{128,8},{156,8},{156,6}}, color={0,0,127}));
  connect(toKelvin2.Celsius, tAmb)
    annotation (Line(points={{-79.6,-70},{-160,-70}}, color={0,0,127}));
  connect(heatpumpSystem.heatPumpSystemBus, bus) annotation (Line(
      points={{0,28},{0,82},{28,82}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (experiment(StopTime=23400), __Dymola_Commands(file(
          ensureSimulated=true)=
        "Resources/Scripts/Dymola/Systems/EONERC_MainBuilding/Validation/Simulate_and_plot_HeatpumpSystemValidation.mos"
        "Simulate and plot"));
end HeatPumpSystemVolumeFlowControlled_Inputs;
