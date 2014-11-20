within AixLib.Building.LowOrder.Validation.Star;
model TestCase_1
  extends Modelica.Icons.Example;
  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T = 295.15) annotation(Placement(transformation(extent = {{-56, 8}, {-36, 28}})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent = {{-56, -22}, {-36, -2}})));
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{-14, -50}, {6, -30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective annotation(Placement(transformation(extent = {{-8, -86}, {12, -66}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelStar reducedModel(
    Ao=10.5,
    Aw=0.000000001,
    Ai=75.5,
    epsi=1,
    epso=1,
    epsw=1,
    g=1,
    alphaiwi=2.2,
    alphaowi=2.7,
    splitfac=0.09,
    R1i=0.000595515,
    C1i=1.48216e+007,
    withWindows=false,
    RRest=0.042748777,
    R1o=0.004366222,
    C1o=1.60085e+006)
    annotation (Placement(transformation(extent={{0,0},{34,34}})));
  Modelica.Blocks.Sources.CombiTimeTable tableMachines(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, table = [0, 0; 3600, 0; 7200, 0; 10800, 0; 14400, 0; 18000, 0; 21600, 0; 21600, 1000; 25200, 1000; 28800, 1000; 32400, 1000; 36000, 1000; 39600, 1000; 43200, 1000; 46800, 1000; 50400, 1000; 54000, 1000; 57600, 1000; 61200, 1000; 64800, 1000; 64800, 0; 68400, 0; 72000, 0; 75600, 0; 79200, 0; 82800, 0; 86400, 0], columns = {2}) annotation(Placement(transformation(extent = {{-40, -83}, {-26, -69}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2}, table = [3600, 22; 7200, 22; 10800, 22; 14400, 22; 18000, 22; 21600, 22; 25200, 27.7; 28800, 27.9; 32400, 28.1; 36000, 28.4; 39600, 28.6; 43200, 28.8; 46800, 29; 50400, 29.2; 54000, 29.4; 57600, 29.6; 61200, 29.8; 64800, 30; 68400, 24.5; 72000, 24.5; 75600, 24.5; 79200, 24.5; 82800, 24.5; 86400, 24.5; 781200, 37.7; 784800, 37.6; 788400, 37.5; 792000, 37.5; 795600, 37.4; 799200, 37.3; 802800, 43; 806400, 43.2; 810000, 43.3; 813600, 43.5; 817200, 43.6; 820800, 43.8; 824400, 43.9; 828000, 44.1; 831600, 44.3; 835200, 44.4; 838800, 44.6; 842400, 44.7; 846000, 39.1; 849600, 39.1; 853200, 39; 856800, 38.9; 860400, 38.9; 864000, 38.8; 5101200, 49.9; 5104800, 49.8; 5108400, 49.7; 5112000, 49.6; 5115600, 49.4; 5119200, 49.3; 5122800, 54.9; 5126400, 55.1; 5130000, 55.2; 5133600, 55.3; 5137200, 55.4; 5140800, 55.5; 5144400, 55.6; 5148000, 55.7; 5151600, 55.8; 5155200, 55.9; 5158800, 56.1; 5162400, 56.2; 5166000, 50.6; 5169600, 50.4; 5173200, 50.3; 5176800, 50.2; 5180400, 50.1; 5184000, 50], extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(Placement(transformation(extent = {{80, 80}, {100, 99}})));
equation
  referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;
  connect(tableMachines.y[1], machinesConvective.Q_flow) annotation(Line(points = {{-25.3, -76}, {-8, -76}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation(Line(points = {{-36, 18}, {-14, 18}, {-14, 17.68}, {3.4, 17.68}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points = {{-35, -12}, {-18, -12}, {-18, 8.84}, {3.4, 8.84}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points = {{7, -40}, {10.2, -40}, {10.2, 3.4}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(machinesConvective.port, reducedModel.internalGainsConv) annotation(Line(points = {{12, -76}, {20.4, -76}, {20.4, 3.4}}, color = {191, 0, 0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), experiment(StopTime = 5.184e+006, Interval = 3600), experimentSetupOutput(events = false), Documentation(revisions = "<html>
 <p><ul>
 <li><i>March, 2012&nbsp;</i> by Moritz Lauster:<br/>Implemented</li>
 </ul></p>
 <p><br/><br/> </p>
 </html>", info = "<html>
 <p>Test Case 1 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to a convective heat source for Type room S</p>
 <ul>
 <li>constant outdoor temperature 22&deg;C</li>
 <li>no shortwave radiation on the outer wall</li>
 <li>no shortwave radiation through the window</li>
 <li>no longwave radiation exchange between outer wall, window and ambience</li>
 </ul>
 <p>Reference: Room air temperature</p>
 <p>Variable path: <code>reducedModel.airload.T</code></p>
 <p><br><br>All values are given in the VDI 6007-1.</p>
 <p>Same Test Case exists in VDI 6020.</p>
 </html>"));
end TestCase_1;
