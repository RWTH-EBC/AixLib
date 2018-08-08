within AixLib.Building.Benchmark;
model Weather
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Components.Weather.Weather weather(
    Wind_dir=true,
    Wind_speed=true,
    Air_temp=true,
    Rel_hum=false,
    SOD=DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor(),
    fileName=
        "D:/aku-bga/AixLib/AixLib/Resources/weatherdata/TRY2010_12_Jahr_Modelica-Library.txt",
    Mass_frac=true,
    Air_press=false)
    annotation (Placement(transformation(extent={{-50,14},{-20,34}})));
  Modelica.Blocks.Interfaces.RealOutput WindSpeed_East "in m/s"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput WindSpeed_South "in m/s"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput WindSpeed_West "in m/s"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Blocks.Interfaces.RealOutput WindSpeed_North "in m/s"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Blocks.Math.Gain gain(k=1/360)
    annotation (Placement(transformation(extent={{10,36},{20,46}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{68,76},{76,84}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{68,36},{76,44}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{68,-4},{76,4}})));
  Modelica.Blocks.Math.Product product3
    annotation (Placement(transformation(extent={{68,-44},{76,-36}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[0,1; 0.25,1; 0.26,0;
        0.74,0; 0.75,1; 1,1], smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{46,62},{56,72}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D1(table=[0,1; 0.25,1; 0.5,1;
        0.51,0; 0.99,0; 1,1])
    annotation (Placement(transformation(extent={{46,22},{56,32}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D2(table=[0,0; 0.24,0; 0.25,1;
        0.75,1; 0.76,0; 1,0])
    annotation (Placement(transformation(extent={{46,-18},{56,-8}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D3(table=[0,1; 0.01,0; 0.49,0;
        0.5,1; 1,1])
    annotation (Placement(transformation(extent={{46,-58},{56,-48}})));
  Modelica.Blocks.Interfaces.RealOutput WindSpeed_Hor "in m/s"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Blocks.Math.Gain gain1(k=0)
    annotation (Placement(transformation(extent={{52,-86},{64,-74}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_OrientedSurfaces1[size(
    weather.SolarRadiation_OrientedSurfaces, 1)]
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Fluid.Sources.Boundary_pT Air_in_bou(
    redeclare package Medium = Medium_Air,
    p=100000,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-52,-60})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Fluid.Sources.MassFlowSource_T boundary(
    use_m_flow_in=true,
    use_T_in=true,
    use_X_in=true,
    nPorts=1,
    redeclare package Medium = Medium_Air)
    annotation (Placement(transformation(extent={{-44,-30},{-64,-10}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-14,-30},{-34,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{22,-48},{10,-32}})));
  Modelica.Blocks.Interfaces.RealOutput Airtemp "in K" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-100})));
  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={{-90,
            -120},{-50,-80}}),      iconTransformation(extent={{-70,-110},{-50,
            -90}})));
  BusSystem.measureBus measureBus annotation (Placement(transformation(extent={
            {-52,-120},{-12,-80}}), iconTransformation(extent={{50,-110},{70,
            -90}})));
equation
  connect(weather.WindDirection, gain.u)
    annotation (Line(points={{-19,33},{0,33},{0,41},{9,41}}, color={0,0,127}));
  connect(weather.WindSpeed, product1.u1) annotation (Line(points={{-19,30},{40,
          30},{40,42.4},{67.2,42.4}}, color={0,0,127}));
  connect(product.u1, product1.u1) annotation (Line(points={{67.2,82.4},{40,
          82.4},{40,42.4},{67.2,42.4}}, color={0,0,127}));
  connect(product2.u1, product1.u1) annotation (Line(points={{67.2,2.4},{40,2.4},
          {40,42.4},{67.2,42.4}},        color={0,0,127}));
  connect(product3.u1, product1.u1) annotation (Line(points={{67.2,-37.6},{40,
          -37.6},{40,42.4},{67.2,42.4}}, color={0,0,127}));
  connect(gain.y, combiTable1D.u[1]) annotation (Line(points={{20.5,41},{32.25,
          41},{32.25,67},{45,67}}, color={0,0,127}));
  connect(combiTable1D.y[1], product.u2) annotation (Line(points={{56.5,67},{
          62.25,67},{62.25,77.6},{67.2,77.6}}, color={0,0,127}));
  connect(combiTable1D1.u[1], gain.y) annotation (Line(points={{45,27},{32,27},
          {32,41},{20.5,41}},color={0,0,127}));
  connect(combiTable1D2.u[1], gain.y) annotation (Line(points={{45,-13},{32,-13},
          {32,41},{20.5,41}}, color={0,0,127}));
  connect(combiTable1D3.u[1], gain.y) annotation (Line(points={{45,-53},{32,-53},
          {32,41},{20.5,41}}, color={0,0,127}));
  connect(combiTable1D1.y[1], product1.u2) annotation (Line(points={{56.5,27},{
          62,27},{62,37.6},{67.2,37.6}},color={0,0,127}));
  connect(combiTable1D2.y[1], product2.u2) annotation (Line(points={{56.5,-13},
          {62,-13},{62,-2.4},{67.2,-2.4}},   color={0,0,127}));
  connect(combiTable1D3.y[1], product3.u2) annotation (Line(points={{56.5,-53},
          {62,-53},{62,-42.4},{67.2,-42.4}}, color={0,0,127}));
  connect(product1.y, WindSpeed_East)
    annotation (Line(points={{76.4,40},{100,40}}, color={0,0,127}));
  connect(product2.y, WindSpeed_South)
    annotation (Line(points={{76.4,0},{100,0}},     color={0,0,127}));
  connect(product3.y, WindSpeed_West)
    annotation (Line(points={{76.4,-40},{100,-40}}, color={0,0,127}));
  connect(product.y, WindSpeed_North)
    annotation (Line(points={{76.4,80},{100,80}}, color={0,0,127}));
  connect(gain1.y, WindSpeed_Hor)
    annotation (Line(points={{64.6,-80},{100,-80}}, color={0,0,127}));
  connect(gain1.u, product1.u1) annotation (Line(points={{50.8,-80},{40,-80},{
          40,42.4},{67.2,42.4}}, color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces,
    SolarRadiation_OrientedSurfaces1) annotation (Line(points={{-42.8,13},{
          -42.8,0},{-80,0},{-80,0},{-80,70},{-90,70}}, color={255,128,0}));
  connect(boundary.X_in[1], weather.WaterInAir) annotation (Line(points={{-42,
          -24},{-24,-24},{-24,16},{-10,16},{-10,21},{-19,21}}, color={0,0,127}));
  connect(boundary.ports[1], Air_out)
    annotation (Line(points={{-64,-20},{-100,-20}}, color={0,127,255}));
  connect(feedback.u2, weather.WaterInAir) annotation (Line(points={{-24,-32},{
          -24,16},{-10,16},{-10,21},{-19,21}}, color={0,0,127}));
  connect(feedback.y, boundary.X_in[2]) annotation (Line(points={{-33,-40},{-36,
          -40},{-36,-24},{-42,-24}}, color={0,0,127}));
  connect(realExpression.y, feedback.u1)
    annotation (Line(points={{9.4,-40},{-16,-40}}, color={0,0,127}));
  connect(Airtemp, weather.AirTemp)
    annotation (Line(points={{0,-100},{0,27},{-19,27}}, color={0,0,127}));
  connect(boundary.T_in, weather.AirTemp) annotation (Line(points={{-42,-16},{0,
          -16},{0,27},{-19,27}}, color={0,0,127}));
  connect(boundary.m_flow_in, controlBus.Fan_RLT) annotation (Line(points={{-44,-12},
          {-6,-12},{-6,-80},{-69.9,-80},{-69.9,-99.9}},       color={0,0,127}));
  connect(Air_in, Air_in_bou.ports[1])
    annotation (Line(points={{-100,-60},{-62,-60}}, color={0,127,255}));
  connect(weather.AirTemp, measureBus.AirTemp) annotation (Line(points={{-19,27},
          {0,27},{0,-84},{-31.9,-84},{-31.9,-99.9}}, color={0,0,127}));
  connect(weather.WaterInAir, measureBus.WaterInAir) annotation (Line(points={{
          -19,21},{0,21},{0,-84},{-31.9,-84},{-31.9,-99.9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Weather;
