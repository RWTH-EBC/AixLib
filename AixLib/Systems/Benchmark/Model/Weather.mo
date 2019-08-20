within AixLib.Systems.Benchmark.Model;
model Weather
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Components.Weather.Weather_Benchmark
                             weather(
    Wind_dir=true,
    Wind_speed=true,
    Air_temp=true,
    Rel_hum=false,
    Mass_frac=true,
    Air_press=false,
    Latitude=48.0304,
    Longitude=9.3138,
    SOD=DataBase.Weather.SurfaceOrientation.SurfaceOrientationData_N_E_S_W_Hor_PV(),
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Building/Benchmark/SimYear_Variante3_angepasst.mat"),
    tableName="SimYearVar")
    annotation (Placement(transformation(extent={{-50,14},{-20,34}})));
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
  Modelica.Blocks.Math.Gain gain1(k=0)
    annotation (Placement(transformation(extent={{52,-86},{64,-74}})));
  Fluid.Sources.Boundary_pT Air_in_bou(
    redeclare package Medium = Medium_Air,
    p=100000,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-52,-40})));
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
  BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
           {{-90,-120},{-50,-80}}), iconTransformation(extent={{-70,-110},{-50,
            -90}})));
  BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
           {{-52,-120},{-12,-80}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  BusSystems.InternalBus internalBus annotation (Placement(transformation(
          extent={{30,-132},{70,-92}}), iconTransformation(extent={{50,-112},{
            70,-92}})));
  Electrical.PVSystem.PVSystem pVSystem(
    NumberOfPanels=50*9,
    data=DataBase.SolarElectric.CanadianSolarCS6P250P(),
    MaxOutputPower=50*9*250)
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-18,64},{-6,76}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_East
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_South
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_West
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_Hor
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  Utilities.Interfaces.SolarRad_out SolarRadiation_North5
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
                         smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[-1,
        0.05,0; 0,0.05,0; 1,3.375,10125; 2,3.375,10125])
    annotation (Placement(transformation(extent={{-32,-78},{-12,-58}})));
  Modelica.Blocks.Interfaces.RealOutput RLT_Velocity
    "Connector of Real output signals"
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Math.Gain gain3(k=10090/(4*3600))
    annotation (Placement(transformation(extent={{-78,76},{-86,84}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=30, y_start=1)
    annotation (Placement(transformation(extent={{-16,-18},{-28,-6}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-54,-74},{-42,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression1
    annotation (Placement(transformation(extent={{-76,-84},{-64,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=1)
    annotation (Placement(transformation(extent={{-76,-68},{-64,-52}})));
equation
  connect(weather.WindDirection, gain.u)
    annotation (Line(points={{-19,33},{0,33},{0,41},{9,41}}, color={0,0,127}));
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
  connect(gain1.u, product1.u1) annotation (Line(points={{50.8,-80},{40,-80},{
          40,42.4},{67.2,42.4}}, color={0,0,127}));
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
  connect(Air_in, Air_in_bou.ports[1])
    annotation (Line(points={{-100,-60},{-92,-60},{-92,-40},{-62,-40}},
                                                    color={0,127,255}));
  connect(weather.WaterInAir, measureBus.WaterInAir) annotation (Line(points={{
          -19,21},{0,21},{0,-84},{-31.9,-84},{-31.9,-99.9}}, color={0,0,127}));
  connect(product.y, internalBus.InternalLoads_Wind_Speed_North) annotation (
      Line(points={{76.4,80},{86,80},{86,-111.9},{50.1,-111.9}},
                                                            color={0,0,127}));
  connect(product1.y, internalBus.InternalLoads_Wind_Speed_East) annotation (
      Line(points={{76.4,40},{86,40},{86,-111.9},{50.1,-111.9}},
                                                            color={0,0,127}));
  connect(product2.y, internalBus.InternalLoads_Wind_Speed_South) annotation (
      Line(points={{76.4,0},{86,0},{86,-112},{68,-112},{68,-111.9},{50.1,-111.9}},
                                                          color={0,0,127}));
  connect(product3.y, internalBus.InternalLoads_Wind_Speed_West) annotation (
      Line(points={{76.4,-40},{86,-40},{86,-111.9},{50.1,-111.9}},
                                                              color={0,0,127}));
  connect(gain1.y, internalBus.InternalLoads_Wind_Speed_Hor) annotation (Line(
        points={{64.6,-80},{86,-80},{86,-111.9},{50.1,-111.9}},
                                                           color={0,0,127}));
  connect(weather.AirTemp, boundary.T_in) annotation (Line(points={{-19,27},{0,
          27},{0,-16},{-42,-16}}, color={0,0,127}));
  connect(weather.AirTemp, measureBus.AirTemp) annotation (Line(points={{-19,27},
          {0,27},{0,-84},{-32,-84},{-32,-92},{-31.9,-92},{-31.9,-99.9}}, color=
          {0,0,127}));
  connect(weather.WindSpeed, product1.u1) annotation (Line(points={{-19,30},{40,
          30},{40,42.4},{67.2,42.4}}, color={0,0,127}));
  connect(pVSystem.PVPowerW, gain2.u)
    annotation (Line(points={{-29,70},{-19.2,70}}, color={0,0,127}));
  connect(gain2.y, measureBus.PV_Power) annotation (Line(points={{-5.4,70},{0,
          70},{0,42},{0,-84},{-32,-84},{-32,-92},{-31.9,-92},{-31.9,-99.9}},
        color={0,0,127}));
  connect(weather.SolarRadiation_OrientedSurfaces[2], SolarRadiation_East)
    annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,30},
          {110,30}}, color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[1], SolarRadiation_North5)
    annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,70},
          {110,70}}, color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[3], SolarRadiation_South)
    annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,
          -10},{110,-10}}, color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[4], SolarRadiation_West)
    annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,
          -50},{110,-50}}, color={255,128,0}));
  connect(weather.SolarRadiation_OrientedSurfaces[5], SolarRadiation_Hor)
    annotation (Line(points={{-42.8,13},{-42.8,0},{20,0},{20,14},{90,14},{90,
          -90},{110,-90}}, color={255,128,0}));
  connect(pVSystem.TOutside, boundary.T_in) annotation (Line(points={{-52,77.6},
          {-60,77.6},{-60,0},{0,0},{0,26},{0,26},{0,-16},{-42,-16}}, color={0,0,
          127}));
  connect(pVSystem.IcTotalRad, weather.SolarRadiation_OrientedSurfaces[6])
    annotation (Line(points={{-51.8,69.5},{-60,69.5},{-60,0},{-42.8,0},{-42.8,
          13}}, color={255,128,0}));
  connect(RLT_Velocity, gain3.y)
    annotation (Line(points={{-110,80},{-86.4,80}}, color={0,0,127}));
  connect(gain3.u, combiTable1Ds.y[1]) annotation (Line(points={{-77.2,80},{-60,
          80},{-60,0},{-8,0},{-8,-68},{-11,-68}}, color={0,0,127}));
  connect(combiTable1Ds.y[2], measureBus.Fan_RLT) annotation (Line(points={{-11,
          -68},{0,-68},{0,-84},{-31.9,-84},{-31.9,-99.9}}, color={0,0,127}));
  connect(boundary.m_flow_in, firstOrder.y)
    annotation (Line(points={{-42,-12},{-28.6,-12}}, color={0,0,127}));
  connect(firstOrder.u, combiTable1Ds.y[1]) annotation (Line(points={{-14.8,-12},
          {-8,-12},{-8,-68},{-11,-68}}, color={0,0,127}));
  connect(realExpression1.y, switch1.u3) annotation (Line(points={{-63.4,-76},{
          -60,-76},{-60,-72.8},{-55.2,-72.8}}, color={0,0,127}));
  connect(switch1.y, combiTable1Ds.u)
    annotation (Line(points={{-41.4,-68},{-34,-68}}, color={0,0,127}));
  connect(realExpression2.y, switch1.u1) annotation (Line(points={{-63.4,-60},{
          -58,-60},{-58,-63.2},{-55.2,-63.2}}, color={0,0,127}));
  connect(switch1.u2, controlBus.OnOff_RLT) annotation (Line(points={{-55.2,-68},
          {-88,-68},{-88,-99.9},{-69.9,-99.9}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Weather;
