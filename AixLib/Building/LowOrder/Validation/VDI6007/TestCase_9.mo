within AixLib.Building.LowOrder.Validation.VDI6007;
model TestCase_9
  extends Modelica.Icons.Example;

  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;

  Modelica.Blocks.Sources.Constant infiltrationTemp(k=273.15 + 22)
    annotation (Placement(transformation(extent={{12,9},{26,23}})));
  Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
    annotation (Placement(transformation(extent={{28,-10},{40,2}})));
  Building.LowOrder.BaseClasses.SolarRadWeightedSum
    window_shortwave_rad_sum(n=4, weightfactors={0,0,7,7})
    annotation (Placement(transformation(extent={{6,62},{28,84}})));
  Building.LowOrder.BaseClasses.EqAirTemp eqAirTemp(
    aowo=0.7,
    wf_wall={0,0,0.05795,0.13245},
    wf_win={0,0,0.4048,0.4048},
    alphaowo=25)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Components.Weather.Sunblind sunblind(Imax=100, gsunblind={1,1,0.15,
        0.15})
    annotation (Placement(transformation(extent={{-20,62},{0,82}})));
  Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
    Ao=25.5,
    Aw=14,
    Ai=60.5,
    epsi=1,
    epso=1,
    epsw=1,
    g=1,
    splitfac=0.09,
    T0all(displayUnit="degC"),
    R1i=0.000668639,
    C1i=1.23849e+007,
    R1o=0.001735719,
    C1o=5.25993e+006,
    alphaiwi=2.1,
    alphaowi=2.7,
    RRest=0.020439688)
    annotation (Placement(transformation(extent={{38,8},{80,46}})));
  Utilities.Sources.PrescribedSolarRad varRad3(n=4) annotation (
      Placement(transformation(extent={{-58,63},{-38,83}})));
  Utilities.Sources.PrescribedSolarRad varRad1(n=4) annotation (
      Placement(transformation(extent={{-44,23},{-24,43}})));
  Modelica.Blocks.Sources.CombiTimeTable windowRad(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfilesOffice",
    fileName="./Tables/J1615/UserProfilesOffice.txt",
    tableOnFile=false,
    table=[0,0,0,0,0; 3600,0,0,0,0; 10800,0,0,0,0; 14400,0,0,0,0; 14400,0,
        0,17,17; 18000,0,0,17,17; 18000,0,0,38,36; 21600,0,0,38,36; 21600,
        0,0,59,51; 25200,0,0,59,51; 25200,0,0,98,64; 28800,0,0,98,64;
        28800,0,0,186,74; 32400,0,0,186,74; 32400,0,0,287,84; 36000,0,0,
        287,84; 36000,0,0,359,92; 39600,0,0,359,92; 39600,0,0,385,100;
        43200,0,0,385,100; 43200,0,0,359,180; 46800,0,0,359,180; 46800,0,
        0,287,344; 50400,0,0,287,344; 50400,0,0,186,475; 54000,0,0,186,
        475; 54000,0,0,98,528; 57600,0,0,98,528; 57600,0,0,59,492; 61200,
        0,0,59,492; 61200,0,0,38,359; 64800,0,0,38,359; 64800,0,0,17,147;
        68400,0,0,17,147; 68400,0,0,0,0; 72000,0,0,0,0; 82800,0,0,0,0;
        86400,0,0,0,0],
    columns={2,3,4,5})
    annotation (Placement(transformation(extent={{-88,66},{-74,80}})));
  Modelica.Blocks.Sources.CombiTimeTable wallRad(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfilesOffice",
    fileName="./Tables/J1615/UserProfilesOffice.txt",
    tableOnFile=false,
    columns={2,3,4,5},
    table=[0,0,0,0,0; 3600,0,0,0,0; 10800,0,0,0,0; 14400,0,0,0,0; 14400,0,
        0,24,23; 18000,0,0,24,23; 18000,0,0,58,53; 21600,0,0,58,53; 21600,
        0,0,91,77; 25200,0,0,91,77; 25200,0,0,203,97; 28800,0,0,203,97;
        28800,0,0,348,114; 32400,0,0,348,114; 32400,0,0,472,131; 36000,0,
        0,472,131; 36000,0,0,553,144; 39600,0,0,553,144; 39600,0,0,581,
        159; 43200,0,0,581,159; 43200,0,0,553,372; 46800,0,0,553,372;
        46800,0,0,472,557; 50400,0,0,472,557; 50400,0,0,348,685; 54000,0,
        0,348,685; 54000,0,0,203,733; 57600,0,0,203,733; 57600,0,0,91,666;
        61200,0,0,91,666; 61200,0,0,58,474; 64800,0,0,58,474; 64800,0,0,
        24,177; 68400,0,0,24,177; 68400,0,0,0,0; 72000,0,0,0,0; 82800,0,0,
        0,0; 86400,0,0,0,0])
    annotation (Placement(transformation(extent={{-88,26},{-74,40}})));
  Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="UserProfilesOffice",
    fileName="./Tables/J1615/UserProfilesOffice.txt",
    tableOnFile=false,
    table=[0,0,0,0,18.8,0,0,0,343,-382,0; 0.36,0,0,0,18.8,0,0,0,343,-382,
        0; 3600,0,0,0,17.1,0,0,0,344,-384,0; 7200,0,0,0,17.1,0,0,0,344,-384,
        0; 7200,0,0,0,16.5,0,0,0,345,-384,0; 10800,0,0,0,16.5,0,0,0,345,-384,
        0; 10800,0,0,0,16.1,0,0,0,347,-381,0; 14400,0,0,0,16.1,0,0,0,347,
        -381,0; 14400,0,0,0,16.5,0,0,0,355,-406,0; 18000,0,0,0,16.5,0,0,0,
        355,-406,0; 18000,0,0,0,17.8,0,0,0,359,-422,0; 21600,0,0,0,17.8,0,
        0,0,359,-422,0; 21600,0,0,0,20.3,0,0,0,353,-448,0; 25200,0,0,0,
        20.3,0,0,0,353,-448,0; 25200,0,0,0,22.8,0,0,0,356,-472,0; 28800,0,
        0,0,22.8,0,0,0,356,-472,0; 28800,0,0,0,24.8,0,0,0,356,-499,0;
        32400,0,0,0,24.8,0,0,0,356,-499,0; 32400,0,0,0,26.7,0,0,0,359,-519,
        0; 36000,0,0,0,26.7,0,0,0,359,-519,0; 36000,0,0,0,28.1,0,0,0,360,
        -537,0; 39600,0,0,0,28.1,0,0,0,360,-537,0; 39600,0,0,0,29,0,0,0,
        361,-553,0; 43200,0,0,0,29,0,0,0,361,-553,0; 43200,0,0,0,29.7,0,0,
        0,367,-552,0; 46800,0,0,0,29.7,0,0,0,367,-552,0; 46800,0,0,0,30.4,
        0,0,0,370,-550,0; 50400,0,0,0,30.4,0,0,0,370,-550,0; 50400,0,0,0,
        30.9,0,0,0,371,-544,0; 54000,0,0,0,30.9,0,0,0,371,-544,0; 54000,0,
        0,0,31,0,0,0,372,-533,0; 57600,0,0,0,31,0,0,0,372,-533,0; 57600,0,
        0,0,30.8,0,0,0,371,-519,0; 61200,0,0,0,30.8,0,0,0,371,-519,0;
        61200,0,0,0,30.1,0,0,0,382,-495,0; 64800,0,0,0,30.1,0,0,0,382,-495,
        0; 64800,0,0,0,28.9,0,0,0,400,-474,0; 68400,0,0,0,28.9,0,0,0,400,
        -474,0; 68400,0,0,0,27,0,0,0,395,-445,0; 72000,0,0,0,27,0,0,0,395,
        -445,0; 72000,0,0,0,24.7,0,0,0,389,-436,0; 75600,0,0,0,24.7,0,0,0,
        389,-436,0; 75600,0,0,0,22.9,0,0,0,383,-427,0; 79200,0,0,0,22.9,0,
        0,0,383,-427,0; 79200,0,0,0,21.9,0,0,0,377,-418,0; 82800,0,0,0,
        21.9,0,0,0,377,-418,0; 82800,0,0,0,20.9,0,0,0,372,-408,0; 86400,0,
        0,0,20.9,0,0,0,372,-408,0],
    columns={5,9,10})
    annotation (Placement(transformation(extent={{-88,3},{-74,17}})));
  Modelica.Blocks.Routing.DeMultiplex3 deMultiplex3_1
    annotation (Placement(transformation(extent={{-68,4},{-56,16}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-50,11},{-44,17}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{-37,4},{-25,16}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(
    tableName="UserProfilesOffice",
    fileName="./Tables/J1615/UserProfilesOffice.txt",
    tableOnFile=false,
    columns={2},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    table=[3600,22; 7200,21.9; 10800,21.9; 14400,21.8; 18000,22; 21600,22.3;
        25200,22.7; 28800,24.8; 32400,24.7; 36000,25.2; 39600,25.6; 43200,
        26.1; 46800,25.9; 50400,26.3; 54000,26.6; 57600,27.5; 61200,27.6;
        64800,26; 68400,25.8; 72000,25.6; 75600,25.6; 79200,25.5; 82800,25.5;
        86400,25.5; 781200,37.6; 784800,37.4; 788400,37.3; 792000,37.1;
        795600,37.1; 799200,37.3; 802800,37.5; 806400,39.6; 810000,39.4;
        813600,39.7; 817200,40; 820800,40.3; 824400,40; 828000,40.3; 831600,
        40.5; 835200,41.3; 838800,41.3; 842400,39.6; 846000,39.2; 849600,38.9;
        853200,38.8; 856800,38.7; 860400,38.5; 864000,38.4; 5101200,40.8;
        5104800,40.6; 5108400,40.4; 5112000,40.2; 5115600,40.2; 5119200,40.4;
        5122800,40.5; 5126400,42.6; 5130000,42.3; 5133600,42.6; 5137200,42.9;
        5140800,43.2; 5144400,42.9; 5148000,43.2; 5151600,43.4; 5155200,44.1;
        5158800,44.1; 5162400,42.3; 5166000,42; 5169600,41.6; 5173200,41.5;
        5176800,41.3; 5180400,41.2; 5184000,41])
    annotation (Placement(transformation(extent={{80,80},{100,99}})));
  Utilities.HeatTransfer.HeatToStar HeatTorStar(A=2)
    annotation (Placement(transformation(extent={{38,-96},{58,-76}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective
    annotation (Placement(transformation(extent={{2,-48},{22,-28}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective
    annotation (Placement(transformation(extent={{2,-68},{22,-48}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative
    annotation (Placement(transformation(extent={{2,-96},{22,-76}})));
  Modelica.Blocks.Sources.CombiTimeTable innerLoads(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=false,
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,200;
        50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200; 61200,
        0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,0,0,0;
        86400,0,0,0],
    columns={2,3,4})
    annotation (Placement(transformation(extent={{-66,-68},{-46,-48}})));
equation
 referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;

  connect(sunblind.sunblindonoff, eqAirTemp.sunblindsig)  annotation (Line(
      points={{-10,63},{-10,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(varRad3.solarRad_out, sunblind.Rad_In)  annotation (Line(
      points={{-39,73},{-19,73}},
      color={255,128,0},
      smooth=Smooth.None));

  connect(windowRad.y, varRad3.u) annotation (Line(
      points={{-73.3,73},{-58,73}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, varRad1.u) annotation (Line(
      points={{-73.3,33},{-44,33}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(outdoorTemp.y, deMultiplex3_1.u) annotation (Line(
      points={{-73.3,10},{-69.2,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(deMultiplex3_1.y1[1], from_degC.u) annotation (Line(
      points={{-55.4,14.2},{-52.7,14.2},{-52.7,14},{-50.6,14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(from_degC.y, multiplex3_1.u1[1]) annotation (Line(
      points={{-43.7,14},{-39.95,14},{-39.95,14.2},{-38.2,14.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(deMultiplex3_1.y2, multiplex3_1.u2) annotation (Line(
      points={{-55.4,10},{-38.2,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(deMultiplex3_1.y3, multiplex3_1.u3) annotation (Line(
      points={{-55.4,5.8},{-38.2,5.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(window_shortwave_rad_sum.solarRad_out, reducedModel.solarRad_in)
    annotation (Line(
      points={{26.9,73},{26.9,54.5},{41.99,54.5},{41.99,37.26}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(eqAirTemp.equalAirTemp, reducedModel.equalAirTemp) annotation (
      Line(
      points={{-2,10},{8,10},{8,27.76},{42.2,27.76}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
    annotation (Line(
      points={{26.7,16},{32,16},{32,17.88},{42.2,17.88}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
      Line(
      points={{40.6,-4},{48,-4},{48,11.8},{50.6,11.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sunblind.Rad_Out, window_shortwave_rad_sum.solarRad_in)
    annotation (Line(
      points={{-1,73},{7.1,73}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(varRad1.solarRad_out, eqAirTemp.solarRad_in) annotation (Line(
      points={{-25,33},{-25,24.5},{-18.5,24.5},{-18.5,15.6}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(multiplex3_1.y, eqAirTemp.weatherData) annotation (Line(
      points={{-24.4,10},{-18,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HeatTorStar.Star, reducedModel.internalGainsRad) annotation (
      Line(
      points={{57.1,-86},{74,-86},{74,11.8},{75.17,11.8}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(personsConvective.port, reducedModel.internalGainsConv)
    annotation (Line(
      points={{22,-58},{63.2,-58},{63.2,11.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(machinesConvective.port, reducedModel.internalGainsConv)
    annotation (Line(
      points={{22,-38},{63.2,-38},{63.2,11.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(innerLoads.y[3], machinesConvective.Q_flow) annotation (Line(
      points={{-45,-58},{-26,-58},{-26,-38},{2,-38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(innerLoads.y[2], personsConvective.Q_flow) annotation (Line(
      points={{-45,-58},{2,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(innerLoads.y[1], personsRadiative.Q_flow) annotation (Line(
      points={{-45,-58},{-26,-58},{-26,-86},{2,-86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(personsRadiative.port, HeatTorStar.Therm) annotation (Line(
      points={{22,-86},{38.8,-86}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(graphics),
    experiment(StopTime=5.184e+006, Interval=3600),
    experimentSetupOutput(events=false), Documentation(revisions="<html>
<ul>
  <li><i>March, 2012&nbsp;</i>
         by Moritz Lauster:<br>
         Implemented</li>
</ul>
</html>",
        info="<html>
<p>Test Case 9 of the VDI6007:: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to mixed inner and outer heat sources for Type Room S:</p>
<p>Based on Test Case 8</p>
<ul>
<li>longwave radiation heat exchange is taken into account</li>
</ul>
<p><br>Reference: Room air temperature</p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"));
end TestCase_9;
