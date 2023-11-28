within AixLib.ThermalZones.HighOrder.Components.Shadow.Examples;
model ShadowLengthTest "Test the modul ShadowLength"
  extends Modelica.Icons.Example;
  ShadowLength shaLen1(aziDeg=0, lenShie=0.3) "Azi=S, lenShie=0.3"
    annotation (Placement(transformation(extent={{20,40},{60,80}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"))
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ShadowLength shaLen2(aziDeg=90, lenShie=0.3) "Azi=W, lenShie=0.3"
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));
  ShadowLength shaLen3(aziDeg=90, lenShie=0.6) "Azi=W, lenShie=0.6"
    annotation (Placement(transformation(extent={{20,-80},{60,-40}})));
equation
  connect(weaDat.weaBus, shaLen1.weaBus) annotation (Line(
      points={{-20,0},{14,0},{14,60},{20,60}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, shaLen2.weaBus) annotation (Line(
      points={{-20,0},{20,0}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, shaLen3.weaBus) annotation (Line(
      points={{-20,0},{14,0},{14,-60},{20,-60}},
      color={255,204,51},
      thickness=0.5));
  annotation (experiment(
      StopTime=31536000,
      Interval=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>Simulation to test the <a href=\"AixLib.Building.Components.Shadow.ShadowLength\">ShadowLength</a> model with different facade azimuth angles and sun shied lengths. </p>
<ul>
<li><i>November, 2023&nbsp;</i> by Jun Jiang:<br>Implemented. </li>
</ul>
</html>"));
end ShadowLengthTest;
