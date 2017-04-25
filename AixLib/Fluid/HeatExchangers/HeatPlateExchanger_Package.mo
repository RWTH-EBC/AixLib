within ;
package HeatPlateExchanger_Package
  "Partial model transporting two fluids each between two ports without storing mass or energy"

  model HeatPlateExchanger
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
      annotation (Placement(transformation(extent={{-78,52},{-62,68}})));
    AixLib.Fluid.Sensors.MassFlowRate Flow_HS(redeclare package Medium = Medium2)
      "Mass Flow HS"
      annotation (Placement(transformation(extent={{76,-52},{60,-68}})));
    AixLib.Fluid.MixingVolumes.MixingVolume Mixer_DH(
      nPorts=3,
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
    AixLib.Fluid.FixedResistances.FixedResistanceDpM res_DH(
      dp_nominal=dp_DistrictHeating,
      m_flow_nominal=m_flow_DH_nom,
      redeclare package Medium = Medium1)
      "Fixed Resistance for Losses in Pipes DH" annotation (Placement(
          transformation(
          extent={{7.5,-8.5},{-7.5,8.5}},
          rotation=180,
          origin={33.5,59.5})));
    AixLib.Fluid.FixedResistances.FixedResistanceDpM res_HS(
      dp_nominal=dp_HeatingSystem,
      m_flow_nominal=m_flow_HS_nom,
      redeclare package Medium = Medium2)
      "Fixed Resistance for Losses in Pipes HS" annotation (Placement(
          transformation(
          extent={{8,-8},{-8,8}},
          rotation=0,
          origin={-16,-60})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow sink
      annotation (Placement(transformation(extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-8,8})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow source
      annotation (Placement(transformation(extent={{8,-8},{-8,8}},
          rotation=-90,
          origin={6,-10})));
    Modelica.Fluid.Sensors.TemperatureTwoPort temp_DH_in(redeclare package
        Medium =
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
    Modelica.Fluid.Sensors.TemperatureTwoPort temp_HS_in(redeclare package
        Medium =
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
    CP_DH cP_DH(realExpression(y=0.01))
                annotation (Placement(transformation(rotation=-90,
                                                                 extent={{-10,-10},
              {10,10}},
          origin={70,18})));
    cP_HS cP_HS1 annotation (Placement(transformation(rotation=-90,
                                                                  extent={{-10,-10},
              {10,10}},
          origin={70,-18})));
    Heat_Transfer heat_Transfer(temperature_detection(effectiveness(A=A, k=k)))
                                annotation (Placement(transformation(rotation=-90,
            extent={{-10,-10},{10,10}},
          origin={32,0})));
    Modelica.Blocks.Continuous.Integrator Measure_Qflow
      "Integrator to measure Qflow over the whole simulation time" annotation (
        Placement(transformation(
          extent={{5,-5},{-5,5}},
          rotation=0,
          origin={5,29})));
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
                                         annotation (Line(points={{-70,68.8},{-70,
            100},{112,100},{112,2},{42,2}},color={0,0,127}));
    connect(cP_DH.y,heat_Transfer.u5)      annotation (Line(points={{70,8},{70,4},
            {42,4}},                                    color={0,0,127}));
    connect(cP_HS1.y,heat_Transfer.u4)     annotation (Line(points={{70,-8},{70,
            -4},{42,-4}},                       color={0,0,127}));
    connect(heat_Transfer.y1,source. Q_flow) annotation (Line(points={{22,-4},{22,
            -4},{22,-18},{6,-18}}, color={0,0,127}));
    connect(heat_Transfer.y,sink.Q_flow) annotation (Line(points={{22,4},{22,18},
            {-8,18},{-8,16}},  color={0,0,127}));
    connect(Mixer_DH.ports[1],res_DH. port_a) annotation (Line(points={{
            -11.8667,60},{-11.8667,59.5},{26,59.5}},
                                  color={0,127,255}));
    connect(Mixer_HS.ports[1],res_HS. port_a)
      annotation (Line(points={{12.4,-60},{12.4,-60},{-8,-60}},
                                                            color={0,127,255}));
    connect(temp_DH_in.port_b,Mixer_DH. ports[2]) annotation (Line(points={{-34,60},
            {-14,60}},                color={0,127,255}));
    connect(temp_DH_in.T,cP_DH. u2) annotation (Line(points={{-43,51.2},{-48,
            51.2},{-48,50},{-48,48},{64,48},{64,28}},        color={0,0,127}));
    connect(temp_DH_in.T,heat_Transfer. u2) annotation (Line(points={{-43,
            51.2},{-43,48},{52,48},{52,8},{42,8}},
                                      color={0,0,127}));
    connect(Enthalpy_DH_in.port_b,Flow_DH. port_a)
      annotation (Line(points={{-80,60},{-80,60},{-78,60}},
                                                     color={0,127,255}));
    connect(Enthalpy_DH_in.h_out,cP_DH. u4) annotation (Line(points={{-88,68.8},{
            -88,68.8},{-88,84},{72,84},{72,28}},
                                           color={0,0,127}));
    connect(Enthalpy_DH_out.h_out,cP_DH. u3) annotation (Line(points={{86,51.2},{
            86,51.2},{86,48},{76,48},{76,28}},
                                             color={0,0,127}));
    connect(res_DH.port_b,temp_DH_out. port_a) annotation (Line(points={{41,59.5},
            {50,60},{56,60}},               color={0,127,255}));
    connect(temp_DH_out.port_b,Enthalpy_DH_out. port_a) annotation (Line(points={{74,60},
            {76,60},{78,60}},                  color={0,127,255}));
    connect(temp_DH_out.T,cP_DH. u1) annotation (Line(points={{65,51.2},{68,51.2},
            {68,28}},                                        color={0,0,127}));
    connect(Flow_HS.port_b,temp_HS_in. port_a)
      annotation (Line(points={{60,-60},{60,-60}},          color={0,127,255}));
    connect(temp_HS_in.port_b,Mixer_HS. ports[2]) annotation (Line(points={{42,-60},
            {42,-60},{15.6,-60}},        color={0,127,255}));
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
    connect(res_HS.port_b,Enthalpy_HS_out. port_a) annotation (Line(points={{-24,-60},
            {-26,-60},{-36,-60}},     color={0,127,255}));
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
        points={{-62,60},{-52,60}},
        color={0,127,255},
        smooth=Smooth.None));
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
</html>",   revisions="<html>
<ul>
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
              {120,100}}), graphics),
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
  end HeatPlateExchanger;

  model CP_DH "Calculation cp_DH"
    Modelica.Blocks.Math.Add dh_cp_DH(
      k1=+1,
      k2=-1,
      u1(
        min=1,
        max=5000,
        nominal=4000),
      u2(
        min=1,
        max=5000,
        nominal=4000)) "h_out-h_in"
      annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
    Modelica.Blocks.Math.Add dT_cp_DH(
      k1=+1,
      k2=-1,
      u1(
        min=253.15,
        max=323.15,
        nominal=293.15),
      u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "T_out-T_in"
      annotation (Placement(transformation(extent={{-78,-52},{-58,-32}})));
    Modelica.Blocks.Math.Division division_cp_DH(
      u1(
        min=-5000,
        max=5000,
        nominal=4000),
      u2(
        min=0.1,
        max=50,
        nominal=20),
      y(min=1,
        max=5000,
        nominal=4000)) "cp = dh/dT"
      annotation (Placement(transformation(extent={{12,-10},{32,10}})));
    Modelica.Blocks.Interfaces.RealInput u1(
      min=253.15,
      max=323.15,
      nominal=293.15) annotation (Placement(transformation(rotation=0, extent={{
              -110,-30},{-90,-10}})));
    Modelica.Blocks.Interfaces.RealInput u2(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(rotation=0, extent={{
              -110,-70},{-90,-50}})));
    Modelica.Blocks.Interfaces.RealInput u3(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{
              -110,50},{-90,70}})));
    Modelica.Blocks.Interfaces.RealInput u4(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{
              -110,10},{-90,30}})));
    Modelica.Blocks.Interfaces.RealOutput y(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{90,
              -10},{110,10}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{54,-68},{74,-48}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=1)
      annotation (Placement(transformation(extent={{14,-58},{34,-38}})));
    Modelica.Blocks.Sources.Clock clock
      annotation (Placement(transformation(extent={{-34,-64},{-24,-54}})));
    Modelica.Blocks.Logical.Less less
      annotation (Placement(transformation(extent={{-2,-70},{12,-54}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=150)
      annotation (Placement(transformation(extent={{-42,-64},{-22,-84}})));
  equation
    connect(dh_cp_DH.y, division_cp_DH.u1) annotation (Line(points={{-29,40},{-16,
            40},{-16,6},{10,6}},              color={0,0,127}));
    connect(u1, dT_cp_DH.u1) annotation (Line(points={{-100,-20},{-100,-20.4},
            {-80,-20.4},{-80,-36}},color={0,0,127}));
    connect(u2, dT_cp_DH.u2) annotation (Line(points={{-100,-60},{-100,-61.6},
            {-80,-61.6},{-80,-48}},color={0,0,127}));
    connect(u3, dh_cp_DH.u1)
      annotation (Line(points={{-100,60},{-52,60},{-52,46}}, color={0,0,127}));
    connect(u4, dh_cp_DH.u2) annotation (Line(points={{-100,20},{-80,20},{-80,34},
            {-52,34}}, color={0,0,127}));
    connect(y, division_cp_DH.y)
      annotation (Line(points={{100,0},{62,0},{33,0}}, color={0,0,127}));
    connect(realExpression.y,switch1. u1) annotation (Line(points={{35,-48},{
            44,-48},{44,-50},{52,-50}}, color={0,0,127}));
    connect(switch1.y, division_cp_DH.u2) annotation (Line(points={{75,-58},{
            80,-58},{80,-22},{-12,-22},{-12,-6},{10,-6}}, color={0,0,127}));
    connect(clock.y, less.u1) annotation (Line(
        points={{-23.5,-59},{-13.75,-59},{-13.75,-62},{-3.4,-62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(realExpression3.y, less.u2) annotation (Line(
        points={{-21,-74},{-14,-74},{-14,-68.4},{-3.4,-68.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(less.y, switch1.u2) annotation (Line(
        points={{12.7,-62},{32,-62},{32,-58},{52,-58}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(dT_cp_DH.y, switch1.u3) annotation (Line(
        points={{-57,-42},{-54,-42},{-54,-90},{42,-90},{42,-66},{52,-66}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (                                 Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics));
  end CP_DH;

  model cP_HS "Calculation of cp_HS"
    Modelica.Blocks.Math.Add dh_cp_HS(
      k1=+1,
      k2=-1,
      u1(
        min=1,
        max=5000,
        nominal=4000),
      u2(
        min=1,
        max=5000,
        nominal=4000)) "h_out-h_in"
      annotation (Placement(transformation(extent={{58,34},{46,46}})));
    Modelica.Blocks.Math.Add dT_cp_HS(
      k1=+1,
      k2=-1,
      u1(
        min=253.15,
        max=323.15,
        nominal=293.15),
      u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "T_out-T_in"
      annotation (Placement(transformation(extent={{56,-46},{44,-34}})));
    Modelica.Blocks.Math.Division division_cp_HS(
      u1(
        min=-5000,
        max=5000,
        nominal=4000),
      u2(
        min=0.1,
        max=50,
        nominal=20),
      y(min=1,
        max=5000,
        nominal=4000)) "cp = dh/dT"
      annotation (Placement(transformation(extent={{-26,-10},{-46,10}})));
    Modelica.Blocks.Interfaces.RealInput u1(
      min=253.15,
      max=323.15,
      nominal=293.15) annotation (Placement(transformation(rotation=0, extent={{
              110,-30},{90,-10}})));
    Modelica.Blocks.Interfaces.RealInput u2(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(rotation=0, extent={{
              110,-70},{90,-50}})));
    Modelica.Blocks.Interfaces.RealInput u3(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{110,
              50},{90,70}})));
    Modelica.Blocks.Interfaces.RealInput u4(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{110,
              10},{90,30}})));
    Modelica.Blocks.Interfaces.RealOutput y(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{-90,
              -10},{-110,10}})));
  equation
    connect(dh_cp_HS.y, division_cp_HS.u1) annotation (Line(points={{45.4,40},{16,
            40},{16,6},{-24,6}},           color={0,0,127}));
    connect(u1, dT_cp_HS.u1) annotation (Line(points={{100,-20},{100,-20},{78,-20},
            {78,-20},{78,-36.4},{68,-36.4},{57.2,-36.4}}, color={0,0,127}));
    connect(u2, dT_cp_HS.u2) annotation (Line(points={{100,-60},{98,-60},{77.2,
            -60},{77.2,-43.6},{57.2,-43.6}}, color={0,0,127}));
    connect(u3, dh_cp_HS.u1) annotation (Line(points={{100,60},{90,60},{69.2,60},
            {69.2,43.6},{59.2,43.6}}, color={0,0,127}));
    connect(u4, dh_cp_HS.u2) annotation (Line(points={{100,20},{100,20},{80,20},{
            69.2,20},{69.2,36.4},{59.2,36.4}}, color={0,0,127}));
    connect(y, division_cp_HS.y)
      annotation (Line(points={{-100,0},{-47,0}}, color={0,0,127}));
    connect(dT_cp_HS.y, division_cp_HS.u2) annotation (Line(
        points={{43.4,-40},{10,-40},{10,-6},{-24,-6}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (                                 Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics));
  end cP_HS;

  model Heat_Transfer "Heat_Transfer"
    Temperature_detection temperature_detection annotation (Placement(
          transformation(rotation=0, extent={{-10,46},{10,66}})));
    Modelica.Blocks.Math.Add add2(k2=-1, u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "y = T_Return_DH - T_DH_in" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-46,20})));
    Modelica.Blocks.Math.Add add1(
      k1=-1,
      k2=+1,
      u1(
        min=253.15,
        max=323.15,
        nominal=278.15)) "y = - T_HS_in + T_Forward_HS" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={46,20})));
    Modelica.Blocks.Math.Product product1(u1(
        min=0,
        max=50,
        nominal=17.5), u2(
        min=1,
        max=5000,
        nominal=4000)) "y = m_flow_HS * cp_HS " annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,-10})));
    Modelica.Blocks.Math.Product product2(u1(
        min=1,
        max=5000,
        nominal=4000), u2(
        min=0,
        max=50,
        nominal=17.5)) "y = cp_DH *  m_flow_DH" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,-10})));
    Modelica.Blocks.Math.Product productQsink "Qsink" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-50})));
    Modelica.Blocks.Math.Product productQsource "Qsource" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-50})));
    Modelica.Blocks.Interfaces.RealInput u1(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={80,100})));
    Modelica.Blocks.Interfaces.RealInput u2(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-80,100})));
    Modelica.Blocks.Interfaces.RealInput u3(
      min=0,
      max=50,
      nominal=17.5) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={20,100})));
    Modelica.Blocks.Interfaces.RealInput u4(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={40,100})));
    Modelica.Blocks.Interfaces.RealInput u5(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-40,100})));
    Modelica.Blocks.Interfaces.RealInput u6(
      min=0,
      max=50,
      nominal=17.5) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-20,100})));
    Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-40,-100})));
    Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={40,-100})));
  equation
    connect(product1.y, productQsource.u2) annotation (Line(points={{20,-21},{20,
            -28.25},{34,-28.25},{34,-38}},
                               color={0,0,127}));
    connect(product2.y, productQsink.u1) annotation (Line(points={{-20,-21},{-20,
            -28.25},{-34,-28.25},{-34,-38}},
                                 color={0,0,127}));
    connect(add1.y, productQsource.u1) annotation (Line(points={{46,9},{46,2},{46,
            -38}},               color={0,0,127}));
    connect(add2.y, productQsink.u2) annotation (Line(points={{-46,9},{-46,9},{
            -46,-28},{-46,-38}},         color={0,0,127}));
    connect(temperature_detection.y,
                           add1. u2) annotation (Line(points={{8,46},{8,40},{40,
            40},{40,32}}, color={0,0,127}));
    connect(temperature_detection.y1,
                           add2.u1) annotation (Line(points={{-8,46},{-8,40},{-40,
            40},{-40,32}}, color={0,0,127}));
    connect(u1, add1.u1) annotation (Line(points={{80,100},{80,100},{80,50},{80,
            40},{52,40},{52,32}}, color={0,0,127}));
    connect(u2, add2.u2) annotation (Line(points={{-80,100},{-80,100},{-80,48},{
            -80,40},{-52,40},{-52,38},{-52,38},{-52,32},{-52,32}}, color={0,0,127}));
    connect(u3, product1.u1) annotation (Line(points={{20,100},{20,100},{20,94},{
            20,80},{26,80},{26,2}}, color={0,0,127}));
    connect(u4, product1.u2) annotation (Line(points={{40,100},{40,100},{40,56},{
            14,56},{14,54},{14,2}}, color={0,0,127}));
    connect(u5, product2.u1) annotation (Line(points={{-40,100},{-40,100},{-40,56},
            {-38,56},{-14,56},{-14,2}}, color={0,0,127}));
    connect(u6, product2.u2) annotation (Line(points={{-20,100},{-20,100},{-20,80},
            {-26,80},{-26,46},{-26,2}}, color={0,0,127}));
    connect(y, productQsink.y)
      annotation (Line(points={{-40,-100},{-40,-61}}, color={0,0,127}));
    connect(y1, productQsource.y)
      annotation (Line(points={{40,-100},{40,-61}}, color={0,0,127}));
    connect(u6, temperature_detection.C_P_DH) annotation (Line(points={{-20,100},
            {-20,100},{-20,92},{-20,80},{-2,80},{-2,66}}, color={0,0,127}));
    connect(u3, temperature_detection.C_P_HS) annotation (Line(points={{20,100},{
            20,100},{20,94},{20,96},{20,80},{2,80},{2,66}}, color={0,0,127}));
    connect(u5, temperature_detection.MassFlowRate_DH) annotation (Line(points={{
            -40,100},{-40,100},{-40,76},{-14,76},{-4,76},{-4,66}}, color={0,0,127}));
    connect(u4, temperature_detection.MassFlowRate_HS) annotation (Line(points={{
            40,100},{40,100},{40,76},{4,76},{4,66}}, color={0,0,127}));
    connect(u1, temperature_detection.u1) annotation (Line(points={{80,100},{80,
            100},{80,96},{80,80},{80,80},{80,80},{80,70},{8,70},{8,68},{8,66}},
          color={0,0,127}));
    connect(u2, temperature_detection.u2) annotation (Line(points={{-80,100},{-80,
            100},{-80,70},{-44,70},{-8,70},{-8,66}}, color={0,0,127}));
    annotation (                                 Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
  end Heat_Transfer;

  model Inputs4toOutputs2 "Model with 4 Inputs resulting in 2 Outputs"

    // constants
    parameter Modelica.SIunits.Area A "Heat transfer area";
    parameter Modelica.SIunits.CoefficientOfHeatTransfer k
      "Coefficient of heat transfer";

     //dimensionless key figures based on the "VDI-Wärmeatlas"
     Real R1 "heat capacity ratio";
     Real R2 "heat capacity ratio";
     Real NTU_1 "Number of transfer units";
     Real NTU_2 "Number of transfer units";
     Real P1 "Effectiveness of a counterflow plate heat exchanger";
     Real P2 "Effectiveness of a counterflow plate heat exchanger";

    Modelica.Blocks.Interfaces.RealInput MassFlowRate_DH
      " Mass flow rate in the district heating circuit"               annotation (
       Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-60,100})));
    Modelica.Blocks.Interfaces.RealInput MassFlowRate_HS
      " Mass flow rate in the heating system"                       annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={60,100})));
    Modelica.Blocks.Interfaces.RealOutput P1_Output
      "Effectiveness based on the VDI-Wärmeatlas"  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-100})));
    Modelica.Blocks.Interfaces.RealOutput P2_Output
      "Effectiveness based on the VDI-Wärmeatlas"  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-100})));
    Modelica.Blocks.Interfaces.RealInput C_P_DH
      "Constant specific heat capacity of the district heating medium"
                                             annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-20,100})));
    Modelica.Blocks.Interfaces.RealInput C_P_HS
      "Constant specific heat capacity of the heating system medium"
                                             annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={20,100})));
  equation
      R1= if (C_P_HS == 0 or MassFlowRate_HS == 0) then 0 else (C_P_DH*MassFlowRate_DH)/(C_P_HS*MassFlowRate_HS);
      R2= if (C_P_DH == 0 or MassFlowRate_DH == 0) then 0 else (C_P_HS*MassFlowRate_HS)/(C_P_DH*MassFlowRate_DH);
      NTU_1= if (C_P_DH == 0 or MassFlowRate_DH == 0) then 0 else (k*A)/(C_P_DH*MassFlowRate_DH);
      NTU_2= if (C_P_HS == 0 or MassFlowRate_HS == 0) then 0 else (k*A)/(C_P_HS*MassFlowRate_HS);
       P1 = if R1<>1.0 then (1-exp((R1-1)*NTU_1))/(1-R1*exp((R1-1)*NTU_1)) else NTU_1/(1+NTU_1);
       P2 = if R1<>1.0 then (1-exp((R2-1)*NTU_2))/(1-R2*exp((R2-1)*NTU_2)) else NTU_2/(1+NTU_2);

     P1_Output=P1;
     P2_Output=P2;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),  Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This model determines the dimensionless key figures (for a counterflow heat exchanger) based on the VDI-W&auml;rmeatlas. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>To determine these key figures, the heat transfer area A, the coefficient of heat transfer k, the specific heat capacity c_p and the mass flow rates of the district heating and the heating circuit are needed.</p>
<p>Following equations are used:</p>
<p><br><u>Heat capacity ratio:</u> </p>
<pre>R1=(C_P_DH*MassFlowRate_DH)/(C_P_HS*MassFlowRate_HS)
R2=(C_P_HS*MassFlowRate_HS)/(C_P_DH*MassFlowRate_DH)</pre>
<p><u>Number of transfer units:</u></p>
<pre>NTU_1=(k*A)/(C_P_DH*MassFlowRate_DH)
NTU_2=(k*A)/(C_P_HS*MassFlowRate_HS)

<u>Effectiveness:</u>
If R1=R2:
P1=NTU_1/(1+NTU_1)
P2=NTU_2/(1+NTU_2)
Else:
P1=(1-exp((R1-1)*NTU_1))/(1-R1*exp((R1-1)*NTU_1))
P2=(1-exp((R2-1)*NTU_2))/(1-R2*exp((R2-1)*NTU_2))

The output of this model is P1 and P2.</pre>
<p><br><h4><span style=\"color:#008000\">Known Limitations</span></h4></p>
<p>The mass flow rates of the primary and the secondary circuit must be higher than zero.</p>
<p><br><h4><span style=\"color:#008000\">References</span></h4></p>
<p>The dimensionless key figures are based on the VDI W&auml;rmeatlas (VDI W&auml;rmeatlas, Springer 2006, Kapitel C). <code></p><p></code>See: <a href=\"modelica://Campus/Miscellaneous/SubStation/References/Chapter C.pdf\">SubStation.References.Chapter C</a></p>
<p>For more detailed information see bachelor thesis &QUOT;Modelling and Simulation of a Heat Transfer Station for District Heating Grids&QUOT; by Thomas Dixius. </p>
</html>",
  revisions="<html>
<p><ul>
<li><i>March 2013&nbsp;</i> by Thomas Dixius (supervised by Marcus Fuchs):<br/>implemented</li>
</ul></p>
</html>"));
  end Inputs4toOutputs2;

  model Temperature_detection "Temperature detection for Heat Transfer"
    Modelica.Blocks.Math.Add T_Forward_HS(k1=+1, u1(
        min=253.15,
        max=323.15,
        nominal=278.15)) "y = T_HS_in * y(prod3)" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,-50})));
    Modelica.Blocks.Math.Add T_Return_DH(k1=-1, u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "y = y(prod4) *  T_DH_in" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-50})));
    Modelica.Blocks.Math.Product prod4 "y = Delta_T * P1(effectiveness)"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-16})));
    Modelica.Blocks.Math.Product prod3 "y =P2(effectiveness) * Delta_T"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-16})));
    Modelica.Blocks.Math.Add Delta_T(
      k1=-1,
      u1(
        min=253.15,
        max=323.15,
        nominal=278.15),
      u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "Delta_T = - T_HS_in + T_DH_in" annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=270,
          origin={0,22})));
    HeatPlateExchanger_Package.Inputs4toOutputs2 effectiveness(A=140, k=4000)
      annotation (Placement(transformation(extent={{-10,46},{10,66}})));
    Modelica.Blocks.Interfaces.RealInput u1(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={80,100})));
    Modelica.Blocks.Interfaces.RealInput u2(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-80,100})));
    Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={80,-100})));
    Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-80,-100})));
    Modelica.Blocks.Interfaces.RealInput C_P_DH annotation (Placement(
          transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-20,100})));
    Modelica.Blocks.Interfaces.RealInput C_P_HS annotation (Placement(
          transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={20,100})));
    Modelica.Blocks.Interfaces.RealInput MassFlowRate_DH annotation (Placement(
          transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={-40,100})));
    Modelica.Blocks.Interfaces.RealInput MassFlowRate_HS annotation (Placement(
          transformation(
          rotation=-90,
          extent={{-10,-10},{10,10}},
          origin={40,100})));
  equation
    connect(prod3.y, T_Forward_HS.u2) annotation (Line(points={{40,-27},{74,-27},
            {74,-38}},   color={0,0,127}));
    connect(prod4.y, T_Return_DH.u1) annotation (Line(points={{-40,-27},{-40,-30},
            {-74,-30},{-74,-38}},
                              color={0,0,127}));
    connect(Delta_T.y, prod3.u2) annotation (Line(points={{-2.22045e-015,8.8},{
            -2.22045e-015,4.85},{34,4.85},{34,-4}},
                                color={0,0,127}));
    connect(Delta_T.y, prod4.u1) annotation (Line(points={{-2.22045e-015,8.8},{
            -2.22045e-015,4.85},{-34,4.85},{-34,-4}},
                                 color={0,0,127}));
    connect(effectiveness.P2_Output, prod3.u1) annotation (Line(points={{4,46},{4,
            42},{46,42},{46,-4}},               color={0,0,127}));
    connect(effectiveness.P1_Output, prod4.u2) annotation (Line(points={{-4,46},{
            -4,42},{-46,42},{-46,-4}},             color={0,0,127}));
    connect(u1, Delta_T.u1) annotation (Line(points={{80,100},{80,100},{80,60},{
            20,60},{20,44},{7.2,44},{7.2,36.4}}, color={0,0,127}));
    connect(u2, Delta_T.u2) annotation (Line(points={{-80,100},{-80,100},{-80,60},
            {-20,60},{-20,44},{-7.2,44},{-7.2,40},{-7.2,36.4}}, color={0,0,127}));
    connect(u1, T_Forward_HS.u1) annotation (Line(points={{80,100},{80,60},{86,60},
            {86,-38}}, color={0,0,127}));
    connect(y, T_Forward_HS.y)
      annotation (Line(points={{80,-100},{80,-84},{80,-61}}, color={0,0,127}));
    connect(u2, T_Return_DH.u2) annotation (Line(points={{-80,100},{-80,100},{-80,
            82},{-80,82},{-80,22},{-86,22},{-86,-38}}, color={0,0,127}));
    connect(y1, T_Return_DH.y) annotation (Line(points={{-80,-100},{-80,-82},{-80,
            -61}}, color={0,0,127}));
    connect(C_P_DH, effectiveness.C_P_DH) annotation (Line(points={{-20,100},{-20,
            100},{-20,84},{-2,84},{-2,66},{-2,66}}, color={0,0,127}));
    connect(C_P_HS, effectiveness.C_P_HS) annotation (Line(points={{20,100},{20,
            84},{2,84},{2,66}}, color={0,0,127}));
    connect(MassFlowRate_DH, effectiveness.MassFlowRate_DH) annotation (Line(
          points={{-40,100},{-40,100},{-40,72},{-38,72},{-38,72},{-6,72},{-6,66},
            {-6,66}}, color={0,0,127}));
    connect(MassFlowRate_HS, effectiveness.MassFlowRate_HS) annotation (Line(
          points={{40,100},{40,100},{40,84},{40,72},{6,72},{6,66}}, color={0,0,
            127}));
    annotation (                                 Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
  end Temperature_detection;

  model CP_Fluid "Calculation CP of a Fluid"

    Modelica.Blocks.Math.Add dh_cp(
      k1=+1,
      k2=-1,
      u1(
        min=1,
        max=5000,
        nominal=4000),
      u2(
        min=1,
        max=5000,
        nominal=4000)) "h_out-h_in"
      annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
    Modelica.Blocks.Math.Add dT_cp(
      k1=+1,
      k2=-1,
      u1(
        min=253.15,
        max=323.15,
        nominal=293.15),
      u2(
        min=253.15,
        max=323.15,
        nominal=278.15)) "T_out-T_in"
      annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
    Modelica.Blocks.Math.Division division_cp(
      u1(
        min=-5000,
        max=5000,
        nominal=4000),
      u2(
        min=0.1,
        max=50,
        nominal=20),
      y(min=1,
        max=5000,
        nominal=4000)) "cp = dh/dT"
      annotation (Placement(transformation(extent={{12,-10},{32,10}})));
    Modelica.Blocks.Interfaces.RealInput u1(
      min=253.15,
      max=323.15,
      nominal=293.15) annotation (Placement(transformation(rotation=0, extent={{
              -110,-30},{-90,-10}})));
    Modelica.Blocks.Interfaces.RealInput u2(
      min=253.15,
      max=323.15,
      nominal=278.15) annotation (Placement(transformation(rotation=0, extent={{
              -110,-70},{-90,-50}})));
    Modelica.Blocks.Interfaces.RealInput u3(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{
              -110,50},{-90,70}})));
    Modelica.Blocks.Interfaces.RealInput u4(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{
              -110,10},{-90,30}})));
    Modelica.Blocks.Interfaces.RealOutput y(
      min=1,
      max=5000,
      nominal=4000) annotation (Placement(transformation(rotation=0, extent={{90,
              -10},{110,10}})));
  equation
    connect(u3, dh_cp.u1) annotation (Line(points={{-100,60},{-76,60},{-76,46},
            {-52,46}}, color={0,0,127}));
    connect(u4, dh_cp.u2) annotation (Line(points={{-100,20},{-76,20},{-76,34},
            {-52,34}}, color={0,0,127}));
    connect(u1, dT_cp.u1) annotation (Line(points={{-100,-20},{-78,-20},{-78,
            -34},{-52,-34}}, color={0,0,127}));
    connect(u2, dT_cp.u2) annotation (Line(points={{-100,-60},{-78,-60},{-78,
            -46},{-52,-46}}, color={0,0,127}));
    connect(dT_cp.y, division_cp.u2) annotation (Line(points={{-29,-40},{-10,
            -40},{-10,-6},{10,-6}}, color={0,0,127}));
    connect(dh_cp.y, division_cp.u1) annotation (Line(points={{-29,40},{-10,
            40},{-10,6},{10,6}}, color={0,0,127}));
    connect(division_cp.y, y)
      annotation (Line(points={{33,0},{100,0},{100,0}}, color={0,0,127}));
    annotation (                                 Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
  end CP_Fluid;

  annotation (uses(AixLib(version="0.3.1"), Modelica(version="3.2.2")));
end HeatPlateExchanger_Package;
