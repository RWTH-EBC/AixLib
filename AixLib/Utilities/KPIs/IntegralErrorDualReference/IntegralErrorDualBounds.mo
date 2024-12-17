within AixLib.Utilities.KPIs.IntegralErrorDualReference;
model IntegralErrorDualBounds
  "Integral error with dual bounds by sign for both positive and negative errors"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegralErrorDualReference;
  extends Modelica.Blocks.Icons.Block;
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itgPos(
    final use_itgAct_in=true,
    final use_itgRes_in=use_itgRes_in,
    final posItg=true) "Integrator positive"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itgNeg(
    final use_itgAct_in=true,
    final use_itgRes_in=use_itgRes_in,
    final posItg=false) "Integrator negative"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Math.Add addItgErr(final k1=+1, final k2=-1)
    "Add integral errors"
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput isItgActPos
    "If the positie integrator is activated"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.BooleanOutput isItgActNeg
    "If the negative integrator is activated"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Logical.Or orItgAct "Or logic for integrator activations"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput isItgAct
    "If one of both integrators is activated"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
equation
  connect(u, itgPos.u) annotation (Line(points={{-120,0},{-90,0},{-90,60},{-82,60}},
        color={0,0,127}));
  connect(u, itgNeg.u) annotation (Line(points={{-120,0},{-90,0},{-90,-60},{-82,
          -60}}, color={0,0,127}));
  connect(refUpp, itgPos.ref) annotation (Line(points={{-120,60},{-92,60},{-92,54},
          {-82,54}}, color={0,0,127}));
  connect(refLow, itgNeg.ref) annotation (Line(points={{-120,-60},{-92,-60},{-92,
          -66},{-82,-66}}, color={0,0,127}));
  connect(itgPos.y,yPos)
    annotation (Line(points={{-59,60},{110,60}}, color={0,0,127}));
  connect(itgNeg.y,yNeg)
    annotation (Line(points={{-59,-60},{110,-60},{110,-60}}, color={0,0,127}));
  connect(booExpItgAct.y, itgPos.itgAct_in) annotation (Line(points={{-79,90},{-50,
          90},{-50,40},{-70,40},{-70,48}}, color={255,0,255}));
  connect(booExpItgAct.y, itgNeg.itgAct_in) annotation (Line(points={{-79,90},{-50,
          90},{-50,-80},{-70,-80},{-70,-72}}, color={255,0,255}));
  connect(itgRes_in, itgPos.itgRes_in) annotation (Line(
      points={{60,-120},{60,-90},{-52,-90},{-52,42},{-64,42},{-64,48}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgRes_in then LinePattern.Solid else LinePattern.Dash)));
  connect(itgRes_in, itgNeg.itgRes_in) annotation (Line(
      points={{60,-120},{60,-90},{-52,-90},{-52,-78},{-64,-78},{-64,-72}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgRes_in then LinePattern.Solid else LinePattern.Dash)));
  connect(itgPos.y, addItgErr.u1) annotation (Line(points={{-59,60},{60,60},{60,
          6},{68,6}}, color={0,0,127}));
  connect(itgNeg.y, addItgErr.u2) annotation (Line(points={{-59,-60},{60,-60},{60,
          -6},{68,-6}}, color={0,0,127}));
  connect(addItgErr.y, y)
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(itgPos.isItgAct, isItgActPos) annotation (Line(points={{-59,66},{80,66},
          {80,80},{110,80}}, color={255,0,255}));
  connect(itgNeg.isItgAct, isItgActNeg) annotation (Line(points={{-59,-54},{80,-54},
          {80,-40},{110,-40}}, color={255,0,255}));
  connect(itgPos.isItgAct, orItgAct.u1) annotation (Line(points={{-59,66},{10,66},
          {10,0},{18,0}}, color={255,0,255}));
  connect(itgNeg.isItgAct, orItgAct.u2) annotation (Line(points={{-59,-54},{10,-54},
          {10,-8},{18,-8}}, color={255,0,255}));
  connect(orItgAct.y, isItgAct) annotation (Line(points={{41,0},{50,0},{50,20},{
          110,20}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                             Text(
          extent={{-80,80},{80,0}},
          textColor={28,108,200},
          textString="IE"),  Text(
          extent={{-80,0},{80,-80}},
          textColor={28,108,200},
          textString="+/-")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>"));
end IntegralErrorDualBounds;
