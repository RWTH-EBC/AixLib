within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model DHCSubstationHeatPumpDirectCooling "Substation model for bidirctional low-temperature networks for buildings with 
  heat pump and direct cooling."

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model for water"
      annotation (choicesAllMatching = true);

  parameter Modelica.Units.SI.Pressure dp_nominal(displayUnit="Pa") = 30000
    "Nominal pressure drop";


  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=m_flow_nominal
    "Nominal mass flow rate"
    annotation (Dialog(tab="General", group="Building System"));

  parameter Modelica.Units.SI.HeatFlowRate heaDem_max
    "Maximum heat demand for scaling of heat pump"
    annotation (Dialog(tab="General", group="Building System"));

  parameter Modelica.Units.SI.Temperature deltaT_heaSecSet=10
    "Set temperature difference for heating on secondary site (building system)"
    annotation (Dialog(tab="General", group="Building System"));

  parameter Modelica.Units.SI.Temperature T_heaSecSet=273.15 + 55
    "Set supply temperature for space heating on secondary side (building)"
    annotation (Dialog(tab="General", group="Building System"));


  parameter Modelica.Units.SI.Temperature T_heaPriSet=273.15 + 22
    "Set temperature of primary side (warm line of grid)"
    annotation (Dialog(tab="General", group="Grid"));
  parameter Modelica.Units.SI.Temperature T_cooPriSet=273.15 + 12
    "Set temperature of primary side (cold line of grid)"
    annotation (Dialog(tab="General", group="Grid"));




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
  Movers.FlowControlled_m_flow pumHeaPri(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    "decentral distribution pump for heating on primary side"
    annotation (Placement(transformation(extent={{-60,-14},{-40,-34}})));
  Sources.MassFlowSource_T souHeaSec(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1)
    annotation (Placement(transformation(extent={{128,-96},{106,-74}})));
  Modelica.Blocks.Sources.Constant T_heaPumInSec(k=T_heaSecSet -
        deltaT_heaSecSet) "Inlet temperatur of heat pump on secondary side"
    annotation (Placement(transformation(extent={{168,-100},{154,-86}})));
  Sources.Boundary_pT sinHeaSec(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-54,-112},{-34,-92}})));
  Modelica.Blocks.Sources.Constant const(k=(cp_default*deltaT_heaSecSet))
    annotation (Placement(transformation(extent={{192,-84},{180,-72}})));
  Modelica.Blocks.Math.Division m_flow_heaSec
    "Mass flow rate on secondary side"
    annotation (Placement(transformation(extent={{168,-72},{154,-58}})));
  HeatPumps.Carnot_TCon              heaPum(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    show_T=true,
    etaCarnot_nominal=0.5,
    QCon_flow_nominal=heaDem_max)
    annotation (Placement(transformation(extent={{58,-20},{38,-40}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-90,-70},{-74,-54}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=(cp_default*(
        senT_heaPumInPri.T - T_cooPriSet)))
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
  Delays.DelayFirstOrder dirCoo(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal) "Ideal heat exchanger for direct cooling"
    annotation (Placement(transformation(extent={{-4,24},{16,44}})));
  Movers.FlowControlled_m_flow pumCoo(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    "decentral distribution pump for cooling on primary side"
    annotation (Placement(transformation(extent={{68,14},{48,34}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{102,52},{88,66}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=(cp_default*(
        T_heaPriSet - senT_dirCooInPri.T)))
    annotation (Placement(transformation(extent={{132,44},{120,56}})));
  Modelica.Blocks.Sources.Constant T_heaPumSet(k=T_heaSecSet)
    annotation (Placement(transformation(extent={{88,-44},{78,-34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-22,60})));
  Sensors.TemperatureTwoPort senT_heaPumOutPri(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{106,-34},{126,-14}})));
  Sensors.TemperatureTwoPort senT_heaPumInPri(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-26,-34},{-6,-14}})));
  Sensors.TemperatureTwoPort senT_heaPumOutSec(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    "Outlet temperature of heat pump on secondary side"
    annotation (Placement(transformation(extent={{-2,-92},{-22,-72}})));
  Sensors.TemperatureTwoPort senT_heaPumInSec(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    "Inlet temperatur of heat pump on secondary side"
    annotation (Placement(transformation(extent={{90,-96},{70,-74}})));
  Sensors.TemperatureTwoPort senT_dirCooInPri(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    "Inlet temperature of ideal heat exchanger for direct cooling on primary side"
    annotation (Placement(transformation(extent={{108,14},{128,34}})));
  Sensors.TemperatureTwoPort senT_dirCooOutPri(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    "Outlet temperature of ideal heat exchanger for direct cooling on primary side"
    annotation (Placement(transformation(extent={{-78,14},{-58,34}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression2(y=heaPum.P)
    annotation (Placement(transformation(extent={{-154,-70},{-142,-58}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression3(y=heaPum.P)
    annotation (Placement(transformation(extent={{210,-46},{222,-34}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=heaDem)
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
  Modelica.Blocks.Interfaces.RealInput heaDem(unit="W")
    "Input for heat demand profile of substation" annotation (Placement(
        transformation(extent={{-274,-72},{-234,-32}}), iconTransformation(
          extent={{254,68},{214,108}})));
  Modelica.Blocks.Interfaces.RealInput cooDem(unit="W")
    "Input for cooling demand profile of substation" annotation (Placement(
        transformation(extent={{268,42},{228,82}}), iconTransformation(extent={
            {-278,40},{-238,80}})));
  Modelica.Blocks.Interfaces.RealOutput P_el_heaPum(unit="W")
    "Electrical power consumed by heat pump"
    annotation (Placement(transformation(extent={{236,-50},{256,-30}})));

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

equation
  connect(port_a,vol. ports[1])
    annotation (Line(points={{-240,0},{-214,0},{-214,4}},
                                                        color={0,127,255},
      thickness=1));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{240,0},{216,0},{216,8}},
                                                     color={0,127,255},
      thickness=1));
  connect(heaDem, add1.u1)
    annotation (Line(points={{-254,-52},{-130,-52}}, color={0,0,127}));
  connect(add1.y,division1. u1) annotation (Line(points={{-107,-58},{-100,-58},
          {-100,-57.2},{-91.6,-57.2}},color={0,0,127}));
  connect(realExpression.y,division1. u2) annotation (Line(points={{-119.4,-90},
          {-102,-90},{-102,-66.8},{-91.6,-66.8}}, color={0,0,127}));
  connect(m_flow_heaSec.u2, const.y) annotation (Line(points={{169.4,-69.2},{
          176,-69.2},{176,-78},{179.4,-78}}, color={0,0,127}));
  connect(m_flow_heaSec.y, souHeaSec.m_flow_in) annotation (Line(points={{153.3,
          -65},{140.65,-65},{140.65,-76.2},{130.2,-76.2}}, color={0,0,127}));
  connect(division2.u2,realExpression1. y) annotation (Line(points={{103.4,54.8},
          {111.7,54.8},{111.7,50},{119.4,50}},
                                             color={0,0,127}));
  connect(port_a,port_a)
    annotation (Line(points={{-240,0},{-240,0}}, color={0,127,255}));
  connect(T_heaPumSet.y, heaPum.TSet)
    annotation (Line(points={{77.5,-39},{60,-39}}, color={0,0,127}));
  connect(dirCoo.ports[1], pumCoo.port_b)
    annotation (Line(points={{4,24},{48,24}}, color={0,127,255},
      thickness=1));
  connect(cooDem, division2.u1) annotation (Line(points={{248,62},{176,62},{176,
          63.2},{103.4,63.2}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, dirCoo.heatPort)
    annotation (Line(points={{-22,50},{-22,34},{-4,34}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, cooDem) annotation (Line(points={{-22,70},
          {-22,88},{176,88},{176,62},{248,62}}, color={0,0,127}));
  connect(pumHeaPri.port_b, senT_heaPumInPri.port_a)
    annotation (Line(points={{-40,-24},{-26,-24}}, color={0,127,255},
      thickness=1));
  connect(senT_heaPumInPri.port_b, heaPum.port_a2)
    annotation (Line(points={{-6,-24},{38,-24}}, color={0,127,255},
      thickness=1));
  connect(heaPum.port_b2, senT_heaPumOutPri.port_a)
    annotation (Line(points={{58,-24},{106,-24}}, color={0,127,255},
      thickness=1));
  connect(senT_heaPumOutPri.port_b, jun1.port_3) annotation (Line(points={{126,
          -24},{146,-24},{146,-10}}, color={0,127,255},
      thickness=1));
  connect(senT_heaPumOutSec.port_a, heaPum.port_b1) annotation (Line(points={{-2,
          -82},{30,-82},{30,-36},{38,-36}}, color={0,127,255},
      thickness=0.5));
  connect(senT_heaPumOutSec.port_b, sinHeaSec.ports[1]) annotation (Line(points=
         {{-22,-82},{-34,-82},{-34,-102}}, color={0,127,255},
      thickness=0.5));
  connect(senT_dirCooInPri.port_b, jun1.port_2) annotation (Line(points={{128,
          24},{130,24},{130,0},{136,0}}, color={0,127,255},
      thickness=1));
  connect(division2.y, pumCoo.m_flow_in)
    annotation (Line(points={{87.3,59},{58,59},{58,36}}, color={0,0,127}));
  connect(division1.y, pumHeaPri.m_flow_in) annotation (Line(points={{-73.2,-62},
          {-50,-62},{-50,-36}}, color={0,0,127}));
  connect(senT_dirCooOutPri.port_b, dirCoo.ports[2])
    annotation (Line(points={{-58,24},{8,24}}, color={0,127,255},
      thickness=1));
  connect(jun.port_3, senT_dirCooOutPri.port_a) annotation (Line(points={{-126,
          10},{-128,10},{-128,24},{-78,24}}, color={0,127,255},
      thickness=1));
  connect(souHeaSec.T_in, T_heaPumInSec.y) annotation (Line(points={{130.2,-80.6},
          {136,-80.6},{136,-90},{153.3,-90},{153.3,-93}}, color={0,0,127}));
  connect(realExpression2.y,add1. u2)
    annotation (Line(points={{-141.4,-64},{-130,-64}}, color={0,0,127}));
  connect(senT_heaPumInSec.port_b, heaPum.port_a1) annotation (Line(points={{70,-85},
          {68,-85},{68,-84},{66,-84},{66,-36},{58,-36}},      color={0,127,255},
      thickness=0.5));

  connect(senT_heaPumInSec.port_a, souHeaSec.ports[1])
    annotation (Line(points={{90,-85},{106,-85}}, color={0,127,255},
      thickness=0.5));
  connect(realExpression3.y, P_el_heaPum)
    annotation (Line(points={{222.6,-40},{246,-40}}, color={0,0,127}));
  connect(m_flow_heaSec.u1, realExpression4.y) annotation (Line(points={{169.4,
          -60.8},{177.7,-60.8},{177.7,-60},{181.4,-60}}, color={0,0,127}));
  connect(vol.ports[2], jun.port_1)
    annotation (Line(points={{-210,4},{-210,0},{-136,0}}, color={0,127,255},
      thickness=1));
  connect(jun.port_2, pumHeaPri.port_a) annotation (Line(points={{-116,0},{-96,
          0},{-96,-24},{-60,-24}}, color={0,127,255},
      thickness=1));
  connect(pumCoo.port_a, senT_dirCooInPri.port_a)
    annotation (Line(points={{68,24},{108,24}}, color={0,127,255},
      thickness=1));
  connect(jun1.port_1, vol1.ports[2])
    annotation (Line(points={{156,0},{220,0},{220,8}}, color={0,127,255},
      thickness=1));
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
end DHCSubstationHeatPumpDirectCooling;
