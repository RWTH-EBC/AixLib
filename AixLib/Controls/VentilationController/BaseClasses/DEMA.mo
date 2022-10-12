within AixLib.Controls.VentilationController.BaseClasses;
block DEMA "double exponential moving average"
  extends Modelica.Blocks.Interfaces.SIMO(nout=2);

protected
  Modelica.Blocks.Continuous.CriticalDamping ExpAVG(
    n=1,
    x_start=fill(ystart, ExpAVG.n),
    f=1/(Modelica.Constants.pi*period),
    normalized=false,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=ystart)
             annotation (Placement(transformation(extent={{-80,-10},{-60,
            10}}, rotation=0)));
  Modelica.Blocks.Discrete.Sampler sampler(samplePeriod=sampleTime)
    annotation (Placement(transformation(extent={{60,-10},{80,10}},
          rotation=0)));
public
  parameter Modelica.Units.SI.Time period=86400*4;
  parameter Modelica.Units.SI.Time sampleTime=86400;
  parameter Real ystart=279.15 "Start value of EMA";
protected
  Modelica.Blocks.Continuous.CriticalDamping ExpAVG1(
    n=1,
    x_start=fill(ystart, ExpAVG.n),
    f=1/(Modelica.Constants.pi*period),
    normalized=false,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=ystart)
             annotation (Placement(transformation(extent={{-40,-50},{-20,
            -30}}, rotation=0)));
  Modelica.Blocks.Math.Gain gain(k=2) annotation (Placement(
        transformation(extent={{-40,-10},{-20,10}}, rotation=0)));
public
  Modelica.Blocks.Math.Feedback DEMAcont
    "continous double exponential moving average"
    annotation (Placement(transformation(extent={{0,-10},{20,10}},
          rotation=0)));
equation
  connect(u, ExpAVG.u) annotation (Line(points={{-120,0},{-82,0}}, color=
          {0,0,127}));
  connect(sampler.y, y[1]) annotation (Line(points={{81,0},{95.5,0},{95.5,
          -5},{110,-5}}, color={0,0,127}));
  connect(ExpAVG.y, gain.u) annotation (Line(points={{-59,0},{-42,0}},
        color={0,0,127}));
  connect(ExpAVG.y, ExpAVG1.u) annotation (Line(points={{-59,0},{-50,0},{
          -50,-40},{-42,-40}}, color={0,0,127}));
  connect(gain.y, DEMAcont.u1)
    annotation (Line(points={{-19,0},{2,0}}, color={0,0,127}));
  connect(ExpAVG1.y, DEMAcont.u2) annotation (Line(points={{-19,-40},{10,
          -40},{10,-8}}, color={0,0,127}));
  connect(DEMAcont.y, sampler.u)
    annotation (Line(points={{19,0},{58,0}}, color={0,0,127}));
  connect(DEMAcont.y, y[2]) annotation (Line(points={{19,0},{32,0},{32,
          -18},{110,-18},{110,5}}, color={0,0,127}));
  annotation (Diagram(graphics), Documentation(revisions="<html><ul>
  <li>
    <i>April, 2016&#160;</i> by Peter Remmen:<br/>
    Moved from Utilities to Controls
  </li>
</ul>
<ul>
  <li>
    <i>October, 2015&#160;</i> by Moritz Lauster:<br/>
    Adapted and moved to AixLib
  </li>
</ul>
</html>"));
end DEMA;
