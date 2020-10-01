within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP_v4_ze_jonas_new_cooling_control_V2
  "Substation model for  low-temperature networks for buildings with heat pump and chiller, modified by jgr"

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

    parameter Modelica.SIunits.Pressure dp_nominal=400000
    "nominal pressure drop";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=(heatDemand_max)/cp_default/dT_Network
    "Nominal mass flow rate of the Network Pipe";

    parameter Modelica.SIunits.TemperatureDifference dT_Network(displayUnit="K")
    "Design temperature difference between hot and cold pipe";

    parameter Modelica.SIunits.Temperature T_dhw_supply(displayUnit="°C")
    "Temperature of the DHW that comes out of showers, sinks etc. Is used to compute the return Temperature";

public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-350,-10},{-330,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{130,-10},{150,10}}),
        iconTransformation(extent={{130,-10},{150,10}})));

  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-374,18},{-334,58}}),     iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation in Watt. Values are positive or 0."
                                                 annotation (Placement(
        transformation(extent={{-384,-186},{-344,-146}}), iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-380,70},{-340,110}}),    iconTransformation(
          extent={{232,76},{192,116}})));

  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=60,
    m_flow_nominal=m_flow_nominal,
    T_start=283.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{78,0},{98,20}})));

  Sensors.TemperatureTwoPort senTem_supply(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-322,14},{-294,-14}})));
  MixingVolumes.MixingVolume HX(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    V=0.15,
    nPorts=2)
            "Heat Exchanger Volume for direct cooling"
    annotation (Placement(transformation(extent={{-148,0},{-168,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-140,32})));
  HeatPumps.Carnot_TCon_RE_Jonas
                           heaPum(
    redeclare package Medium2 = Medium,
    redeclare package Medium1 = MediumBuilding,
    show_T=true,
    dTEva_nominal=-10,
    dTCon_nominal=10,
    use_eta_Carnot_nominal=true,
    etaCarnot_nominal=0.5,
    Q_heating_nominal=heatDemand_max,
    dp1_nominal=30000,
    dp2_nominal=30000,
    m2_flow_nominal=1,
    m1_flow_nominal=m_flow_nominal,
    Q_cooling_nominal=-15000,
    TEva_nominal=283.15)
    annotation (Placement(transformation(extent={{-12,4},{-32,-16}})));
  Sources.Boundary_pT HP_Supply(redeclare package Medium = MediumBuilding,
      nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-68})));
  Sources.MassFlowSource_T HP_Return(
    redeclare package Medium = MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{76,-56},{52,-32}})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{132,-54},{98,-28}})));
  Modelica.Blocks.Logical.Switch T_HP_supply
    "Temperature Level of the Heatpump" annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={25,-73})));
  Modelica.Blocks.Logical.Switch T_hp_return
    "Return Temperture of the Water after it flowed through the radiators. (or the showers, although in real life dhw is not a closed loop system)"
                                             annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={88,-120})));
  Modelica.Blocks.Logical.GreaterThreshold dhw_now(threshold=10)
    "if theres a DHW demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-310,-152},{-290,-132}})));
  Modelica.Blocks.Logical.GreaterThreshold no_free_cool(threshold=273.15 + 18)
    "If the Temperature of the Network Pipe is above the Threshhold, the Temeprature is too high for direct cooling"
    annotation (Placement(transformation(
        extent={{11,-11},{-11,11}},
        rotation=180,
        origin={-289,-37})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{138,52},{158,72}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{136,30},{156,50}})));
  Modelica.Blocks.Sources.RealExpression Pressure_Drop(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{48,28},{112,52}})));
  Actuators.Valves.TwoWayPressureIndependent val(
  redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05)
    "y is the Position of the Valve. Should be between 0 (closed) and 1 (open)"
    annotation (Placement(transformation(extent={{-238,-10},{-218,10}})));

  Modelica.Blocks.Math.Gain cp_dT(k=cp_default)
    annotation (Placement(transformation(extent={{-260,34},{-240,54}})));
  Modelica.Blocks.Math.Division m_flow
    "Computes the mass flow that is necessary to supply the chosen demand at the current Temperature Difference "
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-218,76})));
  Modelica.Blocks.Math.Gain Val_Position(k=1/m_flow_nominal)
    "Valve Position between 0...1 where 1 is the nominal mass flow through the valve"
    annotation (Placement(transformation(
        extent={{-13,-13},{13,13}},
        rotation=270,
        origin={-193,31})));
  Utilities.Math.SmoothMax smoothMax(deltaX=0.001) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-192,60})));
  Modelica.Blocks.Sources.RealExpression m_flow_min(y=0.002)
    "Minimum Mass Flow through Valve (Bypass)"
    annotation (Placement(transformation(extent={{-154,70},{-172,90}})));
  Modelica.Blocks.Math.Max maxDemand
    "Takes the Maximum of the Heat, Cold and DHW Demand"
    annotation (Placement(transformation(extent={{-290,68},{-270,88}})));
  Modelica.Blocks.Sources.Constant deltaT_Network(k=dT_Network)
    "Temperature difference between hot and cold pipe. Needed for Mass Flow Control"
                                                       annotation (Placement(
        transformation(
        extent={{12,12},{-12,-12}},
        rotation=180,
        origin={-290,44})));
  Modelica.Blocks.Sources.Constant T_DHW_supply(k=T_dhw_supply)
    "Temperature of the DHW that comes out of showers, sinks etc. Is used to compute the return Temperature"
    annotation (Placement(transformation(
        extent={{12,12},{-12,-12}},
        rotation=180,
        origin={-258,-164})));
  Modelica.Blocks.Math.Division dT_DHW
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-206,-192})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom1(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{-332,-230},{-286,-206}})));
  Modelica.Blocks.Math.Gain cp_dT1(k=cp_default)
    annotation (Placement(transformation(extent={{-266,-228},{-246,-208}})));
  Modelica.Blocks.Math.Add T_dhw_return(k1=-1)
    annotation (Placement(transformation(extent={{-160,-176},{-140,-196}})));
  Modelica.Blocks.Math.Division dT_Room
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-206,-226})));
  Modelica.Blocks.Math.Add T_room_return(k1=-1)
    annotation (Placement(transformation(extent={{-94,-210},{-74,-230}})));
  Sensors.TemperatureTwoPort senTem_return(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{36,14},{64,-14}})));
  Sensors.TemperatureTwoPort senTem_afterFreeCool(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-134,14},{-106,-14}})));
  Modelica.Blocks.Math.Add sub_P_HP(k2=-1)
    "The demand series is Q_con of the HP. The network though is connected to the Evaporador, and only extracts Q_eva. The Rest is supplied by the electrical Power of the HP. Therefore, we subtract P_el_HP"
    annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-246,82})));
  Modelica.Blocks.Math.Max maxDemand1
    "Takes the Maximum of the Heat and Cold Demand"
    annotation (Placement(transformation(extent={{-320,74},{-300,94}})));
  Modelica.Blocks.Logical.GreaterThreshold cold_now(threshold=10)
    "if theres a cold demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-308,-108},{-292,-92}})));
  Modelica.Blocks.Logical.And active_cooling
    "If theres a cold demand but the temperature is too high for free cooling, active cooling occurs"
    annotation (Placement(transformation(extent={{-254,-102},{-236,-84}})));
  Modelica.Blocks.Logical.Not no_dhw_now
    annotation (Placement(transformation(extent={{-274,-132},{-254,-112}})));
  Modelica.Blocks.Logical.And active_cooling_and_no_dhw
    "If theres a cold demand but the temperature is too high for free cooling, active cooling occur, as long as the HP doesnt have to supply a dhw demands"
    annotation (Placement(transformation(extent={{-206,-124},{-186,-104}})));
  Modelica.Blocks.Logical.Switch T_room_supply
    "Supply Temperature needed in the radiators. If active cooling is needed, the HP goes into cooling mode."
                                               annotation (Placement(
        transformation(
        extent={{-11,-11},{11,11}},
        rotation=0,
        origin={-117,-93})));
  Modelica.Blocks.Sources.RealExpression T_cold_supply(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-180,-96},{-142,-72}})));
  Modelica.Blocks.Sources.RealExpression T_heat_supply(y=273.15 + 35)
    annotation (Placement(transformation(extent={{-178,-140},{-142,-120}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal
                                         teeJunctionIdeal1(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-98,-10},{-78,10}})));
  Modelica.Fluid.Fittings.TeeJunctionIdeal
                                         teeJunctionIdeal2(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{22,-10},{2,10}})));
  Modelica.Fluid.Valves.ValveDiscrete        valveDiscrete1(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    dp_start(displayUnit="Pa") = 100,
    m_flow_small=0.00001,
    dp_nominal(displayUnit="Pa") = 100,
    m_flow_nominal=m_flow_nominal,
    opening_min=0)
    "y is the Position of the Valve. Should be between 0 (closed) and 1 (open)"
    annotation (Placement(transformation(extent={{-80,34},{-64,18}})));
  Modelica.Fluid.Valves.ValveDiscrete        valveDiscrete2(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    dp_start(displayUnit="Pa") = 100,
    m_flow_small=0.00001,
    dp_nominal(displayUnit="Pa") = 100,
    m_flow_nominal=m_flow_nominal)
    "y is the Position of the Valve. Should be between 0 (closed) and 1 (open)"
    annotation (Placement(transformation(extent={{-62,8},{-46,-8}})));
  Modelica.Blocks.Logical.Not free_cool
    annotation (Placement(transformation(extent={{-258,-46},{-240,-28}})));
  Modelica.Blocks.Logical.And hp_off
    "If theres a cold demand and the temperature is low enough for free cooling, the HP can be bypassed, as long as the HP doesnt have to supply a dhw demands"
    annotation (Placement(transformation(extent={{-220,-72},{-202,-54}})));
  Modelica.Blocks.Logical.Not hp_on
    annotation (Placement(transformation(extent={{-152,-54},{-134,-36}})));
  Modelica.Blocks.Logical.Switch DirectCooling annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-120,68})));
  Modelica.Blocks.Sources.RealExpression Zero(y=0) annotation (Placement(
        transformation(
        extent={{9,-10},{-9,10}},
        rotation=0,
        origin={-71,60})));
  Modelica.Blocks.Logical.Switch hp_dt0 "Temperature Level of the Heatpump"
    annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={17,-35})));
equation
  connect(prescribedHeatFlow.port, HX.heatPort)
    annotation (Line(points={{-140,22},{-140,10},{-148,10}},
                                                 color={191,0,0}));
  connect(m_flow_nom.y, HP_Return.m_flow_in) annotation (Line(points={{96.3,-41},
          {90,-41},{90,-34.4},{78.4,-34.4}}, color={0,0,127}));
  connect(T_hp_return.y, HP_Return.T_in) annotation (Line(points={{88,-109},{88,
          -39.2},{78.4,-39.2}}, color={0,0,127}));
  connect(dhw_now.y,T_HP_supply. u2) annotation (Line(points={{-289,-142},{25,
          -142},{25,-86.2}},  color={255,0,255}));
  connect(dhw_now.y, T_hp_return.u2) annotation (Line(points={{-289,-142},{88,
          -142},{88,-132}},color={255,0,255}));
  connect(senTem_supply.T, no_free_cool.u) annotation (Line(points={{-308,-15.4},
          {-308,-37},{-302.2,-37}}, color={0,0,127}));
  connect(Pressure_Drop.y, dpOut)
    annotation (Line(points={{115.2,40},{146,40}}, color={0,0,127}));
  connect(senTem_supply.port_b, val.port_a) annotation (Line(points={{-294,
          -1.77636e-15},{-248,-1.77636e-15},{-248,0},{-238,0}}, color={0,127,
          255}));
  connect(cp_dT.y, m_flow.u2)
    annotation (Line(points={{-239,44},{-234,44},{-234,70},{-230,70}},
                                                             color={0,0,127}));
  connect(Val_Position.u, smoothMax.y)
    annotation (Line(points={{-193,46.6},{-193,48},{-192,48},{-192,49}},
                                                       color={0,0,127}));
  connect(m_flow.y, smoothMax.u2) annotation (Line(points={{-207,76},{-198,76},{
          -198,72}},                             color={0,0,127}));
  connect(Val_Position.y, val.y)
    annotation (Line(points={{-193,16.7},{-193,14},{-228,14},{-228,12}},
                                                     color={0,0,127}));
  connect(m_flow_min.y, smoothMax.u1) annotation (Line(points={{-172.9,80},{
          -186,80},{-186,72}}, color={0,0,127}));
  connect(heaPum.P, P_el) annotation (Line(points={{-33,-6},{-38,-6},{-38,62},{
          148,62}},                 color={0,0,127}));
  connect(dhw_input, dhw_now.u)
    annotation (Line(points={{-364,-166},{-316,-166},{-316,-142},{-312,-142}},
                                                       color={0,0,127}));
  connect(heaPum.port_b1, HP_Supply.ports[1]) annotation (Line(points={{-32,-12},
          {-40,-12},{-40,-58}},            color={0,127,255}));
  connect(HP_Return.ports[1], heaPum.port_a1) annotation (Line(points={{52,-44},
          {42,-44},{42,-12},{-12,-12}},
                                      color={0,127,255}));
  connect(deltaT_Network.y, cp_dT.u)
    annotation (Line(points={{-276.8,44},{-262,44}}, color={0,0,127}));
  connect(T_HP_supply.u1, T_DHW_supply.y) annotation (Line(points={{33.8,-86.2},
          {33.8,-164},{-244.8,-164}},color={0,0,127}));
  connect(dhw_input, dT_DHW.u1) annotation (Line(points={{-364,-166},{-306,-166},
          {-306,-186},{-218,-186}}, color={0,0,127}));
  connect(m_flow_nom1.y, cp_dT1.u)
    annotation (Line(points={{-283.7,-218},{-268,-218}}, color={0,0,127}));
  connect(cp_dT1.y, dT_DHW.u2) annotation (Line(points={{-245,-218},{-236,-218},
          {-236,-198},{-218,-198}}, color={0,0,127}));
  connect(T_DHW_supply.y, T_dhw_return.u2) annotation (Line(points={{-244.8,
          -164},{-184,-164},{-184,-180},{-162,-180}},
                                              color={0,0,127}));
  connect(dT_DHW.y, T_dhw_return.u1)
    annotation (Line(points={{-195,-192},{-162,-192}}, color={0,0,127}));
  connect(T_dhw_return.y, T_hp_return.u1)
    annotation (Line(points={{-139,-186},{80,-186},{80,-132}},
                                                             color={0,0,127}));
  connect(cp_dT1.y,dT_Room. u2) annotation (Line(points={{-245,-218},{-236,-218},
          {-236,-232},{-218,-232}}, color={0,0,127}));
  connect(heat_input,dT_Room. u1) annotation (Line(points={{-354,38},{-326,38},
          {-326,-194},{-228,-194},{-228,-220},{-218,-220}}, color={0,0,127}));
  connect(dT_Room.y,T_room_return. u1) annotation (Line(points={{-195,-226},{
          -96,-226}},                          color={0,0,127}));
  connect(T_room_return.y, T_hp_return.u3) annotation (Line(points={{-73,-220},
          {96,-220},{96,-132}},color={0,0,127}));
  connect(val.port_b, HX.ports[1])
    annotation (Line(points={{-218,0},{-156,0}}, color={0,127,255}));
  connect(HX.ports[2], senTem_afterFreeCool.port_a)
    annotation (Line(points={{-160,0},{-142,0},{-142,-1.77636e-15},{-134,
          -1.77636e-15}},                        color={0,127,255}));
  connect(senTem_return.port_b, del1.ports[1]) annotation (Line(points={{64,0},{
          86,0}},                           color={0,127,255}));
  connect(del1.ports[2], port_b)
    annotation (Line(points={{90,0},{140,0}}, color={0,127,255}));
  connect(senTem_supply.port_a, port_a) annotation (Line(points={{-322,
          -1.77636e-15},{-326,-1.77636e-15},{-326,0},{-340,0}},
                                 color={0,127,255}));
  connect(heaPum.P, sub_P_HP.u2) annotation (Line(points={{-33,-6},{-38,-6},{
          -38,62},{6,62},{6,96},{-264,96},{-264,86.8},{-255.6,86.8}}, color={0,
          0,127}));
  connect(maxDemand.y, sub_P_HP.u1) annotation (Line(points={{-269,78},{-255.6,
          78},{-255.6,77.2}}, color={0,0,127}));
  connect(sub_P_HP.y, m_flow.u1)
    annotation (Line(points={{-237.2,82},{-230,82}}, color={0,0,127}));
  connect(cold_input, maxDemand1.u1)
    annotation (Line(points={{-360,90},{-322,90}}, color={0,0,127}));
  connect(heat_input, maxDemand1.u2) annotation (Line(points={{-354,38},{-328,
          38},{-328,78},{-322,78}}, color={0,0,127}));
  connect(dhw_input, maxDemand.u2) annotation (Line(points={{-364,-166},{-316,
          -166},{-316,72},{-292,72}}, color={0,0,127}));
  connect(maxDemand1.y, maxDemand.u1)
    annotation (Line(points={{-299,84},{-292,84}}, color={0,0,127}));
  connect(cold_input, cold_now.u) annotation (Line(points={{-360,90},{-334,90},
          {-334,-100},{-309.6,-100}},
                                    color={0,0,127}));
  connect(cold_now.y, active_cooling.u2) annotation (Line(points={{-291.2,-100},
          {-262,-100},{-262,-100.2},{-255.8,-100.2}},
                                                   color={255,0,255}));
  connect(no_free_cool.y, active_cooling.u1) annotation (Line(points={{-276.9,
          -37},{-276.9,-36},{-266,-36},{-266,-93},{-255.8,-93}}, color={255,0,
          255}));
  connect(dhw_now.y, no_dhw_now.u) annotation (Line(points={{-289,-142},{-284,
          -142},{-284,-122},{-276,-122}}, color={255,0,255}));
  connect(active_cooling.y, active_cooling_and_no_dhw.u1) annotation (Line(
        points={{-235.1,-93},{-214,-93},{-214,-114},{-208,-114}},
                  color={255,0,255}));
  connect(no_dhw_now.y, active_cooling_and_no_dhw.u2)
    annotation (Line(points={{-253,-122},{-208,-122}}, color={255,0,255}));
  connect(active_cooling_and_no_dhw.y, heaPum.is_cooling) annotation (Line(
        points={{-185,-114},{-6,-114},{-6,-8.2},{-11,-8.2}},   color={255,0,255}));
  connect(T_room_supply.y, T_HP_supply.u3) annotation (Line(points={{-104.9,-93},
          {16,-93},{16,-92},{16.2,-92},{16.2,-86.2}},color={0,0,127}));
  connect(T_cold_supply.y, T_room_supply.u1) annotation (Line(points={{-140.1,
          -84},{-130.2,-84},{-130.2,-84.2}},   color={0,0,127}));
  connect(T_heat_supply.y, T_room_supply.u3) annotation (Line(points={{-140.2,
          -130},{-132,-130},{-132,-101.8},{-130.2,-101.8}},
                                               color={0,0,127}));
  connect(senTem_afterFreeCool.port_b, teeJunctionIdeal1.port_1)
    annotation (Line(points={{-106,0},{-98,0}}, color={0,127,255}));
  connect(heaPum.port_b2, teeJunctionIdeal2.port_2)
    annotation (Line(points={{-12,0},{2,0}}, color={0,127,255}));
  connect(teeJunctionIdeal1.port_3, valveDiscrete1.port_a)
    annotation (Line(points={{-88,10},{-88,26},{-80,26}}, color={0,127,255}));
  connect(heaPum.port_a2, valveDiscrete2.port_b)
    annotation (Line(points={{-32,0},{-46,0}}, color={0,127,255}));
  connect(valveDiscrete2.port_a, teeJunctionIdeal1.port_2)
    annotation (Line(points={{-62,0},{-78,0}}, color={0,127,255}));
  connect(active_cooling.y, T_room_supply.u2) annotation (Line(points={{-235.1,
          -93},{-130.2,-93}},                          color={255,0,255}));
  connect(no_free_cool.y, free_cool.u) annotation (Line(points={{-276.9,-37},{
          -259.8,-37}},                             color={255,0,255}));
  connect(no_dhw_now.y, hp_off.u2) annotation (Line(points={{-253,-122},{-228,
          -122},{-228,-70.2},{-221.8,-70.2}}, color={255,0,255}));
  connect(free_cool.y, hp_off.u1) annotation (Line(points={{-239.1,-37},{-230,
          -37},{-230,-63},{-221.8,-63}}, color={255,0,255}));
  connect(T_room_supply.y, T_room_return.u2) annotation (Line(points={{-104.9,
          -93},{-102,-93},{-102,-214},{-96,-214}},                    color={0,0,127}));
  connect(valveDiscrete1.port_b, teeJunctionIdeal2.port_3)
    annotation (Line(points={{-64,26},{12,26},{12,10}}, color={0,127,255}));
  connect(teeJunctionIdeal2.port_1, senTem_return.port_a) annotation (Line(
        points={{22,0},{30,0},{30,-1.77636e-15},{36,-1.77636e-15}}, color={0,
          127,255}));
  connect(hp_off.y, valveDiscrete1.open) annotation (Line(points={{-201.1,-63},
          {-72,-63},{-72,19.6}}, color={255,0,255}));
  connect(hp_off.y, hp_on.u) annotation (Line(points={{-201.1,-63},{-177.55,-63},
          {-177.55,-45},{-153.8,-45}}, color={255,0,255}));
  connect(hp_on.y, valveDiscrete2.open) annotation (Line(points={{-133.1,-45},{
          -54.55,-45},{-54.55,-6.4},{-54,-6.4}}, color={255,0,255}));
  connect(DirectCooling.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-131,68},{-140,68},{-140,42}}, color={0,0,127}));
  connect(free_cool.y, DirectCooling.u2) annotation (Line(points={{-239.1,-37},
          {-230,-37},{-230,-22},{-94,-22},{-94,68},{-108,68}}, color={255,0,255}));
  connect(cold_input, DirectCooling.u1) annotation (Line(points={{-360,90},{
          -334,90},{-334,108},{-82,108},{-82,76},{-108,76}}, color={0,0,127}));
  connect(Zero.y, DirectCooling.u3) annotation (Line(points={{-80.9,60},{-94,60},
          {-94,60},{-108,60}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,
            -240},{140,120}}),
                         graphics={
        Rectangle(
          extent={{-260,160},{220,-180}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-154,32},{118,-174}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-154,32},{-30,142},{118,32},{-154,32}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-102,4},{-56,-50}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,-100},{4,-174}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,2},{58,-54}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-340,-240},{140,
            120}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br>Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end PumpControlledwithHP_v4_ze_jonas_new_cooling_control_V2;
