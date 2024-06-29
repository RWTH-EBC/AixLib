within AixLib.Airflow.WindowVentilation.Examples;
model VentilationFlowRateSimpleOpening
  "Use different empirical expressions to determine the window ventilation flow rate by simple opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialExampleVentilationFlowRate;
  EmpiricalExpressions.WarrenParkins warrenParkins(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple
      openingArea) "Model Warren Parkins"
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  EmpiricalExpressions.GidsPhaff gidsPhaff(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple
      openingArea) "Model de Gids Phaff"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  EmpiricalExpressions.LarsenHeiselberg larsenHeiselberg(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple
      openingArea,
    aziRef=aziRef) "Model Larsen Heiselberg"
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  EmpiricalExpressions.Caciolo caciolo(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple
      openingArea,
    aziRef=aziRef) "Model Caciolo"
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Utilities.WindProfilePowerLaw winSpeProLoc(height=locHeight, heightRef=10)
    "Calculate wind speed profile local"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  EmpiricalExpressions.Tang tang(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple
      openingArea) "Modell Tang"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  EmpiricalExpressions.VDI2078 vDI2078_1(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078
      openingArea,
    sunShaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.NoSunshading)
    "Model VDI 2078"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  EmpiricalExpressions.VDI2078 vDI2078_2(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078
      openingArea,
    sunShaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.SunshadingInstallationTypesVDI2078.ExternalBlindsOn)
    "Model VDI 2078"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  EmpiricalExpressions.VDI2078 vDI2078_3(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable
      AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078
      openingArea,
    use_cofSunSha_in=true) "Model VDI 2078"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  EmpiricalExpressions.DIN16798 dIN16798_1(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple
      openingArea,
    heightASL=200) "Model DIN 16798"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  EmpiricalExpressions.DIN4108 dIN4108_1(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple
      openingArea)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  EmpiricalExpressions.ASHRAE aSHRAE(
    winClrWidth=winClrWidth,
    winClrHeight=winClrHeight,
    redeclare replaceable AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple
      openingArea,
    aziRef=aziRef)
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Modelica.Blocks.Sources.Pulse cofSunShaSet(
    amplitude=0.5,
    period=10,
    offset=0.5) "Set sunshading coefficient"
    annotation (Placement(transformation(extent={{50,10},{60,20}})));
equation
  connect(from_degC.y, warrenParkins.TRoom) annotation (Line(points={{-39,90},{10,
          90},{10,98},{18,98}}, color={0,0,127}));
  connect(from_degC1.y, warrenParkins.TAmb) annotation (Line(points={{-39,60},{0,
          60},{0,94},{18,94}}, color={0,0,127}));
  connect(winSpe10Set.y, warrenParkins.winSpe10) annotation (Line(points={{-79,30},
          {-10,30},{-10,88},{18,88}}, color={0,0,127}));
  connect(gidsPhaff.TRoom, warrenParkins.TRoom) annotation (Line(points={{18,58},
          {10,58},{10,98},{18,98}}, color={0,0,127}));
  connect(gidsPhaff.TAmb, warrenParkins.TAmb)
    annotation (Line(points={{18,54},{0,54},{0,94},{18,94}}, color={0,0,127}));
  connect(gidsPhaff.winSpe10, warrenParkins.winSpe10) annotation (Line(points={{
          18,48},{-10,48},{-10,88},{18,88}}, color={0,0,127}));
  connect(larsenHeiselberg.TRoom, warrenParkins.TRoom) annotation (Line(points={
          {18,18},{10,18},{10,98},{18,98}}, color={0,0,127}));
  connect(larsenHeiselberg.TAmb, warrenParkins.TAmb)
    annotation (Line(points={{18,14},{0,14},{0,94},{18,94}}, color={0,0,127}));
  connect(larsenHeiselberg.winSpe10, warrenParkins.winSpe10) annotation (Line(
        points={{18,8},{-10,8},{-10,88},{18,88}}, color={0,0,127}));
  connect(winDirSet.y, larsenHeiselberg.winDir) annotation (Line(points={{-79,0},
          {-20,0},{-20,4},{18,4}}, color={0,0,127}));
  connect(caciolo.TRoom, warrenParkins.TRoom) annotation (Line(points={{18,-22},
          {10,-22},{10,98},{18,98}}, color={0,0,127}));
  connect(caciolo.TAmb, warrenParkins.TAmb) annotation (Line(points={{18,-26},{0,
          -26},{0,94},{18,94}}, color={0,0,127}));
  connect(winSpe10Set.y, winSpeProLoc.winSpeRef) annotation (Line(points={{-79,30},
          {-70,30},{-70,-30},{-62,-30}}, color={0,0,127}));
  connect(winSpeProLoc.winSpe, caciolo.winSpeLoc) annotation (Line(points={{-39,
          -30},{-30,-30},{-30,-32},{18,-32}}, color={0,0,127}));
  connect(caciolo.winDir, larsenHeiselberg.winDir) annotation (Line(points={{18,
          -36},{-20,-36},{-20,4},{18,4}}, color={0,0,127}));
  connect(tang.TRoom, warrenParkins.TRoom) annotation (Line(points={{18,-62},{10,
          -62},{10,98},{18,98}}, color={0,0,127}));
  connect(tang.TAmb, warrenParkins.TAmb) annotation (Line(points={{18,-66},{0,-66},
          {0,94},{18,94}}, color={0,0,127}));
  connect(vDI2078_1.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,78},
          {10,78},{10,98},{18,98}}, color={0,0,127}));
  connect(vDI2078_1.TAmb, warrenParkins.TAmb)
    annotation (Line(points={{58,74},{0,74},{0,94},{18,94}}, color={0,0,127}));
  connect(vDI2078_2.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,58},
          {52,58},{52,78},{10,78},{10,98},{18,98}}, color={0,0,127}));
  connect(vDI2078_2.TAmb, warrenParkins.TAmb) annotation (Line(points={{58,54},{
          48,54},{48,74},{0,74},{0,94},{18,94}}, color={0,0,127}));
  connect(dIN16798_1.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,-2},
          {10,-2},{10,98},{18,98}}, color={0,0,127}));
  connect(dIN16798_1.TAmb, warrenParkins.TAmb)
    annotation (Line(points={{58,-6},{0,-6},{0,94},{18,94}}, color={0,0,127}));
  connect(dIN16798_1.winSpe10, warrenParkins.winSpe10) annotation (Line(points={
          {58,-12},{-10,-12},{-10,88},{18,88}}, color={0,0,127}));
  connect(dIN4108_1.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,-42},
          {10,-42},{10,98},{18,98}}, color={0,0,127}));
  connect(dIN4108_1.TAmb, warrenParkins.TAmb) annotation (Line(points={{58,-46},
          {0,-46},{0,94},{18,94}}, color={0,0,127}));
  connect(dIN4108_1.winSpeLoc, caciolo.winSpeLoc) annotation (Line(points={{58,-52},
          {-30,-52},{-30,-32},{18,-32}}, color={0,0,127}));
  connect(aSHRAE.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,-82},{
          10,-82},{10,98},{18,98}}, color={0,0,127}));
  connect(aSHRAE.TAmb, warrenParkins.TAmb) annotation (Line(points={{58,-86},{0,
          -86},{0,94},{18,94}}, color={0,0,127}));
  connect(aSHRAE.winSpeLoc, caciolo.winSpeLoc) annotation (Line(points={{58,-92},
          {-30,-92},{-30,-32},{18,-32}}, color={0,0,127}));
  connect(aSHRAE.winDir, larsenHeiselberg.winDir) annotation (Line(points={{58,-96},
          {-20,-96},{-20,4},{18,4}}, color={0,0,127}));
  connect(vDI2078_3.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,38},
          {52,38},{52,78},{10,78},{10,98},{18,98}}, color={0,0,127}));
  connect(vDI2078_3.TAmb, warrenParkins.TAmb) annotation (Line(points={{58,34},{
          48,34},{48,74},{0,74},{0,94},{18,94}}, color={0,0,127}));
  connect(cofSunShaSet.y, vDI2078_3.cofSunSha_in)
    annotation (Line(points={{60.5,15},{70,15},{70,18}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This example checks the models that simulate the window ventilation flow rate with the simple opening.</p>
<p>The result shows that the estimated volume flow can be quite different when using different models.</p>
</html>"));
end VentilationFlowRateSimpleOpening;
