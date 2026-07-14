within AixLib.Airflow.WindowVentilation.Examples.SensitivityAnalysis;
model BottomHungOpening "Bottom-hung opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialSensitivityAnalysisExample;
  extends Modelica.Icons.Example;
  AixLib.Airflow.WindowVentilation.SensitivityAnalysis.BottomHungOpening
    senAnaOpnWidth "Sensitivity analysis of opening width"
    annotation (Placement(transformation(extent={{60,60},{100,100}})));
  AixLib.Airflow.WindowVentilation.SensitivityAnalysis.BottomHungOpening
    senAnaTAmb "Sensitivity analysis of ambient temperature"
    annotation (Placement(transformation(extent={{60,10},{100,50}})));
  AixLib.Airflow.WindowVentilation.SensitivityAnalysis.BottomHungOpening
    senAnaWinSpe "Sensitivity analysis of wind speed"
    annotation (Placement(transformation(extent={{60,-40},{100,0}})));
  AixLib.Airflow.WindowVentilation.SensitivityAnalysis.BottomHungOpening
    senAnaWinDir "Sensitivity analysis of wind direction"
    annotation (Placement(transformation(extent={{60,-90},{100,-50}})));
  Modelica.Blocks.Sources.Ramp OpnWidthVar(
    height=0.2,
    duration=10,
    offset=0) "Variable opening width"
    annotation (Placement(transformation(extent={{-100,140},{-80,160}})));
  Modelica.Blocks.Sources.Constant OpnWidthCon(k=0.2) "Constant opening width"
    annotation (Placement(transformation(extent={{-100,110},{-80,130}})));
  Modelica.Blocks.Math.Feedback TDif "Temperature difference"
    annotation (Placement(transformation(extent={{30,50},{50,70}})));
equation
  connect(OpnWidthVar.y, senAnaOpnWidth.opnWidth_in)
    annotation (Line(points={{-79,150},{80,150},{80,104}}, color={0,0,127}));
  connect(OpnWidthCon.y, senAnaTAmb.opnWidth_in) annotation (Line(points={{-79,
          120},{110,120},{110,54},{80,54}}, color={0,0,127}));
  connect(OpnWidthCon.y, senAnaWinSpe.opnWidth_in) annotation (Line(points={{
          -79,120},{110,120},{110,4},{80,4}}, color={0,0,127}));
  connect(OpnWidthCon.y, senAnaWinDir.opnWidth_in) annotation (Line(points={{
          -79,120},{110,120},{110,-46},{80,-46}}, color={0,0,127}));
  connect(from_degC.y, senAnaOpnWidth.TRoom) annotation (Line(points={{-39,90},
          {-20,90},{-20,96},{56,96}}, color={0,0,127}));
  connect(from_degC.y, senAnaTAmb.TRoom) annotation (Line(points={{-39,90},{-20,
          90},{-20,46},{56,46}}, color={0,0,127}));
  connect(from_degC.y, senAnaWinSpe.TRoom) annotation (Line(points={{-39,90},{
          -20,90},{-20,-4},{56,-4}}, color={0,0,127}));
  connect(from_degC.y, senAnaWinDir.TRoom) annotation (Line(points={{-39,90},{
          -20,90},{-20,-54},{56,-54}}, color={0,0,127}));
  connect(from_degC1.y, senAnaOpnWidth.TAmb) annotation (Line(points={{-39,60},
          {-10,60},{-10,88},{56,88}}, color={0,0,127}));
  connect(from_degC1.y, senAnaWinSpe.TAmb) annotation (Line(points={{-39,60},{
          -10,60},{-10,-12},{56,-12}}, color={0,0,127}));
  connect(from_degC1.y, senAnaWinDir.TAmb) annotation (Line(points={{-39,60},{
          -10,60},{-10,-62},{56,-62}}, color={0,0,127}));
  connect(from_degC2.y, senAnaTAmb.TAmb) annotation (Line(points={{-39,30},{0,
          30},{0,38},{56,38}}, color={0,0,127}));
  connect(WinSpeCon.y, senAnaOpnWidth.winSpe10) annotation (Line(points={{-79,0},
          {-70,0},{-70,16},{10,16},{10,76},{56,76}}, color={0,0,127}));
  connect(WinSpeCon.y, senAnaTAmb.winSpe10) annotation (Line(points={{-79,0},{
          -70,0},{-70,16},{10,16},{10,26},{56,26}}, color={0,0,127}));
  connect(WinSpeVar.y, senAnaWinSpe.winSpe10) annotation (Line(points={{-79,-30},
          {18,-30},{18,-24},{56,-24}}, color={0,0,127}));
  connect(WinSpeCon1.y, senAnaWinDir.winSpe10) annotation (Line(points={{-39,0},
          {20,0},{20,-74},{56,-74}}, color={0,0,127}));
  connect(from_deg.y, senAnaOpnWidth.winDir) annotation (Line(points={{-39,-60},
          {30,-60},{30,68},{56,68}}, color={0,0,127}));
  connect(from_deg.y, senAnaTAmb.winDir) annotation (Line(points={{-39,-60},{30,
          -60},{30,18},{56,18}}, color={0,0,127}));
  connect(from_deg.y, senAnaWinSpe.winDir) annotation (Line(points={{-39,-60},{
          30,-60},{30,-32},{56,-32}}, color={0,0,127}));
  connect(from_deg1.y, senAnaWinDir.winDir) annotation (Line(points={{-39,-90},
          {40,-90},{40,-82},{56,-82}}, color={0,0,127}));
  connect(from_degC.y, TDif.u1) annotation (Line(points={{-39,90},{-20,90},{-20,
          46},{20,46},{20,60},{32,60}}, color={0,0,127}));
  connect(from_degC2.y, TDif.u2) annotation (Line(points={{-39,30},{0,30},{0,38},
          {40,38},{40,52}}, color={0,0,127}));
  annotation (experiment(
      StartTime=0,
      StopTime=10,
      Interval=0.01,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
      __Dymola_Commands(file=
        "Resources/Scripts/Dymola/Airflow/WindowVentilation/Examples/SensitivityAnalysis/BottomHungOpening.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
  <li>
    October 21, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1608\">issue 1608</a>)
  </li>
</ul>
</html>", info="<html>
<p>This example shows how models of bottom-hung window opening respond to various inputs, including opening width, indoor-ambient temperature difference, wind speed, and wind direction.</p>
<p>More information about the comparison of these models can be found in this study: <a href=\"https://doi.org/10.1016/j.buildenv.2025.113253\">https://doi.org/10.1016/j.buildenv.2025.113253</a></p>
</html>"));
end BottomHungOpening;
