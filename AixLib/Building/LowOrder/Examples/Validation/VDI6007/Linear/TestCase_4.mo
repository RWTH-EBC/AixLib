within AixLib.Building.LowOrder.Examples.Validation.VDI6007.Linear;
model TestCase_4
  extends Modelica.Icons.Example;
  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T = 295.15) annotation(Placement(transformation(extent = {{-46, 20}, {-26, 40}})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent = {{-46, -10}, {-26, 10}})));
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{-6, -40}, {14, -20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative annotation(Placement(transformation(extent = {{10, -68}, {30, -48}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelVDI                reducedModel(Ao = 10.5, Aw = 0.000000001, Ai = 75.5, epsi = 1, epso = 1, epsw = 1, g = 1, alphaiwi = 2.2, alphaowi = 2.7, splitfac = 0.09, withWindows = false,                                                             R1i = 0.003237138, C1i = 7.297100e+006,
    RRest=0.043140385,
    R1o=0.004049352,
    C1o=4.79e+004)                                                                                                     annotation(Placement(transformation(extent = {{10, 10}, {44, 44}})));
  Modelica.Blocks.Sources.CombiTimeTable tableMachines(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, table = [0, 0; 3600, 0; 7200, 0; 10800, 0; 14400, 0; 18000, 0; 21600, 0; 21600, 1000; 25200, 1000; 28800, 1000; 32400, 1000; 36000, 1000; 39600, 1000; 43200, 1000; 46800, 1000; 50400, 1000; 54000, 1000; 57600, 1000; 61200, 1000; 64800, 1000; 64800, 0; 68400, 0; 72000, 0; 75600, 0; 79200, 0; 82800, 0; 86400, 0], columns = {2}) annotation(Placement(transformation(extent = {{-22, -65}, {-8, -51}})));
  Utilities.HeatTransfer.HeatToStar HeatToStar(A = 2, eps = 1) annotation(Placement(transformation(extent = {{36, -68}, {56, -48}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2},                                                                                                    extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    table=[3600,22; 7200,22; 10800,22; 14400,22; 18000,22; 21600,22; 25200,
        25.1; 28800,25.7; 32400,26.1; 36000,26.5; 39600,26.9; 43200,27.3;
        46800,27.7; 50400,28.1; 54000,28.5; 57600,28.9; 61200,29.3; 64800,
        29.7; 68400,26.9; 72000,26.7; 75600,26.7; 79200,26.7; 82800,26.6;
        86400,26.6; 781200,43.8; 784800,43.6; 788400,43.5; 792000,43.3;
        795600,43.1; 799200,43; 802800,45.9; 806400,46.3; 810000,46.6; 813600,
        46.8; 817200,47.1; 820800,47.3; 824400,47.6; 828000,47.8; 831600,48.1;
        835200,48.3; 838800,48.5; 842400,48.8; 846000,45.9; 849600,45.6;
        853200,45.4; 856800,45.2; 860400,45.0; 864000,44.8; 5101200,48.8;
        5104800,48.6; 5108400,48.4; 5112000,48.2; 5115600,48; 5119200,47.8;
        5122800,50.7; 5126400,51.1; 5130000,51.3; 5133600,51.5; 5137200,51.7;
        5140800,51.9; 5144400,52.1; 5148000,52.4; 5151600,52.6; 5155200,52.8;
        5158800,53; 5162400,53.2; 5166000,50.2; 5169600,49.9; 5173200,49.7;
        5176800,49.5; 5180400,49.2; 5184000,49])                                                                                                     annotation(Placement(transformation(extent = {{78, 78}, {98, 97}})));
  Modelica.Blocks.Sources.Constant solarRadiation(k=0)
    annotation (Placement(transformation(extent={{-46,62},{-26,82}})));
equation
  referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;
  connect(machinesRadiative.port, HeatToStar.Therm) annotation(Line(points = {{30, -58}, {36.8, -58}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(tableMachines.y[1], machinesRadiative.Q_flow) annotation(Line(points = {{-7.3, -58}, {10, -58}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation(Line(points = {{-26, 30}, {-8, 30}, {-8, 27.68}, {13.4, 27.68}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points = {{-25, 0}, {-8, 0}, {-8, 18.84}, {13.4, 18.84}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points={{15,-30},
          {18,-30},{18,11.7},{20.54,11.7}},                                                                                            color = {0, 0, 127}, smooth = Smooth.None));
  connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation(Line(points={{55.1,
          -58},{58,-58},{58,-10},{39.75,-10},{39.75,11.7}},                                                                                          color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(solarRadiation.y, reducedModel.u1) annotation (Line(
      points={{-25,72},{19.18,72},{19.18,42.98}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Documentation(revisions="<html>
<p><ul>
 <li><i>May 28, 2015 </i> by Marcus Fuchs:<br/>Added unit testing command to annotations</li>
 </ul></p>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>", info = "<html>
 <p>Test Case 4 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to a radiant heat source for Type room L</p>
 <ul>
 <li>constant outdoor temperature</li>
 <li>no shortwave radiation on the outer wall</li>
 <li>no shortwave radiation through the window</li>
 <li>no longwave radiation exchange between outer wall, window and ambience</li>
 </ul>
 <p>Reference: Room air temperature</p>
 <p>Variable path: <code>reducedModel.airload.T</code></p>
 <p><br><br>All values are given in the VDI 6007-1.</p>
 <p>Same Test Case exists in VDI 6020.</p>
 </html>"),  Diagram(coordinateSystem(preserveAspectRatio = false,
             extent = {{-100, -100}, {100, 100}}), graphics),
             Icon(graphics),
             experiment(StopTime = 5.184e+006, Interval = 3600),
             __Dymola_Commands(file=
                               "modelica://AixLib/Resources/Scripts/Dymola/Building/LowOrder/Examples/Validation/Linear/TestCase_4.mos"
        "Simulate and plot"),
             __Dymola_experimentSetupOutput(events = false));
end TestCase_4;
