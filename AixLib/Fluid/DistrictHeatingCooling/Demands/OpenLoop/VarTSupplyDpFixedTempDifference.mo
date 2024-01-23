within AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop;
model VarTSupplyDpFixedTempDifference
  "Substation with variable supply temperature and fixed dT"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow(start=0),
    final dp(start=0),
    final allowFlowReversal=false,
    final m_flow_nominal = Q_flow_nominal/cp_default/dTDesign);

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal
    "Nominal heat flow rate added to medium";

  parameter Modelica.SIunits.TemperatureDifference dTDesign(
    displayUnit="K")
    "Constant temperature difference for the substation's heat exchanger";

  parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
    "Pressure difference at nominal flow rate"
    annotation(Dialog(group="Design parameter"));

  parameter Real deltaM=0.1
    "Fraction of nominal flow rate where flow transitions to laminar"
    annotation (Dialog(tab="Flow resistance"));
  parameter Modelica.SIunits.Time tau=30
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
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

public
  Modelica.Blocks.Interfaces.RealInput Q_flow_input "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Sensors.TemperatureTwoPort              senT_supply(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-74,-70},{-54,-50}})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Modelica.Blocks.Math.Gain gain(k=cp_default)
    annotation (Placement(transformation(extent={{-36,44},{-16,64}})));
  Modelica.Blocks.Math.Division heat2massFlow
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-2})));
  Sources.MassFlowSource_T              sink(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1) "Sink extracting prescribed flow from the network"
                                              annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-30,-60})));
  Modelica.Blocks.Math.Gain changeSign(k=-1)
    "Changes sign of prescribed flow for extraction from network" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-36})));
  Sources.MassFlowSource_T source(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1,
    use_T_in=true)
               "Source sending prescribed flow back to the network" annotation (
     Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={42,-60})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    "Output signal of pressure difference"
    annotation (Placement(transformation(extent={{98,70},{118,90}})));
  Modelica.Blocks.Sources.Constant deltaT(k=dTDesign)
    "Fixed temperature difference between supply and return" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-72,54})));
  Modelica.Blocks.Math.Add Treturn(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-46,10},{-26,30}})));
equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-88,0},
          {-88,-60},{-74,-60}}, color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{90,0},{90,
          -60},{80,-60}}, color={0,127,255}));
  connect(gain.y, heat2massFlow.u2)
    annotation (Line(points={{-15,54},{-6,54},{-6,10}}, color={0,0,127}));
  connect(Q_flow_input, heat2massFlow.u1)
    annotation (Line(points={{-108,80},{6,80},{6,10}}, color={0,0,127}));
  connect(source.ports[1], senT_return.port_a)
    annotation (Line(points={{52,-60},{60,-60}}, color={0,127,255}));
  connect(heat2massFlow.y, changeSign.u) annotation (Line(points={{-1.9984e-015,
          -13},{0,-13},{0,-24}}, color={0,0,127}));
  connect(changeSign.y, sink.m_flow_in)
    annotation (Line(points={{0,-47},{0,-52},{-18,-52}}, color={0,0,127}));
  connect(heat2massFlow.y, source.m_flow_in) annotation (Line(points={{0,-13},{0,
          -20},{20,-20},{20,-68},{30,-68}},   color={0,0,127}));
  connect(senT_supply.port_b, sink.ports[1])
    annotation (Line(points={{-54,-60},{-40,-60}}, color={0,127,255}));
  connect(deltaT.y, gain.u)
    annotation (Line(points={{-61,54},{-38,54}}, color={0,0,127}));
  connect(deltaT.y, Treturn.u1) annotation (Line(points={{-61,54},{-54,54},{-54,
          26},{-48,26}}, color={0,0,127}));
  connect(senT_supply.T, Treturn.u2) annotation (Line(points={{-64,-49},{-66,
          -49},{-66,14},{-48,14}}, color={0,0,127}));
  connect(Treturn.y, source.T_in) annotation (Line(points={{-25,20},{24,20},{24,
          -64},{30,-64}}, color={0,0,127}));
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
  A simple substation model using a fixed temperature difference and
  the actual supply temperature to calculate the mass flow rate drawn
  from the network. This model uses an open loop design to prescribe
  the required flow rate.
</p>
</html>", revisions="<html>
<ul>
  <li>October 23, 2018, by Tobias Blacha:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end VarTSupplyDpFixedTempDifference;
