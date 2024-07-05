within AixLib.Airflow.WindowVentilation.Examples;
model OpeningArea "Calculation of different opening areas"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Length winClrWidth = 1.0 "Window clear width";
  parameter Modelica.Units.SI.Height winClrHeight = 1.5 "Window clear height";
  parameter Modelica.Units.SI.Thickness sWinSas = 0.08 "Window sash thickness";
  Modelica.Blocks.Sources.Ramp opnWidthSet(
    height=0.5,
    duration=50,
    startTime=5) "Window opening width set value"
    annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
  Modelica.Blocks.Sources.Ramp opnAngSet(
    height=30,
    duration=50,
    startTime=5) "Window opening angle set value"
    annotation (Placement(transformation(extent={{-140,120},{-120,140}})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    "Convert from deg to rad"
    annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple openingAreaSimple(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight) "Simple opening without sash"
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_side_hung_in_geo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Side-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_side_hung_in_prj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Side-hung, inward, projective opening"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_side_hung_in_eqv(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Side-hung, inward, equivalent opening"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_side_hung_in_eff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Side-hung, inward, effective opening"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_side_hung_out_geo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Side-hung, outward, geometric opening"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_bottom_hung_in_geo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Bottom-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_bottom_hung_in_prj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Bottom-hung, inward, projective opening"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_bottom_hung_in_eqv(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Bottom-hung, inward, equivalent opening"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_bottom_hung_in_eff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Bottom-hung, inward, effective opening"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_top_hung_out_prj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Top-hung, outward, projective opening"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_pivot_vertical_geo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Pivot, vertical, geometric opening"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_pivot_vertical_prj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Pivot, vertical, projective opening"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_pivot_vertical_eqv(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Pivot, vertical, equivalent opening"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_pivot_vertical_eff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Pivot, vertical, effective opening"
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_pivot_horizontal_geo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Pivot, horizontal, geometric opening"
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_pivot_horizontal_prj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Pivot, horizontal, projective opening"
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_pivot_horizontal_eqv(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Pivot, horizontal, equivalent opening"
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_pivot_horizontal_eff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Pivot, horizontal, effective opening"
    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_sliding_vertical_geo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Sliding, vertical, geometric opening"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon openingAreaSash_sliding_horizontal_geo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Sliding, horizontal, geometric opening"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  OpeningAreas.OpeningAreaSimpleVDI2078 openingAreaSimpleVDI2078(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight) "Simple opening without sash"
    annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  OpeningAreas.OpeningAreaSashDIN16798 openingAreaSashDIN16798_bottom_hung_in(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward)
    "Bottom-hung, inward, DIN 16798"
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  OpeningAreas.OpeningAreaSashDIN4108 openingAreaSashDIN4108_side_hung_in(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward)
    "Side-hung, inward, DIN 4108"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  OpeningAreas.OpeningAreaSashHall openingAreaSashHall(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    sWinSas=sWinSas) "Bottom-hung, inward, Hall"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  OpeningAreas.OpeningAreaSashVDI2078 openingAreaSashVDI2078(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    sWinSas=sWinSas) "Bottom-hung, inward, VDI2078"
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  OpeningAreas.OpeningAreaSashDIN4108 openingAreaSashDIN4108_bottom_hung_in(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward)
    "Bottom-hung, inward, DIN 4108"
    annotation (Placement(transformation(extent={{-40,-132},{-20,-112}})));
  OpeningAreas.OpeningAreaSashDIN4108
    openingAreaSashDIN4108_pivot_horizontal_in(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    sWinSas=sWinSas)
    "Pivot, horizontal, DIN 4108"
    annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  OpeningAreas.OpeningAreaSashCommon openingAreaSash_pivot_horizontal_eff_pre(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    use_opnWidth_in=false,
    prescribedOpnWidth=0.5,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Pivot, horizontal, effective opening, prescribed input"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Utilities.AngleToWidth angleToWidth(
    lenAxs=openingAreaSash_bottom_hung_in_geo_ang.lenAxs,
    lenAxsToFrm=openingAreaSash_bottom_hung_in_geo_ang.lenAxsToFrm)
    "Convert opening angle to opening width"
    annotation (Placement(transformation(extent={{-60,120},{-40,140}})));
  OpeningAreas.OpeningAreaSashCommon openingAreaSash_bottom_hung_in_geo_ang(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Bottom-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{0,120},{20,140}})));
  Utilities.WidthToAngle widthToAngle(
    lenAxs=openingAreaSash_bottom_hung_in_geo_ang.lenAxs,
    lenAxsToFrm=openingAreaSash_bottom_hung_in_geo_ang.lenAxsToFrm)
    "Convert opening width to opening angle"
    annotation (Placement(transformation(extent={{-20,140},{0,160}})));
equation
  connect(opnWidthSet.y, openingAreaSash_side_hung_in_geo.opnWidth_in) annotation (
      Line(points={{-119,10},{-90,10},{-90,70},{-82,70}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_side_hung_in_prj.opnWidth_in) annotation (
      Line(points={{-119,10},{-90,10},{-90,30},{-82,30}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_side_hung_in_eqv.opnWidth_in) annotation (
      Line(points={{-119,10},{-90,10},{-90,-10},{-82,-10}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_side_hung_in_eff.opnWidth_in) annotation (
      Line(points={{-119,10},{-90,10},{-90,-50},{-82,-50}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_side_hung_out_geo.opnWidth_in) annotation (
      Line(points={{-119,10},{-50,10},{-50,70},{-42,70}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_bottom_hung_in_geo.opnWidth_in) annotation (
      Line(points={{-119,10},{-10,10},{-10,70},{-2,70}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_bottom_hung_in_prj.opnWidth_in) annotation (
      Line(points={{-119,10},{-10,10},{-10,30},{-2,30}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_bottom_hung_in_eqv.opnWidth_in) annotation (
      Line(points={{-119,10},{-10,10},{-10,-10},{-2,-10}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_bottom_hung_in_eff.opnWidth_in) annotation (
      Line(points={{-119,10},{-10,10},{-10,-50},{-2,-50}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_top_hung_out_prj.opnWidth_in) annotation (
      Line(points={{-119,10},{-50,10},{-50,30},{-42,30}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_pivot_vertical_geo.opnWidth_in) annotation (
      Line(points={{-119,10},{30,10},{30,70},{38,70}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_pivot_vertical_prj.opnWidth_in) annotation (
      Line(points={{-119,10},{30,10},{30,30},{38,30}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_pivot_vertical_eqv.opnWidth_in)
    annotation (Line(points={{-119,10},{30,10},{30,-10},{38,-10}}, color={0,0,
          127}));
  connect(opnWidthSet.y, openingAreaSash_pivot_vertical_eff.opnWidth_in) annotation (
      Line(points={{-119,10},{30,10},{30,-50},{38,-50}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_pivot_horizontal_geo.opnWidth_in)
    annotation (Line(points={{-119,10},{70,10},{70,70},{78,70}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_pivot_horizontal_prj.opnWidth_in)
    annotation (Line(points={{-119,10},{70,10},{70,30},{78,30}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_pivot_horizontal_eqv.opnWidth_in)
    annotation (Line(points={{-119,10},{70,10},{70,-10},{78,-10}}, color={0,0,
          127}));
  connect(opnWidthSet.y, openingAreaSash_pivot_horizontal_eff.opnWidth_in)
    annotation (Line(points={{-119,10},{70,10},{70,-50},{78,-50}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSash_sliding_vertical_geo.opnWidth_in)
    annotation (Line(points={{-119,10},{-50,10},{-50,-10},{-42,-10}}, color={0,0,
          127}));
  connect(opnWidthSet.y, openingAreaSash_sliding_horizontal_geo.opnWidth_in)
    annotation (Line(points={{-119,10},{-50,10},{-50,-50},{-42,-50}}, color={0,0,
          127}));
  connect(opnAngSet.y, from_deg.u) annotation (Line(points={{-119,130},{-102,130}},
                                color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSashDIN16798_bottom_hung_in.opnWidth_in)
    annotation (Line(points={{-119,10},{-90,10},{-90,-90},{-82,-90}}, color={0,0,
          127}));
  connect(opnWidthSet.y, openingAreaSashDIN4108_side_hung_in.opnWidth_in)
    annotation (Line(points={{-119,10},{-90,10},{-90,-70},{-50,-70},{-50,-90},{-42,
          -90}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSashDIN4108_bottom_hung_in.opnWidth_in)
    annotation (Line(points={{-119,10},{-90,10},{-90,-70},{-50,-70},{-50,-122},{
          -42,-122}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSashDIN4108_pivot_horizontal_in.opnWidth_in)
    annotation (Line(points={{-119,10},{-90,10},{-90,-70},{-50,-70},{-50,-150},{
          -42,-150}}, color={0,0,127}));
  connect(opnWidthSet.y, openingAreaSashHall.opnWidth_in) annotation (Line(
        points={{-119,10},{-90,10},{-90,-70},{-8,-70},{-8,-90},{-2,-90}}, color=
         {0,0,127}));
  connect(opnWidthSet.y, openingAreaSashVDI2078.opnWidth_in) annotation (Line(
        points={{-119,10},{-90,10},{-90,-70},{30,-70},{30,-90},{38,-90}}, color=
         {0,0,127}));
  connect(from_deg.y, angleToWidth.u)
    annotation (Line(points={{-79,130},{-62,130}}, color={0,0,127}));
  connect(angleToWidth.y, openingAreaSash_bottom_hung_in_geo_ang.opnWidth_in)
    annotation (Line(points={{-39,130},{-2,130}}, color={0,0,127}));
  connect(angleToWidth.y, widthToAngle.u) annotation (Line(points={{-39,130},{-30,
          130},{-30,150},{-22,150}}, color={0,0,127}));
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
          extent={{-20,100},{20,-60}},
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
          extent={{18,100},{60,-60}},
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
        Text(
          extent={{-120,-80},{-100,-100}},
          textColor={0,0,0},
          fontSize=15,
          textString="others")}),
    Documentation(revisions="<html>
<ul>
  <li>
    June 13, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This example simulates and checks the models in package <a href=\"modelica://AixLib/Airflow/WindowVentilation/OpeningAreas/package.mo\">OpeningAreas</a>, calculating the window opening area with variable opening width or angle.</p>
<p>The icon of the model changes itself automatically to indicate the type of window opening that is now being set.</p>
</html>"));
end OpeningArea;
