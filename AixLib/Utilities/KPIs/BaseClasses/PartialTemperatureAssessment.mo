within AixLib.Utilities.KPIs.BaseClasses;
partial model PartialTemperatureAssessment
  "Partial model for temperature assessment"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialAssessmentBase(
    final nItgTim=3);
  Modelica.Blocks.Interfaces.RealInput T(
    final unit="K", displayUnit="degC", final min=0) "Temperature input"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput degSecOutUppBou(final unit="K.s")
    "Degree-second out of upper bound"
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput degSecOutLowBou(final unit="K.s")
    "Degree-second out of lower bound"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput totDegSecOutBou(final unit="K.s")
    "Total degree-second out of bound"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  AixLib.Utilities.KPIs.IntegralErrorDualReference.IntegralErrorDualBounds itgErrDuaBou(
    final use_itgAct_in=use_itgAct_in, final use_itgRes_in=resItgInBou)
    "Dual bounds integrator for temperature"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Interfaces.RealOutput timeOutUppBou(final unit="s") if use_itgTim
    "Time out of upper bound"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput totTimeOutBou(final unit="s") if use_itgTim
    "Total time out of bound"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Interfaces.RealOutput timeOutLowBou(final unit="s") if use_itgTim
    "Time out of lower bound"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
equation
  connect(T, itgErrDuaBou.u)
    annotation (Line(points={{-120,0},{-24,0}}, color={0,0,127}));
  connect(itgAct_in, itgErrDuaBou.itgAct_in) annotation (Line(
      points={{0,-120},{0,-24},{0,-24}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgAct_in then LinePattern.Solid else LinePattern.Dash)));
  connect(itgErrDuaBou.isItgAct, notRes.u) annotation (Line(
      points={{22,4},{48,4},{48,-30},{42,-30}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if (resItgInBou or resItgTimInBou) then LinePattern.Solid
        else LinePattern.Dash)));
  connect(notRes.y, itgErrDuaBou.itgRes_in) annotation (Line(
      points={{19,-30},{12,-30},{12,-24}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if resItgInBou then LinePattern.Solid else LinePattern.Dash)));
  connect(itgErrDuaBou.yPos, degSecOutUppBou) annotation (Line(points={{22,12},{
          60,12},{60,90},{110,90}}, color={0,0,127}));
  connect(itgErrDuaBou.y, totDegSecOutBou) annotation (Line(points={{22,0},{62,0},
          {62,70},{110,70}}, color={0,0,127}));
  connect(itgErrDuaBou.yNeg, degSecOutLowBou) annotation (Line(points={{22,-12},
          {64,-12},{64,50},{110,50}}, color={0,0,127}));
  connect(itgErrDuaBou.isItgActPos, itgTim[1].itgAct_in) annotation (Line(
      points={{22,16},{54,16},{54,-90},{70,-90},{70,-82}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(itgErrDuaBou.isItgAct, itgTim[2].itgAct_in) annotation (Line(
      points={{22,4},{54,4},{54,-90},{70,-90},{70,-82}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(itgErrDuaBou.isItgActNeg, itgTim[3].itgAct_in) annotation (Line(
      points={{22,-8},{54,-8},{54,-90},{70,-90},{70,-82}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(itgTim[1].y, timeOutUppBou) annotation (Line(
      points={{81,-70},{90,-70},{90,-50},{110,-50}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(itgTim[2].y, totTimeOutBou) annotation (Line(
      points={{81,-70},{110,-70}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(itgTim[3].y, timeOutLowBou) annotation (Line(
      points={{81,-70},{90,-70},{90,-90},{110,-90}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(notRes.y, itgTim[1].itgRes_in) annotation (Line(
      points={{19,-30},{16,-30},{16,-92},{76,-92},{76,-82}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if resItgTimInBou then LinePattern.Solid else LinePattern.Dash)));
  connect(notRes.y, itgTim[2].itgRes_in) annotation (Line(
      points={{19,-30},{16,-30},{16,-92},{76,-92},{76,-82}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if resItgTimInBou then LinePattern.Solid else LinePattern.Dash)));
  connect(notRes.y, itgTim[3].itgRes_in) annotation (Line(
      points={{19,-30},{16,-30},{16,-92},{76,-92},{76,-82}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if resItgTimInBou then LinePattern.Solid else LinePattern.Dash)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial model is the base model of temperature assessments.</p>
</html>"));
end PartialTemperatureAssessment;
