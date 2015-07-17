within AixLib.Building.LowOrder.Examples.Validation.VDI6007.Linear;
model TestCase_7
  extends Modelica.Icons.Example;
  output Real referenceLoad[1];
  output Real simulationLoad;
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{32, -15}, {42, -5}})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent = {{6, -4}, {16, 6}})));
  Utilities.HeatTransfer.HeatToStar heatToStar(A = 2) annotation(Placement(transformation(extent = {{40, -99}, {60, -79}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative annotation(Placement(transformation(extent = {{-4, -100}, {22, -78}})));
  Modelica.Blocks.Sources.CombiTimeTable innerLoads(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = [0, 0, 0; 3600, 0, 0; 7200, 0, 0; 10800, 0, 0; 14400, 0, 0; 18000, 0, 0; 21600, 0, 0; 25200, 0, 1000; 28800, 0, 1000; 32400, 0, 1000; 36000, 0, 1000; 39600, 0, 1000; 43200, 0, 1000; 46800, 0, 1000; 50400, 0, 1000; 54000, 0, 1000; 57600, 0, 1000; 61200, 0, 1000; 64800, 0, 1000; 68400, 0, 0; 72000, 0, 0; 75600, 0, 0; 79200, 0, 0; 82800, 0, 0; 86400, 0, 0]) annotation(Placement(transformation(extent = {{-46, -99}, {-26, -79}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T = 295.15) annotation(Placement(transformation(extent = {{-24, 49}, {-4, 69}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelVDI
                                                  reducedModel(                    Aw = 7, g = 0.15,                     alphaiwi = 2.2, epsi = 1, epso = 1, T0all(displayUnit = "K") = 295.15, withWindows = false, R1i = 0.000595515, Ai = 75.5,                                         Ao = 10.5,
    C1i=1.48362e+007,
    RRest=0.042768721,
    R1o=0.004367913,
    C1o=1.6008e+006)                                                                                                     annotation(Placement(transformation(extent={{46,36},
            {80,76}})));
  Utilities.Sources.HeaterCooler.IdealHeaterCoolerVar1 idealHeaterCoolerVar1_1(Q_flow_heat = 1, Q_flow_cooler = 1, h_cooler = 0, TN_heater = 1, TN_cooler = 1, h_heater = 500, l_cooler = -500, KR_heater = 1000, KR_cooler = 1000) annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {-26, -20})));
  Modelica.Blocks.Sources.CombiTimeTable setTemp(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, columns = {2, 3}, table = [0, 295.15, 295.2; 3600, 295.1, 295.2; 7200, 295.1, 295.2; 10800, 295.1, 295.2; 14400, 295.1, 295.2; 18000, 295.1, 295.2; 21600, 295.1, 295.2; 25200, 300.1, 300.2; 28800, 300.1, 300.2; 32400, 300.1, 300.2; 36000, 300.1, 300.2; 39600, 300.1, 300.2; 43200, 300.1, 300.2; 46800, 300.1, 300.2; 50400, 300.1, 300.2; 54000, 300.1, 300.2; 57600, 300.1, 300.2; 61200, 300.1, 300.2; 64800, 300.1, 300.2; 68400, 295.1, 295.2; 72000, 295.1, 295.2; 75600, 295.1, 295.2; 79200, 295.1, 295.2; 82800, 295.1, 295.2; 86400, 295.1, 295.2]) annotation(Placement(transformation(extent = {{-80, -30}, {-60, -10}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2, 3}, table = [3600, 22, 0; 7200, 22, 0; 10800, 22, 0; 14400, 22, 0; 18000, 22, 0; 21600, 22, 0; 25200, 25.5, -500; 28800, 25.8, -500; 32400, 26.1, -500; 36000, 26.5, -500; 39600, 26.8, -500; 43200, 27, -481; 46800, 27, -426; 50400, 27, -374; 54000, 27, -324; 57600, 27, -276; 61200, 27, -230; 64800, 27, -186; 68400, 22.7, 500; 72000, 22.6, 500; 75600, 22.4, 500; 79200, 22.3, 500; 82800, 22.2, 500; 86400, 22, 500; 781200, 25.1, 500; 784800, 25, 500; 788400, 24.8, 500; 792000, 24.7, 500; 795600, 24.6, 500; 799200, 24.4, 500; 802800, 27, 142; 806400, 27, 172; 810000, 27, 201; 813600, 27, 228; 817200, 27, 254; 820800, 27, 278; 824400, 27, 302; 828000, 27, 324; 831600, 27, 345; 835200, 27, 366; 838800, 27, 385; 842400, 27, 404; 846000, 25.9, 500; 849600, 25.8, 500; 853200, 25.6, 500; 856800, 25.5, 500; 860400, 25.4, 500; 864000, 25.2, 500; 5101200, 25.1, 500; 5104800, 25, 500; 5108400, 24.9, 500; 5112000, 24.7, 500; 5115600, 24.6, 500; 5119200, 24.5, 500; 5122800, 27, 149; 5126400, 27, 179; 5130000, 27, 207; 5133600, 27, 234; 5137200, 27, 259; 5140800, 27, 284; 5144400, 27, 307; 5148000, 27, 329; 5151600, 27, 350; 5155200, 27, 371; 5158800, 27, 390; 5162400, 27, 409; 5166000, 25.9, 500; 5169600, 25.8, 500; 5173200, 25.7, 500; 5176800, 25.5, 500; 5180400, 25.4, 500; 5184000, 25.3, 500], extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(Placement(transformation(extent = {{80, 80}, {100, 99}})));
  Modelica.Blocks.Math.Add sumHeatLoad annotation(Placement(transformation(extent = {{-96, 86}, {-86, 96}})));
  Modelica.Blocks.Sources.Constant solarRadiation(k=0)
    annotation (Placement(transformation(extent={{-48,76},{-28,96}})));
equation
  connect(machinesRadiative.port,heatToStar. Therm) annotation(Line(points = {{22, -89}, {40.8, -89}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(innerLoads.y[2], machinesRadiative.Q_flow) annotation(Line(points = {{-25, -89}, {-4, -89}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(setTemp.y[2], idealHeaterCoolerVar1_1.soll_cool) annotation(Line(points = {{-59, -20}, {-50, -20}, {-50, -15.2}, {-30.8, -15.2}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(setTemp.y[1], idealHeaterCoolerVar1_1.soll_heat) annotation(Line(points = {{-59, -20}, {-50, -20}, {-50, -23}, {-30.8, -23}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(sumHeatLoad.u1, idealHeaterCoolerVar1_1.heatMeter.p);
  connect(sumHeatLoad.u2, idealHeaterCoolerVar1_1.coolMeter.p);
  referenceLoad[1] = -reference.y[2];
  simulationLoad = sumHeatLoad.y;
  connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation(Line(points={{-4,59},
          {26.5,59},{26.5,56.8},{49.4,56.8}},                                                                                       color = {191, 0, 0}, smooth = Smooth.None));
  connect(idealHeaterCoolerVar1_1.heatCoolRoom, reducedModel.internalGainsConv) annotation(Line(points={{-26,-29},
          {30,-29},{30,-32},{66.4,-32},{66.4,38}},                                                                                                    color = {191, 0, 0}, smooth = Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points={{16.5,1},
          {35.25,1},{35.25,46.4},{49.4,46.4}},                                                                                                    color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points={{42.5,
          -10},{56.54,-10},{56.54,38}},                                                                                      color = {0, 0, 127}, smooth = Smooth.None));
  connect(heatToStar.Star, reducedModel.internalGainsRad) annotation(Line(points={{59.1,
          -89},{72,-89},{72,38},{75.75,38}},                                                                                        color = {95, 95, 95}, pattern = LinePattern.None, smooth = Smooth.None));
  connect(solarRadiation.y, reducedModel.solarRad_in) annotation (Line(
      points={{-27,86},{55.18,86},{55.18,74.8}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,
                     extent={{-100,-100},{100,100}}),
                     graphics),
             experiment(StopTime = 5.184e+006, Interval = 3600, Algorithm = "Lsodar"),
             __Dymola_Commands(file=
                               "modelica://AixLib/Resources/Scripts/Dymola/Building/LowOrder/Examples/Validation/Linear/TestCase_7.mos"
        "Simulate and plot"),
             __Dymola_experimentSetupOutput(events = false),
             Documentation(revisions="<html>
<p><ul>
 <li><i>May 28, 2015 </i> by Marcus Fuchs:<br/>Added unit testing command to annotations</li>
 </ul></p>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>", info = "<html>
 <p>Test Case 7 of the VDI6007: <a name=\"result_box\">L</a>oad calculation in compliance with the desired values of the indoor temperature and a setpoint for the type space S:</p>
 <p><br>This case is the same like case 6, but with a maximum heating/cooling power.</p>
 <ul>
 <li>constant outdoor temperature </li>
 <li>no shortwave radiation on the outer wall</li>
 <li>no shortwave radiation through the window</li>
 <li>no longwave radiation exchange between outer wall, window and ambience</li>
 </ul>
 <p>Reference: Heating/Cooling load</p>
 <p>Variable path: <code>sumHeatLoad.y</code></p>
 <p><br><br>All values are given in the VDI 6007-1.</p>
 <p>Same Test Case exists in VDI 6020.</p>
 </html>"), Icon(graphics));
end TestCase_7;
