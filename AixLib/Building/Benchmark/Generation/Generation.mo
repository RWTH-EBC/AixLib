within AixLib.Building.Benchmark.Generation;
model Generation
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";

  Generation_Hot generation_Hot
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Fluid.Storage.BufferStorage HotWater(
    useHeatingRod=false,
    data=DataBase.Storage.Generic_New_2000l(),
    n=5,
    useHeatingCoil2=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package Medium = Medium_Water,
    redeclare package MediumHC1 = Medium_Water,
    redeclare package MediumHC2 = Medium_Water)
    annotation (Placement(transformation(extent={{18,44},{48,82}})));

  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,70},{110,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));

  Generation_heatPump generation_heatPump1
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));

  Fluid.Storage.BufferStorage ColdWater(
    useHeatingRod=false,
    n=5,
    useHeatingCoil2=false,
    upToDownHC1=false,
    data=DataBase.Storage.Generic_New_2000l(lengthHC1=200),
    useHeatingCoil1=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package Medium = Medium_Water,
    redeclare package MediumHC1 = Medium_Water,
    redeclare package MediumHC2 = Medium_Water)
    annotation (Placement(transformation(extent={{18,-88},{48,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Fluid.Movers.FlowControlled_dp pump_hotwater(
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
    redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  Fluid.Movers.FlowControlled_dp pump_coldwater(
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
    redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{64,-56},{84,-36}})));
  Generation_AirCooling generation_AirCooling
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve4(
    m_flow_nominal=3,
    dpValve_nominal=10,
    y_start=0,
    redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-20,8},{-36,24}})));
  Generation_geothermalProbe generation_geothermalProbe annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-50,-90})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve3(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={-85,-9})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve1(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water)
                        annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-85,-67})));

  Fluid.Actuators.Valves.ThreeWayLinear Valve2(
    m_flow_nominal=1,
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water)
                        annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={-85,-45})));

  Fluid.Movers.FlowControlled_dp pump_coldwater_heatpump(
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per,
    redeclare package Medium = Medium_Water) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-68,-56})));
  Fluid.Sources.Boundary_pT bou1(
    nPorts=1,
    redeclare package Medium = Medium_Water,
    p=100000) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-50,-56})));
  Fluid.Storage.BufferStorage HotWater2(
    useHeatingRod=false,
    data=DataBase.Storage.Generic_New_2000l(),
    n=5,
    useHeatingCoil2=true,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package Medium = Medium_Water,
    redeclare package MediumHC1 = Medium_Water,
    redeclare package MediumHC2 = Medium_Water)
    annotation (Placement(transformation(extent={{16,-18},{46,20}})));
  Fluid.Movers.FlowControlled_dp pump_warmwater(
    m_flow_nominal=1,
    addPowerToMedium=true,
    tau=1,
    dp_nominal=700,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
    redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{58,14},{78,34}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Fluid.Sources.Boundary_pT bou4(
    nPorts=1,
    redeclare package Medium = Medium_Water,
    p=100000) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={42,98})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve7(
    m_flow_nominal=3,
    dpValve_nominal=10,
    y_start=0,
    redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-6,66},{-22,82}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve5(
    m_flow_nominal=3,
    dpValve_nominal=10,
    y_start=0,
    redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{2,8},{-14,24}})));
  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={
            {-16,80},{24,120}}), iconTransformation(extent={{30,90},{50,110}})));
  Modelica.Blocks.Interfaces.RealInput AirTemp "Prescribed fluid temperature"
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={-40,106})));
equation
  connect(generation_Hot.Fluid_in_Hot, HotWater.portHC1Out) annotation (Line(
        points={{-60,68},{-32,68},{-32,67.94},{17.8125,67.94}},color={0,127,255}));
  connect(HotWater.fluidportBottom2, Fluid_in_hot) annotation (Line(points={{37.3125,
          43.81},{37.3125,40},{100,40}},       color={0,127,255}));
  connect(pump_hotwater.port_b, Fluid_out_hot)
    annotation (Line(points={{80,90},{80,80},{100,80}}, color={0,127,255}));
  connect(pump_coldwater.port_b, Fluid_out_cold) annotation (Line(points={{84,-46},
          {92,-46},{92,-40},{100,-40}}, color={0,127,255}));
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
  connect(Valve1.port_1, generation_geothermalProbe.Fluid_in_Geothermal)
    annotation (Line(points={{-85,-74},{-84,-74},{-84,-76},{-56,-76},{-56,-80}},
        color={0,127,255}));
  connect(Valve2.port_3, ColdWater.portHC1In) annotation (Line(points={{-78,-45},
          {-38,-45},{-38,-46},{12,-46},{12,-58},{14,-58},{14,-58.17},{17.625,
          -58.17}},                                                color={0,127,
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
  connect(Valve1.port_3, pump_coldwater_heatpump.port_a) annotation (Line(
        points={{-78,-67},{-74,-67},{-74,-68},{-68,-68},{-68,-62}}, color={0,
          127,255}));
  connect(generation_geothermalProbe.Fulid_out_Geothermal,
    pump_coldwater_heatpump.port_a) annotation (Line(points={{-44,-80},{-44,-68},
          {-68,-68},{-68,-62}}, color={0,127,255}));
  connect(bou1.ports[1], pump_coldwater_heatpump.port_a) annotation (Line(
        points={{-50,-60},{-50,-64},{-68,-64},{-68,-62}}, color={0,127,255}));
  connect(ColdWater.portHC1Out,Valve1. port_2) annotation (Line(points={{
          17.8125,-64.06},{-16,-64.06},{-16,-104},{-104,-104},{-104,-58},{-85,
          -58},{-85,-60}}, color={0,127,255}));
  connect(Fluid_in_cold, ColdWater.fluidportTop1) annotation (Line(points={{100,-80},
          {56,-80},{56,-46},{27.75,-46},{27.75,-49.81}},      color={0,127,255}));
  connect(HotWater2.fluidportBottom2, Fluid_in_warm) annotation (Line(points={{
          35.3125,-18.19},{35.3125,-20},{100,-20}}, color={0,127,255}));
  connect(pump_warmwater.port_b, Fluid_out_warm) annotation (Line(points={{78,
          24},{90,24},{90,20},{100,20}}, color={0,127,255}));
  connect(HotWater.fluidportTop2, pump_hotwater.port_a) annotation (Line(points=
         {{37.6875,82.19},{37.6875,90},{60,90}}, color={0,127,255}));
  connect(HotWater2.fluidportTop2, pump_warmwater.port_a) annotation (Line(
        points={{35.6875,20.19},{36,20.19},{36,24},{58,24}}, color={0,127,255}));
  connect(pump_coldwater.port_a, ColdWater.fluidportBottom1) annotation (Line(
        points={{64,-46},{56,-46},{56,-90},{27.9375,-90},{27.9375,-88.38}},
        color={0,127,255}));
  connect(bou4.ports[1], pump_hotwater.port_a)
    annotation (Line(points={{42,94},{42,90},{60,90}}, color={0,127,255}));
  connect(generation_Hot.Fluid_out_Hot, Valve7.port_2) annotation (Line(points=
          {{-60,73.8},{-42,73.8},{-42,74},{-22,74}}, color={0,127,255}));
  connect(Valve7.port_1, HotWater.portHC1In) annotation (Line(points={{-6,74},{
          6,74},{6,73.83},{17.625,73.83}}, color={0,127,255}));
  connect(Valve7.port_3, HotWater2.portHC1In) annotation (Line(points={{-14,66},
          {-14,30},{12,30},{12,11.83},{15.625,11.83}}, color={0,127,255}));
  connect(HotWater2.portHC1Out, HotWater.portHC1Out) annotation (Line(points={{15.8125,
          5.94},{12,5.94},{12,67.94},{17.8125,67.94}},      color={0,127,255}));
  connect(Valve4.port_1, Valve5.port_2)
    annotation (Line(points={{-20,16},{-14,16}}, color={0,127,255}));
  connect(Valve5.port_1, HotWater.portHC2In) annotation (Line(points={{2,16},{2,
          58.25},{17.8125,58.25}}, color={0,127,255}));
  connect(Valve5.port_3, HotWater2.portHC2In) annotation (Line(points={{-6,8},{
          -6,-3.75},{15.8125,-3.75}}, color={0,127,255}));
  connect(HotWater2.portHC2Out, generation_heatPump1.Fluid_in_warm) annotation (
     Line(points={{15.8125,-9.83},{-6,-9.83},{-6,4},{-40,4}}, color={0,127,255}));
  connect(HotWater.TTop, controlBus.HotWater_TTop) annotation (Line(points={{18,
          79.72},{10,79.72},{10,80},{4.1,80},{4.1,100.1}}, color={0,0,127}));
  connect(HotWater.TBottom, controlBus.HotWater_TBottom) annotation (Line(
        points={{18,47.8},{12,47.8},{12,48},{4.1,48},{4.1,100.1}}, color={0,0,
          127}));
  connect(HotWater2.TTop, controlBus.WarmWater_TTop) annotation (Line(points={{
          16,17.72},{12,17.72},{12,18},{4.1,18},{4.1,100.1}}, color={0,0,127}));
  connect(HotWater2.TBottom, controlBus.WarmWater_TBottom) annotation (Line(
        points={{16,-14.2},{4,-14.2},{4,100.1},{4.1,100.1}}, color={0,0,127}));
  connect(ColdWater.TTop, controlBus.ColdWater_TTop) annotation (Line(points={{
          18,-52.28},{4.1,-52.28},{4.1,100.1}}, color={0,0,127}));
  connect(ColdWater.TBottom, controlBus.ColdWater_TBottom) annotation (Line(
        points={{18,-84.2},{12,-84.2},{12,-84},{4.1,-84},{4.1,100.1}}, color={0,
          0,127}));
  connect(pump_hotwater.dp_in, controlBus.Pump_Hotwater_dp) annotation (Line(
        points={{70,102},{70,108},{32,108},{18,108},{18,100.1},{4.1,100.1}},
        color={0,0,127}));
  connect(pump_warmwater.dp_in, controlBus.Pump_Warmwater_dp) annotation (Line(
        points={{68,36},{68,40},{4.1,40},{4.1,100.1}}, color={0,0,127}));
  connect(pump_coldwater.dp_in, controlBus.Pump_Coldwater_dp) annotation (Line(
        points={{74,-34},{74,-28},{4.1,-28},{4.1,100.1}}, color={0,0,127}));
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
  connect(pump_coldwater_heatpump.port_b, generation_heatPump1.Fluid_in_cold)
    annotation (Line(points={{-68,-50},{-68,16},{-60,16}}, color={0,127,255}));
  connect(pump_coldwater_heatpump.dp_in, controlBus.Pump_Coldwater_heatpump_dp)
    annotation (Line(points={{-75.2,-56},{-98,-56},{-98,34},{4.1,34},{4.1,100.1}},
        color={0,0,127}));
  connect(generation_heatPump1.controlBus, controlBus) annotation (Line(
      points={{-50,20},{-50,34},{4,34},{4,100}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_AirCooling.controlBus, controlBus) annotation (Line(
      points={{-60,-30},{-98,-30},{-98,34},{4,34},{4,100}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_AirCooling.T_in1, AirTemp) annotation (Line(points={{-60.8,
          -38},{-72,-38},{-72,-30},{-98,-30},{-98,88},{-40,88},{-40,106}},
        color={0,0,127}));
  connect(generation_Hot.controlBus, controlBus) annotation (Line(
      points={{-70,80},{-70,88},{4,88},{4,100}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-190,56},{-128,36}},
          lineColor={28,108,200},
          textString="Parameter müssen angepasst werden
")}));
end Generation;
