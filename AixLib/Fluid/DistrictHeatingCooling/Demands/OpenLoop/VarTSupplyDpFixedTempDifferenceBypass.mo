within AixLib.Fluid.DistrictHeatingCooling.Demands.OpenLoop;
model VarTSupplyDpFixedTempDifferenceBypass
  "Substation with variable supply temperature and fixed dT"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow(start=0),
    final dp(start=0),
    final allowFlowReversal=false,
    final m_flow_nominal = Q_flow_nominal/cp_default/dTDesign);

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal
    "Nominal heat flow rate added to medium";

  parameter Modelica.Units.SI.TemperatureDifference dTDesign(displayUnit="K")
    "Constant temperature difference for the substation's heat exchanger";

  parameter Modelica.Units.SI.Pressure dp_nominal(displayUnit="Pa") = 30000
    "Pressure difference at nominal flow rate"
    annotation (Dialog(group="Design parameter"));

  parameter Real deltaM=0.1
    "Fraction of nominal flow rate where flow transitions to laminar"
    annotation (Dialog(tab="Flow resistance"));
  parameter Modelica.Units.SI.Time tau=30
    "Time constant at nominal flow (if energyDynamics <> SteadyState)"
    annotation (Dialog(tab="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics"));

  parameter Modelica.Units.SI.MassFlowRate m_flo_bypass
    "Minimum bypass flow through substation";

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

public
  Modelica.Blocks.Interfaces.RealInput Q_flow_input "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-132,120},{-92,160}}),
        iconTransformation(extent={{-132,120},{-92,160}})));
  Sensors.TemperatureTwoPort              senT_supply(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,0})));
  Modelica.Blocks.Math.Gain gain(k=cp_default)
    annotation (Placement(transformation(extent={{-40,104},{-20,124}})));
  Modelica.Blocks.Math.Division hea2MasFlo annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,120})));
  Sources.MassFlowSource_T              sink(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1) "Sink extracting prescribed flow from the network"
                                              annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-34,0})));
  Modelica.Blocks.Math.Gain changeSign(k=-1)
    "Changes sign of prescribed flow for extraction from network" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-4,24})));
  Sources.MassFlowSource_T source(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)  "Source sending prescribed flow back to the network" annotation (
     Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={38,0})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    "Output signal of pressure difference"
    annotation (Placement(transformation(extent={{94,130},{114,150}}),
        iconTransformation(extent={{94,130},{114,150}})));
  Modelica.Blocks.Sources.Constant deltaT(k=dTDesign)
    "Fixed temperature difference between supply and return" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-76,114})));
  Modelica.Blocks.Math.Add temRet(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Utilities.Math.SmoothMax smoothMax(deltaX=0.001) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-4,56})));
  Modelica.Blocks.Sources.RealExpression m_flo_min(y=m_flo_bypass)
    annotation (Placement(transformation(extent={{76,94},{56,114}})));
  Utilities.Logical.SmoothSwitch switch1
    annotation (Placement(transformation(extent={{56,66},{76,86}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        m_flo_bypass)
    annotation (Placement(transformation(extent={{28,66},{48,86}})));
  MixingVolumes.MixingVolume vol(
    energyDynamics=energyDynamics,
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    V=m_flow_nominal*30/995.58)
    annotation (Placement(transformation(extent={{50,0},{70,20}})));
equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-78,0}},
                                color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{90,0}},
                          color={0,127,255}));
  connect(Q_flow_input, hea2MasFlo.u1)
    annotation (Line(points={{-112,140},{26,140},{26,132}}, color={0,0,127}));
  connect(changeSign.y, sink.m_flow_in)
    annotation (Line(points={{-4,13},{-4,8},{-22,8}},    color={0,0,127}));
  connect(senT_supply.port_b, sink.ports[1])
    annotation (Line(points={{-58,0},{-44,0}},     color={0,127,255}));
  connect(deltaT.y, gain.u)
    annotation (Line(points={{-65,114},{-42,114}},
                                                 color={0,0,127}));
  connect(deltaT.y, temRet.u1) annotation (Line(points={{-65,114},{-58,114},{-58,
          86},{-52,86}}, color={0,0,127}));
  connect(senT_supply.T, temRet.u2) annotation (Line(points={{-68,11},{-70,11},
          {-70,74},{-52,74}}, color={0,0,127}));
  connect(gain.y, hea2MasFlo.u2) annotation (Line(points={{-19,114},{-12,114},{
          -12,138},{14,138},{14,132}}, color={0,0,127}));
  connect(smoothMax.y, changeSign.u)
    annotation (Line(points={{-4,45},{-4,36}}, color={0,0,127}));
  connect(smoothMax.y, source.m_flow_in) annotation (Line(points={{-4,45},{-4,
          40},{16,40},{16,-8},{26,-8}},color={0,0,127}));
  connect(smoothMax.u1, hea2MasFlo.y) annotation (Line(points={{2,68},{2,92},{
          20,92},{20,109}}, color={0,0,127}));
  connect(m_flo_min.y, smoothMax.u2)
    annotation (Line(points={{55,104},{-10,104},{-10,68}},
                                                      color={0,0,127}));
  connect(lessEqualThreshold.y, switch1.u2)
    annotation (Line(points={{49,76},{54,76}}, color={255,0,255}));
  connect(smoothMax.y, lessEqualThreshold.u) annotation (Line(points={{-4,45},{
          -4,40},{16,40},{16,76},{26,76}},color={0,0,127}));
  connect(senT_supply.T, switch1.u1) annotation (Line(points={{-68,11},{-54,11},
          {-54,64},{-18,64},{-18,90},{54,90},{54,84}},
                                                     color={0,0,127}));
  connect(temRet.y, switch1.u3) annotation (Line(points={{-29,80},{12,80},{12,
          54},{54,54},{54,68}}, color={0,0,127}));
  connect(switch1.y, source.T_in) annotation (Line(points={{77,76},{82,76},{82,
          28},{26,28},{26,-4}},
                              color={0,0,127}));
  connect(source.ports[1], vol.ports[1]) annotation (Line(points={{48,0},{58,0}},
                                   color={0,127,255}));
  connect(vol.ports[2], senT_return.port_a)
    annotation (Line(points={{62,0},{70,0}},              color={0,127,255}));
  annotation ( Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-20},{100,160}}),
                                     graphics={
                                Rectangle(
        extent={{-100,-40},{100,160}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-42,56},{-14,84}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{16,56},{44,84}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{16,6},{44,34}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-42,6},{-14,34}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{52,130},{96,110}},
          lineColor={0,0,127},
          textString="PPum"),             Polygon(
          points={{-86,98},{-86,18},{-26,58},{-86,98}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
                             Ellipse(
          extent={{-8,100},{72,20}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html><p>
  A simple substation model using a fixed temperature difference and
  the actual supply temperature to calculate the mass flow rate drawn
  from the network. This model uses an open loop design to prescribe
  the required flow rate.
</p>
<ul>
  <li>Novemver 22, 2019, by Nils Neuland:<br/>
    Revised variable names and documentation to follow guidelines.
  </li>
  <li>October 23, 2018, by Tobias Blacha:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-20},{100,160}})));
end VarTSupplyDpFixedTempDifferenceBypass;
