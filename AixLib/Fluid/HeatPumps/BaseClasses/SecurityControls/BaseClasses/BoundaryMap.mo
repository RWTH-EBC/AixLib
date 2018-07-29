within AixLib.Fluid.HeatPumps.BaseClasses.SecurityControls.BaseClasses;
block BoundaryMap
  "A function yielding true if input parameters are out of the charasteristic map"
  Modelica.Blocks.Interfaces.BooleanOutput ERR
    "If an error occurs, this will be false"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput x_in "Current value of x-Axis"
    annotation (Placement(transformation(extent={{-128,46},{-100,74}})));
  Modelica.Blocks.Interfaces.RealInput y_in "Current value on y-Axis"
    annotation (Placement(transformation(extent={{-128,-74},{-100,-46}})));

  Modelica.Blocks.Tables.CombiTable1Ds uppCombiTable1Ds(final table=tableUpp, smoothness=
        Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{-52,50},{-32,70}})));
  Modelica.Blocks.Tables.CombiTable1Ds lowCombiTable1Ds(final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      table=tableLow)
    annotation (Placement(transformation(extent={{-52,16},{-32,36}})));
  Modelica.Blocks.MathBoolean.Or
                             or1(nu=4)
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  Modelica.Blocks.Logical.Greater greaterLow
    annotation (Placement(transformation(extent={{-6,16},{14,36}})));
  Modelica.Blocks.Logical.Less lessUpp
    annotation (Placement(transformation(extent={{-6,50},{14,70}})));
  Modelica.Blocks.Logical.Less lessLef
    annotation (Placement(transformation(extent={{-6,-40},{14,-20}})));
  Modelica.Blocks.Logical.Greater greaterRig
    annotation (Placement(transformation(extent={{-6,-70},{14,-50}})));
  parameter Real v2 = {1000,1000};
  parameter Real v1 = {-10,-10};
  parameter Real tableLow[:,2]=fill(
      0.0,
      0,
      2) "Table matrix (grid = first column; e.g., table=[0,2])";
  parameter Real tableUpp[:,2]=fill(
      0.0,
      0,
      2) "Table matrix (grid = first column; e.g., table=[0,2])";
  Modelica.Blocks.Sources.Constant conXMin(k=xMin)
    annotation (Placement(transformation(extent={{-50,-46},{-38,-34}})));
  Modelica.Blocks.Sources.Constant conXMax(k=xMax)
    annotation (Placement(transformation(extent={{-50,-76},{-38,-64}})));
protected
  parameter Real xMax=min(tableLow[end, 1], tableUpp[end, 1])
    "Minimal value of lower and upper table data";
  parameter Real xMin=max(tableLow[1, 1], tableUpp[1, 1])
    "Maximal value of lower and upper table data";
initial equation
  assert(tableLow[end,1]==tableUpp[end,1],"The boundary values have to the same. For now the value to the safe operational side has been selected.", level = AssertionLevel.error);
  assert(tableLow[1,1]==tableUpp[1,1],"The boundary values have to the same. For now the value to the safe operational side has been selected.", level = AssertionLevel.error);

equation
  connect(x_in, uppCombiTable1Ds.u)
    annotation (Line(points={{-114,60},{-54,60}}, color={0,0,127}));
  connect(x_in, lowCombiTable1Ds.u) annotation (Line(points={{-114,60},{-72,60},{-72,26},
          {-54,26}}, color={0,0,127}));
  connect(or1.y, ERR) annotation (Line(points={{69.5,0},{110,0}}, color={255,0,255}));
  connect(y_in, greaterLow.u2) annotation (Line(points={{-114,-60},{-20,-60},{-20,18},
          {-8,18}}, color={0,0,127}));
  connect(lowCombiTable1Ds.y[1], greaterLow.u1)
    annotation (Line(points={{-31,26},{-8,26}}, color={0,0,127}));
  connect(y_in, lessUpp.u2) annotation (Line(points={{-114,-60},{-22,-60},{-22,52},{-8,
          52}}, color={0,0,127}));
  connect(uppCombiTable1Ds.y[1], lessUpp.u1)
    annotation (Line(points={{-31,60},{-8,60}}, color={0,0,127}));
  connect(lessUpp.y, or1.u[1]) annotation (Line(points={{15,60},{32,60},{32,5.25},{48,
          5.25}}, color={255,0,255}));
  connect(greaterLow.y, or1.u[2]) annotation (Line(points={{15,26},{32,26},{32,1.75},
          {48,1.75}}, color={255,0,255}));
  connect(lessLef.y, or1.u[3]) annotation (Line(points={{15,-30},{32,-30},{32,-1.75},
          {48,-1.75}}, color={255,0,255}));
  connect(greaterRig.y, or1.u[4]) annotation (Line(points={{15,-60},{32,-60},{32,-5.25},
          {48,-5.25}}, color={255,0,255}));
  connect(x_in, lessLef.u1) annotation (Line(points={{-114,60},{-72,60},{-72,-30},{-8,
          -30}}, color={0,0,127}));
  connect(x_in, greaterRig.u1) annotation (Line(points={{-114,60},{-72,60},{-72,-60},
          {-8,-60}}, color={0,0,127}));
  connect(conXMax.y, greaterRig.u2) annotation (Line(points={{-37.4,-70},{-22,-70},{-22,
          -68},{-8,-68}}, color={0,0,127}));
  connect(conXMin.y, lessLef.u2) annotation (Line(points={{-37.4,-40},{-24,-40},{-24,
          -38},{-8,-38}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{100,
            100}}),                                             graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-88,74},{-88,-42},{-88,-88},{86,-88},{82,-86},{86,-88},{
              82,-90}}, color={28,108,200}),
        Line(points={{-88,74},{-90,70},{-88,74},{-86,70}}, color={28,108,200}),
        Line(points={{-74,48},{-74,-60},{-46,-80},{46,-80},{82,-64},{82,42}},
            color={28,108,200}),
        Line(points={{-74,48},{-68,58},{-50,70},{-36,70},{-20,70},{18,70},{46,
              70},{72,64},{82,42}}, color={28,108,200}),
        Line(points={{-96,74},{-94,70}}, color={28,108,200}),
        Line(points={{-92,74},{-96,66}}, color={28,108,200}),
        Line(points={{84,-92},{88,-98}}, color={28,108,200}),
        Line(points={{88,-92},{84,-98}}, color={28,108,200})}),  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>Given an input of the x and y-Axis, the block returns true if the given point is outside of the given envelope.</p><p>The maximal and minmal y-value depend on the x-Value and are defined by the upper and lower boundaries in form of 1Ds-Tables. The maximal and minimal x-values are obtained trough the table and are constant.</p>
</html>"));
end BoundaryMap;
