within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
model PumpCircuit
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(allowFlowReversal=
      false, final m_flow_nominal = m_flow_total);
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));
  parameter Modelica.Units.SI.MassFlowRate m_flow_total;
  final parameter Modelica.Units.SI.VolumeFlowRate Vflow_nom=m_flow_total/
      rho_default;
  parameter Modelica.Units.SI.PressureDifference dp_nom;
  parameter Modelica.Units.SI.Volume V_Water;
  Movers.SpeedControlled_y pump(
    redeclare package Medium = Medium,
    per(pressure(V_flow={0,Vflow_nom,Vflow_nom/0.7}, dp={dp_nom/0.7,dp_nom,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
                                                      prescribedTemperature
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-38,20})));
  Modelica.Blocks.Interfaces.RealInput y(final unit="1")
    "controlled normalized speed" annotation (Placement(transformation(extent={{-12,-12},
            {12,12}},
        rotation=270,
        origin={0,44}),          iconTransformation(extent={{-8,-8},{8,8}},
        rotation=270,
        origin={0,38})));
  Modelica.Blocks.Interfaces.RealInput T(final unit="K")
      "controlled normalized speed" annotation (Placement(transformation(extent={{-12,-12},
            {12,12}},
        rotation=270,
        origin={-20,44}),         iconTransformation(extent={{-8,-8},{8,8}},
        rotation=270,
        origin={-20,38})));
  MixingVolumes.MixingVolume              vol(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    mSenFac=mSenFac,
    allowFlowReversal=false,
    V=V_Water,
    nPorts=2,
    m_flow_nominal=m_flow_total)
    annotation (Placement(transformation(extent={{-70,0},{-54,16}})));

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";

equation
  connect(y, pump.y) annotation (Line(points={{0,44},{0,12},{-2,12}},
                   color={0,0,127}));
  connect(T, prescribedTemperature.T)
    annotation (Line(points={{-20,44},{-20,20},{-30.8,20}},
                                                     color={0,0,127}));
  connect(pump.port_b, port_b)
    annotation (Line(points={{8,0},{100,0}},  color={0,127,255}));
  connect(port_a, vol.ports[1])
    annotation (Line(points={{-100,0},{-63.6,0}}, color={0,127,255}));
  connect(vol.ports[2], pump.port_a)
    annotation (Line(points={{-60.4,0},{-12,0}}, color={0,127,255}));
  connect(prescribedTemperature.port, vol.heatPort) annotation (Line(points={{-44,
          20},{-80,20},{-80,8},{-70,8}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},
            {100,40}}),graphics={
        Rectangle(
          extent={{-32,4},{30,-6}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-22,22},{22,-22}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{0,20},{0,-20},{18,0},{0,20}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{2,6},{12,-4}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          visible=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState,
          fillColor={0,100,199}),
        Text(
          extent={{6,56},{18,30}},
          lineColor={28,108,200},
          textString="y
"),     Text(
          extent={{-36,52},{-26,40}},
          lineColor={28,108,200},
          textString="T"),
        Line(
          points={{-90,0},{-32,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{30,0},{90,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{0,30},{0,22}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-20,30},{-20,10}},
          color={238,46,47},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,40}})));
end PumpCircuit;
