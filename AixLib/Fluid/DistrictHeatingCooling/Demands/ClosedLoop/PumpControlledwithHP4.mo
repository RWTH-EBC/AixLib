within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP4 "Substation model for  low-temperature networks for buildings with 
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
  AixLib.Fluid.HeatPumps.Carnot_TCon heaPum(redeclare package Medium1 =
        MediumBuilding,
      redeclare package Medium2 = Medium,
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
    annotation (Placement(transformation(extent={{-294,-46},{-254,-6}}),
        iconTransformation(extent={{232,76},{192,116}})));

  MixingVolumes.MixingVolume vol1(redeclare package Medium = MediumBuilding,
    V(displayUnit="l") = 0.15,
    m_flow_nominal=m_flow_nominal,
    nPorts=2,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-156,-178},{-136,-198}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-258,-62},{-238,-42}})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium =MediumBuilding,tau=0,
    m_flow_nominal=m_flow_nominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-148,-78})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{-290,-150},{-270,-130}})));
  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=600,
    nPorts=2,
    m_flow_nominal=2*m_flow_nominal,
    T_start=283.15)
    annotation (Placement(transformation(extent={{156,-2},{176,18}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMin=0.001*m_flow_nominal,
    yMax=0.999*m_flow_nominal)
    annotation (Placement(transformation(extent={{-210,-92},{-190,-112}})));
  Modelica.Blocks.Sources.Constant const1(k=273.15 + 36)
    annotation (Placement(transformation(extent={{-250,-108},{-230,-88}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-188})));

  Movers.SpeedControlled_y fan(redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    inputType=AixLib.Fluid.Types.InputType.Continuous,
    m_flow_small=0.00001,
    allowFlowReversal=false,
    use_inputFilter=true,
    y_start=1,
    riseTime=60,
    p_start=1000000,
    T_start=283.15,
    per(pressure(V_flow={0,m_flow_nominal/1000}, dp={2*dp_nominal,0})))
    annotation (Placement(transformation(extent={{-138,-48},{-118,-28}})));
  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,m_flow_nominal=2*m_flow_nominal, tau=0,
    T_start=283.15)
    annotation (Placement(transformation(extent={{44,-68},{64,-48}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-72,-30},{-92,-10}})));
  Sources.FixedBoundary bou1(redeclare package Medium = Medium,nPorts=1, use_T=false)
    annotation (Placement(transformation(extent={{-158,-20},{-138,0}})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium = Medium,allowFlowReversal=false, tau=0,
    m_flow_nominal=2*m_flow_nominal)
    annotation (Placement(transformation(extent={{-76,-50},{-56,-30}})));
  Storage.Stratified tan(
    redeclare package Medium = MediumBuilding,
    hTan=3,
    m_flow_nominal=m_flow_nominal,
    dIns=0.3,
    nSeg=4,
    VTan=3,
    tau=1,
    T_start=303.15)
    annotation (Placement(transformation(extent={{-24,-170},{8,-138}})));
  Sensors.TemperatureTwoPort senTem3(tau=0, m_flow_nominal=m_flow_nominal,
    redeclare package Medium = MediumBuilding)
    annotation (Placement(transformation(extent={{-68,-188},{-48,-168}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=max(273.15 + 23, (
        senTem1.T + gain.y/m_flow_nominal/4180)))
    annotation (Placement(transformation(extent={{-266,-198},{-246,-178}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-214,-198},{-194,-178}})));
  FixedResistances.Junction jun(
    redeclare package Medium = MediumBuilding,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal={0,0,0},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    m_flow_nominal={2,-2,-2})
                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-78,-82})));
  FixedResistances.Junction jun1(
    redeclare package Medium = MediumBuilding,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal={0,0,0},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal={2,-2,2})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={62,-102})));
  MixingVolumes.MixingVolume vol(redeclare package Medium =MediumBuilding,
    V=0.15,
    nPorts=2,
    T_start=303.15,
    m_flow_nominal=m_flow_nominal)                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={214,-124})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    rising(displayUnit="h") = 18000,
    falling(displayUnit="h") = 18000,
    amplitude=-9000,
    width(displayUnit="h") = 7200,
    period(displayUnit="h") = 79200)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={130,-42})));
  Movers.FlowControlled_m_flow fan2(redeclare package Medium =MediumBuilding,
    allowFlowReversal=false,
    dp_nominal=dp_nominal,
    T_start=303.15,
    m_flow_nominal=m_flow_nominal,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-76,-118})));
  Sensors.TemperatureTwoPort senTem4(redeclare package Medium = MediumBuilding,                     tau=0,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{26,-164},{46,-144}})));
  Sensors.TemperatureTwoPort senTem5(redeclare package Medium = MediumBuilding,                     tau=0,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=303.15)
    annotation (Placement(transformation(extent={{184,-116},{164,-136}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=m_flow_nominal - PID.y)
    annotation (Placement(transformation(extent={{-122,-130},{-102,-110}})));
  Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumBuilding,
    nPorts=1,
    use_m_flow_in=false,
    m_flow=m_flow_nominal,
    T=298.15)
    annotation (Placement(transformation(extent={{122,-102},{102,-82}})));
  Sources.FixedBoundary bou2(redeclare package Medium = MediumBuilding,nPorts=1)
    annotation (Placement(transformation(extent={{132,-136},{152,-116}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=max(273.15 + 23, (
        senTem4.T + trapezoid.y/(5/60*4180))))
    annotation (Placement(transformation(extent={{158,-60},{178,-40}})));
  Sources.FixedBoundary bou(redeclare package Medium = MediumBuilding, nPorts=1)
    annotation (Placement(transformation(extent={{-218,-76},{-198,-56}})));
  Movers.FlowControlled_m_flow fan3(
    redeclare package Medium = MediumBuilding,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    T_start=308.15,
    m_flow_small=0.0001)   annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-146,-108})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{178,-96},{198,-76}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=30,
    period=86400,
    offset=273.15 + 35,
    startTime=0,
    width=40)
    annotation (Placement(transformation(extent={{-6,-114},{14,-94}})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(del1.ports[1], port_b) annotation (Line(points={{164,-2},{194,-2},{194,
          0},{220,0}}, color={0,127,255}));
  connect(Q_flow_input, gain.u) annotation (Line(points={{-274,-26},{-270,-26},{
          -270,-24},{-264,-24},{-264,-52},{-260,-52}},
                                   color={0,0,127}));
  connect(heaPum.port_b2, senTem.port_a) annotation (Line(points={{8,-56},{26,-56},
          {26,-58},{44,-58}}, color={0,127,255}));
  connect(senTem.port_b, del1.ports[2]) annotation (Line(points={{64,-58},{110,-58},
          {110,-2},{168,-2}}, color={0,127,255}));
  connect(const.y, fan.y)
    annotation (Line(points={{-93,-20},{-128,-20},{-128,-26}},
                                                            color={0,0,127}));
  connect(bou1.ports[1], fan.port_a) annotation (Line(points={{-138,-10},{-138,-38}},
                                           color={0,127,255}));
  connect(fan.port_b, senTem2.port_a) annotation (Line(points={{-118,-38},{-98,-38},
          {-98,-40},{-76,-40}}, color={0,127,255}));
  connect(senTem2.port_b, heaPum.port_a2) annotation (Line(points={{-56,-40},{-34,
          -40},{-34,-56},{-12,-56}}, color={0,127,255}));
  connect(port_a, fan.port_a) annotation (Line(points={{-260,0},{-184,0},{-184,-38},
          {-138,-38}}, color={0,127,255}));
  connect(realExpression1.y, prescribedTemperature.T) annotation (Line(points={{-245,
          -188},{-216,-188}},                               color={0,0,127}));
  connect(vol.ports[1], senTem5.port_a) annotation (Line(points={{204,-122},{194,
          -122},{194,-126},{184,-126}}, color={0,127,255}));
  connect(boundary.ports[1], jun1.port_3) annotation (Line(points={{102,-92},{72,
          -92},{72,-102}},            color={0,127,255}));
  connect(senTem5.port_b, bou2.ports[1]) annotation (Line(points={{164,-126},{
          152,-126}},                   color={0,127,255}));
  connect(jun1.port_2, heaPum.port_a1) annotation (Line(points={{62,-92},{62,-72},
          {28,-72},{28,-68},{8,-68}}, color={0,127,255}));
  connect(heaPum.port_b1, jun.port_1) annotation (Line(points={{-12,-68},{-78,-68},
          {-78,-72}}, color={0,127,255}));
  connect(jun.port_3, senTem1.port_a) annotation (Line(points={{-88,-82},{-118,-82},
          {-118,-68},{-148,-68}}, color={0,127,255}));
  connect(const1.y, PID.u_s) annotation (Line(points={{-229,-98},{-214,-98},{-214,
          -102},{-212,-102}}, color={0,0,127}));
  connect(senTem1.T, PID.u_m) annotation (Line(points={{-159,-78},{-172,-78},{-172,
          -92},{-200,-92},{-200,-90}},  color={0,0,127}));
  connect(prescribedTemperature.port, vol1.heatPort)
    annotation (Line(points={{-194,-188},{-156,-188}}, color={191,0,0}));
  connect(senTem3.port_b, jun1.port_1) annotation (Line(points={{-48,-178},{62,-178},
          {62,-112}}, color={0,127,255}));
  connect(tan.heaPorSid, fixedTemperature.port) annotation (Line(points={{0.96,-154},
          {0,-154},{0,-178},{4.44089e-16,-178}},   color={191,0,0}));
  connect(senTem4.port_b, vol.ports[2]) annotation (Line(points={{46,-154},{196,
          -154},{196,-126},{204,-126}}, color={0,127,255}));
  connect(tan.port_b, senTem4.port_a) annotation (Line(points={{8,-154},{26,-154}},
                                 color={0,127,255}));
  connect(jun.port_2, fan2.port_a) annotation (Line(points={{-78,-92},{-76,-92},
          {-76,-108}},            color={0,127,255}));
  connect(fan2.port_b, tan.port_a) annotation (Line(points={{-76,-128},{-76,-142},
          {-24,-142},{-24,-154}}, color={0,127,255}));
  connect(realExpression.y, fan2.m_flow_in) annotation (Line(points={{-101,-120},
          {-94,-120},{-94,-118},{-88,-118}}, color={0,0,127}));
  connect(senTem1.port_b, fan3.port_a) annotation (Line(points={{-148,-88},{-148,
          -98},{-146,-98}},   color={0,127,255}));
  connect(fan3.port_b, vol1.ports[1]) annotation (Line(points={{-146,-118},{-148,
          -118},{-148,-178}},             color={0,127,255}));
  connect(vol1.ports[2], senTem3.port_a) annotation (Line(points={{-144,-178},{-68,
          -178}},                        color={0,127,255}));
  connect(PID.y, fan3.m_flow_in)
    annotation (Line(points={{-189,-102},{-170,-102},{-170,-108},{-158,-108}},
                                                       color={0,0,127}));
  connect(bou.ports[1], fan3.port_a) annotation (Line(points={{-198,-66},{-174,-66},
          {-174,-98},{-146,-98}}, color={0,127,255}));
  connect(prescribedTemperature1.port, vol.heatPort) annotation (Line(points={{198,
          -86},{214,-86},{214,-114}}, color={191,0,0}));
  connect(realExpression5.y, prescribedTemperature1.T) annotation (Line(points={
          {179,-50},{174,-50},{174,-86},{176,-86}}, color={0,0,127}));
  connect(pulse.y, heaPum.TSet) annotation (Line(points={{15,-104},{18,-104},{18,
          -71},{10,-71}}, color={0,0,127}));
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
end PumpControlledwithHP4;
