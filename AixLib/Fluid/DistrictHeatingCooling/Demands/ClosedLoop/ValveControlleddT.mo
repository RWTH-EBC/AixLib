within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlleddT "Substation with fixed dT and Heat Exchanger"

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = false);
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

  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
protected
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

public
  Modelica.Blocks.Interfaces.RealInput Q_flow_input "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-128,68},{-88,108}})));
  Sensors.TemperatureTwoPort              senT_supply(
                m_flow_nominal=m_flow_nominal, redeclare package Medium =
        Medium,
    tau=1)                                     "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
  Actuators.Valves.TwoWayPressureIndependent valve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    l2=1e-9,
    l=0.05,
    dpValve_nominal(displayUnit="bar") = 50000,
    use_inputFilter=false)
            "Control valve"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    "Output signal of pressure difference"
    annotation (Placement(transformation(extent={{98,70},{118,90}})));

  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0.1,
    k=1)      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-24,30})));
  Modelica.Blocks.Sources.Constant deltaT(k=dTDesign)
    annotation (Placement(transformation(extent={{-100,58},{-80,78}})));
  Delays.DelayFirstOrder del(
    nPorts=2,
    redeclare package Medium = Medium,
    tau=60,
    m_flow_nominal=m_flow_nominal) annotation (Placement(transformation(extent={{8,0},{28,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-38,78},{-18,98}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{-78,78},{-58,98}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-62,46},{-42,66}})));
  Sensors.TemperatureTwoPort senTem( m_flow_nominal=m_flow_nominal, redeclare
      package                                                                         Medium =
        Medium,
    tau=1) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-84,0}}, color={0,127,255}));
  connect(senT_supply.port_b, valve.port_a) annotation (Line(points={{-64,0},{-60,0}}, color={0,127,255}));
  connect(valve.port_b, del.ports[1])
    annotation (Line(points={{-40,0},{16,0}},                          color={0,127,255}));
  connect(valve.y, PID.y) annotation (Line(points={{-50,12},{-50,16},{-24,16},{
          -24,19}},                                                                      color={0,0,127}));
  connect(prescribedHeatFlow.port, del.heatPort)
    annotation (Line(points={{-18,88},{-10,88},{-10,10},{8,10}}, color={191,0,0}));
  connect(Q_flow_input, gain.u) annotation (Line(points={{-108,88},{-80,88}}, color={0,0,127}));
  connect(gain.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-57,88},{-38,88}}, color={0,0,127}));
  connect(deltaT.y, add.u1) annotation (Line(points={{-79,68},{-72,68},{-72,62},{-64,62}}, color={0,0,127}));
  connect(senTem.port_b, port_b) annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
  connect(del.ports[2], senTem.port_a) annotation (Line(points={{20,0},{50,0}}, color={0,127,255}));
  connect(senTem.T, add.u2) annotation (Line(points={{60,11},{62,11},{62,50},{-64,50}}, color={0,0,127}));
  connect(senT_supply.T, PID.u_s)
    annotation (Line(points={{-74,11},{-74,42},{-24,42}}, color={0,0,127}));
  connect(add.y, PID.u_m) annotation (Line(points={{-41,56},{-42,56},{-42,30},{
          -36,30}}, color={0,0,127}));
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
end ValveControlleddT;
