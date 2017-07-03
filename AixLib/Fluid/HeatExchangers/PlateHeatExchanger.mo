within AixLib.Fluid.HeatExchangers;
model PlateHeatExchanger
  "Partial model transporting two fluids each between two ports without storing mass or energy"
  extends AixLib.Fluid.Interfaces.PartialFourPort;
//   parameter Medium1.MassFlowRate m_flow1_small(min=0) = 1E-4*abs(m1_flow_nominal)
//     "Small mass flow rate for regularization of zero flow"
//     annotation(Dialog(tab = "Advanced"));
//   parameter Medium2.MassFlowRate m_flow2_small(min=0) = 1E-4*abs(m2_flow_nominal)
//     "Small mass flow rate for regularization of zero flow"
//     annotation(Dialog(tab = "Advanced"));
  // Diagnostics
  parameter Boolean show_T = false
    "= true, if actual temperature at port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  parameter Modelica.SIunits.Area A "Heat transfer area";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer k
    "Coefficient of heat transfer";
  parameter Modelica.SIunits.Pressure dp1_nominal=10000
    "The pressure drop on side 1 (warm side)";
  parameter Modelica.SIunits.Pressure dp2_nominal=10000
    "The pressure drop on side 2 (cold side)";
  parameter Modelica.SIunits.Volume V_ColdCircuit=5/1000
    "The Volume of the cold water circuit";
  parameter Modelica.SIunits.Volume V_WarmCircuit=5/1000
    "The Volume of the warm water circuit";
  parameter Modelica.SIunits.MassFlowRate m_flow1_nominal=1
    "The nominal mass flow of the cold water circuit";
  parameter Modelica.SIunits.MassFlowRate m_flow2_nominal=1
    "The nominal mass flow of the warm water circuit";

  Medium1.MassFlowRate m1_flow(start=m_flow1_nominal) = port_a1.m_flow
    "Mass flow rate from port_a1 to port_b1 (m1_flow > 0 is design flow direction)";
  Modelica.SIunits.PressureDifference dp1(start=dp1_nominal, displayUnit="Pa")
    "Pressure difference between port_a1 and port_b1";

  Medium2.MassFlowRate m2_flow(start=m_flow2_nominal) = port_a2.m_flow
    "Mass flow rate from port_a2 to port_b2 (m2_flow > 0 is design flow direction)";
  Modelica.SIunits.PressureDifference dp2(start=dp2_nominal, displayUnit="Pa")
    "Pressure difference between port_a2 and port_b2";

  Medium1.ThermodynamicState sta_a1=
      Medium1.setState_phX(port_a1.p,
                           noEvent(actualStream(port_a1.h_outflow)),
                           noEvent(actualStream(port_a1.Xi_outflow))) if
         show_T "Medium properties in port_a1";
  Medium1.ThermodynamicState sta_b1=
      Medium1.setState_phX(port_b1.p,
                           noEvent(actualStream(port_b1.h_outflow)),
                           noEvent(actualStream(port_b1.Xi_outflow))) if
         show_T "Medium properties in port_b1";
  Medium2.ThermodynamicState sta_a2=
      Medium2.setState_phX(port_a2.p,
                           noEvent(actualStream(port_a2.h_outflow)),
                           noEvent(actualStream(port_a2.Xi_outflow))) if
         show_T "Medium properties in port_a2";
  Medium2.ThermodynamicState sta_b2=
      Medium2.setState_phX(port_b2.p,
                           noEvent(actualStream(port_b2.h_outflow)),
                           noEvent(actualStream(port_b2.Xi_outflow))) if
         show_T "Medium properties in port_b2";
protected
  Medium1.ThermodynamicState state_a1_inflow=
    Medium1.setState_phX(port_a1.p, inStream(port_a1.h_outflow), inStream(port_a1.Xi_outflow))
    "state for medium inflowing through port_a1";
  Medium1.ThermodynamicState state_b1_inflow=
    Medium1.setState_phX(port_b1.p, inStream(port_b1.h_outflow), inStream(port_b1.Xi_outflow))
    "state for medium inflowing through port_b1";
  Medium2.ThermodynamicState state_a2_inflow=
    Medium2.setState_phX(port_a2.p, inStream(port_a2.h_outflow), inStream(port_a2.Xi_outflow))
    "state for medium inflowing through port_a2";
  Medium2.ThermodynamicState state_b2_inflow=
    Medium2.setState_phX(port_b2.p, inStream(port_b2.h_outflow), inStream(port_b2.Xi_outflow))
    "state for medium inflowing through port_b2";
public
  AixLib.Fluid.Sensors.MassFlowRate massFlow_DH(redeclare package Medium =
        Medium1) "Mass Flow DH"
    annotation (Placement(transformation(extent={{-74,52},{-58,68}})));
  AixLib.Fluid.Sensors.MassFlowRate massFlow_HS(redeclare package Medium =
        Medium2) "Mass Flow HS"
    annotation (Placement(transformation(extent={{76,-52},{60,-68}})));
  AixLib.Fluid.MixingVolumes.MixingVolume Mixer_DH(
    nPorts=2,
    V=V_ColdCircuit,
    m_flow_nominal=m_flow1_nominal,
    redeclare package Medium = Medium1) "Mixer for DH Volume"
    annotation (Placement(transformation(extent={{-6,60},{-22,44}})));
  AixLib.Fluid.MixingVolumes.MixingVolume Mixer_HS(
    nPorts=2,
    V=V_WarmCircuit,
    m_flow_nominal=m_flow2_nominal,
    redeclare package Medium = Medium2) "Mixer for HS Volume"
    annotation (Placement(transformation(extent={{6,-60},{22,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow sink
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={-6,16})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow source
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={6,-18})));
  Modelica.Fluid.Sensors.TemperatureTwoPort T_DH_in(redeclare package Medium =
        Medium1) "Temperature of Mass Flow DH (in)"
    annotation (Placement(transformation(extent={{-52,68},{-36,52}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort Enthalpy_DH_in(redeclare
      package Medium = Medium1) "Enthalpy of Mass Flow DH (in)"
    annotation (Placement(transformation(extent={{-96,52},{-80,68}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort Enthalpy_DH_out(redeclare
      package Medium = Medium1) "Enthalpy of Mass Flow DH (out)"
    annotation (Placement(transformation(extent={{78,68},{94,52}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort T_DH_out(redeclare package Medium =
        Medium1) "Temperature of Mass Flow DH (in)"
    annotation (Placement(transformation(extent={{58,68},{74,52}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort T_HS_in(redeclare package Medium =
        Medium2) "Temperature of Mass Flow HS (in)"
    annotation (Placement(transformation(extent={{60,-68},{44,-52}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort Enhalpy_HS_in(redeclare
      package Medium = Medium2) "Enthalpy of Mass Flow HS (in)"
    annotation (Placement(transformation(extent={{94,-68},{78,-52}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort Enthalpy_HS_out(redeclare
      package Medium = Medium2) "Enthalpy of Mass Flow HS (out)"
    annotation (Placement(transformation(extent={{-36,-68},{-52,-52}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort T_HS_out(redeclare package Medium =
        Medium2) "Temperature of Mass Flow HS (out)"
    annotation (Placement(transformation(extent={{-64,-68},{-80,-52}})));
  Utilities.cP_DH cP_DH(realExpression(y=0.01)) annotation (
      Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={70,18})));
  Utilities.cP_HS cP_HS annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={70,-18})));
  Utilities.Heat_Transfer heatTransfer(tempCalcOutflow(effectiveness(A=A, k=k)))
    "computes the current heat flow from/to DH and HS volume" annotation (
      Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={32,0})));
  Modelica.Blocks.Continuous.Integrator Measure_Qflow
    "Integrator to measure Qflow over the whole simulation time" annotation (
      Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={5,29})));
  AixLib.Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow1_nominal,
    dp_nominal=dp1_nominal) "pressure drop on side 1"
    annotation (Placement(transformation(extent={{18,50},{38,70}})));
  AixLib.Fluid.FixedResistances.PressureDrop res2(
    redeclare package Medium = Medium2,
    m_flow_nominal=m_flow2_nominal,
    dp_nominal=dp2_nominal)
    annotation (Placement(transformation(extent={{-6,-70},{-26,-50}})));
equation
  dp1 = port_a1.p - port_b1.p;
  dp2 = port_a2.p - port_b2.p;
  connect(Mixer_HS.heatPort,source. port) annotation (Line(points={{6,-52},{6,-26}},
                                          color={191,0,0}));
  connect(Mixer_DH.heatPort,sink. port) annotation (Line(points={{-6,52},{-6,40},
          {-6,24}},                 color={191,0,0}));
  connect(massFlow_HS.m_flow, heatTransfer.m_flow_HS) annotation (Line(points={{
          68,-68.8},{68,-68.8},{68,-100},{112,-100},{112,-2},{42,-2}}, color={0,
          0,127}));
  connect(massFlow_DH.m_flow, heatTransfer.m_flow_DH) annotation (Line(points={{
          -66,68.8},{-66,100},{112,100},{112,2},{42,2}}, color={0,0,127}));
  connect(cP_DH.cp, heatTransfer.cp_DH)
    annotation (Line(points={{70,8},{70,4},{42,4}}, color={0,0,127}));
  connect(cP_HS.cp, heatTransfer.cp_HS)
    annotation (Line(points={{70,-8},{70,-4},{42,-4}}, color={0,0,127}));
  connect(heatTransfer.Q_flow_HS, source.Q_flow) annotation (Line(points={{22,-4},
          {22,-4},{6,-4},{6,-10}}, color={0,0,127}));
  connect(heatTransfer.Q_flow_DH, sink.Q_flow) annotation (Line(points={{22,4},{
          22,4},{-6,4},{-6,8}},                      color={0,0,127}));
  connect(T_DH_in.port_b, Mixer_DH.ports[1])
    annotation (Line(points={{-36,60},{-12.4,60}}, color={0,127,255}));
  connect(T_DH_in.T, cP_DH.T_in) annotation (Line(points={{-44,51.2},{-44,51.2},
          {-44,50},{-44,48},{64,48},{64,28}}, color={0,0,127}));
  connect(T_DH_in.T, heatTransfer.T_DH_in) annotation (Line(points={{-44,51.2},{
          -44,48},{52,48},{52,8},{42,8}}, color={0,0,127}));
  connect(Enthalpy_DH_in.port_b, massFlow_DH.port_a)
    annotation (Line(points={{-80,60},{-80,60},{-74,60}}, color={0,127,255}));
  connect(Enthalpy_DH_in.h_out, cP_DH.h_in) annotation (Line(points={{-88,68.8},
          {-88,68.8},{-88,84},{72,84},{72,28}}, color={0,0,127}));
  connect(Enthalpy_DH_out.h_out, cP_DH.h_out) annotation (Line(points={{86,51.2},
          {86,51.2},{86,48},{76,48},{76,28}}, color={0,0,127}));
  connect(T_DH_out.port_b, Enthalpy_DH_out.port_a)
    annotation (Line(points={{74,60},{76,60},{78,60}}, color={0,127,255}));
  connect(T_DH_out.T, cP_DH.T_out)
    annotation (Line(points={{66,51.2},{68,51.2},{68,28}}, color={0,0,127}));
  connect(massFlow_HS.port_b, T_HS_in.port_a)
    annotation (Line(points={{60,-60},{60,-60}}, color={0,127,255}));
  connect(T_HS_in.port_b, Mixer_HS.ports[1]) annotation (Line(points={{44,-60},{
          44,-60},{12.4,-60}}, color={0,127,255}));
  connect(T_HS_in.T, cP_HS.T_in) annotation (Line(points={{52,-51.2},{52,-51.2},
          {52,-40},{64,-40},{64,-28}}, color={0,0,127}));
  connect(T_HS_in.T, heatTransfer.T_HS_in) annotation (Line(points={{52,-51.2},{
          52,-51.2},{52,-8},{42,-8}}, color={0,0,127}));
  connect(Enhalpy_HS_in.port_b, massFlow_HS.port_a)
    annotation (Line(points={{78,-60},{78,-60},{76,-60}}, color={0,127,255}));
  connect(Enhalpy_HS_in.h_out, cP_HS.h_in) annotation (Line(points={{86,-51.2},{
          86,-51.2},{86,-40},{72,-40},{72,-28}}, color={0,0,127}));
  connect(Enthalpy_HS_out.h_out, cP_HS.h_out) annotation (Line(points={{-44,-51.2},
          {-44,-51.2},{-44,-36},{76,-36},{76,-28}}, color={0,0,127}));
  connect(Enthalpy_HS_out.port_b, T_HS_out.port_a) annotation (Line(points={{-52,
          -60},{-52,-60},{-64,-60}}, color={0,127,255}));
  connect(T_HS_out.T, cP_HS.T_out) annotation (Line(points={{-72,-51.2},{-72,-32},
          {68,-32},{68,-28}}, color={0,0,127}));
  connect(heatTransfer.Q_flow_DH, Measure_Qflow.u) annotation (Line(points={{22,4},{
          16,4},{16,29},{14,29},{11,29}},            color={0,0,127}));
  connect(port_a1, Enthalpy_DH_in.port_a)
    annotation (Line(points={{-100,60},{-98,60},{-96,60}}, color={0,127,255}));
  connect(port_a2, Enhalpy_HS_in.port_a)
    annotation (Line(points={{100,-60},{98,-60},{94,-60}}, color={0,127,255}));
  connect(T_HS_out.port_b, port_b2) annotation (Line(points={{-80,-60},{-80,-60},
          {-100,-60}}, color={0,127,255}));
  connect(port_b1, Enthalpy_DH_out.port_b)
    annotation (Line(points={{100,60},{98,60},{94,60}}, color={0,127,255}));
  connect(massFlow_DH.port_b, T_DH_in.port_a) annotation (Line(
      points={{-58,60},{-52,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Mixer_DH.ports[2], res1.port_a) annotation (Line(points={{-15.6,60},{-15.6,
          60},{18,60}}, color={0,127,255}));
  connect(res1.port_b, T_DH_out.port_a)
    annotation (Line(points={{38,60},{58,60}}, color={0,127,255}));
  connect(Enthalpy_HS_out.port_a,res2. port_b)
    annotation (Line(points={{-36,-60},{-26,-60}}, color={0,127,255}));
  connect(res2.port_a, Mixer_HS.ports[2])
    annotation (Line(points={{-6,-60},{15.6,-60}}, color={0,127,255}));
  annotation (
  preferredView="info",
    Documentation(info="<html>
<p>
This component defines the interface for models that
transport two fluid streams between four ports.
It is similar to
<a href=\"modelica://AixLib.Fluid.Interfaces.PartialTwoPortInterface\">
AixLib.Fluid.Interfaces.PartialTwoPortInterface</a>,
but it has four ports instead of two.
</p>
<p>
The model is used by other models in this package that add heat transfer,
mass transfer and pressure drop equations.
</p>
</html>", revisions="<html>
<ul>
<li><i>2017-04-25</i> by Peter Matthes:<br>Various changes of names and connectors of submodels. Changes parameter defaults (dp, m_flow, V). Removed unused parameters. Renamed pressure drop pipes. This model uses indices &QUOT;DH&QUOT; for domestic hot water and &QUOT;HS&QUOT; for heating system instead of &QUOT;side 1&QUOT; and &QUOT;side 2&QUOT; as the port naming suggests. This should be fixed some time.</li>
<li><i>February 08, 2017</i> by Paul Thiele:<br>Updated the Plate Heat Exchanger model. The model now uses only components of the AixLib and Modelica-Library. </li>
<li><i>January 22, 2016</i>, by Michael Wetter:<br>Corrected type declaration of pressure difference. This is for <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/404\">#404</a>. </li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, initialScale=0.1)),
    Icon(coordinateSystem(preserveAspectRatio=false, initialScale=0.1),
                    graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={215,215,215},
          fillColor={247,247,247},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,80},{100,-80}}, lineColor={28,108,200}),
        Line(
          points={{-43,61},{3,61},{-53,-39},{3,-139},{-43,-139}},
          color={255,0,0},
          thickness=0.5,
          origin={-39,-7},
          rotation=90),
        Line(
          points={{-45,139},{1,139},{-55,39},{1,-61},{-45,-61}},
          color={255,0,0},
          thickness=0.5,
          origin={-39,5},
          rotation=270),
        Text(
          extent={{-100,100},{100,80}},
          lineColor={28,108,200},
          textString="side 1"),
        Text(
          extent={{-100,-80},{100,-100}},
          lineColor={238,46,47},
          textString="side 2")}));
end PlateHeatExchanger;
