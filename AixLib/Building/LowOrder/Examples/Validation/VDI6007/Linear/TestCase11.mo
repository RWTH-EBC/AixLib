within AixLib.Building.LowOrder.Examples.Validation.VDI6007.Linear;
model TestCase11
  extends Modelica.Icons.Example;
  output Real referenceLoad[1];
  output Real simulationLoad;
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{40, 6}, {50, 16}})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent = {{16, 26}, {26, 36}})));
  Utilities.HeatTransfer.HeatToStar heatToStar(A=2)
    annotation (Placement(transformation(extent={{50,-92},{70,-72}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative annotation(Placement(transformation(extent = {{4, -94}, {30, -72}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T = 295.15) annotation(Placement(transformation(extent = {{-14, 47}, {6, 67}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelVDI
                                                 reducedModel(                    Aw = 7, g = 0.15,                     epsi = 1, epso = 1, T0all(displayUnit = "K") = 295.15,                           withWindows = false, R1i = 0.000595515, Ai = 75.5,                                         Ao = 10.5,
    C1i=1.48362e+007,
    RRest=0.042768721,
    R1o=0.004367913,
    C1o=1.6008e+006,
    Vair=0.01,
    alphaiwi=3.0013245)                                                                                                     annotation(Placement(transformation(extent = {{64, 36}, {98, 76}})));
  HVAC.HeatGeneration.IdealHeaterCooler                heater(                                    h_cooler = 0,                   KR_cooler = 1000,                TN_cooler = 1, h_heater = 500, l_cooler = -500, Cooler_on = false,
    KR_heater=10,
    TN_heater=0.1)                                                                                                     annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-26, -20})));
  Modelica.Blocks.Sources.CombiTimeTable setTemp(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, columns = {2, 3},
    table=[0,295.15,295.15; 3600,295.15,295.15; 7200,295.15,295.15; 10800,295.15,
        295.15; 14400,295.15,295.15; 18000,295.15,295.15; 21600,295.15,295.15; 25200,
        300.15,300.15; 28800,300.15,300.15; 32400,300.15,300.15; 36000,300.15,300.15;
        39600,300.15,300.15; 43200,300.15,300.15; 46800,300.15,300.15; 50400,300.15,
        300.15; 54000,300.15,300.15; 57600,300.15,300.15; 61200,300.15,300.15; 64800,
        300.15,300.15; 68400,295.15,295.15; 72000,295.15,295.15; 75600,295.15,295.15;
        79200,295.15,295.15; 82800,295.15,295.15; 86400,295.15,295.15])                                                                                                     annotation(Placement(transformation(extent = {{-80, -30}, {-60, -10}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2, 3},                                                                                                    extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    table=[3600,22,0; 7200,22,0; 10800,22,0; 14400,22,0; 18000,22,0; 21600,22,
        0; 25200,24.9,-500; 28800,25.2,-500; 32400,25.6,-500; 36000,25.9,-500;
        39600,26.2,-500; 43200,26.5,-500; 46800,26.8,-500; 50400,27,-464;
        54000,27,-397; 57600,27,-333; 61200,27,-272; 64800,27,-215; 68400,
        25.3,500; 72000,25.2,500; 75600,25.1,500; 79200,24.9,500; 82800,24.8,
        500; 86400,24.7,500; 781200,26.2,500; 784800,26.1,500; 788400,26,500;
        792000,25.8,500; 795600,25.7,500; 799200,25.6,500; 802800,27,-126;
        806400,27,-76; 810000,27,-28; 813600,27,121; 817200,27,391; 820800,27,
        500; 824400,27.1,500; 828000,27.2,500; 831600,27.3,500; 835200,27.4,
        500; 838800,27.5,500; 842400,27.6,500; 846000,27,500; 849600,26.9,500;
        853200,26.7,500; 856800,26.6,500; 860400,26.5,500; 864000,26.4,500;
        5101200,26.2,500; 5104800,26.1,500; 5108400,26,500; 5112000,25.8,500;
        5115600,25.7,500; 5119200,25.6,500; 5122800,27,-126; 5126400,27,-76;
        5130000,27,-28; 5133600,27,121; 5137200,27,391; 5140800,27,500;
        5144400,27.1,500; 5148000,27.2,500; 5151600,27.3,500; 5155200,27.4,
        500; 5158800,27.5,500; 5162400,27.6,500; 5166000,27,500; 5169600,26.9,
        500; 5173200,26.7,500; 5176800,26.6,500; 5180400,26.5,500; 5184000,
        26.4,500])                                                                                                     annotation(Placement(transformation(extent = {{-96, 78}, {-76, 97}})));
  Modelica.Blocks.Math.Add sumHeatLoad annotation(Placement(transformation(extent = {{86, 86}, {96, 96}})));
  HVAC.HeatGeneration.IdealHeaterCooler                cooler(                                    h_cooler = 0, KR_heater = 1000, KR_cooler = 1000, TN_heater = 1, TN_cooler = 1, h_heater = 500, l_cooler = -500, Heater_on = false) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-26, -48})));
  Modelica.Blocks.Sources.CombiTimeTable innerLoads(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2, 3}, table = [0, 0, 0; 3600, 0, 0; 7200, 0, 0; 10800, 0, 0; 14400, 0, 0; 18000, 0, 0; 21600, 0, 0; 21600, 0, 1000; 25200, 0, 1000; 28800, 0, 1000; 32400, 0, 1000; 36000, 0, 1000; 39600, 0, 1000; 43200, 0, 1000; 46800, 0, 1000; 50400, 0, 1000; 54000, 0, 1000; 57600, 0, 1000; 61200, 0, 1000; 64800, 0, 1000; 64800, 0, 0; 68400, 0, 0; 72000, 0, 0; 75600, 0, 0; 79200, 0, 0; 82800, 0, 0; 86400, 0, 0]) annotation(Placement(transformation(extent = {{-24, -93}, {-10, -79}})));
  Modelica.Blocks.Sources.Constant solarRadiation(k=0)
    annotation (Placement(transformation(extent={{-36,72},{-16,92}})));
equation
  connect(machinesRadiative.port, heatToStar.Therm) annotation (Line(
      points={{30,-83},{38,-83},{38,-82},{50.8,-82}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(setTemp.y[1], heater.soll_heat) annotation(Line(points = {{-59, -20}, {-50, -20}, {-50, -23}, {-30.8, -23}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(sumHeatLoad.u2, cooler.coolMeter.p);
  connect(cooler.HeatCoolRoom, reducedModel.heatConvInnerwall.port_b);
  connect(sumHeatLoad.u1, heater.heatMeter.p);
  referenceLoad[1] = -reference.y[2];
  simulationLoad = sumHeatLoad.y;
  connect(setTemp.y[2], cooler.soll_cool) annotation(Line(points = {{-59, -20}, {-44, -20}, {-44, -43.2}, {-30.8, -43.2}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[2], machinesRadiative.Q_flow) annotation(Line(points = {{-9.3, -86}, {-2, -86}, {-2, -83}, {4, -83}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(heatToStar.Star, reducedModel.internalGainsRad) annotation (Line(
      points={{69.1,-82},{93.75,-82},{93.75,38}},
      color={95,95,95},
      pattern=LinePattern.Solid,
      smooth=Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (Line(
      points={{50.5,11},{74,11},{74,38},{74.54,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation (
      Line(
      points={{26.5,31},{48,31},{48,46.4},{67.4,46.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation (Line(
      points={{6,57},{38,57},{38,56.8},{67.4,56.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solarRadiation.y, reducedModel.solarRad_in) annotation (Line(
      points={{-15,82},{73.18,82},{73.18,74.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heater.HeatCoolRoom, reducedModel.internalGainsConv) annotation (Line(
      points={{-24.8,-29.4},{84.4,-29.4},{84.4,38}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation(experiment(StopTime = 5.184e+006, Interval = 3600),
             __Dymola_Commands(file=
                               "modelica://AixLib/Resources/Scripts/Dymola/Building/LowOrder/Examples/Validation/Linear/TestCase11.mos"
        "Simulate and plot"),
             __Dymola_experimentSetupOutput(events = false), Icon(graphics),
             Diagram(coordinateSystem(preserveAspectRatio=false,
             extent={{-100,-100},{100,100}}),
                      graphics),
            Documentation(revisions="<html>
<p><ul>
 <li><i>May 28, 2015 </i> by Marcus Fuchs:<br/>Added unit testing command to annotations</li>
 </ul></p>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>", info="<html>
<p>Test Case 11 of the VDI6007: <a name=\"result_box\">L</a>oad calculation in compliance with the desired values of the indoor temperature and a setpoint for the type space S: </p>
<p>Based on Test Case 7 </p>
<ul>
<li>implementation of a cooling ceeling (only cooling) </li>
</ul>
<p>Reference: Heating/Cooling load </p>
<p>Variable path: <code>sumHeatLoad.y</code> </p>
<p>Maximum deviation: 55.95 W </p>
<p>All values are given in the VDI 6007-1. </p>
<p>A script to run this test case can be found in AixLib\\Resources\\Scripts\\Dymola\\Building\\LowOrder\\Examples\\Validation\\Linear.</p>
</html>"));
end TestCase11;
