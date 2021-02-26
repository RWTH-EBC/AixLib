within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model DHCSubstationHeatPumpChiller
  "Substation model for bidirctional low-temperature networks for buildings with  heat pump and chiller"

    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
    "Nominal pressure drop";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal = max(max((heaDem_max/(cp_default*deltaT_heaSecSet)),-cooDem_max/(cp_default*deltaT_cooSecSet)),0.0001)
    "Nominal mass flow rate based on max. demand and set temperature difference";

    parameter Modelica.SIunits.HeatFlowRate heaDem_max
    "Maximum heat demand for scaling of heatpump in Watt"
    annotation (Dialog(tab = "General", group = "Building System"));

    parameter Modelica.SIunits.HeatFlowRate cooDem_max
    "Maximum cooling demand for scaling of chiller in Watt (negative values)"
    annotation (Dialog(tab = "General", group = "Building System"));

    parameter Modelica.SIunits.Temperature T_heaSecSet = 273.15 + 55
    "Set supply temperature for space heating on secondary side (building system)"
    annotation (Dialog(tab = "General", group = "Building System"));

    parameter Modelica.SIunits.Temperature deltaT_heaSecSet
    "Set temperature difference for heating on secondary site (building system)"
     annotation (Dialog(tab = "General", group = "Building System"));

    parameter Modelica.SIunits.Temperature T_cooSecSet = 273.15 + 12
    "Set supply temperature for cooling on secondary side (building system)"
    annotation (Dialog(tab = "General", group = "Building System"));

    parameter Modelica.SIunits.Temperature deltaT_cooSecSet
    "Set temperature difference for cooling on secondary site (building system)"
    annotation (Dialog(tab = "General", group = "Building System"));


    parameter Modelica.SIunits.Temperature deltaT_heaPriSet
    "Set temperature difference for heating on primary site (grid)"
     annotation (Dialog(tab = "General", group = "Grid"));

      parameter Modelica.SIunits.Temperature deltaT_cooPriSet
    "Set temperature difference for cooling on primary site (grid)"
     annotation (Dialog(tab = "General", group = "Grid"));

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
  AixLib.Fluid.Movers.FlowControlled_m_flow pumHea(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    "decentral distribution pump for heating on primary side"
    annotation (Placement(transformation(extent={{-80,-14},{-60,-34}})));
  AixLib.Fluid.Sources.MassFlowSource_T souHeaSec(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(extent={{62,-64},{42,-44}})));
  Modelica.Blocks.Sources.Constant T_heaPumInSec(k=T_heaSecSet -
        deltaT_heaSecSet) "Inlet temperatur of heat pump on secondary side"
    annotation (Placement(transformation(extent={{102,-72},{88,-58}})));
  Sources.Boundary_pT sinHeaSec(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-48,-64},{-28,-44}})));
  Modelica.Blocks.Sources.Constant const(k=(cp_default*deltaT_heaSecSet))
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
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    show_T=true,
    etaCarnot_nominal=0.5,
    QCon_flow_max=heaDem_max,
    QCon_flow_nominal=heaDem_max)
    annotation (Placement(transformation(extent={{10,-20},{-10,-40}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-96,-78},{-80,-62}})));
  Modelica.Blocks.Interfaces.RealInput heaDem(unit="W")
    "Input for heat demand profile of substation" annotation (Placement(
        transformation(extent={{-294,-80},{-254,-40}}), iconTransformation(
          extent={{232,76},{192,116}})));
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
    use_eta_Carnot_nominal=true,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    etaCarnot_nominal=0.4,
    QEva_flow_min=cooDem_max,
    QEva_flow_nominal=cooDem_max)
    annotation (Placement(transformation(extent={{-4,40},{-24,20}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumCoo(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    "decentral distribution pump for cooling on primary side"
    annotation (Placement(transformation(extent={{52,14},{32,34}})));
  Modelica.Blocks.Interfaces.RealInput cooDem(unit="W")
    "Input for cooling demand profile of substation" annotation (Placement(
        transformation(extent={{248,42},{208,82}}), iconTransformation(extent={{
            -280,-120},{-240,-80}})));
  AixLib.Fluid.Sources.MassFlowSource_T souCoo(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(extent={{-66,44},{-46,64}})));
  Sources.Boundary_pT sinCoo(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{34,44},{14,64}})));
  Modelica.Blocks.Math.Add add2(k2=+1)
    annotation (Placement(transformation(extent={{94,68},{74,88}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{60,66},{46,80}})));
  Modelica.Blocks.Math.Division division3
    annotation (Placement(transformation(extent={{-58,100},{-72,114}})));
  Modelica.Blocks.Sources.Constant const2(k=cp_default*deltaT_cooSecSet)
    annotation (Placement(transformation(extent={{-32,86},{-44,98}})));

  Modelica.Blocks.Interfaces.RealOutput P_el_heaPum(unit="W")
    "Power demand of heat pump" annotation (Placement(transformation(extent={{-260,
            100},{-280,120}}), iconTransformation(extent={{-260,100},{-280,120}})));
  Modelica.Blocks.Interfaces.RealOutput P_el_chi(unit="W")
    "Power demand of chiller" annotation (Placement(transformation(extent={{-260,
            126},{-280,146}}), iconTransformation(extent={{-260,126},{-280,146}})));
  Modelica.Blocks.Interfaces.RealOutput P_el_subSta(unit="W")
    "Power demand of substation for heat pump, chiller and distribution pumps on primary side (grid)"
    annotation (Placement(transformation(extent={{-260,74},{-280,94}}),
        iconTransformation(extent={{-260,74},{-280,94}})));
  Modelica.Blocks.Math.Sum sum1(nin=4)
    annotation (Placement(transformation(extent={{-220,74},{-240,94}})));
  Modelica.Blocks.Sources.Constant T_heaPumSet(k=T_heaSecSet)
    annotation (Placement(transformation(extent={{40,-78},{26,-64}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression2(y=heaPum.P)
    annotation (Placement(transformation(extent={{-176,-78},{-164,-66}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression1(y=heaDem)
    annotation (Placement(transformation(extent={{138,-38},{126,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=cp_default*
        deltaT_heaPriSet)
    annotation (Placement(transformation(extent={{-128,-96},{-116,-84}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression3(y=heaPum.P)
    annotation (Placement(transformation(extent={{-228,104},{-240,116}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression4(y=chi.P)
    annotation (Placement(transformation(extent={{-228,130},{-240,142}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression5(y=chi.P)
    annotation (Placement(transformation(extent={{130,66},{118,78}})));
  Modelica.Blocks.Sources.Constant const3(k=cp_default*deltaT_cooPriSet)
    annotation (Placement(transformation(extent={{94,48},{80,62}})));
  Modelica.Blocks.Sources.Constant T_chiSet(k=T_cooSecSet)
    annotation (Placement(transformation(extent={{24,2},{10,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=T_cooSecSet +
        deltaT_cooSecSet)
    annotation (Placement(transformation(extent={{-106,52},{-94,64}})));

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
                                                        color={0,127,255},
      thickness=1));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{220,0},{196,0},{196,8}},
                                                     color={0,127,255},
      thickness=1));
  connect(chi.port_b1, jun.port_3) annotation (Line(points={{-24,24},{-146,24},
          {-146,10}},color={0,127,255},
      thickness=1));
  connect(heaPum.port_b2, jun1.port_3)
    annotation (Line(points={{10,-24},{126,-24},{126,-10}},
                                                          color={0,127,255},
      thickness=1));
  connect(pumHea.port_b, heaPum.port_a2) annotation (Line(
      points={{-60,-24},{-10,-24}},
      color={0,127,255},
      thickness=1));
  connect(chi.port_a1, pumCoo.port_b) annotation (Line(
      points={{-4,24},{32,24}},
      color={0,127,255},
      thickness=1));
  connect(heaDem, add1.u1)
    annotation (Line(points={{-274,-60},{-136,-60}}, color={0,0,127}));
  connect(add1.y, division1.u1) annotation (Line(points={{-113,-66},{-106,-66},{
          -106,-65.2},{-97.6,-65.2}}, color={0,0,127}));
  connect(division1.y, pumHea.m_flow_in) annotation (Line(points={{-79.2,-70},{-70,
          -70},{-70,-36}}, color={0,0,127}));
  connect(souHeaSec.ports[1], heaPum.port_a1) annotation (Line(
      points={{42,-54},{28,-54},{28,-36},{10,-36}},
      color={0,127,255},
      thickness=0.5));
  connect(sinHeaSec.ports[1], heaPum.port_b1) annotation (Line(
      points={{-28,-54},{-22,-54},{-22,-36},{-10,-36}},
      color={0,127,255},
      thickness=0.5));
  connect(division.u2, const.y) annotation (Line(points={{105.4,-41.2},{112,-41.2},
          {112,-50},{115.4,-50}}, color={0,0,127}));
  connect(division.y, souHeaSec.m_flow_in) annotation (Line(points={{89.3,-37},{
          76.65,-37},{76.65,-46},{64,-46}}, color={0,0,127}));
  connect(souCoo.ports[1], chi.port_a2) annotation (Line(
      points={{-46,54},{-30,54},{-30,36},{-24,36}},
      color={0,127,255},
      thickness=0.5));
  connect(chi.port_b2, sinCoo.ports[1]) annotation (Line(
      points={{-4,36},{0,36},{0,54},{14,54}},
      color={0,127,255},
      thickness=0.5));
  connect(division2.u1, add2.y) annotation (Line(points={{61.4,77.2},{67.7,77.2},
          {67.7,78},{73,78}},          color={0,0,127}));
  connect(division2.y, pumCoo.m_flow_in) annotation (Line(points={{45.3,73},{42,
          73},{42,36}},                  color={0,0,127}));
  connect(const2.y, division3.u2) annotation (Line(points={{-44.6,92},{-50,92},{
          -50,102.8},{-56.6,102.8}},  color={0,0,127}));
  connect(division3.y, souCoo.m_flow_in) annotation (Line(points={{-72.7,107},{
          -86,107},{-86,62},{-68,62}},
                                   color={0,0,127}));
  connect(port_a, port_a)
    annotation (Line(points={{-260,0},{-260,0}}, color={0,127,255}));
  connect(sum1.y, P_el_subSta)
    annotation (Line(points={{-241,84},{-270,84}}, color={0,0,127}));
  //Power Consumptin Calculation
  connect(chi.P, sum1.u[1]);
  connect(heaPum.P, sum1.u[2]);
  connect(pumCoo.P, sum1.u[3]);
  connect(pumHea.P, sum1.u[4]);

  connect(vol.ports[2], jun.port_1) annotation (Line(
      points={{-230,4},{-230,4},{-230,0},{-156,0}},
      color={0,127,255},
      thickness=1));
  connect(jun.port_2, pumHea.port_a) annotation (Line(
      points={{-136,0},{-124,0},{-124,-24},{-80,-24}},
      color={0,127,255},
      thickness=1));
  connect(jun1.port_2, pumCoo.port_a) annotation (Line(
      points={{116,0},{104,0},{104,24},{52,24}},
      color={0,127,255},
      thickness=1));
  connect(vol1.ports[2], jun1.port_1) annotation (Line(
      points={{200,8},{196,8},{196,0},{136,0}},
      color={0,127,255},
      thickness=1));
  connect(souHeaSec.T_in, T_heaPumInSec.y) annotation (Line(points={{64,-50},{80,
          -50},{80,-65},{87.3,-65}}, color={0,0,127}));
  connect(heaPum.TSet, T_heaPumSet.y) annotation (Line(points={{12,-39},{20,-39},
          {20,-71},{25.3,-71}}, color={0,0,127}));
  connect(realExpression2.y, add1.u2)
    annotation (Line(points={{-163.4,-72},{-136,-72}}, color={0,0,127}));
  connect(division.u1, realExpression1.y) annotation (Line(points={{105.4,-32.8},
          {124.7,-32.8},{124.7,-32},{125.4,-32}}, color={0,0,127}));
  connect(realExpression.y, division1.u2) annotation (Line(points={{-115.4,-90},
          {-108,-90},{-108,-74.8},{-97.6,-74.8}}, color={0,0,127}));
  connect(P_el_heaPum, realExpression3.y)
    annotation (Line(points={{-270,110},{-240.6,110}}, color={0,0,127}));
  connect(P_el_chi, realExpression4.y)
    annotation (Line(points={{-270,136},{-240.6,136}}, color={0,0,127}));
  connect(add2.u1, cooDem) annotation (Line(points={{96,84},{182,84},{182,62},{228,
          62}}, color={0,0,127}));
  connect(add2.u2, realExpression5.y)
    annotation (Line(points={{96,72},{117.4,72}}, color={0,0,127}));
  connect(division2.u2, const3.y) annotation (Line(points={{61.4,68.8},{66,68.8},
          {66,55},{79.3,55}}, color={0,0,127}));
  connect(division3.u1, cooDem) annotation (Line(points={{-56.6,111.2},{122,
          111.2},{122,84},{182,84},{182,62},{228,62}},
                                                color={0,0,127}));
  connect(chi.TSet, T_chiSet.y)
    annotation (Line(points={{-2,21},{2,21},{2,9},{9.3,9}}, color={0,0,127}));
  connect(realExpression6.y, souCoo.T_in) annotation (Line(points={{-93.4,58},{
          -68,58}},               color={0,0,127}));
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
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-260,10},{-154,-10}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{118,10},{220,-10}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-180},{220,160}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>October 19, 2020</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Substation model for bidirctional low-temperature networks for
  buildings with heat pump and chiller. In the case of simultaneous
  cooling and heating demands, the return flows are used as supply
  flows for the other application. This model uses the heat pump
  <a href=
  \"modelica://AixLib.Fluid.HeatPumps.Carnot_TCon\">AixLib.Fluid.HeatPumps.Carnot_TCon</a>
  and the chiller <a href=
  \"modelica://AixLib.Fluid.Chillers.Carnot_TEva\">AixLib.Fluid.Chillers.Carnot_TEva</a>.
  The mass flows are controlled equation-based and calculated using the
  heating and cooling demands and the specified temperature differences
  for heating an cooling on both primary (grind) and secondary
  (building system) side.
</p>
</html>"));
end DHCSubstationHeatPumpChiller;
