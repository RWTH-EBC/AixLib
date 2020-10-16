within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlledHeatPumpZiyuan "Substation model for  low-temperature networks for buildings with 
  heat pump and chiller"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);
      replaceable package MediumBuilding = AixLib.Media.Water
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
    annotation (Placement(transformation(extent={{-270,-10},{-250,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{210,-10},{230,10}}),
        iconTransformation(extent={{210,-10},{230,10}})));

  Modelica.Blocks.Interfaces.RealInput[2] Q_flow_input
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-272,-68},{-232,-28}}),
        iconTransformation(extent={{232,76},{192,116}})));

  Modelica.Blocks.Math.Gain dhw_load(k=4180*40/3600)
    annotation (Placement(transformation(extent={{-250,-116},{-230,-96}})));
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

  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,m_flow_nominal=2*m_flow_nominal, tau=0,
    T_start=283.15)
    annotation (Placement(transformation(extent={{44,-20},{64,0}})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium =Medium,allowFlowReversal=false, tau=0,
    m_flow_nominal=2*m_flow_nominal)
    annotation (Placement(transformation(extent={{-242,10},{-222,-10}})));
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
    annotation (Placement(transformation(extent={{52,-90},{32,-70}})));
  MixingVolumes.MixingVolume vol2(
  redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=m_flow_nominal,
    V=0.15) annotation (Placement(transformation(extent={{-76,4},{-56,24}})));
  Sensors.TemperatureTwoPort senTem4(
  redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    T_start=283.15)
    annotation (Placement(transformation(extent={{-48,-26},{-28,-6}})));
  Modelica.Blocks.Sources.RealExpression cooling(y=if free_cooling.y == true
         then 0 else -min(Q_flow_input[1], 0)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-102,40})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,14})));
  Modelica.Blocks.Sources.RealExpression heatload(y=if free_cooling.y == true
         then Q_flow_input[1] else max(Q_flow_input[1], 0))
    annotation (Placement(transformation(extent={{-256,-82},{-236,-62}})));
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
  Sources.FixedBoundary bou2(
  redeclare package Medium =MediumBuilding, nPorts=1)
    annotation (Placement(transformation(extent={{-124,-48},{-104,-28}})));
  Sources.MassFlowSource_T boundary1(
    redeclare package Medium =MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{120,-48},{100,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{166,-38},{146,-18}})));
  Modelica.Blocks.Sources.RealExpression T_room_r(y=T_room.y - heatload.y/(4180
        *m_flow_nominal))
    annotation (Placement(transformation(extent={{168,-92},{148,-72}})));
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
  Modelica.Blocks.Sources.RealExpression T_dhw_r(y=T_dhw.y - dhw_load.y/(4180*
        m_flow_nominal))
    annotation (Placement(transformation(extent={{88,-88},{108,-68}})));
  Modelica.Blocks.Logical.GreaterThreshold dhw(threshold=10)
    annotation (Placement(transformation(extent={{-202,-116},{-182,-96}})));
  Modelica.Blocks.Sources.TimeTable T_set_free_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        50; 2.2e+07,273.15 + 50; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-220,-80},{-200,-60}})));
  Modelica.Blocks.Logical.GreaterThreshold free_cooling(threshold=273.15 + 18)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-194,-34})));
  Modelica.Blocks.Sources.TimeTable T_set_active_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        10; 2.2e+07,273.15 + 10; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-134,-80},{-154,-60}})));
  Modelica.Blocks.Logical.Switch T_room annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-176,-82})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=if cooling.y == 0
         then (-1/9*(limiter.y - 273.15) + 1.25)/0.6 else (1/11*(limiter1.y -
        273.15) - 0.76)/0.6)
    annotation (Placement(transformation(extent={{-208,4},{-188,24}})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{200,82},{220,102}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCounter.counter)
    annotation (Placement(transformation(extent={{154,80},{174,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=(-1/9*(limiter.y -
        273.15) + 1.15)/0.6)
    annotation (Placement(transformation(extent={{-202,74},{-182,94}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=max(0.2, max(cooling.y,
        heatload.y)/3295/10)/0.6)
    annotation (Placement(transformation(extent={{-236,54},{-216,74}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=273.15 + 9.5, uMin=273.15 + 5)
    annotation (Placement(transformation(extent={{-12,38},{-32,58}})));
  Modelica.Blocks.Sources.BooleanTable booleanTable(startValue=false, table={0,
        1.2e+07,2.205e+07})
    annotation (Placement(transformation(extent={{-226,30},{-206,50}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-180,30},{-160,50}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=273.15 + 15, uMin=273.15 + 10.5)
    annotation (Placement(transformation(extent={{-14,72},{-34,92}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{202,60},{222,80}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{156,60},{176,80}})));
  Actuators.Valves.TwoWayPressureIndependent val(
  redeclare package Medium = Medium,
    m_flow_nominal=0.6,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05)
    annotation (Placement(transformation(extent={{-164,-10},{-144,10}})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(del1.ports[1], port_b) annotation (Line(points={{194,0},{220,0}},
                       color={0,127,255}));
  connect(senTem.port_b, del1.ports[2]) annotation (Line(points={{64,-10},{110,-10},
          {110,0},{198,0}},   color={0,127,255}));
  connect(senTem4.port_b, heaPum.port_a2) annotation (Line(points={{-28,-16},{-20,
          -16},{-20,-26},{-10,-26}}, color={0,127,255}));
  connect(heaPum.port_b2, senTem.port_a) annotation (Line(points={{10,-26},{28,-26},
          {28,-10},{44,-10}}, color={0,127,255}));
  connect(prescribedHeatFlow1.port, vol2.heatPort) annotation (Line(points={{-82,14},
          {-76,14}},                           color={191,0,0}));
  connect(realExpression.y, boundary1.m_flow_in) annotation (Line(points={{145,-28},
          {140,-28},{140,-26},{122,-26},{122,-30}}, color={0,0,127}));
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
  connect(Q_flow_input[2], dhw_load.u) annotation (Line(points={{-252,-38},{-260,
          -38},{-260,-106},{-252,-106}},
                                       color={0,0,127}));
  connect(switch2.y, boundary1.T_in) annotation (Line(points={{130,-53},{128,-53},
          {128,-34},{122,-34}}, color={0,0,127}));
  connect(switch1.y, heaPum.TSet) annotation (Line(points={{14,-51},{14,-46},{14,
          -41},{12,-41}}, color={0,0,127}));
  connect(T_dhw.y, switch1.u1) annotation (Line(points={{31,-80},{26,-80},{26,-74},
          {22,-74}}, color={0,0,127}));
  connect(dhw.y, switch1.u2) annotation (Line(points={{-181,-106},{14,-106},{14,
          -74}}, color={255,0,255}));
  connect(dhw.y, switch2.u2) annotation (Line(points={{-181,-106},{132,-106},{
          132,-84},{130,-84},{130,-76}}, color={255,0,255}));
  connect(T_dhw_r.y, switch2.u1) annotation (Line(points={{109,-78},{116,-78},{116,
          -76},{122,-76}}, color={0,0,127}));
  connect(T_room_r.y, switch2.u3) annotation (Line(points={{147,-82},{142,-82},{
          142,-76},{138,-76}}, color={0,0,127}));
  connect(dhw_load.y, dhw.u)
    annotation (Line(points={{-229,-106},{-204,-106}}, color={0,0,127}));
  connect(port_a, senTem2.port_a)
    annotation (Line(points={{-260,0},{-242,0}}, color={0,127,255}));
  connect(cooling.y, prescribedHeatFlow1.Q_flow)
    annotation (Line(points={{-102,29},{-102,14}}, color={0,0,127}));
  connect(senTem2.T, free_cooling.u) annotation (Line(points={{-232,-11},{-214,-11},
          {-214,-10},{-194,-10},{-194,-22}}, color={0,0,127}));
  connect(free_cooling.y, T_room.u2) annotation (Line(points={{-194,-45},{-184,
          -45},{-184,-44},{-176,-44},{-176,-70}}, color={255,0,255}));
  connect(T_set_active_cooling.y, T_room.u1)
    annotation (Line(points={{-155,-70},{-168,-70}}, color={0,0,127}));
  connect(T_set_free_cooling.y, T_room.u3)
    annotation (Line(points={{-199,-70},{-184,-70}}, color={0,0,127}));
  connect(T_room.y, switch1.u3) annotation (Line(points={{-176,-93},{-124,-93},
          {-124,-74},{6,-74}}, color={0,0,127}));
  connect(realExpression3.y, P_el) annotation (Line(points={{175,90},{192,90},{
          192,92},{210,92}}, color={0,0,127}));
  connect(senTem.T, limiter.u)
    annotation (Line(points={{54,1},{54,48},{-10,48}}, color={0,0,127}));
  connect(booleanTable.y, switch3.u2)
    annotation (Line(points={{-205,40},{-182,40}}, color={255,0,255}));
  connect(senTem.T, limiter1.u) annotation (Line(points={{54,1},{54,80},{-12,80},
          {-12,82}}, color={0,0,127}));
  connect(realExpression5.y, dpOut)
    annotation (Line(points={{177,70},{212,70}}, color={0,0,127}));
  connect(senTem2.port_b, val.port_a)
    annotation (Line(points={{-222,0},{-164,0}}, color={0,127,255}));
  connect(val.port_b, vol2.ports[1])
    annotation (Line(points={{-144,0},{-68,0},{-68,4}}, color={0,127,255}));
  connect(vol2.ports[2], senTem4.port_a)
    annotation (Line(points={{-64,4},{-64,-16},{-48,-16}}, color={0,127,255}));
  connect(switch3.y, val.y) annotation (Line(points={{-159,40},{-156,40},{-156,12},
          {-154,12}}, color={0,0,127}));
  connect(realExpression4.y, switch3.u1) annotation (Line(points={{-215,64},{
          -200,64},{-200,62},{-182,62},{-182,48}}, color={0,0,127}));
  connect(realExpression4.y, switch3.u3) annotation (Line(points={{-215,64},{
          -200,64},{-200,32},{-182,32}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,
            -120},{220,120}}),
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
        coordinateSystem(preserveAspectRatio=false, extent={{-280,-120},{220,
            120}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end ValveControlledHeatPumpZiyuan;
