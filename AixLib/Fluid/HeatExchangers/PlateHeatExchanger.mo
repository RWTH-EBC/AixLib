within AixLib.Fluid.HeatExchangers;
model PlateHeatExchanger
  "Partial model transporting two fluids each between two ports without storing mass or energy"
  extends AixLib.Fluid.Interfaces.PartialFourPort;
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal(min=0)
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal(min=0)
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Medium1.MassFlowRate m1_flow_small(min=0) = 1E-4*abs(m1_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));
  parameter Medium2.MassFlowRate m2_flow_small(min=0) = 1E-4*abs(m2_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));
  // Diagnostics
  parameter Boolean show_T = false
    "= true, if actual temperature at port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  parameter Modelica.SIunits.Area A "Heat transfer area";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer k
    "Coefficient of heat transfer";
  parameter Modelica.SIunits.Pressure dp_DistrictHeating
    "The pressure drop of the district heating circuit caused by the heat exchanger. ";
  parameter Modelica.SIunits.Pressure dp_HeatingSystem
    "The pressure drop of the heating system caused by the heat exchanger";
  parameter Modelica.SIunits.Volume V_ColdCircuit
    "The Volume of the cold water circuit";
  parameter Modelica.SIunits.Volume V_WarmCircuit
    "The Volume of the warm water circuit";
  parameter Modelica.SIunits.MassFlowRate m_flow_DH_nom
    "The nominal mass flow of the cold water circuit";
  parameter Modelica.SIunits.MassFlowRate m_flow_HS_nom
    "The nominal mass flow of the warm water circuit";

  Medium1.MassFlowRate m1_flow(start=0) = port_a1.m_flow
    "Mass flow rate from port_a1 to port_b1 (m1_flow > 0 is design flow direction)";
  Modelica.SIunits.PressureDifference dp1(start=0, displayUnit="Pa")
    "Pressure difference between port_a1 and port_b1";

  Medium2.MassFlowRate m2_flow(start=0) = port_a2.m_flow
    "Mass flow rate from port_a2 to port_b2 (m2_flow > 0 is design flow direction)";
  Modelica.SIunits.PressureDifference dp2(start=0, displayUnit="Pa")
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
  AixLib.Fluid.Sensors.MassFlowRate Flow_DH(redeclare package Medium = Medium1)
    "Mass Flow DH"
    annotation (Placement(transformation(extent={{-74,52},{-58,68}})));
  AixLib.Fluid.Sensors.MassFlowRate Flow_HS(redeclare package Medium = Medium2)
    "Mass Flow HS"
    annotation (Placement(transformation(extent={{76,-52},{60,-68}})));
  AixLib.Fluid.MixingVolumes.MixingVolume Mixer_DH(
    nPorts=2,
    V=V_ColdCircuit,
    m_flow_nominal=m_flow_DH_nom,
    redeclare package Medium = Medium1) "Mixer for DH Volume"
    annotation (Placement(transformation(extent={{-6,60},{-22,44}})));
  AixLib.Fluid.MixingVolumes.MixingVolume Mixer_HS(
    nPorts=2,
    V=V_WarmCircuit,
    m_flow_nominal=m_flow_HS_nom,
    redeclare package Medium = Medium2) "Mixer for HS Volume"
    annotation (Placement(transformation(extent={{6,-60},{22,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow sink
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-8,8})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow source
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={6,-10})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temp_DH_in(redeclare package Medium =
        Medium1) "Temperature of Mass Flow DH (in)"
    annotation (Placement(transformation(extent={{-52,68},{-34,52}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort Enthalpy_DH_in(redeclare
      package Medium = Medium1) "Enthalpy of Mass Flow DH (in)"
    annotation (Placement(transformation(extent={{-96,52},{-80,68}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort Enthalpy_DH_out(redeclare
      package Medium = Medium1) "Enthalpy of Mass Flow DH (out)"
    annotation (Placement(transformation(extent={{78,68},{94,52}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temp_DH_out(redeclare package
      Medium = Medium1) "Temperature of Mass Flow DH (in)"
    annotation (Placement(transformation(extent={{56,68},{74,52}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temp_HS_in(redeclare package Medium =
        Medium2) "Temperature of Mass Flow HS (in)"
    annotation (Placement(transformation(extent={{60,-68},{42,-52}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort Enhalpy_HS_in(redeclare
      package Medium = Medium2) "Enthalpy of Mass Flow HS (in)"
    annotation (Placement(transformation(extent={{94,-68},{78,-52}})));
  Modelica.Fluid.Sensors.SpecificEnthalpyTwoPort Enthalpy_HS_out(redeclare
      package Medium = Medium2) "Enthalpy of Mass Flow HS (out)"
    annotation (Placement(transformation(extent={{-36,-68},{-52,-52}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temp_HS_out(redeclare package
      Medium = Medium2) "Temperature of Mass Flow HS (out)"
    annotation (Placement(transformation(extent={{-64,-68},{-80,-52}})));
  Utilities.cP_DH cP_DH(realExpression(y=0.01)) annotation (
      Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={70,18})));
  Utilities.cP_HS cP_HS1 annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={70,-18})));
  Utilities.Heat_Transfer heat_Transfer(temperature_detection(
        effectiveness(A=A, k=k))) annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={32,0})));
  Modelica.Blocks.Continuous.Integrator Measure_Qflow
    "Integrator to measure Qflow over the whole simulation time" annotation (
      Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={5,29})));
  AixLib.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium1,
    m_flow_nominal=m1_flow_nominal,
    dp_nominal=dp_DistrictHeating)
    annotation (Placement(transformation(extent={{18,50},{38,70}})));
  AixLib.Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Medium2,
    m_flow_nominal=m2_flow_nominal,
    dp_nominal=dp_HeatingSystem)
    annotation (Placement(transformation(extent={{-6,-70},{-26,-50}})));
equation
  dp1 = port_a1.p - port_b1.p;
  dp2 = port_a2.p - port_b2.p;
  connect(Mixer_HS.heatPort,source. port) annotation (Line(points={{6,-52},{6,
          -52},{0,-52},{0,-2},{6,-2}},    color={191,0,0}));
  connect(Mixer_DH.heatPort,sink. port) annotation (Line(points={{-6,52},{
          -6,-2},{-8,-2},{-8,0}},   color={191,0,0}));
  connect(Flow_HS.m_flow,heat_Transfer.u3)
                                       annotation (Line(points={{68,-68.8},{68,
          -68.8},{68,-100},{112,-100},{112,-2},{42,-2}},
                                                 color={0,0,127}));
  connect(Flow_DH.m_flow,heat_Transfer.u6)
                                       annotation (Line(points={{-66,68.8},{-66,
          100},{112,100},{112,2},{42,2}},color={0,0,127}));
  connect(cP_DH.y,heat_Transfer.u5)      annotation (Line(points={{70,8},{70,4},
          {42,4}},                                    color={0,0,127}));
  connect(cP_HS1.y,heat_Transfer.u4)     annotation (Line(points={{70,-8},{70,
          -4},{42,-4}},                       color={0,0,127}));
  connect(heat_Transfer.y1,source. Q_flow) annotation (Line(points={{22,-4},{22,
          -4},{22,-18},{6,-18}}, color={0,0,127}));
  connect(heat_Transfer.y,sink.Q_flow) annotation (Line(points={{22,4},{22,18},
          {-8,18},{-8,16}},  color={0,0,127}));
  connect(temp_DH_in.port_b,Mixer_DH. ports[1]) annotation (Line(points={{-34,60},
          {-12.4,60}},              color={0,127,255}));
  connect(temp_DH_in.T,cP_DH. u2) annotation (Line(points={{-43,51.2},{-44,51.2},
          {-44,50},{-44,48},{64,48},{64,28}},              color={0,0,127}));
  connect(temp_DH_in.T,heat_Transfer. u2) annotation (Line(points={{-43,
          51.2},{-43,48},{52,48},{52,8},{42,8}},
                                    color={0,0,127}));
  connect(Enthalpy_DH_in.port_b,Flow_DH. port_a)
    annotation (Line(points={{-80,60},{-80,60},{-74,60}},
                                                   color={0,127,255}));
  connect(Enthalpy_DH_in.h_out,cP_DH. u4) annotation (Line(points={{-88,68.8},{
          -88,68.8},{-88,84},{72,84},{72,28}},
                                         color={0,0,127}));
  connect(Enthalpy_DH_out.h_out,cP_DH. u3) annotation (Line(points={{86,51.2},{
          86,51.2},{86,48},{76,48},{76,28}},
                                           color={0,0,127}));
  connect(temp_DH_out.port_b,Enthalpy_DH_out. port_a) annotation (Line(points={{74,60},
          {76,60},{78,60}},                  color={0,127,255}));
  connect(temp_DH_out.T,cP_DH. u1) annotation (Line(points={{65,51.2},{68,51.2},
          {68,28}},                                        color={0,0,127}));
  connect(Flow_HS.port_b,temp_HS_in. port_a)
    annotation (Line(points={{60,-60},{60,-60}},          color={0,127,255}));
  connect(temp_HS_in.port_b,Mixer_HS. ports[1]) annotation (Line(points={{42,-60},
          {42,-60},{12.4,-60}},        color={0,127,255}));
  connect(temp_HS_in.T,cP_HS1. u2) annotation (Line(points={{51,-51.2},{52,
          -51.2},{52,-44},{64,-44},{64,-28}},                           color={
          0,0,127}));
  connect(temp_HS_in.T,heat_Transfer. u1) annotation (Line(points={{51,-51.2},{
          52,-51.2},{52,-8},{42,-8}},  color={0,0,127}));
  connect(Enhalpy_HS_in.port_b,Flow_HS. port_a) annotation (Line(points={{78,-60},
          {78,-60},{76,-60}},   color={0,127,255}));
  connect(Enhalpy_HS_in.h_out,cP_HS1. u4) annotation (Line(points={{86,-51.2},{
          78,-51.2},{78,-38},{72,-38},{72,-28}},
                                       color={0,0,127}));
  connect(Enthalpy_HS_out.h_out,cP_HS1. u3) annotation (Line(points={{-44,-51.2},
          {-38,-51.2},{-38,-40},{76,-40},{76,-28}},
                                      color={0,0,127}));
  connect(Enthalpy_HS_out.port_b,temp_HS_out. port_a)
    annotation (Line(points={{-52,-60},{-52,-60},{-64,-60}},
                                                          color={0,127,255}));
  connect(temp_HS_out.T,cP_HS1. u1)
    annotation (Line(points={{-72,-51.2},{-72,-32},{68,-32},{68,-28}},
                                                          color={0,0,127}));
  connect(heat_Transfer.y,Measure_Qflow. u) annotation (Line(points={{22,4},{22,
          4},{22,29},{11,29}},        color={0,0,127}));
  connect(port_a1, Enthalpy_DH_in.port_a)
    annotation (Line(points={{-100,60},{-98,60},{-96,60}}, color={0,127,255}));
  connect(port_a2, Enhalpy_HS_in.port_a)
    annotation (Line(points={{100,-60},{98,-60},{94,-60}}, color={0,127,255}));
  connect(temp_HS_out.port_b, port_b2) annotation (Line(points={{-80,-60},{-80,
          -60},{-100,-60}}, color={0,127,255}));
  connect(port_b1, Enthalpy_DH_out.port_b)
    annotation (Line(points={{100,60},{98,60},{94,60}}, color={0,127,255}));
  connect(Flow_DH.port_b, temp_DH_in.port_a) annotation (Line(
      points={{-58,60},{-52,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Mixer_DH.ports[2], res.port_a) annotation (Line(points={{-15.6,60},{
          -15.6,60},{18,60}}, color={0,127,255}));
  connect(res.port_b, temp_DH_out.port_a)
    annotation (Line(points={{38,60},{56,60}}, color={0,127,255}));
  connect(Enthalpy_HS_out.port_a, res1.port_b)
    annotation (Line(points={{-36,-60},{-26,-60}}, color={0,127,255}));
  connect(res1.port_a, Mixer_HS.ports[2])
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
<li>
February 08, 2017 by Paul Thiele:<br/>
Updated the Plate Heat Exchanger model. The model now uses
only components of the AixLib and Modelica-Library.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/404\">#404</a>.
</li>
<li>
November 13, 2013 by Michael Wetter:<br/>
Removed assignment of <code>min</code> and <code>max</code>
attributes of port mass flow rates, as this is already
done in the base class.
</li>
<li>
November 12, 2013 by Michael Wetter:<br/>
Removed <code>import Modelica.Constants;</code> statement.
</li>
<li>
November 11, 2013 by Michael Wetter:<br/>
Removed the parameter <code>homotopyInitialization</code>
as it is no longer used in this model.
</li>
<li>
November 10, 2013 by Michael Wetter:<br/>
In the computation of <code>sta_a1</code>,
<code>sta_a2</code>, <code>sta_b1</code> and <code>sta_b2</code>,
removed the branch that uses the homotopy operator.
The rational is that these variables are conditionally enables (because
of <code>... if show_T</code>. Therefore, the Modelica Language Specification
does not allow for these variables to be used in any equation. Hence,
the use of the homotopy operator is not needed here.
</li>
<li>
October 10, 2013 by Michael Wetter:<br/>
Added <code>noEvent</code> to the computation of the states at the port.
This is correct, because the states are only used for reporting, but not
to compute any other variable.
Use of the states to compute other variables would violate the Modelica
language, as conditionally removed variables must not be used in any equation.
</li>
<li>
October 8, 2013 by Michael Wetter:<br/>
Removed the computation of <code>V_flow</code> and removed the parameter
<code>show_V_flow</code>.
The reason is that the computation of <code>V_flow</code> required
the use of <code>sta_a</code> (to compute the density),
but <code>sta_a</code> is also a variable that is conditionally
enabled. However, this was not correct Modelica syntax as conditional variables
can only be used in a <code>connect</code>
statement, not in an assignment. Dymola 2014 FD01 beta3 is checking
for this incorrect syntax. Hence, <code>V_flow</code> was removed as its
conditional implementation would require a rather cumbersome implementation
that uses a new connector that carries the state of the medium.
</li>
<li>
April 26, 2013 by Marco Bonvini:<br/>
Moved the definitions of <code>dp1</code> and <code>dp2</code> because they cause some problem with PyFMI.
</li>
<li>
March 27, 2012 by Michael Wetter:<br/>
Replaced the erroneous function call <code>Medium.density</code> with
<code>Medium1.density</code> and <code>Medium2.density</code>.
Changed condition to remove <code>sta_a1</code> and <code>sta_a2</code> to also
compute the states at the inlet port if <code>show_V_flow=true</code>.
The previous implementation resulted in a translation error
if <code>show_V_flow=true</code>, but worked correctly otherwise
because the erroneous function call is removed if  <code>show_V_flow=false</code>.
</li>
<li>
March 27, 2011 by Michael Wetter:<br/>
Added <code>homotopy</code> operator.
</li>
<li>
March 21, 2010 by Michael Wetter:<br/>
Changed pressure start value from <code>system.p_start</code>
to <code>Medium.p_default</code> since HVAC models may have water and
air, which are typically at different pressures.
</li>
<li>
September 19, 2008 by Michael Wetter:<br/>
Added equations for the mass balance of extra species flow,
i.e., <code>C</code> and <code>mC_flow</code>.
</li>
<li>
April 28, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},
            {120,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,
            100}}), graphics={
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
          rotation=270)}));
end PlateHeatExchanger;
