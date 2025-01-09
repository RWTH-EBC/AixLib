within AixLib.Utilities.KPIs.IndoorAirQuality;
model Co2FixedLimit "CO2 concentration assessment with fixed limit"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialCo2Assessment(
    final nItgTim=1);
  parameter Real co2ConLim = 1000 "CO2 concentration limit in ppm";
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itgErrPos(
    final use_itgAct_in=use_itgAct_in,
    final use_itgRes_in=resItgInBou,
    final posItg=true)
    "Positive error integrator for CO2 concentration"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Sources.Constant conConLim(final k=co2ConLim)
    "Concentration limit"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Blocks.Interfaces.RealOutput ppmSecOutBou(final unit="s")
    "Total ppm-second out of bound"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput totTimeOutBou(final unit="s")
    if use_itgTim "Total time out of bound"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
equation
  connect(co2Con, itgErrPos.u)
    annotation (Line(points={{-120,0},{-24,0}}, color={0,0,127}));
  connect(conConLim.y, itgErrPos.ref) annotation (Line(points={{-59,-50},{-40,-50},
          {-40,-12},{-24,-12}}, color={0,0,127}));
  connect(itgErrPos.y, ppmSecOutBou)
    annotation (Line(points={{22,0},{110,0},{110,0}}, color={0,0,127}));
  connect(itgAct_in, itgErrPos.itgAct_in) annotation (Line(
      points={{0,-120},{0,-24},{0,-24}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgAct_in then LinePattern.Solid else LinePattern.Dash)));
  connect(itgErrPos.isItgAct, notRes.u) annotation (Line(
      points={{22,12},{48,12},{48,-30},{42,-30}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if (resItgInBou or resItgTimInBou) then LinePattern.Solid
        else LinePattern.Dash)));
  connect(notRes.y, itgErrPos.itgRes_in) annotation (Line(
      points={{19,-30},{12,-30},{12,-24}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if resItgInBou then LinePattern.Solid else LinePattern.Dash)));
  connect(itgErrPos.isItgAct, itgTim[1].itgAct_in) annotation (Line(
      points={{22,12},{54,12},{54,-90},{70,-90},{70,-82}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(itgTim[1].y, totTimeOutBou) annotation (Line(
      points={{81,-70},{110,-70}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(notRes.y, itgTim[1].itgRes_in) annotation (Line(
      points={{19,-30},{16,-30},{16,-92},{76,-92},{76,-82}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if resItgTimInBou then LinePattern.Solid else LinePattern.Dash)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model assesses room CO<sub>2</sub> concentration using a fixed limit.</p>
</html>", revisions="<html>
<ul>
  <li>
    January 9, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>"));
end Co2FixedLimit;
