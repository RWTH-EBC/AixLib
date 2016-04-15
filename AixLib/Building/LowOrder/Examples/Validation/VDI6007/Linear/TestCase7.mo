within AixLib.Building.LowOrder.Examples.Validation.VDI6007.Linear;
model TestCase7
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
                                                  reducedModel(                    Aw = 7, g = 0.15,                                     epsi = 1, epso = 1, T0all(displayUnit = "K") = 295.15, withWindows = false, R1i = 0.000595515, Ai = 75.5,                                         Ao = 10.5,
    C1i=1.48362e+007,
    RRest=0.042768721,
    R1o=0.004367913,
    C1o=1.6008e+006,
    Vair=0.01,
    alphaiwi=2.23642384)                                                                                         annotation(Placement(transformation(extent={{46,36},
            {80,76}})));
  HVAC.HeatGeneration.IdealHeaterCooler                idealHeaterCoolerVar1_1(                                    h_cooler = 0,                TN_cooler = 1, h_heater = 500, l_cooler = -500,                   KR_cooler = 1000,
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
  Modelica.Blocks.Sources.CombiTimeTable reference( tableOnFile = false, columns = {2, 3},                                                                                                    extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    table=[3600,22,0; 7200,22,0; 10800,22,0; 14400,22,0; 18000,22,0; 21600,22,0;
        25200,25.5,-500; 28800,25.8,-500; 32400,26.1,-500; 36000,26.5,-500; 39600,
        26.8,-500; 43200,27,-481; 46800,27,-426; 50400,27,-374; 54000,27,-324; 57600,
        27,-276; 61200,27,-230; 64800,27,-186; 68400,22.7,500; 72000,22.6,500; 75600,
        22.4,500; 79200,22.3,500; 82800,22.2,500; 86400,22,500; 781200,25.1,500;
        784800,25,500; 788400,24.8,500; 792000,24.7,500; 795600,24.6,500; 799200,
        24.4,500; 802800,27,142; 806400,27,172; 810000,27,201; 813600,27,228; 817200,
        27,254; 820800,27,278; 824400,27,302; 828000,27,324; 831600,27,345; 835200,
        27,366; 838800,27,385; 842400,27,404; 846000,25.9,500; 849600,25.8,500;
        853200,25.6,500; 856800,25.5,500; 860400,25.4,500; 864000,25.2,500; 5101200,
        25.1,500; 5104800,25,500; 5108400,24.9,500; 5112000,24.7,500; 5115600,24.6,
        500; 5119200,24.5,500; 5122800,27,149; 5126400,27,179; 5130000,27,207; 5133600,
        27,234; 5137200,27,259; 5140800,27,284; 5144400,27,307; 5148000,27,329;
        5151600,27,350; 5155200,27,371; 5158800,27,390; 5162400,27,409; 5166000,
        25.9,500; 5169600,25.8,500; 5173200,25.7,500; 5176800,25.5,500; 5180400,
        25.4,500; 5184000,25.3,500])                                                                                                     annotation(Placement(transformation(extent = {{80, 80}, {100, 99}})));
  Modelica.Blocks.Math.Add sumHeatLoad annotation(Placement(transformation(extent = {{-96, 86}, {-86, 96}})));
  Modelica.Blocks.Sources.Constant solarRadiation(k=0)
    annotation (Placement(transformation(extent={{-48,76},{-28,96}})));
equation
  connect(machinesRadiative.port,heatToStar. Therm) annotation(Line(points = {{22, -89}, {40.8, -89}}, color = {191, 0, 0}));
  connect(innerLoads.y[2], machinesRadiative.Q_flow) annotation(Line(points = {{-25, -89}, {-4, -89}}, color = {0, 0, 127}));
  connect(setTemp.y[2], idealHeaterCoolerVar1_1.soll_cool) annotation(Line(points = {{-59, -20}, {-50, -20}, {-50, -15.2}, {-30.8, -15.2}}, color = {0, 0, 127}));
  connect(setTemp.y[1], idealHeaterCoolerVar1_1.soll_heat) annotation(Line(points = {{-59, -20}, {-50, -20}, {-50, -23}, {-30.8, -23}}, color = {0, 0, 127}));
  connect(sumHeatLoad.u1, idealHeaterCoolerVar1_1.heatMeter.p);
  connect(sumHeatLoad.u2, idealHeaterCoolerVar1_1.coolMeter.p);
  referenceLoad[1] = -reference.y[2];
  simulationLoad = sumHeatLoad.y;
  connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation(Line(points={{-4,59},
          {26.5,59},{26.5,56.8},{49.4,56.8}},                                                                                       color = {191, 0, 0}));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points={{16.5,1},
          {35.25,1},{35.25,46.4},{49.4,46.4}},                                                                                                    color = {0, 0, 127}));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points={{42.5,
          -10},{56.54,-10},{56.54,38}},                                                                                      color = {0, 0, 127}));
  connect(heatToStar.Star, reducedModel.internalGainsRad) annotation(Line(points={{59.1,
          -89},{72,-89},{72,38},{75.75,38}},                                                                                        color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(solarRadiation.y, reducedModel.solarRad_in) annotation (Line(
      points={{-27,86},{55.18,86},{55.18,74.8}},
      color={0,0,127}));
  connect(idealHeaterCoolerVar1_1.HeatCoolRoom, reducedModel.internalGainsConv)
    annotation (Line(
      points={{-24.8,-29.4},{-24.8,-48},{66.4,-48},{66.4,38}},
      color={191,0,0}));
  annotation (            experiment(StopTime = 5.184e+006, Interval = 3600, Algorithm = "Lsodar"),
             __Dymola_Commands(file=
                               "modelica://AixLib/Resources/Scripts/Dymola/Building/LowOrder/Examples/Validation/Linear/TestCase7.mos"
        "Simulate and plot"),
             __Dymola_experimentSetupOutput(events = false),
             Documentation(revisions="<html>
<ul>
 <li><i>May 28, 2015 </i> by Marcus Fuchs:<br/>Added unit testing command to annotations</li>
 </ul>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>", info="<html>
<p>Test Case 7 of the VDI6007: <a name=\"result_box\">L</a>oad calculation in compliance with the desired values of the indoor temperature and a setpoint for the type space S: </p>
<p><br/>This case is the same like case 6, but with a maximum heating/cooling power. </p>
<ul>
<li>constant outdoor temperature </li>
<li>no shortwave radiation on the outer wall </li>
<li>no shortwave radiation through the window </li>
<li>no longwave radiation exchange between outer wall, window and ambience </li>
</ul>
<p>Reference: Heating/Cooling load </p>
<p>Variable path: <code>sumHeatLoad.y</code> </p>
<p>Maximum deviation: 13.25 W</p>
<p>All values are given in the VDI 6007-1. </p>
<p>Same Test Case exists in VDI 6020. </p>
<p>A script to run this test case can be found in AixLib\\Resources\\Scripts\\Dymola\\Building\\LowOrder\\Examples\\Validation\\Linear.</p>
</html>"));
end TestCase7;
