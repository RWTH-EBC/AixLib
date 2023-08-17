within AixLib.Fluid.Solar.Thermal.Examples;
model PhotovoltaicThermalCollector
  "Example to demonstrate the function of the photovoltaic thermal collector model"
  extends Modelica.Icons.Example;

  replaceable package Medium = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium model";

  Sources.Boundary_pT                source(
    nPorts=1,
    redeclare package Medium = Medium,
    p=system.p_ambient + pVT_Modul.pressureDropCoeff*(pVT_Modul.m_flow_nominal/
        995)^2 + pipe.dp_nominal)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Sources.Boundary_pT                sink(nPorts=1, redeclare package Medium =
        Medium,
    p=system.p_ambient)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  AixLib.Fluid.Sensors.MassFlowRate massFlowSensor(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-54,-10},{-34,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T1(redeclare package Medium = Medium,
      m_flow_nominal=system.m_flow_nominal)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe(
    redeclare package Medium = Medium,
    m_flow_nominal=system.m_flow_nominal,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T2(redeclare package Medium = Medium,
      m_flow_nominal=system.m_flow_nominal)
    annotation (Placement(transformation(extent={{28,-10},{48,10}})));
  Modelica.Blocks.Sources.CombiTimeTable hotSummerDay(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,21,0; 3600,20.6,0; 7200,20.5,0; 10800,20.4,0; 14400,20,6; 18000,20.5,
        106; 21600,22.4,251; 25200,24.1,402; 28800,26.3,540; 32400,28.4,657; 36000,
        30,739; 39600,31.5,777; 43200,31.5,778; 46800,32.5,737; 50400,32.5,657;
        54000,32.5,544; 57600,32.5,407; 61200,32.5,257; 64800,31.6,60; 68400,30.8,
        5; 72000,22.9,0; 75600,21.2,0; 79200,20.6,0; 82800,20.3,0],
    offset={273.15,0.01})
    annotation (Placement(transformation(extent={{-26,62},{-6,82}})));
  inner Modelica.Fluid.System system(
    T_ambient=298.15,
    m_flow_start=system.m_flow_nominal,
    use_eps_Re=true,
    m_flow_nominal=1.5*pVT_Modul.A/60*995/1000,
    p_ambient=300000)
              annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  AixLib.Fluid.Solar.Thermal.PhotovoltaicThermal pVT_Modul(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=system.m_flow_nominal,
    A=2,
    volPip=0.05,
    Collector=AixLib.DataBase.SolarThermal.AirCollector(),
    pVT_SolarThermalEfficiency(Collector=
          AixLib.DataBase.PhotovoltaicThermal.ThermalGlazedPVTWithLowEmissionCoating()))
    annotation (Placement(transformation(extent={{-4,-10},{20,12}})));
equation
  connect(massFlowSensor.port_b, T1.port_a)
    annotation (Line(points={{-34,0},{-28,0}}, color={0,127,255}));
  connect(T2.port_b, pipe.port_a)
    annotation (Line(points={{48,0},{54,0}}, color={0,127,255}));
  connect(source.ports[1], massFlowSensor.port_a)
    annotation (Line(points={{-60,0},{-54,0}}, color={0,127,255}));
  connect(pipe.port_b, sink.ports[1])
    annotation (Line(points={{74,0},{80,0}}, color={0,127,255}));
  connect(T1.port_b, pVT_Modul.port_a)
    annotation (Line(points={{-8,0},{-6,0},{-6,1},{-4,1}},
                                            color={0,127,255}));
  connect(T2.port_a, pVT_Modul.port_b)
    annotation (Line(points={{28,0},{24,0},{24,1},{20,1}},
                                             color={0,127,255}));
  connect(hotSummerDay.y[1], pVT_Modul.T_air)
    annotation (Line(points={{-5,72},{0.8,72},{0.8,12}},
                                                     color={0,0,127}));
  connect(hotSummerDay.y[2], pVT_Modul.Irradiation)
    annotation (Line(points={{-5,72},{8,72},{8,12}},   color={0,0,127}));
  annotation (
    experiment(StopTime=82600, Interval=3600),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>This test demonstrates the photovoltaic thermal collector model. Different types of collectors can be tested at fixed boundary conditions. </p>
</html>"),
    __Dymola_Commands(file(ensureSimulated=true)=
        "Resources/Scripts/Dymola/Fluid/Solar/Thermal/Examples/SolarThermalCollector.mos"));
end PhotovoltaicThermalCollector;
