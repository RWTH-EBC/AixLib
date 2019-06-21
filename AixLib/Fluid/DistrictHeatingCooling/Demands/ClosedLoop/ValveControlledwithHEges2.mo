within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlledwithHEges2 "Substation with fixed dT and Heat Exchanger"

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
    displayUnit="K")
    "Design temperature difference for the substation's heat exchanger";

  parameter Modelica.SIunits.TemperatureDifference dT_building(
    displayUnit= "K")
    "Design temperature difference for the building";

  parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
    "Pressure difference at nominal flow rate"
    annotation(Dialog(group="Design parameter"));

  parameter Real deltaM=0.1
    "Fraction of nominal flow rate where flow transitions to laminar"
    annotation (Dialog(tab="Flow resistance"));
  parameter Modelica.SIunits.Time tau=30
    "Time constant at nominal flow (if energyDynamics <> SteadyState)"
    annotation (Dialog(tab="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
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
    annotation (Placement(transformation(extent={{-106,64},{-66,104}})));
  Sensors.TemperatureTwoPort senT_supply_pri(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tau=1) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
  Actuators.Valves.TwoWayPressureIndependent valve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    l2=1e-9,
    l=0.05,
    dpValve_nominal(displayUnit="bar") = 50000,
    use_inputFilter=false)
            "Control valve"
    annotation (Placement(transformation(extent={{-26,38},{-6,18}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    "Output signal of pressure difference"
    annotation (Placement(transformation(extent={{98,70},{118,90}})));

  Modelica.Blocks.Continuous.LimPID PID(
    yMax=1,
    k=1,
    Ti=0.5,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    yMin=0.01)
             annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-62,-8})));
  Sensors.TemperatureTwoPort senT_return_pri(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tau=1) annotation (Placement(transformation(extent={{64,18},{84,38}})));
  Sensors.TemperatureTwoPort senT_supply_sec(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tau=0) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-12,-6})));

  Sources.FixedBoundary bou(
     redeclare package Medium = Medium,
    use_p=true,
    use_T=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{8,-90},{-12,-70}})));

  Modelica.Blocks.Sources.TimeTable T_set(table=[0,273.15 + 26; 7.0e+06,273.15 +
        26; 7.0e+06,273.15 + 25; 1.2e+07,273.15 + 25; 1.2e+07,273.15 + 15; 2.2e+07,
        273.15 + 15; 2.2e+07,273.15 + 25; 2.7e+07,273.15 + 25; 2.7e+07,273.15 +
        26; 3.1536e+07,273.15 + 26])
    annotation (Placement(transformation(extent={{-90,-48},{-70,-28}})));
  Movers.FlowControlled_m_flow fan(redeclare package Medium = Medium,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    m_flow_nominal=2*m_flow_nominal)                                  annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-30,-50})));
  Modelica.Blocks.Sources.Constant const(k=Q_flow_nominal/dT_building/
        cp_default)
    annotation (Placement(transformation(extent={{-78,-84},{-58,-64}})));
  Sensors.TemperatureTwoPort senT_return_sec(
     m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tau=0)
    annotation (Placement(transformation(extent={{56,-18},{36,2}})));
  HeatExchangers.DynamicHX dynamicHX(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m_flow_nominal*2,
    dp1_nominal=0,
    dp2_nominal=0,
    Q_nom=Q_flow_nominal,
    T1_start=323.15,
    T2_start=288.15,
    dT_nom=15) annotation (Placement(transformation(extent={{8,12},{28,32}})));
  HeatExchangers.HeaterCooler_u hea(
    allowFlowReversal=false,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    Q_flow_nominal=-1,
    dp_nominal=0,
    T_start=288.15)
    annotation (Placement(transformation(extent={{28,-50},{48,-70}})));
equation

  dpOut = dp;

  connect(port_a, senT_supply_pri.port_a)
    annotation (Line(points={{-100,0},{-92,0},{-92,28},{-58,28}},
                                                color={0,127,255}));
  connect(senT_supply_pri.port_b, valve.port_a)
    annotation (Line(points={{-38,28},{-26,28}},
                                               color={0,127,255}));
  connect(senT_return_pri.port_b, port_b)
    annotation (Line(points={{84,28},{92,28},{92,0},{100,0}},
                                              color={0,127,255}));
  connect(PID.y, valve.y)
    annotation (Line(points={{-62,3},{-62,16},{-16,16}},
                                                   color={0,0,127}));
  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0},{-100,0}}, color={0,127,255}));
  connect(T_set.y, PID.u_s)
    annotation (Line(points={{-69,-38},{-62,-38},{-62,-20}}, color={0,0,127}));
  connect(senT_supply_sec.T, PID.u_m) annotation (Line(points={{-12,5},{-32,5},{
          -32,6},{-50,6},{-50,-8}}, color={0,0,127}));
  connect(senT_supply_sec.port_b, fan.port_a)
    annotation (Line(points={{-22,-6},{-30,-6},{-30,-40}}, color={0,127,255}));
  connect(const.y, fan.m_flow_in) annotation (Line(points={{-57,-74},{-50,-74},{
          -50,-50},{-42,-50}}, color={0,0,127}));
  connect(valve.port_b, dynamicHX.port_a1)
    annotation (Line(points={{-6,28},{8,28}}, color={0,127,255}));
  connect(dynamicHX.port_b1, senT_return_pri.port_a)
    annotation (Line(points={{28,28},{64,28}}, color={0,127,255}));
  connect(senT_return_sec.port_b, dynamicHX.port_a2)
    annotation (Line(points={{36,-8},{36,16},{28,16}}, color={0,127,255}));
  connect(dynamicHX.port_b2, senT_supply_sec.port_a) annotation (Line(points={{8,
          16},{4,16},{4,14},{-2,14},{-2,-6}}, color={0,127,255}));
  connect(bou.ports[1], fan.port_a) annotation (Line(points={{-12,-80},{-14,-80},
          {-14,-40},{-30,-40}}, color={0,127,255}));
  connect(fan.port_b, hea.port_a)
    annotation (Line(points={{-30,-60},{28,-60}}, color={0,127,255}));
  connect(hea.port_b, senT_return_sec.port_a) annotation (Line(points={{48,-60},
          {54,-60},{54,-8},{56,-8}}, color={0,127,255}));
  connect(Q_flow_input, hea.u) annotation (Line(points={{-86,84},{-44,84},{-44,94},
          {120,94},{120,-86},{26,-86},{26,-66},{26,-66}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}}),
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
          textString="PPum"),
        Polygon(
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
</html>"),
    Diagram(coordinateSystem(extent={{-120,-100},{120,100}})));
end ValveControlledwithHEges2;
