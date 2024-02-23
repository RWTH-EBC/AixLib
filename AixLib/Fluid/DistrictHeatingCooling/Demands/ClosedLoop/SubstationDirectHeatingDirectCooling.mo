within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationDirectHeatingDirectCooling "Substation model for bidirctional low-temperature networks for buildings with 
  direct heating and direct cooling. For simultaneous cooling and heat demands, 
  the return flows are used as supply flows for the other application."

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.Units.SI.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";

    parameter Modelica.Units.SI.HeatFlowRate heatDemand_max "Maximum heat demand for scaling of heat pump";

    parameter Modelica.Units.SI.Temperature deltaT_heatingSet "Set temperature difference for heating on the site of building";

    parameter Modelica.Units.SI.Temperature deltaT_heatingGridSet "Set temperature difference for heating on the site of thermal network";
    parameter Modelica.Units.SI.Temperature deltaT_coolingGridSet "Set temperature difference for cooling on the side of the thermal network";

    parameter Modelica.Units.SI.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";

    parameter Modelica.Units.SI.Temperature T_supplyHeatingSet "Set supply temperature fore space heating";

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal = m_flow_nominal
    "Nominal mass flow rate";

  AixLibDHC.Fluid.Delays.DelayFirstOrder vol(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60) annotation (Placement(transformation(extent={{-242,4},{-222,24}})));
  AixLibDHC.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60) annotation (Placement(transformation(extent={{188,8},{208,28}})));
  AixLibDHC.Fluid.Movers.FlowControlled_m_flow pumpHeating(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-80,-14},{-60,-34}})));
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
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-96,-78},{-80,-62}})));
  Modelica.Blocks.Sources.Constant const3(k=(cp_default*deltaT_heatingGridSet))
    annotation (Placement(transformation(extent={{-138,-104},{-126,-92}})));
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit = "W")
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-294,-80},{-254,-40}}),
        iconTransformation(extent={{152,84},{112,124}})));

  AixLibDHC.Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1})
    annotation (Placement(transformation(extent={{-156,10},{-136,-10}})));

  AixLibDHC.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    dp_nominal={0,dp_nominal,dp_nominal},
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering,
    m_flow_nominal=m_flow_nominal*{1,1,1})
    annotation (Placement(transformation(extent={{136,-10},{116,10}})));
  AixLibDHC.Fluid.Delays.DelayFirstOrder del(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-24,24},{-4,44}})));
  AixLibDHC.Fluid.Movers.FlowControlled_m_flow pumpCooling(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{48,14},{28,34}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand(unit = "W")
  "Input for cooling demand profile of substation"
    annotation (Placement(
        transformation(extent={{248,42},{208,82}}), iconTransformation(extent={{-176,66},
            {-136,106}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{48,100},{34,114}})));
  Modelica.Blocks.Sources.Constant const1(k=(cp_default*deltaT_coolingGridSet))
    annotation (Placement(transformation(extent={{78,84},{66,96}})));
  AixLibDHC.Fluid.Sensors.MassFlowRate senMasFlo_GridHeat(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-206,-10},{-186,10}})));
  AixLibDHC.Fluid.Sensors.MassFlowRate senMasFlo_GridCool(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{152,-10},{172,10}})));
  AixLibDHC.Fluid.Sensors.MassFlowRate senMasFlo_HeatPump(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-114,-34},{-94,-14}})));
  AixLibDHC.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium) annotation (Placement(transformation(extent={{78,14},{58,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,88})));
  AixLibDHC.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{22,-34},{42,-14}})));
  AixLibDHC.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium
      = Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-46,-34},{-26,-14}})));
  AixLibDHC.Fluid.Delays.DelayFirstOrder del1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-24},{10,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-40,-84})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-178,-132},{-158,-112}})));
equation

  connect(port_a,vol. ports[1])
    annotation (Line(points={{-260,0},{-233,0},{-233,4}},
                                                        color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{220,0},{197,0},{197,8}},
                                                     color={0,127,255}));
  connect(const3.y, division1.u2) annotation (Line(points={{-125.4,-98},{-108,-98},
          {-108,-74.8},{-97.6,-74.8}}, color={0,0,127}));
  connect(division1.y, pumpHeating.m_flow_in) annotation (Line(points={{-79.2,-70},
          {-70,-70},{-70,-36}}, color={0,0,127}));
  connect(division2.u2, const1.y) annotation (Line(points={{49.4,102.8},{57.7,
          102.8},{57.7,90},{65.4,90}}, color={0,0,127}));
  connect(division2.y, pumpCooling.m_flow_in) annotation (Line(points={{33.3,
          107},{32,107},{32,66},{38,66},{38,36}}, color={0,0,127}));
  connect(vol.ports[2], senMasFlo_GridHeat.port_a) annotation (Line(points={{-231,4},
          {-231,0},{-206,0},{-206,0}},         color={0,127,255}));
  connect(senMasFlo_GridHeat.port_b, jun.port_1)
    annotation (Line(points={{-186,0},{-156,0}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_b, vol1.ports[2])
    annotation (Line(points={{172,0},{199,0},{199,8}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_a, jun1.port_1)
    annotation (Line(points={{152,0},{136,0}}, color={0,127,255}));
  connect(jun.port_2, senMasFlo_HeatPump.port_a) annotation (Line(points={{
          -136,0},{-118,0},{-118,-24},{-114,-24}}, color={0,127,255}));
  connect(senMasFlo_HeatPump.port_b, pumpHeating.port_a)
    annotation (Line(points={{-94,-24},{-80,-24}}, color={0,127,255}));
  connect(senMasFlo.port_a, jun1.port_2) annotation (Line(points={{78,24},{100,24},
          {100,0},{116,0}}, color={0,127,255}));
  connect(senMasFlo.port_b, pumpCooling.port_a)
    annotation (Line(points={{58,24},{48,24}}, color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-260,0},{-260,0}}, color={0,127,255}));
  connect(del.ports[1], pumpCooling.port_b)
    annotation (Line(points={{-15,24},{28,24}}, color={0,127,255}));
  connect(jun.port_3, del.ports[2]) annotation (Line(points={{-146,10},{-148,10},
          {-148,24},{-13,24}}, color={0,127,255}));
  connect(coolingDemand, division2.u1) annotation (Line(points={{228,62},{122,62},
          {122,111.2},{49.4,111.2}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, del.heatPort)
    annotation (Line(points={{-40,78},{-40,34},{-24,34}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, coolingDemand) annotation (Line(points={{-40,
          98},{-40,138},{156,138},{156,62},{228,62}}, color={0,0,127}));
  connect(pumpHeating.port_b, senTem1.port_a)
    annotation (Line(points={{-60,-24},{-46,-24}}, color={0,127,255}));
  connect(senTem.port_b, jun1.port_3) annotation (Line(points={{42,-24},{126,
          -24},{126,-10}}, color={0,127,255}));
  connect(senTem1.port_b,del1. ports[1])
    annotation (Line(points={{-26,-24},{-1,-24}}, color={0,127,255}));
  connect(senTem.port_a,del1. ports[2])
    annotation (Line(points={{22,-24},{1,-24}}, color={0,127,255}));
  connect(prescribedHeatFlow1.port,del1. heatPort) annotation (Line(points={{-40,
          -74},{-40,-52},{-18,-52},{-18,-34},{-10,-34}}, color={191,0,0}));
  connect(heatDemand, division1.u1) annotation (Line(points={{-274,-60},{-124,-60},
          {-124,-65.2},{-97.6,-65.2}}, color={0,0,127}));
  connect(heatDemand, gain.u) annotation (Line(points={{-274,-60},{-234,-60},{
          -234,-122},{-180,-122}}, color={0,0,127}));
  connect(gain.y, prescribedHeatFlow1.Q_flow) annotation (Line(points={{-157,
          -122},{-40,-122},{-40,-94}}, color={0,0,127}));
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
    <li><i>February 20, 2024</i> by Rahul Karuvingal:<br/>
    Revised to make it compatible with MSL 4.0.0 and Aixlib 1.3.2.
    </li>
<li><i>August 09, 2018</i> by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>"));
end SubstationDirectHeatingDirectCooling;
