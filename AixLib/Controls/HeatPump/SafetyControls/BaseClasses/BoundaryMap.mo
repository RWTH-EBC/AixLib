within AixLib.Controls.HeatPump.SafetyControls.BaseClasses;
block BoundaryMap
  "Block which returns false if the input parameters are out of the given charasteristic map.
For the boundaries of the y-input value, a dynamic hysteresis is used to ensure a used device will stay off a certain time after shutdown."
  extends AixLib.Controls.HeatPump.SafetyControls.BaseClasses.BoundaryMapIcon(
     final iconMin=-70, final iconMax=70);
  parameter Real dx = 1 "Delta value used for both upper and lower hysteresis. Used to avoid state-events when used as a safety control.";
  Modelica.Blocks.Interfaces.BooleanOutput noErr
    "If an error occurs, this will be false"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput x_in "Current value of x-Axis"
    annotation (Placement(transformation(extent={{-128,46},{-100,74}})));
  Modelica.Blocks.Interfaces.RealInput y_in "Current value on y-Axis"
    annotation (Placement(transformation(extent={{-128,-74},{-100,-46}})));

  Modelica.Blocks.Tables.CombiTable1Ds uppCombiTable1Ds(final table=tableUpp, smoothness=
        Modelica.Blocks.Types.Smoothness.LinearSegments,
    final tableOnFile=false)
    annotation (Placement(transformation(extent={{-48,68},{-28,88}})));
  Modelica.Blocks.MathBoolean.Nor
                             nor1(
                                 nu=3)
    annotation (Placement(transformation(extent={{72,-10},{92,10}})));
  AixLib.Utilities.Logical.DynamicHysteresis lessUpp(final pre_y_start=false)
    annotation (Placement(transformation(extent={{30,68},{50,88}})));
  Modelica.Blocks.Logical.Less lessLef
    annotation (Placement(transformation(extent={{26,-40},{46,-20}})));
  Modelica.Blocks.Logical.Greater greaterRig
    annotation (Placement(transformation(extent={{26,-70},{46,-50}})));
  Modelica.Blocks.Sources.Constant conXMin(k=xMin)
    annotation (Placement(transformation(extent={{-50,-46},{-38,-34}})));
  Modelica.Blocks.Sources.Constant conXMax(k=xMax)
    annotation (Placement(transformation(extent={{-50,-76},{-38,-64}})));

  Modelica.Blocks.Math.Add addUpp(final k2=-1)
    annotation (Placement(transformation(extent={{-18,56},{-8,66}})));
  Modelica.Blocks.Sources.Constant constDx(final k=dx)
    annotation (Placement(transformation(extent={{-50,46},{-36,60}})));

equation
  connect(x_in, uppCombiTable1Ds.u)
    annotation (Line(points={{-114,60},{-84,60},{-84,78},{-50,78}},
                                                  color={0,0,127}));
  connect(nor1.y, noErr)
    annotation (Line(points={{93.5,0},{110,0}}, color={255,0,255}));
  connect(lessUpp.y, nor1.u[1]) annotation (Line(points={{51,78},{64,78},{64,4.66667},
          {72,4.66667}},
                      color={255,0,255}));
  connect(lessLef.y, nor1.u[2]) annotation (Line(points={{47,-30},{64,-30},{64,2.22045e-16},
          {72,2.22045e-16}},  color={255,0,255}));
  connect(greaterRig.y, nor1.u[3]) annotation (Line(points={{47,-60},{64,-60},{64,
          -4.66667},{72,-4.66667}},
                                  color={255,0,255}));
  connect(x_in, lessLef.u1) annotation (Line(points={{-114,60},{-72,60},{-72,-30},
          {24,-30}},
                 color={0,0,127}));
  connect(x_in, greaterRig.u1) annotation (Line(points={{-114,60},{-72,60},{-72,
          -60},{24,-60}},
                     color={0,0,127}));
  connect(conXMax.y, greaterRig.u2) annotation (Line(points={{-37.4,-70},{-22,-70},
          {-22,-68},{24,-68}},
                          color={0,0,127}));
  connect(conXMin.y, lessLef.u2) annotation (Line(points={{-37.4,-40},{-24,-40},
          {-24,-38},{24,-38}},
                          color={0,0,127}));
  connect(y_in, lessUpp.u) annotation (Line(points={{-114,-60},{-114,-60},{-94,-60},
          {-94,-60},{-90,-60},{-90,100},{16,100},{16,78},{16,78},{16,78},{28,78},
          {28,78}},color={0,0,127}));
  connect(uppCombiTable1Ds.y[1], lessUpp.uHigh) annotation (Line(points={{-27,78},
          {6,78},{6,60},{43,60},{43,66}}, color={0,0,127}));
  connect(lessUpp.uLow, addUpp.y) annotation (Line(points={{35,66},{32,66},{32,61},
          {-7.5,61}}, color={0,0,127}));
  connect(uppCombiTable1Ds.y[1], addUpp.u1) annotation (Line(points={{-27,78},{-24,
          78},{-24,64},{-19,64}}, color={0,0,127}));
  connect(addUpp.u2, constDx.y) annotation (Line(points={{-19,58},{-26,58},{-26,
          53},{-35.3,53}}, color={0,0,127}));
  annotation (Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html><p>
  Given an input of the x and y-Axis, the block returns true if the
  given point is outside of the given envelope.
</p>
<p>
  The maximal and minmal y-value depend on the x-Value and are defined
  by the upper and lower boundaries in form of 1Ds-Tables. The maximal
  and minimal x-values are obtained trough the table and are constant.
</p>
<ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"),
      uses(AixLib(version="0.7.3"), Modelica(version="3.2.2")));
end BoundaryMap;
