within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlledHeatPumpDirectCoolingDHWnoStorage
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

    parameter Modelica.SIunits.MassFlowRate m_flow_min(displayUnit="kg/s")
    "Minimum Mass flow through the valve";

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
    annotation (Placement(transformation(extent={{90,-12},{110,8}}),
        iconTransformation(extent={{90,-12},{110,8}})));
  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-480,50},{-440,90}}),     iconTransformation(
          extent={{-480,100},{-440,140}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation in Watt. Values are positive or 0."
                                                 annotation (Placement(
        transformation(extent={{-480,20},{-440,60}}),     iconTransformation(
          extent={{-480,20},{-440,60}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-480,80},{-440,120}}),    iconTransformation(
          extent={{-480,60},{-440,100}})));
  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=60,
    m_flow_nominal=m_flow_nominal,
    T_start=283.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{56,0},{76,20}})));
  Sensors.TemperatureTwoPort senTem_supply(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-400,14},{-372,-14}})));
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
        origin={-84,36})));
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
    m2_flow_nominal=m_flow_nominal,
    m1_flow_nominal=m_flow_nominal,
    Q_cooling_nominal=-coldDemand_max,
    TEva_nominal=283.15)
    annotation (Placement(transformation(extent={{-12,4},{-32,-16}})));
  Sources.Boundary_pT HP_Supply(redeclare package Medium = MediumBuilding,
      nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-66,-32})));
  Sources.MassFlowSource_T HP_Return(
    redeclare package Medium = MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{78,-48},{54,-24}})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{44,-72},{78,-46}})));
  Modelica.Blocks.Logical.Switch T_HP_supply
    "Temperature Level of the Heatpump" annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={9,-89})));
  Modelica.Blocks.Logical.Switch T_hp_return
    "Return Temperture of the Water after it flowed through the radiators. (or the showers, although in real life dhw is not a closed loop system)"
                                             annotation (Placement(
        transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={89,-95})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{100,90},{120,110}}),
        iconTransformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{100,50},{120,70}}),
        iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Sources.RealExpression Pressure_Drop(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{2,48},{66,72}})));
  Actuators.Valves.TwoWayPressureIndependent val(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05)
    "y is the Position of the Valve. Should be between 0 (closed) and 1 (open)"
    annotation (Placement(transformation(extent={{-242,-10},{-222,10}})));
  Modelica.Blocks.Math.Gain cp_dT(k=cp_default)
    annotation (Placement(transformation(extent={{-262,34},{-242,54}})));
  Modelica.Blocks.Math.Division m_flow
    "Computes the mass flow that is necessary to supply the chosen demand at the current Temperature Difference "
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-218,76})));
  Utilities.Math.SmoothMax smoothMax(deltaX=0.001) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-192,60})));
  Modelica.Blocks.Sources.Constant deltaT_Network(k=dT_Network)
    "Temperature difference between hot and cold pipe. Needed for Mass Flow Control"
                                                       annotation (Placement(
        transformation(
        extent={{12,12},{-12,-12}},
        rotation=180,
        origin={-300,40})));
  Modelica.Blocks.Sources.Constant T_DHW_supply(k=T_dhw_supply)
    "Temperature of the DHW that comes out of showers, sinks etc. Is used to compute the return Temperature"
    annotation (Placement(transformation(
        extent={{12,12},{-12,-12}},
        rotation=180,
        origin={-152,-196})));
  Modelica.Blocks.Math.Division dT_DHW
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,-220})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom1(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{-378,-164},{-332,-140}})));
  Modelica.Blocks.Math.Gain cp_dT1(k=cp_default)
    annotation (Placement(transformation(extent={{-308,-162},{-288,-142}})));
  Modelica.Blocks.Math.Add T_dhw_return(k1=-1)
    annotation (Placement(transformation(extent={{-58,-204},{-38,-224}})));
  Modelica.Blocks.Math.Division dT_hot annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,-176})));
  Modelica.Blocks.Math.Add T_heat_return(k1=-1)
    annotation (Placement(transformation(extent={{-58,-160},{-38,-180}})));
  Sensors.TemperatureTwoPort senTem_return(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{16,14},{44,-14}})));
  Sensors.TemperatureTwoPort senTem_afterFreeCool(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-72,10},{-52,-10}})));
  Modelica.Blocks.Math.Add sub_P_HP(k2=-1)
    "The demand series is Q_con of the HP. The network though is connected to the Evaporador, and only extracts Q_eva. The Rest is supplied by the electrical Power of the HP. Therefore, we subtract P_el_HP"
    annotation (Placement(transformation(
        extent={{9,-9},{-9,9}},
        rotation=180,
        origin={-247,83})));
  Modelica.Blocks.Logical.Switch T_room_supply
    "Supply Temperature needed in the radiators. If active cooling is needed, the HP goes into cooling mode."
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-110})));
  Modelica.Blocks.Sources.RealExpression T_cold_supply(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-180,-100},{-140,-80}})));
  Modelica.Blocks.Sources.RealExpression T_heat_supply(y=273.15 + 35)
    annotation (Placement(transformation(extent={{-180,-142},{-140,-122}})));
  Modelica.Blocks.Logical.Switch DirectCooling annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-98,72})));
  Modelica.Blocks.Sources.RealExpression Zero(y=0) annotation (Placement(
        transformation(
        extent={{9,-10},{-9,10}},
        rotation=0,
        origin={-101,48})));
  Modelica.Blocks.Logical.Switch sup_is_ret
    "wenn HP aus sein soll, ist T supply gleich T return (dT =0, keine Temperaturerhöhung)"
    annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={17,-35})));
  Modelica.Blocks.Continuous.LimPID pControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.02,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3)      "Pressure controller" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-210,30})));
  Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-204,-10},{-184,10}})));
  Modelica.Blocks.Math.Division dT_cold annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,-140})));
  Modelica.Blocks.Logical.Switch T_room_return
    "Return Temperature needed in the radiators"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-4,-160})));
  Modelica.Blocks.Math.Add T_cold_return(k1=+1)
    annotation (Placement(transformation(extent={{-60,-124},{-40,-144}})));
  Utilities.Logical.HPReversibleControlLogicHeatColdDHWDirectCoolingV2
                                                                     HP_control
    "control casees of heatpump and direct cooling"
    annotation (Placement(transformation(extent={{-340,-66},{-300,-36}})));
  Modelica.Blocks.Sources.RealExpression Threshold_dc(y=273.15 + 18)
    "Temp above which its too warm for direct cooling+" annotation (Placement(
        transformation(
        extent={{21,-12},{-21,12}},
        rotation=0,
        origin={-301,-18})));
  Modelica.Blocks.Sources.Constant Bypass(k=m_flow_min) "Bypass Mass Flow Rate"
    annotation (Placement(transformation(
        extent={{-12,12},{12,-12}},
        rotation=180,
        origin={-160,80})));
  Modelica.Blocks.Logical.Switch m_hc_dhw annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-300,78})));
  Modelica.Blocks.Logical.Switch m_hc annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-342,88})));
equation
  connect(prescribedHeatFlow.port,HX. heatPort)
    annotation (Line(points={{-84,26},{-84,10},{-90,10}},
                                                 color={191,0,0}));
  connect(m_flow_nom.y,HP_Return. m_flow_in) annotation (Line(points={{79.7,-59},
          {88,-59},{88,-58},{96,-58},{96,-26.4},{80.4,-26.4}},
                                             color={0,0,127}));
  connect(T_hp_return.y,HP_Return. T_in) annotation (Line(points={{89,-82.9},{
          89,-31.2},{80.4,-31.2}},
                                color={0,0,127}));
  connect(Pressure_Drop.y,dpOut)
    annotation (Line(points={{69.2,60},{110,60}},  color={0,0,127}));
  connect(senTem_supply.port_b,val. port_a) annotation (Line(points={{-372,
          -1.77636e-15},{-248,-1.77636e-15},{-248,0},{-242,0}}, color={0,127,
          255}));
  connect(cp_dT.y,m_flow. u2)
    annotation (Line(points={{-241,44},{-234,44},{-234,70},{-230,70}},
                                                             color={0,0,127}));
  connect(m_flow.y,smoothMax. u2) annotation (Line(points={{-207,76},{-198,76},{
          -198,72}},                             color={0,0,127}));
  connect(heaPum.P,P_el)  annotation (Line(points={{-33,-6},{-40,-6},{-40,100},
          {110,100}},               color={0,0,127}));
  connect(heaPum.port_b1,HP_Supply. ports[1]) annotation (Line(points={{-32,-12},
          {-44,-12},{-44,-32},{-56,-32}},  color={0,127,255}));
  connect(HP_Return.ports[1],heaPum. port_a1) annotation (Line(points={{54,-36},
          {42,-36},{42,-12},{-12,-12}},
                                      color={0,127,255}));
  connect(deltaT_Network.y,cp_dT. u)
    annotation (Line(points={{-286.8,40},{-276,40},{-276,44},{-264,44}},
                                                     color={0,0,127}));
  connect(T_HP_supply.u1,T_DHW_supply. y) annotation (Line(points={{17.8,-102.2},
          {17.8,-196},{-138.8,-196}},color={0,0,127}));
  connect(dhw_input,dT_DHW. u1) annotation (Line(points={{-460,40},{-420,40},{
          -420,-214},{-222,-214}},  color={0,0,127}));
  connect(m_flow_nom1.y,cp_dT1. u)
    annotation (Line(points={{-329.7,-152},{-310,-152}}, color={0,0,127}));
  connect(cp_dT1.y,dT_DHW. u2) annotation (Line(points={{-287,-152},{-234,-152},
          {-234,-226},{-222,-226}}, color={0,0,127}));
  connect(T_DHW_supply.y,T_dhw_return. u2) annotation (Line(points={{-138.8,
          -196},{-82,-196},{-82,-208},{-60,-208}},
                                              color={0,0,127}));
  connect(dT_DHW.y,T_dhw_return. u1)
    annotation (Line(points={{-199,-220},{-60,-220}},  color={0,0,127}));
  connect(T_dhw_return.y,T_hp_return. u1)
    annotation (Line(points={{-37,-214},{97.8,-214},{97.8,-108.2}},
                                                             color={0,0,127}));
  connect(cp_dT1.y,dT_hot. u2) annotation (Line(points={{-287,-152},{-234,-152},
          {-234,-182},{-222,-182}}, color={0,0,127}));
  connect(heat_input,dT_hot. u1) annotation (Line(points={{-460,70},{-426,70},{
          -426,-170},{-222,-170}},                         color={0,0,127}));
  connect(dT_hot.y,T_heat_return. u1) annotation (Line(points={{-199,-176},{-60,
          -176}},                             color={0,0,127}));
  connect(HX.ports[1],senTem_afterFreeCool. port_a)
    annotation (Line(points={{-98,0},{-72,0}},   color={0,127,255}));
  connect(senTem_return.port_b,del1. ports[1]) annotation (Line(points={{44,
          -1.77636e-15},{74,-1.77636e-15},{74,0},{64,0}},
                                            color={0,127,255}));
  connect(del1.ports[2],port_b)
    annotation (Line(points={{68,0},{100,0},{100,-2}},
                                              color={0,127,255}));
  connect(senTem_supply.port_a,port_a)  annotation (Line(points={{-400,
          -1.77636e-15},{-396,-1.77636e-15},{-396,0},{-440,0}},
                                 color={0,127,255}));
  connect(heaPum.P,sub_P_HP. u2) annotation (Line(points={{-33,-6},{-40,-6},{
          -40,100},{-264,100},{-264,88.4},{-257.8,88.4}},             color={0,
          0,127}));
  connect(sub_P_HP.y,m_flow. u1)
    annotation (Line(points={{-237.1,83},{-234,83},{-234,82},{-230,82}},
                                                     color={0,0,127}));
  connect(T_room_supply.y,T_HP_supply. u3) annotation (Line(points={{-99,-110},
          {0.2,-110},{0.2,-102.2}},                  color={0,0,127}));
  connect(T_cold_supply.y,T_room_supply. u1) annotation (Line(points={{-138,-90},
          {-132,-90},{-132,-102},{-122,-102}}, color={0,0,127}));
  connect(T_heat_supply.y,T_room_supply. u3) annotation (Line(points={{-138,
          -132},{-132,-132},{-132,-118},{-122,-118}},
                                               color={0,0,127}));
  connect(T_room_supply.y,T_heat_return. u2) annotation (Line(points={{-99,-110},
          {-90,-110},{-90,-164},{-60,-164}},                          color={0,0,127}));
  connect(DirectCooling.y,prescribedHeatFlow. Q_flow)
    annotation (Line(points={{-87,72},{-84,72},{-84,46}},    color={0,0,127}));
  connect(cold_input,DirectCooling. u1) annotation (Line(points={{-460,100},{
          -410,100},{-410,106},{-124,106},{-124,80},{-110,80}},
                                                             color={0,0,127}));
  connect(Zero.y,DirectCooling. u3) annotation (Line(points={{-110.9,48},{-120,
          48},{-120,64},{-110,64}},
                               color={0,0,127}));
  connect(senTem_return.port_a,heaPum. port_b2)
    annotation (Line(points={{16,-1.77636e-15},{4,-1.77636e-15},{4,0},{-12,0}},
                                              color={0,127,255}));
  connect(heaPum.port_a2,senTem_afterFreeCool. port_b)
    annotation (Line(points={{-32,0},{-52,0}},  color={0,127,255}));
  connect(T_hp_return.y,sup_is_ret. u1) annotation (Line(points={{89,-82.9},{89,
          -70},{26,-70},{26,-48.2},{25.8,-48.2}}, color={0,0,127}));
  connect(T_HP_supply.y,sup_is_ret. u3) annotation (Line(points={{9,-76.9},{8,
          -76.9},{8,-48.2},{8.2,-48.2}}, color={0,0,127}));
  connect(sup_is_ret.y,heaPum. TSet) annotation (Line(points={{17,-22.9},{16,
          -22.9},{16,-15},{-10,-15}}, color={0,0,127}));
  connect(val.port_b,senMasFlo. port_a)
    annotation (Line(points={{-222,0},{-204,0}}, color={0,127,255}));
  connect(senMasFlo.port_b,HX. ports[2])
    annotation (Line(points={{-184,0},{-102,0}}, color={0,127,255}));
  connect(senMasFlo.m_flow,pControl. u_m) annotation (Line(points={{-194,11},{
          -202,11},{-202,18},{-210,18}}, color={0,0,127}));
  connect(smoothMax.y,pControl. u_s) annotation (Line(points={{-192,49},{-194,
          49},{-194,30},{-198,30}}, color={0,0,127}));
  connect(pControl.y,val. y)
    annotation (Line(points={{-221,30},{-232,30},{-232,12}}, color={0,0,127}));
  connect(cp_dT1.y,dT_cold. u2) annotation (Line(points={{-287,-152},{-234,-152},
          {-234,-146},{-222,-146}}, color={0,0,127}));
  connect(cold_input,dT_cold. u1) annotation (Line(points={{-460,100},{-410,100},
          {-410,-134},{-222,-134}}, color={0,0,127}));
  connect(T_room_return.y,T_hp_return. u3) annotation (Line(points={{9.2,-160},
          {82,-160},{82,-108.2},{80.2,-108.2}},   color={0,0,127}));
  connect(T_room_supply.y,T_cold_return. u2) annotation (Line(points={{-99,-110},
          {-90,-110},{-90,-128},{-62,-128}},       color={0,0,127}));
  connect(dT_cold.y,T_cold_return. u1) annotation (Line(points={{-199,-140},{
          -62,-140}},                         color={0,0,127}));
  connect(senTem_supply.T,HP_control. supply_Temp) annotation (Line(points={{-386,
          -15.4},{-386,-39.75},{-344.444,-39.75}},
                                              color={0,0,127}));
  connect(cold_input,HP_control. cold_input) annotation (Line(points={{-460,100},
          {-410,100},{-410,-47.25},{-344.444,-47.25}},
                                             color={0,0,127}));
  connect(heat_input,HP_control. heat_input) annotation (Line(points={{-460,70},
          {-426,70},{-426,-54.75},{-344.444,-54.75}},
                                            color={0,0,127}));
  connect(dhw_input,HP_control. dhw_input) annotation (Line(points={{-460,40},{
          -420,40},{-420,-62.25},{-344.444,-62.25}},
                                           color={0,0,127}));
  connect(HP_control.direct_cooling,DirectCooling. u2) annotation (Line(points={{
          -295.556,-39.75},{-222,-39.75},{-222,-26},{-140,-26},{-140,72},{-110,
          72}},                                      color={255,0,255}));
  connect(heaPum.is_cooling,HP_control. hp_cooling_mode) annotation (Line(
        points={{-11,-8.2},{-3.5,-8.2},{-3.5,-47.25},{-295.556,-47.25}},
                                                               color={255,0,255}));
  connect(HP_control.hp_off,sup_is_ret. u2) annotation (Line(points={{-295.556,
          -54.75},{16,-54.75},{16,-48.2},{17,-48.2}},
                                           color={255,0,255}));
  connect(HP_control.dhw_now,T_HP_supply. u2) annotation (Line(points={{
          -295.556,-62.25},{-40,-62.25},{-40,-118},{8,-118},{8,-102.2},{9,
          -102.2}},                                                  color={255,
          0,255}));
  connect(HP_control.dhw_now,T_hp_return. u2) annotation (Line(points={{
          -295.556,-62.25},{-40,-62.25},{-40,-118},{90,-118},{90,-108.2},{89,
          -108.2}},                                                     color={
          255,0,255}));
  connect(HP_control.hp_cooling_mode,T_room_supply. u2) annotation (Line(points={{
          -295.556,-47.25},{-234,-47.25},{-234,-110},{-122,-110}},
                                                          color={255,0,255}));
  connect(HP_control.hp_cooling_mode,T_room_return. u2) annotation (Line(points={{
          -295.556,-47.25},{-26,-47.25},{-26,-160},{-18.4,-160}},  color={255,0,
          255}));
  connect(T_cold_return.y,T_room_return. u1) annotation (Line(points={{-39,-134},
          {-32,-134},{-32,-150.4},{-18.4,-150.4}}, color={0,0,127}));
  connect(T_heat_return.y,T_room_return. u3) annotation (Line(points={{-37,-170},
          {-32,-170},{-32,-169.6},{-18.4,-169.6}}, color={0,0,127}));
  connect(Threshold_dc.y,HP_control. threshhold) annotation (Line(points={{-324.1,
          -18},{-336,-18},{-336,-32.25}},            color={0,0,127}));
  connect(Bypass.y,smoothMax. u1) annotation (Line(points={{-173.2,80},{-186,80},
          {-186,72}}, color={0,0,127}));
  connect(dhw_input,m_hc_dhw. u1) annotation (Line(points={{-460,40},{-420,40},
          {-420,70},{-312,70}}, color={0,0,127}));
  connect(m_hc.y,m_hc_dhw. u3) annotation (Line(points={{-331,88},{-324,88},{
          -324,86},{-312,86}}, color={0,0,127}));
  connect(m_hc_dhw.y,sub_P_HP. u1) annotation (Line(points={{-289,78},{-264,78},
          {-264,77.6},{-257.8,77.6}}, color={0,0,127}));
  connect(HP_control.dhw_now,m_hc_dhw. u2) annotation (Line(points={{-295.556,
          -62.25},{-252,-62.25},{-252,12},{-326,12},{-326,78},{-312,78}}, color=
         {255,0,255}));
  connect(cold_input,m_hc. u1) annotation (Line(points={{-460,100},{-410,100},{
          -410,96},{-354,96}}, color={0,0,127}));
  connect(heat_input,m_hc. u3) annotation (Line(points={{-460,70},{-426,70},{
          -426,80},{-354,80}}, color={0,0,127}));
  connect(HP_control.hp_cooling_mode,m_hc. u2) annotation (Line(points={{
          -295.556,-47.25},{-258,-47.25},{-258,6},{-362,6},{-362,88},{-354,88}},
        color={255,0,255}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
            -240},{100,120}}),
                         graphics={
        Rectangle(
          extent={{-440,120},{140,-260}},
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
        coordinateSystem(preserveAspectRatio=false, extent={{-440,-240},{100,
            120}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br>Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end ValveControlledHeatPumpDirectCoolingDHWnoStorage;
