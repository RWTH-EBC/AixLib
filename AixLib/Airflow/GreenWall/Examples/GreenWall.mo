within AixLib.Airflow.GreenWall.Examples;
model GreenWall
  extends Modelica.Icons.Example;
  import SI = Modelica.SIunits;
  package Medium = Modelica.Media.Air.MoistAir(extraPropertiesNames = {"CO2", "VOC", "PM2.5", "PM10"}, C_nominal = {C_nomCO2, C_nomVOC, C_nomPM25, C_nomPM10});
  constant SI.Density rho_Air = 1.29 "Density of air";
  constant SI.Density rho_CO2 = 1.977 "Density of CO2";
  constant SI.MolarMass M_Air = 29 "Molar mass of air";
  constant SI.MolarMass M_CO2 = 44 "Molar mass of CO2";
  constant Real C_nomCO2 = 450 * 10 ^ (-6) * M_CO2 / M_Air "Nominal Concentration of CO2";
  //constant Real C_nomVOC = 200*10^(-9) "Nominal Concentration of VOC";
  constant Real C_nomVOC = 190 * 10 ^ (-9) "Nominal Concentration of VOC";
  constant Real C_nomPM25 = 1 * 10 ^ (-15) "Nominal Concentration of PM2.5";
  constant Real C_nomPM10 = 1 * 10 ^ (-15) "Nominal Concentration of PM10";
  parameter Real C_volVOC = 50 * 10 ^ (-9) "VOC concentration set according to use of Naava";
  parameter Real X_vol = 0.008 "Indoor water content set according to use of Naava";
  parameter Real X_winter = 0.008 "Outdoor water content";
  parameter Real T_volstart = 17.5+273.15 "Temperature start value in the Volume";
  parameter Real C_CO2 = 20000E-6 * M_CO2 / M_Air "Released CO2";
  parameter Real C_VOC = 2200E-9 "Released VOC";
  parameter Real C_PM10 = 5750E-9 "Release of the source of PM10 partcles";
  parameter Real C_PM25 = 400E-9 "Release of the source of PM2.5 partcles";
  parameter Real X_hum = 0.025 "Released Water";

  inner Modelica.Fluid.System system(energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) annotation (
    Placement(transformation(extent={{80,-100},{100,-80}})));
    Modelica.Fluid.Vessels.ClosedVolume volume(
    use_HeatTransfer=false,
    V=56,                                            redeclare package Medium=Medium,
    massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, use_T_start=true, T_start = T_volstart, C_start = {C_nomCO2, C_volVOC, C_nomPM25, C_nomPM10}, X_start = {X_vol, 1 - X_vol}, use_portsData = false,
    nPorts=7)                                                                                                                                                                                                         annotation (
    Placement(transformation(extent={{-10,-60},{10,-40}})));
Modelica.Fluid.Sources.MassFlowSource_T boundary(
    use_X_in=false,                              use_C_in = true, redeclare
      package Medium =                                                                         Medium,             use_m_flow_in = false, m_flow = 1.3 * 10 ^ (-4) * rho_CO2,
    X={X_vol,1 - X_vol},
    nPorts=1)                                                                                                                                                                                               annotation (
    Placement(transformation(extent={{-52,-70},{-32,-50}})));
  AixLib.Airflow.GreenWall.GreenWall naava1_1(
    c_VOC=0.05,
    C_offVOC=-110E-9,
    C_minCO2=400*10^(-6)*M_CO2/M_Air,
    c_CO2=0.06,
    C_minVOC=1E-15,
    phi_max=0.82,
    c_W=0.42)
    annotation (Placement(transformation(extent={{-12,-6},{8,14}})));
  Modelica.Fluid.Sensors.MassFractions massFraction(redeclare package Medium = Medium) annotation (
    Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = Medium) annotation (
    Placement(transformation(extent={{40,74},{60,94}})));
  AixLib.Utilities.Psychrometrics.Phi_pTX phi annotation (
    Placement(transformation(extent={{80,50},{100,70}})));
  Modelica.Fluid.Sensors.Pressure pressure(redeclare package Medium = Medium) annotation (
    Placement(transformation(extent={{40,26},{60,46}})));
  Modelica.Blocks.Sources.Constant sourceCO2(k=C_CO2)   annotation (
    Placement(transformation(extent={{-96,-26},{-76,-6}})));
  Modelica.Blocks.Sources.Constant sourceVOC(k=C_VOC)   annotation (
    Placement(transformation(extent={{-96,8},{-76,28}})));
  Modelica.Blocks.Sources.Constant sourcePM2_5(k=C_PM25)      annotation (
    Placement(transformation(extent={{-96,42},{-76,62}})));
  Modelica.Blocks.Sources.Constant sourcePM10(k=C_PM10)      annotation (
    Placement(transformation(extent={{-96,74},{-76,94}})));
  Modelica.Blocks.Math.Product product annotation (
    Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-60,-24})));
  Modelica.Blocks.Math.Product product2 annotation (
    Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-60,10})));
  Modelica.Blocks.Sources.Step releaseTime(
    height=-1,
    offset=1,
    startTime=7200)                                                                   annotation (
    Placement(transformation(extent={{-18,74},{-38,94}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(redeclare package Medium =
        Medium, nPorts=1)                                                                     annotation (
    Placement(transformation(extent={{62,-70},{42,-50}})));
  Modelica.Blocks.Math.Product product3 annotation (
    Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-60,44})));
  Modelica.Blocks.Math.Product product4 annotation (
    Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-60,76})));
equation
  connect(pressure.p, phi.p) annotation (
    Line(points={{61,36},{72,36},{72,52},{79,52}},          color = {0, 0, 127}));
  connect(temperature.T, phi.T) annotation (
    Line(points={{57,84},{68,84},{68,68},{79,68}},
                                        color = {0, 0, 127}));
  connect(massFraction.Xi, phi.X_w) annotation (
    Line(points={{61,60},{79,60}},                          color = {0, 0, 127}));
  connect(product2.y, boundary.C_in[2]) annotation (Line(points={{-60,3.4},{-60,
          -68},{-52,-68}},            color={0,0,127}));
  connect(product.y, boundary.C_in[1]) annotation (Line(points={{-60,-30.6},{
          -60,-68},{-52,-68}},        color={0,0,127}));
  connect(product4.y, boundary.C_in[4]) annotation (Line(points={{-60,69.4},{
          -60,-68},{-52,-68}},        color={0,0,127}));
  connect(product3.y, boundary.C_in[3]) annotation (Line(points={{-60,37.4},{
          -60,-68},{-52,-68}},        color={0,0,127}));
  connect(massFraction.port, volume.ports[1]) annotation (Line(points={{50,50},
          {28,50},{28,-60},{-3.42857,-60}},
                                       color={0,127,255}));
  connect(temperature.port, volume.ports[2]) annotation (Line(points={{50,74},{
          28,74},{28,-60},{-2.28571,-60}},
                                    color={0,127,255}));
  connect(pressure.port, volume.ports[3]) annotation (Line(points={{50,26},{28,
          26},{28,-60},{-1.14286,-60}},
                                color={0,127,255}));
  connect(boundary1.ports[1], volume.ports[4]) annotation (Line(points={{42,-60},
          {0,-60}},                     color={0,127,255}));
  connect(naava1_1.port_b, volume.ports[5]) annotation (Line(points={{8,4},{16,
          4},{16,-60},{1.14286,-60}},
                                   color={0,127,255}));
  connect(naava1_1.port_a, volume.ports[6]) annotation (Line(points={{-12.2,4},
          {-20,4},{-20,-60},{2.28571,-60}},
                                        color={0,127,255}));
  connect(boundary.ports[1], volume.ports[7]) annotation (Line(points={{-32,-60},
          {3.42857,-60}},                 color={0,127,255}));
  connect(sourceCO2.y, product.u2) annotation (Line(points={{-75,-16},{-70,-16},
          {-70,-16.8},{-63.6,-16.8}}, color={0,0,127}));
  connect(sourceVOC.y, product2.u2) annotation (Line(points={{-75,18},{-70,18},
          {-70,17.2},{-63.6,17.2}}, color={0,0,127}));
  connect(sourcePM2_5.y, product3.u2) annotation (Line(points={{-75,52},{-70,52},
          {-70,51.2},{-63.6,51.2}}, color={0,0,127}));
  connect(sourcePM10.y, product4.u2) annotation (Line(points={{-75,84},{-70,84},
          {-70,83.2},{-63.6,83.2}}, color={0,0,127}));
  connect(releaseTime.y, product4.u1) annotation (Line(points={{-39,84},{-48,84},
          {-48,83.2},{-56.4,83.2}}, color={0,0,127}));
  connect(releaseTime.y, product3.u1) annotation (Line(points={{-39,84},{-48,84},
          {-48,51.2},{-56.4,51.2}}, color={0,0,127}));
  connect(releaseTime.y, product2.u1) annotation (Line(points={{-39,84},{-48,84},
          {-48,17.2},{-56.4,17.2}}, color={0,0,127}));
  connect(releaseTime.y, product.u1) annotation (Line(points={{-39,84},{-48,84},
          {-48,-16.8},{-56.4,-16.8}}, color={0,0,127}));
  annotation (
    Placement(transformation(extent = {{60, 60}, {80, 80}})),
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    experiment(StopTime = 64800),
    Documentation(info="<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>Simulation to check the behaviour of the Green Wall. </p>
<p>The Model includes a volume representing a room, </p>
<p>sources releasing volatile organic compounds (VOC), CO<sub>2</sub> and particulate matter in two sizes (PM2.5 and PM10) </p>
<p>and the plant wall model of type Naava One (N). The plant wall is parameterised according to Bardey et al. [1] </p>
<h4>
  <span style=\"color:#008000\">Output</span>
</h4>
<p>The interaction with the indoor air quality parameters (VOC,CO<sub>2</sub>,PM2.5 and PM10, relative humidity (RH) and temperature(T)) is represented by the variables: </p>
<p>CO<sub>2</sub>: volume.C[1]</p>
<p>VOC: volume.C[2]</p>
<p>PM2.5: volume.C[3] </p>
<p>PM10: volume.C[4]</p>
<p>RH: phi.phi</p>
<p>T: phi.T</p>
<h4>
<span style=\"color:#008000\">References</span>
</h4>
<p>[1] Bardey, J. (2020): Measurement and analysis of the influence of plant wall systems on indoor climate control (master thesis). RWTH Aachen University, Aachen. E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate; supervised by: Baranski, M.; M&uuml;ller, D.</p>
</html>
"));
end GreenWall;
