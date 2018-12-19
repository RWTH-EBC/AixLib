within AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop;
model VarTSupplyDpFixedTempDifferenceBypass
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

  parameter Modelica.SIunits.MassFlowRate m_flo_bypass
    "Minimum bypass flow through substation";

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
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={94,-44})));
  Modelica.Blocks.Math.Gain gain(k=cp_default)
    annotation (Placement(transformation(extent={{-36,44},{-16,64}})));
  Modelica.Blocks.Math.Division heat2massFlow
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={24,60})));
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
    use_T_in=true,
    nPorts=1)  "Source sending prescribed flow back to the network" annotation (
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
  Utilities.Math.SmoothMax smoothMax(deltaX=0.001) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-4})));
  Modelica.Blocks.Sources.RealExpression m_flo_min(y=m_flo_bypass)
    annotation (Placement(transformation(extent={{80,34},{60,54}})));
  Utilities.Logical.SmoothSwitch switch1
    annotation (Placement(transformation(extent={{60,6},{80,26}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        m_flo_bypass)
    annotation (Placement(transformation(extent={{32,6},{52,26}})));
  MixingVolumes.MixingVolume vol(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=m_flow_nominal*30/995.58)
    annotation (Placement(transformation(extent={{66,-84},{86,-64}})));
equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-88,0},
          {-88,-60},{-74,-60}}, color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{94,0},{
          94,-34}},       color={0,127,255}));
  connect(Q_flow_input, heat2massFlow.u1)
    annotation (Line(points={{-108,80},{30,80},{30,72}},
                                                       color={0,0,127}));
  connect(changeSign.y, sink.m_flow_in)
    annotation (Line(points={{0,-47},{0,-52},{-18,-52}}, color={0,0,127}));
  connect(senT_supply.port_b, sink.ports[1])
    annotation (Line(points={{-54,-60},{-40,-60}}, color={0,127,255}));
  connect(deltaT.y, gain.u)
    annotation (Line(points={{-61,54},{-38,54}}, color={0,0,127}));
  connect(deltaT.y, Treturn.u1) annotation (Line(points={{-61,54},{-54,54},{-54,
          26},{-48,26}}, color={0,0,127}));
  connect(senT_supply.T, Treturn.u2) annotation (Line(points={{-64,-49},{-66,
          -49},{-66,14},{-48,14}}, color={0,0,127}));
  connect(gain.y, heat2massFlow.u2) annotation (Line(points={{-15,54},{-8,54},{-8,
          78},{18,78},{18,72}}, color={0,0,127}));
  connect(smoothMax.y, changeSign.u)
    annotation (Line(points={{0,-15},{0,-24}}, color={0,0,127}));
  connect(smoothMax.y, source.m_flow_in) annotation (Line(points={{0,-15},{0,-20},
          {20,-20},{20,-68},{30,-68}}, color={0,0,127}));
  connect(smoothMax.u1, heat2massFlow.y)
    annotation (Line(points={{6,8},{6,32},{24,32},{24,49}}, color={0,0,127}));
  connect(m_flo_min.y, smoothMax.u2)
    annotation (Line(points={{59,44},{-6,44},{-6,8}}, color={0,0,127}));
  connect(lessEqualThreshold.y, switch1.u2)
    annotation (Line(points={{53,16},{58,16}}, color={255,0,255}));
  connect(smoothMax.y, lessEqualThreshold.u) annotation (Line(points={{0,-15},{0,
          -20},{20,-20},{20,16},{30,16}}, color={0,0,127}));
  connect(senT_supply.T, switch1.u1) annotation (Line(points={{-64,-49},{-50,-49},
          {-50,4},{-14,4},{-14,30},{58,30},{58,24}}, color={0,0,127}));
  connect(Treturn.y, switch1.u3) annotation (Line(points={{-25,20},{16,20},{16,-6},
          {58,-6},{58,8}}, color={0,0,127}));
  connect(switch1.y, source.T_in) annotation (Line(points={{81,16},{86,16},{86,-32},
          {30,-32},{30,-64}}, color={0,0,127}));
  connect(source.ports[1], vol.ports[1]) annotation (Line(points={{52,-60},{62,
          -60},{62,-84},{74,-84}}, color={0,127,255}));
  connect(vol.ports[2], senT_return.port_a)
    annotation (Line(points={{78,-84},{94,-84},{94,-54}}, color={0,127,255}));
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
    Documentation(info="<html>
<p>A simple substation model using a fixed temperature difference and the actual supply temperature to calculate the mass flow rate drawn from the network. This model uses an open loop design to prescribe the required flow rate. </p>
</html>", revisions="<html>
<ul>
<li>
October 23, 2018, by Tobias Blacha:<br/>
First implementation.
</li>
</ul>
</html>"));
end VarTSupplyDpFixedTempDifferenceBypass;
