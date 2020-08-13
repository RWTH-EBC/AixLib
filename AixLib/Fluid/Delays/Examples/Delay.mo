within AixLib.Fluid.Delays.Examples;
model Delay
  extends Modelica.Icons.Example;
// We set X_default to a small enough value to avoid saturation at the medium temperature
// that is used in this model.
 package Medium = AixLib.Media.Air(X_default={0.001, 0.999});
   final parameter Modelica.SIunits.Volume V_Water = vol.m_flow_nominal * tau / rho_default "Water Volume in Tube";
  final parameter Modelica.SIunits.Time tau = 120 "Time constant to heat up the medium";

    Modelica.Blocks.Sources.Constant PAtm(k=101325)
      annotation (Placement(transformation(extent={{62,36},{82,56}})));
    Modelica.Blocks.Sources.Ramp P(
      duration=1,
    height=20,
    offset=101315)
                 annotation (Placement(transformation(extent={{-94,30},{-74,50}})));
  AixLib.Fluid.FixedResistances.PressureDrop res1(
    from_dp=true,
    m_flow_nominal=5,
    dp_nominal=5,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-30,-4},{-10,16}})));
  AixLib.Fluid.Sources.Boundary_pT sou(
                          redeclare package Medium = Medium,
    use_p_in=true,
    nPorts=1,
    T=293.15)             annotation (Placement(transformation(extent={{-58,-4},
            {-38,16}})));
  AixLib.Fluid.Sources.Boundary_pT sin(
                          redeclare package Medium = Medium,
    use_p_in=true,
    nPorts=1,
    T=283.15)             annotation (Placement(transformation(extent={{78,-4},
            {58,16}})));
  AixLib.Fluid.FixedResistances.PressureDrop res2(
    from_dp=true,
    m_flow_nominal=5,
    dp_nominal=5,
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{26,-4},{46,16}})));

  MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    nPorts=2,
    V=V_Water,
    m_flow_nominal=5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{0,10},{18,28}})));

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.SIunits.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";
equation
  connect(P.y, sou.p_in) annotation (Line(points={{-73,40},{-66,40},{-66,14},{
          -60,14}}, color={0,0,127}));
  connect(PAtm.y, sin.p_in) annotation (Line(points={{83,46},{90,46},{90,14},{
          80,14}}, color={0,0,127}));
  connect(sou.ports[1], res1.port_a) annotation (Line(
      points={{-38,6},{-36,6},{-36,6},{-34,6},{-34,6},{-30,6}},
      color={0,127,255}));
  connect(sin.ports[1], res2.port_b) annotation (Line(
      points={{58,6},{55,6},{55,6},{52,6},{52,6},{46,6}},
      color={0,127,255}));
  connect(res1.port_b, vol.ports[1])
    annotation (Line(points={{-10,6},{7.2,6},{7.2,10}}, color={0,127,255}));
  connect(vol.ports[2], res2.port_a) annotation (Line(points={{10.8,10},{10,10},
          {10,6},{26,6}}, color={0,127,255}));
    annotation (experiment(Tolerance=1e-6, StopTime=300),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Delays/Examples/Delay.mos"
        "Simulate and plot"));
end Delay;
