within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlledwithHE2
  "Substation with fixed dT and Heat Exchanger"

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
    annotation (Placement(transformation(extent={{-106,68},{-66,108}})));
  Sensors.TemperatureTwoPort senT_supply_pri(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tau=1) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-86,18},{-66,38}})));
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
    annotation (Placement(transformation(extent={{80,64},{100,84}})));

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
    tau=1) annotation (Placement(transformation(extent={{40,18},{60,38}})));
  Sensors.TemperatureTwoPort senT_supply_sec(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tau=0) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-16,-6})));
  Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    T=288.15) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={32,-40})));
  Modelica.Blocks.Sources.Constant m_flow_building(k=Q_flow_nominal/cp_default/
        dT_building)
    annotation (Placement(transformation(extent={{108,-52},{88,-32}})));

  Sources.FixedBoundary bou(
     redeclare package Medium = Medium,
    use_p=true,
    nPorts=1,
    use_T=false)
    annotation (Placement(transformation(extent={{-54,-46},{-34,-26}})));

  Modelica.Blocks.Sources.TimeTable T_set(table=[0,273.15 + 36; 7.0e+06,273.15 +
        36; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 + 15; 2.2e+07,
        273.15 + 15; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,273.15 +
        36; 3.1536e+07,273.15 + 36], timeScale=1)
    annotation (Placement(transformation(extent={{-90,-48},{-70,-28}})));
  HeatExchangers.DynamicHX1 dynamicHX(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m2_flow_nominal=2*m_flow_nominal,
    nNodes=2,
    dT_nom=14.5,
    allowFlowReversal2=false,
    allowFlowReversal1=true,
    Q_nom=m_flow_nominal*cp_default*20,
    dp1_nominal=5000,
    dp2_nominal=1000,
    T1_start=323.15,
    T2_start=288.15)
    annotation (Placement(transformation(extent={{6,-2},{26,18}})));

  Modelica.Blocks.Math.Add delta_T(k2=-1)
    annotation (Placement(transformation(extent={{-58,50},{-38,70}})));
  Modelica.Blocks.Math.Gain gain(k=cp_default*m_flow_nominal)
    annotation (Placement(transformation(extent={{-28,50},{-8,70}})));
  Modelica.Blocks.Math.Product Q_flow
    annotation (Placement(transformation(extent={{12,46},{32,66}})));
  Modelica.Blocks.Sources.Constant T_return_sec(k=273.15 + 20)
    annotation (Placement(transformation(extent={{54,-88},{34,-68}})));
  Modelica.Blocks.Math.Gain gain1(k=1/cp_default) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={120,-86})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={10,-58})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{76,-88},{56,-108}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
                                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={6,-86})));
  Sensors.TemperatureTwoPort senT_return_sec(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    tau=0)
    annotation (Placement(transformation(extent={{46,-14},{26,6}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=10)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={52,62})));
equation

  dpOut = dp;

  connect(port_a, senT_supply_pri.port_a)
    annotation (Line(points={{-100,0},{-92,0},{-92,28},{-86,28}},
                                                color={0,127,255}));
  connect(senT_supply_pri.port_b, valve.port_a)
    annotation (Line(points={{-66,28},{-26,28}},
                                               color={0,127,255}));
  connect(senT_return_pri.port_b, port_b)
    annotation (Line(points={{60,28},{92,28},{92,0},{100,0}},
                                              color={0,127,255}));
  connect(PID.y, valve.y)
    annotation (Line(points={{-62,3},{-62,16},{-16,16}},
                                                   color={0,0,127}));
  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0},{-100,0}}, color={0,127,255}));
  connect(T_set.y, PID.u_s)
    annotation (Line(points={{-69,-38},{-62,-38},{-62,-20}}, color={0,0,127}));
  connect(senT_supply_sec.T, PID.u_m) annotation (Line(points={{-16,5},{-32,5},{
          -32,6},{-50,6},{-50,-8}}, color={0,0,127}));
  connect(bou.ports[1], senT_supply_sec.port_b)
    annotation (Line(points={{-34,-36},{-34,-6},{-26,-6}}, color={0,127,255}));
  connect(valve.port_b, dynamicHX.port_a1) annotation (Line(points={{-6,28},{0,28},
          {0,14},{6,14}}, color={0,127,255}));
  connect(dynamicHX.port_b1, senT_return_pri.port_a)
    annotation (Line(points={{26,14},{26,28},{40,28}}, color={0,127,255}));
  connect(dynamicHX.port_b2, senT_supply_sec.port_a)
    annotation (Line(points={{6,2},{6,-6},{-6,-6}}, color={0,127,255}));
  connect(senT_supply_pri.T, delta_T.u1) annotation (Line(points={{-76,39},{-74,
          39},{-74,68},{-60,68},{-60,66}}, color={0,0,127}));
  connect(senT_return_pri.T, delta_T.u2) annotation (Line(points={{50,39},{-6,39},
          {-6,44},{-60,44},{-60,54}}, color={0,0,127}));
  connect(delta_T.y, gain.u)
    annotation (Line(points={{-37,60},{-30,60}}, color={0,0,127}));
  connect(gain.y, Q_flow.u1)
    annotation (Line(points={{-7,60},{4,60},{4,62},{10,62}}, color={0,0,127}));
  connect(valve.y_actual, Q_flow.u2) annotation (Line(points={{-11,21},{0,21},{0,
          50},{10,50}}, color={0,0,127}));
  connect(division.y, add1.u2)
    annotation (Line(points={{55,-98},{12,-98}},          color={0,0,127}));
  connect(senT_return_sec.port_b, dynamicHX.port_a2)
    annotation (Line(points={{26,-4},{26,2}}, color={0,127,255}));
  connect(boundary.ports[1], senT_return_sec.port_a) annotation (Line(points={{
          32,-30},{32,-22},{54,-22},{54,-4},{46,-4}}, color={0,127,255}));
  connect(m_flow_building.y, boundary.m_flow_in) annotation (Line(points={{87,-42},
          {50,-42},{50,-56},{40,-56},{40,-52}},      color={0,0,127}));
  connect(m_flow_building.y, division.u2)
    annotation (Line(points={{87,-42},{78,-42},{78,-92}}, color={0,0,127}));
  connect(Q_flow_input, gain1.u)
    annotation (Line(points={{-86,88},{120,88},{120,-74}}, color={0,0,127}));
  connect(senT_supply_sec.T, add1.u1) annotation (Line(points={{-16,5},{-18,5},{
          -18,-96},{0,-96},{0,-98},{-8.88178e-16,-98}}, color={0,0,127}));
  connect(gain1.y, division.u1) annotation (Line(points={{120,-97},{100,-97},{100,
          -104},{78,-104}}, color={0,0,127}));
  connect(add1.y, max.u2)
    annotation (Line(points={{6,-75},{6,-70},{4,-70}}, color={0,0,127}));
  connect(max.y, boundary.T_in) annotation (Line(points={{10,-47},{24,-47},{24,-52},
          {36,-52}}, color={0,0,127}));
  connect(T_return_sec.y, max.u1) annotation (Line(points={{33,-78},{24,-78},{24,
          -70},{16,-70}}, color={0,0,127}));
  connect(greaterThreshold.y, dynamicHX.u) annotation (Line(points={{52,51},{38,
          51},{38,42},{20.4,42},{20.4,17.2}}, color={255,0,255}));
  connect(Q_flow_input, greaterThreshold.u)
    annotation (Line(points={{-86,88},{52,88},{52,74}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,
            100}}), graphics={
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
    Diagram(coordinateSystem(extent={{-120,-100},{120,100}})),
    experiment);
end ValveControlledwithHE2;
