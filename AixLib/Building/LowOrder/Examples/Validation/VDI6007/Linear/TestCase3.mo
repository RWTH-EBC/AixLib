within AixLib.Building.LowOrder.Examples.Validation.VDI6007.Linear;
model TestCase3
  extends Modelica.Icons.Example;
  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T = 295.15) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-34, 30})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent = {{-44, -8}, {-24, 12}})));
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{-4, -40}, {16, -20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective annotation(Placement(transformation(extent = {{4, -68}, {24, -48}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelVDI                reducedModel(Ao = 10.5, Aw = 0.000000001, Ai = 75.5, epsi = 1, epso = 1, epsw = 1, g = 1,                 alphaowi = 2.7, splitfac = 0.09, withWindows = false,                     R1i = 0.003237138, C1i = 7.297100e+006,
    RRest=0.043140385,
    R1o=0.004049352,
    C1o=4.79e+004,
    alphaiwi=2.23642384)                                                                                                     annotation(Placement(transformation(extent = {{12, 10}, {46, 44}})));
  Modelica.Blocks.Sources.CombiTimeTable tableMachines(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false,                                                                                                    columns = {2},
    table=[0,0; 3600,0; 3600,0; 7200,0; 7200,0; 10800,0; 10800,0; 14400,0; 14400,
        0; 18000,0; 18000,0; 21600,0; 21600,1000; 25200,1000; 25200,1000; 28800,
        1000; 28800,1000; 32400,1000; 32400,1000; 36000,1000; 36000,1000; 39600,
        1000; 39600,1000; 43200,1000; 43200,1000; 46800,1000; 46800,1000; 50400,
        1000; 50400,1000; 54000,1000; 54000,1000; 57600,1000; 57600,1000; 61200,
        1000; 61200,1000; 64800,1000; 64800,0; 68400,0; 68400,0; 72000,0; 72000,
        0; 75600,0; 75600,0; 79200,0; 79200,0; 82800,0; 82800,0; 86400,0])                                                                                                     annotation(Placement(transformation(extent = {{-32, -65}, {-18, -51}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2}, table = [3600, 22; 7200, 22; 10800, 22; 14400, 22; 18000, 22; 21600, 22; 25200, 30.2; 28800, 30.8; 32400, 31.2; 36000, 31.6; 39600, 32; 43200, 32.4; 46800, 32.8; 50400, 33.2; 54000, 33.6; 57600, 34; 61200, 34.3; 64800, 34.7; 68400, 26.9; 72000, 26.7; 75600, 26.7; 79200, 26.6; 82800, 26.6; 86400, 26.6; 781200, 43.7; 784800, 43.5; 788400, 43.4; 792000, 43.2; 795600, 43; 799200, 42.9; 802800, 50.9; 806400, 51.3; 810000, 51.6; 813600, 51.8; 817200, 52.1; 820800, 52.3; 824400, 52.5; 828000, 52.8; 831600, 53; 835200, 53.3; 838800, 53.5; 842400, 53.7; 846000, 45.8; 849600, 45.4; 853200, 45.3; 856800, 45.1; 860400, 44.9; 864000, 44.7; 5101200, 48.7; 5104800, 48.5; 5108400, 48.3; 5112000, 48.1; 5115600, 47.9; 5119200, 47.7; 5122800, 55.7; 5126400, 56; 5130000, 56.3; 5133600, 56.5; 5137200, 56.7; 5140800, 56.9; 5144400, 57.1; 5148000, 57.3; 5151600, 57.5; 5155200, 57.7; 5158800, 57.9; 5162400, 58.1; 5166000, 50.1; 5169600, 49.8; 5173200, 49.5; 5176800, 49.3; 5180400, 49.1; 5184000, 48.9], extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(Placement(transformation(extent = {{62, 76}, {82, 95}})));
  Modelica.Blocks.Sources.Constant solarRadiation(k=0)
    annotation (Placement(transformation(extent={{-46,62},{-26,82}})));
equation
  referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;
  connect(tableMachines.y[1], machinesConvective.Q_flow) annotation(Line(points = {{-17.3, -58}, {4, -58}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation(Line(points = {{-24, 30}, {-4, 30}, {-4, 27.68}, {15.4, 27.68}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points = {{-23, 2}, {-4, 2}, {-4, 18.84}, {15.4, 18.84}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points={{17,-30},
          {22,-30},{22,11.7},{22.54,11.7}},                                                                                            color = {0, 0, 127}, smooth = Smooth.None));
  connect(machinesConvective.port, reducedModel.internalGainsConv) annotation(Line(points={{24,-58},
          {32.4,-58},{32.4,11.7}},                                                                                                  color = {191, 0, 0}, smooth = Smooth.None));
  connect(solarRadiation.y, reducedModel.solarRad_in) annotation (Line(
      points={{-25,72},{21.18,72},{21.18,42.98}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Documentation(revisions="<html>
<p><ul>
 <li><i>May 28, 2015 </i> by Marcus Fuchs:<br/>Added unit testing command to annotations</li>
 </ul></p>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>", info="<html>
<p>Test Case 3 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to a convective heat source for Type room L </p>
<ul>
<li>constant outdoor temperature 22 degC </li>
<li>no shortwave radiation on the outer wall </li>
<li>no shortwave radiation through the window </li>
<li>no longwave radiation exchange between outer wall, window and ambience </li>
</ul>
<p>Reference: Room air temperature </p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p>Maximum deviation: 0.2 K</p>
<p>All values are given in the VDI 6007-1. </p>
<p>Same Test Case exists in VDI 6020. </p>
<p>A script to run this test case can be found in AixLib\\Resources\\Scripts\\Dymola\\Building\\LowOrder\\Examples\\Validation\\Linear.</p>
</html>"),  Icon(graphics),
            experiment(StopTime = 5.184e+006, Interval = 3600),
            __Dymola_Commands(file=
                               "modelica://AixLib/Resources/Scripts/Dymola/Building/LowOrder/Examples/Validation/Linear/TestCase3.mos"
        "Simulate and plot"),
            __Dymola_experimentSetupOutput(events = false),
            Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}),      graphics));
end TestCase3;
