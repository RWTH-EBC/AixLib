within AixLib.Fluid.Storage.BaseClasses;
model HeatingCoil "Heating coil for heat storage model"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

 parameter Integer disHC = 2 "Number of elements for heating coil discretization";

  parameter Modelica.Units.SI.Length lengthHC=3 "Length of Pipe for HC";

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConHC=20
    "Model assumptions heat transfer coefficient HC <-> Heating Water";

  parameter Modelica.Units.SI.Temperature TStart=298.15
    "Start Temperature of fluid" annotation (Dialog(group="Initialization"));

 parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeHC=
      AixLib.DataBase.Pipes.Copper.Copper_28x1() "Type of Pipe for HC";

  AixLib.Utilities.HeatTransfer.HeatConv convHC1Outside[disHC](each final hCon=hConHC, each final A=pipeHC.d_o*Modelica.Constants.pi*lengthHC/disHC)
                "Outer heat convection"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={1.77636e-15,52})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm1[disHC]
    "Vectorized heat port"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  FixedResistances.PlugFlowPipe pipe[disHC](
    redeclare each final package Medium = Medium,
    each final allowFlowReversal=allowFlowReversal,
    each final dh=pipeHC.d_i,
    each final v_nominal=4*m_flow_nominal/den_default/pipeHC.d_i/pipeHC.d_i/Modelica.Constants.pi,
    each final length=lengthHC/disHC,
    each final m_flow_nominal=m_flow_nominal,
    each final m_flow_small=m_flow_small,
    each final dIns=0.5*(pipeHC.d_o - pipeHC.d_i),
    each final kIns=pipeHC.lambda,
    each final cPip=pipeHC.c,
    each final rhoPip=pipeHC.d,
    each final thickness=0.5*(pipeHC.d_o - pipeHC.d_i),
    each final T_start_in=TStart,
    each final T_start_out=TStart,
    each final nPorts=1) annotation (Placement(transformation(extent={{-16,-16},{16,16}})));

protected
  parameter Medium.ThermodynamicState sta_default=
     Medium.setState_pTX(T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
  parameter Modelica.Units.SI.Density den_default=Medium.density(sta_default)
    "Density of Medium in default state";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
      Medium.heatCapacity_cp(sta_default)
    "Specific heat capacity of Medium in default state";

equation


  connect(convHC1Outside.port_a, Therm1) annotation (Line(
      points={{3.9968e-15,64},{3.9968e-15,100},{0,100}},
      color={191,0,0},
      smooth=Smooth.None));


  connect(convHC1Outside.port_b, pipe.heatPort) annotation (Line(points={{0,40},{0,16}}, color={191,0,0}));
  connect(port_a, pipe[1].port_a) annotation (Line(
      points={{-100,0},{-16,0}},
      color={0,127,255},
      pattern=LinePattern.DashDotDot));
  for i in 1:disHC-1 loop
    connect(pipe[i].ports_b[1], pipe[i + 1].port_a) annotation (Line(
        points={{16,0},{28,0},{28,26},{-28,26},{-28,0},{-16,0}},
        color={0,127,255},
        pattern=LinePattern.DashDotDot));
  end for;
  connect(pipe[disHC].ports_b[1], port_b) annotation (Line(
      points={{16,0},{100,0}},
      color={0,127,255},
      pattern=LinePattern.DashDotDot));

  annotation (                   Icon(graphics={
        Line(
          points={{-94,0},{-80,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-60,-80},{-80,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-10,-80},{10,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1,
          origin={-50,0},
          rotation=180),
        Line(
          points={{-10,-80},{10,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1,
          origin={-10,0},
          rotation=180),
        Line(
          points={{-20,-80},{-40,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-10,-80},{10,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1,
          origin={30,0},
          rotation=180),
        Line(
          points={{20,-80},{0,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-10,-80},{10,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1,
          origin={70,0},
          rotation=180),
        Line(
          points={{60,-80},{40,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{94,0},{80,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1)}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model of a heating coil to heat a fluid (e.g. water) by a given input
  on the heat port.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The heating coil is implemented as a pipe which is going through the
  storage tank. The heat transfer to the storage tank is modelled with
  a heat transfer coefficient.
</p>
</html>",
      revisions="<html><ul>
  <li>January 24, 2020 by Philipp Mehrfeld:<br/>
    <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/793\">#793</a> Use
    AixLib PlugFlowPipe instead of MSL pipe to use the IBPSA fluid
    core.
  </li>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add comments and fix documentation
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Sebastian Stinner:<br/>
    Added to AixLib
  </li>
  <li>
    <i>March 25, 2015&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL
  </li>
  <li>
    <i>October 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>
"));
end HeatingCoil;
