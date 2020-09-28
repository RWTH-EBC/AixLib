within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP_v4_ze_jonas "Substation model for  low-temperature networks for buildings with 
  heat pump and chiller, modified by jgr"

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
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-374,18},{-334,58}}),     iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation in Watt. Values are positive or 0."
                                                 annotation (Placement(
        transformation(extent={{-374,-126},{-334,-86}}),  iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-370,70},{-330,110}}),    iconTransformation(
          extent={{232,76},{192,116}})));

  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=60,
    m_flow_nominal=m_flow_nominal,
    T_start=283.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{38,0},{58,20}})));

  Sensors.TemperatureTwoPort senTem_supply(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-308,14},{-280,-14}})));
  MixingVolumes.MixingVolume HX(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    V=0.15,
    nPorts=2)
            "Heat Exchanger Volume for direct cooling"
    annotation (Placement(transformation(extent={{-148,0},{-168,20}})));
  Modelica.Blocks.Sources.RealExpression DirectCooling(y=if no_free_cool.y ==
        true then 0 else cold_input) annotation (Placement(transformation(
        extent={{61,-13},{-61,13}},
        rotation=0,
        origin={-71,73})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-140,32})));
  HeatPumps.Carnot_TCon_RE heaPum(
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
    annotation (Placement(transformation(extent={{-42,4},{-62,-16}})));
  Sources.Boundary_pT HP_Supply(redeclare package Medium = MediumBuilding,
      nPorts=1)
    annotation (Placement(transformation(extent={{-144,-38},{-124,-18}})));
  Sources.MassFlowSource_T HP_Return(
    redeclare package Medium = MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{36,-56},{12,-32}})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{92,-54},{58,-28}})));
  Modelica.Blocks.Logical.Switch T_HP_supply
    "Temperature Level of the Heatpump" annotation (Placement(transformation(
        extent={{-11,11},{11,-11}},
        rotation=90,
        origin={-27,-33})));
  Modelica.Blocks.Logical.Switch T_hp_return
    "Return Temperture of the Water after it flowed through the radiators. (or the showers, although in real life dhw is not a closed loop system)"
                                             annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={44,-78})));
  Modelica.Blocks.Logical.GreaterThreshold dhw_now(threshold=10)
    "if theres a DHW demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-296,-116},{-276,-96}})));
  Modelica.Blocks.Sources.TimeTable T_set_free_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        50; 2.2e+07,273.15 + 50; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-252,-94},{-222,-64}})));
  Modelica.Blocks.Logical.GreaterThreshold no_free_cool(threshold=273.15 + 18)
    "If the Temperature of the Network Pipe is above the Threshhold, the Temeprature is too high for direct cooling"
    annotation (Placement(transformation(
        extent={{11,-11},{-11,11}},
        rotation=180,
        origin={-277,-53})));
  Modelica.Blocks.Sources.TimeTable T_set_active_cooling(table=[0,273.15 + 35;
        7.0e+06,273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,
        273.15 + 10; 2.2e+07,273.15 + 10; 2.2e+07,273.15 + 35; 2.7e+07,273.15
         + 35; 2.7e+07,273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-252,-44},{-222,-14}})));
  Modelica.Blocks.Logical.Switch T_room_supply
    "Supply Temperature needed in the radiators."
                                               annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=0,
        origin={-179,-53})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{98,52},{118,72}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{96,30},{116,50}})));
  Modelica.Blocks.Sources.RealExpression Pressure_Drop(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{8,28},{72,52}})));
  Actuators.Valves.TwoWayPressureIndependent val(
  redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05)
    "y is the Position of the Valve. Should be between 0 (closed) and 1 (open)"
    annotation (Placement(transformation(extent={{-202,-10},{-182,10}})));

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
        origin={-148,-82})));
  Modelica.Blocks.Math.Division dT_DHW
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-208,-132})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom1(y=m_flow_nominal)
    "mas flow on secondary side is not important, only used for computing the dT of the secondary network. Therefore, we can just use m_flow_nominal of the primary circuit."
    annotation (Placement(transformation(extent={{-334,-170},{-288,-146}})));
  Modelica.Blocks.Math.Gain cp_dT1(k=cp_default)
    annotation (Placement(transformation(extent={{-268,-168},{-248,-148}})));
  Modelica.Blocks.Math.Add T_dhw_return(k1=-1)
    annotation (Placement(transformation(extent={{-96,-116},{-76,-136}})));
  Modelica.Blocks.Math.Division dT_Room
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-208,-166})));
  Modelica.Blocks.Math.Add T_room_return(k1=-1)
    annotation (Placement(transformation(extent={{-96,-148},{-74,-170}})));
  Sensors.TemperatureTwoPort senTem_return(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-4,14},{24,-14}})));
  Sensors.TemperatureTwoPort senTem_afterFreeCool(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-120,14},{-92,-14}})));
  Modelica.Blocks.Math.Add sub_P_HP(k2=-1)
    "The demand series is Q_con of the HP. The network though is connected to the Evaporador, and only extracts Q_eva. The Rest is supplied by the electrical Power of the HP. Therefore, we subtract P_el_HP"
    annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=180,
        origin={-246,82})));
  Modelica.Blocks.Math.Max maxDemand1
    "Takes the Maximum of the Heat and Cold Demand"
    annotation (Placement(transformation(extent={{-320,74},{-300,94}})));
equation
  connect(prescribedHeatFlow.port, HX.heatPort)
    annotation (Line(points={{-140,22},{-140,10},{-148,10}},
                                                 color={191,0,0}));
  connect(m_flow_nom.y, HP_Return.m_flow_in) annotation (Line(points={{56.3,-41},
          {50,-41},{50,-34.4},{38.4,-34.4}}, color={0,0,127}));
  connect(T_hp_return.y, HP_Return.T_in) annotation (Line(points={{44,-67},{44,
          -39.2},{38.4,-39.2}}, color={0,0,127}));
  connect(T_HP_supply.y, heaPum.TSet) annotation (Line(points={{-27,-20.9},{-27,
          -15},{-40,-15}}, color={0,0,127}));
  connect(dhw_now.y,T_HP_supply. u2) annotation (Line(points={{-275,-106},{-27,-106},
          {-27,-46.2}},       color={255,0,255}));
  connect(dhw_now.y, T_hp_return.u2) annotation (Line(points={{-275,-106},{44,-106},
          {44,-90}},       color={255,0,255}));
  connect(DirectCooling.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-138.1,
          73},{-140,73},{-140,42}},                   color={0,0,127}));
  connect(senTem_supply.T, no_free_cool.u) annotation (Line(points={{-294,-15.4},
          {-294,-53},{-290.2,-53}}, color={0,0,127}));
  connect(no_free_cool.y, T_room_supply.u2)
    annotation (Line(points={{-264.9,-53},{-194.6,-53}}, color={255,0,255}));
  connect(T_set_active_cooling.y, T_room_supply.u1) annotation (Line(points={{-220.5,
          -29},{-214,-29},{-214,-42.6},{-194.6,-42.6}},        color={0,0,127}));
  connect(T_set_free_cooling.y, T_room_supply.u3) annotation (Line(points={{-220.5,
          -79},{-212,-79},{-212,-63.4},{-194.6,-63.4}},        color={0,0,127}));
  connect(T_room_supply.y,T_HP_supply. u3) annotation (Line(points={{-164.7,-53},
          {-36,-53},{-36,-46.2},{-35.8,-46.2}}, color={0,0,127}));
  connect(Pressure_Drop.y, dpOut)
    annotation (Line(points={{75.2,40},{106,40}},  color={0,0,127}));
  connect(senTem_supply.port_b, val.port_a) annotation (Line(points={{-280,
          -1.77636e-15},{-196,-1.77636e-15},{-196,0},{-202,0}}, color={0,127,
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
    annotation (Line(points={{-193,16.7},{-193,14},{-192,14},{-192,12}},
                                                     color={0,0,127}));
  connect(m_flow_min.y, smoothMax.u1) annotation (Line(points={{-172.9,80},{
          -186,80},{-186,72}}, color={0,0,127}));
  connect(heaPum.P, P_el) annotation (Line(points={{-63,-6},{-76,-6},{-76,62},{108,
          62}},                     color={0,0,127}));
  connect(dhw_input, dhw_now.u)
    annotation (Line(points={{-354,-106},{-298,-106}}, color={0,0,127}));
  connect(heaPum.port_b1, HP_Supply.ports[1]) annotation (Line(points={{-62,-12},
          {-70,-12},{-70,-28},{-124,-28}}, color={0,127,255}));
  connect(HP_Return.ports[1], heaPum.port_a1) annotation (Line(points={{12,-44},
          {2,-44},{2,-12},{-42,-12}}, color={0,127,255}));
  connect(deltaT_Network.y, cp_dT.u)
    annotation (Line(points={{-276.8,44},{-262,44}}, color={0,0,127}));
  connect(T_HP_supply.u1, T_DHW_supply.y) annotation (Line(points={{-18.2,-46.2},
          {-18.2,-82},{-134.8,-82}}, color={0,0,127}));
  connect(dhw_input, dT_DHW.u1) annotation (Line(points={{-354,-106},{-308,-106},
          {-308,-126},{-220,-126}}, color={0,0,127}));
  connect(m_flow_nom1.y, cp_dT1.u)
    annotation (Line(points={{-285.7,-158},{-270,-158}}, color={0,0,127}));
  connect(cp_dT1.y, dT_DHW.u2) annotation (Line(points={{-247,-158},{-238,-158},
          {-238,-138},{-220,-138}}, color={0,0,127}));
  connect(T_DHW_supply.y, T_dhw_return.u2) annotation (Line(points={{-134.8,-82},
          {-104,-82},{-104,-120},{-98,-120}}, color={0,0,127}));
  connect(dT_DHW.y, T_dhw_return.u1)
    annotation (Line(points={{-197,-132},{-98,-132}},  color={0,0,127}));
  connect(T_dhw_return.y, T_hp_return.u1)
    annotation (Line(points={{-75,-126},{36,-126},{36,-90}}, color={0,0,127}));
  connect(cp_dT1.y,dT_Room. u2) annotation (Line(points={{-247,-158},{-238,-158},
          {-238,-172},{-220,-172}}, color={0,0,127}));
  connect(heat_input,dT_Room. u1) annotation (Line(points={{-354,38},{-328,38},
          {-328,-134},{-230,-134},{-230,-160},{-220,-160}}, color={0,0,127}));
  connect(T_room_supply.y, T_room_return.u2) annotation (Line(points={{-164.7,
          -53},{-114,-53},{-114,-152.4},{-98.2,-152.4}}, color={0,0,127}));
  connect(dT_Room.y,T_room_return. u1) annotation (Line(points={{-197,-166},{
          -146,-166},{-146,-165.6},{-98.2,-165.6}},
                                               color={0,0,127}));
  connect(T_room_return.y, T_hp_return.u3) annotation (Line(points={{-72.9,-159},
          {52,-159},{52,-90}}, color={0,0,127}));
  connect(val.port_b, HX.ports[1])
    annotation (Line(points={{-182,0},{-156,0}}, color={0,127,255}));
  connect(HX.ports[2], senTem_afterFreeCool.port_a)
    annotation (Line(points={{-160,0},{-120,0}}, color={0,127,255}));
  connect(heaPum.port_a2, senTem_afterFreeCool.port_b)
    annotation (Line(points={{-62,0},{-92,0}}, color={0,127,255}));
  connect(heaPum.port_b2, senTem_return.port_a) annotation (Line(points={{-42,0},
          {-18,0},{-18,-1.77636e-15},{-4,-1.77636e-15}}, color={0,127,255}));
  connect(senTem_return.port_b, del1.ports[1]) annotation (Line(points={{24,-1.77636e-15},
          {60,-1.77636e-15},{60,0},{46,0}}, color={0,127,255}));
  connect(del1.ports[2], port_b)
    annotation (Line(points={{50,0},{100,0}}, color={0,127,255}));
  connect(senTem_supply.port_a, port_a) annotation (Line(points={{-308,0},{-340,
          0}},                   color={0,127,255}));
  connect(heaPum.P, sub_P_HP.u2) annotation (Line(points={{-63,-6},{-76,-6},{
          -76,62},{6,62},{6,96},{-264,96},{-264,86.8},{-255.6,86.8}}, color={0,
          0,127}));
  connect(maxDemand.y, sub_P_HP.u1) annotation (Line(points={{-269,78},{-255.6,
          78},{-255.6,77.2}}, color={0,0,127}));
  connect(sub_P_HP.y, m_flow.u1)
    annotation (Line(points={{-237.2,82},{-230,82}}, color={0,0,127}));
  connect(cold_input, maxDemand1.u1)
    annotation (Line(points={{-350,90},{-322,90}}, color={0,0,127}));
  connect(heat_input, maxDemand1.u2) annotation (Line(points={{-354,38},{-328,
          38},{-328,78},{-322,78}}, color={0,0,127}));
  connect(dhw_input, maxDemand.u2) annotation (Line(points={{-354,-106},{-318,
          -106},{-318,72},{-292,72}}, color={0,0,127}));
  connect(maxDemand1.y, maxDemand.u1)
    annotation (Line(points={{-299,84},{-292,84}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,
            -180},{100,100}}),
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
        coordinateSystem(preserveAspectRatio=false, extent={{-340,-180},{100,
            100}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br>Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end PumpControlledwithHP_v4_ze_jonas;
