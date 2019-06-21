within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlled "Substation with fixed dT and Heat Exchanger"


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

  parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=20000
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
    p=Medium.p_default,
    T=Medium.T_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";

protected
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";
public
  Modelica.Blocks.Interfaces.RealInput Q_flow_input "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Sensors.TemperatureTwoPort              senT_supply(
                m_flow_nominal=m_flow_nominal, redeclare package Medium =
        Medium)                                "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    "Output signal of pressure difference"
    annotation (Placement(transformation(extent={{96,78},{116,98}})));

  Modelica.Blocks.Sources.Constant mflow_nominal(k=Q_flow_nominal/cp_default/
        dTDesign)
    annotation (Placement(transformation(extent={{-98,50},{-78,70}})));

  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0.1)
    annotation (Placement(transformation(extent={{-64,28},{-44,48}})));
  Movers.SpeedControlled_y fan(
    redeclare package Medium = Medium,
    per(pressure(V_flow={0, m_flow_nominal/1000}, dp={2*dp_nominal,dp_nominal,0})),
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{96,48},{116,68}})));
  Sensors.MassFlowRate senMasFlo
    annotation (Placement(transformation(extent={{24,-10},{44,10}})));
  HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=300000,
    Q_flow_nominal=1)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-90,0}},
                                color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{80,0}},
                          color={0,127,255}));
  connect(mflow_nominal.y, PID.u_s) annotation (Line(points={{-77,60},{-74,60},{
          -74,38},{-66,38}}, color={0,0,127}));
  connect(fan.P, P)
    annotation (Line(points={{-19,9},{106,9},{106,58}}, color={0,0,127}));
  connect(PID.y, fan.y)
    annotation (Line(points={{-43,38},{-30,38},{-30,12}}, color={0,0,127}));
  connect(senMasFlo.m_flow, PID.u_m)
    annotation (Line(points={{34,11},{34,26},{-54,26}},
                                                 color={0,0,127}));
  connect(senT_supply.port_b, fan.port_a)
    annotation (Line(points={{-70,0},{-40,0}}, color={0,127,255}));
  connect(senMasFlo.port_b, senT_return.port_a)
    annotation (Line(points={{44,0},{60,0}}, color={0,127,255}));
  connect(fan.port_b, hea.port_a)
    annotation (Line(points={{-20,0},{-8,0}}, color={0,127,255}));
  connect(hea.port_b, senMasFlo.port_a)
    annotation (Line(points={{12,0},{24,0}}, color={0,127,255}));
  connect(Q_flow_input, hea.u)
    annotation (Line(points={{-108,80},{-10,80},{-10,6}}, color={0,0,127}));
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
end PumpControlled;
