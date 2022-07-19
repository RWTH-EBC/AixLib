within AixLib.ThermalZones.ReducedOrder.Windows.Validation.SelfShadowing;
model SelfShadowingTestLeft
  extends Modelica.Icons.Example;

  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.SelfShadowing selfShadowingLeft(
    final bRig={0},
    final n=1,
    final b={1},
    final h={1},
    final dRig={0},
    final bAbo={0},
    final bBel={0},
    final dAbo={0},
    final dBel={0},
    final azi(displayUnit="deg") = {0},
    final til(displayUnit="deg") = {1.5707963267949},
    final bLef={1},
    final dLef={0.01})
    "Shadowing due to a projection on the left-hand side of the window"
    annotation (Placement(transformation(extent={{62,-4},{94,24}})));
  AixLib.ThermalZones.ReducedOrder.Windows.Validation.BaseClasses.IncidenceAngleVDI6007 incAng1(azi=0, til=90)
    "Incidence angle for the window"
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Blocks.Sources.Constant alt(k=0.3490658504)
    "Constant altitude angle"
    annotation (Placement(transformation(extent={{-76,8},{-56,28}})));
  Modelica.Blocks.Sources.Sine solAziSine(amplitude=Modelica.Constants.pi, f=1)
    "Solar azimuth angle generated as a sine"
    annotation (Placement(transformation(extent={{-76,-26},{-56,-6}})));
equation
  connect(incAng1.incAng, selfShadowingLeft.incAng[1]) annotation (Line(
        points={{11,-2},{36,-2},{36,0.2},{60.4,0.2}}, color={0,0,127}));
  connect(alt.y, selfShadowingLeft.alt) annotation (Line(points={{-55,18},{-18,
          18},{-18,16},{16,16},{30,16},{36,16},{36,10},{60.4,10}}, color={0,0,
          127}));
  connect(alt.y, incAng1.alt) annotation (Line(points={{-55,18},{-34,18},{-34,
          3.4},{-12.2,3.4}},     color={0,0,127}));
  connect(solAziSine.y, incAng1.solAzi) annotation (Line(
      points={{-55,-16},{-32,-16},{-32,-6.8},{-12,-6.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solAziSine.y, selfShadowingLeft.solAzi) annotation (Line(
      points={{-55,-16},{44,-16},{44,19.8},{60.4,19.8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Documentation(info="<html><p>
  This model simulates a projection on the left-hand side of the
  window.
</p>
<ul>
  <li>July 17 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end SelfShadowingTestLeft;
