within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationHeatingDirectCooling "Substation model for bidirctional low-temperature networks for buildings with 
  heat pump and direct cooling. For simultaneous cooling and heat demands, 
  the return flows are used as supply flows for the other application. "

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";

    parameter Modelica.SIunits.HeatFlowRate heatDemand_max "Maximum heat demand for scaling of heat pump";

    parameter Modelica.SIunits.Temperature deltaT_heatingSet "Set temperature difference for heating on the site of building";

    parameter Modelica.SIunits.Temperature deltaT_heatingGridSet "Set temperature difference for heating on the site of thermal network";
    parameter Modelica.SIunits.Temperature deltaT_coolingGridSet "Set temperature difference for cooling on the side of the thermal network";

    parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";

    parameter Modelica.SIunits.Temperature T_supplyHeatingSet "Set supply temperature fore space heating";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal = m_flow_nominal
    "Nominal mass flow rate";


  AixLib.Fluid.Delays.DelayFirstOrder vol(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{-242,4},{-222,24}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{188,8},{208,28}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpHeating(redeclare package
      Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-80,-14},{-60,-34}})));
  AixLib.Fluid.Sources.MassFlowSource_T sourceHeating(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(extent={{62,-64},{42,-44}})));
  Modelica.Blocks.Sources.Constant T_return(k=deltaT_heatingSet)
    annotation (Placement(transformation(extent={{118,-102},{104,-88}})));
  Sources.Boundary_pT                sinkHeating(redeclare package Medium =
        Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-74,-114},{-54,-94}})));
  Modelica.Blocks.Sources.Constant const(k=(cp_default*deltaT_heatingSet))
    annotation (Placement(transformation(extent={{128,-56},{116,-44}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{104,-44},{90,-30}})));
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
  AixLib.Fluid.HeatPumps.Carnot_TCon heaPum(redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    show_T=true,
    etaCarnot_nominal=0.5,
    QCon_flow_nominal=heatDemand_max)
    annotation (Placement(transformation(extent={{10,-20},{-10,-40}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-96,-78},{-80,-62}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=(cp_default*(senTem1.T -
        273.15 + 12)))
    annotation (Placement(transformation(extent={{-138,-104},{-126,-92}})));
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit = "W")
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-294,-80},{-254,-40}}),
        iconTransformation(extent={{152,68},{112,108}})));

  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{92,-88},{72,-68}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-134,-76},{-114,-56}})));
  AixLib.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1})
    annotation (Placement(transformation(extent={{-156,10},{-136,-10}})));

  AixLib.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1})
    annotation (Placement(transformation(extent={{136,-10},{116,10}})));
  Delays.DelayFirstOrder            del( nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-24,24},{-4,44}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpCooling(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{48,14},{28,34}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand(unit = "W")
    "Input for cooling demand profile of substation"
    annotation (Placement(
        transformation(extent={{248,42},{208,82}}), iconTransformation(extent={{-176,40},
            {-136,80}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{48,100},{34,114}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression1(y=(cp_default*(273.15 + 22
         - senTem4.T)))
    annotation (Placement(transformation(extent={{78,84},{66,96}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_GridHeat(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-206,-10},{-186,10}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_GridCool(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{152,-10},{172,10}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_HeatPump(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-114,-34},{-94,-14}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{78,14},{58,34}})));
  Modelica.Blocks.Sources.Constant const4(k=T_supplyHeatingSet)
    annotation (Placement(transformation(extent={{-32,-150},{-12,-130}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,88})));
  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{22,-34},{42,-14}})));
  Sensors.TemperatureTwoPort senTem1(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-46,-34},{-26,-14}})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-16,-96},{-36,-76}})));
  Sensors.TemperatureTwoPort senTem3(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{38,-92},{18,-70}})));
  Modelica.Blocks.Interfaces.RealOutput P_el_HP( unit = "W")
    "Electrical power consumed by heat pump"
    annotation (Placement(transformation(extent={{216,-30},{236,-10}})));
  Sensors.TemperatureTwoPort senTem4(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{88,14},{108,34}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=7200)
    annotation (Placement(transformation(extent={{-136,70},{-124,82}})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating1
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{-94,84},{-74,104}})));
  Modelica.Blocks.Sources.Constant const3(k=m_flow_nominal)
    annotation (Placement(transformation(extent={{-122,50},{-110,62}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep1(startTime=7200)
    annotation (Placement(transformation(extent={{-236,-124},{-224,-112}})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating2
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{-194,-110},{-174,-90}})));
  Modelica.Blocks.Sources.Constant const1(k=m_flow_nominal)
    annotation (Placement(transformation(extent={{-222,-144},{-210,-132}})));
equation




  connect(port_a,vol. ports[1])
    annotation (Line(points={{-260,0},{-234,0},{-234,4}},
                                                        color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{220,0},{196,0},{196,8}},
                                                     color={0,127,255}));
  connect(heaPum.P, add1.u2) annotation (Line(points={{-11,-30},{-54,-30},{-54,-80},
          {-144,-80},{-144,-72},{-136,-72},{-136,-72}}, color={0,0,127}));
  connect(heatDemand, add1.u1)
    annotation (Line(points={{-274,-60},{-136,-60}}, color={0,0,127}));
  connect(add1.y, division1.u1) annotation (Line(points={{-113,-66},{-106,-66},{
          -106,-65.2},{-97.6,-65.2}}, color={0,0,127}));
  connect(realExpression.y, division1.u2) annotation (Line(points={{-125.4,-98},
          {-108,-98},{-108,-74.8},{-97.6,-74.8}}, color={0,0,127}));
  connect(heatDemand, division.u1) annotation (Line(points={{-274,-60},{-154,
          -60},{-154,-120},{132,-120},{132,-38},{105.4,-38},{105.4,-32.8}},
                                                                       color={0,
          0,127}));
  connect(division.u2, const.y) annotation (Line(points={{105.4,-41.2},{112,-41.2},
          {112,-50},{115.4,-50}}, color={0,0,127}));
  connect(division.y, sourceHeating.m_flow_in) annotation (Line(points={{89.3,
          -37},{76.65,-37},{76.65,-46},{64,-46}},
                                             color={0,0,127}));
  connect(T_return.y, add.u2) annotation (Line(points={{103.3,-95},{100,-95},{100,
          -84},{94,-84}}, color={0,0,127}));
  connect(add.y, sourceHeating.T_in) annotation (Line(points={{71,-78},{68,-78},
          {68,-50},{64,-50}}, color={0,0,127}));
  connect(division2.u2, realExpression1.y) annotation (Line(points={{49.4,102.8},
          {57.7,102.8},{57.7,90},{65.4,90}}, color={0,0,127}));
  connect(vol.ports[2], senMasFlo_GridHeat.port_a) annotation (Line(points={{
          -230,4},{-230,0},{-206,0},{-206,0}}, color={0,127,255}));
  connect(senMasFlo_GridHeat.port_b, jun.port_1)
    annotation (Line(points={{-186,0},{-156,0}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_b, vol1.ports[2])
    annotation (Line(points={{172,0},{200,0},{200,8}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_a, jun1.port_1)
    annotation (Line(points={{152,0},{136,0}}, color={0,127,255}));
  connect(jun.port_2, senMasFlo_HeatPump.port_a) annotation (Line(points={{
          -136,0},{-118,0},{-118,-24},{-114,-24}}, color={0,127,255}));
  connect(senMasFlo_HeatPump.port_b, pumpHeating.port_a)
    annotation (Line(points={{-94,-24},{-80,-24}}, color={0,127,255}));
  connect(senMasFlo.port_b, pumpCooling.port_a)
    annotation (Line(points={{58,24},{48,24}}, color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-260,0},{-260,0}}, color={0,127,255}));
  connect(const4.y, add.u1) annotation (Line(points={{-11,-140},{148,-140},{148,
          -72},{94,-72}}, color={0,0,127}));
  connect(const4.y, heaPum.TSet) annotation (Line(points={{-11,-140},{12,-140},{
          12,-39},{12,-39}}, color={0,0,127}));
  connect(del.ports[1], pumpCooling.port_b)
    annotation (Line(points={{-16,24},{28,24}}, color={0,127,255}));
  connect(jun.port_3, del.ports[2]) annotation (Line(points={{-146,10},{-148,10},
          {-148,24},{-12,24}}, color={0,127,255}));
  connect(coolingDemand, division2.u1) annotation (Line(points={{228,62},{122,62},
          {122,111.2},{49.4,111.2}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, del.heatPort) annotation (Line(points={{-40,
          78},{-42,78},{-42,34},{-24,34}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, coolingDemand) annotation (Line(points={{-40,
          98},{-40,138},{156,138},{156,62},{228,62}}, color={0,0,127}));
  connect(pumpHeating.port_b, senTem1.port_a)
    annotation (Line(points={{-60,-24},{-46,-24}}, color={0,127,255}));
  connect(senTem1.port_b, heaPum.port_a2)
    annotation (Line(points={{-26,-24},{-10,-24}}, color={0,127,255}));
  connect(heaPum.port_b2, senTem.port_a)
    annotation (Line(points={{10,-24},{22,-24}}, color={0,127,255}));
  connect(senTem.port_b, jun1.port_3) annotation (Line(points={{42,-24},{126,
          -24},{126,-10}}, color={0,127,255}));
  connect(sourceHeating.ports[1], senTem3.port_a)
    annotation (Line(points={{42,-54},{38,-54},{38,-81}}, color={0,127,255}));
  connect(senTem3.port_b, heaPum.port_a1)
    annotation (Line(points={{18,-81},{18,-36},{10,-36}}, color={0,127,255}));
  connect(senTem2.port_a, heaPum.port_b1) annotation (Line(points={{-16,-86},{
          -18,-86},{-18,-36},{-10,-36}}, color={0,127,255}));
  connect(senTem2.port_b, sinkHeating.ports[1]) annotation (Line(points={{-36,
          -86},{-44,-86},{-44,-84},{-54,-84},{-54,-104}}, color={0,127,255}));
  connect(heaPum.P,P_el_HP)  annotation (Line(points={{-11,-30},{-20,-30},{-20,-20},
          {226,-20}}, color={0,0,127}));
  connect(senMasFlo.port_a, senTem4.port_a)
    annotation (Line(points={{78,24},{88,24}}, color={0,127,255}));
  connect(senTem4.port_b, jun1.port_2) annotation (Line(points={{108,24},{110,
          24},{110,0},{116,0}}, color={0,127,255}));
  connect(booleanStep.y,mass_flow_heatExchangerHeating1. u2) annotation (Line(
        points={{-123.4,76},{-110,76},{-110,94},{-96,94}},
                                                         color={255,0,255}));
  connect(const3.y,mass_flow_heatExchangerHeating1. u3) annotation (Line(points={{-109.4,
          56},{-102,56},{-102,86},{-96,86}},      color={0,0,127}));
  connect(division2.y, mass_flow_heatExchangerHeating1.u1) annotation (Line(
        points={{33.3,107},{-138,107},{-138,102},{-96,102}}, color={0,0,127}));
  connect(booleanStep1.y, mass_flow_heatExchangerHeating2.u2) annotation (Line(
        points={{-223.4,-118},{-210,-118},{-210,-100},{-196,-100}}, color={255,
          0,255}));
  connect(const1.y,mass_flow_heatExchangerHeating2. u3) annotation (Line(points={{-209.4,
          -138},{-202,-138},{-202,-108},{-196,-108}},
                                                  color={0,0,127}));
  connect(division1.y, mass_flow_heatExchangerHeating2.u1) annotation (Line(
        points={{-79.2,-70},{-68,-70},{-68,-40},{-224,-40},{-224,-92},{-196,-92}},
        color={0,0,127}));
  connect(mass_flow_heatExchangerHeating2.y, pumpHeating.m_flow_in) annotation (
     Line(points={{-173,-100},{-128,-100},{-128,-98},{-70,-98},{-70,-36}},
        color={0,0,127}));
  connect(mass_flow_heatExchangerHeating1.y, pumpCooling.m_flow_in)
    annotation (Line(points={{-73,94},{38,94},{38,36}}, color={0,0,127}));
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
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>"));
end SubstationHeatingDirectCooling;
