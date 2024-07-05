within AixLib.Airflow.WindowVentilation.Examples;
model VentilationFlowRateSashOpening
  "Use different empirical expressions to determine the window ventilation flow rate by sash opening"
  extends
    AixLib.Airflow.WindowVentilation.Examples.VentilationFlowRateSimpleOpening(
    warrenParkins(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon
        openingArea(opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)),
    gidsPhaff(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon
        openingArea(opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)),
    larsenHeiselberg(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon
        openingArea(opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)),
    caciolo(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon
        openingArea(opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)),
    tang(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon
        openingArea(opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward,
          opnAreaTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric)),
    vDI2078_1(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashVDI2078
        openingArea),
    vDI2078_2(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashVDI2078
        openingArea(use_opnWidth_in=false, prescribedOpnWidth=0.1)),
    vDI2078_3(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashVDI2078
        openingArea(use_opnWidth_in=false, prescribedOpnWidth=0.1)),
    dIN16798_1(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN16798
        openingArea(opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward)),
    dIN4108_1(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashDIN4108
        openingArea(opnTyp=AixLib.Airflow.WindowVentilation.BaseClasses.Types.WindowOpeningTypes.BottomHungInward)),
    aSHRAE(redeclare
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSashCommon
        openingArea));
  Modelica.Blocks.Sources.SawTooth winOpnWidthSet(amplitude=0.3, period=10)
    "Set window opening width"
    annotation (Placement(transformation(extent={{120,100},{100,120}})));
  Modelica.Blocks.Sources.Ramp dpSet(
    height=20,
    duration=160,
    offset=-10,
    startTime=10) "Set pressure difference"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  EmpiricalExpressions.Maas maas(winClrWidth=winClrWidth, winClrHeight=
        winClrHeight) "Model Maas"
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  Utilities.WindProfilePowerLaw winSpePro13(height=13, heightRef=10)
    "Calculate wind speed profile at height of 13 m"
    annotation (Placement(transformation(extent={{4,-120},{14,-110}})));
  EmpiricalExpressions.Hall hall(winClrWidth=winClrWidth, winClrHeight=
        winClrHeight) "Model Hall"
    annotation (Placement(transformation(extent={{60,-140},{80,-120}})));
  EmpiricalExpressions.Jiang jiang(winClrWidth=winClrWidth, winClrHeight=
        winClrHeight) "Model Jiang"
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
equation
  connect(winOpnWidthSet.y, warrenParkins.opnWidth_in)
    annotation (Line(points={{99,110},{30,110},{30,102}}, color={0,0,127}));
  connect(gidsPhaff.opnWidth_in, warrenParkins.opnWidth_in) annotation (Line(
        points={{30,62},{44,62},{44,110},{30,110},{30,102}}, color={0,0,127}));
  connect(larsenHeiselberg.opnWidth_in, warrenParkins.opnWidth_in) annotation (
      Line(points={{30,22},{44,22},{44,110},{30,110},{30,102}}, color={0,0,127}));
  connect(caciolo.opnWidth_in, warrenParkins.opnWidth_in) annotation (Line(
        points={{30,-18},{44,-18},{44,110},{30,110},{30,102}}, color={0,0,127}));
  connect(tang.opnWidth_in, warrenParkins.opnWidth_in) annotation (Line(points=
          {{30,-58},{44,-58},{44,110},{30,110},{30,102}}, color={0,0,127}));
  connect(vDI2078_1.opnWidth_in, warrenParkins.opnWidth_in) annotation (Line(
        points={{70,82},{84,82},{84,110},{30,110},{30,102}}, color={0,0,127}));
  connect(dIN16798_1.opnWidth_in, warrenParkins.opnWidth_in) annotation (Line(
        points={{70,2},{84,2},{84,110},{30,110},{30,102}}, color={0,0,127}));
  connect(dIN4108_1.opnWidth_in, warrenParkins.opnWidth_in) annotation (Line(
        points={{70,-38},{84,-38},{84,110},{30,110},{30,102}}, color={0,0,127}));
  connect(aSHRAE.opnWidth_in, warrenParkins.opnWidth_in) annotation (Line(
        points={{70,-78},{84,-78},{84,110},{30,110},{30,102}}, color={0,0,127}));
  connect(maas.opnWidth_in, warrenParkins.opnWidth_in) annotation (Line(points=
          {{30,-98},{44,-98},{44,110},{30,110},{30,102}}, color={0,0,127}));
  connect(maas.TRoom, warrenParkins.TRoom) annotation (Line(points={{18,-102},{
          10,-102},{10,98},{18,98}}, color={0,0,127}));
  connect(maas.TAmb, warrenParkins.TAmb) annotation (Line(points={{18,-106},{0,
          -106},{0,94},{18,94}}, color={0,0,127}));
  connect(winSpePro13.winSpeRef, warrenParkins.winSpe10) annotation (Line(
        points={{3,-115},{-10,-115},{-10,88},{18,88}}, color={0,0,127}));
  connect(winSpePro13.winSpe, maas.winSpe13) annotation (Line(points={{14.5,
          -115},{14.5,-112},{18,-112}}, color={0,0,127}));
  connect(hall.TRoom, warrenParkins.TRoom) annotation (Line(points={{58,-122},{
          10,-122},{10,98},{18,98}}, color={0,0,127}));
  connect(hall.TAmb, warrenParkins.TAmb) annotation (Line(points={{58,-126},{0,
          -126},{0,94},{18,94}}, color={0,0,127}));
  connect(hall.opnWidth_in, warrenParkins.opnWidth_in) annotation (Line(points=
          {{70,-118},{84,-118},{84,110},{30,110},{30,102}}, color={0,0,127}));
  connect(dpSet.y, jiang.dp)
    annotation (Line(points={{-79,-90},{-62,-90}}, color={0,0,127}));
  connect(jiang.opnWidth_in, tang.opnWidth_in)
    annotation (Line(points={{-50,-78},{-50,-58},{30,-58}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1492\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This example checks the models that simulate the window ventilation flow rate with the sash opening. For the sash opening type, all models are set to the bottom-hung opening.</p>
<p>The result shows that the estimated volume flow can be quite different when using different models.</p>
</html>"));
end VentilationFlowRateSashOpening;
