within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model Cooler "Idealized model for cooler considering condensation"
  extends BaseClasses.PartialCooler(TAirIn( start=291.15, fixed=false));

  AixLib.Utilities.Psychrometrics.SaturationPressure pSat if use_T_set
    annotation (Placement(transformation(extent={{-24,26},{-4,46}})));
  AixLib.Utilities.Psychrometrics.X_pW humRat(use_p_in=false) if use_T_set
    annotation (Placement(transformation(extent={{8,26},{28,46}})));
protected
  Modelica.Blocks.Math.Min minX if use_T_set
    annotation (Placement(transformation(extent={{50,54},{62,66}})));
equation

  if not use_T_set then
    XAirOut = XAirIn;
    X_intern =XAirIn;
  else
    XAirOut = X_intern;
  end if;

  connect(minX.y, X_intern);
  connect(pSat.pSat, humRat.p_w)
    annotation (Line(points={{-3,36},{7,36}},      color={0,0,127}));
  connect(humRat.X_w, minX.u2) annotation (Line(points={{29,36},{36,36},{36,
          56.4},{48.8,56.4}}, color={0,0,127}));
  connect(XAirIn, minX.u1) annotation (Line(points={{-120,10},{-62,10},{-62,
          63.6},{48.8,63.6}}, color={0,0,127}));
  connect(minT.y, pSat.TSat) annotation (Line(points={{-35.4,74},{-30,74},{-30,
          36},{-25,36}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(
          points={{100,94},{-100,-94}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{54,-14},{64,-24}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{54,-20},{54,-16},{56,-12},{60,-8},{64,-6},{62,-10},{62,-14},{
              64,-18},{60,-18},{54,-20}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{72,-8},{82,-18}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{72,-14},{72,-10},{74,-6},{78,-2},{82,0},{80,-4},{80,-8},{82,-12},
              {78,-12},{72,-14}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{70,-34},{80,-44}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{70,-40},{70,-36},{72,-32},{76,-28},{80,-26},{78,-30},{78,-34},
              {80,-38},{76,-38},{70,-40}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}), Documentation(info="<html><p>
  This model provides a idealized cooler. The model considers the
  convective heat transfer from the heat transfer surface in the air
  stream. Moreover the heat capacity of the heating surface and the
  housing of the heat exchanger is considered.
</p>
<p>
  If the temperature of the cooling surface lies below the dew point,
  condensation is considered.
</p>
<h4>
  Heat transfer model:
</h4>
<p>
  The model assumes a heat transfer in a plane gap. Hence the
  convective heat transfer coefficient is calculated using the
  Nusselt-correlation for a plane gap as described in the
  VDI-Wärmeatlas 2013 (p.800, eq. 45).
</p>
<p style=\"text-align:center;\">
  <i>Nu<sub>m</sub> = 7.55 + (0.024 {Re Pr d<sub>h</sub> ⁄
  l}<sup>1.14</sup>) ⁄ (1 + 0.0358 {Re Pr d<sub>h</sub> ⁄
  l}<sup>0.64</sup> Pr<sup>0.17</sup>)</i>
</p>
</html>", revisions="<html>
<ul>
  <li>April, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end Cooler;
