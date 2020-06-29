within AixLib.Systems.Benchmark.Model.Generation;
model Generation_v2
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

    parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 0 annotation(Dialog(tab = "General"));
    parameter Integer pipe_nodes= 2 annotation(Dialog(tab = "General"));

    // Hotwater
    parameter Real m_flow_nominal_hotwater = 0 annotation(Dialog(tab = "hotwater"));
    parameter Modelica.SIunits.Length pipe_length_hotwater = 0 annotation(Dialog(tab = "hotwater"));
    parameter Modelica.SIunits.Length pipe_diameter_hotwater = 0 annotation(Dialog(tab = "hotwater"));

    //Warmwater
    parameter Real m_flow_nominal_warmwater = 0 annotation(Dialog(tab = "warmwater"));
    parameter Modelica.SIunits.Length pipe_length_warmwater = 0 annotation(Dialog(tab = "warmwater"));
    parameter Modelica.SIunits.Length pipe_diameter_warmwater = 0 annotation(Dialog(tab = "warmwater"));

    //ColdWater
    parameter Real m_flow_nominal_coldwater = 0 annotation(Dialog(tab = "coldwater"));
    parameter Modelica.SIunits.Length pipe_length_coldwater = 0 annotation(Dialog(tab = "coldwater"));
    parameter Modelica.SIunits.Length pipe_diameter_coldwater = 0 annotation(Dialog(tab = "coldwater"));

    //Generation Hot
    parameter Real m_flow_nominal_generation_hot = 0 annotation(Dialog(tab = "generation_hot"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_generation_hot = 0 annotation(Dialog(tab = "generation_hot"));

    //Heatpump
    parameter Modelica.SIunits.Temp_K T_conMax_1 = 328.15 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.Temp_K T_conMax_2 = 328.15 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.Volume vol_1 = 0.012 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.Volume vol_2 = 0.024 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.ThermalConductance R_loss_1 = 0 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.ThermalConductance R_loss_2 = 0 annotation(Dialog(tab = "Heatpump"));

    //Generation Warm
    parameter Real m_flow_nominal_generation_warmwater = 0 annotation(Dialog(tab = "generation_warmwater"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_warmwater = 0 annotation(Dialog(tab = "generation_warmwater"));

    //Generation Cold
    parameter Real m_flow_nominal_generation_coldwater = 0 annotation(Dialog(tab = "generation_coldwater"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_coldwater = 0 annotation(Dialog(tab = "generation_coldwater"));

    //Generation Aircooler
    parameter Real m_flow_nominal_generation_aircooler = 0 annotation(Dialog(tab = "generation_aircooler"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_generation_aircooler = 0 annotation(Dialog(tab = "generation_aircooler"));
    parameter Real m_flow_nominal_generation_air_small_max annotation(Dialog(tab = "generation_aircooler"));
    parameter Real m_flow_nominal_generation_air_small_min annotation(Dialog(tab = "generation_aircooler"));
    parameter Real m_flow_nominal_generation_air_big_max annotation(Dialog(tab = "generation_aircooler"));
    parameter Real m_flow_nominal_generation_air_big_min annotation(Dialog(tab = "generation_aircooler"));
    parameter Modelica.SIunits.Area Area_Heatexchanger_Air = 0 annotation(Dialog(tab = "generation_aircooler"));
    parameter Modelica.SIunits.ThermalConductance Thermal_Conductance_Cold = 0 annotation(Dialog(tab = "generation_aircooler"));
    parameter Modelica.SIunits.ThermalConductance Thermal_Conductance_Warm = 0 annotation(Dialog(tab = "generation_aircooler"));

    //Geothermal Probe
    parameter Modelica.SIunits.Length Probe_depth = 0 annotation(Dialog(tab = "Geothermal Probe"));
    parameter Real n_probes = 1 "Number of Probes" annotation(Dialog(tab = "Geothermal Probe"));
    parameter Modelica.SIunits.Temp_K Earthtemperature_start = 283.15 annotation(Dialog(tab = "Geothermal Probe"));

    //Storage
    parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC1_warm = 0 annotation(Dialog(tab = "Storage"));
    parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC2_warm = 0 annotation(Dialog(tab = "Storage"));
    parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC1_cold = 0 annotation(Dialog(tab = "Storage"));

  AixLib.Systems.Benchmark.HighTemperatureSystem generation_Hot(
    m_flow_nominal_generation_hot=m_flow_nominal_generation_hot,
    redeclare package Medium_Water = Medium_Water,
    dpValve_nominal_generation_hot=dpValve_nominal_generation_hot)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Fluid.Storage.BufferStorage HotWater(
    useHeatingRod=false,
    n=5,
    useHeatingCoil2=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package Medium = Medium_Water,
    redeclare package MediumHC1 = Medium_Water,
    redeclare package MediumHC2 = Medium_Water,
    data=DataBase.Storage.Generic_22000l(),
    TStart=343.15)
    annotation (Placement(transformation(extent={{18,44},{48,82}})));
  Generation_heatPump generation_heatPump1(
    redeclare package Medium_Water = Medium_Water,
    dpHeatexchanger_nominal=dpHeatexchanger_nominal,
    T_conMax_1=T_conMax_1,
    T_conMax_2=T_conMax_2,
    vol_1=vol_1,
    vol_2=vol_2,
    R_loss_1=R_loss_1,
    R_loss_2=R_loss_2)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Fluid.Storage.BufferStorage ColdWater(
    useHeatingRod=false,
    n=5,
    upToDownHC1=false,
    useHeatingCoil1=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package Medium = Medium_Water,
    redeclare package MediumHC1 = Medium_Water,
    redeclare package MediumHC2 = Medium_Water,
    useHeatingCoil2=true,
    upToDownHC2=false,
    TStart=283.15,
    data=DataBase.Storage.Generic_46000l())
    annotation (Placement(transformation(extent={{18,-88},{48,-50}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve4(
    y_start=0,
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_warmwater,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_warmwater,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-20,8},{-36,24}})));
  GeothermalProbe generation_geothermalProbe(
    Probe_depth=Probe_depth,
    n_probes=n_probes,
    Earthtemperature_start=Earthtemperature_start,
    redeclare package Medium_Water = Medium_Water) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-50,-90})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve3(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_coldwater,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_coldwater,
    use_inputFilter=false)                   annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-85,-9})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve1(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_coldwater,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_coldwater,
    use_inputFilter=false)
                        annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-85,-67})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve2(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_coldwater,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_coldwater,
    use_inputFilter=false)
                        annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-85,-45})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-50,-56})));
  Fluid.Storage.BufferStorage WarmWater(
    useHeatingRod=false,
    n=5,
    useHeatingCoil2=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package Medium = Medium_Water,
    redeclare package MediumHC1 = Medium_Water,
    redeclare package MediumHC2 = Medium_Water,
    TStart=308.15,
    data=DataBase.Storage.Generic_22000l())
    annotation (Placement(transformation(extent={{16,-18},{46,20}})));
  Fluid.Sources.Boundary_pT bou4(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={30,102})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve7(
    y_start=0,
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_hot,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_generation_hot,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-6,66},{-22,82}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve5(
    y_start=0,
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_warmwater,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_warmwater,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{2,8},{-14,24}})));
  Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium = Medium_Water,
      redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per,
    y_start=0)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=180,
        origin={60,94})));
  Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium = Medium_Water,
    y_start=0,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=180,
        origin={56,28})));
  Fluid.Movers.SpeedControlled_y fan3(redeclare package Medium = Medium_Water,
    y_start=0,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12 per)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=180,
        origin={56,-96})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      redeclare Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per,
    y_start=1)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-68,-60})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = Medium_Water,
    nNodes=pipe_nodes,
    length=pipe_length_hotwater,
    diameter=pipe_diameter_hotwater,
    height_ab=0)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={84,94})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium = Medium_Water,
    nNodes=pipe_nodes,
    length=pipe_length_warmwater,
    diameter=pipe_diameter_warmwater,
    height_ab=0)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={78,28})));
  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium = Medium_Water,
    nNodes=pipe_nodes,
    length=pipe_length_coldwater,
    diameter=pipe_diameter_coldwater,
    height_ab=0)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,-94})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={36,34})));
  Fluid.Sources.Boundary_pT bou3(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={12,-92})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
           {{-16,80},{24,120}}), iconTransformation(extent={{30,90},{50,110}})));
  BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
           {{-70,70},{-30,110}}), iconTransformation(extent={{-50,90},{-30,110}})));
  Generation_Aircooling_v2 generation_Aircooling_v2_1(
    m_flow_nominal_generation_warmwater=m_flow_nominal_generation_warmwater,
    m_flow_nominal_generation_coldwater=m_flow_nominal_generation_coldwater,
    m_flow_nominal_generation_aircooler=m_flow_nominal_generation_aircooler,
    redeclare package Medium_Water = Medium_Water,
    dpValve_nominal_generation_aircooler=dpValve_nominal_generation_aircooler,
    dpHeatexchanger_nominal=dpHeatexchanger_nominal,Area_Heatexchanger_Air=
        Area_Heatexchanger_Air,
    Thermal_Conductance_Cold=Thermal_Conductance_Cold,
    Thermal_Conductance_Warm=Thermal_Conductance_Warm,
    m_flow_nominal_generation_air_big_max=m_flow_nominal_generation_air_big_max,
    m_flow_nominal_generation_air_big_min=m_flow_nominal_generation_air_big_min,
    m_flow_nominal_generation_air_small_max=
        m_flow_nominal_generation_air_small_max,
    m_flow_nominal_generation_air_small_min=
        m_flow_nominal_generation_air_small_min)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{72,58},{60,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{72,-4},{60,8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature2
    annotation (Placement(transformation(extent={{72,-74},{60,-62}})));
equation
  connect(generation_Hot.Fluid_in_Hot,HotWater. portHC1Out) annotation (Line(
        points={{-60.4,66.2},{-32,66.2},{-32,67.94},{17.8125,67.94}},
                                                               color={0,127,255}));
  connect(HotWater.fluidportBottom2,Fluid_in_hot)  annotation (Line(points={{37.3125,
          43.81},{37.3125,40},{100,40}},       color={0,127,255}));
  connect(HotWater.portHC2Out,generation_heatPump1. Fluid_in_warm) annotation (
      Line(points={{17.8125,52.17},{12,52.17},{12,4},{-40,4}},          color={
          0,127,255}));
  connect(generation_heatPump1.Fluid_out_warm,Valve4. port_2)
    annotation (Line(points={{-40,16},{-36,16}}, color={0,127,255}));
  connect(generation_heatPump1.Fluid_out_cold,Valve3. port_1)
    annotation (Line(points={{-60,4},{-85,4},{-85,-2}}, color={0,127,255}));
  connect(Valve3.port_2,Valve2. port_2) annotation (Line(points={{-85,-16},{-85,
          -16},{-85,-38}}, color={0,127,255}));
  connect(Valve2.port_1,Valve1. port_2) annotation (Line(points={{-85,-52},{-85,
          -52},{-85,-60}}, color={0,127,255}));
  connect(Valve2.port_3,ColdWater. portHC1In) annotation (Line(points={{-78,-45},
          {12,-45},{12,-46},{12,-46},{12,-58},{12,-58},{12,-58},{12,-58.17},{14,
          -58.17},{17.625,-58.17}},                                color={0,127,
          255}));
  connect(ColdWater.portHC1Out,Valve1. port_2) annotation (Line(points={{
          17.8125,-64.06},{-16,-64.06},{-16,-104},{-104,-104},{-104,-58},{-85,
          -58},{-85,-60}}, color={0,127,255}));
  connect(Fluid_in_cold,ColdWater. fluidportTop1) annotation (Line(points={{100,-40},
          {28,-40},{28,-46},{27.75,-46},{27.75,-49.81}},      color={0,127,255}));
  connect(WarmWater.fluidportBottom2,Fluid_in_warm)  annotation (Line(points={{
          35.3125,-18.19},{35.3125,-20},{100,-20}}, color={0,127,255}));
  connect(generation_Hot.Fluid_out_Hot,Valve7. port_2) annotation (Line(points=
          {{-60,73.8},{-42,73.8},{-42,74},{-22,74}}, color={0,127,255}));
  connect(Valve7.port_1,HotWater. portHC1In) annotation (Line(points={{-6,74},{
          6,74},{6,73.83},{17.625,73.83}}, color={0,127,255}));
  connect(Valve7.port_3,WarmWater. portHC1In) annotation (Line(points={{-14,66},
          {-14,30},{12,30},{12,11.83},{15.625,11.83}}, color={0,127,255}));
  connect(WarmWater.portHC1Out,HotWater. portHC1Out) annotation (Line(points={{15.8125,
          5.94},{12,5.94},{12,67.94},{17.8125,67.94}},      color={0,127,255}));
  connect(Valve4.port_1,Valve5. port_2)
    annotation (Line(points={{-20,16},{-14,16}}, color={0,127,255}));
  connect(Valve5.port_1,HotWater. portHC2In) annotation (Line(points={{2,16},{2,
          58.25},{17.8125,58.25}}, color={0,127,255}));
  connect(Valve5.port_3,WarmWater. portHC2In) annotation (Line(points={{-6,8},{
          -6,-3.75},{15.8125,-3.75}}, color={0,127,255}));
  connect(WarmWater.portHC2Out,generation_heatPump1. Fluid_in_warm) annotation (
     Line(points={{15.8125,-9.83},{-6,-9.83},{-6,4},{-40,4}}, color={0,127,255}));
  connect(Valve7.y,controlBus. Valve7) annotation (Line(points={{-14,83.6},{-14,
          88},{4.1,88},{4.1,100.1}}, color={0,0,127}));
  connect(Valve5.y,controlBus. Valve5) annotation (Line(points={{-6,25.6},{-6,
          34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(Valve4.y,controlBus. Valve4) annotation (Line(points={{-28,25.6},{-28,
          34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(Valve3.y,controlBus. Valve3) annotation (Line(points={{-93.4,-9},{-98,
          -9},{-98,34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(Valve2.y,controlBus. Valve2) annotation (Line(points={{-93.4,-45},{
          -98,-45},{-98,34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(Valve1.y,controlBus. Valve1) annotation (Line(points={{-93.4,-67},{
          -98,-67},{-98,34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(generation_heatPump1.controlBus,controlBus)  annotation (Line(
      points={{-54,20},{-54,34},{4,34},{4,100}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_Hot.controlBus,controlBus)  annotation (Line(
      points={{-74,80},{-74,88},{4,88},{4,100}},
      color={255,204,51},
      thickness=0.5));
  connect(Valve1.port_3,generation_geothermalProbe. Fluid_in_Geothermal)
    annotation (Line(points={{-78,-67},{-74,-67},{-74,-80},{-56,-80}}, color={0,
          127,255}));
  connect(Fluid_out_hot,Fluid_out_hot)  annotation (Line(points={{100,80},{94,80},
          {94,80},{100,80}}, color={0,127,255}));
  connect(fan2.y,controlBus. Pump_Hotwater_y) annotation (Line(points={{60,103.6},
          {60,108},{20,108},{20,100},{12,100},{12,100.1},{4.1,100.1}}, color={0,
          0,127}));
  connect(fan3.port_a,ColdWater. fluidportBottom1) annotation (Line(points={{48,
          -96},{28,-96},{28,-94},{27.9375,-94},{27.9375,-88.38}}, color={0,127,255}));
  connect(WarmWater.fluidportTop2,fan1. port_a) annotation (Line(points={{35.6875,
          20.19},{35.6875,28},{48,28}}, color={0,127,255}));
  connect(fan3.y,controlBus. Pump_Coldwater_y) annotation (Line(points={{56,-105.6},
          {56,-110},{4.1,-110},{4.1,100.1}}, color={0,0,127}));
  connect(fan1.y,controlBus. Pump_Warmwater_y) annotation (Line(points={{56,37.6},
          {56,40},{4.1,40},{4.1,100.1}}, color={0,0,127}));
  connect(fan4.port_a,generation_geothermalProbe. Fulid_out_Geothermal)
    annotation (Line(points={{-68,-68},{-68,-70},{-44,-70},{-44,-80}}, color={0,
          127,255}));
  connect(Valve1.port_1,generation_geothermalProbe. Fulid_out_Geothermal)
    annotation (Line(points={{-85,-74},{-84,-74},{-84,-76},{-68,-76},{-68,-70},{
          -44,-70},{-44,-80}}, color={0,127,255}));
  connect(bou1.ports[1],generation_geothermalProbe. Fulid_out_Geothermal)
    annotation (Line(points={{-50,-60},{-50,-70},{-44,-70},{-44,-80}}, color={0,
          127,255}));
  connect(fan4.y,controlBus. Pump_Coldwater_heatpump_y) annotation (Line(points={{-77.6,
          -60},{-98,-60},{-98,88},{4.1,88},{4.1,100.1}},        color={0,0,127}));
  connect(ColdWater.TTop,measureBus. ColdWater_TTop) annotation (Line(points={{18,
          -52.28},{12,-52.28},{12,-52},{4,-52},{4,88},{-49.9,88},{-49.9,90.1}},
        color={0,0,127}));
  connect(WarmWater.TBottom,measureBus. WarmWater_TBottom) annotation (Line(
        points={{16,-14.2},{10,-14.2},{4,-14.2},{4,-14},{4,88},{-49.9,88},{-49.9,90.1}},
                   color={0,0,127}));
  connect(WarmWater.TTop,measureBus. WarmWater_TTop) annotation (Line(points={{16,
          17.72},{10,17.72},{10,18},{4,18},{4,88},{-49.9,88},{-49.9,90.1}},
        color={0,0,127}));
  connect(HotWater.TBottom,measureBus. HotWater_TBottom) annotation (Line(
        points={{18,47.8},{4,47.8},{4,88},{-49.9,88},{-49.9,90.1}},  color={0,0,
          127}));
  connect(HotWater.TTop,measureBus. HotWater_TTop) annotation (Line(points={{18,79.72},
          {12,79.72},{12,80},{4,80},{4,88},{-49.9,88},{-49.9,90.1}},
        color={0,0,127}));
  connect(fan2.P,measureBus. Pump_Hotwater_power) annotation (Line(points={{68.8,101.2},
          {70,101.2},{70,88},{-49.9,88},{-49.9,90.1}},         color={0,0,127}));
  connect(fan1.P,measureBus. Pump_Warmwater_power) annotation (Line(points={{64.8,
          35.2},{60,35.2},{60,40},{4,40},{4,90},{-49.9,90},{-49.9,90.1}},
        color={0,0,127}));
  connect(fan3.P,measureBus. Pump_Coldwater_power) annotation (Line(points={{64.8,
          -103.2},{70,-103.2},{70,-110},{4,-110},{4,90},{-49.9,90},{-49.9,90.1}},
        color={0,0,127}));
  connect(fan4.P,measureBus. Pump_Coldwater_heatpump_power) annotation (Line(
        points={{-75.2,-51.2},{-75.2,-30},{-98,-30},{-98,88},{-49.9,88},{-49.9,
          90.1}},
        color={0,0,127}));
  connect(generation_Hot.measureBus,measureBus)  annotation (Line(
      points={{-66,79.9},{-66,88},{-50,88},{-50,90}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_heatPump1.measureBus,measureBus)  annotation (Line(
      points={{-46,20},{-46,34},{-98,34},{-98,88},{-50,88},{-50,90}},
      color={255,204,51},
      thickness=0.5));
  connect(fan4.port_b,generation_heatPump1. Fluid_in_cold)
    annotation (Line(points={{-68,-52},{-68,16},{-60,16}}, color={0,127,255}));
  connect(fan2.port_b,pipe. port_a)
    annotation (Line(points={{68,94},{74,94}}, color={0,127,255}));
  connect(pipe.port_b,Fluid_out_hot)  annotation (Line(points={{94,94},{98,94},{
          98,80},{100,80}}, color={0,127,255}));
  connect(fan1.port_b,pipe1. port_a) annotation (Line(points={{64,28},{68,28}},
                        color={0,127,255}));
  connect(pipe1.port_b,Fluid_out_warm)  annotation (Line(points={{88,28},{90,28},
          {90,20},{100,20}}, color={0,127,255}));
  connect(fan3.port_b,pipe2. port_a) annotation (Line(points={{64,-96},{68,-96},
          {68,-94},{70,-94}}, color={0,127,255}));
  connect(pipe2.port_b,Fluid_out_cold)  annotation (Line(points={{90,-94},{96,-94},
          {96,-80},{100,-80}}, color={0,127,255}));
  connect(ColdWater.TBottom,measureBus. ColdWater_TBottom) annotation (Line(
        points={{18,-84.2},{12,-84.2},{12,-84},{4,-84},{4,90.1},{-49.9,90.1}},
        color={0,0,127}));
  connect(WarmWater.fluidportTop2,bou2. ports[1]) annotation (Line(points={{
          35.6875,20.19},{35.6875,30},{36,30}}, color={0,127,255}));
  connect(fan3.port_a,bou3. ports[1])
    annotation (Line(points={{48,-96},{12,-96}}, color={0,127,255}));
  connect(fan2.port_a,HotWater. fluidportTop2) annotation (Line(points={{52,94},
          {37.6875,94},{37.6875,82.19}}, color={0,127,255}));
  connect(bou4.ports[1],HotWater. fluidportTop2) annotation (Line(points={{30,
          98},{30,94},{37.6875,94},{37.6875,82.19}}, color={0,127,255}));
  connect(generation_Aircooling_v2_1.Fluid_in_cool_airCooler, Valve3.port_3)
    annotation (Line(points={{-56,-20},{-56,-9},{-78,-9}}, color={0,127,255}));
  connect(generation_Aircooling_v2_1.Fluid_out_cool_airCooler,
    generation_heatPump1.Fluid_in_cold) annotation (Line(points={{-44,-20},{-44,
          -4},{-68,-4},{-68,16},{-60,16}}, color={0,127,255}));
  connect(generation_Aircooling_v2_1.Fluid_in_warm_airCooler, Valve4.port_3)
    annotation (Line(points={{-40,-24},{-28,-24},{-28,8}}, color={0,127,255}));
  connect(generation_Aircooling_v2_1.Fluid_out_warm_airCooler,
    generation_heatPump1.Fluid_in_warm) annotation (Line(points={{-40,-36},{-20,
          -36},{-20,4},{-40,4}}, color={0,127,255}));
  connect(generation_Aircooling_v2_1.controlBus, controlBus) annotation (Line(
      points={{-60,-30},{-98,-30},{-98,88},{4,88},{4,100}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_Aircooling_v2_1.measureBus, measureBus) annotation (Line(
      points={{-59.4,-36.8},{-66,-36.8},{-66,-30},{-98,-30},{-98,88},{-50,88},{-50,
          90},{-50,90}},
      color={255,204,51},
      thickness=0.5));
  connect(HotWater.heatportOutside, prescribedTemperature.port) annotation (
      Line(points={{47.625,64.14},{55.8125,64.14},{55.8125,64},{60,64}}, color=
          {191,0,0}));
  connect(WarmWater.heatportOutside, prescribedTemperature1.port) annotation (
      Line(points={{45.625,2.14},{53.8125,2.14},{53.8125,2},{60,2}}, color={191,
          0,0}));
  connect(ColdWater.heatportOutside, prescribedTemperature2.port) annotation (
      Line(points={{47.625,-67.86},{53.8125,-67.86},{53.8125,-68},{60,-68}},
        color={191,0,0}));
  connect(prescribedTemperature2.T, measureBus.RoomTemp_Workshop) annotation (
      Line(points={{73.2,-68},{78,-68},{78,-34},{4,-34},{4,90.1},{-49.9,90.1}},
        color={0,0,127}));
  connect(prescribedTemperature1.T, measureBus.RoomTemp_Canteen) annotation (
      Line(points={{73.2,2},{78,2},{78,-34},{4,-34},{4,90.1},{-49.9,90.1}},
        color={0,0,127}));
  connect(prescribedTemperature.T, measureBus.RoomTemp_Canteen) annotation (
      Line(points={{73.2,64},{76,64},{76,80},{76,80},{76,88},{4,88},{4,90.1},{
          -49.9,90.1}}, color={0,0,127}));
  connect(generation_geothermalProbe.measureBus, measureBus) annotation (Line(
      points={{-40,-90},{-34,-90},{-34,-104},{-98,-104},{-98,88},{-50,88},{-50,
          90},{-50,90}},
      color={255,204,51},
      thickness=0.5));
  connect(ColdWater.portHC2In, Valve2.port_3) annotation (Line(points={{17.8125,
          -73.75},{14,-73.75},{12,-73.75},{12,-74},{12,-45},{-78,-45}}, color={
          0,127,255}));
  connect(ColdWater.portHC2Out, Valve1.port_2) annotation (Line(points={{
          17.8125,-79.83},{-16,-79.83},{-16,-104},{-104,-104},{-104,-58},{-85,
          -58},{-85,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_v2;
