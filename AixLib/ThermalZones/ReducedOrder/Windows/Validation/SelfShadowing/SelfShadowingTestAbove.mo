within AixLib.ThermalZones.ReducedOrder.Windows.Validation.SelfShadowing;
model SelfShadowingTestAbove
  extends Modelica.Icons.Example;

  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.SelfShadowing selfShadowingAbove(
    final bRig={0},
    final n=1,
    final b={1},
    final h={1},
    final bLef={0},
    final dLef={0},
    final dRig={0},
    final bAbo={1},
    final bBel={0},
    final dAbo={0.01},
    final dBel={0},
    final azi(displayUnit="deg") = {0},
    final til(displayUnit="deg") = {1.5707963267949})
    "Shadowing due to a projection above the window"
          annotation (Placement(transformation(extent={{56,46},{88,74}})));
  AixLib.ThermalZones.ReducedOrder.Windows.Validation.BaseClasses.IncidenceAngleVDI6007 incAng1(azi=0, til=90)
    "Incidence angle for the window"
    annotation (Placement(transformation(extent={{-26,40},{-6,60}})));
  Modelica.Blocks.Sources.Constant solAzi(k=0)
    "Constant soar azimuth angle (North)"
    annotation (Placement(transformation(extent={{-88,24},{-68,44}})));
  Modelica.Blocks.Sources.Constant alt(k=Modelica.Constants.pi/6)
    "Constant altitude angle"
    annotation (Placement(transformation(extent={{-88,-20},{-68,0}})));
  Modelica.Blocks.Sources.Sine altSine(f=1, amplitude=Modelica.Constants.pi/3)
    "Altitude angle generated as a sine"
    annotation (Placement(transformation(extent={{-88,56},{-68,76}})));
  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.SelfShadowing selfShadowingAboveSin(
    final n=1,
    final b={1},
    final h={1},
    final bLef={0},
    final bRig={0},
    final dLef={0},
    final dRig={0},
    final bAbo={1},
    final bBel={0},
    final dAbo={0.01},
    final dBel={0},
    final azi(displayUnit="deg") = {0},
    final til(displayUnit="deg") = {1.5707963267949})
    "Shadowing due to a projection above the window"
          annotation (Placement(transformation(extent={{56,-32},{88,-4}})));
  AixLib.ThermalZones.ReducedOrder.Windows.Validation.BaseClasses.IncidenceAngleVDI6007 incAng2(azi=0, til=90)
    "Incidence angle for the window"
    annotation (Placement(transformation(extent={{-26,-38},{-6,-18}})));
  Modelica.Blocks.Sources.Sine solAziSine(f=0.25, amplitude=2*Modelica.Constants.pi)
    "Solar azimuth generated as a sine"
    annotation (Placement(transformation(extent={{-88,-52},{-68,-32}})));
equation
  connect(altSine.y, incAng1.alt) annotation (Line(
      points={{-67,66},{-44,66},{-44,55.4},{-28.2,55.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(altSine.y, selfShadowingAbove.alt) annotation (Line(
      points={{-67,66},{2,66},{2,60},{54.4,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solAzi.y, incAng1.solAzi) annotation (Line(
      points={{-67,34},{-44,34},{-44,45.2},{-28,45.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solAzi.y, selfShadowingAbove.solAzi) annotation (Line(
      points={{-67,34},{38,34},{38,69.8},{54.4,69.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solAziSine.y, incAng2.solAzi) annotation (Line(points={{-67,-42},
          {-48,-42},{-48,-32.8},{-28,-32.8}}, color={0,0,127}));
  connect(solAziSine.y, selfShadowingAboveSin.solAzi) annotation (Line(
        points={{-67,-42},{24,-42},{24,-8.2},{54.4,-8.2}}, color={0,0,127}));
  connect(alt.y, incAng2.alt) annotation (Line(points={{-67,-10},{-48,-10},
          {-48,-22.6},{-28.2,-22.6}}, color={0,0,127}));
  connect(alt.y, selfShadowingAboveSin.alt) annotation (Line(points={{-67,
          -10},{-26,-10},{-26,-8},{14,-8},{14,-18},{54.4,-18}}, color={0,0,
          127}));
  connect(incAng1.incAng, selfShadowingAbove.incAng[1]) annotation (Line(
        points={{-5,50},{54.4,50},{54.4,50.2}}, color={0,0,127}));
  connect(incAng2.incAng, selfShadowingAboveSin.incAng[1]) annotation (Line(
        points={{-5,-28},{54.4,-28},{54.4,-27.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Documentation(info="<html><p>
  This model simulates a projection above the window.
</p>
<ul>
  <li>July 17 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end SelfShadowingTestAbove;
