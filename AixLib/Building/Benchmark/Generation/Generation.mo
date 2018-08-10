within AixLib.Building.Benchmark.Generation;
model Generation
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

    parameter Modelica.SIunits.Time riseTime_valve = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 0 annotation(Dialog(tab = "General"));

    // Hotwater
    parameter AixLib.Fluid.Movers.Data.Generic pump_model_hotwater annotation(Dialog(tab = "hotwater"), choicesAllMatching = true);
    parameter Modelica.SIunits.Velocity v_nominal_hotwater = 0 annotation(Dialog(tab = "hotwater"));
    parameter Real m_flow_nominal_hotwater = 0 annotation(Dialog(tab = "hotwater"));
    parameter Modelica.SIunits.Length pipe_length_hotwater = 0 annotation(Dialog(tab = "hotwater"));
    parameter Modelica.SIunits.Length pipe_wall_thickness_hotwater = 0 annotation(Dialog(tab = "hotwater"));
    parameter Modelica.SIunits.Length pipe_insulation_thickness_hotwater = 0 annotation(Dialog(tab = "hotwater"));
    parameter Modelica.SIunits.ThermalConductivity pipe_insulation_conductivity_hotwater = 0  annotation(Dialog(tab = "hotwater"));

    //Warmwater
    parameter AixLib.Fluid.Movers.Data.Generic pump_model_warmwater annotation(Dialog(tab = "warmwater"), choicesAllMatching = true);
    parameter Modelica.SIunits.Velocity v_nominal_warmwater = 0 annotation(Dialog(tab = "warmwater"));
    parameter Real m_flow_nominal_warmwater = 0 annotation(Dialog(tab = "warmwater"));
    parameter Modelica.SIunits.Length pipe_length_warmwater = 0 annotation(Dialog(tab = "warmwater"));
    parameter Modelica.SIunits.Length pipe_wall_thickness_warmwater = 0 annotation(Dialog(tab = "warmwater"));
    parameter Modelica.SIunits.Length pipe_insulation_thickness_warmwater = 0 annotation(Dialog(tab = "warmwater"));
    parameter Modelica.SIunits.ThermalConductivity pipe_insulation_conductivity_warmwater = 0  annotation(Dialog(tab = "warmwater"));

    //ColdWater
    parameter AixLib.Fluid.Movers.Data.Generic pump_model_coldwater annotation(Dialog(tab = "coldwater"), choicesAllMatching = true);
    parameter Modelica.SIunits.Velocity v_nominal_coldwater = 0 annotation(Dialog(tab = "coldwater"));
    parameter Real m_flow_nominal_coldwater = 0 annotation(Dialog(tab = "coldwater"));
    parameter Modelica.SIunits.Length pipe_length_coldwater = 0 annotation(Dialog(tab = "coldwater"));
    parameter Modelica.SIunits.Length pipe_wall_thickness_coldwater = 0 annotation(Dialog(tab = "coldwater"));
    parameter Modelica.SIunits.Length pipe_insulation_thickness_coldwater = 0 annotation(Dialog(tab = "coldwater"));
    parameter Modelica.SIunits.ThermalConductivity pipe_insulation_conductivity_coldwater = 0  annotation(Dialog(tab = "coldwater"));

    //Generation Hot
    parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_hot annotation(Dialog(tab = "generation_hot"), choicesAllMatching = true);
    parameter AixLib.DataBase.CHP.CHPBaseDataDefinition CHP_model_generation_hot annotation(Dialog(tab = "generation_hot"), choicesAllMatching = true);
    parameter AixLib.DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition boiler_model_generation_hot annotation(Dialog(tab = "generation_hot"), choicesAllMatching = true);
    parameter Real m_flow_nominal_generation_hot = 0 annotation(Dialog(tab = "generation_hot"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_generation_hot = 0 annotation(Dialog(tab = "generation_hot"));

    //Heatpump
    parameter AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition heatpump_model_small annotation(Dialog(tab = "Heatpump"), choicesAllMatching = true);
    parameter Real factor_heatpump_model_small = 3 annotation(Dialog(tab = "Heatpump"));
    parameter AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition heatpump_model_big annotation(Dialog(tab = "Heatpump"), choicesAllMatching = true);
    parameter Real factor_heatpump_model_big = 6 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.Temp_K T_conMax_big = 328.15 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.Temp_K T_conMax_small = 328.15 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.Volume vol_small = 0.012 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.Volume vol_big = 0.024 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.ThermalConductance R_loss_small = 0 annotation(Dialog(tab = "Heatpump"));
    parameter Modelica.SIunits.ThermalConductance R_loss_big = 0 annotation(Dialog(tab = "Heatpump"));

    //Generation Warm
    parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_warmwater annotation(Dialog(tab = "generation_warmwater"), choicesAllMatching = true);
    parameter Real m_flow_nominal_generation_warmwater = 0 annotation(Dialog(tab = "generation_warmwater"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_warmwater = 0 annotation(Dialog(tab = "generation_warmwater"));

    //Generation Cold
    parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_coldwater annotation(Dialog(tab = "generation_coldwater"), choicesAllMatching = true);
    parameter Real m_flow_nominal_generation_coldwater = 0 annotation(Dialog(tab = "generation_coldwater"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_coldwater = 0 annotation(Dialog(tab = "generation_coldwater"));

    //Generation Aircooler
    parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_aircooler annotation(Dialog(tab = "generation_aircooler"), choicesAllMatching = true);
    parameter Real m_flow_nominal_generation_aircooler = 0 annotation(Dialog(tab = "generation_aircooler"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_generation_aircooler = 0 annotation(Dialog(tab = "generation_aircooler"));
    parameter Real m_flow_nominal_generation_air_max annotation(Dialog(tab = "generation_aircooler"));
    parameter Real m_flow_nominal_generation_air_min annotation(Dialog(tab = "generation_aircooler"));

    //Geothermal Probe
    parameter Modelica.SIunits.Length Probe_depth = 0 annotation(Dialog(tab = "Geothermal Probe"));
    parameter Real n_probes = 1 "Number of Probes" annotation(Dialog(tab = "Geothermal Probe"));
    parameter Modelica.SIunits.Temp_K Earthtemperature_start = 283.15 annotation(Dialog(tab = "Geothermal Probe"));

    //Storage
    parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC1_warm = 0 annotation(Dialog(tab = "Storage"));
    parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC2_warm = 0 annotation(Dialog(tab = "Storage"));
    parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC1_cold = 0 annotation(Dialog(tab = "Storage"));
    parameter AixLib.DataBase.Storage.Generic_New_2000l storage_model_hot annotation(Dialog(tab = "Storage"), choicesAllMatching = true);
    parameter AixLib.DataBase.Storage.Generic_New_2000l storage_model_warm annotation(Dialog(tab = "Storage"), choicesAllMatching = true);
    parameter AixLib.DataBase.Storage.Generic_New_2000l storage_model_cold annotation(Dialog(tab = "Storage"), choicesAllMatching = true);


  Generation_Hot generation_Hot(pump_model_generation_hot=
        pump_model_generation_hot, m_flow_nominal_generation_hot=
        m_flow_nominal_generation_hot,
    redeclare package Medium_Water = Medium_Water,
    riseTime_valve=riseTime_valve,
    CHP_model_generation_hot=CHP_model_generation_hot,
    boiler_model_generation_hot=boiler_model_generation_hot,
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
    alphaHC1=alphaHC1_warm,
    alphaHC2=alphaHC2_warm,
    data=storage_model_hot)
    annotation (Placement(transformation(extent={{18,44},{48,82}})));

  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));

  Generation_heatPump generation_heatPump1(pump_model_generation_warmwater=
        pump_model_generation_warmwater,
    heatpump_model_small=heatpump_model_small,
    factor_heatpump_model_small=factor_heatpump_model_small,
    heatpump_model_big=heatpump_model_big,
    factor_heatpump_model_big=factor_heatpump_model_big,
    T_conMax_big=T_conMax_big,
    T_conMax_small=T_conMax_small,
    vol_small=vol_small,
    vol_big=vol_big,
    R_loss_small=R_loss_small,
    R_loss_big=R_loss_big,
    redeclare package Medium_Water = Medium_Water,
    dpHeatexchanger_nominal=dpHeatexchanger_nominal)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));

  Fluid.Storage.BufferStorage ColdWater(
    useHeatingRod=false,
    n=5,
    useHeatingCoil2=false,
    upToDownHC1=false,
    useHeatingCoil1=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package Medium = Medium_Water,
    redeclare package MediumHC1 = Medium_Water,
    redeclare package MediumHC2 = Medium_Water,
    alphaHC1=alphaHC1_cold,
    data=storage_model_cold)
    annotation (Placement(transformation(extent={{18,-88},{48,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Generation_AirCooling generation_AirCooling(
    m_flow_nominal_generation_warmwater=m_flow_nominal_generation_warmwater,
    m_flow_nominal_generation_coldwater=m_flow_nominal_generation_coldwater,
    pump_model_generation_aircooler=pump_model_generation_aircooler,
    m_flow_nominal_generation_aircooler=m_flow_nominal_generation_aircooler,
    m_flow_nominal_generation_air_max=m_flow_nominal_generation_air_max,
    m_flow_nominal_generation_air_min=m_flow_nominal_generation_air_min,
    redeclare package Medium_Water = Medium_Water,
    riseTime_valve=riseTime_valve,
    dpValve_nominal_generation_aircooler=dpValve_nominal_generation_aircooler,
    dpHeatexchanger_nominal=dpHeatexchanger_nominal)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve4(
    y_start=0,
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_warmwater,
    riseTime=riseTime_valve,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_warmwater)
    annotation (Placement(transformation(extent={{-20,8},{-36,24}})));
  Generation_geothermalProbe generation_geothermalProbe(
    Probe_depth=Probe_depth,
    n_probes=n_probes,
    Earthtemperature_start=Earthtemperature_start,
    redeclare package Medium_Water = Medium_Water)      annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-50,-90})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve3(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_coldwater,
    riseTime=riseTime_valve,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_coldwater)
                                             annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-85,-9})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve1(
    redeclare package Medium = Medium_Water,
    riseTime=riseTime_valve,
    m_flow_nominal=m_flow_nominal_generation_coldwater,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_coldwater)
                        annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-85,-67})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve2(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_coldwater,
    riseTime=riseTime_valve,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_coldwater)
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
    alphaHC1=alphaHC1_warm,
    alphaHC2=alphaHC2_warm,
    data=storage_model_warm)
    annotation (Placement(transformation(extent={{16,-18},{46,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Fluid.Sources.Boundary_pT bou4(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=2) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={42,98})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve7(
    y_start=0,
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_hot,
    riseTime=riseTime_valve,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_generation_hot)
    annotation (Placement(transformation(extent={{-6,66},{-22,82}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve5(
    y_start=0,
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_warmwater,
    riseTime=riseTime_valve,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_warmwater)
    annotation (Placement(transformation(extent={{2,8},{-14,24}})));
  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={
            {-16,80},{24,120}}), iconTransformation(extent={{30,90},{50,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_pumpsAndPipes[5]
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={100,0})));
  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe1(
                                                   redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    nPorts=1,
    v_nominal=v_nominal_hotwater,
    length=pipe_length_hotwater,
    dIns=pipe_insulation_thickness_hotwater,
    kIns=pipe_insulation_conductivity_hotwater,
    thickness=pipe_wall_thickness_hotwater,
    m_flow_nominal=m_flow_nominal_hotwater)
    annotation (Placement(transformation(extent={{7.5,-7.5},{-7.5,7.5}},
        rotation=180,
        origin={81.5,94.5})));
  Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium = Medium_Water,
      per=pump_model_hotwater)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=180,
        origin={60,94})));
  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe2(
                                                   redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    nPorts=1,
    v_nominal=v_nominal_warmwater,
    length=pipe_length_warmwater,
    dIns=pipe_insulation_thickness_warmwater,
    kIns=pipe_insulation_conductivity_warmwater,
    thickness=pipe_wall_thickness_warmwater,
    m_flow_nominal=m_flow_nominal_warmwater)
    annotation (Placement(transformation(extent={{7.5,-7.5},{-7.5,7.5}},
        rotation=180,
        origin={69.5,28.5})));
  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe3(
                                                   redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    nPorts=1,
    v_nominal=v_nominal_coldwater,
    length=pipe_length_coldwater,
    dIns=pipe_insulation_thickness_coldwater,
    kIns=pipe_insulation_conductivity_coldwater,
    thickness=pipe_wall_thickness_coldwater,
    m_flow_nominal=m_flow_nominal_coldwater)
    annotation (Placement(transformation(extent={{7.5,7.5},{-7.5,-7.5}},
        rotation=180,
        origin={81.5,-97.5})));
  Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium = Medium_Water,
      per=pump_model_warmwater)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=180,
        origin={48,28})));
  Fluid.Movers.SpeedControlled_y fan3(redeclare package Medium = Medium_Water,
      per=pump_model_coldwater)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=180,
        origin={56,-96})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      per=pump_model_generation_coldwater)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-68,-58})));
  BusSystem.measureBus measureBus
    annotation (Placement(transformation(extent={{-70,70},{-30,110}}),
        iconTransformation(extent={{-50,90},{-30,110}})));
equation
  connect(generation_Hot.Fluid_in_Hot, HotWater.portHC1Out) annotation (Line(
        points={{-60,68},{-32,68},{-32,67.94},{17.8125,67.94}},color={0,127,255}));
  connect(HotWater.fluidportBottom2, Fluid_in_hot) annotation (Line(points={{37.3125,
          43.81},{37.3125,40},{100,40}},       color={0,127,255}));
  connect(HotWater.portHC2Out, generation_heatPump1.Fluid_in_warm) annotation (
      Line(points={{17.8125,52.17},{12,52.17},{12,4},{-40,4}},          color={
          0,127,255}));
  connect(generation_heatPump1.Fluid_out_warm, Valve4.port_2)
    annotation (Line(points={{-40,16},{-36,16}}, color={0,127,255}));
  connect(generation_heatPump1.Fluid_out_cold, Valve3.port_1)
    annotation (Line(points={{-60,4},{-85,4},{-85,-2}}, color={0,127,255}));
  connect(Valve3.port_2, Valve2.port_2) annotation (Line(points={{-85,-16},{-85,
          -16},{-85,-38}}, color={0,127,255}));
  connect(Valve2.port_1,Valve1. port_2) annotation (Line(points={{-85,-52},{-85,
          -52},{-85,-60}}, color={0,127,255}));
  connect(Valve2.port_3, ColdWater.portHC1In) annotation (Line(points={{-78,-45},
          {12,-45},{12,-46},{12,-46},{12,-58},{12,-58},{12,-58},{12,-58.17},{14,
          -58.17},{17.625,-58.17}},                                color={0,127,
          255}));
  connect(Valve3.port_3, generation_AirCooling.Fluid_in_cool_airCooler)
    annotation (Line(points={{-78,-9},{-56,-9},{-56,-10},{-56,-10},{-56,-20}},
        color={0,127,255}));
  connect(generation_AirCooling.Fluid_out_cool_airCooler, generation_heatPump1.Fluid_in_cold)
    annotation (Line(points={{-44,-20},{-44,-2},{-68,-2},{-68,16},{-60,16}},
        color={0,127,255}));
  connect(Valve4.port_3, generation_AirCooling.Fluid_in_warm_airCooler)
    annotation (Line(points={{-28,8},{-28,-24},{-40,-24}}, color={0,127,255}));
  connect(generation_AirCooling.Fluid_out_warm_airCooler, generation_heatPump1.Fluid_in_warm)
    annotation (Line(points={{-40,-36},{-6,-36},{-6,4},{-40,4}},   color={0,127,
          255}));
  connect(ColdWater.portHC1Out,Valve1. port_2) annotation (Line(points={{
          17.8125,-64.06},{-16,-64.06},{-16,-104},{-104,-104},{-104,-58},{-85,
          -58},{-85,-60}}, color={0,127,255}));
  connect(Fluid_in_cold, ColdWater.fluidportTop1) annotation (Line(points={{100,-40},
          {28,-40},{28,-46},{27.75,-46},{27.75,-49.81}},      color={0,127,255}));
  connect(WarmWater.fluidportBottom2, Fluid_in_warm) annotation (Line(points={{
          35.3125,-18.19},{35.3125,-20},{100,-20}}, color={0,127,255}));
  connect(generation_Hot.Fluid_out_Hot, Valve7.port_2) annotation (Line(points=
          {{-60,73.8},{-42,73.8},{-42,74},{-22,74}}, color={0,127,255}));
  connect(Valve7.port_1, HotWater.portHC1In) annotation (Line(points={{-6,74},{
          6,74},{6,73.83},{17.625,73.83}}, color={0,127,255}));
  connect(Valve7.port_3,WarmWater. portHC1In) annotation (Line(points={{-14,66},
          {-14,30},{12,30},{12,11.83},{15.625,11.83}}, color={0,127,255}));
  connect(WarmWater.portHC1Out, HotWater.portHC1Out) annotation (Line(points={{15.8125,
          5.94},{12,5.94},{12,67.94},{17.8125,67.94}},      color={0,127,255}));
  connect(Valve4.port_1, Valve5.port_2)
    annotation (Line(points={{-20,16},{-14,16}}, color={0,127,255}));
  connect(Valve5.port_1, HotWater.portHC2In) annotation (Line(points={{2,16},{2,
          58.25},{17.8125,58.25}}, color={0,127,255}));
  connect(Valve5.port_3,WarmWater. portHC2In) annotation (Line(points={{-6,8},{
          -6,-3.75},{15.8125,-3.75}}, color={0,127,255}));
  connect(WarmWater.portHC2Out, generation_heatPump1.Fluid_in_warm) annotation (
     Line(points={{15.8125,-9.83},{-6,-9.83},{-6,4},{-40,4}}, color={0,127,255}));
  connect(Valve7.y, controlBus.Valve7) annotation (Line(points={{-14,83.6},{-14,
          88},{4.1,88},{4.1,100.1}}, color={0,0,127}));
  connect(Valve5.y, controlBus.Valve5) annotation (Line(points={{-6,25.6},{-6,
          34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(Valve4.y, controlBus.Valve4) annotation (Line(points={{-28,25.6},{-28,
          34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(Valve3.y, controlBus.Valve3) annotation (Line(points={{-93.4,-9},{-98,
          -9},{-98,34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(Valve2.y, controlBus.Valve2) annotation (Line(points={{-93.4,-45},{
          -98,-45},{-98,34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(Valve1.y, controlBus.Valve1) annotation (Line(points={{-93.4,-67},{
          -98,-67},{-98,34},{4.1,34},{4.1,100.1}}, color={0,0,127}));
  connect(generation_heatPump1.controlBus, controlBus) annotation (Line(
      points={{-54,20},{-54,34},{4,34},{4,100}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_AirCooling.controlBus, controlBus) annotation (Line(
      points={{-60,-30},{-98,-30},{-98,34},{4,34},{4,100}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_Hot.controlBus, controlBus) annotation (Line(
      points={{-74,80},{-74,88},{4,88},{4,100}},
      color={255,204,51},
      thickness=0.5));
  connect(Valve1.port_3, generation_geothermalProbe.Fluid_in_Geothermal)
    annotation (Line(points={{-78,-67},{-74,-67},{-74,-80},{-56,-80}}, color={0,
          127,255}));
  connect(HotWater.heatportOutside, HeatPort_pumpsAndPipes[4]) annotation (Line(
        points={{47.625,64.14},{80,64.14},{80,4},{100,4}}, color={191,0,0}));
  connect(WarmWater.heatportOutside, HeatPort_pumpsAndPipes[4]) annotation (
      Line(points={{45.625,2.14},{62,2.14},{62,2},{80,2},{80,4},{100,4}}, color=
         {191,0,0}));
  connect(ColdWater.heatportOutside, HeatPort_pumpsAndPipes[5]) annotation (
      Line(points={{47.625,-67.86},{80,-67.86},{80,8},{100,8}}, color={191,0,0}));
  connect(HotWater.fluidportTop2, bou4.ports[1]) annotation (Line(points={{37.6875,
          82.19},{37.6875,94},{42.8,94}}, color={0,127,255}));
  connect(Fluid_out_hot, Fluid_out_hot) annotation (Line(points={{100,80},{94,80},
          {94,80},{100,80}}, color={0,127,255}));
  connect(plugFlowPipe1.ports_b[1], Fluid_out_hot) annotation (Line(points={{89,
          94.5},{92,94.5},{92,80},{100,80}}, color={0,127,255}));
  connect(bou4.ports[2], fan2.port_a)
    annotation (Line(points={{41.2,94},{52,94}}, color={0,127,255}));
  connect(fan2.port_b, plugFlowPipe1.port_a) annotation (Line(points={{68,94},{70,
          94},{70,94.5},{74,94.5}}, color={0,127,255}));
  connect(fan2.y, controlBus.Pump_Hotwater_y) annotation (Line(points={{60,103.6},
          {60,108},{20,108},{20,100},{12,100},{12,100.1},{4.1,100.1}}, color={0,
          0,127}));
  connect(fan2.heatPort, HeatPort_pumpsAndPipes[4]) annotation (Line(points={{60,
          88.56},{60,64},{80,64},{80,4},{100,4}}, color={191,0,0}));
  connect(plugFlowPipe1.heatPort, HeatPort_pumpsAndPipes[4]) annotation (Line(
        points={{81.5,87},{81.5,64},{80,64},{80,4},{100,4}}, color={191,0,0}));
  connect(fan3.port_b, plugFlowPipe3.port_a) annotation (Line(points={{64,-96},{
          70,-96},{70,-97.5},{74,-97.5}}, color={0,127,255}));
  connect(plugFlowPipe3.ports_b[1], Fluid_out_cold) annotation (Line(points={{89,
          -97.5},{92,-97.5},{92,-80},{100,-80}}, color={0,127,255}));
  connect(fan3.port_a, ColdWater.fluidportBottom1) annotation (Line(points={{48,
          -96},{28,-96},{28,-94},{27.9375,-94},{27.9375,-88.38}}, color={0,127,255}));
  connect(WarmWater.fluidportTop2, fan1.port_a) annotation (Line(points={{35.6875,
          20.19},{35.6875,28},{40,28}}, color={0,127,255}));
  connect(fan1.port_b, plugFlowPipe2.port_a) annotation (Line(points={{56,28},{60,
          28},{60,28.5},{62,28.5}}, color={0,127,255}));
  connect(plugFlowPipe2.ports_b[1], Fluid_out_warm) annotation (Line(points={{77,
          28.5},{84.5,28.5},{84.5,20},{100,20}}, color={0,127,255}));
  connect(plugFlowPipe2.heatPort, HeatPort_pumpsAndPipes[4]) annotation (Line(
        points={{69.5,21},{69.5,2},{70,2},{70,2},{80,2},{80,4},{100,4}}, color={
          191,0,0}));
  connect(fan1.heatPort, HeatPort_pumpsAndPipes[4]) annotation (Line(points={{48,
          22.56},{48,12},{48,12},{48,2},{80,2},{80,4},{100,4}}, color={191,0,0}));
  connect(fan3.heatPort, HeatPort_pumpsAndPipes[5]) annotation (Line(points={{56,
          -90.56},{56,-68},{80,-68},{80,8},{100,8}}, color={191,0,0}));
  connect(plugFlowPipe3.heatPort, HeatPort_pumpsAndPipes[5]) annotation (Line(
        points={{81.5,-90},{80,-90},{80,8},{100,8}}, color={191,0,0}));
  connect(fan3.y, controlBus.Pump_Coldwater_y) annotation (Line(points={{56,-105.6},
          {56,-110},{4.1,-110},{4.1,100.1}}, color={0,0,127}));
  connect(fan1.y, controlBus.Pump_Warmwater_y) annotation (Line(points={{48,37.6},
          {48,40},{4.1,40},{4.1,100.1}}, color={0,0,127}));
  connect(fan4.port_a, generation_geothermalProbe.Fulid_out_Geothermal)
    annotation (Line(points={{-68,-66},{-68,-70},{-44,-70},{-44,-80}}, color={0,
          127,255}));
  connect(Valve1.port_1, generation_geothermalProbe.Fulid_out_Geothermal)
    annotation (Line(points={{-85,-74},{-84,-74},{-84,-76},{-68,-76},{-68,-70},{
          -44,-70},{-44,-80}}, color={0,127,255}));
  connect(bou1.ports[1], generation_geothermalProbe.Fulid_out_Geothermal)
    annotation (Line(points={{-50,-60},{-50,-70},{-44,-70},{-44,-80}}, color={0,
          127,255}));
  connect(fan4.port_b, generation_heatPump1.Fluid_in_cold)
    annotation (Line(points={{-68,-50},{-68,16},{-60,16}}, color={0,127,255}));
  connect(fan4.y, controlBus.Pump_Coldwater_heatpump_y) annotation (Line(points={{-77.6,
          -58},{-98,-58},{-98,88},{4.1,88},{4.1,100.1}},        color={0,0,127}));
  connect(generation_AirCooling.measureBus, measureBus) annotation (Line(
      points={{-60,-36},{-72,-36},{-72,-30},{-98,-30},{-98,88},{-50,88},{-50,90}},
      color={255,204,51},
      thickness=0.5));

  connect(ColdWater.TBottom, measureBus.ColdWater_TBottom) annotation (Line(
        points={{18,-84.2},{12,-84.2},{12,-84},{4,-84},{4,88},{-49.9,88},{-49.9,90.1}},
                   color={0,0,127}));
  connect(ColdWater.TTop, measureBus.ColdWater_TTop) annotation (Line(points={{18,
          -52.28},{12,-52.28},{12,-52},{4,-52},{4,88},{-49.9,88},{-49.9,90.1}},
        color={0,0,127}));
  connect(WarmWater.TBottom, measureBus.WarmWater_TBottom) annotation (Line(
        points={{16,-14.2},{10,-14.2},{4,-14.2},{4,-14},{4,88},{-49.9,88},{-49.9,90.1}},
                   color={0,0,127}));
  connect(WarmWater.TTop, measureBus.WarmWater_TTop) annotation (Line(points={{16,
          17.72},{10,17.72},{10,18},{4,18},{4,88},{-49.9,88},{-49.9,90.1}},
        color={0,0,127}));
  connect(HotWater.TBottom, measureBus.HotWater_TBottom) annotation (Line(
        points={{18,47.8},{4,47.8},{4,88},{-49.9,88},{-49.9,90.1}},  color={0,0,
          127}));
  connect(HotWater.TTop, measureBus.HotWater_TTop) annotation (Line(points={{18,79.72},
          {12,79.72},{12,80},{4,80},{4,88},{-49.9,88},{-49.9,90.1}},
        color={0,0,127}));
  connect(fan2.P, measureBus.Pump_Hotwater_power) annotation (Line(points={{68.8,101.2},
          {70,101.2},{70,88},{-49.9,88},{-49.9,90.1}},         color={0,0,127}));
  connect(fan1.P, measureBus.Pump_Warmwater_power) annotation (Line(points={{56.8,
          35.2},{60,35.2},{60,40},{4,40},{4,88},{-49.9,88},{-49.9,90.1}},
        color={0,0,127}));
  connect(fan3.P, measureBus.Pump_Coldwater_power) annotation (Line(points={{64.8,
          -103.2},{68,-103.2},{68,-110},{4,-110},{4,88},{-49.9,88},{-49.9,90.1}},
        color={0,0,127}));
  connect(fan4.P, measureBus.Pump_Coldwater_heatpump_power) annotation (Line(
        points={{-75.2,-49.2},{-75.2,-30},{-98,-30},{-98,88},{-49.9,88},{-49.9,90.1}},
        color={0,0,127}));
  connect(generation_Hot.measureBus, measureBus) annotation (Line(
      points={{-66,79.9},{-66,88},{-50,88},{-50,90}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_heatPump1.measureBus, measureBus) annotation (Line(
      points={{-46,20},{-46,34},{-98,34},{-98,88},{-50,88},{-50,90}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation;
