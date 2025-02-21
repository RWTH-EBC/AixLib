within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model ExampleAHU "Comparative simulation with existing AHU model"
  extends Modelica.Icons.Example;
  ModularAHU modularAHU(
    humidifying=true,
    cooling=false,
    dehumidifying=true,
    heating=true,
    heatRecovery=true,
    usePhiSet=true,
    limPhiOda=true,
    m_flow_nominal=3000/3600*1.2,
    dpHrs_nominal(displayUnit="Pa") = 120,
    dpCoo_nominal(displayUnit="Pa") = 80,
    dpHea_nominal(displayUnit="Pa") = 40,
    dpHum_nominal(displayUnit="Pa") = 20,
    dpFanOda_nominal(displayUnit="Pa") = 1200,
    dpFanEta_nominal(displayUnit="Pa") = 1200,
    effHrsOn=0.73,
    dpFanOda(displayUnit="Pa") = 1200,
    dpFanEta(displayUnit="Pa") = 1200,
    etaFanOda=0.54,
    etaFanEta=0.54,
    redeclare model humidifier =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.SteamHumidifier)
    annotation (Placement(transformation(extent={{-58,-22},{48,42}})));
  BoundaryConditions.WeatherData.ReaderTMY3        weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-100,64},{-80,84}})));
  BoundaryConditions.WeatherData.Bus weaBus1
             "Weather data bus"
    annotation (Placement(transformation(extent={{-80,64},{-60,84}})));
  Modelica.Blocks.Sources.Constant TEta(k=293.15)
    annotation (Placement(transformation(extent={{100,60},{80,80}})));
  Modelica.Blocks.Sources.Constant PhiEta(k=0.45)
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Modelica.Blocks.Sources.CombiTimeTable tableAhu(
    table=[0,293.15,0.3,0.6,1000/3600; 6,293.15,0.3,0.6,1000/3600; 7,293.15,0.3,
        0.6,3000/3600; 19,293.15,0.3,0.6,3000/3600; 20,293.15,0.3,0.6,1000/3600;
        24,293.15,0.3,0.6,1000/3600],
    columns={2,3,4,5},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
equation
  connect(weaDat.weaBus, weaBus1) annotation (Line(
      points={{-80,74},{-70,74}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus1.TDryBul, modularAHU.TOda) annotation (Line(
      points={{-69.95,74.05},{-69.95,22.8},{-59.325,22.8}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus1.relHum, modularAHU.phiOda) annotation (Line(
      points={{-69.95,74.05},{-69.95,16.4},{-59.325,16.4}},
      color={255,204,51},
      thickness=0.5));
  connect(TEta.y, modularAHU.TEta) annotation (Line(points={{79,70},{68,70},{68,
          22.8},{49.325,22.8}}, color={0,0,127}));
  connect(PhiEta.y, modularAHU.phiEta) annotation (Line(points={{79,30},{68,30},
          {68,16.4},{49.325,16.4}}, color={0,0,127}));
  connect(tableAhu.y[4], modularAHU.VOda_flow) annotation (Line(points={{-79,
          -70},{-70,-70},{-70,29.2},{-59.325,29.2}}, color={0,0,127}));
  connect(tableAhu.y[4], modularAHU.VEta_flow) annotation (Line(points={{-79,
          -70},{-70,-70},{-70,50},{60,50},{60,29.2},{49.325,29.2}}, color={0,0,
          127}));
  connect(tableAhu.y[1], modularAHU.TSupSet) annotation (Line(points={{-79,-70},
          {41.375,-70},{41.375,-23.28}}, color={0,0,127}));
  connect(tableAhu.y[2], modularAHU.phiSupSet[1]) annotation (Line(points={{-79,
          -70},{34.75,-70},{34.75,-23.6}}, color={0,0,127}));
  connect(tableAhu.y[3], modularAHU.phiSupSet[2]) annotation (Line(points={{-79,
          -70},{34.75,-70},{34.75,-22.96}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=3600,
      Tolerance=1e-04,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p> This example showcases the functionality of the modular air handling unit model.
</p>
</html>"));
end ExampleAHU;
