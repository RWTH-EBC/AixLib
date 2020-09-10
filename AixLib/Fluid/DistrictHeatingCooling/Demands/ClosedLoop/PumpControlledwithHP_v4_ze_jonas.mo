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
    annotation (Placement(transformation(extent={{210,-10},{230,10}}),
        iconTransformation(extent={{210,-10},{230,10}})));

  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation" annotation (Placement(
        transformation(extent={{-354,-64},{-314,-24}}),   iconTransformation(
          extent={{232,76},{192,116}})));

  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumBuilding,tau=0,
    m_flow_nominal=m_flow_nominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-74,-38})));
  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=600,
    nPorts=2,
    m_flow_nominal=2*m_flow_nominal,
    T_start=283.15)
    annotation (Placement(transformation(extent={{186,0},{206,20}})));

  Sensors.TemperatureTwoPort senTem_Return(
    redeclare package Medium = Medium,
    m_flow_nominal=2*m_flow_nominal,
    tau=0,
    T_start=283.15)
    annotation (Placement(transformation(extent={{52,-14},{82,14}})));
  Sensors.TemperatureTwoPort senTem_supply(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0,
    m_flow_nominal=2*m_flow_nominal)
    annotation (Placement(transformation(extent={{-252,14},{-226,-14}})));
  Sensors.TemperatureTwoPort senTem3(
    redeclare package Medium =MediumBuilding,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={68,-38})));
  Modelica.Blocks.Sources.RealExpression T_dhw(y=273.15 + 65)
    annotation (Placement(transformation(extent={{60,-88},{32,-70}})));
  MixingVolumes.MixingVolume HX(
    redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=m_flow_nominal,
    V=0.15) "Heat Exchanger Volume for direct cooling"
    annotation (Placement(transformation(extent={{-76,4},{-56,24}})));
  Sensors.TemperatureTwoPort senTem4(
  redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    T_start=283.15)
    annotation (Placement(transformation(extent={{-48,-26},{-28,-6}})));
  Modelica.Blocks.Sources.RealExpression cooling(y=if no_free_cool.y == true
         then 0 else cold_input)             annotation (Placement(
        transformation(
        extent={{-87,-13},{87,13}},
        rotation=0,
        origin={-191,147})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,14})));
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
    annotation (Placement(transformation(extent={{10,-22},{-10,-42}})));
  Sources.Boundary_pT   bou2(
  redeclare package Medium =MediumBuilding, nPorts=1)
    annotation (Placement(transformation(extent={{-124,-48},{-104,-28}})));
  Sources.MassFlowSource_T boundary1(
    redeclare package Medium =MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{120,-48},{100,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{184,-38},{146,-18}})));
  Modelica.Blocks.Sources.RealExpression T_room_r(y=T_room.y - heat_input/(4180
        *m_flow_nominal))
    annotation (Placement(transformation(extent={{276,-102},{148,-72}})));
  Utilities.Sensors.FuelCounter fuelCounter
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,8})));
  Utilities.Sensors.EnergyMeter con_HM annotation (Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=90,
        origin={-26,6})));
  Utilities.Sensors.EnergyMeter eva_HM annotation (Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=90,
        origin={2,6})));
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
    annotation (Placement(transformation(extent={{-20,-126},{106,-90}})));
  Modelica.Blocks.Logical.GreaterThreshold dhw(threshold=10)
    annotation (Placement(transformation(extent={{-52,-132},{-32,-112}})));
  Modelica.Blocks.Sources.TimeTable T_set_free_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        50; 2.2e+07,273.15 + 50; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-220,-80},{-200,-60}})));
  Modelica.Blocks.Logical.GreaterThreshold no_free_cool(threshold=273.15 + 18)
    annotation (Placement(transformation(
        extent={{13,-13},{-13,13}},
        rotation=180,
        origin={-201,-29})));
  Modelica.Blocks.Sources.TimeTable T_set_active_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        10; 2.2e+07,273.15 + 10; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-134,-80},{-154,-60}})));
  Modelica.Blocks.Logical.Switch T_room annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-176,-82})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{202,84},{222,104}})));
  Modelica.Blocks.Sources.RealExpression HP_Power(y=fuelCounter.counter)
    annotation (Placement(transformation(extent={{116,82},{174,106}})));
  Modelica.Blocks.Nonlinear.Limiter Lim50to95(uMax=273.15 + 9.5, uMin=273.15 +
        5) "Keeps the Temperature between 5 and 9.5 °C"
    annotation (Placement(transformation(extent={{12,26},{-22,60}})));
  Modelica.Blocks.Nonlinear.Limiter Lim105to150(uMax=273.15 + 15, uMin=273.15
         + 10.5) "Keep the Temeprature between 10.5 and 15 °C"
    annotation (Placement(transformation(extent={{14,78},{-20,112}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{202,60},{222,80}})));
  Modelica.Blocks.Sources.RealExpression Pressure_Drop(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{114,58},{178,82}})));
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
        transformation(extent={{-188,-142},{-148,-102}}), iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation"
                                                 annotation (Placement(
        transformation(extent={{-350,-102},{-310,-62}}),  iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Math.Gain Vol_Flow_to_Heatcapacityflow(k=4180*0.001)
    "Converts the Volumetric Flow input of dhw to a Heatcapacity flow. The Heatcapacity Flow can then be multiplied by the Temperature Difference of the DHW Cicle to compute the DHW Heatflow"
    annotation (Placement(transformation(extent={{-116,-134},{-92,-110}})));
  Modelica.Blocks.Math.Add dT(k2=-1)
    "Differernce of supply and return network pipes temperature in K"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-302,54})));
  Modelica.Blocks.Math.Gain cp_dT(k=cp_default)
    annotation (Placement(transformation(extent={{-276,44},{-256,64}})));
  Modelica.Blocks.Math.Division m_flow annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-202,64})));
  Modelica.Blocks.Math.Gain Val_Position(k=1/m_flow_nominal)
    "Valve Position between 0...1 where 1 is the nominal mass flow through the valve"
    annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=270,
        origin={-155,37})));
  Utilities.Math.SmoothMax smoothMax(deltaX=0.001) annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=-90,
        origin={-155,77})));
  Modelica.Blocks.Sources.RealExpression MaxDemand(y=max(cold_input, heat_input))
    "Takes the maximum of heat or cold demand"
    annotation (Placement(transformation(extent={{-324,76},{-248,102}})));
  Modelica.Blocks.Sources.RealExpression m_flo_min(y=0.2)
    "Minimum Mass Flow through Valve (Bypass)"
    annotation (Placement(transformation(extent={{-110,90},{-128,112}})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(del1.ports[1], port_b) annotation (Line(points={{194,0},{220,0}},
                       color={0,127,255}));
  connect(senTem_Return.port_b, del1.ports[2]) annotation (Line(points={{82,
          1.77636e-15},{110,1.77636e-15},{110,0},{198,0}}, color={0,127,255}));
  connect(senTem4.port_b, heaPum.port_a2) annotation (Line(points={{-28,-16},{-20,
          -16},{-20,-26},{-10,-26}}, color={0,127,255}));
  connect(heaPum.port_b2, senTem_Return.port_a) annotation (Line(points={{10,
          -26},{28,-26},{28,1.77636e-15},{52,1.77636e-15}}, color={0,127,255}));
  connect(prescribedHeatFlow.port, HX.heatPort)
    annotation (Line(points={{-82,14},{-76,14}}, color={191,0,0}));
  connect(realExpression.y, boundary1.m_flow_in) annotation (Line(points={{144.1,
          -28},{140,-28},{140,-26},{122,-26},{122,-30}},
                                                    color={0,0,127}));
  connect(heaPum.QEva_flow, eva_HM.p)
    annotation (Line(points={{-11,-23},{2,-23},{2,0.4}}, color={0,0,127}));
  connect(heaPum.P, fuelCounter.fuel_in)
    annotation (Line(points={{-11,-32},{-12,-32},{-12,-2}}, color={0,0,127}));
  connect(heaPum.QCon_flow, con_HM.p)
    annotation (Line(points={{-11,-41},{-26,-41},{-26,0.4}}, color={0,0,127}));
  connect(boundary1.ports[1], senTem3.port_a)
    annotation (Line(points={{100,-38},{78,-38}}, color={0,127,255}));
  connect(senTem3.port_b, heaPum.port_a1)
    annotation (Line(points={{58,-38},{10,-38}}, color={0,127,255}));
  connect(heaPum.port_b1, senTem1.port_a) annotation (Line(points={{-10,-38},{-64,
          -38}},               color={0,127,255}));
  connect(senTem1.port_b, bou2.ports[1]) annotation (Line(points={{-84,-38},{-104,
          -38}},                          color={0,127,255}));
  connect(switch2.y, boundary1.T_in) annotation (Line(points={{130,-53},{128,-53},
          {128,-34},{122,-34}}, color={0,0,127}));
  connect(switch1.y, heaPum.TSet) annotation (Line(points={{14,-51},{14,-46},{14,
          -41},{12,-41}}, color={0,0,127}));
  connect(T_dhw.y, switch1.u1) annotation (Line(points={{30.6,-79},{26,-79},{26,
          -74},{22,-74}},
                     color={0,0,127}));
  connect(dhw.y, switch1.u2) annotation (Line(points={{-31,-122},{14,-122},{14,
          -74}}, color={255,0,255}));
  connect(dhw.y, switch2.u2) annotation (Line(points={{-31,-122},{130,-122},{
          130,-76}},                     color={255,0,255}));
  connect(T_dhw_r.y, switch2.u1) annotation (Line(points={{112.3,-108},{116,
          -108},{116,-76},{122,-76}},
                           color={0,0,127}));
  connect(T_room_r.y, switch2.u3) annotation (Line(points={{141.6,-87},{142,-87},
          {142,-76},{138,-76}},color={0,0,127}));
  connect(port_a, senTem_supply.port_a) annotation (Line(points={{-340,0},{-296,
          0},{-296,-1.77636e-15},{-252,-1.77636e-15}}, color={0,127,255}));
  connect(cooling.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-95.3,
          147},{-34,147},{-34,142},{-58,142},{-58,50},{-118,50},{-118,14},{-102,
          14}}, color={0,0,127}));
  connect(senTem_supply.T, no_free_cool.u) annotation (Line(points={{-239,-15.4},
          {-239,-29},{-216.6,-29}}, color={0,0,127}));
  connect(no_free_cool.y, T_room.u2) annotation (Line(points={{-186.7,-29},{
          -176,-29},{-176,-70}},                  color={255,0,255}));
  connect(T_set_active_cooling.y, T_room.u1)
    annotation (Line(points={{-155,-70},{-168,-70}}, color={0,0,127}));
  connect(T_set_free_cooling.y, T_room.u3)
    annotation (Line(points={{-199,-70},{-184,-70}}, color={0,0,127}));
  connect(T_room.y, switch1.u3) annotation (Line(points={{-176,-93},{-124,-93},
          {-124,-74},{6,-74}}, color={0,0,127}));
  connect(HP_Power.y, P_el)
    annotation (Line(points={{176.9,94},{212,94}}, color={0,0,127}));
  connect(senTem_Return.T, Lim50to95.u)
    annotation (Line(points={{67,15.4},{67,43},{15.4,43}}, color={0,0,127}));
  connect(senTem_Return.T, Lim105to150.u) annotation (Line(points={{67,15.4},{
          67,96},{17.4,96},{17.4,95}}, color={0,0,127}));
  connect(Pressure_Drop.y, dpOut)
    annotation (Line(points={{181.2,70},{212,70}}, color={0,0,127}));
  connect(senTem_supply.port_b, val.port_a) annotation (Line(points={{-226,
          -1.77636e-15},{-196,-1.77636e-15},{-196,0},{-164,0}}, color={0,127,
          255}));
  connect(val.port_b, HX.ports[1])
    annotation (Line(points={{-144,0},{-68,0},{-68,4}}, color={0,127,255}));
  connect(HX.ports[2], senTem4.port_a)
    annotation (Line(points={{-64,4},{-64,-16},{-48,-16}}, color={0,127,255}));
  connect(dhw_input, Vol_Flow_to_Heatcapacityflow.u)
    annotation (Line(points={{-168,-122},{-118.4,-122}}, color={0,0,127}));
  connect(Vol_Flow_to_Heatcapacityflow.y, dhw.u)
    annotation (Line(points={{-90.8,-122},{-54,-122}}, color={0,0,127}));
  connect(dT.y, cp_dT.u) annotation (Line(points={{-291,54},{-292,54},{-292,54},
          {-278,54}}, color={0,0,127}));
  connect(cp_dT.y, m_flow.u2)
    annotation (Line(points={{-255,54},{-214,54},{-214,58}}, color={0,0,127}));
  connect(Val_Position.u, smoothMax.y)
    annotation (Line(points={{-155,50.2},{-155,62.7}}, color={0,0,127}));
  connect(m_flow.y, smoothMax.u2) annotation (Line(points={{-191,64},{-191,110},
          {-162,110},{-162,92.6},{-162.8,92.6}}, color={0,0,127}));
  connect(Val_Position.y, val.y) annotation (Line(points={{-155,24.9},{-155,
          18.45},{-154,18.45},{-154,12}}, color={0,0,127}));
  connect(senTem_supply.T, dT.u1) annotation (Line(points={{-239,-15.4},{-324.5,
          -15.4},{-324.5,48},{-314,48}}, color={0,0,127}));
  connect(senTem_Return.T, dT.u2) annotation (Line(points={{67,15.4},{67,124},{
          -354,124},{-354,60},{-314,60}}, color={0,0,127}));
  connect(MaxDemand.y, m_flow.u1) annotation (Line(points={{-244.2,89},{-229.1,
          89},{-229.1,70},{-214,70}}, color={0,0,127}));
  connect(m_flo_min.y, smoothMax.u1) annotation (Line(points={{-128.9,101},{
          -148,101},{-148,92.6},{-147.2,92.6}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,
            -160},{220,120}}),
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
        coordinateSystem(preserveAspectRatio=false, extent={{-340,-160},{220,
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
