within AixLib.Building.LowOrder.Validation.Star;
model TestCase_12
  extends Modelica.Icons.Example;
  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;
  BaseClasses.ReducedOrderModel.ReducedOrderModelStar reducedModel(
    C1i=1.48216e+007,
    Aw=7,
    C1o=1.60085e+006,
    epsi=1,
    epso=1,
    T0all(displayUnit="K") = 295.15,
    R1i=0.000595515,
    Ai=75.5,
    RRest=0.042748777,
    R1o=0.004366222,
    Ao=10.5,
    splitfac=0.09,
    epsw=1,
    g=1,
    airload(V=0.1),
    alphaiwi=2.2)
    annotation (Placement(transformation(extent={{54,30},{88,70}})));
  Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, columns = {2, 3, 4}, table = [0, 291.95, 0, 0; 3600, 291.95, 0, 0; 3600, 290.25, 0, 0; 7200, 290.25, 0, 0; 7200, 289.65, 0, 0; 10800, 289.65, 0, 0; 10800, 289.25, 0, 0; 14400, 289.25, 0, 0; 14400, 289.65, 0, 0; 18000, 289.65, 0, 0; 18000, 290.95, 0, 0; 21600, 290.95, 0, 0; 21600, 293.45, 0, 0; 25200, 293.45, 0, 0; 25200, 295.95, 0, 0; 28800, 295.95, 0, 0; 28800, 297.95, 0, 0; 32400, 297.95, 0, 0; 32400, 299.85, 0, 0; 36000, 299.85, 0, 0; 36000, 301.25, 0, 0; 39600, 301.25, 0, 0; 39600, 302.15, 0, 0; 43200, 302.15, 0, 0; 43200, 302.85, 0, 0; 46800, 302.85, 0, 0; 46800, 303.55, 0, 0; 50400, 303.55, 0, 0; 50400, 304.05, 0, 0; 54000, 304.05, 0, 0; 54000, 304.15, 0, 0; 57600, 304.15, 0, 0; 57600, 303.95, 0, 0; 61200, 303.95, 0, 0; 61200, 303.25, 0, 0; 64800, 303.25, 0, 0; 64800, 302.05, 0, 0; 68400, 302.05, 0, 0; 68400, 300.15, 0, 0; 72000, 300.15, 0, 0; 72000, 297.85, 0, 0; 75600, 297.85, 0, 0; 75600, 296.05, 0, 0; 79200, 296.05, 0, 0; 79200, 295.05, 0, 0; 82800, 295.05, 0, 0; 82800, 294.05, 0, 0; 86400, 294.05, 0, 0]) annotation(Placement(transformation(extent = {{-60, 18}, {-40, 38}})));
  Modelica.Blocks.Sources.CombiTimeTable windowRad(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0, 0, 0, 0, 0.0; 3600, 0, 0, 0, 0, 0.0; 10800, 0, 0, 0, 0, 0.0; 14400, 0, 0, 0, 0, 0.0; 14400, 0, 0, 17, 0, 0.0; 18000, 0, 0, 17, 0, 0.0; 18000, 0, 0, 38, 0, 0.0; 21600, 0, 0, 38, 0, 0.0; 21600, 0, 0, 59, 0, 0.0; 25200, 0, 0, 59, 0, 0.0; 25200, 0, 0, 98, 0, 0.0; 28800, 0, 0, 98, 0, 0.0; 28800, 0, 0, 186, 0, 0.0; 32400, 0, 0, 186, 0, 0.0; 32400, 0, 0, 287, 0, 0.0; 36000, 0, 0, 287, 0, 0.0; 36000, 0, 0, 359, 0, 0.0; 39600, 0, 0, 359, 0, 0.0; 39600, 0, 0, 385, 0, 0.0; 43200, 0, 0, 385, 0, 0.0; 43200, 0, 0, 359, 0, 0.0; 46800, 0, 0, 359, 0, 0.0; 46800, 0, 0, 287, 0, 0.0; 50400, 0, 0, 287, 0, 0.0; 50400, 0, 0, 186, 0, 0.0; 54000, 0, 0, 186, 0, 0.0; 54000, 0, 0, 98, 0, 0.0; 57600, 0, 0, 98, 0, 0.0; 57600, 0, 0, 59, 0, 0.0; 61200, 0, 0, 59, 0, 0.0; 61200, 0, 0, 38, 0, 0.0; 64800, 0, 0, 38, 0, 0.0; 64800, 0, 0, 17, 0, 0.0; 68400, 0, 0, 17, 0, 0.0; 68400, 0, 0, 0, 0, 0.0; 72000, 0, 0, 0, 0, 0.0; 82800, 0, 0, 0, 0, 0.0; 86400, 0, 0, 0, 0, 0.0], columns = {2, 3, 4, 5, 6}) annotation(Placement(transformation(extent = {{-82, 72}, {-62, 92}})));
  Utilities.Sources.PrescribedSolarRad Quelle_Fenster(n = 5) annotation(Placement(transformation(extent = {{-54, 72}, {-34, 92}})));
  Components.Weather.Sunblind sunblind(n = 5, gsunblind = {0, 0, 0.15, 0, 0}) annotation(Placement(transformation(extent = {{-24, 71}, {-4, 91}})));
  Building.LowOrder.BaseClasses.SolarRadWeightedSum rad_weighted_sum(n = 5, weightfactors = {0, 0, 7, 0, 0}) annotation(Placement(transformation(extent = {{4, 72}, {24, 92}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp annotation(Placement(transformation(extent = {{-2, 26}, {18, 46}})));
  Modelica.Blocks.Sources.CombiTimeTable ventitaltionRate(table = [0, 1.9048; 3600, 1.9048; 7200, 1.9048; 10800, 1.9048; 14400, 1.9048; 18000, 1.9048; 21600, 1.9048; 25200, 1.9048; 25200, 0.95238; 28800, 0.95238; 32400, 0.95238; 36000, 0.95238; 39600, 0.95238; 43200, 0.95238; 46800, 0.95238; 50400, 0.95238; 54000, 0.95238; 57600, 0.95238; 61200, 0.95238; 61200, 1.9048; 64800, 1.9048; 72000, 1.9048; 75600, 1.9048; 79200, 1.9048; 82800, 1.9048; 86400, 1.9048], columns = {2}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic) annotation(Placement(transformation(extent = {{-60, -16}, {-40, 4}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2}, table = [3600, 21.5; 7200, 21.2; 10800, 21; 14400, 20.9; 18000, 21; 21600, 21.3; 25200, 21.9; 28800, 24.1; 32400, 24; 36000, 24.4; 39600, 24.8; 43200, 25.1; 46800, 25.4; 50400, 25.5; 54000, 25.7; 57600, 26.3; 61200, 26.3; 64800, 25.2; 68400, 25; 72000, 24.7; 75600, 24.3; 79200, 24; 82800, 23.8; 86400, 23.6; 781200, 29.1; 784800, 28.7; 788400, 28.5; 792000, 28.3; 795600, 28.3; 799200, 28.6; 802800, 29.1; 806400, 31.8; 810000, 31.7; 813600, 32; 817200, 32.3; 820800, 32.6; 824400, 32.8; 828000, 32.9; 831600, 33; 835200, 33.6; 838800, 33.5; 842400, 31.8; 846000, 31.5; 849600, 31.1; 853200, 30.7; 856800, 30.3; 860400, 30.1; 864000, 29.8; 5101200, 30.5; 5104800, 30; 5108400, 29.8; 5112000, 29.6; 5115600, 29.6; 5119200, 29.8; 5122800, 30.3; 5126400, 33.1; 5130000, 33; 5133600, 33.3; 5137200, 33.7; 5140800, 33.9; 5144400, 34.1; 5148000, 34.2; 5151600, 34.3; 5155200, 34.9; 5158800, 34.8; 5162400, 33; 5166000, 32.7; 5169600, 32.2; 5173200, 31.8; 5176800, 31.4; 5180400, 31.2; 5184000, 30.9], extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(Placement(transformation(extent = {{-96, -38}, {-76, -19}})));
  Utilities.HeatTransfer.HeatToStar HeatTorStar(A = 2) annotation(Placement(transformation(extent = {{48, -104}, {68, -84}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective annotation(Placement(transformation(extent = {{12, -56}, {32, -36}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective annotation(Placement(transformation(extent = {{12, -76}, {32, -56}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative annotation(Placement(transformation(extent = {{12, -104}, {32, -84}})));
  Modelica.Blocks.Sources.CombiTimeTable innerLoads(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = [0, 0, 0, 0; 3600, 0, 0, 0; 7200, 0, 0, 0; 10800, 0, 0, 0; 14400, 0, 0, 0; 18000, 0, 0, 0; 21600, 0, 0, 0; 25200, 0, 0, 0; 25200, 80, 80, 200; 28800, 80, 80, 200; 32400, 80, 80, 200; 36000, 80, 80, 200; 39600, 80, 80, 200; 43200, 80, 80, 200; 46800, 80, 80, 200; 50400, 80, 80, 200; 54000, 80, 80, 200; 57600, 80, 80, 200; 61200, 80, 80, 200; 61200, 0, 0, 0; 64800, 0, 0, 0; 72000, 0, 0, 0; 75600, 0, 0, 0; 79200, 0, 0, 0; 82800, 0, 0, 0; 86400, 0, 0, 0], columns = {2, 3, 4}) annotation(Placement(transformation(extent = {{-56, -76}, {-36, -56}})));
equation
  referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;
  connect(outdoorTemp.y[1], varTemp.T) annotation(Line(points = {{-39, 28}, {-22, 28}, {-22, 36}, {-4, 36}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(windowRad.y, Quelle_Fenster.u) annotation(Line(points = {{-61, 82}, {-54, 82}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(Quelle_Fenster.solarRad_out, sunblind.Rad_In) annotation(Line(points = {{-35, 82}, {-23, 82}}, color = {255, 128, 0}, smooth = Smooth.None));
  connect(varTemp.port, reducedModel.equalAirTemp) annotation(Line(points = {{18, 36}, {28, 36}, {28, 50.8}, {57.4, 50.8}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(sunblind.Rad_Out, rad_weighted_sum.solarRad_in) annotation(Line(points = {{-5, 82}, {5, 82}}, color = {255, 128, 0}, smooth = Smooth.None));
  connect(rad_weighted_sum.solarRad_out, reducedModel.solarRad_in) annotation(Line(points={{23,82},
          {32,82},{32,69},{64.2,69}},                                                                                                    color = {255, 128, 0}, smooth = Smooth.None));
  connect(HeatTorStar.Star, reducedModel.internalGainsRad) annotation(Line(points = {{67.1, -94}, {84, -94}, {84, 34}, {84.09, 34}}, color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(personsConvective.port, reducedModel.internalGainsConv) annotation(Line(points = {{32, -66}, {74.4, -66}, {74.4, 34}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(machinesConvective.port, reducedModel.internalGainsConv) annotation(Line(points = {{32, -46}, {74.4, -46}, {74.4, 34}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(innerLoads.y[3], machinesConvective.Q_flow) annotation(Line(points = {{-35, -66}, {-16, -66}, {-16, -46}, {12, -46}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[2], personsConvective.Q_flow) annotation(Line(points = {{-35, -66}, {12, -66}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[1], personsRadiative.Q_flow) annotation(Line(points = {{-35, -66}, {-16, -66}, {-16, -94}, {12, -94}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(personsRadiative.port, HeatTorStar.Therm) annotation(Line(points = {{32, -94}, {48.8, -94}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(outdoorTemp.y[1], reducedModel.ventilationTemperature) annotation (
      Line(
      points={{-39,28},{-22,28},{-22,20},{48,20},{48,40.4},{57.4,40.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ventitaltionRate.y[1], reducedModel.ventilationRate) annotation (
      Line(
      points={{-39,-6},{10,-6},{10,-4},{64.2,-4},{64.2,34}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                           graphics), experiment(StopTime = 5.184e+006, Interval = 3600), __Dymola_experimentSetupOutput(events = false), Icon(graphics), Documentation(revisions = "<html>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>", info = "<html>
 <p>Test Case 12 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to mixed inner and outer heat sources for Type Room S:</p>
 <p>Based on Test Case 5</p>
 <ul>
 <li>fixed ventialation day and night</li>
 </ul>
 <p>Reference: Room air temperature</p>
 <p>Variable path: <code>reducedModel.airload.T</code></p>
 <p><br/><br/>All values are given in the VDI 6007-1.</p>
 <p>Same Test Case exists in VDI 6020.</p>
 </html>"));
end TestCase_12;
