within AixLib.Systems.Benchmark.Model.Generation;
model GeothermalProbe "Geothermal probe"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
    parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.Temperature T_start = 283.15
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization"));
  parameter Integer nParallel=2 "Number of identical parallel pipes";

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        285.15)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));

  Fluid.FixedResistances.PlugFlowPipe pipe[nParallel](
    redeclare package Medium = Medium,
    each m_flow_nominal=m_flow_nominal,
    each T_start_in=T_start,
    each T_start_out=T_start,
    each final v_nominal=1.5,
    each final allowFlowReversal=allowFlowReversal,
    each dh=0.05,
    each dIns=0.001,
    each kIns=0.05,
    each length=100,
    each R=0.001,
    each nPorts=2)           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-30,0})));
  Utilities.HeatTransfer.CylindricHeatTransfer cylindricHeatTransfer[nParallel](
    each rho=2000,
    each d_out=0.1,
    each d_in=0.05,
    each length=50,
    each lambda=2.1,
    each T0=T_start,
    each nParallel=1)
    annotation (Placement(transformation(extent={{-40,28},{-20,48}})));

  Fluid.FixedResistances.PlugFlowPipe pipe1
                                          [nParallel](
    redeclare package Medium = Medium,
    each m_flow_nominal=m_flow_nominal,
    each T_start_in=T_start,
    each T_start_out=T_start,
    each final v_nominal=1.5,
    each final allowFlowReversal=allowFlowReversal,
    each dh=0.05,
    each dIns=0.001,
    each kIns=0.05,
    each length=100,
    each R=0.001,
    each nPorts=1)           annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={30,0})));
  Utilities.HeatTransfer.CylindricHeatTransfer cylindricHeatTransfer1
                                                                    [nParallel](
    each rho=2000,
    each d_out=0.1,
    each d_in=0.05,
    each length=50,
    each lambda=2.1,
    each T0=T_start,
    each nParallel=1)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
equation

  for i in 1:nParallel loop
      connect(fixedTemperature.port, cylindricHeatTransfer[i].port_b)
    annotation (Line(points={{-80,70},{-30,70},{-30,46.8}},
                                                        color={191,0,0}));
     connect(pipe[i].port_a, port_a)
    annotation (Line(points={{-40,1.77636e-15},{-60,1.77636e-15},{-60,0},{-100,0}},
                                                color={0,127,255}));
    connect(pipe[i].ports_b[1], pipe1[i].port_a) annotation (Line(points={{-20,-2},
            {0,-2},{0,1.77636e-15},{20,1.77636e-15}},
                                               color={0,127,255}));
    connect(pipe1[i].ports_b[1], port_b)
      annotation (Line(points={{40,0},{100,0}}, color={0,127,255}));

    connect(cylindricHeatTransfer1[i].port_b, fixedTemperature.port)
      annotation (Line(points={{30,48.8},{30,70},{-80,70}}, color={191,0,0}));
  end for;

  connect(cylindricHeatTransfer.port_a, pipe.heatPort)
    annotation (Line(points={{-30,38},{-30,10}}, color={191,0,0}));
  connect(cylindricHeatTransfer1.port_a, pipe1.heatPort)
    annotation (Line(points={{30,40},{30,10}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-68,76},{72,-84}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-56},{64,-64}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,54},{64,50}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,2},{64,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,76},{-60,-84}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{64,76},{74,-84}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{58,88},{50,-92}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-52,-92},{-44,88}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,-84},{56,-92}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GeothermalProbe;
