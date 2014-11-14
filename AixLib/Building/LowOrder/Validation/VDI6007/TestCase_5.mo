within AixLib.Building.LowOrder.Validation.VDI6007;
model TestCase_5
  extends Modelica.Icons.Example;
  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{30, -4}, {40, 6}})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent = {{6, -4}, {16, 6}})));
  Utilities.HeatTransfer.HeatToStar HeatToStar(A = 2) annotation(Placement(transformation(extent = {{42, -100}, {62, -80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective annotation(Placement(transformation(extent = {{10, -52}, {30, -32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective annotation(Placement(transformation(extent = {{10, -72}, {30, -52}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative annotation(Placement(transformation(extent = {{10, -100}, {30, -80}})));
  Modelica.Blocks.Sources.CombiTimeTable innerLoads(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = [0, 0, 0, 0; 3600, 0, 0, 0; 7200, 0, 0, 0; 10800, 0, 0, 0; 14400, 0, 0, 0; 18000, 0, 0, 0; 21600, 0, 0, 0; 25200, 0, 0, 0; 25200, 80, 80, 200; 28800, 80, 80, 200; 32400, 80, 80, 200; 36000, 80, 80, 200; 39600, 80, 80, 200; 43200, 80, 80, 200; 46800, 80, 80, 200; 50400, 80, 80, 200; 54000, 80, 80, 200; 57600, 80, 80, 200; 61200, 80, 80, 200; 61200, 0, 0, 0; 64800, 0, 0, 0; 72000, 0, 0, 0; 75600, 0, 0, 0; 79200, 0, 0, 0; 82800, 0, 0, 0; 86400, 0, 0, 0], columns = {2, 3, 4}) annotation(Placement(transformation(extent = {{-58, -72}, {-38, -52}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelStar reducedModel(
    C1i=1.48216e+007,
    C1o=1.60085e+006,
    alphaiwi=2.2,
    epsi=1,
    epso=1,
    T0all(displayUnit="K") = 295.15,
    Aw=7,
    splitfac=0.09,
    R1i=0.000595515,
    Ai=75.5,
    epsw=1,
    g=1,
    RRest=0.042748777,
    R1o=0.004366222,
    Ao=10.5) annotation (Placement(transformation(extent={{48,26},{82,66}})));
  Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, columns = {2, 3, 4}, table = [0, 291.95, 0, 0; 3600, 291.95, 0, 0; 3600, 290.25, 0, 0; 7200, 290.25, 0, 0; 7200, 289.65, 0, 0; 10800, 289.65, 0, 0; 10800, 289.25, 0, 0; 14400, 289.25, 0, 0; 14400, 289.65, 0, 0; 18000, 289.65, 0, 0; 18000, 290.95, 0, 0; 21600, 290.95, 0, 0; 21600, 293.45, 0, 0; 25200, 293.45, 0, 0; 25200, 295.95, 0, 0; 28800, 295.95, 0, 0; 28800, 297.95, 0, 0; 32400, 297.95, 0, 0; 32400, 299.85, 0, 0; 36000, 299.85, 0, 0; 36000, 301.25, 0, 0; 39600, 301.25, 0, 0; 39600, 302.15, 0, 0; 43200, 302.15, 0, 0; 43200, 302.85, 0, 0; 46800, 302.85, 0, 0; 46800, 303.55, 0, 0; 50400, 303.55, 0, 0; 50400, 304.05, 0, 0; 54000, 304.05, 0, 0; 54000, 304.15, 0, 0; 57600, 304.15, 0, 0; 57600, 303.95, 0, 0; 61200, 303.95, 0, 0; 61200, 303.25, 0, 0; 64800, 303.25, 0, 0; 64800, 302.05, 0, 0; 68400, 302.05, 0, 0; 68400, 300.15, 0, 0; 72000, 300.15, 0, 0; 72000, 297.85, 0, 0; 75600, 297.85, 0, 0; 75600, 296.05, 0, 0; 79200, 296.05, 0, 0; 79200, 295.05, 0, 0; 82800, 295.05, 0, 0; 82800, 294.05, 0, 0; 86400, 294.05, 0, 0]) annotation(Placement(transformation(extent = {{-62, 22}, {-42, 42}})));
  Modelica.Blocks.Sources.CombiTimeTable windowRad(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0, 0, 0, 0, 0.0; 3600, 0, 0, 0, 0, 0.0; 10800, 0, 0, 0, 0, 0.0; 14400, 0, 0, 0, 0, 0.0; 14400, 0, 0, 17, 0, 0.0; 18000, 0, 0, 17, 0, 0.0; 18000, 0, 0, 38, 0, 0.0; 21600, 0, 0, 38, 0, 0.0; 21600, 0, 0, 59, 0, 0.0; 25200, 0, 0, 59, 0, 0.0; 25200, 0, 0, 98, 0, 0.0; 28800, 0, 0, 98, 0, 0.0; 28800, 0, 0, 186, 0, 0.0; 32400, 0, 0, 186, 0, 0.0; 32400, 0, 0, 287, 0, 0.0; 36000, 0, 0, 287, 0, 0.0; 36000, 0, 0, 359, 0, 0.0; 39600, 0, 0, 359, 0, 0.0; 39600, 0, 0, 385, 0, 0.0; 43200, 0, 0, 385, 0, 0.0; 43200, 0, 0, 359, 0, 0.0; 46800, 0, 0, 359, 0, 0.0; 46800, 0, 0, 287, 0, 0.0; 50400, 0, 0, 287, 0, 0.0; 50400, 0, 0, 186, 0, 0.0; 54000, 0, 0, 186, 0, 0.0; 54000, 0, 0, 98, 0, 0.0; 57600, 0, 0, 98, 0, 0.0; 57600, 0, 0, 59, 0, 0.0; 61200, 0, 0, 59, 0, 0.0; 61200, 0, 0, 38, 0, 0.0; 64800, 0, 0, 38, 0, 0.0; 64800, 0, 0, 17, 0, 0.0; 68400, 0, 0, 17, 0, 0.0; 68400, 0, 0, 0, 0, 0.0; 72000, 0, 0, 0, 0, 0.0; 82800, 0, 0, 0, 0, 0.0; 86400, 0, 0, 0, 0, 0.0], columns = {2, 3, 4, 5, 6}) annotation(Placement(transformation(extent = {{-96, 68}, {-76, 88}})));
  Utilities.Sources.PrescribedSolarRad PrescribedSolarRad(n = 5) annotation(Placement(transformation(extent = {{-60, 68}, {-40, 88}})));
  Components.Weather.Sunblind sunblind(n = 5, gsunblind = {0, 0, 0.15, 0, 0}) annotation(Placement(transformation(extent = {{-30, 67}, {-10, 87}})));
  Building.LowOrder.BaseClasses.SolarRadWeightedSum SolarRadWeightedSum(n = 5, weightfactors = {0, 0, 7, 0, 0}) annotation(Placement(transformation(extent = {{-2, 68}, {18, 88}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp annotation(Placement(transformation(extent = {{-8, 22}, {12, 42}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, table = [3600, 22; 7200, 22; 10800, 21.9; 14400, 21.9; 18000, 22; 21600, 22.2; 25200, 22.4; 28800, 24.4; 32400, 24.1; 36000, 24.4; 39600, 24.7; 43200, 24.9; 46800, 25.1; 50400, 25.2; 54000, 25.3; 57600, 26; 61200, 25.9; 64800, 24.3; 68400, 24.2; 72000, 24.1; 75600, 24.1; 79200, 24.1; 82800, 24.1; 86400, 24.1; 781200, 34.9; 784800, 34.8; 788400, 34.7; 792000, 34.6; 795600, 34.7; 799200, 34.8; 802800, 34.9; 806400, 36.9; 810000, 36.6; 813600, 36.8; 817200, 37; 820800, 37.2; 824400, 37.3; 828000, 37.4; 831600, 37.4; 835200, 38.1; 838800, 38; 842400, 36.4; 846000, 36.2; 849600, 36.1; 853200, 36.1; 856800, 36; 860400, 35.9; 864000, 35.9; 5101200, 44.9; 5104800, 44.8; 5108400, 44.7; 5112000, 44.6; 5115600, 44.6; 5119200, 44.6; 5122800, 44.8; 5126400, 46.7; 5130000, 46.3; 5133600, 46.5; 5137200, 46.7; 5140800, 46.8; 5144400, 46.9; 5148000, 47; 5151600, 47; 5155200, 47.6; 5158800, 47.5; 5162400, 45.8; 5166000, 45.6; 5169600, 45.4; 5173200, 45.4; 5176800, 45.3; 5180400, 45.2; 5184000, 45.1], columns = {2}, extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(Placement(transformation(extent = {{78, 80}, {98, 99}})));
equation
  referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;
  connect(personsRadiative.port, HeatToStar.Therm) annotation(Line(points = {{30, -90}, {42.8, -90}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(outdoorTemp.y[1], varTemp.T) annotation(Line(points = {{-41, 32}, {-10, 32}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(windowRad.y, PrescribedSolarRad.u) annotation(Line(points = {{-75, 78}, {-60, 78}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(PrescribedSolarRad.solarRad_out, sunblind.Rad_In) annotation(Line(points = {{-41, 78}, {-29, 78}}, color = {255, 128, 0}, smooth = Smooth.None));
  connect(SolarRadWeightedSum.solarRad_out, reducedModel.solarRad_in) annotation(Line(points = {{17, 78}, {34, 78}, {34, 56.8}, {51.23, 56.8}}, color = {255, 128, 0}, smooth = Smooth.None));
  connect(varTemp.port, reducedModel.equalAirTemp) annotation(Line(points = {{12, 32}, {22, 32}, {22, 46.8}, {51.4, 46.8}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points = {{16.5, 1}, {16.5, 18.5}, {51.4, 18.5}, {51.4, 36.4}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points = {{40.5, 1}, {40.5, 14.5}, {58.2, 14.5}, {58.2, 30}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(personsConvective.port, reducedModel.internalGainsConv) annotation(Line(points = {{30, -62}, {68.4, -62}, {68.4, 30}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(machinesConvective.port, reducedModel.internalGainsConv) annotation(Line(points = {{30, -42}, {68.4, -42}, {68.4, 30}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation(Line(points = {{61.1, -90}, {78, -90}, {78, 30}, {78.09, 30}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(sunblind.Rad_Out, SolarRadWeightedSum.solarRad_in) annotation(Line(points = {{-11, 78}, {-1, 78}}, color = {255, 128, 0}, smooth = Smooth.None));
  connect(innerLoads.y[3], machinesConvective.Q_flow) annotation(Line(points = {{-37, -62}, {-18, -62}, {-18, -42}, {10, -42}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[2], personsConvective.Q_flow) annotation(Line(points = {{-37, -62}, {10, -62}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[1], personsRadiative.Q_flow) annotation(Line(points = {{-37, -62}, {-18, -62}, {-18, -90}, {10, -90}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StartTime = 3600, StopTime = 5.184e+006, Interval = 3600, __Dymola_Algorithm = "Lsodar"), __Dymola_experimentSetupOutput(events = false), Documentation(revisions = "<html>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>", info = "<html>
 <p>Test Case 5 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to radiant and convective heat source for Type room S</p>
 <ul>
 <li>daily input for outdoor temperature </li>
 <li>no shortwave radiation on the outer wall</li>
 <li>shortwave radiation through the window</li>
 <li>sunblind is closed at &GT;100W/m&sup2;, behind the window</li>
 <li>no longwave radiation exchange between outer wall, window and ambience</li>
 </ul>
 <p>Reference: Room air temperature</p>
 <p>Variable path: <code>reducedModel.airload.T</code></p>
 <p><br><br>All values are given in the VDI 6007-1.</p>
 <p>Same Test Case exists in VDI 6020.</p>
 </html>"), Icon(graphics));
end TestCase_5;

