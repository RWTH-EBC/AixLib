within AixLib.Building.LowOrder.Examples.Validation.VDI6007.Star;
model TestCase_8
  extends Modelica.Icons.Example;
  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{38, -5}, {48, 5}})));
  Utilities.HeatTransfer.HeatToStar HeatTorStar(A = 2) annotation(Placement(transformation(extent = {{42, -98}, {62, -78}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelStar reducedModel(
    epsi=1,
    epso=1,
    T0all(displayUnit="K") = 295.15,
    R1i=0.000668639,
    C1i=1.23849e+007,
    Ai=60.5,
    splitfac=0.09,
    Aw=14,
    epsw=1,
    g=1,
    R1o=0.001735719,
    C1o=5.25993e+006,
    Ao=25.5,
    alphaiwi=2.1,
    RRest=0.020439688)
    annotation (Placement(transformation(extent={{48,26},{82,66}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2}, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint, table = [3600, 22; 7200, 21.9; 10800, 21.9; 14400, 21.8; 18000, 22; 21600, 22.3; 25200, 22.7; 28800, 24.8; 32400, 24.7; 36000, 25.2; 39600, 25.6; 43200, 26.1; 46800, 25.9; 50400, 26.3; 54000, 26.6; 57600, 27.5; 61200, 27.6; 64800, 26; 68400, 25.8; 72000, 25.6; 75600, 25.6; 79200, 25.5; 82800, 25.5; 86400, 25.5; 781200, 37.6; 784800, 37.5; 788400, 37.3; 792000, 37.1; 795600, 37.1; 799200, 37.3; 802800, 37.5; 806400, 39.6; 810000, 39.4; 813600, 39.7; 817200, 40; 820800, 40.3; 824400, 40; 828000, 40.3; 831600, 40.5; 835200, 41.3; 838800, 41.3; 842400, 39.6; 846000, 39.2; 849600, 38.9; 853200, 38.8; 856800, 38.7; 860400, 38.5; 864000, 38.4; 5101200, 40.9; 5104800, 40.7; 5108400, 40.5; 5112000, 40.2; 5115600, 40.3; 5119200, 40.4; 5122800, 40.6; 5126400, 42.6; 5130000, 42.4; 5133600, 42.7; 5137200, 43; 5140800, 43.3; 5144400, 43; 5148000, 43.2; 5151600, 43.4; 5155200, 44.2; 5158800, 44.1; 5162400, 42.4; 5166000, 42; 5169600, 41.7; 5173200, 41.6; 5176800, 41.4; 5180400, 41.2; 5184000, 41.1]) annotation(Placement(transformation(extent = {{80, 80}, {100, 99}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective annotation(Placement(transformation(extent = {{6, -50}, {26, -30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective annotation(Placement(transformation(extent = {{6, -70}, {26, -50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative annotation(Placement(transformation(extent = {{6, -98}, {26, -78}})));
  Modelica.Blocks.Sources.CombiTimeTable innerLoads(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = [0, 0, 0, 0; 3600, 0, 0, 0; 7200, 0, 0, 0; 10800, 0, 0, 0; 14400, 0, 0, 0; 18000, 0, 0, 0; 21600, 0, 0, 0; 25200, 0, 0, 0; 25200, 80, 80, 200; 28800, 80, 80, 200; 32400, 80, 80, 200; 36000, 80, 80, 200; 39600, 80, 80, 200; 43200, 80, 80, 200; 46800, 80, 80, 200; 50400, 80, 80, 200; 54000, 80, 80, 200; 57600, 80, 80, 200; 61200, 80, 80, 200; 61200, 0, 0, 0; 64800, 0, 0, 0; 72000, 0, 0, 0; 75600, 0, 0, 0; 79200, 0, 0, 0; 82800, 0, 0, 0; 86400, 0, 0, 0], columns = {2, 3, 4}) annotation(Placement(transformation(extent = {{-62, -70}, {-42, -50}})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent={{26,24},
            {36,34}})));
  Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, columns = {2, 3, 4}, table = [0, 291.95, 0, 0; 3600, 291.95, 0, 0; 3600, 290.25, 0, 0; 7200, 290.25, 0, 0; 7200, 289.65, 0, 0; 10800, 289.65, 0, 0; 10800, 289.25, 0, 0; 14400, 289.25, 0, 0; 14400, 289.65, 0, 0; 18000, 289.65, 0, 0; 18000, 290.95, 0, 0; 21600, 290.95, 0, 0; 21600, 293.45, 0, 0; 25200, 293.45, 0, 0; 25200, 295.95, 0, 0; 28800, 295.95, 0, 0; 28800, 297.95, 0, 0; 32400, 297.95, 0, 0; 32400, 299.85, 0, 0; 36000, 299.85, 0, 0; 36000, 301.25, 0, 0; 39600, 301.25, 0, 0; 39600, 302.15, 0, 0; 43200, 302.15, 0, 0; 43200, 302.85, 0, 0; 46800, 302.85, 0, 0; 46800, 303.55, 0, 0; 50400, 303.55, 0, 0; 50400, 304.05, 0, 0; 54000, 304.05, 0, 0; 54000, 304.15, 0, 0; 57600, 304.15, 0, 0; 57600, 303.95, 0, 0; 61200, 303.95, 0, 0; 61200, 303.25, 0, 0; 64800, 303.25, 0, 0; 64800, 302.05, 0, 0; 68400, 302.05, 0, 0; 68400, 300.15, 0, 0; 72000, 300.15, 0, 0; 72000, 297.85, 0, 0; 75600, 297.85, 0, 0; 75600, 296.05, 0, 0; 79200, 296.05, 0, 0; 79200, 295.05, 0, 0; 82800, 295.05, 0, 0; 82800, 294.05, 0, 0; 86400, 294.05, 0, 0]) annotation(Placement(transformation(extent={{-78,16},
            {-58,36}})));
  Utilities.Sources.PrescribedSolarRad Quelle_Wand(n = 5) annotation(Placement(transformation(extent={{-50,46},
            {-30,66}})));
  Modelica.Blocks.Sources.CombiTimeTable wallRad(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0, 0, 0, 0, 0.0; 3600, 0, 0, 0, 0, 0.0; 10800, 0, 0, 0, 0, 0.0; 14400, 0, 0, 0, 0, 0.0; 14400, 0, 0, 24, 23, 0.0; 18000, 0, 0, 24, 23, 0.0; 18000, 0, 0, 58, 53, 0.0; 21600, 0, 0, 58, 53, 0.0; 21600, 0, 0, 91, 77, 0.0; 25200, 0, 0, 91, 77, 0.0; 25200, 0, 0, 203, 97, 0.0; 28800, 0, 0, 203, 97, 0.0; 28800, 0, 0, 348, 114, 0.0; 32400, 0, 0, 348, 114, 0.0; 32400, 0, 0, 472, 131, 0.0; 36000, 0, 0, 472, 131, 0.0; 36000, 0, 0, 553, 144, 0.0; 39600, 0, 0, 553, 144, 0.0; 39600, 0, 0, 581, 159, 0.0; 43200, 0, 0, 581, 159, 0.0; 43200, 0, 0, 553, 372, 0.0; 46800, 0, 0, 553, 372, 0.0; 46800, 0, 0, 472, 557, 0.0; 50400, 0, 0, 472, 557, 0.0; 50400, 0, 0, 348, 685, 0.0; 54000, 0, 0, 348, 685, 0.0; 54000, 0, 0, 203, 733, 0.0; 57600, 0, 0, 203, 733, 0.0; 57600, 0, 0, 91, 666, 0.0; 61200, 0, 0, 91, 666, 0.0; 61200, 0, 0, 58, 474, 0.0; 64800, 0, 0, 58, 474, 0.0; 64800, 0, 0, 24, 177, 0.0; 68400, 0, 0, 24, 177, 0.0; 68400, 0, 0, 0, 0, 0.0; 72000, 0, 0, 0, 0, 0.0; 82800, 0, 0, 0, 0, 0.0; 86400, 0, 0, 0, 0, 0.0], columns = {2, 3, 4, 5, 6}) annotation(Placement(transformation(extent={{-78,46},
            {-58,66}})));
  Modelica.Blocks.Sources.CombiTimeTable windowRad(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0, 0, 0, 0, 0.0; 3600, 0, 0, 0, 0, 0.0; 10800, 0, 0, 0, 0, 0.0; 14400, 0, 0, 0, 0, 0.0; 14400, 0, 0, 17, 17, 0.0; 18000, 0, 0, 17, 17, 0.0; 18000, 0, 0, 38, 36, 0.0; 21600, 0, 0, 38, 36, 0.0; 21600, 0, 0, 59, 51, 0.0; 25200, 0, 0, 59, 51, 0.0; 25200, 0, 0, 98, 64, 0.0; 28800, 0, 0, 98, 64, 0.0; 28800, 0, 0, 186, 74, 0.0; 32400, 0, 0, 186, 74, 0.0; 32400, 0, 0, 287, 84, 0.0; 36000, 0, 0, 287, 84, 0.0; 36000, 0, 0, 359, 92, 0.0; 39600, 0, 0, 359, 92, 0.0; 39600, 0, 0, 385, 100, 0.0; 43200, 0, 0, 385, 100, 0.0; 43200, 0, 0, 359, 180, 0.0; 46800, 0, 0, 359, 180, 0.0; 46800, 0, 0, 287, 344, 0.0; 50400, 0, 0, 287, 344, 0.0; 50400, 0, 0, 186, 475, 0.0; 54000, 0, 0, 186, 475, 0.0; 54000, 0, 0, 98, 528, 0.0; 57600, 0, 0, 98, 528, 0.0; 57600, 0, 0, 59, 492, 0.0; 61200, 0, 0, 59, 492, 0.0; 61200, 0, 0, 38, 359, 0.0; 64800, 0, 0, 38, 359, 0.0; 64800, 0, 0, 17, 147, 0.0; 68400, 0, 0, 17, 147, 0.0; 68400, 0, 0, 0, 0, 0.0; 72000, 0, 0, 0, 0, 0.0; 82800, 0, 0, 0, 0, 0.0; 86400, 0, 0, 0, 0, 0.0], columns = {2, 3, 4, 5, 6}) annotation(Placement(transformation(extent={{-78,78},
            {-58,98}})));
  Utilities.Sources.PrescribedSolarRad Quelle_Fenster(n = 5) annotation(Placement(transformation(extent={{-50,78},
            {-30,98}})));
  Components.Weather.Sunblind sunblind(n = 5, gsunblind = {0, 0, 0.15, 0.15, 0}) annotation(Placement(transformation(extent={{-20,77},
            {0,97}})));
  BaseClasses.SolarRadWeightedSum                   rad_weighted_sum(weightfactors = {0, 0, 7, 7, 0}, n = 5) annotation(Placement(transformation(extent={{30,78},
            {50,98}})));
  BaseClasses.EqAirTemp.EqAirTempSimple
                                     eqAirTemp(aowo = 0.7, n = 5,                                                                                                    alphaowo = 25,
    wf_wall={0.000000000,0.000000000,0.057968311,0.132498994,0.000000000},
    wf_win={0.000000000,0.000000000,0.404766351,0.404766351,0.000000000},
    withLongwave=false)                                                                                                     annotation(Placement(transformation(extent={{-6,40},
            {14,60}})));
  BaseClasses.SolarRadAdapter solarRadAdapter[5]
    annotation (Placement(transformation(extent={{8,78},{28,98}})));
  BaseClasses.SolarRadAdapter solarRadAdapter1[5]
    annotation (Placement(transformation(extent={{-28,46},{-8,66}})));
equation
  referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points={{48.5,0},
          {58.54,0},{58.54,28}},                                                                                         color = {0, 0, 127}, smooth = Smooth.None));
  connect(HeatTorStar.Star, reducedModel.internalGainsRad) annotation(Line(points={{61.1,
          -88},{78,-88},{78,28},{77.75,28}},                                                                                         color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(personsConvective.port, reducedModel.internalGainsConv) annotation(Line(points={{26,-60},
          {68.4,-60},{68.4,28}},                                                                                                 color = {191, 0, 0}, smooth = Smooth.None));
  connect(machinesConvective.port, reducedModel.internalGainsConv) annotation(Line(points={{26,-40},
          {68.4,-40},{68.4,28}},                                                                                                  color = {191, 0, 0}, smooth = Smooth.None));
  connect(innerLoads.y[3], machinesConvective.Q_flow) annotation(Line(points = {{-41, -60}, {-22, -60}, {-22, -40}, {6, -40}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[2], personsConvective.Q_flow) annotation(Line(points = {{-41, -60}, {6, -60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[1], personsRadiative.Q_flow) annotation(Line(points = {{-41, -60}, {-22, -60}, {-22, -88}, {6, -88}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(personsRadiative.port, HeatTorStar.Therm) annotation(Line(points = {{26, -88}, {42.8, -88}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(sunblind.sunblindonoff,eqAirTemp. sunblindsig) annotation(Line(points={{-10,78},
          {-4,78},{-4,58},{4,58}},                                                                                             color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points={{36.5,29},
          {44,29},{44,36.4},{51.4,36.4}},                                                                                                    color = {0, 0, 127}, smooth = Smooth.None));
  connect(outdoorTemp.y,eqAirTemp. weatherData) annotation (Line(
      points={{-57,26},{-28,26},{-28,50},{-4,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(eqAirTemp.equalAirTemp, reducedModel.equalAirTemp) annotation (Line(
      points={{13.8,44.4},{24,44.4},{24,44},{36,44},{36,46.8},{51.4,46.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(rad_weighted_sum.solarRad_in, solarRadAdapter.solarRad_out)
    annotation (Line(
      points={{31,88},{28,88}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.I) annotation (Line(
      points={{-57,88},{-54,88},{-54,96.9},{-48.9,96.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.I_dir) annotation (Line(
      points={{-57,88},{-54,88},{-54,93},{-49,93}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.I_diff) annotation (Line(
      points={{-57,88},{-54,88},{-54,89},{-49,89}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.I_gr) annotation (Line(
      points={{-57,88},{-54,88},{-54,84.9},{-48.9,84.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.AOI) annotation (Line(
      points={{-57,88},{-54,88},{-54,81},{-49,81}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, Quelle_Wand.I) annotation (Line(
      points={{-57,56},{-54,56},{-54,64.9},{-48.9,64.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, Quelle_Wand.I_dir) annotation (Line(
      points={{-57,56},{-54,56},{-54,61},{-49,61}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, Quelle_Wand.I_diff) annotation (Line(
      points={{-57,56},{-54,56},{-54,57},{-49,57}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, Quelle_Wand.I_gr) annotation (Line(
      points={{-57,56},{-54,56},{-54,52.9},{-48.9,52.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(wallRad.y, Quelle_Wand.AOI) annotation (Line(
      points={{-57,56},{-52,56},{-52,49},{-49,49}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Quelle_Wand.solarRad_out, solarRadAdapter1.solarRad_in) annotation (
      Line(
      points={{-31,56},{-27,56}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(eqAirTemp.solarRad_in, solarRadAdapter1.solarRad_out) annotation (
      Line(
      points={{-4.5,55.6},{-6,55.6},{-6,56},{-8,56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Quelle_Fenster.solarRad_out, sunblind.Rad_in) annotation (Line(
      points={{-31,88},{-19,88}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(sunblind.Rad_out, solarRadAdapter.solarRad_in) annotation (Line(
      points={{-1,88},{9,88}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(rad_weighted_sum.solarRad_out, reducedModel.solarRad_in) annotation (
      Line(
      points={{49,88},{57.18,88},{57.18,64.8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
              graphics),
              experiment(StopTime = 5.184e+006, Interval = 3600, Algorithm = "Lsodar"),
              __Dymola_Commands(file=
                               "modelica://AixLib/Resources/Scripts/Dymola/Building/LowOrder/Examples/Validation/Star/TestCase_8.mos"
        "Simulate and plot"),
              __Dymola_experimentSetupOutput(events = false),
              Icon(graphics),
              Documentation(revisions="<html>
<p><ul>
 <li><i>June 8, 2015 </i> by Marcus Fuchs:<br/>Added unit testing command to annotations</li>
 </ul></p>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>", info = "<html>
 <p>Test Case 8 of the VDI6007:: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to mixed inner and outer heat sources for Type Room S:</p>
 <p>Based on Test Case 5</p>
 <ul>
 <li>Second outer wall to the west</li>
 <li>shortwave radiation on the outer wall</li>
 <li>shortwave radiation through the windows</li>
 <li>Shutter cloeses &GT;100W/m&sup2;</li>
 <li>no longwave radiation heat exchange (special EqAirTemp see: EqAirTemp_TestCase_8)</li>
 </ul>
 <p><br>Reference: Room air temperature</p>
 <p>Variable path: <code>reducedModel.airload.T</code></p>
 <p><br><br>All values are given in the VDI 6007-1.</p>
 <p>Same Test Case exists in VDI 6020.</p>
 </html>"));
end TestCase_8;
