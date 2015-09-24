within AixLib.Building.LowOrder.Examples.Validation.VDI6007.Star;
model TestCase2
  extends Modelica.Icons.Example;
  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T = 295.15) annotation(Placement(transformation(extent = {{-44, 20}, {-24, 40}})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent = {{-44, -10}, {-24, 10}})));
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{-4, -40}, {16, -20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative annotation(Placement(transformation(extent = {{38, -76}, {58, -56}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelStar reducedModel(
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
    C1o=1.60085e+006,
    Ao=10.5) annotation (Placement(transformation(extent={{12,10},{46,44}})));
  Modelica.Blocks.Sources.CombiTimeTable tableMachines(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableName = "NoName", fileName = "NoName", tableOnFile = false, table = [0, 0; 3600, 0; 7200, 0; 10800, 0; 14400, 0; 18000, 0; 21600, 0; 21600, 1000; 25200, 1000; 28800, 1000; 32400, 1000; 36000, 1000; 39600, 1000; 43200, 1000; 46800, 1000; 50400, 1000; 54000, 1000; 57600, 1000; 61200, 1000; 64800, 1000; 64800, 0; 68400, 0; 72000, 0; 75600, 0; 79200, 0; 82800, 0; 86400, 0], columns = {2}) annotation(Placement(transformation(extent = {{2, -73}, {16, -59}})));
  Utilities.HeatTransfer.HeatToStar HeatToStar(A = 2, eps = 1) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {70, -38})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "NoName", fileName = "NoName", tableOnFile = false, columns = {2}, table = [3600, 22; 7200, 22; 10800, 22; 14400, 22; 18000, 22; 21600, 22; 25200, 22.6; 28800, 22.9; 32400, 23.1; 36000, 23.3; 39600, 23.5; 43200, 23.7; 46800, 23.9; 50400, 24.1; 54000, 24.3; 57600, 24.6; 61200, 24.8; 64800, 25; 68400, 24.5; 72000, 24.5; 75600, 24.5; 79200, 24.5; 82800, 24.5; 86400, 24.5; 781200, 37.7; 784800, 37.7; 788400, 37.6; 792000, 37.5; 795600, 37.5; 799200, 37.4; 802800, 38; 806400, 38.2; 810000, 38.3; 813600, 38.5; 817200, 38.6; 820800, 38.8; 824400, 38.9; 828000, 39.1; 831600, 39.2; 835200, 39.4; 838800, 39.5; 842400, 39.7; 846000, 39.2; 849600, 39.1; 853200, 39.1; 856800, 39; 860400, 38.9; 864000, 38.9; 5101200, 50; 5104800, 49.9; 5108400, 49.8; 5112000, 49.7; 5115600, 49.6; 5119200, 49.5; 5122800, 50; 5126400, 50.1; 5130000, 50.2; 5133600, 50.3; 5137200, 50.5; 5140800, 50.6; 5144400, 50.7; 5148000, 50.8; 5151600, 50.9; 5155200, 51; 5158800, 51.1; 5162400, 51.2; 5166000, 50.7; 5169600, 50.6; 5173200, 50.4; 5176800, 50.3; 5180400, 50.2; 5184000, 50.1], extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(Placement(transformation(extent = {{80, 80}, {100, 99}})));
  Modelica.Blocks.Sources.Constant solarRadiation(k=0)
    annotation (Placement(transformation(extent={{-46,62},{-26,82}})));
equation
  referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;
  connect(machinesRadiative.port, HeatToStar.Therm) annotation(Line(points = {{58, -66}, {70, -66}, {70, -47.2}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(tableMachines.y[1], machinesRadiative.Q_flow) annotation(Line(points = {{16.7, -66}, {38, -66}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation(Line(points = {{-24, 30}, {-6, 30}, {-6, 27.68}, {15.4, 27.68}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points = {{-23, 0}, {-4, 0}, {-4, 18.84}, {15.4, 18.84}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points={{17,-30},
          {20,-30},{20,11.7},{22.54,11.7}},                                                                                            color = {0, 0, 127}, smooth = Smooth.None));
  connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation(Line(points={{70,
          -28.9},{70,-18},{41.75,-18},{41.75,11.7}},                                                                                      color = {95, 95, 95}, pattern = LinePattern.Solid, smooth = Smooth.None));
  connect(solarRadiation.y, reducedModel.solarRad_in) annotation (Line(
      points={{-25,72},{21.18,72},{21.18,42.98}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,
             extent={{-100,-100},{100,100}}),      graphics),
             experiment(StopTime = 5.184e+006, Interval = 3600),
             __Dymola_Commands(file=
                               "modelica://AixLib/Resources/Scripts/Dymola/Building/LowOrder/Examples/Validation/Star/TestCase2.mos"
        "Simulate and plot"),
             __Dymola_experimentSetupOutput(events = false),
             Icon(graphics),
             Documentation(info="<html>
<p>Test Case 2 of the VDI6007: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to a radiant heat source for Type room S </p>
<ul>
<li>constant outdoor temperature 22 degC </li>
<li>no shortwave radiation on the outer wall </li>
<li>no shortwave radiation through the window </li>
<li>no longwave radiation exchange between outer wall, window and ambience </li>
</ul>
<p>Reference: Room air temperature </p>
<p>Variable path: <code>reducedModel.airload.T</code> </p>
<p><br><br>All values are given in the VDI 6007-1. </p>
<p>Same Test Case exists in VDI 6020. </p>
<p>A script to run this test case can be found in AixLib\\Resources\\Scripts\\Dymola\\Building\\LowOrder\\Examples\\Validation\\Star.</p>
</html>",  revisions="<html>
<ul>
<li><i>June 8, 2015 </i> by Marcus Fuchs:<br>Added unit testing command to annotations </li>
</ul>
<p><i>February 2014</i>, by Peter Remmen:</p>
<p>Implemented </p>
</html>"));
end TestCase2;
