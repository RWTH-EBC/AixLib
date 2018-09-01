within AixLib.Fluid.Actuators.Valves.ExpansionValves.Examples;
model MassFlowRateModifiedPoly
  Modelica.Blocks.Sources.Ramp ramp(duration=1)
    annotation (Placement(transformation(extent={{-86,48},{-66,68}})));
  Sensors.SpecificEnthalpy senSpeEnt
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Fluid.Sources.Boundary_ph boundary3(
    use_p_in=false,
    use_h_in=true,
    p=350000,
    nPorts=1,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Formula)
              annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  SimpleExpansionValves.ExpansionValveModified expansionValveModified(
    AVal=1.15e-6,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Formula,
    redeclare model MetastabilityCoefficient =
        Utilities.MetastabilityCoefficient.SpecifiedMetastabilityCoefficient.Poly_R410A_16_18_pth)
    annotation (Placement(transformation(extent={{-10,-16},{10,4}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    p=2900000,
    T=279.15,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Formula)
    annotation (Placement(transformation(extent={{-98,-10},{-78,10}})));
equation
  connect(senSpeEnt.h_out, boundary3.h_in)
    annotation (Line(points={{-29,10},{72,10},{72,4}}, color={0,0,127}));
  connect(senSpeEnt.port, expansionValveModified.port_a) annotation (Line(
        points={{-40,0},{-26,0},{-26,-6},{-10,-6}}, color={0,127,255}));
  connect(expansionValveModified.port_b, boundary3.ports[1]) annotation (Line(
        points={{10,-6},{30,-6},{30,0},{50,0}}, color={0,127,255}));
  connect(ramp.y, expansionValveModified.manVarVal)
    annotation (Line(points={{-65,58},{-5,58},{-5,4.6}}, color={0,0,127}));
  connect(boundary.ports[1], senSpeEnt.port)
    annotation (Line(points={{-78,0},{-40,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MassFlowRateModifiedPoly;
