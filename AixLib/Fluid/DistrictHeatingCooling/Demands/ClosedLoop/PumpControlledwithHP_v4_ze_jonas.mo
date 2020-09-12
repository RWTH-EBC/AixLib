within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP_v4_ze_jonas "Substation model for  low-temperature networks for buildings with 
  heat pump and chiller, modified by jgr"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);
      replaceable package MediumBuilding =
      Modelica.Media.Interfaces.PartialMedium
      "Medium in the building heating system"
      annotation (choicesAllMatching = true);

    parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";

    parameter Modelica.SIunits.HeatFlowRate heatDemand_max "maximum heat demand for scaling of heatpump in Watt";
//    parameter Modelica.SIunits.HeatFlowRate coolingDemand_max=-5000
//                                                              "maximum cooling demand for scaling of chiller in Watt (negative values)";
    parameter Modelica.SIunits.Temperature T_supplyHeating "set temperature of supply heating";
    parameter Modelica.SIunits.Temperature T_supplyCooling "set temperature of supply heating";

 //   parameter Modelica.SIunits.Temperature deltaT_heatingSet "set temperature difference for heating on the site of building";
 //   parameter Modelica.SIunits.Temperature deltaT_coolingSet "set temperature difference for cooling on the building site";

    parameter Modelica.SIunits.Pressure dp_nominal=400000                  "nominal pressure drop";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=(heatDemand_max)/4180
      /10
    "Nominal mass flow rate";

public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-350,-10},{-330,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{146,-10},{166,10}}),
        iconTransformation(extent={{146,-10},{166,10}})));

  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation in W. Values are positive or 0."
                                                  annotation (Placement(
        transformation(extent={{-372,82},{-332,122}}),    iconTransformation(
          extent={{232,76},{192,116}})));

  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumBuilding,tau=0,
    m_flow_nominal=m_flow_nominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-44,-38})));
  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=600,
    nPorts=2,
    m_flow_nominal=2*m_flow_nominal,
    T_start=283.15)
    annotation (Placement(transformation(extent={{110,0},{130,20}})));

  Sensors.TemperatureTwoPort senTem_Return(
    redeclare package Medium = Medium,
    m_flow_nominal=2*m_flow_nominal,
    tau=0,
    T_start=283.15)
    annotation (Placement(transformation(extent={{30,-14},{60,14}})));
  Sensors.TemperatureTwoPort senTem_supply(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=2*m_flow_nominal)
    annotation (Placement(transformation(extent={{-282,14},{-256,-14}})));
  Sensors.TemperatureTwoPort senTem3(
    redeclare package Medium =MediumBuilding,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={48,-40})));
  Modelica.Blocks.Sources.RealExpression T_dhw(y=273.15 + 65)
    annotation (Placement(transformation(extent={{64,-86},{36,-68}})));
  MixingVolumes.MixingVolume HX(
    redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=m_flow_nominal,
    V=0.15) "Heat Exchanger Volume for direct cooling"
    annotation (Placement(transformation(extent={{-74,18},{-54,38}})));
  Sensors.TemperatureTwoPort senTem4(
  redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    T_start=283.15)
    "Temperature after potential direct cooling. Therefore equal or higher than supply Temperature."
    annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
  Modelica.Blocks.Sources.RealExpression DirectCooling(y=if no_free_cool.y ==
        true then 0 else cold_input) annotation (Placement(transformation(
        extent={{54,-12},{-54,12}},
        rotation=0,
        origin={-48,52})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,28})));
  HeatPumps.Carnot_TCon_RE heaPum(
    redeclare package Medium2 = Medium,
    redeclare package Medium1 = MediumBuilding,
    show_T=true,
    dTEva_nominal=-10,
    dTCon_nominal=10,
    etaCarnot_nominal=0.5,
    Q_heating_nominal=heatDemand_max,
    use_eta_Carnot_nominal=true,
    dp1_nominal=30000,
    dp2_nominal=30000,
    m2_flow_nominal=1,
    m1_flow_nominal=m_flow_nominal,
    Q_cooling_nominal=-15000,
    TEva_nominal=283.15)
    annotation (Placement(transformation(extent={{4,4},{-16,-16}})));
  Sources.Boundary_pT toRoom(redeclare package Medium = MediumBuilding, nPorts=
        1) annotation (Placement(transformation(extent={{-96,-48},{-76,-28}})));
  Sources.MassFlowSource_T fromRoom(
    redeclare package Medium = MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{106,-60},{86,-40}})));
  Modelica.Blocks.Sources.RealExpression m_flow_nom(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{72,-32},{118,-10}})));
  Modelica.Blocks.Sources.RealExpression T_room_r(y=T_room.y - heat_input/(4180
        *m_flow_nominal))
    annotation (Placement(transformation(extent={{-24,-140},{112,-118}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={14,-62})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,-64})));
  Modelica.Blocks.Sources.RealExpression T_dhw_r(y=T_dhw.y - dhw_input/(4180*
        m_flow_nominal))
    annotation (Placement(transformation(extent={{-24,-120},{110,-96}})));
  Modelica.Blocks.Logical.GreaterThreshold dhw(threshold=10)
    "if theres a DHW demand, the boolean is set to true"
    annotation (Placement(transformation(extent={{-242,-100},{-222,-80}})));
  Modelica.Blocks.Sources.TimeTable T_set_free_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        50; 2.2e+07,273.15 + 50; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-188,-80},{-168,-60}})));
  Modelica.Blocks.Logical.GreaterThreshold no_free_cool(threshold=273.15 + 18)
    "If the Temperature of the Network Pipe is above the Threshhold, the Temeprature is too high for direct cooling"
    annotation (Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=180,
        origin={-234,-28})));
  Modelica.Blocks.Sources.TimeTable T_set_active_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        10; 2.2e+07,273.15 + 10; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-188,-44},{-168,-24}})));
  Modelica.Blocks.Logical.Switch T_room annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-132,-52})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{158,46},{178,66}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{156,24},{176,44}})));
  Modelica.Blocks.Sources.RealExpression Pressure_Drop(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{68,22},{132,46}})));
  Actuators.Valves.TwoWayPressureIndependent val(
  redeclare package Medium = Medium,
    m_flow_nominal=0.6,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05)
    annotation (Placement(transformation(extent={{-164,-10},{-144,10}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation, as a Volumentic Flow in Liters (l/s)"
                                                 annotation (Placement(
        transformation(extent={{-364,-110},{-324,-70}}),  iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation in W. Values are positive or zero."
                                                 annotation (Placement(
        transformation(extent={{-372,42},{-332,82}}),     iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Math.Add dT_Network(k2=-1)
    "Differernce of supply and return network pipes temperature in K"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-302,54})));
  Modelica.Blocks.Math.Gain cp_dT(k=cp_default)
    annotation (Placement(transformation(extent={{-276,44},{-256,64}})));
  Modelica.Blocks.Math.Division m_flow
    "Computes the mass flow that is necessary to supply the chosen demand at the current Temperature Difference "
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-202,64})));
  Modelica.Blocks.Math.Gain Val_Position(k=1/m_flow_nominal)
    "Valve Position between 0...1 where 1 is the nominal mass flow through the valve"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={-154,36})));
  Utilities.Math.SmoothMax smoothMax(deltaX=0.001) annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={-154,76})));
  Modelica.Blocks.Sources.RealExpression m_flo_min(y=0.2)
    "Minimum Mass Flow through Valve (Bypass)"
    annotation (Placement(transformation(extent={{-110,92},{-128,112}})));
  Modelica.Blocks.Math.Max maxDemand
    "Takes the Maximum of the Heat and Cold Demand"
    annotation (Placement(transformation(extent={{-284,86},{-264,106}})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(del1.ports[1], port_b) annotation (Line(points={{118,0},{156,0}},
                       color={0,127,255}));
  connect(senTem_Return.port_b, del1.ports[2]) annotation (Line(points={{60,
          1.77636e-15},{110,1.77636e-15},{110,0},{122,0}}, color={0,127,255}));
  connect(senTem4.port_b, heaPum.port_a2) annotation (Line(points={{-36,0},{-16,
          0}},                       color={0,127,255}));
  connect(heaPum.port_b2, senTem_Return.port_a) annotation (Line(points={{4,0},
          {28,0},{28,1.77636e-15},{30,1.77636e-15}}, color={0,127,255}));
  connect(prescribedHeatFlow.port, HX.heatPort)
    annotation (Line(points={{-90,28},{-74,28}}, color={191,0,0}));
  connect(m_flow_nom.y, fromRoom.m_flow_in) annotation (Line(points={{120.3,-21},
          {132,-21},{132,-42},{108,-42}}, color={0,0,127}));
  connect(fromRoom.ports[1], senTem3.port_a) annotation (Line(points={{86,-50},
          {72,-50},{72,-40},{58,-40}}, color={0,127,255}));
  connect(senTem3.port_b, heaPum.port_a1)
    annotation (Line(points={{38,-40},{24,-40},{24,-12},{4,-12}},
                                                 color={0,127,255}));
  connect(heaPum.port_b1, senTem1.port_a) annotation (Line(points={{-16,-12},{
          -24,-12},{-24,-38},{-34,-38}},
                               color={0,127,255}));
  connect(senTem1.port_b, toRoom.ports[1])
    annotation (Line(points={{-54,-38},{-76,-38}}, color={0,127,255}));
  connect(switch2.y, fromRoom.T_in) annotation (Line(points={{130,-53},{128,-53},
          {128,-46},{108,-46}}, color={0,0,127}));
  connect(switch1.y, heaPum.TSet) annotation (Line(points={{14,-51},{14,-15},{6,
          -15}},          color={0,0,127}));
  connect(T_dhw.y, switch1.u1) annotation (Line(points={{34.6,-77},{26,-77},{26,
          -74},{22,-74}},
                     color={0,0,127}));
  connect(dhw.y, switch1.u2) annotation (Line(points={{-221,-90},{14,-90},{14,
          -74}}, color={255,0,255}));
  connect(dhw.y, switch2.u2) annotation (Line(points={{-221,-90},{130,-90},{130,
          -76}},                         color={255,0,255}));
  connect(T_dhw_r.y, switch2.u1) annotation (Line(points={{116.7,-108},{116,
          -108},{116,-76},{122,-76}},
                           color={0,0,127}));
  connect(T_room_r.y, switch2.u3) annotation (Line(points={{118.8,-129},{142,
          -129},{142,-76},{138,-76}},
                               color={0,0,127}));
  connect(port_a, senTem_supply.port_a) annotation (Line(points={{-340,0},{-296,
          0},{-296,-1.77636e-15},{-282,-1.77636e-15}}, color={0,127,255}));
  connect(DirectCooling.y, prescribedHeatFlow.Q_flow) annotation (Line(points={
          {-107.4,52},{-120,52},{-120,28},{-110,28}}, color={0,0,127}));
  connect(senTem_supply.T, no_free_cool.u) annotation (Line(points={{-269,-15.4},
          {-269,-28},{-248.4,-28}}, color={0,0,127}));
  connect(no_free_cool.y, T_room.u2) annotation (Line(points={{-220.8,-28},{
          -204,-28},{-204,-52},{-144,-52}},       color={255,0,255}));
  connect(T_set_active_cooling.y, T_room.u1)
    annotation (Line(points={{-167,-34},{-156,-34},{-156,-44},{-144,-44}},
                                                     color={0,0,127}));
  connect(T_set_free_cooling.y, T_room.u3)
    annotation (Line(points={{-167,-70},{-156,-70},{-156,-60},{-144,-60}},
                                                     color={0,0,127}));
  connect(T_room.y, switch1.u3) annotation (Line(points={{-121,-52},{-118,-52},
          {-118,-74},{6,-74}}, color={0,0,127}));
  connect(Pressure_Drop.y, dpOut)
    annotation (Line(points={{135.2,34},{166,34}}, color={0,0,127}));
  connect(senTem_supply.port_b, val.port_a) annotation (Line(points={{-256,
          -1.77636e-15},{-196,-1.77636e-15},{-196,0},{-164,0}}, color={0,127,
          255}));
  connect(val.port_b, HX.ports[1])
    annotation (Line(points={{-144,0},{-66,0},{-66,18}}, color={0,127,255}));
  connect(HX.ports[2], senTem4.port_a)
    annotation (Line(points={{-62,18},{-62,0},{-56,0}}, color={0,127,255}));
  connect(dT_Network.y, cp_dT.u) annotation (Line(points={{-291,54},{-292,54},{
          -292,54},{-278,54}}, color={0,0,127}));
  connect(cp_dT.y, m_flow.u2)
    annotation (Line(points={{-255,54},{-214,54},{-214,58}}, color={0,0,127}));
  connect(Val_Position.u, smoothMax.y)
    annotation (Line(points={{-154,50.4},{-154,60.6}}, color={0,0,127}));
  connect(m_flow.y, smoothMax.u2) annotation (Line(points={{-191,64},{-191,110},
          {-162,110},{-162,92.8},{-162.4,92.8}}, color={0,0,127}));
  connect(Val_Position.y, val.y)
    annotation (Line(points={{-154,22.8},{-154,12}}, color={0,0,127}));
  connect(senTem_Return.T, dT_Network.u2) annotation (Line(points={{45,15.4},{
          45,116},{-324,116},{-324,60},{-314,60}}, color={0,0,127}));
  connect(m_flo_min.y, smoothMax.u1) annotation (Line(points={{-128.9,102},{
          -146,102},{-146,92.8},{-145.6,92.8}}, color={0,0,127}));
  connect(heaPum.P, P_el) annotation (Line(points={{-17,-6},{-18,-6},{-18,28},{
          60,28},{60,56},{168,56}}, color={0,0,127}));
  connect(senTem_supply.T, dT_Network.u1) annotation (Line(points={{-269,-15.4},
          {-269,-28},{-322,-28},{-322,48},{-314,48}}, color={0,0,127}));
  connect(maxDemand.y, m_flow.u1) annotation (Line(points={{-263,96},{-239.5,96},
          {-239.5,70},{-214,70}}, color={0,0,127}));
  connect(heat_input, maxDemand.u1)
    annotation (Line(points={{-352,102},{-286,102}}, color={0,0,127}));
  connect(cold_input, maxDemand.u2) annotation (Line(points={{-352,62},{-330,62},
          {-330,90},{-286,90}}, color={0,0,127}));
  connect(dhw_input, dhw.u)
    annotation (Line(points={{-344,-90},{-244,-90}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,
            -140},{160,120}}),
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
        coordinateSystem(preserveAspectRatio=false, extent={{-340,-140},{160,
            120}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end PumpControlledwithHP_v4_ze_jonas;
