within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlledHXPIcontrol
  "Substation with HeatExchanger and PI controller for 3G Network"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow(start=0),
    final dp(start=0),
    final allowFlowReversal=false,
    final m_flow_nominal = Q_flow_nominal/cp_default/dT_Network);

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal(
    min=0) "Nominal heat flow rate added to medium (Q_flow_nominal > 0)";

  parameter Modelica.SIunits.TemperatureDifference dT_Network(
    displayUnit="K")
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
  Sensors.TemperatureTwoPort              senT_supply(redeclare package Medium
      = Medium, m_flow_nominal=m_flow_nominal) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-74,-70},{-54,-50}})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium
      = Medium, m_flow_nominal=m_flow_nominal) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{54,-70},{74,-50}})));
  Actuators.Valves.TwoWayPressureIndependent valve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05) "Control valve"
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Delays.DelayFirstOrder              vol1(
    redeclare package Medium = Medium,
    tau=60,
    m_flow_nominal=m_flow_nominal,
    nPorts=2)
             annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
                     annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={56,50})));
  Modelica.Blocks.Continuous.LimPID pControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.02,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3)      "Pressure controller" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-10})));
  Modelica.Blocks.Sources.Constant delT(k=dT_Network)
    "Temperature difference of substation" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,50})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.RealExpression Pressure_Drop(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{60,72},{94,88}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{100,70},{120,90}}),
        iconTransformation(extent={{100,70},{120,90}})));
equation

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-88,0},
          {-88,-60},{-74,-60}}, color={0,127,255}));
  connect(senT_supply.port_b, valve.port_a)
    annotation (Line(points={{-54,-60},{-10,-60}}, color={0,127,255}));
  connect(prescribedHeatFlow.port,vol1. heatPort)
    annotation (Line(points={{56,40},{56,-50},{40,-50}},color={191,0,0}));
  connect(senT_supply.T, add.u2)
    annotation (Line(points={{-64,-49},{-64,24},{-42,24}}, color={0,0,127}));
  connect(delT.y, add.u1) annotation (Line(points={{-59,50},{-50,50},{-50,36},{-42,
          36}}, color={0,0,127}));
  connect(add.y, pControl.u_s) annotation (Line(points={{-19,30},{2.22045e-15,30},
          {2.22045e-15,2}}, color={0,0,127}));
  connect(pControl.y, valve.y) annotation (Line(points={{-1.9984e-15,-21},{-1.9984e-15,
          -48},{0,-48}}, color={0,0,127}));
  connect(senT_return.T, pControl.u_m)
    annotation (Line(points={{64,-49},{64,-10},{12,-10}}, color={0,0,127}));
  connect(Q_flow_input, gain.u)
    annotation (Line(points={{-108,80},{-62,80}},color={0,0,127}));
  connect(gain.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-39,80},{56,80},{56,60}},color={0,0,127}));
  connect(Pressure_Drop.y,dpOut)
    annotation (Line(points={{95.7,80},{110,80}},  color={0,0,127}));
  connect(dpOut, dpOut)
    annotation (Line(points={{110,80},{110,80}}, color={0,0,127}));
  connect(valve.port_b, vol1.ports[1])
    annotation (Line(points={{10,-60},{32,-60}}, color={0,127,255}));
  connect(vol1.ports[2], senT_return.port_a)
    annotation (Line(points={{28,-60},{54,-60}}, color={0,127,255}));
  connect(senT_return.port_b, port_b) annotation (Line(points={{74,-60},{88,-60},
          {88,0},{100,0}}, color={0,127,255}));
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
<p>
A simple substation model using a fixed return temperature and the actual supply temperature
to calculate the mass flow rate drawn from the network. This model uses a linear control
valve to set the mass flow rate.

Please consider that this model is still in an early testing stage. The behavior is not 
verified. It seems that behavior may be problematic for low demands. In such cases, the
actual mass flow rate differs significantly from the set value.
</p>
</html>", revisions="<html>
<ul>
<li>
March 3, 2018, by Marcus Fuchs:<br/>
First implementation.
</li>
</ul>
</html>"));
end ValveControlledHXPIcontrol;
