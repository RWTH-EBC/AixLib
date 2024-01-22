within AixLib.ThermalZones.ReducedOrder.Windows.Validation.SelfShadowing;
model SelfShadowingTestBelow
  extends Modelica.Icons.Example;

    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.SelfShadowing selfShadowingBelow(
    final bRig={0},
    final n=1,
    final b={1},
    final h={1},
    final bLef={0},
    final dRig={0},
    final dLef={0},
    final bAbo={0},
    final dAbo={0},
    final azi(displayUnit="deg") = {0},
    final til(displayUnit="deg") = {1.5707963267949},
    final dBel={0.01},
    final bBel={1}) "Shadowing due to a projection below"
    annotation (Placement(transformation(extent={{56,46},{88,74}})));
    AixLib.ThermalZones.ReducedOrder.Windows.Validation.BaseClasses.IncidenceAngleVDI6007 incAng1(azi=0, til=90)
    "Incidence Angle for the window"
    annotation (Placement(transformation(extent={{-26,40},{-6,60}})));
  Modelica.Blocks.Sources.Constant solAzi(k=0)
    "Constant solar azimuth angle (north)"
    annotation (Placement(transformation(extent={{-88,24},{-68,44}})));
  Modelica.Blocks.Sources.Sine altSine(f=1, amplitude=Modelica.Constants.pi/3)
    "Solar altitude angle generated as a sine"
    annotation (Placement(transformation(extent={{-88,56},{-68,76}})));
  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.SelfShadowing selfShadowingBalkony(
    final bRig={0},
    final n=1,
    final b={1},
    final h={1},
    final bLef={0},
    final dRig={0},
    final dLef={0},
    final bAbo={0},
    final dAbo={0},
    final azi(displayUnit="deg") = {0},
    final til(displayUnit="deg") = {1.5707963267949},
    final bBel={1},
    final dBel={-0.2}) "Shadowing due to a balkony"
    annotation (Placement(transformation(extent={{56,-40},{88,-12}})));
  AixLib.ThermalZones.ReducedOrder.Windows.Validation.BaseClasses.IncidenceAngleVDI6007 incAng2(azi=0, til=90)
    "Incidence angle for the window"
    annotation (Placement(transformation(extent={{-26,-46},{-6,-26}})));
  Modelica.Blocks.Sources.Constant solAzi1(k=0)
    "Constant solar azimuth angle (north)"
    annotation (Placement(transformation(extent={{-88,-62},{-68,-42}})));
  Modelica.Blocks.Sources.Sine altSine1(f=1, amplitude=Modelica.Constants.pi/3)
    "Solar altitude angle generated as a sine"
    annotation (Placement(transformation(extent={{-88,-30},{-68,-10}})));
equation
  connect(incAng1.incAng, selfShadowingBelow.incAng[1]) annotation (Line(
        points={{-5,50},{28,50},{28,50.2},{54.4,50.2}}, color={0,0,127}));
  connect(altSine.y, incAng1.alt) annotation (Line(
      points={{-67,66},{-44,66},{-44,55.4},{-28.2,55.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(altSine.y, selfShadowingBelow.alt) annotation (Line(
      points={{-67,66},{2,66},{2,60},{54.4,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solAzi.y, incAng1.solAzi) annotation (Line(
      points={{-67,34},{-44,34},{-44,45.2},{-28,45.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solAzi.y, selfShadowingBelow.solAzi) annotation (Line(
      points={{-67,34},{38,34},{38,69.8},{54.4,69.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(incAng2.incAng, selfShadowingBalkony.incAng[1]) annotation (
  Line(points={
          {-5,-36},{28,-36},{28,-35.8},{54.4,-35.8}}, color={0,0,127}));
  connect(altSine1.y, incAng2.alt) annotation (Line(
      points={{-67,-20},{-44,-20},{-44,-30.6},{-28.2,-30.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(altSine1.y, selfShadowingBalkony.alt) annotation (Line(
      points={{-67,-20},{2,-20},{2,-26},{54.4,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solAzi1.y, incAng2.solAzi) annotation (Line(
      points={{-67,-52},{-44,-52},{-44,-40.8},{-28,-40.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solAzi1.y, selfShadowingBalkony.solAzi) annotation (Line(
      points={{-67,-52},{38,-52},{38,-16.2},{54.4,-16.2}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Documentation(info="<html><p>
  This model simulates a projection below the window and a balcony.
</p>
<ul>
  <li>July 17 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end SelfShadowingTestBelow;
