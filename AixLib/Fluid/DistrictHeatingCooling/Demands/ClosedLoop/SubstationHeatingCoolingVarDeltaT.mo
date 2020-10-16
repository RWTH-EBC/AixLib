within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationHeatingCoolingVarDeltaT "Substation model for bidirctional low-temperature networks for buildings with 
  heat pump and chiller"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

    final parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";

    parameter Modelica.SIunits.HeatFlowRate heatDemand_max "maximum heat demand for scaling of heatpump in Watt";
    parameter Modelica.SIunits.HeatFlowRate coolingDemand_max "maximum cooling demand for scaling of chiller in Watt (negative values)";

    parameter Modelica.SIunits.Temperature deltaT_heatingSet "set temperature difference for heating on the site of building";
    parameter Modelica.SIunits.Temperature deltaT_coolingSet "set temperature difference for cooling on the building site";

    parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000 "nominal pressure drop";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal = max((heatDemand_max/(cp_default*deltaT_heatingSet)),-coolingDemand_max/(cp_default*deltaT_coolingSet))
    "Nominal mass flow rate based on max. demand and set temperature difference";

  AixLib.Fluid.Delays.DelayFirstOrder vol(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
             annotation (Placement(transformation(extent={{-242,4},{-222,24}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
             annotation (Placement(transformation(extent={{188,8},{208,28}})));
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
    annotation (Placement(transformation(extent={{-48,-64},{-28,-44}})));
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
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    dTCon_nominal=deltaT_heatingSet,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    show_T=true,
    etaCarnot_nominal=0.5,
    QCon_flow_nominal=heatDemand_max,
    QCon_flow_max=heatDemand_max)
    annotation (Placement(transformation(extent={{10,-20},{-10,-40}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-96,-78},{-80,-62}})));
  Modelica.Blocks.Math.Gain        const3(k=cp_default)
    annotation (Placement(transformation(extent={{-138,-104},{-126,-92}})));
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit = "W")
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-294,-80},{-254,-40}}),
        iconTransformation(extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput T_supplyHeatingSet(unit = "K")
  "Supply temeprature of heating circuit in the building"
    annotation (
      Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-270,-130}), iconTransformation(extent={{232,124},{192,164}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{92,-88},{72,-68}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-134,-76},{-114,-56}})));
  AixLib.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Medium,
    tau=60,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=max(m_flow_nominal, 1)*{1,1,1})
    annotation (Placement(transformation(extent={{-156,10},{-136,-10}})));

  AixLib.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    tau=60,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=max(m_flow_nominal, 1)*{1,1,1})
    annotation (Placement(transformation(extent={{136,-10},{116,10}})));
  AixLib.Fluid.Chillers.Carnot_TEva chi(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    dTEva_nominal=-deltaT_heatingSet,
    use_eta_Carnot_nominal=true,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    etaCarnot_nominal=0.4,
    QEva_flow_nominal=coolingDemand_max,
    QEva_flow_min=coolingDemand_max)
    annotation (Placement(transformation(extent={{-4,40},{-24,20}})));
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
        transformation(extent={{248,42},{208,82}}), iconTransformation(extent={{-280,
            -120},{-240,-80}})));
  Modelica.Blocks.Interfaces.RealInput T_supplyCoolingSet(unit = "K")
  "Supply temperatur of cooling circuit in the building"
    annotation (
      Placement(transformation(extent={{248,82},{208,122}}),
        iconTransformation(extent={{-280,-72},{-240,-32}})));
  AixLib.Fluid.Sources.MassFlowSource_T sourceCooling(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(extent={{-70,44},{-50,64}})));
  Sources.Boundary_pT                sinkCooling(redeclare package Medium =
        Medium, nPorts=1)
    annotation (Placement(transformation(extent={{30,46},{10,66}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{82,102},{62,122}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{48,100},{34,114}})));
  Modelica.Blocks.Math.Gain        const1(k=-cp_default)
    annotation (Placement(transformation(extent={{78,84},{66,96}})));
  Modelica.Blocks.Math.Add add3(
                               k2=+1)
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
  Modelica.Blocks.Sources.Constant T_return1(k=deltaT_coolingSet)
    annotation (Placement(transformation(extent={{-158,76},{-138,96}})));
  Modelica.Blocks.Math.Division division3
    annotation (Placement(transformation(extent={{-58,120},{-72,134}})));
  Modelica.Blocks.Sources.Constant const2(k=-(cp_default*deltaT_coolingSet))
    annotation (Placement(transformation(extent={{-32,94},{-44,106}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_GridHeat(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-206,-10},{-186,10}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_GridCool(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{152,-10},{172,10}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_HeatPump(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-114,-34},{-94,-14}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_chiller(redeclare package Medium =
               Medium)
    annotation (Placement(transformation(extent={{78,14},{58,34}})));
  Modelica.Blocks.Interfaces.RealInput deltaT_heatingGridSet(unit = "K")
  "Set temperature difference for heating on the site of thermal network"
                                                          annotation (
      Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-268,-158}), iconTransformation(extent={{232,32},{192,72}})));
  Modelica.Blocks.Interfaces.RealInput deltaT_coolingGridSet(unit = "K")
  "Set temperature difference for cooling on the site of thermal network"  annotation (
      Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=180,
        origin={228,142}),   iconTransformation(extent={{-280,-168},{-240,-128}})));

  Modelica.Blocks.Interfaces.RealOutput powerDemandHP(unit = "W")
  "Power demand of heat pump"
    annotation (Placement(transformation(extent={{-260,100},{-280,120}}),
        iconTransformation(extent={{-260,100},{-280,120}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandChiller(unit = "W")
  "Power demand of chiller"
    annotation (Placement(transformation(extent={{-260,126},{-280,146}}),
        iconTransformation(extent={{-260,126},{-280,146}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandSubstation(unit = "W")
  "Power demand of heat pump and chiller (sum)"
    annotation (Placement(transformation(extent={{-260,74},{-280,94}}),
        iconTransformation(extent={{-260,74},{-280,94}})));
  Modelica.Blocks.Math.Sum sum1(nin=2)
    annotation (Placement(transformation(extent={{-208,74},{-228,94}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{188,52},{168,72}})));
equation
  connect(port_a,vol. ports[1])
    annotation (Line(points={{-260,0},{-234,0},{-234,4}},
                                                        color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{220,0},{196,0},{196,8}},
                                                     color={0,127,255}));
  connect(chi.port_b1, jun.port_3) annotation (Line(points={{-24,24},{-146,24},
          {-146,10}},color={0,127,255}));
  connect(heaPum.port_b2, jun1.port_3)
    annotation (Line(points={{10,-24},{126,-24},{126,-10}},
                                                          color={0,127,255}));
  connect(pumpHeating.port_b, heaPum.port_a2)
    annotation (Line(points={{-60,-24},{-10,-24}}, color={0,127,255}));
  connect(chi.port_a1, pumpCooling.port_b)
    annotation (Line(points={{-4,24},{28,24}},color={0,127,255}));
  connect(heaPum.P, add1.u2) annotation (Line(points={{-11,-30},{-54,-30},{-54,-80},
          {-144,-80},{-144,-72},{-136,-72},{-136,-72}}, color={0,0,127}));
  connect(heatDemand, add1.u1)
    annotation (Line(points={{-274,-60},{-136,-60}}, color={0,0,127}));
  connect(add1.y, division1.u1) annotation (Line(points={{-113,-66},{-106,-66},{
          -106,-65.2},{-97.6,-65.2}}, color={0,0,127}));
  connect(const3.y, division1.u2) annotation (Line(points={{-125.4,-98},{-108,-98},
          {-108,-74.8},{-97.6,-74.8}}, color={0,0,127}));
  connect(division1.y, pumpHeating.m_flow_in) annotation (Line(points={{-79.2,
          -70},{-70,-70},{-70,-36}},
                                color={0,0,127}));
  connect(T_supplyHeatingSet, heaPum.TSet) annotation (Line(points={{-270,-130},
          {20,-130},{20,-39},{12,-39}}, color={0,0,127}));
  connect(sourceHeating.ports[1], heaPum.port_a1) annotation (Line(points={{42,-54},
          {28,-54},{28,-36},{10,-36}}, color={0,127,255}));
  connect(sinkHeating.ports[1], heaPum.port_b1) annotation (Line(points={{-28,-54},
          {-22,-54},{-22,-36},{-10,-36}}, color={0,127,255}));
  connect(heatDemand, division.u1) annotation (Line(points={{-274,-60},{-154,
          -60},{-154,-120},{132,-120},{132,-38},{105.4,-38},{105.4,-32.8}},
                                                                       color={0,
          0,127}));
  connect(division.u2, const.y) annotation (Line(points={{105.4,-41.2},{112,-41.2},
          {112,-50},{115.4,-50}}, color={0,0,127}));
  connect(division.y, sourceHeating.m_flow_in) annotation (Line(points={{89.3,
          -37},{76.65,-37},{76.65,-46},{64,-46}},
                                             color={0,0,127}));
  connect(T_supplyHeatingSet, add.u1) annotation (Line(points={{-270,-130},{124,
          -130},{124,-72},{94,-72}},     color={0,0,127}));
  connect(T_return.y, add.u2) annotation (Line(points={{103.3,-95},{100,-95},{100,
          -84},{94,-84}}, color={0,0,127}));
  connect(add.y, sourceHeating.T_in) annotation (Line(points={{71,-78},{68,-78},
          {68,-50},{64,-50}}, color={0,0,127}));
  connect(sourceCooling.ports[1], chi.port_a2) annotation (Line(points={{-50,54},
          {-30,54},{-30,36},{-24,36}}, color={0,127,255}));
  connect(chi.port_b2, sinkCooling.ports[1]) annotation (Line(points={{-4,36},{
          0,36},{0,56},{10,56}}, color={0,127,255}));
  connect(chi.P, add2.u2) annotation (Line(points={{-25,30},{-130,30},{-130,80},
          {88,80},{88,106},{84,106}}, color={0,0,127}));
  connect(division2.u1, add2.y) annotation (Line(points={{49.4,111.2},{55.7,
          111.2},{55.7,112},{61,112}}, color={0,0,127}));
  connect(division2.u2, const1.y) annotation (Line(points={{49.4,102.8},{57.7,
          102.8},{57.7,90},{65.4,90}}, color={0,0,127}));
  connect(division2.y, pumpCooling.m_flow_in) annotation (Line(points={{33.3,
          107},{32,107},{32,66},{38,66},{38,36}}, color={0,0,127}));
  connect(T_return1.y, add3.u2) annotation (Line(points={{-137,86},{-130,86},{
          -130,104},{-122,104}}, color={0,0,127}));
  connect(T_supplyCoolingSet, add3.u1) annotation (Line(points={{228,102},{
          106,102},{106,146},{-150,146},{-150,116},{-122,116}},
                 color={0,0,127}));
  connect(add3.y, sourceCooling.T_in) annotation (Line(points={{-99,110},{-94,
          110},{-94,58},{-72,58}}, color={0,0,127}));
  connect(const2.y, division3.u2) annotation (Line(points={{-44.6,100},{-50,100},
          {-50,122.8},{-56.6,122.8}}, color={0,0,127}));
  connect(division3.y, sourceCooling.m_flow_in) annotation (Line(points={{-72.7,
          127},{-86,127},{-86,62},{-72,62}}, color={0,0,127}));
  connect(T_supplyCoolingSet, chi.TSet) annotation (Line(points={{228,102},{
          106,102},{106,42},{8,42},{8,21},{-2,21}},                     color=
         {0,0,127}));
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
  connect(senMasFlo_chiller.port_a, jun1.port_2) annotation (Line(points={{78,
          24},{100,24},{100,0},{116,0}}, color={0,127,255}));
  connect(senMasFlo_chiller.port_b, pumpCooling.port_a)
    annotation (Line(points={{58,24},{48,24}}, color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-260,0},{-260,0}}, color={0,127,255}));
  connect(deltaT_heatingGridSet, const3.u) annotation (Line(points={{-268,-158},
          {-148,-158},{-148,-98},{-139.2,-98}}, color={0,0,127}));
  connect(deltaT_coolingGridSet, const1.u) annotation (Line(points={{228,142},
          {152,142},{152,90},{79.2,90}}, color={0,0,127}));
  connect(chi.P, powerDemandChiller) annotation (Line(points={{-25,30},{-166,30},
          {-166,136},{-270,136}},          color={0,0,127}));
  connect(heaPum.P, powerDemandHP) annotation (Line(points={{-11,-30},{-174,-30},
          {-174,110},{-270,110}},         color={0,0,127}));
  connect(sum1.y, powerDemandSubstation)
    annotation (Line(points={{-229,84},{-270,84}}, color={0,0,127}));
  //Power Consumptin Calculation
  connect(chi.P, sum1.u[1]);
  connect(heaPum.P, sum1.u[2]);
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(gain.u, coolingDemand)
    annotation (Line(points={{190,62},{228,62}}, color={0,0,127}));
  connect(gain.y, division3.u1) annotation (Line(points={{167,62},{98,62},{98,
          131.2},{-56.6,131.2}}, color={0,0,127}));
  connect(gain.y, add2.u1) annotation (Line(points={{167,62},{98,62},{98,118},
          {84,118}}, color={0,0,127}));
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
    Documentation(revisions="<html><ul>
  <li>
    <i>August 09, 2018</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Substation model for bidirctional low-temperature networks for
  buildings with heat pump and chiller. In the case of simultaneous
  cooling and heating demands, the return flows are used as supply
  flows for the other application. The mass flows are controlled
  equation-based. This model uses the heat pump <a href=
  \"modelica://AixLib.Fluid.HeatPumps.Carnot_TCon\">AixLib.Fluid.HeatPumps.Carnot_TCon</a>
  and the chiller <a href=
  \"modelica://AixLib.Fluid.Chillers.Carnot_TEva\">AixLib.Fluid.Chillers.Carnot_TEva</a>.
  The mass flows are calculated using the heating and cooling demands
  and the specified temperature differences between flow and return
  (network side).
</p>
</html>"));
end SubstationHeatingCoolingVarDeltaT;
