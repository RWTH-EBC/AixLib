within AixLib.BoundaryConditions.WeatherData.Old;
model CompareTMYToTRY
  ReaderTMY3 weaDat(filNam=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/temp_compare_data/TRY2015_494414066370_Jahr.mos"))
    annotation (Placement(transformation(extent={{-104,12},{-36,90}})));
  WeatherTRY.Weather weather(
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/weatherdata/temp_compare_data/TRY2015_494414066370_Jahr.txt"),

    formatTRY="TRY 2015/2017",
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    Cloud_cover=true,
    Wind_dir=true,
    Wind_speed=true,
    Air_temp=true,
    Air_press=true,
    Mass_frac=true,
    Rel_hum=true,
    Sky_rad=true,
    Ter_rad=true)
    annotation (Placement(transformation(extent={{-172,-102},{-70,-34}})));
  Bus weaBus "Weather data bus" annotation (Placement(transformation(extent={{-6,44},
            {14,64}}),           iconTransformation(extent={{190,-10},{210,10}})));
  Modelica.Blocks.Math.Add diffWinSpe(k2=-1)
    annotation (Placement(transformation(extent={{74,-30},{90,-14}})));
  Modelica.Blocks.Math.Add diffWinDir(k2=-1)
    annotation (Placement(transformation(extent={{48,12},{64,28}})));
  Modelica.Blocks.Math.Add diffTAir(k2=-1)
    annotation (Placement(transformation(extent={{44,40},{60,56}})));
  Modelica.Blocks.Math.Add diffRelHum(k2=-1)
    annotation (Placement(transformation(extent={{80,-84},{96,-68}})));
  Modelica.Blocks.Math.Add diffAirPressure(k2=-1)
    annotation (Placement(transformation(extent={{82,-110},{98,-94}})));
  Modelica.Blocks.Math.Add diffnOpa(k2=-1)
    annotation (Placement(transformation(extent={{84,-130},{100,-114}})));
  Modelica.Blocks.Math.Gain gain(k=Modelica.Constants.pi/180)
    annotation (Placement(transformation(extent={{-26,-76},{-6,-56}})));
  Modelica.Blocks.Math.Add diffRad(k2=-1)
    annotation (Placement(transformation(extent={{70,-54},{86,-38}})));
equation
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-36,51},{-21,51},{-21,54},{4,54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weather.WindSpeed, diffWinSpe.u2) annotation (Line(points={{-66.6,
          -47.6},{-26.3,-47.6},{-26.3,-26.8},{72.4,-26.8}}, color={0,0,127}));
  connect(weather.AirTemp, diffTAir.u2) annotation (Line(points={{-66.6,-57.8},
          {-36,-57.8},{-36,43.2},{42.4,43.2}}, color={0,0,127}));
  connect(weather.RelHumidity, diffRelHum.u2) annotation (Line(points={{-66.6,
          -88.4},{39.7,-88.4},{39.7,-80.8},{78.4,-80.8}}, color={0,0,127}));
  connect(diffRelHum.u1, weaBus.relHum) annotation (Line(points={{78.4,-71.2},{
          78.4,-72},{4,-72},{4,54}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weather.AirPressure, diffAirPressure.u2) annotation (Line(points={{
          -66.6,-68},{-36,-68},{-36,-106},{22,-106},{22,-106.8},{80.4,-106.8}},
        color={0,0,127}));
  connect(diffAirPressure.u1, weaBus.pAtm) annotation (Line(points={{80.4,-97.2},
          {80.4,-98},{4,-98},{4,54}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weather.CloudCover, diffnOpa.u2) annotation (Line(points={{-66.6,
          -27.2},{-66.6,-26},{-54,-26},{-54,-128},{82.4,-128},{82.4,-126.8}},
        color={0,0,127}));
  connect(diffnOpa.u1, weaBus.nOpa) annotation (Line(points={{82.4,-117.2},{
          82.4,-116},{4,-116},{4,54}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(diffWinSpe.u1, weaBus.winSpe) annotation (Line(points={{72.4,-17.2},{
          4,-17.2},{4,54}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(diffWinDir.u1, weaBus.winDir) annotation (Line(points={{46.4,24.8},{4,
          24.8},{4,54}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(diffTAir.u1, weaBus.TDryBul) annotation (Line(points={{42.4,52.8},{
          24.2,52.8},{24.2,54},{4,54}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weather.WindDirection, gain.u) annotation (Line(points={{-66.6,-37.4},
          {-54.3,-37.4},{-54.3,-66},{-28,-66}}, color={0,0,127}));
  connect(gain.y, diffWinDir.u2) annotation (Line(points={{-5,-66},{-6,-66},{-6,
          15.2},{46.4,15.2}}, color={0,0,127}));
  connect(weather.SkyRadiation, diffRad.u2) annotation (Line(points={{-66.6,
          -98.6},{-24,-98.6},{-24,-50.8},{68.4,-50.8}}, color={0,0,127}));
  connect(diffRad.u1, weaBus.HGloHor) annotation (Line(points={{68.4,-41.2},{4,
          -41.2},{4,54}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=1800,
      __Dymola_Algorithm="Dassl"));
end CompareTMYToTRY;
