within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
model Distributor
  "Heating circuit distributor for underfloor heating systems"
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

  Modelica.Fluid.Interfaces.FluidPort_a portMaiSup(redeclare final package
      Medium = Medium) "Main supply port" annotation (Placement(transformation(
          extent={{-70,-10},{-50,10}}), iconTransformation(extent={{-70,-10},{-50,
            10}})));

  Modelica.Fluid.Interfaces.FluidPort_b portMaiRet(redeclare final package
      Medium = Medium) "Main return port"
                       annotation (Placement(transformation(extent={{50,-10},
            {70,10}}),
                    iconTransformation(extent={{50,-10},{70,10}})));
  AixLib.Fluid.MixingVolumes.MixingVolume volSup(
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
    final allowFlowReversal=allowFlowReversal,
    final nPorts=n + 1) "Volume for supply" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,30})));
  AixLib.Fluid.MixingVolumes.MixingVolume volRet(
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
    final allowFlowReversal=allowFlowReversal,
    final nPorts=n + 1) "Volume for return flow" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-30})));
  Modelica.Fluid.Interfaces.FluidPorts_b portsCirSup[n](redeclare each final
      package Medium = Medium) "Supply ports to circuits" annotation (Placement(
      visible=true,
      transformation(
        origin={0,60},
        extent={{-10,-40},{10,40}},
        rotation=90),
      iconTransformation(
        origin={-8,60},
        extent={{-6,-24},{6,24}},
        rotation=90)));
  Modelica.Fluid.Interfaces.FluidPorts_a portsCirRet[n](redeclare each final
      package Medium = Medium) "Return ports from circuits" annotation (
      Placement(
      visible=true,
      transformation(
        origin={0,-60},
        extent={{-10,-40},{10,40}},
        rotation=90),
      iconTransformation(
        origin={8,-62},
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

  for k in 1:n loop
    connect(volSup.ports[k + 1], portsCirSup[k])
      annotation (Line(points={{20,30},{0,30},{0,60}}, color={255,0,0}));
    connect(volRet.ports[k + 1], portsCirRet[k])
      annotation (Line(points={{-20,-30},{0,-30},{0,-60}}, color={0,0,255}));
  end for;

  connect(portMaiSup, volSup.ports[1]) annotation (Line(points={{-60,0},{-10,0},
          {-10,30},{20,30}}, color={0,127,255}));
  connect(volRet.ports[1], portMaiRet) annotation (Line(points={{-20,-30},{10,-30},
          {10,0},{60,0}}, color={0,127,255}));
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
          points={{50,0},{8,0},{8,-68}},
          color={0,0,255},
          thickness=1),
        Line(
          points={{-68,0},{-8,0},{-8,60}},
          color={238,46,47},
          thickness=1),
        Text(
          extent={{-78,18},{16,8}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="[n] flow"),
        Text(
          extent={{-18,-10},{78,-20}},
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
