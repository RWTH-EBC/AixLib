within AixLib.Fluid.HeatExchangers.ActiveWalls;
model Distributor "Heating circuit distributor for underfloor heating systems"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  //General
  parameter Integer n(min=1) "Number of underfloor heating circuits / registers"
    annotation (Dialog(connectorSizing=true, group="General"));

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="General"));

  parameter Modelica.Units.SI.Time tau=10
    "Time constant at nominal flow (if energyDynamics <> SteadyState)"
    annotation (Dialog(tab="Dynamics", group="Nominal condition"));

  // Assumptions
  parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);

  Modelica.Fluid.Interfaces.FluidPort_a mainFlow(redeclare final package Medium =
               Medium)
    annotation (Placement(transformation(extent={{-70,22},{-50,42}})));

  Modelica.Fluid.Interfaces.FluidPort_b mainReturn(redeclare final package Medium =
               Medium) annotation (Placement(transformation(extent={{-70,-40},{-50,
            -20}}), iconTransformation(extent={{-70,-40},{-50,-20}})));
  MixingVolumes.MixingVolume vol_flow(
    final nPorts=n + 1,
    final m_flow_nominal=m_flow_nominal,
    final V=m_flow_nominal*tau/rho_default,
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start,
    final mSenFac=mSenFac,
    each final C_nominal=C_nominal,
    final allowFlowReversal=allowFlowReversal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,12})));
  MixingVolumes.MixingVolume vol_return(
    final nPorts=n + 1,
    final m_flow_nominal=m_flow_nominal,
    final V=m_flow_nominal*tau/rho_default,
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start,
    final mSenFac=mSenFac,
    each final C_nominal=C_nominal,
    final allowFlowReversal=allowFlowReversal) annotation (Placement(
        transformation(extent={{-10,-20},{10,0}}, rotation=0)));
  Modelica.Fluid.Interfaces.FluidPorts_b flowPorts[n](redeclare each final
      package                                                                      Medium =
                       Medium) annotation (Placement(
      visible=true,
      transformation(
        origin={0,60},
        extent={{-10,-40},{10,40}},
        rotation=90),
      iconTransformation(
        origin={0,60},
        extent={{-6,-24},{6,24}},
        rotation=90)));
  Modelica.Fluid.Interfaces.FluidPorts_a returnPorts[n](redeclare each final
      package                                                                        Medium =
                       Medium) annotation (Placement(
      visible=true,
      transformation(
        origin={0,-60},
        extent={{-10,-40},{10,40}},
        rotation=90),
      iconTransformation(
        origin={0,-62},
        extent={{-6,-24},{6,24}},
        rotation=90)));

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";
equation
  connect(mainFlow, vol_flow.ports[1]) annotation (Line(points={{-60,32},{-46,32},
          {-46,22},{0,22}}, color={255,0,0}));
  connect(mainReturn, vol_return.ports[1]) annotation (Line(points={{-60,-30},{-46,
          -30},{-46,-20},{0,-20}}, color={0,0,255}));

  for k in 1:n loop
    connect(vol_flow.ports[k + 1], flowPorts[k])
      annotation (Line(points={{0,22},{0,60}}, color={255,0,0}));
    connect(vol_return.ports[k + 1], returnPorts[k])
      annotation (Line(points={{0,-20},{0,-60}}, color={0,0,255}));
  end for;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-60,-60},{60,60}})),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-60,-60},{60,60}}),
        graphics={
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-62,-30},{0,-30},{0,-68}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-62,28},{0,28},{0,60}},
          color={238,46,47},
          thickness=1),
        Text(
          extent={{-22,46},{72,36}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="[n] flow"),
        Text(
          extent={{-20,-30},{76,-40}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="[n] return")}),
    Documentation(revisions="<html><ul>
  <li>
    <i>January 11, 2019&#160;</i> by Fabian Wüllhorst:<br/>
    Make model more dynamic (See <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/673\">#673</a>)
  </li>
  <li>
    <i>June 15, 2017&#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>November 06, 2014&#160;</i> by Ana Constantin:<br/>
    Added documentation.
  </li>
</ul>
</html>", info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Model for a contributor for different floor heating circuits in a
  house.
</p>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The contributor is built to connect <span style=
  \"font-family: Courier New;\">n</span> floor heating circuits together.
  The volume is used for nummerical reasons, to have a point where all
  the flows mix together.
</p>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test\">AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test</a>
</p>
</html>"));
end Distributor;
