within AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop;
model VarTSupplyDpBypass
  "Substation with variable dT for fixed return temperature"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow(start=0),
    final dp(start=0),
    final allowFlowReversal=false,
    final m_flow_nominal = Q_flow_nominal/cp_default/dTDesign);

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal
    "Nominal heat flow rate added to medium";

  parameter Modelica.SIunits.TemperatureDifference dTDesign(
    displayUnit="K")
    "Design temperature difference for the substation's heat exchanger";

  parameter Modelica.SIunits.Temperature TReturn
    "Fixed return temperature";

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
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Modelica.Blocks.Math.Add deltaT(k1=+1, k2=-1)
    "Differernce of flow and return line temperature in K" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,40})));
  Modelica.Blocks.Sources.Constant temRet(k=TReturn)
    "Temperature of return line in °C" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,46})));
  Modelica.Blocks.Math.Gain gain(k=cp_default)
    annotation (Placement(transformation(extent={{-26,54},{-6,74}})));
  Modelica.Blocks.Math.Division hea2MasFlo annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={4,46})));
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
    T=TReturn,
    use_T_in=true)
               "Source sending prescribed flow back to the network" annotation (
     Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={42,-60})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    "Output signal of pressure difference"
    annotation (Placement(transformation(extent={{98,70},{118,90}})));
  Modelica.Blocks.Sources.Constant mindeltaT(k=20)
    "Temperature of return line in °C" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-114,-28})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-50,-4},{-30,16}})));
  Modelica.Blocks.Math.Min min annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,12})));
  Modelica.Blocks.Sources.Constant temRet_nominal(k=TReturn)
    "Temperature of return line in °C" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={24,72})));
  Modelica.Blocks.Math.Add deltaT1(k1=+1, k2=-1)
    "Differernce of flow and return line temperature in K" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={36,22})));
  Modelica.Blocks.Sources.RealExpression m_flo_min(y=m_flo_bypass)
    annotation (Placement(transformation(extent={{100,52},{80,72}})));
  Utilities.Math.SmoothMax smoothMax(deltaX=0.001) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-4})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        m_flo_bypass)
    annotation (Placement(transformation(extent={{24,-30},{44,-10}})));
  Utilities.Logical.SmoothSwitch switch1
    annotation (Placement(transformation(extent={{96,22},{116,42}})));
equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-88,0},
          {-88,-60},{-74,-60}}, color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{90,0},{90,
          -60},{80,-60}}, color={0,127,255}));
  connect(temRet.y, deltaT.u2)
    annotation (Line(points={{-79,46},{-62,46}}, color={0,0,127}));
  connect(gain.y, hea2MasFlo.u2)
    annotation (Line(points={{-5,64},{-2,64},{-2,58}}, color={0,0,127}));
  connect(Q_flow_input, hea2MasFlo.u1)
    annotation (Line(points={{-108,80},{10,80},{10,58}}, color={0,0,127}));
  connect(source.ports[1], senT_return.port_a)
    annotation (Line(points={{52,-60},{60,-60}}, color={0,127,255}));
  connect(changeSign.y, sink.m_flow_in)
    annotation (Line(points={{0,-47},{0,-52},{-18,-52}}, color={0,0,127}));
  connect(senT_supply.port_b, sink.ports[1])
    annotation (Line(points={{-54,-60},{-40,-60}}, color={0,127,255}));
  connect(senT_supply.T, deltaT.u1) annotation (Line(points={{-64,-49},{-64,-8},
          {-64,34},{-62,34}}, color={0,0,127}));
  connect(max.y, gain.u)
    annotation (Line(points={{-29,6},{-28,6},{-28,64}}, color={0,0,127}));
  connect(deltaT.y, max.u1) annotation (Line(points={{-39,40},{-46,40},{-46,12},
          {-52,12}}, color={0,0,127}));
  connect(mindeltaT.y, max.u2) annotation (Line(points={{-103,-28},{-78,-28},{
          -78,0},{-52,0}}, color={0,0,127}));
  connect(temRet_nominal.y, min.u1)
    annotation (Line(points={{35,72},{68,72},{68,18}}, color={0,0,127}));
  connect(deltaT1.y, min.u2)
    annotation (Line(points={{47,22},{68,22},{68,6}},  color={0,0,127}));
  connect(senT_supply.T, deltaT1.u1)
    annotation (Line(points={{-64,-49},{-64,16},{24,16}}, color={0,0,127}));
  connect(mindeltaT.y, deltaT1.u2) annotation (Line(points={{-103,-28},{-20,-28},
          {-20,28},{24,28}}, color={0,0,127}));
  connect(smoothMax.y, changeSign.u)
    annotation (Line(points={{0,-15},{0,-24}}, color={0,0,127}));
  connect(hea2MasFlo.y, smoothMax.u2)
    annotation (Line(points={{4,35},{4,32},{-6,32},{-6,8}}, color={0,0,127}));
  connect(m_flo_min.y, smoothMax.u1) annotation (Line(points={{79,62},{50,62},{
          50,34},{6,34},{6,8}}, color={0,0,127}));
  connect(smoothMax.y, lessEqualThreshold.u) annotation (Line(points={{0,-15},{
          2,-15},{2,-20},{22,-20}}, color={0,0,127}));
  connect(lessEqualThreshold.y, switch1.u2) annotation (Line(points={{45,-20},{
          60,-20},{60,32},{94,32}}, color={255,0,255}));
  connect(min.y, switch1.u3) annotation (Line(points={{91,12},{92,12},{92,24},{
          94,24}}, color={0,0,127}));
  connect(senT_supply.T, switch1.u1) annotation (Line(points={{-64,-49},{16,-49},
          {16,40},{94,40}}, color={0,0,127}));
  connect(switch1.y, source.T_in) annotation (Line(points={{117,32},{124,32},{
          124,-64},{30,-64}},
                          color={0,0,127}));
  connect(changeSign.y, source.m_flow_in)
    annotation (Line(points={{0,-47},{0,-68},{30,-68}}, color={0,0,127}));
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
  required flow rate.
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
end VarTSupplyDpBypass;
