within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlled "Substation with variable dT"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow(start=0),
    final dp(start=0),
    final allowFlowReversal=false,
    final m_flow_nominal = Q_flow_nominal/cp_default/dTDesign);

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal(
    min=0) "Nominal heat flow rate added to medium (Q_flow_nominal > 0)";

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

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

  AixLib.Fluid.HeatExchangers.HeaterCooler_u hex(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final from_dp=false,
    final linearizeFlowResistance=true,
    final show_T=false,
    final Q_flow_nominal=-1,
    final dp_nominal=dp_nominal,
    final deltaM=deltaM,
    final tau=tau,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final allowFlowReversal=true)
    "Component to remove heat from or add heat to fluid"
    annotation (Placement(transformation(extent={{34,-70},{54,-50}})));

public
  Modelica.Blocks.Interfaces.RealInput Q_flow_input "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Sensors.TemperatureTwoPort              senT_supply(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-74,-70},{-54,-50}})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Modelica.Blocks.Math.Add deltaT(k2=-1)
    "Differernce of flow and return line temperature in K" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-50,40})));
  Modelica.Blocks.Sources.Constant temperatureReturn(k=TReturn)
    "Temperature of return line in °C"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,46})));
  Modelica.Blocks.Math.Gain gain(k=cp_default)
    annotation (Placement(transformation(extent={{-32,30},{-12,50}})));
  Modelica.Blocks.Math.Division heat2massFlow
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-2})));
  Actuators.Valves.TwoWayPressureIndependent valve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05) "Control valve"
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Math.Gain gain1(k=1/m_flow_nominal)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-30})));
equation

  connect(Q_flow_input, hex.u) annotation (Line(points={{-108,80},{28,80},{28,-54},
          {32,-54}}, color={0,0,127}));
  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-88,0},
          {-88,-60},{-74,-60}}, color={0,127,255}));
  connect(hex.port_b, senT_return.port_a)
    annotation (Line(points={{54,-60},{60,-60}}, color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{90,0},{90,
          -60},{80,-60}}, color={0,127,255}));
  connect(temperatureReturn.y, deltaT.u2)
    annotation (Line(points={{-79,46},{-62,46}}, color={0,0,127}));
  connect(senT_supply.T, deltaT.u1)
    annotation (Line(points={{-64,-49},{-64,34},{-62,34}}, color={0,0,127}));
  connect(deltaT.y, gain.u)
    annotation (Line(points={{-39,40},{-34,40}}, color={0,0,127}));
  connect(gain.y, heat2massFlow.u2)
    annotation (Line(points={{-11,40},{-6,40},{-6,10}}, color={0,0,127}));
  connect(Q_flow_input, heat2massFlow.u1)
    annotation (Line(points={{-108,80},{6,80},{6,10}}, color={0,0,127}));
  connect(senT_supply.port_b, valve.port_a)
    annotation (Line(points={{-54,-60},{-10,-60}}, color={0,127,255}));
  connect(hex.port_a, valve.port_b)
    annotation (Line(points={{34,-60},{10,-60}}, color={0,127,255}));
  connect(heat2massFlow.y, gain1.u) annotation (Line(points={{-1.9984e-015,-13},
          {0,-13},{0,-18},{2.22045e-015,-18}}, color={0,0,127}));
  connect(valve.y, gain1.y) annotation (Line(points={{0,-48},{0,-41},{
          -1.9984e-015,-41}}, color={0,0,127}));
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
  the network. This model uses a linear control valve to set the mass
  flow rate. Please consider that this model is still in an early
  testing stage. The behavior is not verified. It seems that behavior
  may be problematic for low demands. In such cases, the actual mass
  flow rate differs significantly from the set value.
</p>
<ul>
  <li>March 3, 2018, by Marcus Fuchs:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end ValveControlled;
