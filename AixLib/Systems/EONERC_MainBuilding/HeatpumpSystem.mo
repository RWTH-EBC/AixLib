within AixLib.Systems.EONERC_MainBuilding;
model HeatpumpSystem "Heatpump system of the E.ON ERC main building"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  HydraulicModules.Pump pump_hot(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dIns=0.01,
    kIns=0.028,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(energyDynamics=pump_hot.energyDynamics, redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2
          per)),
    d=0.125,
    T_amb=293.15) annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-60,0})));

  HydraulicModules.Pump pump_cold(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dIns=0.01,
    kIns=0.028,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(energyDynamics=pump_hot.energyDynamics, redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2
          per)),
    d=0.100,
    length=4,
    pipe3(length=8),
    T_amb=293.15) annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={60,0})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-158,34},{-150,42}})));
  Fluid.HeatPumps.HeatPumpSimple heatPumpSimple(
    redeclare package Medium = Medium,
    tablePower=[0.0,273.15,283.15; 308.15,11000*5,11500*5; 328.15,16000*5,17500
        *5],
    tableHeatFlowCondenser=[0.0,273.15,283.15; 308.15,48000*5,63000*5; 328.15,
        44000*5,57500*5])
    annotation (Placement(transformation(extent={{20,-20},{-20,20}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        298.15) annotation (Placement(transformation(extent={{84,-4},{92,4}})));
  Fluid.Storage.BufferStorage coldStorage(
    n=10,
    redeclare package Medium = Medium,
    data=AixLib.DataBase.Storage.Generic_New_2000l(),
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    upToDownHC1=false,
    upToDownHC2=false,
    useHeatingRod=false,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart=303.15)
    annotation (Placement(transformation(extent={{124,-16},{100,14}})));
  Fluid.Storage.BufferStorage heatStorage(
    n=10,
    redeclare package Medium = Medium,
    data=AixLib.DataBase.Storage.Generic_New_2000l(),
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    upToDownHC1=false,
    upToDownHC2=false,
    useHeatingRod=false,
    redeclare model HeatTransfer =
        Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart=303.15) annotation (Placement(transformation(
        extent={{12,-15},{-12,15}},
        rotation=0,
        origin={-188,-1})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=
        298.15)
    annotation (Placement(transformation(extent={{-212,-2},{-204,6}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 31, uHigh=273.15
         + 35)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={8.88178e-16,34})));
  HydraulicModules.Throttle throttle_recool(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dIns=0.01,
    kIns=0.028,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    d=0.125,
    length=5,
    Kv=160,
    pipe3(length=10),
    T_amb=293.15) annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={-60,-80})));
  HydraulicModules.Controller.CtrPump ctrPump(rpm_pump=3000) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-34,-24})));
  HydraulicModules.Controller.CtrPump ctrPump1(rpm_pump=3000)
    annotation (Placement(transformation(extent={{28,16},{40,28}})));
  HydraulicModules.Throttle throttle_HS(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dIns=0.01,
    kIns=0.028,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    pipe3(length=2),
    d=0.100,
    Kv=100,
    T_amb=293.15) annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=0,
        origin={-140,0})));
  HydraulicModules.Throttle throttle_CS(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dIns=0.01,
    kIns=0.028,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    pipe3(length=2),
    d=0.125,
    Kv=160,
    T_amb=293.15) annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={160,0})));
  HydraulicModules.Throttle throttle_freecool(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dIns=0.01,
    kIns=0.028,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    length=1,
    pipe3(length=2),
    d=0.100,
    Kv=100,
    T_amb=293.15) annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={140,-80})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    V=0.01,
    nPorts=2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-20,-80})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    V=0.01,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={100,-80})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBus1
    annotation (Placement(transformation(extent={{-150,28},{-130,48}})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBus2
    annotation (Placement(transformation(extent={{-68,-58},{-48,-38}})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBus3
    annotation (Placement(transformation(extent={{130,-54},{150,-34}})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBus4
    annotation (Placement(transformation(extent={{150,24},{170,44}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-84,-52},{-74,-42}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{112,-48},{120,-40}})));
  Modelica.Blocks.Sources.Constant const3(k=1)
    annotation (Placement(transformation(extent={{132,32},{140,40}})));
  Modelica.Fluid.Interfaces.FluidPort_a fluidportBottom1
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-230,-30},{-210,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_b fluidportTop1
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-230,10},{-210,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{210,-30},{230,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{210,10},{230,30}})));
equation
  connect(pump_hot.port_b1, heatPumpSimple.port_a_sink) annotation (Line(
        points={{-40,-12},{-28,-12},{-28,-14},{-18,-14}}, color={0,127,255}));
  connect(heatPumpSimple.port_b_sink, pump_hot.port_a2) annotation (Line(
        points={{-18,14},{-30,14},{-30,12},{-40,12}}, color={0,127,255}));
  connect(heatPumpSimple.port_b_source, pump_cold.port_a2) annotation (Line(
        points={{18,-14},{28.15,-14},{28.15,-12},{40,-12}}, color={0,127,255}));
  connect(heatPumpSimple.port_a_source, pump_cold.port_b1) annotation (Line(
        points={{18,14},{30,14},{30,12},{40,12}}, color={0,127,255}));
  connect(pump_cold.port_a1, coldStorage.fluidportTop2) annotation (Line(
        points={{80,12},{88,12},{88,20},{108,20},{108,14.15},{108.25,14.15}},
        color={0,127,255}));
  connect(pump_cold.port_b2, coldStorage.fluidportBottom2) annotation (Line(
        points={{80,-12},{90,-12},{90,-20},{108,-20},{108,-16},{108.55,-16},{
          108.55,-16.15}}, color={0,127,255}));
  connect(fixedTemperature.port, coldStorage.heatportOutside) annotation (
      Line(points={{92,0},{100.3,0},{100.3,-0.1}}, color={191,0,0}));
  connect(heatStorage.heatportOutside, fixedTemperature1.port) annotation (
      Line(points={{-199.7,-0.1},{-200,-0.1},{-200,2},{-204,2}}, color={191,0,
          0}));
  connect(hysteresis.y, not1.u) annotation (Line(points={{-19,50},{0,50},{0,
          41.2},{2.22045e-15,41.2}}, color={255,0,255}));
  connect(not1.y, heatPumpSimple.OnOff) annotation (Line(points={{-2.22045e-16,
          27.4},{0,27.4},{0,16}}, color={255,0,255}));
  connect(heatStorage.TTop, hysteresis.u) annotation (Line(points={{-176,12.2},
          {-176,50},{-42,50}}, color={0,0,127}));
  connect(pump_hot.hydraulicBus, ctrPump.hydraulicBus) annotation (Line(
      points={{-60,-20},{-60,-24},{-40.06,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrPump1.hydraulicBus, pump_cold.hydraulicBus) annotation (Line(
      points={{40.06,22},{60,22},{60,20}},
      color={255,204,51},
      thickness=0.5));
  connect(throttle_HS.port_a1, pump_hot.port_b2)
    annotation (Line(points={{-120,12},{-80,12}}, color={0,127,255}));
  connect(pump_hot.port_a1, throttle_recool.port_b1) annotation (Line(points=
          {{-80,-12},{-100,-12},{-100,-68},{-80,-68}}, color={0,127,255}));
  connect(throttle_HS.port_b2, pump_hot.port_a1)
    annotation (Line(points={{-120,-12},{-80,-12}}, color={0,127,255}));
  connect(throttle_HS.port_a2, heatStorage.fluidportBottom1) annotation (Line(
        points={{-160,-12},{-166,-12},{-166,-20},{-183.95,-20},{-183.95,-16.3}},
        color={0,127,255}));
  connect(throttle_HS.port_b1, heatStorage.fluidportTop1) annotation (Line(
        points={{-160,12},{-160,20},{-184,20},{-184,14.15},{-183.8,14.15}},
        color={0,127,255}));
  connect(throttle_CS.port_a2, coldStorage.fluidportBottom1) annotation (Line(
        points={{140,-12},{134,-12},{134,-20},{116.05,-20},{116.05,-16.3}},
        color={0,127,255}));
  connect(throttle_CS.port_b1, coldStorage.fluidportTop1) annotation (Line(
        points={{140,12},{136,12},{136,20},{116.2,20},{116.2,14.15}}, color={
          0,127,255}));
  connect(throttle_freecool.port_a1, throttle_CS.port_a1) annotation (Line(
        points={{160,-68},{202,-68},{202,12},{180,12}}, color={0,127,255}));
  connect(throttle_freecool.port_b2, throttle_CS.port_b2) annotation (Line(
        points={{160,-92},{188,-92},{188,-12},{180,-12}}, color={0,127,255}));
  connect(throttle_recool.port_a2, pump_hot.port_b2) annotation (Line(points=
          {{-80,-92},{-110,-92},{-110,12},{-80,12}}, color={0,127,255}));
  connect(vol1.ports[1], throttle_freecool.port_b1) annotation (Line(points={
          {110,-82},{110,-68},{120,-68}}, color={0,127,255}));
  connect(vol1.ports[2], throttle_freecool.port_a2) annotation (Line(points={
          {110,-78},{110,-92},{120,-92}}, color={0,127,255}));
  connect(vol.ports[1], throttle_recool.port_b2) annotation (Line(points={{-30,
          -82},{-30,-92},{-40,-92}}, color={0,127,255}));
  connect(throttle_recool.port_a1, vol.ports[2]) annotation (Line(points={{-40,
          -68},{-30,-68},{-30,-78}}, color={0,127,255}));
  connect(throttle_HS.hydraulicBus, hydraulicBus1) annotation (Line(
      points={{-140,20},{-142,20},{-142,38},{-140,38}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(throttle_recool.hydraulicBus, hydraulicBus2) annotation (Line(
      points={{-60,-60},{-60,-48},{-58,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(throttle_freecool.hydraulicBus, hydraulicBus3) annotation (Line(
      points={{140,-60},{140,-44}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(throttle_CS.hydraulicBus, hydraulicBus4) annotation (Line(
      points={{160,20},{160,34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(const.y, hydraulicBus1.valSet) annotation (Line(points={{-149.6,38},{
          -140,38},{-140,40},{-139.95,40},{-139.95,38.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const1.y, hydraulicBus2.valSet) annotation (Line(points={{-73.5,-47},
          {-57.95,-47},{-57.95,-47.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const2.y, hydraulicBus3.valSet) annotation (Line(points={{120.4,-44},
          {126,-44},{126,-43.95},{140.05,-43.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const3.y, hydraulicBus4.valSet) annotation (Line(points={{140.4,36},{
          160.05,36},{160.05,34.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatStorage.fluidportBottom2, fluidportBottom1) annotation (Line(
        points={{-191.45,-16.15},{-192,-16.15},{-192,-20},{-220,-20}}, color=
          {0,127,255}));
  connect(heatStorage.fluidportTop2, fluidportTop1) annotation (Line(points={
          {-191.75,14.15},{-191.75,20},{-220,20}}, color={0,127,255}));
  connect(throttle_CS.port_b2, port_b1) annotation (Line(points={{180,-12},{
          220,-12},{220,-20}}, color={0,127,255}));
  connect(throttle_CS.port_a1, port_a1) annotation (Line(points={{180,12},{
          220,12},{220,20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},
            {220,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-220,-100},{220,100}})));
end HeatpumpSystem;
