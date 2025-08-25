within AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop;
model HeatPumpCarnot "Substation with a heat pump carnot model"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow(start=0),
    final dp(start=0),
    final allowFlowReversal=false,
    final m_flow_nominal = Q_flow_nominal/cp_default/dTDesign);

  replaceable package MediumBuilding =
    Modelica.Media.Interfaces.PartialMedium
      "Medium in the building heating system"
      annotation (choicesAllMatching = true);

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal
    "Nominal heat flow rate added to medium";

  parameter Modelica.Units.SI.TemperatureDifference dTDesign(displayUnit="K")
    "Design temperature difference for the heat pump on its district heating side";

  parameter Modelica.Units.SI.Temperature TReturn "Fixed return temperature";

  parameter Modelica.Units.SI.TemperatureDifference dTBuilding(displayUnit="K")
    "Design temperature difference for the building's heating system";

  parameter Modelica.Units.SI.Temperature TSupplyBuilding
    "Fixed supply temperature for the building heating system";

  parameter Modelica.Units.SI.Pressure dp_nominal(displayUnit="Pa") = 30000
    "Pressure difference at nominal flow rate"
    annotation (Dialog(group="Design parameter"));

  parameter Real deltaM=0.1
    "Fraction of nominal flow rate where flow transitions to laminar"
    annotation (Dialog(tab="Flow resistance"));
  parameter Modelica.Units.SI.Time tau=30
    "Time constant at nominal flow (if energyDynamics <> SteadyState)"
    annotation (Dialog(tab="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics"));

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid in the district heating system";
  final parameter Modelica.Units.SI.SpecificHeatCapacity cp_default_building=
      MediumBuilding.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid in the building heating system";

public
  Modelica.Blocks.Interfaces.RealInput Q_flow_input "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Sensors.TemperatureTwoPort              senT_supply(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-88,-20})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-20})));
  Modelica.Blocks.Math.Add deltaT(k2=-1)
    "Differernce of flow and return line temperature in K" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-40,-10})));
  Modelica.Blocks.Sources.Constant dTheaPum(k=dTDesign)
    "Temperature drop over heat pump in K" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,50})));
  Modelica.Blocks.Math.Gain gain(k=cp_default)
    annotation (Placement(transformation(extent={{-32,40},{-12,60}})));
  Modelica.Blocks.Math.Division hea2MasFlo annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={24,32})));
  Sources.MassFlowSource_T              sink(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1) "Sink extracting prescribed flow from the network"
                                              annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={10,-50})));
  Modelica.Blocks.Math.Gain changeSign(k=-1)
    "Changes sign of prescribed flow for extraction from network" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={24,0})));
  Sources.MassFlowSource_T source(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1,
    T=TReturn,
    use_T_in=true)
               "Source sending prescribed flow back to the network" annotation (
     Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={70,-40})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    "Output signal of pressure difference"
    annotation (Placement(transformation(extent={{98,70},{118,90}})));
  HeatPumps.Carnot_TCon              heaPum(
    redeclare package Medium1 = MediumBuilding,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    etaCarnot_nominal=0.3,
    show_T=true,
    redeclare package Medium2 = Medium,
    QCon_flow_nominal=Q_flow_nominal)
    annotation (Placement(transformation(extent={{-30,-46},{-50,-66}})));
  Modelica.Blocks.Math.Add Q_con(k2=-1)
    "Differernce of heat demand and electric power of heat pump" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,74})));
  Sources.MassFlowSource_T              sourceHeating(
    use_m_flow_in=true,
    redeclare package Medium = MediumBuilding,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{20,-90},{0,-70}})));
  Sources.Boundary_pT                sinkHeating(
                          redeclare package Medium = MediumBuilding, nPorts=1)
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  Modelica.Blocks.Math.Gain masFloBuilding(k=1/(cp_default_building*dTBuilding))
    "Changes sign of prescribed flow for extraction from network" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,50})));
  Modelica.Blocks.Sources.Constant temperatureSupplyBuilding(k=TSupplyBuilding)
    "Temperature of supply line" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,-90})));
  Modelica.Blocks.Sources.Constant deltaTBuilding(k=dTBuilding)
    "Temperature difference in building heating system" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,-70})));
  Modelica.Blocks.Math.Add temperatureReturnBuilding(k2=-1)
    "Temperature returning from building heating system" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={42,-76})));
  Modelica.Blocks.Math.Gain gainInput(k=1) "Optional gain on the input"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.Constant minT_return(k=273.15 + 10)
    "Minimal return Temperature" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-40,20})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-2,-32},{18,-12}})));
equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-88,0},
          {-88,-10}},           color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{90,0},{90,
          -10}},          color={0,127,255}));
  connect(gain.y, hea2MasFlo.u2)
    annotation (Line(points={{-11,50},{18,50},{18,44}}, color={0,0,127}));
  connect(source.ports[1], senT_return.port_a)
    annotation (Line(points={{80,-40},{90,-40},{90,-30}},
                                                 color={0,127,255}));
  connect(hea2MasFlo.y, changeSign.u)
    annotation (Line(points={{24,21},{24,12}}, color={0,0,127}));
  connect(changeSign.y, sink.m_flow_in)
    annotation (Line(points={{24,-11},{24,-42},{22,-42}},color={0,0,127}));
  connect(hea2MasFlo.y, source.m_flow_in) annotation (Line(points={{24,21},{24,
          16},{54,16},{54,-48},{58,-48}}, color={0,0,127}));
  connect(senT_supply.port_b, heaPum.port_a2) annotation (Line(points={{-88,-30},
          {-88,-50},{-50,-50}}, color={0,127,255}));
  connect(sink.ports[1], heaPum.port_b2)
    annotation (Line(points={{0,-50},{-30,-50}}, color={0,127,255}));
  connect(Q_con.y, hea2MasFlo.u1)
    annotation (Line(points={{21,74},{30,74},{30,44}}, color={0,0,127}));
  connect(heaPum.P, Q_con.u2) annotation (Line(points={{-51,-56},{-70,-56},{-70,
          68},{-2,68}}, color={0,0,127}));
  connect(masFloBuilding.y, sourceHeating.m_flow_in) annotation (Line(points={{60,
          39},{60,-20},{30,-20},{30,-72},{22,-72}}, color={0,0,127}));
  connect(temperatureSupplyBuilding.y, heaPum.TSet) annotation (Line(points={{
          59,-90},{-22,-90},{-22,-65},{-28,-65}}, color={0,0,127}));
  connect(sourceHeating.T_in, temperatureReturnBuilding.y)
    annotation (Line(points={{22,-76},{31,-76}}, color={0,0,127}));
  connect(temperatureSupplyBuilding.y, temperatureReturnBuilding.u1)
    annotation (Line(points={{59,-90},{58,-90},{58,-82},{54,-82}}, color={0,0,
          127}));
  connect(deltaTBuilding.y, temperatureReturnBuilding.u2)
    annotation (Line(points={{79,-70},{54,-70}}, color={0,0,127}));
  connect(sinkHeating.ports[1], heaPum.port_b1) annotation (Line(points={{-70,
          -80},{-60,-80},{-60,-62},{-50,-62}}, color={0,127,255}));
  connect(heaPum.port_a1, sourceHeating.ports[1]) annotation (Line(points={{-30,
          -62},{-12,-62},{-12,-80},{0,-80}}, color={0,127,255}));
  connect(dTheaPum.y, gain.u)
    annotation (Line(points={{-79,50},{-34,50}}, color={0,0,127}));
  connect(senT_supply.T, deltaT.u1) annotation (Line(points={{-77,-20},{-58,-20},
          {-58,-16},{-52,-16}}, color={0,0,127}));
  connect(dTheaPum.y, deltaT.u2) annotation (Line(points={{-79,50},{-58,50},{-58,
          -4},{-52,-4}}, color={0,0,127}));
  connect(Q_flow_input, gainInput.u)
    annotation (Line(points={{-108,80},{-62,80}}, color={0,0,127}));
  connect(Q_con.u1, gainInput.y)
    annotation (Line(points={{-2,80},{-39,80}}, color={0,0,127}));
  connect(gainInput.y,masFloBuilding. u) annotation (Line(points={{-39,80},{-20,
          80},{-20,94},{60,94},{60,62}}, color={0,0,127}));
  connect(deltaT.y, max.u2) annotation (Line(points={{-29,-10},{-18,-10},{-18,
          -28},{-4,-28}}, color={0,0,127}));
  connect(minT_return.y, max.u1) annotation (Line(points={{-29,20},{-6,20},{-6,
          -16},{-4,-16}}, color={0,0,127}));
  connect(max.y, source.T_in) annotation (Line(points={{19,-22},{38,-22},{38,
          -44},{58,-44}}, color={0,0,127}));
  annotation ( Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                     graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-42,-4},{-14,24}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{16,-4},{44,24}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{16,-54},{44,-26}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-42,-54},{-14,-26}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{52,70},{96,50}},
          lineColor={0,0,127},
          textString="PPum"),             Polygon(
          points={{-86,38},{-86,-42},{-26,-2},{-86,38}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
                             Ellipse(
          extent={{-8,40},{72,-40}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html><p>
  A simple substation model using a fixed return temperature and the
  actual supply temperature to calculate the mass flow rate drawn from
  the network. This model uses an open loop design to prescribe the
  required flow rate. This model includes a heat pump model using the
  district heating network as its source.
</p>
<ul>
  <li>Novemver 22, 2019, by Nils Neuland:<br/>
    Revised variable names and documentation to follow guidelines.
  </li>
  <li>March 4, 2018, by Marcus Fuchs:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end HeatPumpCarnot;
