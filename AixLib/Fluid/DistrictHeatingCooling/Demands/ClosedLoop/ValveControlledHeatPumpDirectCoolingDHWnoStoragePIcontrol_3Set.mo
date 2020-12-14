within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlledHeatPumpDirectCoolingDHWnoStoragePIcontrol_3Set
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
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-480,50},{-440,90}}),     iconTransformation(
          extent={{-480,100},{-440,140}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation in Watt. Values are positive or 0."
                                                 annotation (Placement(
        transformation(extent={{-480,14},{-440,54}}),     iconTransformation(
          extent={{-480,14},{-440,54}})));
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
    annotation (Placement(transformation(extent={{64,0},{84,20}})));
  Sensors.TemperatureTwoPort senTem_supply(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-406,14},{-378,-14}})));
  MixingVolumes.MixingVolume HX(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    V=0.15,
    nPorts=2)
            "Heat Exchanger Volume for direct cooling"
    annotation (Placement(transformation(extent={{-124,0},{-144,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-102,72})));
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
    annotation (Placement(transformation(extent={{-38,4},{-58,-16}})));
  Sources.Boundary_pT HP_Supply(redeclare package Medium = MediumBuilding,
      nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-94,-32})));
  Sources.MassFlowSource_T HP_Return(
    redeclare package Medium = MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{74,-48},{50,-24}})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{40,-72},{74,-46}})));
  Modelica.Blocks.Logical.Switch T_HP_supply
    "Temperature Level of the Heatpump" annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={9,-89})));
  Modelica.Blocks.Logical.Switch T_hp_return
    "Return Temperture of the Water after it flowed through the radiators. (or the showers, although in real life dhw is not a closed loop system)"
                                             annotation (Placement(
        transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={85,-95})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{100,90},{120,110}}),
        iconTransformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{100,50},{120,70}}),
        iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Sources.RealExpression Pressure_Drop(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{-14,48},{50,72}})));
  Actuators.Valves.TwoWayPressureIndependent val(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05)
    "y is the Position of the Valve. Should be between 0 (closed) and 1 (open)"
    annotation (Placement(transformation(extent={{-238,-48},{-218,-28}})));
  Modelica.Blocks.Sources.Constant T_DHW_supply(k=T_dhw_supply)
    "Temperature of the DHW that comes out of showers, sinks etc. Is used to compute the return Temperature"
    annotation (Placement(transformation(
        extent={{12,12},{-12,-12}},
        rotation=180,
        origin={-136,-144})));
  Modelica.Blocks.Math.Division dT_DHW
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,-172})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom1(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{-368,-196},{-322,-172}})));
  Modelica.Blocks.Math.Gain cp_dT1(k=cp_default)
    annotation (Placement(transformation(extent={{-298,-194},{-278,-174}})));
  Modelica.Blocks.Math.Add T_dhw_return(k1=-1)
    annotation (Placement(transformation(extent={{-60,-156},{-40,-176}})));
  Modelica.Blocks.Math.Division dT_hot annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,-242})));
  Modelica.Blocks.Math.Add T_heat_return(k1=-1)
    annotation (Placement(transformation(extent={{-58,-226},{-38,-246}})));
  Sensors.TemperatureTwoPort senTem_return(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{10,-14},{38,14}})));
  Sensors.TemperatureTwoPort senTem_afterFreeCool(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-100,10},{-80,-10}})));
  Modelica.Blocks.Logical.Switch T_room_supply
    "Supply Temperature needed in the radiators. If active cooling is needed, the HP goes into cooling mode."
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-136,-112})));
  Modelica.Blocks.Sources.RealExpression T_cold_supply(y=273.15 + 15)
    annotation (Placement(transformation(extent={{-214,-106},{-172,-82}})));
  Modelica.Blocks.Sources.RealExpression T_heat_supply(y=273.15 + 35)
    annotation (Placement(transformation(extent={{-214,-140},{-170,-118}})));
  Modelica.Blocks.Logical.Switch DirectCooling annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-124,92})));
  Modelica.Blocks.Sources.RealExpression Zero(y=0) annotation (Placement(
        transformation(
        extent={{9,-10},{-9,10}},
        rotation=0,
        origin={-125,70})));
  Modelica.Blocks.Logical.Switch sup_is_ret
    "wenn HP aus sein soll, ist T supply gleich T return (dT =0, keine Temperaturerhöhung)"
    annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={17,-39})));
  Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-196,-48},{-176,-28}})));
  Modelica.Blocks.Math.Division dT_cold annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,-206})));
  Modelica.Blocks.Logical.Switch T_room_return
    "Return Temperature needed in the radiators"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-4,-226})));
  Modelica.Blocks.Math.Add T_cold_return(k1=+1)
    annotation (Placement(transformation(extent={{-60,-190},{-40,-210}})));
  Utilities.Logical.HPReversibleControlLogicHeatColdDHWDirectCoolingV2
                                                                     HP_control
    "control casees of heatpump and direct cooling"
    annotation (Placement(transformation(extent={{-372,-82},{-332,-52}})));
  Modelica.Blocks.Sources.RealExpression Threshold_dc(y=273.15 + 18)
    "Temp above which its too warm for direct cooling+" annotation (Placement(
        transformation(
        extent={{18,-10},{-18,10}},
        rotation=0,
        origin={-340,-36})));
  Modelica.Blocks.Logical.Or            ret_hot
    "more heat added to the pipe than taken out" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-256,18})));
  Modelica.Blocks.Continuous.LimPID pControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3)      "Pressure controller" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-190,48})));
  Modelica.Blocks.Logical.Less hx_bigger_hp
    "the heat added to the network by the heat exchanger is vbigger than the heat taken from the nwtowkr by the condensor"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-378,38})));
  Modelica.Blocks.Logical.And dc_and_cold
    "more heat added to the pipe than taken out" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-298,16})));
  Modelica.Blocks.Sources.RealExpression open(y=1)
    annotation (Placement(transformation(extent={{-264,-14},{-248,6}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=7200)
    annotation (Placement(transformation(extent={{-200,10},{-218,28}})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating1
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{9,9},{-9,-9}},
        rotation=90,
        origin={-229,-11})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-276,54})));
  Modelica.Blocks.Math.Add s_r(k1=-1)
    annotation (Placement(transformation(extent={{-138,36},{-158,56}})));
  Modelica.Blocks.Sources.RealExpression dT_heating(y=dT_Network) "Temp drops"
    annotation (Placement(transformation(extent={{-348,46},{-312,70}})));
  Modelica.Blocks.Sources.RealExpression dT_cooling(y=-dT_Network)
    "Temp increases"
    annotation (Placement(transformation(extent={{-350,28},{-312,52}})));
  Modelica.Blocks.Sources.RealExpression dT_nothing(y=0) "Temp increases"
    annotation (Placement(transformation(extent={{-306,74},{-272,100}})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-232,76})));
  Modelica.Blocks.Logical.LessThreshold    c(threshold=10)
    "if theres a cold demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-354,72},{-334,92}})));
  Modelica.Blocks.Math.Add3                c1(k1=-1)
    "if theres a cold demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-390,72},{-370,92}})));
equation
  connect(prescribedHeatFlow.port,HX. heatPort)
    annotation (Line(points={{-102,62},{-102,10},{-124,10}},
                                                 color={191,0,0}));
  connect(m_flow_nom.y,HP_Return. m_flow_in) annotation (Line(points={{75.7,-59},
          {92,-59},{92,-26.4},{76.4,-26.4}}, color={0,0,127}));
  connect(T_hp_return.y,HP_Return. T_in) annotation (Line(points={{85,-82.9},{
          85,-31.2},{76.4,-31.2}},
                                color={0,0,127}));
  connect(Pressure_Drop.y,dpOut)
    annotation (Line(points={{53.2,60},{110,60}},  color={0,0,127}));
  connect(senTem_supply.port_b,val. port_a) annotation (Line(points={{-378,
          -1.77636e-15},{-298,-1.77636e-15},{-298,-38},{-238,-38}},
                                                                color={0,127,
          255}));
  connect(heaPum.P,P_el)  annotation (Line(points={{-59,-6},{-70,-6},{-70,100},
          {110,100}},               color={0,0,127}));
  connect(heaPum.port_b1,HP_Supply. ports[1]) annotation (Line(points={{-58,-12},
          {-74,-12},{-74,-32},{-84,-32}},  color={0,127,255}));
  connect(HP_Return.ports[1],heaPum. port_a1) annotation (Line(points={{50,-36},
          {42,-36},{42,-12},{-38,-12}},
                                      color={0,127,255}));
  connect(T_HP_supply.u1,T_DHW_supply. y) annotation (Line(points={{17.8,-102.2},
          {17.8,-144},{-122.8,-144}},color={0,0,127}));
  connect(dhw_input,dT_DHW. u1) annotation (Line(points={{-460,34},{-420,34},{
          -420,-166},{-222,-166}},  color={0,0,127}));
  connect(m_flow_nom1.y,cp_dT1. u)
    annotation (Line(points={{-319.7,-184},{-300,-184}}, color={0,0,127}));
  connect(cp_dT1.y,dT_DHW. u2) annotation (Line(points={{-277,-184},{-234,-184},
          {-234,-178},{-222,-178}}, color={0,0,127}));
  connect(T_DHW_supply.y,T_dhw_return. u2) annotation (Line(points={{-122.8,
          -144},{-82,-144},{-82,-160},{-62,-160}},
                                              color={0,0,127}));
  connect(dT_DHW.y,T_dhw_return. u1)
    annotation (Line(points={{-199,-172},{-62,-172}},  color={0,0,127}));
  connect(T_dhw_return.y,T_hp_return. u1)
    annotation (Line(points={{-39,-166},{76.2,-166},{76.2,-108.2}},
                                                             color={0,0,127}));
  connect(cp_dT1.y,dT_hot. u2) annotation (Line(points={{-277,-184},{-234,-184},
          {-234,-248},{-222,-248}}, color={0,0,127}));
  connect(heat_input,dT_hot. u1) annotation (Line(points={{-460,70},{-426,70},{
          -426,-236},{-222,-236}},                         color={0,0,127}));
  connect(dT_hot.y,T_heat_return. u1) annotation (Line(points={{-199,-242},{-60,
          -242}},                             color={0,0,127}));
  connect(HX.ports[1],senTem_afterFreeCool. port_a)
    annotation (Line(points={{-132,0},{-100,0}}, color={0,127,255}));
  connect(senTem_return.port_b,del1. ports[1]) annotation (Line(points={{38,
          1.77636e-15},{74,1.77636e-15},{74,0},{72,0}},
                                            color={0,127,255}));
  connect(del1.ports[2],port_b)
    annotation (Line(points={{76,0},{100,0}}, color={0,127,255}));
  connect(senTem_supply.port_a,port_a)  annotation (Line(points={{-406,
          -1.77636e-15},{-396,-1.77636e-15},{-396,0},{-440,0}},
                                 color={0,127,255}));
  connect(T_room_supply.y,T_HP_supply. u3) annotation (Line(points={{-125,-112},
          {0.2,-112},{0.2,-102.2}},                  color={0,0,127}));
  connect(T_cold_supply.y,T_room_supply. u1) annotation (Line(points={{-169.9,
          -94},{-160,-94},{-160,-104},{-148,-104}},
                                               color={0,0,127}));
  connect(T_heat_supply.y,T_room_supply. u3) annotation (Line(points={{-167.8,
          -129},{-162,-129},{-162,-120},{-148,-120}},
                                               color={0,0,127}));
  connect(T_room_supply.y,T_heat_return. u2) annotation (Line(points={{-125,
          -112},{-90,-112},{-90,-230},{-60,-230}},                    color={0,0,127}));
  connect(DirectCooling.y,prescribedHeatFlow. Q_flow)
    annotation (Line(points={{-113,92},{-102,92},{-102,82}}, color={0,0,127}));
  connect(cold_input,DirectCooling. u1) annotation (Line(points={{-460,100},{
          -136,100}},                                        color={0,0,127}));
  connect(Zero.y,DirectCooling. u3) annotation (Line(points={{-134.9,70},{-142,
          70},{-142,84},{-136,84}},
                               color={0,0,127}));
  connect(senTem_return.port_a,heaPum. port_b2)
    annotation (Line(points={{10,1.77636e-15},{6,1.77636e-15},{6,0},{-38,0}},
                                              color={0,127,255}));
  connect(heaPum.port_a2,senTem_afterFreeCool. port_b)
    annotation (Line(points={{-58,0},{-80,0}},  color={0,127,255}));
  connect(T_hp_return.y,sup_is_ret. u1) annotation (Line(points={{85,-82.9},{85,
          -70},{26,-70},{26,-52.2},{25.8,-52.2}}, color={0,0,127}));
  connect(T_HP_supply.y,sup_is_ret. u3) annotation (Line(points={{9,-76.9},{8,
          -76.9},{8,-52.2},{8.2,-52.2}}, color={0,0,127}));
  connect(sup_is_ret.y,heaPum. TSet) annotation (Line(points={{17,-26.9},{16,
          -26.9},{16,-15},{-36,-15}}, color={0,0,127}));
  connect(val.port_b,senMasFlo. port_a)
    annotation (Line(points={{-218,-38},{-196,-38}},
                                                 color={0,127,255}));
  connect(senMasFlo.port_b,HX. ports[2])
    annotation (Line(points={{-176,-38},{-154,-38},{-154,0},{-136,0}},
                                                 color={0,127,255}));
  connect(cp_dT1.y,dT_cold. u2) annotation (Line(points={{-277,-184},{-234,-184},
          {-234,-212},{-222,-212}}, color={0,0,127}));
  connect(cold_input,dT_cold. u1) annotation (Line(points={{-460,100},{-410,100},
          {-410,-200},{-222,-200}}, color={0,0,127}));
  connect(T_room_return.y,T_hp_return. u3) annotation (Line(points={{9.2,-226},
          {94,-226},{94,-108.2},{93.8,-108.2}},   color={0,0,127}));
  connect(T_room_supply.y,T_cold_return. u2) annotation (Line(points={{-125,
          -112},{-90,-112},{-90,-194},{-62,-194}}, color={0,0,127}));
  connect(dT_cold.y,T_cold_return. u1) annotation (Line(points={{-199,-206},{
          -62,-206}},                         color={0,0,127}));
  connect(senTem_supply.T,HP_control. supply_Temp) annotation (Line(points={{-392,
          -15.4},{-392,-55.75},{-376.444,-55.75}},
                                              color={0,0,127}));
  connect(cold_input,HP_control. cold_input) annotation (Line(points={{-460,100},
          {-410,100},{-410,-63.25},{-376.444,-63.25}},
                                             color={0,0,127}));
  connect(heat_input,HP_control. heat_input) annotation (Line(points={{-460,70},
          {-426,70},{-426,-70.75},{-376.444,-70.75}},
                                            color={0,0,127}));
  connect(dhw_input,HP_control. dhw_input) annotation (Line(points={{-460,34},{
          -420,34},{-420,-78.25},{-376.444,-78.25}},
                                           color={0,0,127}));
  connect(heaPum.is_cooling,HP_control. hp_cooling_mode) annotation (Line(
        points={{-37,-8.2},{-25.5,-8.2},{-25.5,-63.25},{-327.556,-63.25}},
                                                               color={255,0,255}));
  connect(HP_control.hp_off,sup_is_ret. u2) annotation (Line(points={{-327.556,
          -70.75},{16,-70.75},{16,-52.2},{17,-52.2}},
                                           color={255,0,255}));
  connect(HP_control.dhw_now,T_HP_supply. u2) annotation (Line(points={{
          -327.556,-78.25},{-40,-78.25},{-40,-118},{8,-118},{8,-102.2},{9,
          -102.2}},                                                  color={255,
          0,255}));
  connect(HP_control.dhw_now,T_hp_return. u2) annotation (Line(points={{
          -327.556,-78.25},{-40,-78.25},{-40,-118},{86,-118},{86,-108.2},{85,
          -108.2}},                                                     color={
          255,0,255}));
  connect(HP_control.hp_cooling_mode,T_room_supply. u2) annotation (Line(points={{
          -327.556,-63.25},{-282,-63.25},{-282,-112},{-148,-112}},
                                                          color={255,0,255}));
  connect(HP_control.hp_cooling_mode,T_room_return. u2) annotation (Line(points={{
          -327.556,-63.25},{-26,-63.25},{-26,-226},{-18.4,-226}},  color={255,0,
          255}));
  connect(T_cold_return.y,T_room_return. u1) annotation (Line(points={{-39,-200},
          {-32,-200},{-32,-216.4},{-18.4,-216.4}}, color={0,0,127}));
  connect(T_heat_return.y,T_room_return. u3) annotation (Line(points={{-37,-236},
          {-32,-236},{-32,-235.6},{-18.4,-235.6}}, color={0,0,127}));
  connect(Threshold_dc.y,HP_control. threshhold) annotation (Line(points={{-359.8,
          -36},{-368,-36},{-368,-48.25}},            color={0,0,127}));
  connect(dpOut,dpOut)
    annotation (Line(points={{110,60},{110,60}}, color={0,0,127}));
  connect(ret_hot.u2,HP_control. hp_cooling_mode) annotation (Line(points={{-268,10},
          {-282,10},{-282,-63.25},{-327.556,-63.25}},
                    color={255,0,255}));
  connect(heaPum.QEva_flow,hx_bigger_hp. u1) annotation (Line(points={{-59,3},{
          -59,114},{-400,114},{-400,38},{-390,38}}, color={0,0,127}));
  connect(cold_input,hx_bigger_hp. u2) annotation (Line(points={{-460,100},{
          -410,100},{-410,30},{-390,30}}, color={0,0,127}));
  connect(hx_bigger_hp.y,dc_and_cold. u1)
    annotation (Line(points={{-367,38},{-360,38},{-360,16},{-310,16}},
                                                   color={255,0,255}));
  connect(dc_and_cold.y,ret_hot. u1) annotation (Line(points={{-287,16},{-280,
          16},{-280,18},{-268,18}}, color={255,0,255}));
  connect(DirectCooling.u2,HP_control. direct_cooling) annotation (Line(points={{-136,92},
          {-164,92},{-164,-55.75},{-327.556,-55.75}},            color={255,0,
          255}));
  connect(dc_and_cold.u2,HP_control. direct_cooling) annotation (Line(points={{-310,8},
          {-316,8},{-316,-55.75},{-327.556,-55.75}},           color={255,0,255}));
  connect(mass_flow_heatExchangerHeating1.u3,open. y) annotation (Line(points={{-236.2,
          -0.2},{-236.1,-0.2},{-236.1,-4},{-247.2,-4}},         color={0,0,127}));
  connect(booleanStep.y,mass_flow_heatExchangerHeating1. u2) annotation (Line(
        points={{-218.9,19},{-230,19},{-230,-0.2},{-229,-0.2}},
                                                              color={255,0,255}));
  connect(mass_flow_heatExchangerHeating1.y,val. y) annotation (Line(points={{-229,
          -20.9},{-228,-20.9},{-228,-26}},  color={0,0,127}));
  connect(pControl.y,mass_flow_heatExchangerHeating1. u1) annotation (Line(
        points={{-190,37},{-190,-0.2},{-221.8,-0.2}},   color={0,0,127}));
  connect(pControl.u_m, s_r.y) annotation (Line(points={{-178,48},{-168,48},{
          -168,46},{-159,46}}, color={0,0,127}));
  connect(senTem_return.T, s_r.u1)
    annotation (Line(points={{24,15.4},{24,52},{-136,52}}, color={0,0,127}));
  connect(senTem_supply.T, s_r.u2) annotation (Line(points={{-392,-15.4},{-392,
          -22},{-112,-22},{-112,40},{-136,40}}, color={0,0,127}));
  connect(dT_cooling.y, switch1.u1) annotation (Line(points={{-310.1,40},{-300,
          40},{-300,46},{-288,46}}, color={0,0,127}));
  connect(dT_heating.y, switch1.u3) annotation (Line(points={{-310.2,58},{-300,
          58},{-300,62},{-288,62}}, color={0,0,127}));
  connect(ret_hot.y, switch1.u2) annotation (Line(points={{-245,18},{-240,18},{
          -240,36},{-302,36},{-302,54},{-288,54}}, color={255,0,255}));
  connect(dhw_input, c1.u3) annotation (Line(points={{-460,34},{-418,34},{-418,
          74},{-392,74}}, color={0,0,127}));
  connect(heat_input, c1.u2) annotation (Line(points={{-460,70},{-426,70},{-426,
          82},{-392,82}}, color={0,0,127}));
  connect(cold_input, c1.u1) annotation (Line(points={{-460,100},{-410,100},{
          -410,90},{-392,90}}, color={0,0,127}));
  connect(c1.y, c.u)
    annotation (Line(points={{-369,82},{-356,82}}, color={0,0,127}));
  connect(switch1.y, switch2.u3) annotation (Line(points={{-265,54},{-254.5,54},
          {-254.5,68},{-244,68}}, color={0,0,127}));
  connect(dT_nothing.y, switch2.u1) annotation (Line(points={{-270.3,87},{
          -257.15,87},{-257.15,84},{-244,84}}, color={0,0,127}));
  connect(c.y, switch2.u2) annotation (Line(points={{-333,82},{-316,82},{-316,
          76},{-244,76}}, color={255,0,255}));
  connect(switch2.y, pControl.u_s)
    annotation (Line(points={{-221,76},{-190,76},{-190,60}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
            -260},{100,120}}),
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
        coordinateSystem(preserveAspectRatio=false, extent={{-440,-260},{100,
            120}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br>Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end ValveControlledHeatPumpDirectCoolingDHWnoStoragePIcontrol_3Set;
