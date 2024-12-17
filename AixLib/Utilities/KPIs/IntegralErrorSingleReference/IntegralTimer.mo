within AixLib.Utilities.KPIs.IntegralErrorSingleReference;
model IntegralTimer "Integral timer"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegratorBase(
    final use_itgAct_in=true);
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealOutput y(unit="s") "Output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant conZero(final k=0) "Constant zero"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.Constant conOne(final k=1) "Constant one"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Logical.Switch swi "Switch for integration"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Continuous.Integrator timeItg(final use_reset=use_itgRes_in)
    "Time integrator"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(booExpItgAct.y, swi.u2) annotation (Line(points={{-79,90},{-70,90},{-70,
          0},{-22,0}}, color={255,0,255}));
  connect(conOne.y, swi.u1) annotation (Line(points={{-39,50},{-30,50},{-30,8},{
          -22,8}}, color={0,0,127}));
  connect(conZero.y, swi.u3) annotation (Line(points={{-39,-50},{-30,-50},{-30,-8},
          {-22,-8}}, color={0,0,127}));
  connect(swi.y, timeItg.u)
    annotation (Line(points={{1,0},{58,0}}, color={0,0,127}));
  connect(timeItg.y, y)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(itgRes_in, timeItg.reset) annotation (Line(
      points={{60,-120},{60,-100},{76,-100},{76,-12}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgRes_in then LinePattern.Solid else LinePattern.Dash)));
  annotation (Icon(graphics={
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={28,108,200}),
        Line(points={{0,80},{0,60}}, color={28,108,200}),
        Line(points={{80,0},{60,0}}, color={28,108,200}),
        Line(points={{0,-80},{0,-60}}, color={28,108,200}),
        Line(points={{-80,0},{-60,0}}, color={28,108,200}),
        Line(points={{37,70},{26,50}}, color={28,108,200}),
        Line(points={{70,38},{49,26}}, color={28,108,200}),
        Line(points={{71,-37},{52,-27}}, color={28,108,200}),
        Line(points={{39,-70},{29,-51}}, color={28,108,200}),
        Line(points={{-39,-70},{-29,-52}}, color={28,108,200}),
        Line(points={{-71,-37},{-50,-26}}, color={28,108,200}),
        Line(points={{-71,37},{-54,28}}, color={28,108,200}),
        Line(points={{-38,70},{-28,51}}, color={28,108,200}),
        Line(
          points={{0,0},{-50,50}},
          thickness=0.5,
          color={28,108,200}),
        Line(
          points={{0,0},{40,0}},
          thickness=0.5,
          color={28,108,200})}));
end IntegralTimer;
