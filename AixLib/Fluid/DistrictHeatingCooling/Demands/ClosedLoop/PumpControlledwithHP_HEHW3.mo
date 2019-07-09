within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP_HEHW3 "Substation model for  low-temperature networks for buildings with 
  heat pump and chiller"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);
      replaceable package MediumBuilding = AixLib.Media.Water
      "Medium in the building heating system"
      annotation (choicesAllMatching = true);

    final parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";

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
  AixLib.Fluid.HeatPumps.Carnot_TCon heaPum(redeclare package Medium2 = Medium,
      redeclare package Medium1 = MediumBuilding,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    show_T=true,
    etaCarnot_nominal=0.5,
    dTCon_nominal=10,
    dTEva_nominal=-10,
    QCon_flow_nominal=5000 + heatDemand_max)
    annotation (Placement(transformation(extent={{8,-52},{-12,-72}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow_input
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-304,-66},{-264,-26}}),
        iconTransformation(extent={{232,76},{192,116}})));

  Movers.FlowControlled_m_flow fan5(redeclare package Medium =MediumBuilding,
      inputType=AixLib.Fluid.Types.InputType.Continuous,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false,
    y_start=1,
    m_flow_start=m_flow_nominal,
    m_flow_small=0,
    p_start=200000000,
    T_start=308.15,
    use_inputFilter=true)                                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-110,-72})));
  MixingVolumes.MixingVolume vol1(redeclare package Medium =MediumBuilding,
    V(displayUnit="l") = 0.15,
    m_flow_nominal=m_flow_nominal,
    T_start=298.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{-140,-210},{-120,-230}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-276,-92},{-256,-72}})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumBuilding,tau=0,
    m_flow_nominal=m_flow_nominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-170,-72})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{-134,-106},{-114,-86}})));
  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=600,
    nPorts=2,
    m_flow_nominal=2*m_flow_nominal,
    T_start=283.15)
    annotation (Placement(transformation(extent={{156,-2},{176,18}})));
  Sources.FixedBoundary bou(
    redeclare package Medium = MediumBuilding,
    use_p=true,
    use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-220,-52},{-200,-32}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 36)
    annotation (Placement(transformation(extent={{-274,-120},{-254,-100}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-46,-186})));

  Movers.SpeedControlled_y fan(redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    inputType=AixLib.Fluid.Types.InputType.Continuous,
    m_flow_small=0.00001,
    allowFlowReversal=false,
    use_inputFilter=true,
    y_start=1,
    riseTime=60,
    per(pressure(V_flow={0,m_flow_nominal/1000}, dp={2*dp_nominal,0})),
    p_start=1000000,
    T_start=283.15)
    annotation (Placement(transformation(extent={{-138,-48},{-118,-28}})));
  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,m_flow_nominal=2*m_flow_nominal, tau=0,
    T_start=283.15)
    annotation (Placement(transformation(extent={{46,-58},{66,-38}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-72,-30},{-92,-10}})));
  Sources.FixedBoundary bou1(redeclare package Medium = Medium,          use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-158,-20},{-138,0}})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium =Medium,allowFlowReversal=false, tau=0,
    m_flow_nominal=2*m_flow_nominal)
    annotation (Placement(transformation(extent={{-76,-50},{-56,-30}})));
  Sensors.TemperatureTwoPort senTem3(tau=0, m_flow_nominal=m_flow_nominal,
    redeclare package Medium = MediumBuilding,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-118,-196},{-98,-176}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=max(273.15 + 22, (
        product.y + gain.y/m_flow_nominal/4180)))
    annotation (Placement(transformation(extent={{-236,-230},{-216,-210}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-192,-230},{-172,-210}})));
  FixedResistances.Junction jun1(
    redeclare package Medium =MediumBuilding,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal={0,0,0},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal={2,-2,2})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={82,-90})));
  MixingVolumes.MixingVolume vol(redeclare package Medium = MediumBuilding,
    V=0.15,
    nPorts=2,
    m_flow_nominal=0.15,
    m_flow_small=0.001,
    allowFlowReversal=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    T_start=308.15)                                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={162,-124})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    rising(displayUnit="h") = 18000,
    falling(displayUnit="h") = 18000,
    amplitude=-9000,
    width(displayUnit="h") = 7200,
    period(displayUnit="h") = 79200)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={130,-42})));
  Sensors.TemperatureTwoPort senTem4(redeclare package Medium = MediumBuilding,                               tau=0,
    m_flow_nominal=0.25,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{110,-192},{130,-172}})));
  Sensors.TemperatureTwoPort senTem5(redeclare package Medium =MediumBuilding,                               tau=0,
    m_flow_nominal=0.25,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{112,-152},{92,-172}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=max(273.15 + 33, (
        senTem4.T + trapezoid.y/m_flow_nominal/4180)))
    annotation (Placement(transformation(extent={{98,-134},{118,-114}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{126,-134},{146,-114}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-224,-110})));
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
    VTan=3,
    hTan=3,
    T_start=308.15,
    hHex_a=2,
    hHex_b=0.5,
    TTan_nominal=306.15,
    THex_nominal=338.15)
            annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-42,-162})));
  Sources.FixedBoundary bou2(redeclare package Medium =
        MediumBuilding, nPorts=2)
    annotation (Placement(transformation(extent={{-14,-210},{6,-190}})));
  Movers.FlowControlled_m_flow fan1(
    redeclare package Medium = MediumBuilding,
    m_flow_nominal=0.25,
    use_inputFilter=true,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    T_start=308.15)
    annotation (Placement(transformation(extent={{62,-176},{82,-196}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0.15)
    annotation (Placement(transformation(extent={{42,-222},{62,-202}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-72,-126})));
  Sensors.TemperatureTwoPort senTem6(
    redeclare package Medium =MediumBuilding,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-8,-146},{12,-126}})));
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
        origin={-166,-112})));
  Sensors.TemperatureTwoPort senTem7(
    redeclare package Medium = MediumBuilding,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    T_start=308.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-182,-138})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=273.15 + 55,
    uHigh=273.15 + 60,
    pre_y_start=false)
    annotation (Placement(transformation(extent={{-48,-114},{-28,-94}})));
  Modelica.Blocks.Math.Product product annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-216,-162})));
  Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumBuilding,
    nPorts=1,
    m_flow=m_flow_nominal,
    T=293.15)
    annotation (Placement(transformation(extent={{136,-100},{116,-80}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,-114},{10,-94}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=273.15 + 35)
    annotation (Placement(transformation(extent={{-48,-90},{-28,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 65)
    annotation (Placement(transformation(extent={{-44,-138},{-24,-118}})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(del1.ports[1], port_b) annotation (Line(points={{164,-2},{194,-2},{194,
          0},{220,0}}, color={0,127,255}));
  connect(Q_flow_input, gain.u) annotation (Line(points={{-284,-46},{-288,-46},{
          -288,-82},{-278,-82}},   color={0,0,127}));
  connect(heaPum.port_b2, senTem.port_a) annotation (Line(points={{8,-56},{26,-56},
          {26,-48},{46,-48}}, color={0,127,255}));
  connect(senTem.port_b, del1.ports[2]) annotation (Line(points={{66,-48},{110,-48},
          {110,-2},{168,-2}}, color={0,127,255}));
  connect(const.y, fan.y)
    annotation (Line(points={{-93,-20},{-128,-20},{-128,-26}},
                                                            color={0,0,127}));
  connect(fan.port_b, senTem2.port_a) annotation (Line(points={{-118,-38},{-98,-38},
          {-98,-40},{-76,-40}}, color={0,127,255}));
  connect(senTem2.port_b, heaPum.port_a2) annotation (Line(points={{-56,-40},{-34,
          -40},{-34,-56},{-12,-56}}, color={0,127,255}));
  connect(port_a, fan.port_a) annotation (Line(points={{-260,0},{-184,0},{-184,-38},
          {-138,-38}}, color={0,127,255}));
  connect(jun1.port_2, heaPum.port_a1) annotation (Line(points={{82,-80},{82,-70},
          {8,-70},{8,-68}}, color={0,127,255}));
  connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{-215,-220},{-194,-220}}, color={0,0,127}));
  connect(prescribedTemperature.port, vol1.heatPort) annotation (Line(points={{-172,
          -220},{-140,-220}},                         color={191,0,0}));
  connect(prescribedTemperature1.port, vol.heatPort) annotation (Line(points={{146,
          -124},{152,-124}},          color={191,0,0}));
  connect(realExpression5.y, prescribedTemperature1.T)
    annotation (Line(points={{119,-124},{124,-124}},         color={0,0,127}));
  connect(realExpression2.y, fan5.m_flow_in) annotation (Line(points={{-113,-96},
          {-98,-96},{-98,-84},{-110,-84}}, color={0,0,127}));
  connect(heaPum.port_b1, fan5.port_a) annotation (Line(points={{-12,-68},{-56,-68},
          {-56,-72},{-100,-72}}, color={0,127,255}));
  connect(const1.y, PID.u_s) annotation (Line(points={{-253,-110},{-236,-110}},
                              color={0,0,127}));
  connect(fan5.port_b, senTem1.port_a) annotation (Line(points={{-120,-72},{-146,
          -72},{-146,-62},{-170,-62}}, color={0,127,255}));
  connect(senTem1.T, PID.u_m) annotation (Line(points={{-181,-72},{-224,-72},{-224,
          -98}}, color={0,0,127}));
  connect(tan.heaPorSid, fixedTemperature.port) annotation (Line(points={{-42,-167.6},
          {-46,-167.6},{-46,-176}}, color={191,0,0}));
  connect(bou1.ports[1], fan.port_a)
    annotation (Line(points={{-138,-10},{-138,-38}}, color={0,127,255}));
  connect(bou.ports[1], fan5.port_a) annotation (Line(points={{-200,-42},{-174,-42},
          {-174,-54},{-100,-54},{-100,-72}}, color={0,127,255}));
  connect(senTem4.port_b, vol.ports[1]) annotation (Line(points={{130,-182},{160,
          -182},{160,-134}}, color={0,127,255}));
  connect(vol.ports[2], senTem5.port_a) annotation (Line(points={{164,-134},{154,
          -134},{154,-164},{112,-164},{112,-162}},
                                                 color={0,127,255}));
  connect(fan1.port_b, senTem4.port_a) annotation (Line(points={{82,-186},{96,-186},
          {96,-182},{110,-182}}, color={0,127,255}));
  connect(bou2.ports[1], fan1.port_a) annotation (Line(points={{6,-198},{62,-198},
          {62,-186}}, color={0,127,255}));
  connect(realExpression.y, fan1.m_flow_in)
    annotation (Line(points={{63,-212},{72,-212},{72,-198}}, color={0,0,127}));
  connect(tan.port_b, fan1.port_a) annotation (Line(points={{-42,-172},{-30,-172},
          {-30,-184},{62,-184},{62,-186}}, color={0,127,255}));
  connect(tan.port_a, senTem5.port_b) annotation (Line(points={{-42,-152},{-44,-152},
          {-44,-146},{-2,-146},{-2,-162},{92,-162}}, color={0,127,255}));
  connect(tan.heaPorVol[1], temperatureSensor.port) annotation (Line(points={{-41.55,
          -162},{-48,-162},{-48,-136},{-72,-136}}, color={191,0,0}));
  connect(tan.portHex_b, senTem6.port_a) annotation (Line(points={{-34,-152},{-22,
          -152},{-22,-144},{-8,-144},{-8,-136}}, color={0,127,255}));
  connect(senTem3.port_b, jun1.port_1) annotation (Line(points={{-98,-186},{-84,
          -186},{-84,-232},{220,-232},{220,-106},{82,-106},{82,-100}}, color={0,
          127,255}));
  connect(senTem1.port_b, val.port_2) annotation (Line(points={{-170,-82},{-168,
          -82},{-168,-102},{-166,-102}}, color={0,127,255}));
  connect(PID.y, val.y) annotation (Line(points={{-213,-110},{-182,-110},{-182,-112},
          {-178,-112}}, color={0,0,127}));
  connect(val.port_3, tan.portHex_a) annotation (Line(points={{-156,-112},{-148,
          -112},{-148,-160},{-38.2,-160},{-38.2,-152}}, color={0,127,255}));
  connect(val.port_1, senTem7.port_a) annotation (Line(points={{-166,-122},{-166,
          -128},{-182,-128}},             color={0,127,255}));
  connect(temperatureSensor.T, hysteresis.u) annotation (Line(points={{-72,-116},
          {-58,-116},{-58,-104},{-50,-104}}, color={0,0,127}));
  connect(senTem7.port_b, vol1.ports[1]) annotation (Line(points={{-182,-148},{-186,
          -148},{-186,-190},{-132,-190},{-132,-210}}, color={0,127,255}));
  connect(vol1.ports[2], senTem3.port_a) annotation (Line(points={{-128,-210},{-124,
          -210},{-124,-186},{-118,-186}}, color={0,127,255}));
  connect(PID.y, product.u2) annotation (Line(points={{-213,-110},{-218,-110},{-218,
          -150},{-222,-150}}, color={0,0,127}));
  connect(senTem1.T, product.u1) annotation (Line(points={{-181,-72},{-210,-72},
          {-210,-150}}, color={0,0,127}));
  connect(senTem6.port_b, bou2.ports[2]) annotation (Line(points={{12,-136},{18,
          -136},{18,-192},{6,-192},{6,-202}}, color={0,127,255}));
  connect(boundary.ports[1], jun1.port_3)
    annotation (Line(points={{116,-90},{92,-90}}, color={0,127,255}));
  connect(hysteresis.y, switch1.u2)
    annotation (Line(points={{-27,-104},{-12,-104}}, color={255,0,255}));
  connect(switch1.y, heaPum.TSet)
    annotation (Line(points={{11,-104},{10,-104},{10,-71}}, color={0,0,127}));
  connect(realExpression3.y, switch1.u1) annotation (Line(points={{-27,-80},{
          -20,-80},{-20,-96},{-12,-96}}, color={0,0,127}));
  connect(realExpression4.y, switch1.u3) annotation (Line(points={{-23,-128},{
          -23,-112},{-12,-112}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-260,-180},
            {220,160}}), graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-180},{220,160}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end PumpControlledwithHP_HEHW3;
