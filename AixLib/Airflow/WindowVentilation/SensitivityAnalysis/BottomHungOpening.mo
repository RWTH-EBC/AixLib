within AixLib.Airflow.WindowVentilation.SensitivityAnalysis;
model BottomHungOpening "Analysis of bottom-hung opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialSensitivityAnalysis;
  parameter Modelica.Units.SI.Thickness sWinSas(min=0) = 0
    "Window sash thickness (depth)";

  Modelica.Blocks.Interfaces.RealInput opnWidth_in(
    final quantity="Length", final unit="m", min=0)
    "Input port for window sash opening width"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.GidsPhaff gidsPhaff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric))
    "Model de Gids Phaff"
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.WarrenParkins warrenParkins(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric))
    "Model Warren Parkins"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.Maas maas(
    winClrWidth=winClrWidth, winClrHeight=winClrHeight) "Model Maas"
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.Hall hall(
    winClrWidth=winClrWidth, winClrHeight=winClrHeight,
    sWinSas=sWinSas)                                    "Model Hall"
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.LarsenHeiselberg larsenHeiselberg(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric),
    aziRef=0,
    winSpeLim=0.25)
              "Model Larsen Heiselberg"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.Caciolo caciolo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric),
    aziRef=0) "Model caciolo"
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.Tang tang(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric),
    dTLim=0.02)
    "Model Tang"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.VDI2078 vdi2078(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashVDI2078 (
          sWinSas=sWinSas),
    sunShaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.NoSunshading)
    "Model VDI 2078"
               annotation (Placement(transformation(extent={{60,20},{80,40}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.DIN16798 din16798(
    winClrWidth=winClrHeight,
    winClrHeight=winClrWidth,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN16798 (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward),
    heightASL=0) "Model DIN EN 16798-7"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.DIN4108 din4108(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN4108 (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward))
    "Model DIN/TS 4108-8"
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.ASHRAE ashrae(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon (
          opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric),
    aziRef=0) "Model ASHRAE"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Utilities.WindProfilePowerLaw winSpePro13(height=13, heightRef=10)
    "Calculate wind speed profile at height of 13 m"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
equation
  connect(opnWidth_in, gidsPhaff.opnWidth_in)
    annotation (Line(points={{0,120},{0,102},{30,102}}, color={0,0,127}));
  connect(opnWidth_in, warrenParkins.opnWidth_in)
    annotation (Line(points={{0,120},{0,62},{30,62}}, color={0,0,127}));
  connect(opnWidth_in, maas.opnWidth_in)
    annotation (Line(points={{0,120},{0,22},{30,22}}, color={0,0,127}));
  connect(opnWidth_in, hall.opnWidth_in)
    annotation (Line(points={{0,120},{0,-18},{30,-18}}, color={0,0,127}));
  connect(opnWidth_in, larsenHeiselberg.opnWidth_in)
    annotation (Line(points={{0,120},{0,-58},{30,-58}}, color={0,0,127}));
  connect(opnWidth_in, caciolo.opnWidth_in)
    annotation (Line(points={{0,120},{0,-98},{30,-98}}, color={0,0,127}));
  connect(opnWidth_in, tang.opnWidth_in)
    annotation (Line(points={{0,120},{0,82},{70,82}}, color={0,0,127}));
  connect(opnWidth_in, vdi2078.opnWidth_in)
    annotation (Line(points={{0,120},{0,42},{70,42}}, color={0,0,127}));
  connect(opnWidth_in, din16798.opnWidth_in)
    annotation (Line(points={{0,120},{0,2},{70,2}}, color={0,0,127}));
  connect(opnWidth_in, din4108.opnWidth_in)
    annotation (Line(points={{0,120},{0,-38},{70,-38}}, color={0,0,127}));
  connect(opnWidth_in, ashrae.opnWidth_in)
    annotation (Line(points={{0,120},{0,-78},{70,-78}}, color={0,0,127}));
  connect(TRoom, gidsPhaff.TRoom) annotation (Line(points={{-120,80},{-40,80},{
          -40,98},{18,98}}, color={0,0,127}));
  connect(TRoom, warrenParkins.TRoom) annotation (Line(points={{-120,80},{-40,
          80},{-40,58},{18,58}}, color={0,0,127}));
  connect(TRoom, maas.TRoom) annotation (Line(points={{-120,80},{-40,80},{-40,
          18},{18,18}}, color={0,0,127}));
  connect(TRoom, hall.TRoom) annotation (Line(points={{-120,80},{-40,80},{-40,
          -22},{18,-22}}, color={0,0,127}));
  connect(TRoom, larsenHeiselberg.TRoom) annotation (Line(points={{-120,80},{
          -40,80},{-40,-62},{18,-62}}, color={0,0,127}));
  connect(TRoom, caciolo.TRoom) annotation (Line(points={{-120,80},{-40,80},{
          -40,-102},{18,-102}}, color={0,0,127}));
  connect(TRoom, tang.TRoom) annotation (Line(points={{-120,80},{-40,80},{-40,
          78},{58,78}}, color={0,0,127}));
  connect(TRoom, vdi2078.TRoom) annotation (Line(points={{-120,80},{-40,80},{
          -40,38},{58,38}}, color={0,0,127}));
  connect(TRoom, din16798.TRoom) annotation (Line(points={{-120,80},{-40,80},{
          -40,-2},{58,-2}}, color={0,0,127}));
  connect(TRoom, din4108.TRoom) annotation (Line(points={{-120,80},{-40,80},{
          -40,-42},{58,-42}}, color={0,0,127}));
  connect(TRoom, ashrae.TRoom) annotation (Line(points={{-120,80},{-40,80},{-40,
          -82},{58,-82}}, color={0,0,127}));
  connect(TAmb, gidsPhaff.TAmb) annotation (Line(points={{-120,40},{-30,40},{
          -30,94},{18,94}}, color={0,0,127}));
  connect(TAmb, warrenParkins.TAmb) annotation (Line(points={{-120,40},{-30,40},
          {-30,54},{18,54}}, color={0,0,127}));
  connect(TAmb, maas.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,14},
          {18,14}}, color={0,0,127}));
  connect(TAmb, hall.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,-26},
          {18,-26}}, color={0,0,127}));
  connect(TAmb, larsenHeiselberg.TAmb) annotation (Line(points={{-120,40},{-30,
          40},{-30,-66},{18,-66}}, color={0,0,127}));
  connect(TAmb, caciolo.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          -106},{18,-106}}, color={0,0,127}));
  connect(TAmb, tang.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,74},
          {58,74}}, color={0,0,127}));
  connect(TAmb, vdi2078.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          34},{58,34}}, color={0,0,127}));
  connect(TAmb, din16798.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          -6},{58,-6}}, color={0,0,127}));
  connect(TAmb, din4108.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          -46},{58,-46}}, color={0,0,127}));
  connect(TAmb, ashrae.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          -86},{58,-86}}, color={0,0,127}));
  connect(winSpe10, gidsPhaff.winSpe10) annotation (Line(points={{-120,-20},{
          -90,-20},{-90,88},{18,88}}, color={0,0,127}));
  connect(winSpe10, warrenParkins.winSpe10) annotation (Line(points={{-120,-20},
          {-90,-20},{-90,48},{18,48}}, color={0,0,127}));
  connect(winSpe10, winSpePro13.winSpeRef) annotation (Line(points={{-120,-20},
          {-90,-20},{-90,10},{-82,10}}, color={0,0,127}));
  connect(winSpePro13.winSpe, maas.winSpe13)
    annotation (Line(points={{-59,10},{18,10},{18,8}}, color={0,0,127}));
  connect(winSpe10, larsenHeiselberg.winSpe10) annotation (Line(points={{-120,
          -20},{-90,-20},{-90,-72},{18,-72}}, color={0,0,127}));
  connect(winSpeProLoc.winSpe, caciolo.winSpeLoc) annotation (Line(points={{-59,
          -20},{-50,-20},{-50,-112},{18,-112}}, color={0,0,127}));
  connect(winSpe10, din16798.winSpe10) annotation (Line(points={{-120,-20},{-90,
          -20},{-90,-12},{58,-12}}, color={0,0,127}));
  connect(winSpeProLoc.winSpe, din4108.winSpeLoc) annotation (Line(points={{-59,
          -20},{-50,-20},{-50,-52},{58,-52}}, color={0,0,127}));
  connect(winSpeProLoc.winSpe, ashrae.winSpeLoc) annotation (Line(points={{-59,
          -20},{-50,-20},{-50,-92},{58,-92}}, color={0,0,127}));
  connect(winDir, larsenHeiselberg.winDir) annotation (Line(points={{-120,-60},
          {-20,-60},{-20,-76},{18,-76}}, color={0,0,127}));
  connect(winDir, caciolo.winDir) annotation (Line(points={{-120,-60},{-20,-60},
          {-20,-116},{18,-116}}, color={0,0,127}));
  connect(winDir, ashrae.winDir) annotation (Line(points={{-120,-60},{-20,-60},
          {-20,-96},{58,-96}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
    October 21, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1608\">issue 1608</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model is set up for sensitivity analysis and contains 11 different empirical expressions for bottom-hung window openings.</p>
</html>"));
end BottomHungOpening;
