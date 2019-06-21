within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlledwithHE_end1 "Substation with fixed dT and Heat Exchanger"

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = false);
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final dp(start=0),
    final allowFlowReversal=false,
    final m_flow_nominal = Q_flow_nominal/cp_default/dTDesign,
    final m_flow(start=0));

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
    annotation (Placement(transformation(extent={{-110,76},{-70,116}})));
  Sensors.TemperatureTwoPort senT_supply_pri(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tau=0) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-68,18},{-48,38}})));
  Actuators.Valves.TwoWayPressureIndependent valve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    l2=1e-9,
    l=0.05,
    dpValve_nominal(displayUnit="bar") = 50000,
    use_inputFilter=false)
            "Control valve"
    annotation (Placement(transformation(extent={{-36,38},{-16,18}})));
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
    tau=0) annotation (Placement(transformation(extent={{64,18},{84,38}})));
  Sensors.TemperatureTwoPort senT_supply_sec(
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tau=0) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-12,-8})));

  Modelica.Blocks.Sources.TimeTable T_set(table=[0,273.15 + 36; 7.0e+06,273.15
         + 36; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 + 25;
        2.2e+07,273.15 + 25; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 36; 3.1536e+07,273.15 + 36])
    annotation (Placement(transformation(extent={{-90,-48},{-70,-28}})));
  Modelica.Blocks.Math.Gain gain(k=1/cp_default)
    annotation (Placement(transformation(extent={{134,-110},{114,-90}})));
  Sensors.TemperatureTwoPort senT_return_sec(
     m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    tau=0)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={74,-10})));
  HeatExchangers.DynamicHX dynamicHX(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m_flow_nominal*2,
    dp1_nominal=0,
    dp2_nominal=0,
    Q_nom=(
    if senT_supply_pri.T-senT_supply_sec.T<5 then
      0
    else
      m_flow_nominal*cp_default*20),
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    dT_nom=20,
    T1_start=323.15,
    T2_start=288.15)
    annotation (Placement(transformation(extent={{8,12},{28,32}})));
  Sources.FixedBoundary bou1( redeclare package Medium = Medium,use_T=false, nPorts=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,-34})));
  Sources.MassFlowSource_T boundary(
    nPorts=1,
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={6,-44})));
  Modelica.Blocks.Sources.Constant m_flow_building(k=Q_flow_nominal/cp_default/
        dT_building)
    annotation (Placement(transformation(extent={{112,-94},{92,-74}})));
  Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,-86})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{82,-86},{62,-106}})));
  Modelica.Blocks.Sources.Constant T_return_min(k=273.15 + 20)
    annotation (Placement(transformation(extent={{52,-96},{32,-76}})));
  Modelica.Blocks.Math.Max max(y(start= 273.15+20)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={8,-76})));
  Modelica.Blocks.Math.Gain gain1(k=cp_default*m_flow_nominal)
    annotation (Placement(transformation(extent={{-26,56},{-6,76}})));
  Modelica.Blocks.Math.Add dT_pri(k2=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-52,56})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{8,46},{28,66}})));
  Modelica.Blocks.Interfaces.RealOutput HeatMeter
    annotation (Placement(transformation(extent={{100,46},{120,66}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=10)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={120,-52})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{70,-42},{50,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{106,-54},{86,-34}})));
equation

  dpOut = dp;

  connect(port_a, senT_supply_pri.port_a)
    annotation (Line(points={{-100,0},{-92,0},{-92,28},{-68,28}},
                                                color={0,127,255}));
  connect(senT_supply_pri.port_b, valve.port_a)
    annotation (Line(points={{-48,28},{-36,28}},
                                               color={0,127,255}));
  connect(senT_return_pri.port_b, port_b)
    annotation (Line(points={{84,28},{92,28},{92,0},{100,0}},
                                              color={0,127,255}));
  connect(PID.y, valve.y)
    annotation (Line(points={{-62,3},{-62,10},{-44,10},{-44,16},{-26,16}},
                                                   color={0,0,127}));
  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0},{-100,0}}, color={0,127,255}));
  connect(T_set.y, PID.u_s)
    annotation (Line(points={{-69,-38},{-62,-38},{-62,-20}}, color={0,0,127}));
  connect(senT_supply_sec.T, PID.u_m) annotation (Line(points={{-23,-8},{-32,-8},
          {-32,6},{-50,6},{-50,-8}},color={0,0,127}));
  connect(Q_flow_input, gain.u) annotation (Line(points={{-90,96},{136,96},{136,
          -100}},              color={0,0,127}));
  connect(valve.port_b, dynamicHX.port_a1)
    annotation (Line(points={{-16,28},{8,28}},color={0,127,255}));
  connect(dynamicHX.port_b1, senT_return_pri.port_a)
    annotation (Line(points={{28,28},{64,28}}, color={0,127,255}));
  connect(senT_return_sec.port_b, dynamicHX.port_a2)
    annotation (Line(points={{74,3.55271e-15},{74,16},{28,16}},
                                                       color={0,127,255}));
  connect(dynamicHX.port_b2, senT_supply_sec.port_a) annotation (Line(points={{8,16},{
          4,16},{4,14},{-12,14},{-12,2}},     color={0,127,255}));
  connect(senT_supply_sec.port_b, bou1.ports[1]) annotation (Line(points={{-12,-18},
          {-12,-24}},                    color={0,127,255}));
  connect(boundary.ports[1], senT_return_sec.port_a) annotation (Line(points={{6,-34},
          {74,-34},{74,-20}},           color={0,127,255}));
  connect(senT_supply_sec.T, add.u1) annotation (Line(points={{-23,-8},{-34,-8},
          {-34,-80},{-32,-80}},
                          color={0,0,127}));
  connect(gain.y, division.u1) annotation (Line(points={{113,-100},{100,-100},{100,
          -102},{84,-102}},
                     color={0,0,127}));
  connect(m_flow_building.y, division.u2) annotation (Line(points={{91,-84},{84,
          -84},{84,-90}},          color={0,0,127}));
  connect(add.u2, division.y) annotation (Line(points={{-32,-92},{-36,-92},{-36,
          -98},{61,-98},{61,-96}}, color={0,0,127}));
  connect(add.y, max.u1)
    annotation (Line(points={{-9,-86},{-4,-86},{-4,-88},{2,-88}},
                                                color={0,0,127}));
  connect(T_return_min.y, max.u2)
    annotation (Line(points={{31,-86},{22,-86},{22,-88},{14,-88}},
                                                 color={0,0,127}));
  connect(senT_supply_pri.T, dT_pri.u1)
    annotation (Line(points={{-58,39},{-58,44}}, color={0,0,127}));
  connect(senT_return_pri.T, dT_pri.u2) annotation (Line(points={{74,39},{20,39},
          {20,38},{-46,38},{-46,44}}, color={0,0,127}));
  connect(dT_pri.y, gain1.u) annotation (Line(points={{-52,67},{-42,67},{-42,66},
          {-28,66}}, color={0,0,127}));
  connect(gain1.y, product.u1)
    annotation (Line(points={{-5,66},{4,66},{4,62},{6,62}}, color={0,0,127}));
  connect(valve.y_actual, product.u2)
    annotation (Line(points={{-21,21},{0,21},{0,50},{6,50}}, color={0,0,127}));
  connect(product.y, HeatMeter) annotation (Line(points={{29,56},{110,56}},
                     color={0,0,127}));
  connect(Q_flow_input, greaterThreshold.u) annotation (Line(points={{-90,96},{136,
          96},{136,-52},{132,-52}}, color={0,0,127}));
  connect(max.y, boundary.T_in)
    annotation (Line(points={{8,-65},{10,-65},{10,-56}}, color={0,0,127}));
  connect(switch1.u2, greaterThreshold.y)
    annotation (Line(points={{72,-52},{109,-52}}, color={255,0,255}));
  connect(switch1.u1, m_flow_building.y) annotation (Line(points={{72,-60},{82,-60},
          {82,-84},{91,-84}}, color={0,0,127}));
  connect(realExpression.y, switch1.u3)
    annotation (Line(points={{85,-44},{72,-44}}, color={0,0,127}));
  connect(switch1.y, boundary.m_flow_in) annotation (Line(points={{49,-52},{36,-52},
          {36,-64},{14,-64},{14,-56}}, color={0,0,127}));
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
end ValveControlledwithHE_end1;
