within AixLib.Airflow.WindowVentilation.SensitivityAnalysis;
model SimpleOpening "Analysis of simple opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialSensitivityAnalysis;
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.GidsPhaff gidsPhaff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple)
    "Model de Gids Phaff"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.WarrenParkins warrenParkins(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple)
    "Model Warren Parkins"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.LarsenHeiselberg larsenHeiselberg(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    aziRef=0,
    winSpeLim=0.25)
              "Model Larsen Heiselberg"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.Caciolo caciolo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    aziRef=0) "Model caciolo"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.Tang tang(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    dTLim=0.02)
    "Model Tang"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.VDI2078 vdi2078(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078,
    sunShaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.NoSunshading)
    "Model VDI 2078"
               annotation (Placement(transformation(extent={{40,60},{60,80}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.DIN16798 din16798(
    winClrWidth=winClrHeight,
    winClrHeight=winClrWidth,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    heightASL=0) "Model DIN EN 16798-7"
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.DIN4108 din4108(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple)
    "Model DIN/TS 4108-8"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  AixLib.Airflow.WindowVentilation.EmpiricalExpressions.ASHRAE ashrae(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple,
    aziRef=0) "Model ASHRAE"
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
equation
  connect(TRoom, gidsPhaff.TRoom) annotation (Line(points={{-120,80},{-40,80},{-40,
          98},{-2,98}}, color={0,0,127}));
  connect(TRoom, warrenParkins.TRoom) annotation (Line(points={{-120,80},{-40,80},
          {-40,58},{-2,58}}, color={0,0,127}));
  connect(TRoom, larsenHeiselberg.TRoom) annotation (Line(points={{-120,80},{
          -40,80},{-40,18},{-2,18}}, color={0,0,127}));
  connect(TRoom, caciolo.TRoom) annotation (Line(points={{-120,80},{-40,80},{
          -40,-22},{-2,-22}}, color={0,0,127}));
  connect(TRoom, tang.TRoom) annotation (Line(points={{-120,80},{-40,80},{-40,
          -62},{-2,-62}}, color={0,0,127}));
  connect(TRoom, vdi2078.TRoom) annotation (Line(points={{-120,80},{-40,80},{
          -40,78},{38,78}}, color={0,0,127}));
  connect(TRoom, din16798.TRoom) annotation (Line(points={{-120,80},{-40,80},{
          -40,38},{38,38}}, color={0,0,127}));
  connect(TRoom, din4108.TRoom) annotation (Line(points={{-120,80},{-40,80},{
          -40,-2},{38,-2}}, color={0,0,127}));
  connect(TRoom, ashrae.TRoom) annotation (Line(points={{-120,80},{-40,80},{-40,
          -42},{38,-42}}, color={0,0,127}));
  connect(TAmb, gidsPhaff.TAmb) annotation (Line(points={{-120,40},{-30,40},{
          -30,94},{-2,94}}, color={0,0,127}));
  connect(TAmb, warrenParkins.TAmb) annotation (Line(points={{-120,40},{-30,40},
          {-30,54},{-2,54}}, color={0,0,127}));
  connect(TAmb, larsenHeiselberg.TAmb) annotation (Line(points={{-120,40},{-30,
          40},{-30,14},{-2,14}}, color={0,0,127}));
  connect(TAmb, caciolo.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          -26},{-2,-26}}, color={0,0,127}));
  connect(TAmb, tang.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,-66},
          {-2,-66}}, color={0,0,127}));
  connect(TAmb, vdi2078.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          74},{38,74}}, color={0,0,127}));
  connect(TAmb, din16798.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          34},{38,34}}, color={0,0,127}));
  connect(TAmb, din4108.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          -6},{38,-6}}, color={0,0,127}));
  connect(TAmb, ashrae.TAmb) annotation (Line(points={{-120,40},{-30,40},{-30,
          -46},{38,-46}}, color={0,0,127}));
  connect(winSpe10, gidsPhaff.winSpe10) annotation (Line(points={{-120,-20},{
          -90,-20},{-90,88},{-2,88}}, color={0,0,127}));
  connect(winSpe10, warrenParkins.winSpe10) annotation (Line(points={{-120,-20},
          {-90,-20},{-90,48},{-2,48}}, color={0,0,127}));
  connect(winSpe10, larsenHeiselberg.winSpe10) annotation (Line(points={{-120,
          -20},{-90,-20},{-90,8},{-2,8}}, color={0,0,127}));
  connect(winSpeProLoc.winSpe, caciolo.winSpeLoc) annotation (Line(points={{-59,
          -20},{-50,-20},{-50,-32},{-2,-32}}, color={0,0,127}));
  connect(winSpe10, din16798.winSpe10) annotation (Line(points={{-120,-20},{-90,
          -20},{-90,28},{38,28}}, color={0,0,127}));
  connect(winSpeProLoc.winSpe, din4108.winSpeLoc) annotation (Line(points={{-59,
          -20},{-50,-20},{-50,-12},{38,-12}}, color={0,0,127}));
  connect(winSpeProLoc.winSpe, ashrae.winSpeLoc) annotation (Line(points={{-59,
          -20},{-50,-20},{-50,-52},{38,-52}}, color={0,0,127}));
  connect(winDir, larsenHeiselberg.winDir) annotation (Line(points={{-120,-60},
          {-20,-60},{-20,4},{-2,4}}, color={0,0,127}));
  connect(winDir, caciolo.winDir) annotation (Line(points={{-120,-60},{-20,-60},
          {-20,-36},{-2,-36}}, color={0,0,127}));
  connect(winDir, ashrae.winDir) annotation (Line(points={{-120,-60},{-20,-60},
          {-20,-56},{38,-56}}, color={0,0,127}));
end SimpleOpening;
