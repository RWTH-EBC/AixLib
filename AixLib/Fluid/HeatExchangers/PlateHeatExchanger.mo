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
  AixLib.Fluid.Sensors.MassFlowRate mFlow1(redeclare package Medium = Medium1)
    "Mass Flow 1"
    annotation (Placement(transformation(extent={{-68,52},{-52,68}})));
  AixLib.Fluid.Sensors.MassFlowRate mFlow2(redeclare package Medium = Medium2)
    "Mass Flow 2"
    annotation (Placement(transformation(extent={{68,-52},{52,-68}})));
  AixLib.Fluid.MixingVolumes.MixingVolume Mixer1(
    nPorts=2,
    V=V_ColdCircuit,
    m_flow_nominal=m_flow1_nominal,
    redeclare package Medium = Medium1) "Mixer for first Volume"
    annotation (Placement(transformation(extent={{-12,60},{-28,44}})));
  AixLib.Fluid.MixingVolumes.MixingVolume Mixer2(
    nPorts=2,
    V=V_WarmCircuit,
    m_flow_nominal=m_flow2_nominal,
    redeclare package Medium = Medium2) "Mixer for second Volume"
    annotation (Placement(transformation(extent={{12,-60},{28,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow sink
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={-26,16})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow source
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-26,-18})));
  Modelica.Fluid.Sensors.TemperatureTwoPort T1_in(redeclare package Medium =
        Medium1) "Temperature of Mass Flow 1 (in)"
    annotation (Placement(transformation(extent={{-48,68},{-32,52}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort h1_in(redeclare package Medium =
        Medium1) "Enthalpy of Mass Flow 1 (in)"
    annotation (Placement(transformation(extent={{-88,52},{-72,68}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort h1_out(redeclare package
      Medium = Medium1) "Enthalpy of Mass Flow 1 (out)"
    annotation (Placement(transformation(extent={{72,68},{88,52}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort T1_out(redeclare package Medium =
        Medium1) "Temperature of Mass Flow 1 (in)"
    annotation (Placement(transformation(extent={{52,68},{68,52}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort T2_in(redeclare package Medium =
        Medium2) "Temperature of Mass Flow 2 (in)"
    annotation (Placement(transformation(extent={{48,-68},{32,-52}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort h2_in(redeclare package Medium =
        Medium2) "Enthalpy of Mass Flow 2 (in)"
    annotation (Placement(transformation(extent={{88,-68},{72,-52}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort h2_out(redeclare package
      Medium = Medium2) "Enthalpy of Mass Flow 2 (out)"
    annotation (Placement(transformation(extent={{-52,-68},{-68,-52}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort T2_out(redeclare package Medium =
        Medium2) "Temperature of Mass Flow 2 (out)"
    annotation (Placement(transformation(extent={{-72,-68},{-88,-52}})));
  Utilities.Heat_Transfer heatTransfer(tempCalcOutflow(effectiveness(A=A, k=k)))
    "computes the current heat flow from/to DH and HS volume" annotation (
      Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={0,0})));
  Modelica.Blocks.Continuous.Integrator Measure_Qflow
    "Integrator to measure Qflow over the whole simulation time" annotation (
      Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={-61,15})));
  AixLib.Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Medium1,
    m_flow_nominal=m_flow1_nominal,
    dp_nominal=dp1_nominal) "pressure drop on side 1"
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  AixLib.Fluid.FixedResistances.PressureDrop res2(
    redeclare package Medium = Medium2,
    m_flow_nominal=m_flow2_nominal,
    dp_nominal=dp2_nominal)
    annotation (Placement(transformation(extent={{-10,-70},{-30,-50}})));
  Utilities.cpCalc cpCalc1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,20})));
  Utilities.cpCalc cpCalc2 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={60,-20})));
equation
  dp1 = port_a1.p - port_b1.p;
  dp2 = port_a2.p - port_b2.p;
  connect(Mixer2.heatPort, source.port) annotation (Line(points={{12,-52},{12,
          -40},{12,-26},{-26,-26}}, color={191,0,0}));
  connect(Mixer1.heatPort, sink.port) annotation (Line(points={{-12,52},{-12,34},
          {-26,34},{-26,24}}, color={191,0,0}));
  connect(mFlow1.m_flow, heatTransfer.mFlow1) annotation (Line(points={{-60,
          68.8},{-60,90},{90,90},{90,2},{10,2}}, color={0,0,127}));
  connect(heatTransfer.Q_flow_2, source.Q_flow) annotation (Line(points={{-10,
          -4},{-10,-4},{-26,-4},{-26,-10}}, color={0,0,127}));
  connect(heatTransfer.Q_flow_1, sink.Q_flow) annotation (Line(points={{-10,4},
          {-10,4},{-26,4},{-26,8}}, color={0,0,127}));
  connect(T1_in.port_b, Mixer1.ports[1])
    annotation (Line(points={{-32,60},{-18.4,60}}, color={0,127,255}));
  connect(T1_in.T, heatTransfer.T1_in) annotation (Line(points={{-40,51.2},{-40,
          40},{40,40},{40,8},{10,8}}, color={0,0,127}));
  connect(h1_in.port_b, mFlow1.port_a)
    annotation (Line(points={{-72,60},{-68,60}}, color={0,127,255}));
  connect(T1_out.port_b, h1_out.port_a)
    annotation (Line(points={{68,60},{68,60},{72,60}}, color={0,127,255}));
  connect(mFlow2.port_b, T2_in.port_a)
    annotation (Line(points={{52,-60},{52,-60},{48,-60}}, color={0,127,255}));
  connect(T2_in.port_b, Mixer2.ports[1]) annotation (Line(points={{32,-60},{32,
          -60},{18.4,-60}}, color={0,127,255}));
  connect(T2_in.T, heatTransfer.T2_in) annotation (Line(points={{40,-51.2},{40,
          -51.2},{40,-8},{10,-8}}, color={0,0,127}));
  connect(h2_in.port_b, mFlow2.port_a)
    annotation (Line(points={{72,-60},{72,-60},{68,-60}}, color={0,127,255}));
  connect(h2_out.port_b, T2_out.port_a) annotation (Line(points={{-68,-60},{-68,
          -60},{-72,-60}}, color={0,127,255}));
  connect(port_a1, h1_in.port_a)
    annotation (Line(points={{-100,60},{-88,60}}, color={0,127,255}));
  connect(port_a2, h2_in.port_a)
    annotation (Line(points={{100,-60},{88,-60}}, color={0,127,255}));
  connect(T2_out.port_b, port_b2) annotation (Line(points={{-88,-60},{-88,-60},
          {-100,-60}}, color={0,127,255}));
  connect(port_b1, h1_out.port_b)
    annotation (Line(points={{100,60},{88,60}}, color={0,127,255}));
  connect(mFlow1.port_b, T1_in.port_a) annotation (Line(
      points={{-52,60},{-48,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Mixer1.ports[2], res1.port_a) annotation (Line(points={{-21.6,60},{
          -21.6,60},{10,60}}, color={0,127,255}));
  connect(res1.port_b, T1_out.port_a)
    annotation (Line(points={{30,60},{42,60},{52,60}}, color={0,127,255}));
  connect(h2_out.port_a, res2.port_b)
    annotation (Line(points={{-52,-60},{-30,-60}}, color={0,127,255}));
  connect(res2.port_a, Mixer2.ports[2])
    annotation (Line(points={{-10,-60},{21.6,-60}}, color={0,127,255}));
  connect(cpCalc1.cp, heatTransfer.cP1)
    annotation (Line(points={{60,10},{60,4},{10,4}}, color={0,0,127}));
  connect(cpCalc1.h_out, h1_out.h_out) annotation (Line(points={{66,30},{66,30},
          {66,40},{80,40},{80,51.2}}, color={0,0,127}));
  connect(cpCalc1.T_out, T1_out.T) annotation (Line(points={{58,30},{58,30},{58,
          51.2},{60,51.2}}, color={0,0,127}));
  connect(h1_in.h_out, cpCalc1.h_in) annotation (Line(points={{-80,68.8},{-80,
          68.8},{-80,80},{66,80},{66,46},{62,46},{62,30}},         color={0,0,
          127}));
  connect(T1_in.T, cpCalc1.T_in) annotation (Line(points={{-40,51.2},{-40,40},{
          54,40},{54,30}}, color={0,0,127}));
  connect(cpCalc2.cp, heatTransfer.cP2)
    annotation (Line(points={{60,-10},{60,-4},{10,-4}}, color={0,0,127}));
  connect(h2_in.h_out, cpCalc2.h_in) annotation (Line(points={{80,-51.2},{80,
          -40},{62,-40},{62,-30}}, color={0,0,127}));
  connect(T2_out.T, cpCalc2.T_out) annotation (Line(points={{-80,-51.2},{-80,
          -34},{58,-34},{58,-30}}, color={0,0,127}));
  connect(h2_out.h_out, cpCalc2.h_out) annotation (Line(points={{-60,-51.2},{
          -60,-51.2},{-60,-38},{66,-38},{66,-30}}, color={0,0,127}));
  connect(heatTransfer.Q_flow_1, Measure_Qflow.u) annotation (Line(points={{-10,
          4},{-40,4},{-40,15},{-55,15}}, color={0,0,127}));
  connect(mFlow2.m_flow, heatTransfer.mFlow2) annotation (Line(points={{60,
          -68.8},{60,-90},{90,-90},{90,-2},{10,-2}}, color={0,0,127}));
  connect(T2_in.T, cpCalc2.T_in) annotation (Line(points={{40,-51.2},{40,-42},{
          54,-42},{54,-30}}, color={0,0,127}));
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
    Diagram(coordinateSystem(preserveAspectRatio=false, initialScale=0.1,
        extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, initialScale=0.1,
        extent={{-100,-120},{100,100}}),
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
