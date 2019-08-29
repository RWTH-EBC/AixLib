within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP_wrong "Substation model for  low-temperature networks for buildings with 
  heat pump and chiller"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);
      replaceable package MediumBuilding = AixLib.Media.Water
      "Medium in the building heating system"
      annotation (choicesAllMatching = true);
    final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
    final parameter Modelica.SIunits.SpecificHeatCapacity cp_default = Medium.specificHeatCapacityCp(sta_default)
                                                                                  "Cp-value of Water";

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

  Modelica.Blocks.Math.Gain dhw_load(k=-4180*40/3600)
    annotation (Placement(transformation(extent={{-250,-116},{-230,-96}})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumBuilding,tau=0,
    m_flow_nominal=m_flow_nominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,-40})));
  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=600,
    nPorts=2,
    m_flow_nominal=2*m_flow_nominal,
    T_start=283.15)
    annotation (Placement(transformation(extent={{186,0},{206,20}})));

  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,m_flow_nominal=2*m_flow_nominal, tau=0,
    allowFlowReversal=false,
    T_start=283.15)
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));
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
        origin={34,-38})));
  Modelica.Blocks.Sources.RealExpression T_dhw(y=273.15 + 65)
    annotation (Placement(transformation(extent={{52,-90},{32,-70}})));
  MixingVolumes.MixingVolume vol2(
  redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=m_flow_nominal,
    V=0.15) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-54,10})));
  Sensors.TemperatureTwoPort senTem4(
  redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    T_start=283.15)
    annotation (Placement(transformation(extent={{-48,-26},{-28,-6}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=if free_cooling.y ==
        true then 0 else -min(Q_flow_input[1], 0))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-54,72})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-54,40})));
  Modelica.Blocks.Sources.RealExpression heatload(y=if free_cooling.y == true
         then Q_flow_input[1] else max(Q_flow_input[1], 0))
    annotation (Placement(transformation(extent={{-256,-82},{-236,-62}})));
  Movers.FlowControlled_m_flow fan(
     redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    use_inputFilter=true,
    y_start=1,
    nominalValuesDefineDefaultPressureCurve=false,
    addPowerToMedium=true,
    m_flow_nominal=0.5,
    m_flow_start=0.2)
    annotation (Placement(transformation(extent={{-174,-10},{-154,10}})));
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
    annotation (Placement(transformation(extent={{-142,-154},{-122,-134}})));
  Sources.MassFlowSource_T boundary1(
    redeclare package Medium =MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{120,-48},{100,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=senTem5.T - heatload.y
        /(4180*m_flow_nominal))
    annotation (Placement(transformation(extent={{166,-48},{146,-28}})));
  Modelica.Blocks.Sources.RealExpression T_room_r(y=HZ.m_flow)
    annotation (Placement(transformation(extent={{162,-30},{142,-10}})));
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
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,-58})));
  Modelica.Blocks.Sources.TimeTable T_set_free_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        50; 2.2e+07,273.15 + 50; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-222,-62},{-202,-42}})));
  Modelica.Blocks.Logical.GreaterThreshold free_cooling(threshold=273.15 + 18)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-194,-28})));
  Modelica.Blocks.Sources.TimeTable T_set_active_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        10; 2.2e+07,273.15 + 10; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-136,-62},{-156,-42}})));
  Modelica.Blocks.Logical.Switch T_room annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-180,-64})));
  Utilities.Sensors.FuelCounter pump
    annotation (Placement(transformation(extent={{-146,6},{-126,26}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=1)
    annotation (Placement(transformation(extent={{-130,36},{-150,56}})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{200,82},{220,102}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=pump.counter +
        fuelCounter.counter)
    annotation (Placement(transformation(extent={{154,80},{174,100}})));
  Actuators.Valves.ThreeWayEqualPercentageLinear val(
   redeclare package Medium = MediumBuilding,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    riseTime=20,
    m_flow_nominal=m_flow_nominal,
    R=10,
    from_dp=false,
    m_flow_small=0.0001,
    verifyFlowReversal=false,
    y_start=1,
    T_start=308.15,
    dpValve_nominal=10000)
               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-96})));
  Movers.FlowControlled_m_flow fan1(
  redeclare package Medium =MediumBuilding,
      inputType=AixLib.Fluid.Types.InputType.Continuous,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false,
    y_start=1,
    m_flow_start=m_flow_nominal,
    m_flow_small=0,
    use_inputFilter=true,
    addPowerToMedium=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-72,-50},{-92,-30}})));
  MixingVolumes.MixingVolume vol(
   redeclare package Medium =MediumBuilding,
    nPorts=2,
    m_flow_nominal=m_flow_nominal,
    use_C_flow=false,
    V=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    allowFlowReversal=true)
           annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-6,-150})));
  FixedResistances.Junction jun(
     redeclare package Medium =MediumBuilding,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal={0,0,0},
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal={2,-2,2},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    verifyFlowReversal=false)
    annotation (Placement(transformation(extent={{78,-48},{58,-28}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-208,-142},{-188,-122}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uHigh=273.15 + 64,
    uLow=273.15 + 60,
    pre_y_start=true)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-94})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=1, realFalse=0)
    annotation (Placement(transformation(extent={{-140,-108},{-120,-88}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{-110,-34},{-90,-14}})));
  Sensors.MassFlowRate HZ(redeclare package Medium = MediumBuilding)
    annotation (Placement(transformation(extent={{-92,-156},{-112,-136}})));
  Sensors.TemperatureTwoPort senTem5(
  redeclare package Medium = MediumBuilding,
  m_flow_nominal=m_flow_nominal,
  tau=0)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-78,-124})));
  Sources.FixedBoundary bou(redeclare package Medium = MediumBuilding, nPorts=1)
    annotation (Placement(transformation(extent={{-148,-26},{-128,-6}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-24,-134},{-4,-114}})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(del1.ports[1], port_b) annotation (Line(points={{194,0},{220,0}},
                       color={0,127,255}));
  connect(senTem4.port_b, heaPum.port_a2) annotation (Line(points={{-28,-16},{-20,
          -16},{-20,-26},{-10,-26}}, color={0,127,255}));
  connect(heaPum.QEva_flow, eva_HM.p)
    annotation (Line(points={{-11,-23},{2,-23},{2,0.4}}, color={0,0,127}));
  connect(heaPum.P, fuelCounter.fuel_in)
    annotation (Line(points={{-11,-32},{-12,-32},{-12,-2}}, color={0,0,127}));
  connect(heaPum.QCon_flow, con_HM.p)
    annotation (Line(points={{-11,-41},{-26,-41},{-26,0.4}}, color={0,0,127}));
  connect(senTem3.port_b, heaPum.port_a1)
    annotation (Line(points={{24,-38},{10,-38}}, color={0,127,255}));
  connect(heaPum.port_b1, senTem1.port_a) annotation (Line(points={{-10,-38},{-20,
          -38},{-20,-40},{-30,-40}},
                               color={0,127,255}));
  connect(Q_flow_input[2], dhw_load.u) annotation (Line(points={{-252,-38},{-260,
          -38},{-260,-106},{-252,-106}},
                                       color={0,0,127}));
  connect(switch1.y, heaPum.TSet) annotation (Line(points={{14,-47},{14,-41},{12,
          -41}},          color={0,0,127}));
  connect(port_a, senTem2.port_a)
    annotation (Line(points={{-260,0},{-242,0}}, color={0,127,255}));
  connect(senTem2.T, free_cooling.u) annotation (Line(points={{-232,-11},{-214,-11},
          {-214,-10},{-194,-10},{-194,-16}}, color={0,0,127}));
  connect(free_cooling.y, T_room.u2) annotation (Line(points={{-194,-39},{-184,-39},
          {-184,-44},{-180,-44},{-180,-52}},      color={255,0,255}));
  connect(T_set_active_cooling.y, T_room.u1)
    annotation (Line(points={{-157,-52},{-172,-52}}, color={0,0,127}));
  connect(T_set_free_cooling.y, T_room.u3)
    annotation (Line(points={{-201,-52},{-188,-52}}, color={0,0,127}));
  connect(realExpression3.y, P_el) annotation (Line(points={{175,90},{192,90},{
          192,92},{210,92}}, color={0,0,127}));
  connect(vol2.ports[1], senTem4.port_a) annotation (Line(points={{-64,12},{-64,
          -16},{-48,-16}},         color={0,127,255}));
  connect(fan.P, pump.fuel_in)
    annotation (Line(points={{-153,9},{-146,9},{-146,16}}, color={0,0,127}));
  connect(heaPum.port_b2, senTem.port_a) annotation (Line(points={{10,-26},{20,
          -26},{20,0},{36,0}}, color={0,127,255}));
  connect(senTem.port_b, del1.ports[2])
    annotation (Line(points={{56,0},{198,0}}, color={0,127,255}));
  connect(senTem2.port_b, fan.port_a)
    annotation (Line(points={{-222,0},{-174,0}}, color={0,127,255}));
  connect(fan.port_b, vol2.ports[2])
    annotation (Line(points={{-154,0},{-64,0},{-64,8}}, color={0,127,255}));
  connect(vol2.heatPort, prescribedHeatFlow1.port)
    annotation (Line(points={{-54,20},{-54,30}}, color={191,0,0}));
  connect(prescribedHeatFlow1.Q_flow, realExpression6.y)
    annotation (Line(points={{-54,50},{-54,61},{-54,61}}, color={0,0,127}));
  connect(realExpression2.y, fan.m_flow_in)
    annotation (Line(points={{-151,46},{-164,46},{-164,12}}, color={0,0,127}));
  connect(senTem1.port_b, fan1.port_a)
    annotation (Line(points={{-50,-40},{-72,-40}}, color={0,127,255}));
  connect(val.port_3, vol.ports[1]) annotation (Line(points={{-70,-96},{-46,-96},
          {-46,-140},{-8,-140}},  color={0,127,255}));
  connect(jun.port_2, senTem3.port_a)
    annotation (Line(points={{58,-38},{44,-38}}, color={0,127,255}));
  connect(boundary1.ports[1], jun.port_1)
    annotation (Line(points={{100,-38},{78,-38}}, color={0,127,255}));
  connect(dhw_load.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-229,
          -106},{-228,-106},{-228,-132},{-208,-132}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2)
    annotation (Line(points={{8.88178e-16,-83},{14,-83},{14,-70}},
                                                          color={255,0,255}));
  connect(T_dhw.y, switch1.u3)
    annotation (Line(points={{31,-80},{22,-80},{22,-70}}, color={0,0,127}));
  connect(T_room.y, switch1.u1) annotation (Line(points={{-180,-75},{-86,-75},{-86,
          -70},{6,-70}}, color={0,0,127}));
  connect(hysteresis.y, booleanToReal.u) annotation (Line(points={{8.88178e-16,-83},
          {-80,-83},{-80,-82},{-142,-82},{-142,-98}},
                                                  color={255,0,255}));
  connect(booleanToReal.y, val.y) annotation (Line(points={{-119,-98},{-106,-98},
          {-106,-96},{-92,-96}},    color={0,0,127}));
  connect(realExpression1.y, fan1.m_flow_in)
    annotation (Line(points={{-89,-24},{-82,-24},{-82,-28}}, color={0,0,127}));
  connect(val.port_1, senTem5.port_a) annotation (Line(points={{-80,-106},{-80,-110},
          {-78,-110},{-78,-114}}, color={0,127,255}));
  connect(senTem5.port_b, HZ.port_a) annotation (Line(points={{-78,-134},{-78,-146},
          {-92,-146}}, color={0,127,255}));
  connect(HZ.port_b, bou2.ports[1]) annotation (Line(points={{-112,-146},{-118,-146},
          {-118,-144},{-122,-144}}, color={0,127,255}));
  connect(T_room_r.y, boundary1.m_flow_in) annotation (Line(points={{141,-20},{132,
          -20},{132,-30},{122,-30}}, color={0,0,127}));
  connect(realExpression.y, boundary1.T_in) annotation (Line(points={{145,-38},{
          134,-38},{134,-34},{122,-34}}, color={0,0,127}));
  connect(bou.ports[1], fan1.port_a) annotation (Line(points={{-128,-16},{-72,-16},
          {-72,-40}}, color={0,127,255}));
  connect(fan1.port_b, val.port_2) annotation (Line(points={{-92,-40},{-94,-40},
          {-94,-86},{-80,-86}}, color={0,127,255}));
  connect(vol.ports[2], jun.port_3) annotation (Line(points={{-4,-140},{68,-140},
          {68,-48}}, color={0,127,255}));
  connect(temperatureSensor.T, hysteresis.u) annotation (Line(points={{-4,-124},
          {-8.88178e-16,-124},{-8.88178e-16,-106}}, color={0,0,127}));
  connect(vol.heatPort, temperatureSensor.port) annotation (Line(points={{-16,
          -150},{-20,-150},{-20,-148},{-24,-148},{-24,-124}}, color={191,0,0}));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation (Line(points={{-188,
          -132},{-180,-132},{-180,-134},{-170,-134},{-170,-168},{-16,-168},{-16,
          -150}}, color={191,0,0}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,-200},
            {220,120}}), graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-280,-200},{220,120}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end PumpControlledwithHP_wrong;
