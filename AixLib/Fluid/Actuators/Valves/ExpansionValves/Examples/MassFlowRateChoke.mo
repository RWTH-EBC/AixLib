within AixLib.Fluid.Actuators.Valves.ExpansionValves.Examples;
model MassFlowRateChoke
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
  SimpleExpansionValves.ExpansionValveChoke expansionValveChoke(
    AVal=1.15e-6,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Formula,
    redeclare model FlowCoefficient =
        Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R410a_EEV_18,
    Choice=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.Choice.ExpansionValveChoke)
    annotation (Placement(transformation(extent={{-10,-24},{10,-4}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_340_Formula,
    p=2900000,
    T=279.15)
    annotation (Placement(transformation(extent={{-110,-22},{-90,-2}})));
equation
  connect(senSpeEnt.h_out, boundary3.h_in)
    annotation (Line(points={{-29,10},{72,10},{72,4}}, color={0,0,127}));
  connect(senSpeEnt.port, expansionValveChoke.port_a) annotation (Line(points={
          {-40,0},{-24,0},{-24,-14},{-10,-14}}, color={0,127,255}));
  connect(expansionValveChoke.port_b, boundary3.ports[1]) annotation (Line(
        points={{10,-14},{30,-14},{30,0},{50,0}}, color={0,127,255}));
  connect(ramp.y, expansionValveChoke.manVarVal)
    annotation (Line(points={{-65,58},{-5,58},{-5,-3.4}}, color={0,0,127}));
  connect(boundary.ports[1], senSpeEnt.port) annotation (Line(points={{-90,-12},
          {-66,-12},{-66,0},{-40,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MassFlowRateChoke;
