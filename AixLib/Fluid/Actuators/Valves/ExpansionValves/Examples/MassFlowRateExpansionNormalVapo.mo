within AixLib.Fluid.Actuators.Valves.ExpansionValves.Examples;
model MassFlowRateExpansionNormalVapo

  Modelica.Blocks.Sources.Ramp ramp(duration=1)
    annotation (Placement(transformation(extent={{-86,48},{-66,68}})));
  Sensors.SpecificEnthalpy senSpeEnt
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Fluid.Sources.Boundary_ph boundary3(
    use_p_in=false,
    use_h_in=true,
    p=350000,
    redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Formula,
    nPorts=1) annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    p=2900000,
    T=279.15,
    redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Formula)
    annotation (Placement(transformation(extent={{-100,-12},{-80,8}})));
  Modelica.Fluid.Valves.ValveVaporizing valveVaporizing(
    redeclare package Medium =
        Media.Refrigerants.R410A_HEoS.R410a_IIR_P1_48_T233_473_Formula,
    m_flow_nominal=0.1,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=1.15e-6,
    dp_nominal=1000000)
    annotation (Placement(transformation(extent={{-10,-14},{10,6}})));
equation
  connect(senSpeEnt.h_out, boundary3.h_in)
    annotation (Line(points={{-29,10},{72,10},{72,4}}, color={0,0,127}));
  connect(boundary.ports[1], senSpeEnt.port) annotation (Line(points={{-80,-2},
          {-60,-2},{-60,0},{-40,0}}, color={0,127,255}));
  connect(senSpeEnt.port, valveVaporizing.port_a) annotation (Line(points={{-40,
          0},{-26,0},{-26,-4},{-10,-4}}, color={0,127,255}));
  connect(valveVaporizing.port_b, boundary3.ports[1]) annotation (Line(points={
          {10,-4},{30,-4},{30,0},{50,0}}, color={0,127,255}));
  connect(ramp.y, valveVaporizing.opening) annotation (Line(points={{-65,58},{
          -26,58},{-26,36},{0,36},{0,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MassFlowRateExpansionNormalVapo;
