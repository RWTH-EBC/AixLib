within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP_V2 "Substation model for  low-temperature networks for buildings with 
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

  Movers.FlowControlled_m_flow fan5(redeclare package Medium =MediumBuilding,
      inputType=AixLib.Fluid.Types.InputType.Continuous,
    m_flow_nominal=m_flow_nominal,
    allowFlowReversal=false,
    y_start=1,
    m_flow_start=m_flow_nominal,
    m_flow_small=0,
    use_inputFilter=true,
    addPowerToMedium=false,
    T_start=308.15)                                                    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-68,-42})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-252,-84},{-232,-64}})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumBuilding,tau=0,
    m_flow_nominal=m_flow_nominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-122,-58})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{-106,-68},{-86,-48}})));
  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=600,
    nPorts=2,
    m_flow_nominal=2*m_flow_nominal,
    T_start=283.15)
    annotation (Placement(transformation(extent={{186,0},{206,20}})));
  Sources.FixedBoundary bou(
    redeclare package Medium = MediumBuilding,
    use_p=true,
    use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-108,-34},{-88,-14}})));

  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,m_flow_nominal=2*m_flow_nominal, tau=0,
    T_start=283.15)
    annotation (Placement(transformation(extent={{44,-20},{64,0}})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium =Medium,allowFlowReversal=false, tau=0,
    m_flow_nominal=2*m_flow_nominal)
    annotation (Placement(transformation(extent={{-238,12},{-218,-8}})));
  FixedResistances.Junction jun1(
    redeclare package Medium =MediumBuilding,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    dp_nominal={0,0,0},
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal={2,-2,2},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
    verifyFlowReversal=false)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={76,-40})));
  Sensors.TemperatureTwoPort senTem4(redeclare package Medium = MediumBuilding,                               tau=0,
    m_flow_nominal=0.25,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{76,-190},{96,-170}})));
  Sensors.TemperatureTwoPort senTem5(redeclare package Medium =MediumBuilding,                               tau=0,
    m_flow_nominal=0.25,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{88,-142},{68,-162}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-18,-144})));
  Sensors.TemperatureTwoPort senTem6(
    redeclare package Medium =MediumBuilding,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-112})));
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
    dpValve_nominal=dp_nominal,
    y_start=1,
    T_start=308.15)
          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-120,-112})));
  Sensors.TemperatureTwoPort senTem7(
    redeclare package Medium = MediumBuilding,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    T_start=308.15) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-120,-140})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=false,
    uLow=273.15 + 60,
    uHigh=273.15 + 64)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={2,-106})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,-66})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=273.15 + 65)
    annotation (Placement(transformation(extent={{56,-88},{36,-68}})));
  MixingVolumes.MixingVolume vol2(
  redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=m_flow_nominal,
    V=0.15) annotation (Placement(transformation(extent={{-76,4},{-56,24}})));
  Sensors.TemperatureTwoPort senTem8(
  redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    T_start=283.15)
    annotation (Placement(transformation(extent={{-48,-24},{-28,-4}})));
  Modelica.Blocks.Sources.RealExpression cooling(y=max(0, gain.y))
    annotation (Placement(transformation(extent={{-76,30},{-96,50}})));
  Modelica.Blocks.Math.BooleanToReal opening(realTrue=1, realFalse=0)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-160,-112})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Sensors.MassFlowRate HZ(redeclare package Medium = MediumBuilding)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-120,-170})));
  Modelica.Blocks.Sources.RealExpression heatload(y=min(0, gain.y))
    annotation (Placement(transformation(extent={{-276,-110},{-256,-90}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=max(0.2, max(cooling.y,
        heaPum.QCon_flow)/3295/10))
    annotation (Placement(transformation(extent={{-124,10},{-144,30}})));
  Modelica.Blocks.Sources.TimeTable T_set_freeCooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        50; 2.2e+07,273.15 + 50; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-232,-60},{-212,-40}})));
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
  redeclare package Medium =MediumBuilding,
  nPorts=1)
    annotation (Placement(transformation(extent={{-150,-214},{-130,-194}})));
  Sources.FixedBoundary bou3(
  redeclare package Medium =MediumBuilding,
  nPorts=1)
    annotation (Placement(transformation(extent={{142,-202},{122,-182}})));
  Sources.MassFlowSource_T boundary(
    redeclare package Medium =MediumBuilding,
    nPorts=1,
    use_m_flow_in=true,
    T=293.15)
    annotation (Placement(transformation(extent={{122,-162},{102,-142}})));
  Sources.MassFlowSource_T boundary1(
    redeclare package Medium =MediumBuilding,
    nPorts=1,
    use_m_flow_in=true,
    use_T_in=true)
    annotation (Placement(transformation(extent={{132,-56},{112,-36}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=HZ.m_flow)
    annotation (Placement(transformation(extent={{166,-38},{146,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=senTem7.T + heatload.y
        /(4180*m_flow_nominal))
    annotation (Placement(transformation(extent={{166,-66},{146,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=Q_flow_input[2]/3600)
    annotation (Placement(transformation(extent={{156,-158},{136,-138}})));
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
  Modelica.Blocks.Logical.GreaterThreshold freeCooling(threshold=273.15 + 18)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-204,-20})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-196,-64})));
  Modelica.Blocks.Sources.TimeTable T_set_reverseHP(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        10; 2.2e+07,273.15 + 10; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-160,-60},{-180,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15)
    annotation (Placement(transformation(extent={{-44,-192},{-24,-172}})));
  Storage.Storage storage(
    redeclare package Medium =MediumBuilding,
    n=3,
    d=0.59,
    h=1.5,
    lambda_ins=0.04,
    alpha_in=1500,
    alpha_out=15,
    s_ins=0.1,
    k_HE=1500,
    A_HE=10,
    V_HE=0.2)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={6,-178})));
  Movers.FlowControlled_m_flow fan( dp_nominal= dp_nominal,
     redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    use_inputFilter=true,
    y_start=1,
    m_flow_start=2*m_flow_nominal,
    m_flow_nominal=2,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-166,-10},{-146,10}})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(del1.ports[1], port_b) annotation (Line(points={{194,0},{220,0}},
                       color={0,127,255}));
  connect(senTem.port_b, del1.ports[2]) annotation (Line(points={{64,-10},{110,-10},
          {110,0},{198,0}},   color={0,127,255}));
  connect(realExpression2.y, fan5.m_flow_in) annotation (Line(points={{-85,-58},
          {-78,-58},{-78,-54},{-68,-54}},  color={0,0,127}));
  connect(fan5.port_b, senTem1.port_a) annotation (Line(points={{-78,-42},{-122,
          -42},{-122,-48}},            color={0,127,255}));
  connect(senTem1.port_b, val.port_2) annotation (Line(points={{-122,-68},{-122,
          -90},{-120,-90},{-120,-102}},  color={0,127,255}));
  connect(val.port_1, senTem7.port_a) annotation (Line(points={{-120,-122},{-120,
          -130}},                         color={0,127,255}));
  connect(fan5.port_a, bou.ports[1]) annotation (Line(points={{-58,-42},{-58,-24},
          {-88,-24}},  color={0,127,255}));
  connect(senTem6.port_b, jun1.port_3) annotation (Line(points={{60,-102},{60,-50},
          {76,-50}},                                    color={0,127,255}));
  connect(opening.y, val.y) annotation (Line(points={{-149,-112},{-132,-112}},
                                   color={0,0,127}));
  connect(realExpression4.y, switch1.u3)
    annotation (Line(points={{35,-78},{22,-78}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2) annotation (Line(points={{2,-95},{2,-84},{14,
          -84},{14,-78}}, color={255,0,255}));
  connect(cooling.y, prescribedHeatFlow1.Q_flow)
    annotation (Line(points={{-97,40},{-100,40},{-100,20}}, color={0,0,127}));
  connect(Q_flow_input[1], gain.u) annotation (Line(points={{-252,-58},{-260,-58},
          {-260,-74},{-254,-74}}, color={0,0,127}));
  connect(hysteresis.y, opening.u) annotation (Line(points={{2,-95},{2,-94},{-172,
          -94},{-172,-112}}, color={255,0,255}));
  connect(switch1.y, heaPum.TSet)
    annotation (Line(points={{14,-55},{14,-41},{12,-41}}, color={0,0,127}));
  connect(jun1.port_2, heaPum.port_a1) annotation (Line(points={{66,-40},{38,-40},
          {38,-38},{10,-38}}, color={0,127,255}));
  connect(heaPum.port_b1, fan5.port_a) annotation (Line(points={{-10,-38},{-34,-38},
          {-34,-42},{-58,-42}}, color={0,127,255}));
  connect(senTem8.port_b, heaPum.port_a2) annotation (Line(points={{-28,-14},{-20,
          -14},{-20,-26},{-10,-26}}, color={0,127,255}));
  connect(heaPum.port_b2, senTem.port_a) annotation (Line(points={{10,-26},{28,-26},
          {28,-10},{44,-10}}, color={0,127,255}));
  connect(prescribedHeatFlow1.port, vol2.heatPort) annotation (Line(points={{-80,20},
          {-80,14},{-76,14}},                  color={191,0,0}));
  connect(senTem7.port_b, HZ.port_a)
    annotation (Line(points={{-120,-150},{-120,-160}}, color={0,127,255}));
  connect(HZ.port_b, bou2.ports[1]) annotation (Line(points={{-120,-180},{-120,-204},
          {-130,-204}}, color={0,127,255}));
  connect(senTem4.port_b, bou3.ports[1]) annotation (Line(points={{96,-180},{100,
          -180},{100,-192},{122,-192}}, color={0,127,255}));
  connect(boundary.ports[1], senTem5.port_a)
    annotation (Line(points={{102,-152},{88,-152}}, color={0,127,255}));
  connect(boundary1.ports[1], jun1.port_1) annotation (Line(points={{112,-46},{104,
          -46},{104,-48},{86,-48},{86,-40}}, color={0,127,255}));
  connect(realExpression5.y, boundary.m_flow_in) annotation (Line(points={{135,-148},
          {130,-148},{130,-144},{124,-144}}, color={0,0,127}));
  connect(realExpression3.y, boundary1.T_in)
    annotation (Line(points={{145,-56},{134,-56},{134,-42}}, color={0,0,127}));
  connect(realExpression.y, boundary1.m_flow_in) annotation (Line(points={{145,-28},
          {140,-28},{140,-26},{134,-26},{134,-38}}, color={0,0,127}));
  connect(heaPum.QEva_flow, eva_HM.p)
    annotation (Line(points={{-11,-23},{2,-23},{2,0.4}}, color={0,0,127}));
  connect(heaPum.P, fuelCounter.fuel_in)
    annotation (Line(points={{-11,-32},{-12,-32},{-12,-2}}, color={0,0,127}));
  connect(heaPum.QCon_flow, con_HM.p)
    annotation (Line(points={{-11,-41},{-26,-41},{-26,0.4}}, color={0,0,127}));
  connect(port_a, senTem2.port_a)
    annotation (Line(points={{-260,0},{-250,0},{-250,2},{-238,2}},
                                                 color={0,127,255}));
  connect(senTem2.T, freeCooling.u) annotation (Line(points={{-228,-9},{-228,-8},
          {-204,-8}}, color={0,0,127}));
  connect(T_set_freeCooling.y, switch2.u3) annotation (Line(points={{-211,-50},{
          -208,-50},{-208,-52},{-204,-52}}, color={0,0,127}));
  connect(T_set_reverseHP.y, switch2.u1) annotation (Line(points={{-181,-50},{-184,
          -50},{-184,-52},{-188,-52}}, color={0,0,127}));
  connect(freeCooling.y, switch2.u2) annotation (Line(points={{-204,-31},{-202,-31},
          {-202,-32},{-196,-32},{-196,-52}}, color={255,0,255}));
  connect(switch2.y, switch1.u1) annotation (Line(points={{-196,-75},{-96,-75},{
          -96,-78},{6,-78}}, color={0,0,127}));
  connect(fixedTemperature.port, storage.heatPort) annotation (Line(points={{-24,
          -182},{-14,-182},{-14,-186},{6,-186}}, color={191,0,0}));
  connect(temperatureSensor.port, storage.layer_HE[1].heatPort) annotation (Line(points={{-18,
          -154},{-18,-186},{6,-186}}, color={191,0,0}));
  connect(val.port_3, storage.port_a_heatGenerator) annotation (Line(points={{-110,
          -112},{-58,-112},{-58,-124},{-2.8,-124},{-2.8,-169.6}}, color={0,127,255}));
  connect(storage.port_b_heatGenerator, senTem6.port_a) annotation (Line(points=
         {{14,-169.6},{38,-169.6},{38,-122},{60,-122}}, color={0,127,255}));
  connect(senTem5.port_b, storage.port_a_consumer) annotation (Line(points={{68,
          -152},{42,-152},{42,-178},{16,-178}}, color={0,127,255}));
  connect(storage.port_b_consumer, senTem4.port_a) annotation (Line(points={{-4,
          -178},{-4,-198},{76,-198},{76,-180}}, color={0,127,255}));
  connect(fan.port_b, vol2.ports[1])
    annotation (Line(points={{-146,0},{-68,0},{-68,4}}, color={0,127,255}));
  connect(vol2.ports[2], senTem8.port_a) annotation (Line(points={{-64,4},{-62,4},
          {-62,-18},{-48,-18},{-48,-14}}, color={0,127,255}));
  connect(senTem2.port_b, fan.port_a) annotation (Line(points={{-218,2},{-192,2},
          {-192,0},{-166,0}}, color={0,127,255}));
  connect(realExpression1.y, fan.m_flow_in)
    annotation (Line(points={{-145,20},{-156,20},{-156,12}}, color={0,0,127}));
  connect(temperatureSensor.T, hysteresis.u) annotation (Line(points={{-18,-134},
          {-8,-134},{-8,-118},{2,-118}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,-240},
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
        coordinateSystem(preserveAspectRatio=false, extent={{-280,-240},{220,120}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end PumpControlledwithHP_V2;
