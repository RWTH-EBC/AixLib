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
    annotation (Placement(transformation(extent={{132,-10},{152,10}}),
        iconTransformation(extent={{132,-10},{152,10}})));

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
    annotation (Placement(transformation(extent={{78,0},{98,20}})));

  Sensors.TemperatureTwoPort senTem_supply(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-392,14},{-364,-14}})));
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
        rotation=0,
        origin={-66,-22})));
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
        origin={9,-89})));
  Modelica.Blocks.Logical.Switch T_hp_return
    "Return Temperture of the Water after it flowed through the radiators. (or the showers, although in real life dhw is not a closed loop system)"
                                             annotation (Placement(
        transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={91,-95})));
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
    annotation (Placement(transformation(extent={{-238,-10},{-218,10}})));

  Modelica.Blocks.Math.Gain cp_dT(k=cp_default)
    annotation (Placement(transformation(extent={{-260,34},{-240,54}})));
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
        origin={-130,-188})));
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
    annotation (Placement(transformation(extent={{-68,-196},{-48,-216}})));
  Modelica.Blocks.Math.Division dT_hot annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-204,-226})));
  Modelica.Blocks.Math.Add T_heat_return(k1=-1)
    annotation (Placement(transformation(extent={{-70,-228},{-50,-248}})));
  Sensors.TemperatureTwoPort senTem_return(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{32,14},{60,-14}})));
  Sensors.TemperatureTwoPort senTem_afterFreeCool(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-126,10},{-106,-10}})));
  Modelica.Blocks.Math.Add sub_P_HP(k2=-1)
    "The demand series is Q_con of the HP. The network though is connected to the Evaporador, and only extracts Q_eva. The Rest is supplied by the electrical Power of the HP. Therefore, we subtract P_el_HP"
    annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-246,82})));
  Modelica.Blocks.Math.Max maxDemand1
    "Takes the Maximum of the Heat and Cold Demand"
    annotation (Placement(transformation(extent={{-320,74},{-300,94}})));
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
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-120,68})));
  Modelica.Blocks.Sources.RealExpression Zero(y=0) annotation (Placement(
        transformation(
        extent={{9,-10},{-9,10}},
        rotation=0,
        origin={-71,60})));
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
        origin={-204,-260})));
  Modelica.Blocks.Logical.Switch T_room_return
    "Supply Temperature needed in the radiators. If active cooling is needed, the HP goes into cooling mode."
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-4,-250})));
  Modelica.Blocks.Math.Add T_cold_return(k1=-1)
    annotation (Placement(transformation(extent={{-70,-260},{-50,-280}})));
  Utilities.Logical.HPReversibleControlLogicHeatColdDHWDirectCooling HP_control
    "control casees of heatpump and direct cooling"
    annotation (Placement(transformation(extent={{-366,-76},{-328,-48}})));
equation
  connect(prescribedHeatFlow.port, HX.heatPort)
    annotation (Line(points={{-140,22},{-140,10},{-148,10}},
                                                 color={191,0,0}));
  connect(m_flow_nom.y, HP_Return.m_flow_in) annotation (Line(points={{100.3,
          -23},{90,-23},{90,-26.4},{80.4,-26.4}},
                                             color={0,0,127}));
  connect(T_hp_return.y, HP_Return.T_in) annotation (Line(points={{91,-82.9},{
          91,-31.2},{80.4,-31.2}},
                                color={0,0,127}));
  connect(Pressure_Drop.y, dpOut)
    annotation (Line(points={{109.2,60},{150,60}}, color={0,0,127}));
  connect(senTem_supply.port_b, val.port_a) annotation (Line(points={{-364,
          -1.77636e-15},{-248,-1.77636e-15},{-248,0},{-238,0}}, color={0,127,
          255}));
  connect(cp_dT.y, m_flow.u2)
    annotation (Line(points={{-239,44},{-234,44},{-234,70},{-230,70}},
                                                             color={0,0,127}));
  connect(m_flow.y, smoothMax.u2) annotation (Line(points={{-207,76},{-198,76},{
          -198,72}},                             color={0,0,127}));
  connect(m_flow_min.y, smoothMax.u1) annotation (Line(points={{-172.9,80},{
          -186,80},{-186,72}}, color={0,0,127}));
  connect(heaPum.P, P_el) annotation (Line(points={{-33,-6},{-38,-6},{-38,100},
          {150,100}},               color={0,0,127}));
  connect(heaPum.port_b1, HP_Supply.ports[1]) annotation (Line(points={{-32,-12},
          {-44,-12},{-44,-22},{-56,-22}},  color={0,127,255}));
  connect(HP_Return.ports[1], heaPum.port_a1) annotation (Line(points={{54,-36},
          {42,-36},{42,-12},{-12,-12}},
                                      color={0,127,255}));
  connect(deltaT_Network.y, cp_dT.u)
    annotation (Line(points={{-276.8,44},{-262,44}}, color={0,0,127}));
  connect(T_HP_supply.u1, T_DHW_supply.y) annotation (Line(points={{17.8,-102.2},
          {17.8,-188},{-116.8,-188}},color={0,0,127}));
  connect(dhw_input, dT_DHW.u1) annotation (Line(points={{-460,40},{-420,40},{
          -420,-186},{-218,-186}},  color={0,0,127}));
  connect(m_flow_nom1.y, cp_dT1.u)
    annotation (Line(points={{-315.7,-218},{-300,-218}}, color={0,0,127}));
  connect(cp_dT1.y, dT_DHW.u2) annotation (Line(points={{-277,-218},{-234,-218},
          {-234,-198},{-218,-198}}, color={0,0,127}));
  connect(T_DHW_supply.y, T_dhw_return.u2) annotation (Line(points={{-116.8,
          -188},{-82,-188},{-82,-200},{-70,-200}},
                                              color={0,0,127}));
  connect(dT_DHW.y, T_dhw_return.u1)
    annotation (Line(points={{-195,-192},{-174,-192},{-174,-212},{-70,-212}},
                                                       color={0,0,127}));
  connect(T_dhw_return.y, T_hp_return.u1)
    annotation (Line(points={{-47,-206},{82.2,-206},{82.2,-108.2}},
                                                             color={0,0,127}));
  connect(cp_dT1.y, dT_hot.u2) annotation (Line(points={{-277,-218},{-234,-218},
          {-234,-232},{-216,-232}}, color={0,0,127}));
  connect(heat_input, dT_hot.u1) annotation (Line(points={{-460,70},{-428,70},{
          -428,-192},{-230,-192},{-230,-220},{-216,-220}}, color={0,0,127}));
  connect(dT_hot.y, T_heat_return.u1) annotation (Line(points={{-193,-226},{
          -172,-226},{-172,-244},{-72,-244}}, color={0,0,127}));
  connect(HX.ports[1], senTem_afterFreeCool.port_a)
    annotation (Line(points={{-156,0},{-126,0}}, color={0,127,255}));
  connect(senTem_return.port_b, del1.ports[1]) annotation (Line(points={{60,
          -1.77636e-15},{74,-1.77636e-15},{74,0},{86,0}},
                                            color={0,127,255}));
  connect(del1.ports[2], port_b)
    annotation (Line(points={{90,0},{52,0},{52,0},{142,0}},
                                              color={0,127,255}));
  connect(senTem_supply.port_a, port_a) annotation (Line(points={{-392,
          -1.77636e-15},{-396,-1.77636e-15},{-396,0},{-440,0}},
                                 color={0,127,255}));
  connect(heaPum.P, sub_P_HP.u2) annotation (Line(points={{-33,-6},{-38,-6},{
          -38,96},{-264,96},{-264,86.8},{-255.6,86.8}},               color={0,
          0,127}));
  connect(maxDemand.y, sub_P_HP.u1) annotation (Line(points={{-269,78},{-255.6,
          78},{-255.6,77.2}}, color={0,0,127}));
  connect(sub_P_HP.y, m_flow.u1)
    annotation (Line(points={{-237.2,82},{-230,82}}, color={0,0,127}));
  connect(cold_input, maxDemand1.u1)
    annotation (Line(points={{-460,100},{-410,100},{-410,90},{-322,90}},
                                                   color={0,0,127}));
  connect(heat_input, maxDemand1.u2) annotation (Line(points={{-460,70},{-428,
          70},{-428,78},{-322,78}}, color={0,0,127}));
  connect(dhw_input, maxDemand.u2) annotation (Line(points={{-460,40},{-420,40},
          {-420,72},{-292,72}},       color={0,0,127}));
  connect(maxDemand1.y, maxDemand.u1)
    annotation (Line(points={{-299,84},{-292,84}}, color={0,0,127}));
  connect(T_room_supply.y, T_HP_supply.u3) annotation (Line(points={{-101,-128},
          {0.2,-128},{0.2,-102.2}},                  color={0,0,127}));
  connect(T_cold_supply.y, T_room_supply.u1) annotation (Line(points={{-156.1,
          -116},{-150,-116},{-150,-120},{-124,-120}},
                                               color={0,0,127}));
  connect(T_heat_supply.y, T_room_supply.u3) annotation (Line(points={{-158.2,
          -144},{-148,-144},{-148,-136},{-124,-136}},
                                               color={0,0,127}));
  connect(T_room_supply.y,T_heat_return. u2) annotation (Line(points={{-101,
          -128},{-90,-128},{-90,-232},{-72,-232}},                    color={0,0,127}));
  connect(DirectCooling.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-131,68},{-140,68},{-140,42}}, color={0,0,127}));
  connect(cold_input, DirectCooling.u1) annotation (Line(points={{-460,100},{
          -410,100},{-410,108},{-82,108},{-82,76},{-108,76}},color={0,0,127}));
  connect(Zero.y, DirectCooling.u3) annotation (Line(points={{-80.9,60},{-94,60},
          {-94,60},{-108,60}}, color={0,0,127}));
  connect(senTem_return.port_a, heaPum.port_b2)
    annotation (Line(points={{32,0},{-12,0}}, color={0,127,255}));
  connect(heaPum.port_a2, senTem_afterFreeCool.port_b)
    annotation (Line(points={{-32,0},{-106,0}}, color={0,127,255}));
  connect(T_hp_return.y, sup_is_ret.u1) annotation (Line(points={{91,-82.9},{91,
          -70},{26,-70},{26,-52.2},{25.8,-52.2}}, color={0,0,127}));
  connect(T_HP_supply.y, sup_is_ret.u3) annotation (Line(points={{9,-76.9},{8,
          -76.9},{8,-52.2},{8.2,-52.2}}, color={0,0,127}));
  connect(sup_is_ret.y, heaPum.TSet) annotation (Line(points={{17,-26.9},{16,
          -26.9},{16,-15},{-10,-15}}, color={0,0,127}));
  connect(val.port_b, senMasFlo.port_a)
    annotation (Line(points={{-218,0},{-204,0}}, color={0,127,255}));
  connect(senMasFlo.port_b, HX.ports[2])
    annotation (Line(points={{-184,0},{-160,0}}, color={0,127,255}));
  connect(senMasFlo.m_flow, pControl.u_m) annotation (Line(points={{-194,11},{
          -202,11},{-202,18},{-210,18}}, color={0,0,127}));
  connect(smoothMax.y, pControl.u_s) annotation (Line(points={{-192,49},{-194,
          49},{-194,30},{-198,30}}, color={0,0,127}));
  connect(pControl.y, val.y)
    annotation (Line(points={{-221,30},{-228,30},{-228,12}}, color={0,0,127}));
  connect(cp_dT1.y, dT_cold.u2) annotation (Line(points={{-277,-218},{-234,-218},
          {-234,-266},{-216,-266}}, color={0,0,127}));
  connect(cold_input, dT_cold.u1) annotation (Line(points={{-460,100},{-410,100},
          {-410,-254},{-216,-254}}, color={0,0,127}));
  connect(T_room_return.y, T_hp_return.u3) annotation (Line(points={{9.2,-250},
          {100,-250},{100,-108.2},{99.8,-108.2}}, color={0,0,127}));
  connect(T_room_supply.y, T_cold_return.u2) annotation (Line(points={{-101,
          -128},{-90,-128},{-90,-264},{-72,-264}}, color={0,0,127}));
  connect(dT_cold.y, T_cold_return.u1) annotation (Line(points={{-193,-260},{
          -170,-260},{-170,-276},{-72,-276}}, color={0,0,127}));
  connect(T_cold_return.y, T_room_return.u3) annotation (Line(points={{-49,-270},
          {-34,-270},{-34,-259.6},{-18.4,-259.6}}, color={0,0,127}));
  connect(T_heat_return.y, T_room_return.u1) annotation (Line(points={{-49,-238},
          {-34,-238},{-34,-240.4},{-18.4,-240.4}}, color={0,0,127}));
  connect(senTem_supply.T, HP_control.supply_Temp) annotation (Line(points={{
          -378,-15.4},{-378,-50},{-368,-50}}, color={0,0,127}));
  connect(cold_input, HP_control.cold_input) annotation (Line(points={{-460,100},
          {-410,100},{-410,-58},{-368,-58}}, color={0,0,127}));
  connect(heat_input, HP_control.heat_input) annotation (Line(points={{-460,70},
          {-428,70},{-428,-66},{-368,-66}}, color={0,0,127}));
  connect(dhw_input, HP_control.dhw_input) annotation (Line(points={{-460,40},{
          -420,40},{-420,-74},{-368,-74}}, color={0,0,127}));
  connect(HP_control.direct_cooling, DirectCooling.u2) annotation (Line(points=
          {{-326,-50},{-94,-50},{-94,68},{-108,68}}, color={255,0,255}));
  connect(heaPum.is_cooling, HP_control.hp_cooling_mode) annotation (Line(
        points={{-11,-8.2},{-3.5,-8.2},{-3.5,-58},{-326,-58}}, color={255,0,255}));
  connect(HP_control.hp_off, sup_is_ret.u2) annotation (Line(points={{-326,-66},
          {16,-66},{16,-52.2},{17,-52.2}}, color={255,0,255}));
  connect(HP_control.dhw_now, T_HP_supply.u2) annotation (Line(points={{-326,
          -74},{-40,-74},{-40,-118},{8,-118},{8,-102.2},{9,-102.2}}, color={255,
          0,255}));
  connect(HP_control.dhw_now, T_hp_return.u2) annotation (Line(points={{-326,
          -74},{-40,-74},{-40,-118},{90,-118},{90,-108.2},{91,-108.2}}, color={
          255,0,255}));
  connect(HP_control.hp_cooling_mode, T_room_supply.u2) annotation (Line(points
        ={{-326,-58},{-226,-58},{-226,-128},{-124,-128}}, color={255,0,255}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,
            -280},{140,120}}),
                         graphics={
        Rectangle(
          extent={{-398,96},{82,-244}},
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
          fillPattern=FillPattern.Solid)}),                      Diagram(
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
end ValveControlledHeatPumpDirectCoolingDHWnoStorage;
