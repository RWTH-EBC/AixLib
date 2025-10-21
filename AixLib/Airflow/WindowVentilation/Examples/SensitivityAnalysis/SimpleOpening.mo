within AixLib.Airflow.WindowVentilation.Examples.SensitivityAnalysis;
model SimpleOpening "Simple opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialSensitivityAnalysisExample;
  extends Modelica.Icons.Example;
  AixLib.Airflow.WindowVentilation.SensitivityAnalysis.SimpleOpening senAnaTAmb
    "Sensitivity analysis of ambient temperature"
    annotation (Placement(transformation(extent={{60,60},{100,100}})));
  AixLib.Airflow.WindowVentilation.SensitivityAnalysis.SimpleOpening
    senAnaWinSpe "Sensitivity analysis of wind speed"
    annotation (Placement(transformation(extent={{60,0},{100,40}})));
  AixLib.Airflow.WindowVentilation.SensitivityAnalysis.SimpleOpening
    senAnaWinDir "Sensitivity analysis of wind direction"
    annotation (Placement(transformation(extent={{60,-60},{100,-20}})));
  Modelica.Blocks.Math.Feedback TDif "Temperature difference"
    annotation (Placement(transformation(extent={{30,100},{50,120}})));
equation
  connect(from_degC.y, senAnaTAmb.TRoom) annotation (Line(points={{-39,90},{-20,
          90},{-20,96},{56,96}}, color={0,0,127}));
  connect(from_degC.y, senAnaWinSpe.TRoom) annotation (Line(points={{-39,90},{-20,
          90},{-20,36},{56,36}}, color={0,0,127}));
  connect(from_degC.y, senAnaWinDir.TRoom) annotation (Line(points={{-39,90},{-20,
          90},{-20,-24},{56,-24}}, color={0,0,127}));
  connect(from_degC1.y, senAnaWinSpe.TAmb) annotation (Line(points={{-39,60},{-10,
          60},{-10,28},{56,28}}, color={0,0,127}));
  connect(from_degC1.y, senAnaWinDir.TAmb) annotation (Line(points={{-39,60},{-10,
          60},{-10,-32},{56,-32}}, color={0,0,127}));
  connect(from_degC2.y, senAnaTAmb.TAmb) annotation (Line(points={{-39,30},{0,30},
          {0,88},{56,88}}, color={0,0,127}));
  connect(WinSpeCon.y, senAnaTAmb.winSpe10) annotation (Line(points={{-79,0},{-70,
          0},{-70,16},{10,16},{10,76},{56,76}}, color={0,0,127}));
  connect(from_deg.y, senAnaTAmb.winDir) annotation (Line(points={{-39,-60},{20,
          -60},{20,68},{56,68}}, color={0,0,127}));
  connect(WinSpeVar.y, senAnaWinSpe.winSpe10) annotation (Line(points={{-79,-30},
          {0,-30},{0,16},{56,16}}, color={0,0,127}));
  connect(from_deg.y, senAnaWinSpe.winDir) annotation (Line(points={{-39,-60},{20,
          -60},{20,8},{56,8}}, color={0,0,127}));
  connect(WinSpeCon1.y, senAnaWinDir.winSpe10) annotation (Line(points={{-39,0},
          {10,0},{10,-44},{56,-44}}, color={0,0,127}));
  connect(from_deg1.y, senAnaWinDir.winDir) annotation (Line(points={{-39,-90},{
          30,-90},{30,-52},{56,-52}}, color={0,0,127}));
  connect(from_degC.y, TDif.u1) annotation (Line(points={{-39,90},{-20,90},{-20,
          96},{20,96},{20,110},{32,110},{32,110}}, color={0,0,127}));
  connect(from_degC2.y, TDif.u2) annotation (Line(points={{-39,30},{0,30},{0,88},
          {40,88},{40,102}}, color={0,0,127}));
  annotation (experiment(
      StartTime=0,
      StopTime=10,
      Interval=0.01,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
      __Dymola_Commands(file=
        "Resources/Scripts/Dymola/Airflow/WindowVentilation/Examples/SensitivityAnalysis/SimpleOpening.mos"
        "Simulate and plot"),
    Documentation(revisions="<html>
<ul>
  <li>
    October 21, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1608\">issue 1608</a>)
  </li>
</ul>
</html>", info="<html>
<p>This example shows how models of simple window opening respond to various inputs, including indoor-ambient temperature difference, wind speed, and wind direction.</p>
</html>"));
end SimpleOpening;
