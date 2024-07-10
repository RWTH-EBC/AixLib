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
    annotation (Placement(transformation(extent={{-160,0},{-140,20}})));
  Modelica.Blocks.Sources.Ramp opnAngSet(
    height=30,
    duration=50,
    startTime=5) "Window opening angle set value"
    annotation (Placement(transformation(extent={{-160,-160},{-140,-140}})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    "Convert from deg to rad"
    annotation (Placement(transformation(extent={{-100,-160},{-80,-140}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple opnSimp(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight) "Simple opening without sash"
    annotation (Placement(transformation(extent={{-80,120},{-60,140}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078 opnSimpVDI2078(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight) "Simple opening without sash, VDI 2078"
    annotation (Placement(transformation(extent={{-40,120},{-20,140}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasSdHunInGeo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Side-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasSdHunInPrj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Side-hung, inward, projective opening"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasSdHunInEqv(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Side-hung, inward, equivalent opening"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasSdHunInEff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Side-hung, inward, effective opening"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasSdHunOutGeo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungOutward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Side-hung, outward, geometric opening"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasBtmHunInGeo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Bottom-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasBtmHunInPrj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Bottom-hung, inward, projective opening"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasBtmHunInEqv(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Bottom-hung, inward, equivalent opening"
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasBtmHunInEff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Bottom-hung, inward, effective opening"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasTopHunOutPrj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.TopHungOutward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Top-hung, outward, projective opening"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasPivVerGeo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Pivot, vertical, geometric opening"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasPivVerPrj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Pivot, vertical, projective opening"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasPivVerEqv(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Pivot, vertical, equivalent opening"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasPivVerEff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Pivot, vertical, effective opening"
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasPivHorGeo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Pivot, horizontal, geometric opening"
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasPivHorPrj(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective)
    "Pivot, horizontal, projective opening"
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasPivHorEqv(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent)
    "Pivot, horizontal, equivalent opening"
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasPivHorEff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Pivot, horizontal, effective opening"
    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasPivHorEffPre(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    use_opnWidth_in=false,
    prescribedOpnWidth=0.5,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective)
    "Pivot, horizontal, effective opening, prescribed input"
    annotation (Placement(transformation(extent={{120,-60},{140,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasSldVerGeo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingVertical,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Sliding, vertical, geometric opening"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasSldHorGeo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SlidingHorizontal,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Sliding, horizontal, geometric opening"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN16798 opnSasBtmHunInDIN16798(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward)
    "Bottom-hung, inward, DIN 16798"
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN4108 opnSasSdHunInDIN4108(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.SideHungInward)
    "Side-hung, inward, DIN 4108"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN4108 opnSasBtmHunInDIN4108(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward)
    "Bottom-hung, inward, DIN 4108"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN4108 opnSasPivHorDIN4108(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.PivotHorizontal,
    sWinSas=sWinSas) "Pivot, horizontal, DIN 4108"
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashHall opnSasBtmHunInHall(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    sWinSas=sWinSas) "Bottom-hung, inward, Hall"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashVDI2078 opnSasBtmHunInVDI2078(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    sWinSas=sWinSas) "Bottom-hung, inward, VDI2078"
    annotation (Placement(transformation(extent={{120,-100},{140,-80}})));
  AixLib.Airflow.WindowVentilation.Utilities.AngleToWidth angToWidth(lenAxs=opnSasAngBtmHunInGeo.lenAxs,
      lenAxsToFrm=opnSasAngBtmHunInGeo.lenAxsToFrm)
    "Convert opening angle to opening width"
    annotation (Placement(transformation(extent={{-60,-160},{-40,-140}})));
  AixLib.Airflow.WindowVentilation.Utilities.WidthToAngle widthToAng(lenAxs=opnSasAngBtmHunInGeo.lenAxs,
      lenAxsToFrm=opnSasAngBtmHunInGeo.lenAxsToFrm)
    "Convert opening width to opening angle"
    annotation (Placement(transformation(extent={{-20,-140},{0,-120}})));
  AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon opnSasAngBtmHunInGeo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
    opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)
    "Input of angle, bottom-hung, inward, geometric opening"
    annotation (Placement(transformation(extent={{20,-160},{40,-140}})));

equation
  connect(opnWidthSet.y, opnSasSdHunInGeo.opnWidth_in) annotation (Line(points={{-139,10},
          {-90,10},{-90,70},{-82,70}},           color={0,0,127}));
  connect(opnWidthSet.y, opnSasSdHunInPrj.opnWidth_in) annotation (Line(points={{-139,10},
          {-90,10},{-90,30},{-82,30}},           color={0,0,127}));
  connect(opnWidthSet.y, opnSasSdHunInEqv.opnWidth_in) annotation (Line(points={{-139,10},
          {-90,10},{-90,-10},{-82,-10}},           color={0,0,127}));
  connect(opnWidthSet.y, opnSasSdHunInEff.opnWidth_in) annotation (Line(points={{-139,10},
          {-90,10},{-90,-50},{-82,-50}},           color={0,0,127}));
  connect(opnWidthSet.y, opnSasSdHunOutGeo.opnWidth_in) annotation (Line(points={{-139,10},
          {-50,10},{-50,70},{-42,70}},           color={0,0,127}));
  connect(opnWidthSet.y, opnSasBtmHunInGeo.opnWidth_in) annotation (Line(points={{-139,10},
          {-10,10},{-10,70},{-2,70}},           color={0,0,127}));
  connect(opnWidthSet.y, opnSasBtmHunInPrj.opnWidth_in) annotation (Line(points={{-139,10},
          {-10,10},{-10,30},{-2,30}},           color={0,0,127}));
  connect(opnWidthSet.y, opnSasBtmHunInEqv.opnWidth_in) annotation (Line(points={{-139,10},
          {-10,10},{-10,-10},{-2,-10}},           color={0,0,127}));
  connect(opnWidthSet.y, opnSasBtmHunInEff.opnWidth_in) annotation (Line(points={{-139,10},
          {-10,10},{-10,-50},{-2,-50}},           color={0,0,127}));
  connect(opnWidthSet.y, opnSasTopHunOutPrj.opnWidth_in) annotation (Line(
        points={{-139,10},{-50,10},{-50,30},{-42,30}}, color={0,0,127}));
  connect(opnWidthSet.y, opnSasPivVerGeo.opnWidth_in) annotation (Line(points={{-139,10},
          {30,10},{30,70},{38,70}},          color={0,0,127}));
  connect(opnWidthSet.y, opnSasPivVerPrj.opnWidth_in) annotation (Line(points={{-139,10},
          {30,10},{30,30},{38,30}},          color={0,0,127}));
  connect(opnWidthSet.y, opnSasPivVerEqv.opnWidth_in) annotation (Line(points={{-139,10},
          {30,10},{30,-10},{38,-10}},          color={0,0,127}));
  connect(opnWidthSet.y, opnSasPivVerEff.opnWidth_in) annotation (Line(points={{-139,10},
          {30,10},{30,-50},{38,-50}},          color={0,0,127}));
  connect(opnWidthSet.y, opnSasPivHorGeo.opnWidth_in) annotation (Line(points={{-139,10},
          {70,10},{70,70},{78,70}},          color={0,0,127}));
  connect(opnWidthSet.y, opnSasPivHorPrj.opnWidth_in) annotation (Line(points={{-139,10},
          {70,10},{70,30},{78,30}},          color={0,0,127}));
  connect(opnWidthSet.y, opnSasPivHorEqv.opnWidth_in) annotation (Line(points={{-139,10},
          {70,10},{70,-10},{78,-10}},          color={0,0,127}));
  connect(opnWidthSet.y, opnSasPivHorEff.opnWidth_in) annotation (Line(points={{-139,10},
          {70,10},{70,-50},{78,-50}},          color={0,0,127}));
  connect(opnWidthSet.y, opnSasSldVerGeo.opnWidth_in) annotation (Line(points={{-139,10},
          {-50,10},{-50,-10},{-42,-10}},          color={0,0,127}));
  connect(opnWidthSet.y, opnSasSldHorGeo.opnWidth_in) annotation (Line(points={{-139,10},
          {-50,10},{-50,-50},{-42,-50}},          color={0,0,127}));
  connect(opnAngSet.y, from_deg.u) annotation (Line(points={{-139,-150},{-102,-150}},
                                color={0,0,127}));
  connect(opnWidthSet.y, opnSasBtmHunInDIN16798.opnWidth_in) annotation (Line(
        points={{-139,10},{-90,10},{-90,-90},{-82,-90}}, color={0,0,127}));
  connect(opnWidthSet.y, opnSasSdHunInDIN4108.opnWidth_in) annotation (Line(
        points={{-139,10},{-90,10},{-90,-70},{-50,-70},{-50,-90},{-42,-90}},
        color={0,0,127}));
  connect(opnWidthSet.y, opnSasBtmHunInDIN4108.opnWidth_in) annotation (Line(
        points={{-139,10},{-90,10},{-90,-70},{-10,-70},{-10,-90},{-2,-90}},
        color={0,0,127}));
  connect(opnWidthSet.y, opnSasPivHorDIN4108.opnWidth_in) annotation (Line(
        points={{-139,10},{-90,10},{-90,-70},{30,-70},{30,-90},{38,-90}},
        color={0,0,127}));
  connect(opnWidthSet.y, opnSasBtmHunInHall.opnWidth_in) annotation (Line(
        points={{-139,10},{-90,10},{-90,-70},{70,-70},{70,-90},{78,-90}}, color=
         {0,0,127}));
  connect(opnWidthSet.y, opnSasBtmHunInVDI2078.opnWidth_in) annotation (Line(
        points={{-139,10},{-90,10},{-90,-70},{110,-70},{110,-90},{118,-90}},
                                                                          color=
         {0,0,127}));
  connect(from_deg.y, angToWidth.u)
    annotation (Line(points={{-79,-150},{-62,-150}},
                                                   color={0,0,127}));
  connect(angToWidth.y, opnSasAngBtmHunInGeo.opnWidth_in)
    annotation (Line(points={{-39,-150},{18,-150}},
                                                  color={0,0,127}));
  connect(angToWidth.y, widthToAng.u) annotation (Line(points={{-39,-150},{-30,-150},
          {-30,-130},{-22,-130}},
                                color={0,0,127}));
  annotation (experiment(
      StopTime=60,
      Interval=1,
      __Dymola_Algorithm="Dassl"), Diagram(coordinateSystem(extent={{-160,-160},
            {160,160}}),                   graphics={
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
          extent={{-140,80},{-100,60}},
          textColor={0,0,0},
          fontSize=16,
          textString="geo."),
        Text(
          extent={{-140,40},{-100,20}},
          textColor={0,0,0},
          fontSize=16,
          textString="prj."),
        Text(
          extent={{-140,0},{-100,-20}},
          textColor={0,0,0},
          fontSize=16,
          textString="eqv."),
        Text(
          extent={{-140,-40},{-100,-60}},
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
          extent={{20,100},{60,-60}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{20,100},{60,80}},
          textColor={255,255,255},
          textString="Pivot
vertical"),
        Rectangle(
          extent={{60,100},{100,-60}},
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
          extent={{-140,-80},{-100,-100}},
          textColor={0,0,0},
          fontSize=15,
          textString="others"),
        Text(
          extent={{-160,160},{0,140}},
          textColor={0,0,0},
          fontSize=14,
          textString="Simple opening",
          horizontalAlignment=TextAlignment.Left),
        Text(
          extent={{-160,120},{0,100}},
          textColor={0,0,0},
          fontSize=13,
          horizontalAlignment=TextAlignment.Left,
          textString="Sash opening (input opening width)"),
        Text(
          extent={{-160,-100},{0,-120}},
          textColor={0,0,0},
          fontSize=12,
          horizontalAlignment=TextAlignment.Left,
          textString="Sash opening (input opening angle)")}),
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
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Airflow/WindowVentilation/Examples/OpeningArea.mos"
        "Simulate and plot"));
end OpeningArea;
