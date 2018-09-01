within AixLib.Fluid.Actuators.Valves.ExpansionValves.Examples;
model MassFlowRateExpansionNormal
  SimpleExpansionValves.IsenthalpicExpansionValve linearValve(
    show_flow_coefficient=true,
    show_staInl=true,
    show_staOut=false,
    useInpFil=false,
    redeclare model FlowCoefficient =
        Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Power_R134a_EEV_15,
    AVal=1.15e-6,
    calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.linear,
    redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Formula,
    dpNom=1000000)
    "Simple isothermal valve"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Blocks.Sources.Ramp ramp(duration=1)
    annotation (Placement(transformation(extent={{-86,48},{-66,68}})));
  Sensors.SpecificEnthalpy senSpeEnt
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Fluid.Sources.Boundary_ph boundary3(
    nPorts=1,
    use_p_in=false,
    use_h_in=true,
    p=350000,
    redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Formula)
              annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    p=2900000,
    T=279.15,
    redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Formula)
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
equation
  connect(senSpeEnt.port, linearValve.port_a)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
  connect(ramp.y, linearValve.manVarVal) annotation (Line(points={{-65,58},{-30,
          58},{-30,34},{-5,34},{-5,10.6}}, color={0,0,127}));
  connect(linearValve.port_b, boundary3.ports[1])
    annotation (Line(points={{10,0},{50,0}}, color={0,127,255}));
  connect(senSpeEnt.h_out, boundary3.h_in)
    annotation (Line(points={{-29,10},{72,10},{72,4}}, color={0,0,127}));
  connect(boundary.ports[1], senSpeEnt.port) annotation (Line(points={{-80,-2},
          {-60,-2},{-60,0},{-40,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MassFlowRateExpansionNormal;
