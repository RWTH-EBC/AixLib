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
    tau=60)  annotation (Placement(transformation(extent={{-222,4},{-202,24}})));
  Delays.DelayFirstOrder              vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{208,8},{228,28}})));
  Movers.FlowControlled_m_flow              pumpHeating(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-60,-14},{-40,-34}})));
  Sources.MassFlowSource_T              sourceHeating(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(extent={{126,-94},{106,-74}})));
  Modelica.Blocks.Sources.Constant T_return(k=T_supplyHeatingSet -
        deltaT_heatingSet)
    annotation (Placement(transformation(extent={{168,-100},{154,-86}})));
  Sources.Boundary_pT              sinkHeating(redeclare package Medium =
        Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-54,-112},{-34,-92}})));
  Modelica.Blocks.Sources.Constant const(k=(cp_default*deltaT_heatingSet))
    annotation (Placement(transformation(extent={{192,-84},{180,-72}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{168,-72},{154,-58}})));
  HeatPumps.Carnot_TCon              heaPum(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    show_T=true,
    etaCarnot_nominal=0.5,
    QCon_flow_nominal=heatDemand_max)
    annotation (Placement(transformation(extent={{58,-20},{38,-40}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-90,-70},{-74,-54}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=(cp_default*(senTem1.T -
        T_coolingGridSet)))
    annotation (Placement(transformation(extent={{-132,-96},{-120,-84}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-128,-68},{-108,-48}})));
  FixedResistances.Junction              jun(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1})
    annotation (Placement(transformation(extent={{-136,10},{-116,-10}})));
  FixedResistances.Junction              jun1(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1})
    annotation (Placement(transformation(extent={{156,-10},{136,10}})));
  Delays.DelayFirstOrder              del(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-4,24},{16,44}})));
  Movers.FlowControlled_m_flow              pumpCooling(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{68,14},{48,34}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{102,52},{88,66}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression1(y=(cp_default*(
        T_heatingGridSet - senTem4.T)))
    annotation (Placement(transformation(extent={{132,44},{120,56}})));
  Sensors.MassFlowRate              senMasFlo_GridHeat(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-186,-10},{-166,10}})));
  Sensors.MassFlowRate              senMasFlo_GridCool(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{172,-10},{192,10}})));
  Sensors.MassFlowRate              senMasFlo_HeatPump(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-94,-34},{-74,-14}})));
  Sensors.MassFlowRate              senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{98,14},{78,34}})));
  Modelica.Blocks.Sources.Constant const4(k=T_supplyHeatingSet)
    annotation (Placement(transformation(extent={{88,-44},{78,-34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-22,60})));
  Sensors.TemperatureTwoPort              senTem(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{106,-34},{126,-14}})));
  Sensors.TemperatureTwoPort              senTem1(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-26,-34},{-6,-14}})));
  Sensors.TemperatureTwoPort              senTem2(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-2,-92},{-22,-72}})));
  Sensors.TemperatureTwoPort              senTem3(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{90,-94},{70,-72}})));
  Sensors.TemperatureTwoPort              senTem4(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{108,14},{128,34}})));
  Sensors.TemperatureTwoPort              senTem5(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-78,14},{-58,34}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression2(y=heaPum.P)
    annotation (Placement(transformation(extent={{-154,-70},{-142,-58}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression3(y=heaPum.P)
    annotation (Placement(transformation(extent={{210,-46},{222,-34}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression4(y=heatDemand)
    annotation (Placement(transformation(extent={{194,-66},{182,-54}})));
public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-250,-10},{-230,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{230,-10},{250,10}}),
        iconTransformation(extent={{230,-10},{250,10}})));
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit="W")
    "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-274,-72},{-234,-32}}),
        iconTransformation(extent={{254,68},{214,108}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand(unit="W")
    "Input for cooling demand profile of substation"
    annotation (Placement(
        transformation(extent={{268,42},{228,82}}), iconTransformation(extent={{-278,40},
            {-238,80}})));
  Modelica.Blocks.Interfaces.RealOutput P_el_HP(unit="W")
    "Electrical power consumed by heat pump"
    annotation (Placement(transformation(extent={{236,-50},{256,-30}})));

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
    annotation (Line(points={{-240,0},{-214,0},{-214,4}},
                                                        color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{240,0},{216,0},{216,8}},
                                                     color={0,127,255}));
  connect(heatDemand,add1. u1)
    annotation (Line(points={{-254,-52},{-130,-52}}, color={0,0,127}));
  connect(add1.y,division1. u1) annotation (Line(points={{-107,-58},{-100,-58},
          {-100,-57.2},{-91.6,-57.2}},color={0,0,127}));
  connect(realExpression.y,division1. u2) annotation (Line(points={{-119.4,-90},
          {-102,-90},{-102,-66.8},{-91.6,-66.8}}, color={0,0,127}));
  connect(division.u2,const. y) annotation (Line(points={{169.4,-69.2},{176,
          -69.2},{176,-78},{179.4,-78}},
                                  color={0,0,127}));
  connect(division.y,sourceHeating. m_flow_in) annotation (Line(points={{153.3,
          -65},{140.65,-65},{140.65,-76},{128,-76}},
                                             color={0,0,127}));
  connect(division2.u2,realExpression1. y) annotation (Line(points={{103.4,54.8},
          {111.7,54.8},{111.7,50},{119.4,50}},
                                             color={0,0,127}));
  connect(vol.ports[2],senMasFlo_GridHeat. port_a) annotation (Line(points={{-210,4},
          {-210,0},{-186,0}},                  color={0,127,255}));
  connect(senMasFlo_GridHeat.port_b,jun. port_1)
    annotation (Line(points={{-166,0},{-136,0}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_b,vol1. ports[2])
    annotation (Line(points={{192,0},{220,0},{220,8}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_a,jun1. port_1)
    annotation (Line(points={{172,0},{156,0}}, color={0,127,255}));
  connect(jun.port_2,senMasFlo_HeatPump. port_a) annotation (Line(points={{-116,0},
          {-98,0},{-98,-24},{-94,-24}},            color={0,127,255}));
  connect(senMasFlo_HeatPump.port_b,pumpHeating. port_a)
    annotation (Line(points={{-74,-24},{-60,-24}}, color={0,127,255}));
  connect(senMasFlo.port_b,pumpCooling. port_a)
    annotation (Line(points={{78,24},{68,24}}, color={0,127,255}));
  connect(port_a,port_a)
    annotation (Line(points={{-240,0},{-240,0}}, color={0,127,255}));
  connect(const4.y,heaPum. TSet) annotation (Line(points={{77.5,-39},{60,-39}},
                             color={0,0,127}));
  connect(del.ports[1],pumpCooling. port_b)
    annotation (Line(points={{4,24},{48,24}},   color={0,127,255}));
  connect(coolingDemand,division2. u1) annotation (Line(points={{248,62},{176,
          62},{176,63.2},{103.4,63.2}},
                                     color={0,0,127}));
  connect(prescribedHeatFlow.port,del. heatPort) annotation (Line(points={{-22,50},
          {-22,34},{-4,34}},               color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow,coolingDemand)  annotation (Line(points={{-22,70},
          {-22,88},{176,88},{176,62},{248,62}},       color={0,0,127}));
  connect(pumpHeating.port_b,senTem1. port_a)
    annotation (Line(points={{-40,-24},{-26,-24}}, color={0,127,255}));
  connect(senTem1.port_b,heaPum. port_a2)
    annotation (Line(points={{-6,-24},{38,-24}},   color={0,127,255}));
  connect(heaPum.port_b2,senTem. port_a)
    annotation (Line(points={{58,-24},{106,-24}},color={0,127,255}));
  connect(senTem.port_b,jun1. port_3) annotation (Line(points={{126,-24},{146,
          -24},{146,-10}}, color={0,127,255}));
  connect(senTem2.port_a,heaPum. port_b1) annotation (Line(points={{-2,-82},{30,
          -82},{30,-36},{38,-36}},       color={0,127,255}));
  connect(senTem2.port_b,sinkHeating. ports[1]) annotation (Line(points={{-22,-82},
          {-34,-82},{-34,-102}},                          color={0,127,255}));
  connect(senMasFlo.port_a,senTem4. port_a)
    annotation (Line(points={{98,24},{108,24}},color={0,127,255}));
  connect(senTem4.port_b,jun1. port_2) annotation (Line(points={{128,24},{130,
          24},{130,0},{136,0}}, color={0,127,255}));
  connect(division2.y,pumpCooling. m_flow_in)
    annotation (Line(points={{87.3,59},{58,59},{58,36}}, color={0,0,127}));
  connect(division1.y,pumpHeating. m_flow_in) annotation (Line(points={{-73.2,
          -62},{-50,-62},{-50,-36}},
                                color={0,0,127}));
  connect(senTem5.port_b,del. ports[2])
    annotation (Line(points={{-58,24},{8,24}},   color={0,127,255}));
  connect(jun.port_3,senTem5. port_a) annotation (Line(points={{-126,10},{-128,
          10},{-128,24},{-78,24}},
                               color={0,127,255}));
  connect(sourceHeating.T_in,T_return. y) annotation (Line(points={{128,-80},{
          136,-80},{136,-90},{153.3,-90},{153.3,-93}},
                                                   color={0,0,127}));
  connect(realExpression2.y,add1. u2)
    annotation (Line(points={{-141.4,-64},{-130,-64}}, color={0,0,127}));
  connect(senTem3.port_b,heaPum. port_a1) annotation (Line(points={{70,-83},{68,
          -83},{68,-84},{66,-84},{66,-36},{58,-36}}, color={0,127,255}));
  connect(senTem3.port_a,sourceHeating. ports[1]) annotation (Line(points={{90,-83},
          {98,-83},{98,-84},{106,-84}},color={0,127,255}));
  connect(realExpression3.y,P_el_HP)
    annotation (Line(points={{222.6,-40},{246,-40}}, color={0,0,127}));
  connect(division.u1,realExpression4. y) annotation (Line(points={{169.4,-60.8},
          {177.7,-60.8},{177.7,-60},{181.4,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-240,
            -160},{240,160}}),
                         graphics={
        Rectangle(
          extent={{-240,160},{240,-160}},
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
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{94,10},{240,-10}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-238,10},{-90,-10}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-240,-160},{240,
            160}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>October 08, 2020,by</i> Tobias Blacha:<br/>
    Move to development
  </li>
  <li>
    <i>August 09, 2018</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Substation model for bidirectional low-temperature networks for
  buildings with heat pump and direct cooling. In the case of
  simultaneous cooling and heating demands, the return flows are used
  as supply flows for the other application for energy balancing. This
  model uses the heat pump <a href=
  \"modelica://AixLib.Fluid.HeatPumps.Carnot_TCon\">AixLib.Fluid.HeatPumps.Carnot_TCon</a>.
  The mass flows are controlled equation-based and calculated using the
  heating and cooling demands and the specified temperatures of the
  warm and cold line of the network.
</p>
</html>"));
end SubstationHeatingDirectCooling;
