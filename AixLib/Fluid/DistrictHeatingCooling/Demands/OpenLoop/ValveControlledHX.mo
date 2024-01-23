within AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop;
model ValveControlledHX "Substation with variable dT and Heat Exchanger"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow(start=0),
    final dp(start=0),
    final allowFlowReversal=false,
    final m_flow_nominal = Q_flow_nominal/cp_default/dTDesign);

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal(
    min=0) "Nominal heat flow rate added to medium (Q_flow_nominal > 0)";

  parameter Modelica.SIunits.Temperature TReturn
    "Fixed return temperature";

  parameter Modelica.SIunits.TemperatureDifference dTDesign(
    displayUnit="K")=60
    "Design temperature difference for the substation's heat exchanger";

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
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Actuators.Valves.TwoWayPressureIndependent valve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    l2=1e-9,
    l=0.05,
    dpValve_nominal(displayUnit="bar") = 50000,
    use_inputFilter=false)
            "Control valve"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    "Output signal of pressure difference"
    annotation (Placement(transformation(extent={{98,70},{118,90}})));

  Modelica.Blocks.Math.Gain Q_flow_max(k=cp_default, u=(senT_supply.T - TReturn)
        *port_a.m_flow) "Available Heat flow"
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  Modelica.Blocks.Math.Min min
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Math.Division rel_Q_flow_cur
    annotation (Placement(transformation(extent={{-40,64},{-20,84}})));
  Modelica.Blocks.Math.Feedback feedback(u2=1 - rel_Q_flow_cur.y)
                                         annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={-30,50})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-50,34})));
  Sources.Boundary_pT                   sink(
    redeclare package Medium = Medium,
    nPorts=1,
    use_p_in=true,
    p_in=port_b.p)
              "Sink extracting prescribed flow from the network"
                                              annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,0})));
  Sources.MassFlowSource_T source(
    redeclare package Medium = Medium,
    nPorts=1,
    use_T_in=true,
    use_m_flow_in=true,
    T_in=senT_supply.T - min.y/(cp_default*port_a.m_flow),
    m_flow_in=port_a.m_flow)
               "Source sending prescribed flow back to the network" annotation (
     Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={38,0})));
equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-90,0}},
                                color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{80,0}},
                          color={0,127,255}));
  connect(senT_supply.port_b, valve.port_a)
    annotation (Line(points={{-70,0},{-40,0}},     color={0,127,255}));
  connect(Q_flow_max.y, min.u2) annotation (Line(points={{-69,-40},{-62,-40},{
          -62,-76},{-42,-76}},
                           color={0,0,127}));
  connect(Q_flow_input, min.u1) annotation (Line(points={{-108,80},{-66,80},{
          -66,-64},{-42,-64}},          color={0,0,127}));
  connect(Q_flow_max.y, rel_Q_flow_cur.u2) annotation (Line(points={{-69,-40},{
          -62,-40},{-62,68},{-42,68}},
                                     color={0,0,127}));
  connect(valve.y_actual, feedback.u1) annotation (Line(points={{-25,7},{-25,20},
          {-10,20},{-10,50},{-22,50}}, color={0,0,127}));
  connect(feedback.y, limiter.u)
    annotation (Line(points={{-39,50},{-50,50},{-50,46}}, color={0,0,127}));
  connect(limiter.y, valve.y)
    annotation (Line(points={{-50,23},{-50,20},{-30,20},{-30,12}},
                                                 color={0,0,127}));
  connect(rel_Q_flow_cur.u1, min.u1) annotation (Line(points={{-42,80},{-66,80},
          {-66,-64},{-42,-64}}, color={0,0,127}));
  connect(valve.port_b, sink.ports[1])
    annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
  connect(source.ports[1], senT_return.port_a)
    annotation (Line(points={{48,0},{60,0}}, color={0,127,255}));
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
</html>", revisions="<html>
<ul>
  <li>March 3, 2018, by Marcus Fuchs:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end ValveControlledHX;
