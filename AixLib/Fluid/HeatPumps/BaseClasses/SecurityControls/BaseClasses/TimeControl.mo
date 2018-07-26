within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls.BaseClasses;
block TimeControl
  "Counts seconds a device is turned on and returns true if the time is inside given boundaries"
  extends Modelica.Blocks.Interfaces.BooleanSISO;
  Modelica.Blocks.Logical.Timer RunTim
    "counts the seconds the heat pump is locled still"
    annotation (Placement(transformation(extent={{-24,6},{-8,22}})));
  Modelica.Blocks.Sources.Constant inputLocTime(final k=minRunTime)
    "Mimimum lock time of heat pump"
    annotation (Placement(transformation(extent={{-24,-26},{-8,-10}})));
  Modelica.Blocks.Logical.GreaterEqual LocGreaterMin
    annotation (Placement(transformation(extent={{22,-8},{36,8}})));
  parameter Modelica.SIunits.Time minRunTime
    "Minimal time the device is turned on or off";
  Modelica.Blocks.Interfaces.RealOutput
             y1
               "Connector of Real output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
equation
  connect(inputLocTime.y,LocGreaterMin. u2) annotation (Line(points={{-7.2,
          -18},{4,-18},{4,-6.4},{20.6,-6.4}},
                                          color={0,0,127}));
  connect(RunTim.y,LocGreaterMin. u1) annotation (Line(points={{-7.2,14},{4,
          14},{4,0},{20.6,0}},  color={0,0,127}));
  connect(LocGreaterMin.y, y)
    annotation (Line(points={{36.7,0},{110,0}}, color={255,0,255}));
  connect(u, RunTim.u) annotation (Line(points={{-120,0},{-32,0},{-32,14},{
          -25.6,14}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={160,160,164}),
        Line(points={{0,80},{0,60}}, color={160,160,164}),
        Line(points={{80,0},{60,0}}, color={160,160,164}),
        Line(points={{0,-80},{0,-60}}, color={160,160,164}),
        Line(points={{-80,0},{-60,0}}, color={160,160,164}),
        Line(points={{37,70},{26,50}}, color={160,160,164}),
        Line(points={{70,38},{49,26}}, color={160,160,164}),
        Line(points={{71,-37},{52,-27}}, color={160,160,164}),
        Line(points={{39,-70},{29,-51}}, color={160,160,164}),
        Line(points={{-39,-70},{-29,-52}}, color={160,160,164}),
        Line(points={{-71,-37},{-50,-26}}, color={160,160,164}),
        Line(points={{-71,37},{-54,28}}, color={160,160,164}),
        Line(points={{-38,70},{-28,51}}, color={160,160,164}),
        Line(
          points={{0,0},{-50,50}},
          thickness=0.5),
        Line(
          points={{0,0},{40,0}},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>When the input is true, a timer thats counting seconds until it is false again. As long as the counted time is smaller than a given minimal time, the block yields false.</p><p>This block is used to validate a mimimal run- or loctime of a device.</p>
</html>"));
end TimeControl;
