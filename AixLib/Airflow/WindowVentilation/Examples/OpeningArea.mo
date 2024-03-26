within AixLib.Airflow.WindowVentilation.Examples;
model OpeningArea "Calculation of different opening areas"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Length winClrW = 1.0;
  parameter Modelica.Units.SI.Height winClrH = 1.5;

  Modelica.Blocks.Sources.Ramp opnWidth(
    height=0.5,
    duration=50,
    startTime=5)
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  OpeningAreas.OpeningAreaSimple openingAreaSimple(winClrW=winClrW, winClrH=
        winClrH)
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_side_hung_in_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Side-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));

  OpeningAreas.OpeningAreaSashWidth openingAreaSash_side_hung_in_proj(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Side-hung, inward, projective opening"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_side_hung_in_eq(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Side-hung, inward, equivalent opening"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_side_hung_in_eff(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Side-hung, inward, effective opening"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_side_hung_out_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Side-hung, outward, geometric opening"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_bottom_hung_in_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Bottom-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_bottom_hung_in_proj(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Bottom-hung, inward, projective opening"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_bottom_hung_in_eq(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Bottom-hung, inward, equivalent opening"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_bottom_hung_in_eff(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Bottom-hung, inward, effective opening"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_top_hung_out_proj(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Top-hung, outward, projective opening"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_pivot_vertical_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Pivot, vertical, geometric opening"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_pivot_vertical_proj(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Pivot, vertical, projective opening"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_pivot_vertical_eq(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Pivot, vertical, equivalent opening"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_pivot_vertical_eff(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Pivot, vertical, effective opening"
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_pivot_horizontal_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Pivot, horizontal, geometric opening"
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_pivot_horizontal_proj(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Pivot, horizontal, projective opening"
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_pivot_horizontal_eq(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Pivot, horizontal, equivalent opening"
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_pivot_horizontal_eff(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Pivot, horizontal, effective opening"
    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_sliding_vertical_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Sliding, vertical, geometric opening"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  OpeningAreas.OpeningAreaSashWidth openingAreaSash_sliding_horizontal_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Sliding, horizontal, geometric opening"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  OpeningAreas.OpeningAreaSashAngle openingAreaSashAngle_side_hung_in_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Side-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Blocks.Sources.Ramp opnAngle(
    height=90,
    duration=50,
    startTime=5)
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  OpeningAreas.OpeningAreaSashAngle openingAreaSashAngle_bottom_hung_in_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Bottom-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  OpeningAreas.OpeningAreaSashAngle openingAreaSashAngle_pivot_vertical_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Pivot, vertical, geometric opening"
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  OpeningAreas.OpeningAreaSashAngle openingAreaSashAngle_pivot_horizontal_geo(
    winClrW=winClrW,
    winClrH=winClrH,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Pivot, horizontal, geometric opening"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
equation
  connect(opnWidth.y, openingAreaSash_side_hung_in_geo.s) annotation (Line(
        points={{-119,10},{-90,10},{-90,70},{-82,70}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_side_hung_in_proj.s) annotation (Line(
        points={{-119,10},{-90,10},{-90,30},{-82,30}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_side_hung_in_eq.s) annotation (Line(
        points={{-119,10},{-90,10},{-90,-10},{-82,-10}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_side_hung_in_eff.s) annotation (Line(
        points={{-119,10},{-90,10},{-90,-50},{-82,-50}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_side_hung_out_geo.s) annotation (Line(
        points={{-119,10},{-50,10},{-50,70},{-42,70}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_bottom_hung_in_geo.s) annotation (Line(
        points={{-119,10},{-10,10},{-10,70},{-2,70}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_bottom_hung_in_proj.s) annotation (Line(
        points={{-119,10},{-10,10},{-10,30},{-2,30}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_bottom_hung_in_eq.s) annotation (Line(
        points={{-119,10},{-10,10},{-10,-10},{-2,-10}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_bottom_hung_in_eff.s) annotation (Line(
        points={{-119,10},{-10,10},{-10,-50},{-2,-50}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_top_hung_out_proj.s) annotation (Line(
        points={{-119,10},{-50,10},{-50,30},{-42,30}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_pivot_vertical_geo.s) annotation (Line(
        points={{-119,10},{30,10},{30,70},{38,70}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_pivot_vertical_proj.s) annotation (Line(
        points={{-119,10},{30,10},{30,30},{38,30}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_pivot_vertical_eq.s) annotation (Line(
        points={{-119,10},{30,10},{30,-10},{38,-10}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_pivot_vertical_eff.s) annotation (Line(
        points={{-119,10},{30,10},{30,-50},{38,-50}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_pivot_horizontal_geo.s) annotation (Line(
        points={{-119,10},{70,10},{70,70},{78,70}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_pivot_horizontal_proj.s) annotation (Line(
        points={{-119,10},{70,10},{70,30},{78,30}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_pivot_horizontal_eq.s) annotation (Line(
        points={{-119,10},{70,10},{70,-10},{78,-10}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_pivot_horizontal_eff.s) annotation (Line(
        points={{-119,10},{70,10},{70,-50},{78,-50}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_sliding_vertical_geo.s) annotation (Line(
        points={{-119,10},{-50,10},{-50,-10},{-42,-10}}, color={0,0,127}));
  connect(opnWidth.y, openingAreaSash_sliding_horizontal_geo.s) annotation (
      Line(points={{-119,10},{-50,10},{-50,-50},{-42,-50}}, color={0,0,127}));
  connect(opnAngle.y, from_deg.u) annotation (Line(points={{-119,-70},{-88,-70},
          {-88,-90},{-82,-90}}, color={0,0,127}));
  connect(from_deg.y, openingAreaSashAngle_side_hung_in_geo.alpha)
    annotation (Line(points={{-59,-90},{-42,-90}}, color={0,0,127}));
  connect(from_deg.y, openingAreaSashAngle_bottom_hung_in_geo.alpha)
    annotation (Line(points={{-59,-90},{-50,-90},{-50,-70},{-8,-70},{-8,-90},{-2,
          -90}}, color={0,0,127}));
  connect(from_deg.y, openingAreaSashAngle_pivot_vertical_geo.alpha)
    annotation (Line(points={{-59,-90},{-50,-90},{-50,-70},{30,-70},{30,-90},{38,
          -90}}, color={0,0,127}));
  connect(from_deg.y, openingAreaSashAngle_pivot_horizontal_geo.alpha)
    annotation (Line(points={{-59,-90},{-50,-90},{-50,-70},{70,-70},{70,-90},{78,
          -90}}, color={0,0,127}));
  annotation (experiment(
      StopTime=60,
      Interval=1,
      __Dymola_Algorithm="Dassl"), Diagram(graphics={
        Rectangle(
          extent={{-100,100},{-60,-60}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,100},{-60,80}},
          textColor={255,255,255},
          textString="Side-hung
inward"),
        Rectangle(
          extent={{-60,100},{-20,60}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,100},{-20,80}},
          textColor={255,255,255},
          textString="Side-hung
outward"),
        Text(
          extent={{-120,80},{-100,60}},
          textColor={0,0,0},
          fontSize=16,
          textString="geo."),
        Text(
          extent={{-120,40},{-100,20}},
          textColor={0,0,0},
          textString="proj.",
          fontSize=16),
        Text(
          extent={{-120,0},{-100,-20}},
          textColor={0,0,0},
          textString="eq.",
          fontSize=16),
        Text(
          extent={{-120,-40},{-100,-60}},
          textColor={0,0,0},
          textString="eff.",
          fontSize=16),
        Rectangle(
          extent={{-20,100},{20,-100}},
          lineColor={28,108,200},
          fillColor={217,67,180},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,100},{20,80}},
          textColor={255,255,255},
          textString="Bottom-hung
inward"),
        Rectangle(
          extent={{-60,60},{-20,20}},
          lineColor={28,108,200},
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,60},{-20,40}},
          textColor={255,255,255},
          textString="Top-hung
outward"),
        Rectangle(
          extent={{20,100},{60,-100}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{20,100},{60,80}},
          textColor={255,255,255},
          textString="Pivot
vertical"),
        Rectangle(
          extent={{60,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={102,44,145},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{60,100},{100,80}},
          textColor={255,255,255},
          textString="Pivot
horizontal"),
        Rectangle(
          extent={{-60,20},{-20,-20}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,20},{-20,0}},
          textColor={255,255,255},
          textString="Sliding
vertical"),
        Rectangle(
          extent={{-60,-20},{-20,-60}},
          lineColor={28,108,200},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,-20},{-20,-40}},
          textColor={255,255,255},
          textString="Sliding
horizontal"),
        Rectangle(
          extent={{-60,-60},{-20,-100}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,-80},{-100,-100}},
          textColor={0,0,0},
          fontSize=16,
          textString="geo.")}));
end OpeningArea;
