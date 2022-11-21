within AixLib.Fluid.Storage.Examples;
model StorageSolarCollector
  extends Modelica.Icons.Example;

  replaceable package Medium = AixLib.Media.Water;

  AixLib.Fluid.Storage.StorageDetailed bufferStorage(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    m1_flow_nominal=solarThermal.m_flow_nominal,
    m2_flow_nominal=solarThermal.m_flow_nominal,
    mHC1_flow_nominal=solarThermal.m_flow_nominal,
    useHeatingCoil2=false,
    useHeatingRod=false,
    TStart=333.15,
    redeclare AixLib.DataBase.Storage.Generic_New_2000l data(hHC1Up=2.1),
    n=10,
    hConIn=1500,
    hConOut=15,
    redeclare package Medium = Medium,
    hConHC1=1500)
		annotation (Placement(transformation(extent={{-10,14},{-30,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 283.15)
	annotation(Placement(transformation(extent={{-60,14},
            {-40,34}})));
  AixLib.Fluid.Sources.Boundary_pT boundary_p(redeclare package Medium = Medium,nPorts=1)
	annotation(Placement(transformation(extent={{86,74},
            {66,94}})));
  AixLib.Fluid.FixedResistances.PressureDrop
                   res1(
    redeclare package Medium = Medium,
    m_flow_nominal=solarThermal.m_flow_nominal,
    dp_nominal=2000)
	annotation(Placement(transformation(extent={{-6,-10},{14,10}})));
  AixLib.Fluid.Sources.Boundary_pT boundary_ph2(nPorts=1, redeclare package Medium = Medium)
	annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin={-76,52})));
  AixLib.Fluid.FixedResistances.PressureDrop
                   res(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=solarThermal.m_flow_nominal,
    dp_nominal=2000)
	annotation(Placement(transformation(extent={{-40,-26},{-20,-6}})));
  AixLib.Fluid.Solar.Thermal.SolarThermal solarThermal(
    vol(T(start=298.15, fixed=true)),
    Collector=AixLib.DataBase.SolarThermal.FlatCollector(),
    A=20,
    redeclare package Medium = Medium,
    m_flow_nominal=0.04,
    volPip=1)
    annotation (Placement(transformation(extent={{24,-10},{44,10}})));
  Modelica.Blocks.Sources.Pulse pulse(period = 3600,
    width=10,
    amplitude=0.05,
    offset=0)
	annotation(Placement(transformation(extent={{-96,-14},{-76,6}})));
  AixLib.Fluid.Actuators.Valves.TwoWayEqualPercentage valve(
    redeclare package Medium = Medium,
    m_flow_nominal=solarThermal.m_flow_nominal,
    dpValve_nominal=2000) annotation (Placement(transformation(
        extent={{-10,9},{10,-9}},
        rotation=90,
        origin={69,42})));
  AixLib.Fluid.Sensors.TemperatureTwoPort temperatureSensor(redeclare package Medium = Medium,
      m_flow_nominal=0.01)
	  annotation(Placement(transformation(extent={{48,-10},{68,10}})));
  Modelica.Blocks.Continuous.LimPID PI(controllerType = Modelica.Blocks.Types.SimpleController.PI,
    k=0.005,
    Ti=60,
	yMax = 0.999,
	yMin = 0) annotation(Placement(transformation(extent = {{-6, 6}, {6, -6}}, rotation = 90, origin={90,14})));
  Modelica.Blocks.Sources.Constant const(k = 273.15 + 70)
	annotation(Placement(transformation(extent={{74,-10},{80,-4}})));
  Modelica.Blocks.Math.Add add(k2 = -1)
	annotation(Placement(transformation(extent = {{-4, -4}, {4, 4}}, rotation = 90, origin={88,30})));
  Modelica.Blocks.Sources.Constant const1(k = 1)
	annotation(Placement(transformation(extent={{70,20},{78,28}})));
  Modelica.Blocks.Sources.CombiTimeTable hotSummerDay(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,21,0; 3600,20.6,0; 7200,20.5,0; 10800,20.4,0; 14400,20,6; 18000,20.5,
        106; 21600,22.4,251; 25200,24.1,402; 28800,26.3,540; 32400,28.4,657; 36000,
        30,739; 39600,31.5,777; 43200,31.5,778; 46800,32.5,737; 50400,32.5,657;
        54000,32.5,544; 57600,32.5,407; 61200,32.5,257; 64800,31.6,60; 68400,30.8,
        5; 72000,22.9,0; 75600,21.2,0; 79200,20.6,0; 82800,20.3,0],
    offset={273.15,0.01})
    annotation (Placement(transformation(extent={{10,32},{30,52}})));
  AixLib.Fluid.Movers.FlowControlled_dp pump(redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      m_flow_nominal=solarThermal.m_flow_nominal,
    per(pressure(V_flow={0,solarThermal.m_flow_nominal/1000,solarThermal.m_flow_nominal
            /(1000*0.8)}, dp={dpPumpInput.k/0.8,dpPumpInput.k,0})))
    annotation (Placement(transformation(extent={{6,60},{-14,80}})));
  Modelica.Blocks.Sources.Constant dpPumpInput(k=55000)
    annotation (Placement(transformation(extent={{32,80},{12,100}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=false,
    T=283.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,-26},{-48,-6}})));
equation
  connect(hotSummerDay.y[2], solarThermal.Irradiation) annotation(Line(points={{31,42},
          {31,10},{34,10}},color = {0, 0, 127}));
  connect(hotSummerDay.y[1], solarThermal.T_air) annotation(Line(points={{31,42},
          {31,22},{28,22},{28,10}},color = {0, 0, 127}));
  connect(solarThermal.port_b, temperatureSensor.port_a) annotation(Line(points={{44,0},{
          48,0}},color = {0, 127, 255}));
  connect(solarThermal.port_a,res1. port_b) annotation(Line(points={{24,0},{14,
          0}},color = {0, 127, 255}));
  connect(temperatureSensor.port_b, valve.port_a)
    annotation (Line(points={{68,0},{68,32},{69,32}}, color={0,127,255}));
  connect(const.y, PI.u_s) annotation(Line(points={{80.3,-7},{90,-7},{90,6.8}},color = {0, 0, 127}));
  connect(PI.y, add.u2) annotation(Line(points={{90,20.6},{90,25.2},{90.4,25.2}},color = {0, 0, 127}));
  connect(temperatureSensor.T, PI.u_m) annotation (Line(
      points={{58,11},{58,14},{82.8,14}},
      color={0,0,127}));
  connect(const1.y, add.u1) annotation (Line(points={{78.4,24},{85.6,24},{85.6,
          25.2}}, color={0,0,127}));
  connect(boundary_ph2.ports[1], bufferStorage.fluidportTop2) annotation (Line(
        points={{-66,52},{-50,52},{-50,50},{-23.125,50},{-23.125,34.1}}, color=
          {0,127,255}));
  connect(res.port_b, bufferStorage.fluidportBottom2) annotation (Line(points={{
          -20,-16},{-16,-16},{-16,0},{-22.875,0},{-22.875,13.9}}, color={0,127,255}));
  connect(fixedTemperature.port, bufferStorage.heatportOutside) annotation (
      Line(points={{-40,24},{-34,24},{-34,24.6},{-29.75,24.6}}, color={191,0,0}));
  connect(res1.port_a, bufferStorage.portHC1Out) annotation (Line(points={{-6,0},
          {-6,26.6},{-9.875,26.6}}, color={0,127,255}));
  connect(valve.port_b, pump.port_a) annotation (Line(points={{69,52},{68,52},{
          68,70},{6,70}}, color={0,127,255}));
  connect(dpPumpInput.y, pump.dp_in)
    annotation (Line(points={{11,90},{-4,90},{-4,82}}, color={0,0,127}));
  connect(pump.port_a, boundary_p.ports[1]) annotation (Line(points={{6,70},{36,
          70},{36,84},{66,84}}, color={0,127,255}));
  connect(add.y, valve.y)
    annotation (Line(points={{88,34.4},{88,42},{79.8,42}}, color={0,0,127}));
  connect(pump.port_b, bufferStorage.portHC1In) annotation (Line(points={{-14,
          70},{-16,70},{-16,46},{-6,46},{-6,29.7},{-9.75,29.7}}, color={0,127,
          255}));
  connect(boundary.ports[1], res.port_a)
    annotation (Line(points={{-48,-16},{-40,-16}}, color={0,127,255}));
  connect(pulse.y, boundary.m_flow_in) annotation (Line(points={{-75,-4},{-72,
          -4},{-72,-8},{-70,-8}}, color={0,0,127}));
  annotation (experiment(Tolerance=1e-6, StopTime = 172800, Interval = 60),
  __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Storage/Examples/StorageSolarCollector.mos" "Simulate and plot"),
  Documentation(info = "<html>
  <p>
  This is a simple example of a storage and a solar collector.
  </p>
  <ul>
  </html>",revisions="<html>
  <ul>
  <li>
   <i>November 17, 2022</i> by Laura Maier:<br/>
    Replace pump, polish example to make it more realistic, and add simulate and plot script.
   </li>
  <li>
    <i>October 11, 2016</i> by Marcus Fuchs:<br/>
    Replace pipe
  </li>
  <li>
    <i>April 2016&#160;</i> by Peter Remmen:<br/>
    Replace TempAndRad model
  </li>
  <li>
    <i>November 2014&#160;</i> by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class
  </li>
  <li>
    <i>13.12.2013</i> by Sebastian Stinner:<br/>
    implemented
  </li>
  </ul>
  </ul>
</html>"));
end StorageSolarCollector;
