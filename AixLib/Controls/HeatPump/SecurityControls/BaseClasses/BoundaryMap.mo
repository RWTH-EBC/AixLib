within AixLib.Controls.HeatPump.SecurityControls.BaseClasses;
model BoundaryMap
  "A function yielding true if input parameters are out of the charasteristic map"
  extends BoundaryMapIcon(final iconMin=-70,
  final iconMax=70);
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
    annotation (Placement(transformation(extent={{-52,50},{-32,70}})));
  Modelica.Blocks.Tables.CombiTable1Ds lowCombiTable1Ds(final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    final tableOnFile=false,
    final table=tableLow)
    annotation (Placement(transformation(extent={{-52,16},{-32,36}})));
  Modelica.Blocks.MathBoolean.Nor
                             nor1(
                                 nu=4)
    annotation (Placement(transformation(extent={{44,-10},{64,10}})));
  Modelica.Blocks.Logical.Greater greaterLow
    annotation (Placement(transformation(extent={{-6,16},{14,36}})));
  Modelica.Blocks.Logical.Less lessUpp
    annotation (Placement(transformation(extent={{-6,50},{14,70}})));
  Modelica.Blocks.Logical.Less lessLef
    annotation (Placement(transformation(extent={{-6,-40},{14,-20}})));
  Modelica.Blocks.Logical.Greater greaterRig
    annotation (Placement(transformation(extent={{-6,-70},{14,-50}})));
  Modelica.Blocks.Sources.Constant conXMin(k=xMin)
    annotation (Placement(transformation(extent={{-50,-46},{-38,-34}})));
  Modelica.Blocks.Sources.Constant conXMax(k=xMax)
    annotation (Placement(transformation(extent={{-50,-76},{-38,-64}})));

initial equation
  assert(tableLow_internal[end,1]==tableUpp_internal[end,1],"The boundary values have to be the same. For now the value to the safe operational side has been selected.", level = AssertionLevel.error);
  assert(tableLow_internal[1,1]==tableUpp_internal[1,1],"The boundary values have to be the same. For now the value to the safe operational side has been selected.", level = AssertionLevel.error);

equation
  connect(x_in, uppCombiTable1Ds.u)
    annotation (Line(points={{-114,60},{-54,60}}, color={0,0,127}));
  connect(x_in, lowCombiTable1Ds.u) annotation (Line(points={{-114,60},{-72,60},{-72,26},
          {-54,26}}, color={0,0,127}));
  connect(nor1.y, noErr)
    annotation (Line(points={{65.5,0},{110,0}}, color={255,0,255}));
  connect(y_in, greaterLow.u2) annotation (Line(points={{-114,-60},{-20,-60},{-20,18},
          {-8,18}}, color={0,0,127}));
  connect(lowCombiTable1Ds.y[1], greaterLow.u1)
    annotation (Line(points={{-31,26},{-8,26}}, color={0,0,127}));
  connect(y_in, lessUpp.u2) annotation (Line(points={{-114,-60},{-22,-60},{-22,52},{-8,
          52}}, color={0,0,127}));
  connect(uppCombiTable1Ds.y[1], lessUpp.u1)
    annotation (Line(points={{-31,60},{-8,60}}, color={0,0,127}));
  connect(lessUpp.y, nor1.u[1]) annotation (Line(points={{15,60},{32,60},{32,5.25},
          {44,5.25}}, color={255,0,255}));
  connect(greaterLow.y, nor1.u[2]) annotation (Line(points={{15,26},{32,26},{32,
          1.75},{44,1.75}}, color={255,0,255}));
  connect(lessLef.y, nor1.u[3]) annotation (Line(points={{15,-30},{32,-30},{32,
          -1.75},{44,-1.75}}, color={255,0,255}));
  connect(greaterRig.y, nor1.u[4]) annotation (Line(points={{15,-60},{32,-60},
          {32,-5.25},{44,-5.25}}, color={255,0,255}));
  connect(x_in, lessLef.u1) annotation (Line(points={{-114,60},{-72,60},{-72,-30},{-8,
          -30}}, color={0,0,127}));
  connect(x_in, greaterRig.u1) annotation (Line(points={{-114,60},{-72,60},{-72,-60},
          {-8,-60}}, color={0,0,127}));
  connect(conXMax.y, greaterRig.u2) annotation (Line(points={{-37.4,-70},{-22,-70},{-22,
          -68},{-8,-68}}, color={0,0,127}));
  connect(conXMin.y, lessLef.u2) annotation (Line(points={{-37.4,-40},{-24,-40},{-24,
          -38},{-8,-38}}, color={0,0,127}));
  annotation (Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>Given an input of the x and y-Axis, the block returns true if the given point is outside of the given envelope.</p><p>The maximal and minmal y-value depend on the x-Value and are defined by the upper and lower boundaries in form of 1Ds-Tables. The maximal and minimal x-values are obtained trough the table and are constant.</p>
</html>"));
end BoundaryMap;
