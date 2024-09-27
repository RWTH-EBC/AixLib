within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationCooling
  "Substation model for bidirectional low-temperature networks for buildings with only cooling demand equipped with a chiller"

    replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.Units.SI.SpecificHeatCapacity cp_default = 4180 "Specific heat capacity of Water (cp-value)";

    parameter Modelica.Units.SI.HeatFlowRate coolingDemand_max "Maximum cooling demand for scaling of chiller in Watt (negative values)";

    parameter Modelica.Units.SI.Temperature deltaT_coolingSet "Set temperature difference for cooling on the building site";

    parameter Modelica.Units.SI.Temperature deltaT_coolingGridSet "Set temperature difference for cooling on the side of the thermal network";

    parameter Modelica.Units.SI.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal = -coolingDemand_max / (cp_default * deltaT_coolingGridSet)
    "Nominal mass flow rate based on max. cooling demand and set temperature difference";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-152,-10},{-132,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60) annotation (Placement(transformation(extent={{-130,6},{-110,26}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=288.15,
    tau=60) annotation (Placement(transformation(extent={{70,6},{90,26}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpCooling(
    redeclare package Medium = Medium,
    nominalValuesDefineDefaultPressureCurve=true,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    use_inputFilter=false,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{68,-10},{48,10}})));
  AixLib.Fluid.Chillers.Carnot_TEva chiller(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    allowFlowReversal1=true,
    use_eta_Carnot_nominal=true,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    allowFlowReversal2=false,
    etaCarnot_nominal=0.4,
    QEva_flow_nominal=coolingDemand_max,
    QEva_flow_min=coolingDemand_max) annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=180,
        origin={3,-5})));
  AixLib.Fluid.Sources.MassFlowSource_T coolingReturnBuilding(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1)
    "Mass flow source represents return flow of buildings cooling system"
    annotation (Placement(transformation(extent={{-46,-64},{-26,-44}})));
  Modelica.Blocks.Sources.Constant deltaT_coolingBuildingSite(k=
        deltaT_coolingSet)
    annotation (Placement(transformation(extent={{-126,-94},{-106,-74}})));
  AixLib.Fluid.Sources.Boundary_pT coolingSupplyBuilding(redeclare package
      Medium = Medium, nPorts=1)
    "Mass flow sink represents supply flow of buildings cooling system"
    annotation (Placement(transformation(extent={{64,-64},{44,-44}})));
  Modelica.Blocks.Sources.Constant const(k=-(cp_default*deltaT_coolingSet))
    annotation (Placement(transformation(extent={{-96,-46},{-84,-34}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-72,-38},{-58,-24}})));
  Modelica.Blocks.Sources.Constant const1(k=-(cp_default*deltaT_coolingGridSet))
    annotation (Placement(transformation(extent={{-24,50},{-12,62}})));
  Modelica.Blocks.Math.Division division1
    "Calculation of mass flow rate needed from dhc grid for cooling"
    annotation (Placement(transformation(extent={{-2,64},{12,78}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand(unit="W")
    "Input for cooling demand profile of substation (negative values for cooling)"
    annotation (Placement(transformation(extent={{-166,74},{-126,114}}),
        iconTransformation(extent={{-166,74},{-126,114}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemChiOut(redeclare package Medium
      =        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-82,-6},{-66,8}})));
  Modelica.Blocks.Interfaces.RealInput T_supplyCoolingSet(unit="K")
  "Supply temperature of the cooling circuit in the building"
    annotation (Placement(transformation(extent={{-166,28},{-126,68}}),
        iconTransformation(extent={{-166,28},{-126,68}})));
  Modelica.Blocks.Math.Add add(k2=+1)
    annotation (Placement(transformation(extent={{-92,-80},{-72,-60}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-44,64},{-24,84}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandChiller(unit="W")
  "Power demand of chiller"
    annotation (Placement(transformation(extent={{96,90},{116,110}}),
        iconTransformation(extent={{96,90},{116,110}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandPump(unit="W")
  "Power demand of distribution pump"
    annotation (Placement(transformation(extent={{96,66},{116,86}}),
        iconTransformation(extent={{96,66},{116,86}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandSubstation(unit="W")
  "Power demand of substation (sum of chiller and distribution pump)"
    annotation (Placement(transformation(extent={{96,42},{116,62}}),
        iconTransformation(extent={{96,42},{116,62}})));
  Modelica.Blocks.Math.Sum sum1(nin=1)
    "Adds power demand for chiller and distribution pump"
    annotation (Placement(transformation(extent={{68,36},{88,56}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    "switches cooling demand profile from positiv to negativ values"
    annotation (Placement(transformation(extent={{-118,70},{-98,90}})));
  Sensors.TemperatureTwoPort senTemChiIn(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{20,-10},{36,4}})));
equation
  connect(port_a, vol.ports[1])
    annotation (Line(points={{-142,0},{-121,0},{-121,6}},
                                                        color={0,127,255}));
  connect(port_b, vol1.ports[1])
    annotation (Line(points={{100,0},{79,0},{79,6}}, color={0,127,255}));
  connect(pumpCooling.port_a, vol1.ports[2])
    annotation (Line(points={{68,0},{81,0},{81,6}}, color={0,127,255}));
  connect(const1.y, division1.u2) annotation (Line(points={{-11.4,56},{-10,56},{
          -10,66},{-3.4,66},{-3.4,66.8}},
                                   color={0,0,127}));
  connect(chiller.port_b2, coolingSupplyBuilding.ports[1]) annotation (Line(
        points={{12,-10.4},{40,-10.4},{40,-54},{44,-54}},
                                                      color={0,127,255}));
  connect(add.y, coolingReturnBuilding.T_in) annotation (Line(points={{-71,-70},
          {-58,-70},{-58,-50},{-48,-50}}, color={0,0,127}));
  connect(deltaT_coolingBuildingSite.y, add.u2) annotation (Line(points={{-105,-84},
          {-100,-84},{-100,-76},{-94,-76}},      color={0,0,127}));
  connect(T_supplyCoolingSet, add.u1) annotation (Line(points={{-146,48},{-102,48},
          {-102,-64},{-94,-64}}, color={0,0,127}));
  connect(add1.y, division1.u1) annotation (Line(points={{-23,74},{-16,74},{-16,
          75.2},{-3.4,75.2}}, color={0,0,127}));
  connect(chiller.P, add1.u2) annotation (Line(points={{-6.9,-5},{-54,-5},{-54,68},
          {-46,68}},     color={0,0,127}));
  connect(division1.y, pumpCooling.m_flow_in)
    annotation (Line(points={{12.7,71},{58,71},{58,12}},color={0,0,127}));
  connect(chiller.P, powerDemandChiller) annotation (Line(points={{-6.9,-5},{-54,
          -5},{-54,100},{106,100}},                          color={0,0,127}));
  connect(pumpCooling.P, powerDemandPump) annotation (Line(points={{47,9},{46,9},
          {46,76},{106,76}},        color={0,0,127}));
  connect(sum1.y, powerDemandSubstation)
    annotation (Line(points={{89,46},{98,46},{98,52},{106,52}},
                                                color={0,0,127}));
  connect(chiller.P, sum1.u[1]) annotation (Line(points={{-6.9,-5},{-54,-5},{-54,
          46},{66,46}},      color={0,0,127}));
  connect(coolingDemand, gain.u)
    annotation (Line(points={{-146,94},{-134,94},{-134,80},{-120,80}},
                                                   color={0,0,127}));
  connect(gain.y, add1.u1)
    annotation (Line(points={{-97,80},{-46,80}}, color={0,0,127}));
  connect(gain.y, division.u1) annotation (Line(points={{-97,80},{-90,80},{-90,-26.8},
          {-73.4,-26.8}},            color={0,0,127}));
  connect(T_supplyCoolingSet, chiller.TSet) annotation (Line(points={{-146,48},{
          36,48},{36,3.1},{13.8,3.1}},
                                 color={0,0,127}));
  connect(const.y, division.u2) annotation (Line(points={{-83.4,-40},{-80,-40},{
          -80,-35.2},{-73.4,-35.2}}, color={0,0,127}));
  connect(division.y, coolingReturnBuilding.m_flow_in) annotation (Line(points={
          {-57.3,-31},{-54,-31},{-54,-46},{-48,-46}}, color={0,0,127}));
  connect(chiller.port_a2, coolingReturnBuilding.ports[1]) annotation (Line(
        points={{-6,-10.4},{-22,-10.4},{-22,-54},{-26,-54}},
                                                         color={0,127,255}));
  connect(senTemChiOut.port_b, chiller.port_b1) annotation (Line(points={{-66,1},
          {-34,1},{-34,0.4},{-6,0.4}}, color={0,127,255}));
  connect(vol.ports[2], senTemChiOut.port_a) annotation (Line(points={{-119,6},{
          -118,6},{-118,1},{-82,1}}, color={0,127,255}));
  connect(senTemChiIn.port_b, pumpCooling.port_b)
    annotation (Line(points={{36,-3},{36,0},{48,0}}, color={0,127,255}));
  connect(senTemChiIn.port_a, chiller.port_a1)
    annotation (Line(points={{20,-3},{20,0.4},{12,0.4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
            {100,120}}), graphics={
        Rectangle(
          extent={{-140,120},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,34},{58,-80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,34},{58,34}}, color={28,108,200}),
        Polygon(
          points={{-104,34},{-18,112},{70,34},{-104,34}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-58,18},{-30,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,18},{28,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-32,-28},{-6,-80}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{100,120}})),
    Documentation(revisions="<html><ul>
    <li><i>February 20, 2024</i> by Rahul Karuvingal:<br/>
    Revised to make it compatible with MSL 4.0.0 and Aixlib 1.3.2.
  </li>
  <li><i>April 15, 2020</i> by Tobias Blacha:<br/>
Added documentation </li>
<li><i>August 09, 2018</i> by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirectional low-temperature networks with chiller and fixed temperature difference (parameter) on network side. 
This model uses the chiller <a href=\"modelica://AixLib.Fluid.Chillers.Carnot_TEva\">AixLib.Fluid.Chillers.Carnot_TEva</a>.
The supply temperature of buildings cooling system must be set be using the input T_supplyCoolingSet.  </p>
</html>"));
end SubstationCooling;
