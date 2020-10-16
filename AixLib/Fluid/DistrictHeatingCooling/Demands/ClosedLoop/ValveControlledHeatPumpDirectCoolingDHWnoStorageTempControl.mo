within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlledHeatPumpDirectCoolingDHWnoStorageTempControl
  "Substation model for low-temperature networks for buildings with reversible heat pump that also supplies dhw"

      replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium
      "Medium model for water"
      annotation (choicesAllMatching = true);
      replaceable package MediumBuilding =
      Modelica.Media.Interfaces.PartialMedium
      "Medium in the building heating system"
      annotation (choicesAllMatching = true);

    parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180
    "Cp-value of Water";

    parameter Modelica.SIunits.HeatFlowRate heatDemand_max
    "maximum heat demand for scaling of heatpump in Watt";

    parameter Modelica.SIunits.HeatFlowRate coldDemand_max
    "maximum cold demand for scaling of heatpump in cooling mode in Watt";

    parameter Modelica.SIunits.Pressure dp_nominal=400000
    "nominal pressure drop";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=(heatDemand_max)/cp_default/dT_Network
    "Nominal mass flow rate of the Network Pipe";

    parameter Modelica.SIunits.TemperatureDifference dT_Network(displayUnit="K")
    "Design temperature difference between hot and cold pipe";

    parameter Modelica.SIunits.Position val_pos_min
    "Minimum Vale Position, between 0 and 1";

    parameter Modelica.SIunits.Temperature T_dhw_supply(displayUnit="°C")
    "Temperature of the DHW that comes out of showers, sinks etc. Is used to compute the return Temperature";

public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-450,-10},{-430,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{132,-10},{152,10}}),
        iconTransformation(extent={{132,-10},{152,10}})));

  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-480,-100},{-440,-60}}),  iconTransformation(
          extent={{-480,-60},{-440,-20}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation in Watt. Values are positive or 0."
                                                 annotation (Placement(
        transformation(extent={{-480,-140},{-440,-100}}), iconTransformation(
          extent={{-480,-140},{-440,-100}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-480,-60},{-440,-20}}),   iconTransformation(
          extent={{-480,-220},{-440,-180}})));

  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=60,
    m_flow_nominal=m_flow_nominal,
    T_start=283.15,
    nPorts=3)
    annotation (Placement(transformation(extent={{86,0},{106,20}})));

  Sensors.TemperatureTwoPort senTem_supply(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-390,14},{-362,-14}})));
  MixingVolumes.MixingVolume HX(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    V=0.15,
    nPorts=2)
            "Heat Exchanger Volume for direct cooling"
    annotation (Placement(transformation(extent={{-90,0},{-110,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,36})));
  HeatPumps.Carnot_TCon_RE_Jonas
                           heaPum(
    redeclare package Medium2 = Medium,
    redeclare package Medium1 = MediumBuilding,
    show_T=true,
    dTEva_nominal=-10,
    dTCon_nominal=10,
    etaCarnot_nominal=0.5,
    Q_heating_nominal=heatDemand_max,
    dp1_nominal=30000,
    dp2_nominal=30000,
    m2_flow_nominal=m_flow_nominal,
    m1_flow_nominal=m_flow_nominal,
    Q_cooling_nominal=-coldDemand_max,
    TEva_nominal=283.15)
    annotation (Placement(transformation(extent={{-12,4},{-32,-16}})));
  Sources.Boundary_pT HP_Supply(redeclare package Medium = MediumBuilding,
      nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-66,-38})));
  Sources.MassFlowSource_T HP_Return(
    redeclare package Medium = MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{78,-48},{54,-24}})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{136,-36},{102,-10}})));
  Modelica.Blocks.Logical.Switch T_HP_supply
    "Temperature Level of the Heatpump" annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={9,-101})));
  Modelica.Blocks.Logical.Switch T_hp_return
    "Return Temperture of the Water after it flowed through the radiators. (or the showers, although in real life dhw is not a closed loop system)"
                                             annotation (Placement(
        transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={91,-101})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{140,90},{160,110}}),
        iconTransformation(extent={{140,90},{160,110}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{140,50},{160,70}}),
        iconTransformation(extent={{140,50},{160,70}})));
  Modelica.Blocks.Sources.RealExpression Pressure_Drop(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{42,48},{106,72}})));
  Actuators.Valves.TwoWayPressureIndependent val(
  redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05)
    "y is the Position of the Valve. Should be between 0 (closed) and 1 (open)"
    annotation (Placement(transformation(extent={{-160,-10},{-140,10}})));

  Modelica.Blocks.Sources.Constant deltaT_Network(k=dT_Network)
    "Temperature difference between hot and cold pipe. Needed for Mass Flow Control"
                                                       annotation (Placement(
        transformation(
        extent={{12,12},{-12,-12}},
        rotation=180,
        origin={-384,72})));
  Modelica.Blocks.Sources.Constant T_DHW_supply(k=T_dhw_supply)
    "Temperature of the DHW that comes out of showers, sinks etc. Is used to compute the return Temperature"
    annotation (Placement(transformation(
        extent={{12,12},{-12,-12}},
        rotation=180,
        origin={-120,-170})));
  Modelica.Blocks.Math.Division dT_DHW
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-206,-192})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom1(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{-364,-230},{-318,-206}})));
  Modelica.Blocks.Math.Gain cp_dT1(k=cp_default)
    annotation (Placement(transformation(extent={{-298,-228},{-278,-208}})));
  Modelica.Blocks.Math.Add T_dhw_return(k1=-1)
    annotation (Placement(transformation(extent={{-66,-184},{-46,-204}})));
  Modelica.Blocks.Math.Division dT_hot annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-204,-226})));
  Modelica.Blocks.Math.Add T_heat_return(k1=-1)
    annotation (Placement(transformation(extent={{-68,-218},{-48,-238}})));
  Sensors.TemperatureTwoPort senTem_return(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{0,-14},{28,14}})));
  Sensors.TemperatureTwoPort senTem_afterFreeCool(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-72,10},{-52,-10}})));
  Modelica.Blocks.Logical.Switch T_room_supply
    "Supply Temperature needed in the radiators. If active cooling is needed, the HP goes into cooling mode."
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-112,-128})));
  Modelica.Blocks.Sources.RealExpression T_cold_supply(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-196,-128},{-158,-104}})));
  Modelica.Blocks.Sources.RealExpression T_heat_supply(y=273.15 + 35)
    annotation (Placement(transformation(extent={{-196,-154},{-160,-134}})));
  Modelica.Blocks.Logical.Switch DirectCooling annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,70})));
  Modelica.Blocks.Sources.RealExpression Zero(y=0) annotation (Placement(
        transformation(
        extent={{9,-10},{-9,10}},
        rotation=0,
        origin={-101,46})));
  Modelica.Blocks.Logical.Switch sup_is_ret
    "wenn HP aus sein soll, ist T supply gleich T return (dT =0, keine Temperaturerhöhung)"
    annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={17,-39})));
  Modelica.Blocks.Continuous.LimPID pControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.2,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3)      "Pressure controller" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-250,72})));
  Modelica.Blocks.Math.Division dT_cold annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-204,-260})));
  Modelica.Blocks.Logical.Switch T_room_return
    "Supply Temperature needed in the radiators. If active cooling is needed, the HP goes into cooling mode."
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={12,-238})));
  Modelica.Blocks.Math.Add T_cold_return(k1=+1)
    annotation (Placement(transformation(extent={{-62,-250},{-42,-270}})));
  Utilities.Logical.HPReversibleControlLogicHeatColdDHWDirectCoolingV2
                                                                     HP_control
    "control casees of heatpump and direct cooling"
    annotation (Placement(transformation(extent={{-304,-94},{-268,-56}})));
  Modelica.Blocks.Math.Add heat_ret(k1=-1)
    annotation (Placement(transformation(extent={{-346,56},{-326,76}})));
  Modelica.Blocks.Sources.RealExpression Threshold_dc(y=273.15 + 18)
    "Temp above which its too warm for direct cooling+" annotation (Placement(
        transformation(
        extent={{21,-12},{-21,12}},
        rotation=0,
        origin={-253,-36})));
  Modelica.Blocks.Math.Add cold_ret(k1=+1)
    "desired return temperature of the network pipe in cooling mode"
    annotation (Placement(transformation(extent={{-346,24},{-326,44}})));
  Modelica.Blocks.Logical.Switch T_HP_supply1 "return Temp of the Network"
                                        annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=0,
        origin={-289,57})));
  Modelica.Blocks.Math.Add3 total_heat_flow(k1=-1)
    "Determine of the total Heat Flow is positive or negative"
    annotation (Placement(transformation(extent={{-366,-58},{-346,-38}})));
  Modelica.Blocks.Logical.LessThreshold cooling
    "more heat added to the pipe than taken out" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-318,-20})));
equation
  connect(prescribedHeatFlow.port, HX.heatPort)
    annotation (Line(points={{-80,26},{-80,10},{-90,10}},
                                                 color={191,0,0}));
  connect(m_flow_nom.y, HP_Return.m_flow_in) annotation (Line(points={{100.3,
          -23},{90,-23},{90,-26.4},{80.4,-26.4}},
                                             color={0,0,127}));
  connect(T_hp_return.y, HP_Return.T_in) annotation (Line(points={{91,-88.9},{
          91,-31.2},{80.4,-31.2}},
                                color={0,0,127}));
  connect(Pressure_Drop.y, dpOut)
    annotation (Line(points={{109.2,60},{150,60}}, color={0,0,127}));
  connect(senTem_supply.port_b, val.port_a) annotation (Line(points={{-362,
          -1.77636e-15},{-362,0},{-160,0}},                     color={0,127,
          255}));
  connect(heaPum.P, P_el) annotation (Line(points={{-33,-6},{-38,-6},{-38,100},
          {150,100}},               color={0,0,127}));
  connect(heaPum.port_b1, HP_Supply.ports[1]) annotation (Line(points={{-32,-12},
          {-44,-12},{-44,-38},{-56,-38}},  color={0,127,255}));
  connect(HP_Return.ports[1], heaPum.port_a1) annotation (Line(points={{54,-36},
          {42,-36},{42,-12},{-12,-12}},
                                      color={0,127,255}));
  connect(T_HP_supply.u1, T_DHW_supply.y) annotation (Line(points={{17.8,-114.2},
          {17.8,-170},{-106.8,-170}},color={0,0,127}));
  connect(dhw_input, dT_DHW.u1) annotation (Line(points={{-460,-120},{-420,-120},
          {-420,-186},{-218,-186}}, color={0,0,127}));
  connect(m_flow_nom1.y, cp_dT1.u)
    annotation (Line(points={{-315.7,-218},{-300,-218}}, color={0,0,127}));
  connect(cp_dT1.y, dT_DHW.u2) annotation (Line(points={{-277,-218},{-234,-218},
          {-234,-198},{-218,-198}}, color={0,0,127}));
  connect(T_DHW_supply.y, T_dhw_return.u2) annotation (Line(points={{-106.8,-170},
          {-82,-170},{-82,-188},{-68,-188}},  color={0,0,127}));
  connect(dT_DHW.y, T_dhw_return.u1)
    annotation (Line(points={{-195,-192},{-174,-192},{-174,-200},{-68,-200}},
                                                       color={0,0,127}));
  connect(T_dhw_return.y, T_hp_return.u1)
    annotation (Line(points={{-45,-194},{82.2,-194},{82.2,-114.2}},
                                                             color={0,0,127}));
  connect(cp_dT1.y, dT_hot.u2) annotation (Line(points={{-277,-218},{-234,-218},
          {-234,-232},{-216,-232}}, color={0,0,127}));
  connect(heat_input, dT_hot.u1) annotation (Line(points={{-460,-80},{-428,-80},
          {-428,-192},{-230,-192},{-230,-220},{-216,-220}},color={0,0,127}));
  connect(dT_hot.y, T_heat_return.u1) annotation (Line(points={{-193,-226},{-172,
          -226},{-172,-234},{-70,-234}},      color={0,0,127}));
  connect(HX.ports[1], senTem_afterFreeCool.port_a)
    annotation (Line(points={{-98,0},{-72,0}},   color={0,127,255}));
  connect(senTem_return.port_b, del1.ports[1]) annotation (Line(points={{28,
          1.77636e-15},{74,1.77636e-15},{74,0},{93.3333,0}},
                                            color={0,127,255}));
  connect(del1.ports[2], port_b)
    annotation (Line(points={{96,0},{142,0}}, color={0,127,255}));
  connect(senTem_supply.port_a, port_a) annotation (Line(points={{-390,
          -1.77636e-15},{-396,-1.77636e-15},{-396,0},{-440,0}},
                                 color={0,127,255}));
  connect(T_room_supply.y, T_HP_supply.u3) annotation (Line(points={{-101,-128},
          {-50,-128},{-50,-158},{0,-158},{0,-130},{0.2,-130},{0.2,-114.2}},
                                                     color={0,0,127}));
  connect(T_cold_supply.y, T_room_supply.u1) annotation (Line(points={{-156.1,
          -116},{-150,-116},{-150,-120},{-124,-120}},
                                               color={0,0,127}));
  connect(T_heat_supply.y, T_room_supply.u3) annotation (Line(points={{-158.2,
          -144},{-148,-144},{-148,-136},{-124,-136}},
                                               color={0,0,127}));
  connect(T_room_supply.y,T_heat_return. u2) annotation (Line(points={{-101,-128},
          {-90,-128},{-90,-222},{-70,-222}},                          color={0,0,127}));
  connect(DirectCooling.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-89,70},{-80,70},{-80,46}},    color={0,0,127}));
  connect(cold_input, DirectCooling.u1) annotation (Line(points={{-460,-40},{-410,
          -40},{-410,102},{-122,102},{-122,78},{-112,78}},   color={0,0,127}));
  connect(Zero.y, DirectCooling.u3) annotation (Line(points={{-110.9,46},{-118,
          46},{-118,62},{-112,62}},
                               color={0,0,127}));
  connect(senTem_return.port_a, heaPum.port_b2)
    annotation (Line(points={{0,1.77636e-15},{-4,1.77636e-15},{-4,0},{-12,0}},
                                              color={0,127,255}));
  connect(heaPum.port_a2, senTem_afterFreeCool.port_b)
    annotation (Line(points={{-32,0},{-52,0}},  color={0,127,255}));
  connect(T_hp_return.y, sup_is_ret.u1) annotation (Line(points={{91,-88.9},{91,
          -70},{26,-70},{26,-52.2},{25.8,-52.2}}, color={0,0,127}));
  connect(T_HP_supply.y, sup_is_ret.u3) annotation (Line(points={{9,-88.9},{8,
          -88.9},{8,-52.2},{8.2,-52.2}}, color={0,0,127}));
  connect(sup_is_ret.y, heaPum.TSet) annotation (Line(points={{17,-26.9},{16,
          -26.9},{16,-15},{-10,-15}}, color={0,0,127}));
  connect(cp_dT1.y, dT_cold.u2) annotation (Line(points={{-277,-218},{-234,-218},
          {-234,-266},{-216,-266}}, color={0,0,127}));
  connect(cold_input, dT_cold.u1) annotation (Line(points={{-460,-40},{-410,-40},
          {-410,-254},{-216,-254}}, color={0,0,127}));
  connect(T_room_return.y, T_hp_return.u3) annotation (Line(points={{25.2,-238},
          {100,-238},{100,-114.2},{99.8,-114.2}}, color={0,0,127}));
  connect(T_room_supply.y, T_cold_return.u2) annotation (Line(points={{-101,-128},
          {-90,-128},{-90,-254},{-64,-254}},       color={0,0,127}));
  connect(dT_cold.y, T_cold_return.u1) annotation (Line(points={{-193,-260},{-170,
          -260},{-170,-266},{-64,-266}},      color={0,0,127}));
  connect(T_cold_return.y, T_room_return.u3) annotation (Line(points={{-41,-260},
          {-20,-260},{-20,-247.6},{-2.4,-247.6}},  color={0,0,127}));
  connect(T_heat_return.y, T_room_return.u1) annotation (Line(points={{-47,-228},
          {-34,-228},{-34,-228.4},{-2.4,-228.4}},  color={0,0,127}));
  connect(senTem_supply.T, HP_control.supply_Temp) annotation (Line(points={{-376,
          -15.4},{-376,-60.75},{-308,-60.75}},color={0,0,127}));
  connect(cold_input, HP_control.cold_input) annotation (Line(points={{-460,-40},
          {-410,-40},{-410,-70.25},{-308,-70.25}},
                                             color={0,0,127}));
  connect(heat_input, HP_control.heat_input) annotation (Line(points={{-460,-80},
          {-428,-80},{-428,-79.75},{-308,-79.75}},
                                            color={0,0,127}));
  connect(dhw_input, HP_control.dhw_input) annotation (Line(points={{-460,-120},
          {-420,-120},{-420,-89.25},{-308,-89.25}},
                                           color={0,0,127}));
  connect(HP_control.direct_cooling, DirectCooling.u2) annotation (Line(points={{-262.8,
          -60.75},{-124,-60.75},{-124,70},{-112,70}},color={255,0,255}));
  connect(heaPum.is_cooling, HP_control.hp_cooling_mode) annotation (Line(
        points={{-11,-8.2},{-3.5,-8.2},{-3.5,-70.25},{-262.8,-70.25}},
                                                               color={255,0,255}));
  connect(HP_control.hp_off, sup_is_ret.u2) annotation (Line(points={{-262.8,
          -79.75},{16,-79.75},{16,-52.2},{17,-52.2}},
                                           color={255,0,255}));
  connect(HP_control.dhw_now, T_HP_supply.u2) annotation (Line(points={{-262.8,
          -89.25},{-40,-89.25},{-40,-140},{8,-140},{8,-114.2},{9,-114.2}},
                                                                     color={255,
          0,255}));
  connect(HP_control.dhw_now, T_hp_return.u2) annotation (Line(points={{-262.8,
          -89.25},{-40,-89.25},{-40,-140},{90,-140},{90,-114.2},{91,-114.2}},
                                                                        color={
          255,0,255}));
  connect(HP_control.hp_cooling_mode, T_room_supply.u2) annotation (Line(points={{-262.8,
          -70.25},{-234,-70.25},{-234,-128},{-124,-128}}, color={255,0,255}));
  connect(HP_control.hp_cooling_mode, T_room_return.u2) annotation (Line(points={{-262.8,
          -70.25},{-28,-70.25},{-28,-238},{-2.4,-238}},  color={255,0,255}));
  connect(senTem_supply.T, heat_ret.u2) annotation (Line(points={{-376,-15.4},{
          -376,-28},{-398,-28},{-398,28},{-356,28},{-356,60},{-348,60}},
                                                color={0,0,127}));
  connect(deltaT_Network.y, heat_ret.u1)
    annotation (Line(points={{-370.8,72},{-348,72}}, color={0,0,127}));
  connect(del1.ports[3], senTem_return.port_b) annotation (Line(points={{98.6667,
          0},{74,0},{74,1.77636e-15},{28,1.77636e-15}},           color={0,127,
          255}));
  connect(senTem_return.T, pControl.u_m) annotation (Line(points={{14,15.4},{14,
          90},{-250,90},{-250,84}},                   color={0,0,127}));
  connect(Threshold_dc.y, HP_control.threshhold) annotation (Line(points={{-276.1,
          -36},{-300.4,-36},{-300.4,-51.25}}, color={0,0,127}));
  connect(val.port_b, HX.ports[2])
    annotation (Line(points={{-140,0},{-102,0}}, color={0,127,255}));
  connect(deltaT_Network.y, cold_ret.u1) annotation (Line(points={{-370.8,72},{-360,
          72},{-360,40},{-348,40}}, color={0,0,127}));
  connect(senTem_supply.T, cold_ret.u2) annotation (Line(points={{-376,-15.4},{
          -376,-28},{-398,-28},{-398,28},{-348,28}},
                                                color={0,0,127}));
  connect(cold_ret.y, T_HP_supply1.u1) annotation (Line(points={{-325,34},{-310,
          34},{-310,48.2},{-302.2,48.2}}, color={0,0,127}));
  connect(heat_ret.y, T_HP_supply1.u3) annotation (Line(points={{-325,66},{-314,
          66},{-314,65.8},{-302.2,65.8}}, color={0,0,127}));
  connect(T_HP_supply1.y, pControl.u_s) annotation (Line(points={{-276.9,57},{
          -265.45,57},{-265.45,72},{-262,72}},
                                       color={0,0,127}));
  connect(cold_input, total_heat_flow.u1)
    annotation (Line(points={{-460,-40},{-368,-40}}, color={0,0,127}));
  connect(heat_input, total_heat_flow.u2) annotation (Line(points={{-460,-80},{
          -428,-80},{-428,-48},{-368,-48}}, color={0,0,127}));
  connect(dhw_input, total_heat_flow.u3) annotation (Line(points={{-460,-120},{
          -420,-120},{-420,-56},{-368,-56}}, color={0,0,127}));
  connect(total_heat_flow.y, cooling.u) annotation (Line(points={{-345,-48},{
          -318,-48},{-318,-32}}, color={0,0,127}));
  connect(cooling.y, T_HP_supply1.u2) annotation (Line(points={{-318,-9},{-318,
          57},{-302.2,57}}, color={255,0,255}));
  connect(pControl.y, val.y)
    annotation (Line(points={{-239,72},{-150,72},{-150,12}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
            -280},{140,120}}),
                         graphics={
        Rectangle(
          extent={{-440,120},{140,-280}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-292,-32},{-20,-238}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-292,-32},{-168,78},{-20,-32},{-292,-32}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-240,-60},{-194,-114}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-174,-164},{-134,-238}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-128,-62},{-80,-118}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),      Text(
          extent={{-440,180},{140,120}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-440,-280},{140,
            120}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>August 09, 2018</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Substation model for bidirctional low-temperature networks for
  buildings with heat pump and chiller. In the case of simultaneous
  cooling and heating demands, the return flows are used as supply
  flows for the other application. The mass flows are controlled
  equation-based. The mass flows are calculated using the heating and
  cooling demands and the specified temperature differences between
  flow and return (network side).
</p>
</html>"));
end ValveControlledHeatPumpDirectCoolingDHWnoStorageTempControl;
