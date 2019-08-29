within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP_RE2 "Substation model for  low-temperature networks for buildings with 
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
    final parameter Modelica.SIunits.SpecificHeatCapacity cp_default =   Medium.specificHeatCapacityCp(sta_default)
                                                                                  "Cp-value of Water";
    parameter Modelica.SIunits.HeatFlowRate heatDemand_max "maximum heat demand for scaling of heatpump in Watt";
//    parameter Modelica.SIunits.HeatFlowRate coolingDemand_max=-5000
//                                                              "maximum cooling demand for scaling of chiller in Watt (negative values)";
    parameter Modelica.SIunits.Temperature T_supplyHeating "set temperature of supply heating";
    parameter Modelica.SIunits.Temperature T_supplyCooling "set temperature of supply heating";

 //   parameter Modelica.SIunits.Temperature deltaT_heatingSet "set temperature difference for heating on the site of building";
 //   parameter Modelica.SIunits.Temperature deltaT_coolingSet "set temperature difference for cooling on the building site";

    parameter Modelica.SIunits.Pressure dp_nominal=400000                  "nominal pressure drop";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=(heatDemand_max)/
      cp_default/10
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
  AixLib.Fluid.HeatPumps.Carnot_TCon_RE heaPum(redeclare package Medium2 = Medium,
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
    annotation (Placement(transformation(extent={{8,4},{-12,-16}})));
  Modelica.Blocks.Interfaces.RealInput[2] Q_flow_input
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-280,-60},{-240,-20}}),
        iconTransformation(extent={{232,76},{192,116}})));

  Movers.FlowControlled_m_flow fan5(redeclare package Medium =MediumBuilding,
      inputType=AixLib.Fluid.Types.InputType.Continuous,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false,
    y_start=1,
    m_flow_start=m_flow_nominal,
    m_flow_small=0,
    use_inputFilter=true,
    p_start=200000000,
    T_start=308.15)                                                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-104,-36})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-260,-90},{-240,-70}})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumBuilding,tau=0,
    m_flow_nominal=m_flow_nominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-136,-60})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{-72,-72},{-92,-52}})));
  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=600,
    m_flow_nominal=2*m_flow_nominal,
    T_start=283.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{140,12},{160,32}})));
  Sources.FixedBoundary bou(
    redeclare package Medium = MediumBuilding,
    use_p=true,
    use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-164,-30},{-144,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-6,-210})));

  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,m_flow_nominal=2*m_flow_nominal, tau=0,
    T_start=283.15)
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Sources.FixedBoundary bou1(redeclare package Medium = Medium,          use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-182,14},{-162,34}})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium =Medium,allowFlowReversal=false, tau=0,
    m_flow_nominal=2*m_flow_nominal)
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  Sensors.TemperatureTwoPort senTem3(tau=0, m_flow_nominal=m_flow_nominal,
    redeclare package Medium = MediumBuilding,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-76,-224},{-56,-244}})));
  FixedResistances.Junction jun1(
    redeclare package Medium =MediumBuilding,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal={0,0,0},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal={2,-2,2})
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={92,-24})));
  MixingVolumes.MixingVolume vol(redeclare package Medium = MediumBuilding,
    V=0.15,
    nPorts=2,
    m_flow_nominal=0.15,
    m_flow_small=0.001,
    allowFlowReversal=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_start=308.15)                                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={186,-174})));
  Sensors.TemperatureTwoPort senTem4(redeclare package Medium = MediumBuilding,                               tau=0,
    m_flow_nominal=0.25,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{110,-206},{130,-186}})));
  Sensors.TemperatureTwoPort senTem5(redeclare package Medium =MediumBuilding,                               tau=0,
    m_flow_nominal=0.25,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{144,-158},{124,-178}})));
  Storage.StratifiedEnhancedInternalHex tan(
    redeclare package Medium = MediumBuilding,
    redeclare package MediumHex = MediumBuilding,
    dIns=0.0762,
    m_flow_nominal=m_flow_nominal,
    mHex_flow_nominal=m_flow_nominal,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
   energyDynamicsHex=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nSeg=4,
    Q_flow_nominal=m_flow_nominal*cp_default*30,
    kIns=0.04,
    tau=1,
    hexSegMult=2,
    dExtHex=0.025,
    r_nominal=0.5,
    dpHex_nominal=2500,
    allowFlowReversalHex=false,
    hHex_b=0.5,
    hTan=2,
    hHex_a=1.5,
    VTan=0.4,
    T_start=308.15,
    TTan_nominal=306.15,
    THex_nominal=338.15)
            annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={0,-170})));
  Sources.FixedBoundary bou2(redeclare package Medium =
        MediumBuilding, nPorts=1)
    annotation (Placement(transformation(extent={{120,-158},{100,-138}})));
  Movers.FlowControlled_m_flow fan1(
    redeclare package Medium = MediumBuilding,
    m_flow_nominal=0.25,
    use_inputFilter=true,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    T_start=308.15)
    annotation (Placement(transformation(extent={{82,-156},{62,-176}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-4,-136})));
  Sensors.TemperatureTwoPort senTem6(
    redeclare package Medium =MediumBuilding,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={92,-126})));
  Actuators.Valves.ThreeWayEqualPercentageLinear val(
   redeclare package Medium = MediumBuilding,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_start=308.15,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    riseTime=20,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dp_nominal,
    R=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-134,-134})));
  Sensors.TemperatureTwoPort senTem7(
    redeclare package Medium = MediumBuilding,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    T_start=308.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-132,-166})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=false,
    uLow=273.15 + 60,
    uHigh=273.15 + 65)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={12,-108})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-62})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 65)
    annotation (Placement(transformation(extent={{50,-92},{30,-72}})));
  Modelica.Blocks.Sources.TimeTable T_set(table=[0,273.15 + 35; 7.0e+06,273.15
         + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 + 10;
        2.2e+07,273.15 + 10; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-36,-84},{-16,-64}})));
  Modelica.Blocks.Sources.RealExpression realinput(y=gain.y*opening.y)
    annotation (Placement(transformation(extent={{-200,-264},{-180,-244}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={184,-128})));
  Modelica.Blocks.Math.BooleanToReal opening annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-164,-126})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-164,-264},{-144,-244}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Q_flow_input[2]/3600)
    annotation (Placement(transformation(extent={{104,-194},{84,-174}})));
  Actuators.Valves.ThreeWayEqualPercentageLinear val1(
  redeclare package Medium = MediumBuilding,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    riseTime=20,
    m_flow_nominal=m_flow_nominal,
    R=10,
    T_start=308.15,
    dpValve_nominal=2000)
          annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-132,-190})));
  Sensors.MassFlowRate senMasFlo( redeclare package Medium = MediumBuilding) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-132,-220})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=(gain.y - realinput.y))
    annotation (Placement(transformation(extent={{-234,-144},{-254,-124}})));
  MixingVolumes.MixingVolume vol1(
    nPorts=2,
    redeclare package Medium = MediumBuilding,
    m_flow_nominal=m_flow_nominal,
    V=0.15)
    annotation (Placement(transformation(extent={{-122,-244},{-102,-264}})));
  Modelica.Blocks.Sources.RealExpression Bypass(y=if gain.y == 0 then 0 else 1)
    annotation (Placement(transformation(extent={{-180,-200},{-160,-180}})));
  Movers.FlowControlled_m_flow fan(
     dp_nominal= dp_nominal,
     redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    use_inputFilter=true,
    y_start=1,
    m_flow_nominal=2,
    m_flow_start=1)
    annotation (Placement(transformation(extent={{-142,-8},{-122,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=1)
    annotation (Placement(transformation(extent={{-92,16},{-112,36}})));
  Utilities.Sensors.EnergyMeter con_HM annotation (Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=90,
        origin={-36,30})));
  Utilities.Sensors.EnergyMeter eva_HM annotation (Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=90,
        origin={-4,30})));
  Utilities.Sensors.FuelCounter fuelCounter annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,30})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(heaPum.port_b2, senTem.port_a) annotation (Line(points={{8,0},{46,0}},
                              color={0,127,255}));
  connect(senTem2.port_b, heaPum.port_a2) annotation (Line(points={{-58,0},{-12,
          0}},                       color={0,127,255}));
  connect(realExpression2.y, fan5.m_flow_in) annotation (Line(points={{-93,-62},
          {-98,-62},{-98,-48},{-104,-48}}, color={0,0,127}));
  connect(heaPum.port_b1, fan5.port_a) annotation (Line(points={{-12,-12},{-56,-12},
          {-56,-36},{-94,-36}},  color={0,127,255}));
  connect(fan5.port_b, senTem1.port_a) annotation (Line(points={{-114,-36},{-136,
          -36},{-136,-50}},            color={0,127,255}));
  connect(tan.heaPorSid, fixedTemperature.port) annotation (Line(points={{-8.88178e-16,
          -175.6},{-6,-175.6},{-6,-200}},
                                    color={191,0,0}));
  connect(bou.ports[1], fan5.port_a) annotation (Line(points={{-144,-20},{-94,
          -20},{-94,-36}},                   color={0,127,255}));
  connect(senTem4.port_b, vol.ports[1]) annotation (Line(points={{130,-196},{176,
          -196},{176,-172}}, color={0,127,255}));
  connect(vol.ports[2], senTem5.port_a) annotation (Line(points={{176,-176},{
          144,-176},{144,-168}},                 color={0,127,255}));
  connect(bou2.ports[1], fan1.port_a) annotation (Line(points={{100,-148},{82,
          -148},{82,-166}},
                      color={0,127,255}));
  connect(tan.heaPorVol[1], temperatureSensor.port) annotation (Line(points={{0.45,
          -170},{-4,-170},{-4,-146}},              color={191,0,0}));
  connect(tan.portHex_b, senTem6.port_a) annotation (Line(points={{8,-160},{8,
          -146},{92,-146},{92,-136}},            color={0,127,255}));
  connect(senTem1.port_b, val.port_2) annotation (Line(points={{-136,-70},{-136,
          -124},{-134,-124}},            color={0,127,255}));
  connect(val.port_1, senTem7.port_a) annotation (Line(points={{-134,-144},{-134,
          -156},{-132,-156}},             color={0,127,255}));
  connect(temperatureSensor.T, hysteresis.u) annotation (Line(points={{-4,-126},
          {12,-126},{12,-120}},              color={0,0,127}));
  connect(jun1.port_2, heaPum.port_a1) annotation (Line(points={{82,-24},{16,-24},
          {16,-12},{8,-12}}, color={0,127,255}));
  connect(fixedTemperature1.port, vol.heatPort) annotation (Line(points={{184,-138},
          {184,-164},{186,-164}},            color={191,0,0}));
  connect(senTem6.port_b, jun1.port_3)
    annotation (Line(points={{92,-116},{92,-34}}, color={0,127,255}));
  connect(heaPum.TSet, switch1.y)
    annotation (Line(points={{10,-15},{10,-51}}, color={0,0,127}));
  connect(realExpression4.y, switch1.u3)
    annotation (Line(points={{29,-82},{18,-82},{18,-74}}, color={0,0,127}));
  connect(T_set.y, switch1.u1)
    annotation (Line(points={{-15,-74},{2,-74}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2) annotation (Line(points={{12,-97},{12,-84},{
          10,-84},{10,-74}}, color={255,0,255}));
  connect(senTem3.port_b, jun1.port_1) annotation (Line(points={{-56,-234},{218,
          -234},{218,-24},{102,-24}},color={0,127,255}));
  connect(tan.portHex_a, val.port_3) annotation (Line(points={{3.8,-160},{4,-160},
          {4,-152},{-124,-152},{-124,-134}}, color={0,127,255}));

  connect(opening.y, val.y) annotation (Line(points={{-153,-126},{-150,-126},{-150,
          -134},{-146,-134}}, color={0,0,127}));

  connect(realExpression.y, fan1.m_flow_in) annotation (Line(points={{83,-184},
          {78,-184},{78,-178},{72,-178}},color={0,0,127}));
  connect(Q_flow_input[1], gain.u) annotation (Line(points={{-260,-50},{-262,-50},
          {-262,-80},{-262,-80}}, color={0,0,127}));
  connect(senTem7.port_b, val1.port_2) annotation (Line(points={{-132,-176},{-132,
          -180}},                                     color={0,127,255}));
  connect(hysteresis.y, opening.u) annotation (Line(points={{12,-97},{12,-106},
          {-176,-106},{-176,-126}}, color={255,0,255}));
  connect(val1.port_1, senMasFlo.port_a)
    annotation (Line(points={{-132,-200},{-132,-210}}, color={0,127,255}));
  connect(senMasFlo.port_b, vol1.ports[1]) annotation (Line(points={{-132,-230},
          {-132,-244},{-114,-244}}, color={0,127,255}));
  connect(vol1.ports[2], senTem3.port_a) annotation (Line(points={{-110,-244},{-96,
          -244},{-96,-246},{-76,-246},{-76,-234}}, color={0,127,255}));
  connect(prescribedHeatFlow.port, vol1.heatPort)
    annotation (Line(points={{-144,-254},{-122,-254}}, color={191,0,0}));
  connect(Bypass.y, val1.y)
    annotation (Line(points={{-159,-190},{-144,-190}}, color={0,0,127}));
  connect(fan.port_b, senTem2.port_a) annotation (Line(points={{-122,2},{-100,2},
          {-100,0},{-78,0}}, color={0,127,255}));
  connect(bou1.ports[1], fan.port_a) annotation (Line(points={{-162,24},{-142,24},
          {-142,2}}, color={0,127,255}));
  connect(realExpression5.y, fan.m_flow_in) annotation (Line(points={{-113,26},
          {-122,26},{-122,28},{-132,28},{-132,14}}, color={0,0,127}));
  connect(senTem.port_b, del1.ports[1])
    annotation (Line(points={{66,0},{148,0},{148,12}}, color={0,127,255}));
  connect(del1.ports[2], port_b) annotation (Line(points={{152,12},{152,12},{
          152,0},{220,0}}, color={0,127,255}));
  connect(port_a, fan.port_a) annotation (Line(points={{-260,0},{-202,0},{-202,
          2},{-142,2}}, color={0,127,255}));
  connect(realinput.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-179,-254},{-164,-254}}, color={0,0,127}));
  connect(val1.port_3, senTem3.port_a) annotation (Line(points={{-122,-190},{
          -76,-190},{-76,-234}}, color={0,127,255}));
  connect(tan.port_b, senTem4.port_a) annotation (Line(points={{0,-180},{0,-196},
          {110,-196}}, color={0,127,255}));
  connect(senTem5.port_b, fan1.port_a) annotation (Line(points={{124,-168},{104,
          -168},{104,-166},{82,-166}}, color={0,127,255}));
  connect(fan1.port_b, tan.port_a) annotation (Line(points={{62,-166},{32,-166},
          {32,-160},{0,-160}}, color={0,127,255}));
  connect(eva_HM.p, heaPum.QEva_flow)
    annotation (Line(points={{-4,24.4},{-4,3},{-13,3}}, color={0,0,127}));
  connect(heaPum.P, fuelCounter.fuel_in)
    annotation (Line(points={{-13,-6},{-20,-6},{-20,20}}, color={0,0,127}));
  connect(heaPum.QCon_flow, con_HM.p) annotation (Line(points={{-13,-15},{-36,
          -15},{-36,24.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-260,-280},
            {220,60}}),  graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-280},{220,60}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end PumpControlledwithHP_RE2;
