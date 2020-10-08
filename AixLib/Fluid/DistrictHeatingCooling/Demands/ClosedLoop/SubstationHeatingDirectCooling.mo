within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationHeatingDirectCooling "Substation model for bidirctional low-temperature networks for buildings with 
  heat pump and direct cooling."

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.SIunits.HeatFlowRate heatDemand_max
    "Maximum heat demand for scaling of heat pump";

    parameter Modelica.SIunits.Temperature deltaT_heatingSet = 10
    "Set temperature difference for heating on the site of building";

    parameter Modelica.SIunits.Temperature T_heatingGridSet = 273.15 + 22
    "Set temperature of warm line";
    parameter Modelica.SIunits.Temperature T_coolingGridSet = 273.15 + 12
    "Set temperature of cold line";

    parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
    "Nominal pressure drop";

    parameter Modelica.SIunits.Temperature T_supplyHeatingSet = 273.15 + 55
    "Set supply temperature for space heating";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal = m_flow_nominal
    "Nominal mass flow rate";


  Delays.DelayFirstOrder              vol(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{-242,4},{-222,24}})));
  Delays.DelayFirstOrder              vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{188,8},{208,28}})));
  Movers.FlowControlled_m_flow              pumpHeating(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-80,-14},{-60,-34}})));
  Sources.MassFlowSource_T              sourceHeating(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(extent={{106,-94},{86,-74}})));
  Modelica.Blocks.Sources.Constant T_return(k=T_supplyHeatingSet -
        deltaT_heatingSet)
    annotation (Placement(transformation(extent={{148,-100},{134,-86}})));
  Sources.Boundary_pT              sinkHeating(redeclare package Medium =
        Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-74,-112},{-54,-92}})));
  Modelica.Blocks.Sources.Constant const(k=(cp_default*deltaT_heatingSet))
    annotation (Placement(transformation(extent={{172,-84},{160,-72}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{148,-72},{134,-58}})));
  HeatPumps.Carnot_TCon              heaPum(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    show_T=true,
    etaCarnot_nominal=0.5,
    QCon_flow_nominal=heatDemand_max)
    annotation (Placement(transformation(extent={{38,-20},{18,-40}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-110,-70},{-94,-54}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=(cp_default*(senTem1.T -
        T_coolingGridSet)))
    annotation (Placement(transformation(extent={{-152,-96},{-140,-84}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-148,-68},{-128,-48}})));
  FixedResistances.Junction              jun(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1})
    annotation (Placement(transformation(extent={{-156,10},{-136,-10}})));
  FixedResistances.Junction              jun1(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1})
    annotation (Placement(transformation(extent={{136,-10},{116,10}})));
  Delays.DelayFirstOrder              del(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-24,24},{-4,44}})));
  Movers.FlowControlled_m_flow              pumpCooling(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{48,14},{28,34}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{82,52},{68,66}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression1(y=(cp_default*(
        T_heatingGridSet - senTem4.T)))
    annotation (Placement(transformation(extent={{112,44},{100,56}})));
  Sensors.MassFlowRate              senMasFlo_GridHeat(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-206,-10},{-186,10}})));
  Sensors.MassFlowRate              senMasFlo_GridCool(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{152,-10},{172,10}})));
  Sensors.MassFlowRate              senMasFlo_HeatPump(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-114,-34},{-94,-14}})));
  Sensors.MassFlowRate              senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{78,14},{58,34}})));
  Modelica.Blocks.Sources.Constant const4(k=T_supplyHeatingSet)
    annotation (Placement(transformation(extent={{68,-44},{58,-34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-42,60})));
  Sensors.TemperatureTwoPort              senTem(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{86,-34},{106,-14}})));
  Sensors.TemperatureTwoPort              senTem1(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-46,-34},{-26,-14}})));
  Sensors.TemperatureTwoPort              senTem2(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-22,-92},{-42,-72}})));
  Sensors.TemperatureTwoPort              senTem3(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{70,-94},{50,-72}})));
  Sensors.TemperatureTwoPort              senTem4(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{88,14},{108,34}})));
  Sensors.TemperatureTwoPort              senTem5(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-98,14},{-78,34}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression2(y=heaPum.P)
    annotation (Placement(transformation(extent={{-174,-70},{-162,-58}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression3(y=heaPum.P)
    annotation (Placement(transformation(extent={{190,-46},{202,-34}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression4(y=heatDemand)
    annotation (Placement(transformation(extent={{174,-66},{162,-54}})));
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
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit="W")
    "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-294,-72},{-254,-32}}),
        iconTransformation(extent={{152,68},{112,108}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand(unit="W")
    "Input for cooling demand profile of substation"
    annotation (Placement(
        transformation(extent={{248,42},{208,82}}), iconTransformation(extent={{-176,40},
            {-136,80}})));
  Modelica.Blocks.Interfaces.RealOutput P_el_HP(unit="W")
    "Electrical power consumed by heat pump"
    annotation (Placement(transformation(extent={{216,-50},{236,-30}})));

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
      final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";


equation
  connect(port_a,vol. ports[1])
    annotation (Line(points={{-260,0},{-234,0},{-234,4}},
                                                        color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{220,0},{196,0},{196,8}},
                                                     color={0,127,255}));
  connect(heatDemand,add1. u1)
    annotation (Line(points={{-274,-52},{-150,-52}}, color={0,0,127}));
  connect(add1.y,division1. u1) annotation (Line(points={{-127,-58},{-120,-58},{
          -120,-57.2},{-111.6,-57.2}},color={0,0,127}));
  connect(realExpression.y,division1. u2) annotation (Line(points={{-139.4,-90},
          {-122,-90},{-122,-66.8},{-111.6,-66.8}},color={0,0,127}));
  connect(division.u2,const. y) annotation (Line(points={{149.4,-69.2},{156,-69.2},
          {156,-78},{159.4,-78}}, color={0,0,127}));
  connect(division.y,sourceHeating. m_flow_in) annotation (Line(points={{133.3,-65},
          {120.65,-65},{120.65,-76},{108,-76}},
                                             color={0,0,127}));
  connect(division2.u2,realExpression1. y) annotation (Line(points={{83.4,54.8},
          {91.7,54.8},{91.7,50},{99.4,50}},  color={0,0,127}));
  connect(vol.ports[2],senMasFlo_GridHeat. port_a) annotation (Line(points={{
          -230,4},{-230,0},{-206,0},{-206,0}}, color={0,127,255}));
  connect(senMasFlo_GridHeat.port_b,jun. port_1)
    annotation (Line(points={{-186,0},{-156,0}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_b,vol1. ports[2])
    annotation (Line(points={{172,0},{200,0},{200,8}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_a,jun1. port_1)
    annotation (Line(points={{152,0},{136,0}}, color={0,127,255}));
  connect(jun.port_2,senMasFlo_HeatPump. port_a) annotation (Line(points={{
          -136,0},{-118,0},{-118,-24},{-114,-24}}, color={0,127,255}));
  connect(senMasFlo_HeatPump.port_b,pumpHeating. port_a)
    annotation (Line(points={{-94,-24},{-80,-24}}, color={0,127,255}));
  connect(senMasFlo.port_b,pumpCooling. port_a)
    annotation (Line(points={{58,24},{48,24}}, color={0,127,255}));
  connect(port_a,port_a)
    annotation (Line(points={{-260,0},{-260,0}}, color={0,127,255}));
  connect(const4.y,heaPum. TSet) annotation (Line(points={{57.5,-39},{40,-39}},
                             color={0,0,127}));
  connect(del.ports[1],pumpCooling. port_b)
    annotation (Line(points={{-16,24},{28,24}}, color={0,127,255}));
  connect(coolingDemand,division2. u1) annotation (Line(points={{228,62},{156,62},
          {156,63.2},{83.4,63.2}},   color={0,0,127}));
  connect(prescribedHeatFlow.port,del. heatPort) annotation (Line(points={{-42,50},
          {-42,34},{-24,34}},              color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow,coolingDemand)  annotation (Line(points={{-42,70},
          {-42,88},{156,88},{156,62},{228,62}},       color={0,0,127}));
  connect(pumpHeating.port_b,senTem1. port_a)
    annotation (Line(points={{-60,-24},{-46,-24}}, color={0,127,255}));
  connect(senTem1.port_b,heaPum. port_a2)
    annotation (Line(points={{-26,-24},{18,-24}},  color={0,127,255}));
  connect(heaPum.port_b2,senTem. port_a)
    annotation (Line(points={{38,-24},{86,-24}}, color={0,127,255}));
  connect(senTem.port_b,jun1. port_3) annotation (Line(points={{106,-24},{126,-24},
          {126,-10}},      color={0,127,255}));
  connect(senTem2.port_a,heaPum. port_b1) annotation (Line(points={{-22,-82},{10,
          -82},{10,-36},{18,-36}},       color={0,127,255}));
  connect(senTem2.port_b,sinkHeating. ports[1]) annotation (Line(points={{-42,-82},
          {-54,-82},{-54,-102}},                          color={0,127,255}));
  connect(senMasFlo.port_a,senTem4. port_a)
    annotation (Line(points={{78,24},{88,24}}, color={0,127,255}));
  connect(senTem4.port_b,jun1. port_2) annotation (Line(points={{108,24},{110,
          24},{110,0},{116,0}}, color={0,127,255}));
  connect(division2.y,pumpCooling. m_flow_in)
    annotation (Line(points={{67.3,59},{38,59},{38,36}}, color={0,0,127}));
  connect(division1.y,pumpHeating. m_flow_in) annotation (Line(points={{-93.2,-62},
          {-70,-62},{-70,-36}}, color={0,0,127}));
  connect(senTem5.port_b,del. ports[2])
    annotation (Line(points={{-78,24},{-12,24}}, color={0,127,255}));
  connect(jun.port_3,senTem5. port_a) annotation (Line(points={{-146,10},{-148,10},
          {-148,24},{-98,24}}, color={0,127,255}));
  connect(sourceHeating.T_in,T_return. y) annotation (Line(points={{108,-80},{116,
          -80},{116,-90},{133.3,-90},{133.3,-93}}, color={0,0,127}));
  connect(realExpression2.y,add1. u2)
    annotation (Line(points={{-161.4,-64},{-150,-64}}, color={0,0,127}));
  connect(senTem3.port_b,heaPum. port_a1) annotation (Line(points={{50,-83},{48,
          -83},{48,-84},{46,-84},{46,-36},{38,-36}}, color={0,127,255}));
  connect(senTem3.port_a,sourceHeating. ports[1]) annotation (Line(points={{70,-83},
          {78,-83},{78,-84},{86,-84}}, color={0,127,255}));
  connect(realExpression3.y,P_el_HP)
    annotation (Line(points={{202.6,-40},{226,-40}}, color={0,0,127}));
  connect(division.u1,realExpression4. y) annotation (Line(points={{149.4,-60.8},
          {157.7,-60.8},{157.7,-60},{161.4,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-260,
            -160},{220,160}}),
                         graphics={
        Rectangle(
          extent={{-160,160},{140,-160}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,30},{94,-146}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-106,30},{-6,140},{112,30},{-106,30}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-48,6},{-12,-36}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,-72},{18,-146}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{18,6},{54,-36}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-160},{220,
            160}})),
    Documentation(revisions="<html>
<ul>
<li><i>October 08, 2020,by</i> Tobias Blacha:<br>Move to development</li>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br>Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirectional low-temperature networks for buildings with heat pump and direct cooling. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application for energy balancing. This model uses the heat pump <a href=\"modelica://AixLib.Fluid.HeatPumps.Carnot_TCon\">AixLib.Fluid.HeatPumps.Carnot_TCon</a>. The mass flows are controlled equation-based and calculated using the heating and cooling demands and the specified temperatures of the warm and cold line of the network.</p>
</html>"));
end SubstationHeatingDirectCooling;
