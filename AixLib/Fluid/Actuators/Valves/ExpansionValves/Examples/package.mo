within AixLib.Fluid.Actuators.Valves.ExpansionValves;
package Examples "Package that contains example models"
  extends Modelica.Icons.ExamplesPackage;

  model MassFlowRateExpansionPower
    SimpleExpansionValves.IsenthalpicExpansionValve linearValve(
      show_flow_coefficient=true,
      show_staInl=true,
      show_staOut=false,
      useInpFil=false,
      calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
    mFlowNom=0.1,
    AVal=1.15e-6,
    m_flow_nominal=0.1,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula,
    redeclare model FlowCoefficient =
        Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Buck_R22R407CR410A_EEV_16_18,
    dpNom=1000000)
      "Simple isothermal valve"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    Modelica.Blocks.Sources.Ramp ramp(duration=1)
      annotation (Placement(transformation(extent={{-86,48},{-66,68}})));
    Sensors.SpecificEnthalpy senSpeEnt
      annotation (Placement(transformation(extent={{-60,-2},{-40,18}})));
    Modelica.Fluid.Sources.Boundary_ph boundary3(
      nPorts=1,
      use_p_in=false,
      use_h_in=true,
    p=350000,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula)
                annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    p=2900000,
    T=279.15,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula)
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
  equation
    connect(senSpeEnt.port, linearValve.port_a)
      annotation (Line(points={{-50,-2},{-26,-2},{-26,0},{-10,0}},
                                                 color={0,127,255}));
    connect(ramp.y, linearValve.manVarVal) annotation (Line(points={{-65,58},{-30,
            58},{-30,34},{-5,34},{-5,10.6}}, color={0,0,127}));
    connect(linearValve.port_b, boundary3.ports[1])
      annotation (Line(points={{10,0},{50,0}}, color={0,127,255}));
    connect(senSpeEnt.h_out, boundary3.h_in)
      annotation (Line(points={{-39,8},{72,8},{72,4}},   color={0,0,127}));
  connect(boundary.ports[1], senSpeEnt.port)
    annotation (Line(points={{-80,-2},{-50,-2}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end MassFlowRateExpansionPower;

  model MassFlowRateModifiedPower

    Modelica.Blocks.Sources.Ramp ramp(duration=1)
      annotation (Placement(transformation(extent={{-86,48},{-66,68}})));
    Sensors.SpecificEnthalpy senSpeEnt
      annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
    Modelica.Fluid.Sources.Boundary_ph boundary3(
      use_p_in=false,
      use_h_in=true,
    nPorts=1,
    p=350000,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula)
                annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  SimpleExpansionValves.ExpansionValveModified expansionValveModified(
    AVal=1.15e-6,
    redeclare model MetastabilityCoefficient =
        Utilities.MetastabilityCoefficient.SpecifiedMetastabilityCoefficient.Buck_R22R407CR410A_EEV_16_18_meta,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula)
    annotation (Placement(transformation(extent={{-8,-24},{12,-4}})));

  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    p=2900000,
    T=279.15,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula)
    annotation (Placement(transformation(extent={{-112,-28},{-92,-8}})));
  equation
    connect(senSpeEnt.h_out, boundary3.h_in)
      annotation (Line(points={{-29,10},{72,10},{72,4}}, color={0,0,127}));
  connect(senSpeEnt.port, expansionValveModified.port_a) annotation (Line(
        points={{-40,0},{-24,0},{-24,-14},{-8,-14}}, color={0,127,255}));
  connect(expansionValveModified.port_b, boundary3.ports[1]) annotation (Line(
        points={{12,-14},{32,-14},{32,0},{50,0}}, color={0,127,255}));
  connect(ramp.y, expansionValveModified.manVarVal) annotation (Line(points={{
          -65,58},{-42,58},{-42,36},{-3,36},{-3,-3.4}}, color={0,0,127}));
  connect(boundary.ports[1], senSpeEnt.port) annotation (Line(points={{-92,-18},
          {-66,-18},{-66,0},{-40,0}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end MassFlowRateModifiedPower;

annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This package provides models to test the expansion valves provided in
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves</a>
and 
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.ModularExpansionValves\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.ModularExpansionValves</a>.
</p>
</html>"));
end Examples;
