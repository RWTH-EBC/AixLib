within AixLib.Building.LowOrder.Examples.Validation.VDI6007.Linear;
model TestCase10
  extends Modelica.Icons.Example;
  output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC referenceTemp[1];
  output Modelica.SIunits.Temp_K simulationTemp;
  Modelica.Blocks.Sources.Constant infiltrationRate(k = 0) annotation(Placement(transformation(extent = {{40, 0}, {50, 10}})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k = 22) annotation(Placement(transformation(extent = {{16, 0}, {26, 10}})));
  Modelica.Blocks.Sources.CombiTimeTable windowRad(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, table = [0, 0, 0, 0, 0, 0.0; 3600, 0, 0, 0, 0, 0.0; 10800, 0, 0, 0, 0, 0.0; 14400, 0, 0, 0, 0, 0.0; 14400, 0, 0, 17, 0, 0.0; 18000, 0, 0, 17, 0, 0.0; 18000, 0, 0, 38, 0, 0.0; 21600, 0, 0, 38, 0, 0.0; 21600, 0, 0, 59, 0, 0.0; 25200, 0, 0, 59, 0, 0.0; 25200, 0, 0, 98, 0, 0.0; 28800, 0, 0, 98, 0, 0.0; 28800, 0, 0, 186, 0, 0.0; 32400, 0, 0, 186, 0, 0.0; 32400, 0, 0, 287, 0, 0.0; 36000, 0, 0, 287, 0, 0.0; 36000, 0, 0, 359, 0, 0.0; 39600, 0, 0, 359, 0, 0.0; 39600, 0, 0, 385, 0, 0.0; 43200, 0, 0, 385, 0, 0.0; 43200, 0, 0, 359, 0, 0.0; 46800, 0, 0, 359, 0, 0.0; 46800, 0, 0, 287, 0, 0.0; 50400, 0, 0, 287, 0, 0.0; 50400, 0, 0, 186, 0, 0.0; 54000, 0, 0, 186, 0, 0.0; 54000, 0, 0, 98, 0, 0.0; 57600, 0, 0, 98, 0, 0.0; 57600, 0, 0, 59, 0, 0.0; 61200, 0, 0, 59, 0, 0.0; 61200, 0, 0, 38, 0, 0.0; 64800, 0, 0, 38, 0, 0.0; 64800, 0, 0, 17, 0, 0.0; 68400, 0, 0, 17, 0, 0.0; 68400, 0, 0, 0, 0, 0.0; 72000, 0, 0, 0, 0, 0.0; 82800, 0, 0, 0, 0, 0.0; 86400, 0, 0, 0, 0, 0.0], columns = {2, 3, 4, 5, 6}) annotation(Placement(transformation(extent = {{-86, 72}, {-66, 92}})));
  Utilities.Sources.PrescribedSolarRad Quelle_Fenster(n = 5) annotation(Placement(transformation(extent = {{-50, 72}, {-30, 92}})));
  Components.Weather.Sunblinds.Sunblind sunblind(n = 5, gsunblind = {0, 0, 0.15, 0, 0}) annotation(Placement(transformation(extent={{-20,71},
            {0,91}})));
  Building.LowOrder.BaseClasses.SolarRadWeightedSum rad_weighted_sum(n = 5, weightfactors = {0, 0, 7, 0, 0}) annotation(Placement(transformation(extent={{28,72},
            {48,92}})));
  BaseClasses.EqAirTemp.EqAirTempSimple eqAirTemp_TestCase_8_1(
    alphaowo=25,
    wf_ground=0.629038674,
    n=5,
    wf_wall={0.000000000,0.000000000,0.046454666,0.000000000,0.0},
    wf_win={0.000000000,0.000000000,0.324506660,0.000000000,0.0},
    withLongwave=false,
    T_ground=288.15)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Utilities.Sources.PrescribedSolarRad Quelle_Wand(n = 5) annotation(Placement(transformation(extent = {{-58, 44}, {-38, 64}})));
  Modelica.Blocks.Sources.CombiTimeTable outdoorTemp(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, columns = {2, 3, 4}, table = [0, 291.95, 0, 0; 3600, 291.95, 0, 0; 3600, 290.25, 0, 0; 7200, 290.25, 0, 0; 7200, 289.65, 0, 0; 10800, 289.65, 0, 0; 10800, 289.25, 0, 0; 14400, 289.25, 0, 0; 14400, 289.65, 0, 0; 18000, 289.65, 0, 0; 18000, 290.95, 0, 0; 21600, 290.95, 0, 0; 21600, 293.45, 0, 0; 25200, 293.45, 0, 0; 25200, 295.95, 0, 0; 28800, 295.95, 0, 0; 28800, 297.95, 0, 0; 32400, 297.95, 0, 0; 32400, 299.85, 0, 0; 36000, 299.85, 0, 0; 36000, 301.25, 0, 0; 39600, 301.25, 0, 0; 39600, 302.15, 0, 0; 43200, 302.15, 0, 0; 43200, 302.85, 0, 0; 46800, 302.85, 0, 0; 46800, 303.55, 0, 0; 50400, 303.55, 0, 0; 50400, 304.05, 0, 0; 54000, 304.05, 0, 0; 54000, 304.15, 0, 0; 57600, 304.15, 0, 0; 57600, 303.95, 0, 0; 61200, 303.95, 0, 0; 61200, 303.25, 0, 0; 64800, 303.25, 0, 0; 64800, 302.05, 0, 0; 68400, 302.05, 0, 0; 68400, 300.15, 0, 0; 72000, 300.15, 0, 0; 72000, 297.85, 0, 0; 75600, 297.85, 0, 0; 75600, 296.05, 0, 0; 79200, 296.05, 0, 0; 79200, 295.05, 0, 0; 82800, 295.05, 0, 0; 82800, 294.05, 0, 0; 86400, 294.05, 0, 0]) annotation(Placement(transformation(extent={{-100,10},
            {-80,30}})));
  Modelica.Blocks.Sources.Constant wallRad(k = 0) annotation(Placement(transformation(extent = {{-126, 50}, {-116, 60}})));
  Modelica.Blocks.Routing.Multiplex5 multiplex5_1 annotation(Placement(transformation(extent = {{-84, 44}, {-64, 64}})));
  BaseClasses.ReducedOrderModel.ReducedOrderModelVDI  reducedModel(
    R1i=0.000779672,
    C1i=1.23140e+07,
    Ai=58,
    splitfac=0.09,
    Aw=7,
    epsw=1,
    RRest=0.014406788,
    R1o=0.001719315,
    C1o=4.33875e+06,
    Ao=28,
    epsi=1,
    epso=1,
    g=1,
    T0all=290.75,
    alphaiwi=2.39827586,
    alphaowi=2.075)
    annotation (Placement(transformation(extent={{52,42},{100,92}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(tableName = "UserProfilesOffice", fileName = "./Tables/J1615/UserProfilesOffice.txt", tableOnFile = false, columns = {2}, table = [3600, 17.6; 7200, 17.6; 10800, 17.5; 14400, 17.5; 18000, 17.6; 21600, 17.8; 25200, 18; 28800, 20; 32400, 19.7; 36000, 20; 39600, 20.3; 43200, 20.5; 46800, 20.6; 50400, 20.7; 54000, 20.8; 57600, 21.5; 61200, 21.4; 64800, 19.8; 68400, 19.7; 72000, 19.6; 75600, 19.6; 79200, 19.5; 82800, 19.5; 86400, 19.5; 781200, 24.7; 784800, 24.6; 788400, 24.5; 792000, 24.4; 795600, 24.4; 799200, 24.5; 802800, 24.6; 806400, 26.6; 810000, 26.2; 813600, 26.4; 817200, 26.6; 820800, 26.8; 824400, 26.9; 828000, 26.9; 831600, 26.9; 835200, 27.5; 838800, 27.4; 842400, 25.7; 846000, 25.5; 849600, 25.3; 853200, 25.3; 856800, 25.2; 860400, 25.1; 864000, 25; 5101200, 25.5; 5104800, 25.3; 5108400, 25.2; 5112000, 25.1; 5115600, 25.1; 5119200, 25.2; 5122800, 25.3; 5126400, 27.3; 5130000, 26.9; 5133600, 27.1; 5137200, 27.3; 5140800, 27.4; 5144400, 27.5; 5148000, 27.5; 5151600, 27.5; 5155200, 28.1; 5158800, 28; 5162400, 26.3; 5166000, 26.1; 5169600, 26; 5173200, 25.9; 5176800, 25.8; 5180400, 25.7; 5184000, 25.6], extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation(Placement(transformation(extent = {{-98, -26}, {-78, -7}})));
  Utilities.HeatTransfer.HeatToStar HeatTorStar(A = 2) annotation(Placement(transformation(extent = {{56, -100}, {76, -80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesConvective annotation(Placement(transformation(extent = {{20, -52}, {40, -32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsConvective annotation(Placement(transformation(extent = {{20, -72}, {40, -52}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow personsRadiative annotation(Placement(transformation(extent = {{20, -100}, {40, -80}})));
  Modelica.Blocks.Sources.CombiTimeTable innerLoads(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, tableOnFile = false, table = [0, 0, 0, 0; 3600, 0, 0, 0; 7200, 0, 0, 0; 10800, 0, 0, 0; 14400, 0, 0, 0; 18000, 0, 0, 0; 21600, 0, 0, 0; 25200, 0, 0, 0; 25200, 80, 80, 200; 28800, 80, 80, 200; 32400, 80, 80, 200; 36000, 80, 80, 200; 39600, 80, 80, 200; 43200, 80, 80, 200; 46800, 80, 80, 200; 50400, 80, 80, 200; 54000, 80, 80, 200; 57600, 80, 80, 200; 61200, 80, 80, 200; 61200, 0, 0, 0; 64800, 0, 0, 0; 72000, 0, 0, 0; 75600, 0, 0, 0; 79200, 0, 0, 0; 82800, 0, 0, 0; 86400, 0, 0, 0], columns = {2, 3, 4}) annotation(Placement(transformation(extent = {{-48, -72}, {-28, -52}})));
  BaseClasses.SolarRadAdapter solarRadAdapter1[5]
    annotation (Placement(transformation(extent={{-40,44},{-20,64}})));
  BaseClasses.SolarRadAdapter solarRadAdapter2[5]
    annotation (Placement(transformation(extent={{2,72},{22,92}})));
equation
  referenceTemp = reference.y;
  simulationTemp = reducedModel.airload.port.T;
  connect(wallRad.y, multiplex5_1.u1[1]) annotation(Line(points = {{-115.5, 55}, {-104, 55}, {-104, 64}, {-86, 64}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(wallRad.y, multiplex5_1.u2[1]) annotation(Line(points = {{-115.5, 55}, {-104, 55}, {-104, 59}, {-86, 59}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(wallRad.y, multiplex5_1.u3[1]) annotation(Line(points = {{-115.5, 55}, {-104, 55}, {-104, 54}, {-86, 54}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(wallRad.y, multiplex5_1.u4[1]) annotation(Line(points = {{-115.5, 55}, {-104, 55}, {-104, 49}, {-86, 49}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(sunblind.sunblindonoff, eqAirTemp_TestCase_8_1.sunblindsig) annotation(Line(points={{-10,72},
          {-10,28}},                                                                                                    color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature) annotation(Line(points={{26.5,5},
          {34,5},{34,55},{56.8,55}},                                                                                                    color = {0, 0, 127}, smooth = Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation(Line(points={{50.5,5},
          {66.88,5},{66.88,44.5}},                                                                                       color = {0, 0, 127}, smooth = Smooth.None));
  connect(wallRad.y, multiplex5_1.u5[1]) annotation(Line(points = {{-115.5, 55}, {-104.75, 55}, {-104.75, 44}, {-86, 44}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(HeatTorStar.Star, reducedModel.internalGainsRad) annotation(Line(points={{75.1,
          -90},{92,-90},{92,44.5},{94,44.5}},                                                                                        color = {95, 95, 95}, pattern = LinePattern.Solid, smooth = Smooth.None));
  connect(personsConvective.port, reducedModel.internalGainsConv) annotation(Line(points={{40,-62},
          {80.8,-62},{80.8,44.5}},                                                                                               color = {191, 0, 0}, smooth = Smooth.None));
  connect(machinesConvective.port, reducedModel.internalGainsConv) annotation(Line(points={{40,-42},
          {80.8,-42},{80.8,44.5}},                                                                                                color = {191, 0, 0}, smooth = Smooth.None));
  connect(innerLoads.y[3], machinesConvective.Q_flow) annotation(Line(points = {{-27, -62}, {-8, -62}, {-8, -42}, {20, -42}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[2], personsConvective.Q_flow) annotation(Line(points = {{-27, -62}, {20, -62}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(innerLoads.y[1], personsRadiative.Q_flow) annotation(Line(points = {{-27, -62}, {-8, -62}, {-8, -90}, {20, -90}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(personsRadiative.port, HeatTorStar.Therm) annotation(Line(points = {{40, -90}, {56.8, -90}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(outdoorTemp.y, eqAirTemp_TestCase_8_1.weatherData) annotation (Line(
      points={{-79,20},{-18,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(eqAirTemp_TestCase_8_1.equalAirTemp, reducedModel.equalAirTemp)
    annotation (Line(
      points={{-0.2,14.4},{-8,14.4},{-8,14},{8,14},{8,68},{56.8,68}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(multiplex5_1.y, Quelle_Wand.I) annotation (Line(
      points={{-63,54},{-60,54},{-60,62.9},{-56.9,62.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex5_1.y, Quelle_Wand.I_dir) annotation (Line(
      points={{-63,54},{-60,54},{-60,59},{-57,59}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex5_1.y, Quelle_Wand.I_diff) annotation (Line(
      points={{-63,54},{-60,54},{-60,55},{-57,55}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex5_1.y, Quelle_Wand.I_gr) annotation (Line(
      points={{-63,54},{-60.5,54},{-60.5,50.9},{-56.9,50.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex5_1.y, Quelle_Wand.AOI) annotation (Line(
      points={{-63,54},{-60,54},{-60,47},{-57,47}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.I) annotation (Line(
      points={{-65,82},{-58,82},{-58,90.9},{-48.9,90.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.I_dir) annotation (Line(
      points={{-65,82},{-58,82},{-58,87},{-49,87}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.I_diff) annotation (Line(
      points={{-65,82},{-58,82},{-58,83},{-49,83}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.I_gr) annotation (Line(
      points={{-65,82},{-58,82},{-58,78.9},{-48.9,78.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(windowRad.y, Quelle_Fenster.AOI) annotation (Line(
      points={{-65,82},{-58,82},{-58,75},{-49,75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Quelle_Wand.solarRad_out, solarRadAdapter1.solarRad_in) annotation (
      Line(
      points={{-39,54},{-39,54}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(solarRadAdapter1.solarRad_out, eqAirTemp_TestCase_8_1.solarRad_in)
    annotation (Line(
      points={{-20,54},{-20,25.6},{-18.5,25.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solarRadAdapter2.solarRad_out, rad_weighted_sum.solarRad_in)
    annotation (Line(
      points={{22,82},{29,82}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(rad_weighted_sum.solarRad_out, reducedModel.solarRad_in) annotation (
      Line(
      points={{47,82},{52,82},{52,98},{64.96,98},{64.96,90.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Quelle_Fenster.solarRad_out, sunblind.Rad_In) annotation (Line(
      points={{-31,82},{-19,82}},
      color={255,128,0},
      smooth=Smooth.None));
  connect(sunblind.Rad_Out, solarRadAdapter2.solarRad_in) annotation (Line(
      points={{-1,82},{3,82}},
      color={255,128,0},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),
            graphics),
            experiment(StopTime = 5.184e+006, Interval = 3600),
            __Dymola_Commands(file=
                               "modelica://AixLib/Resources/Scripts/Dymola/Building/LowOrder/Examples/Validation/Linear/TestCase10.mos"
        "Simulate and plot"),
            __Dymola_experimentSetupOutput(events = false),
            Icon(graphics),
            Documentation(revisions="<html>
<p><ul>
 <li><i>May 28, 2015 </i> by Marcus Fuchs:<br/>Added unit testing command to annotations</li>
 </ul></p>
 <p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
 </html>", info="<html>
<p>Test Case 10 of the VDI6007:: <a name=\"result_box\">C</a>alculation of the reaction indoor temperature to mixed inner and outer heat sources for Type Room S: </p>
<p>Based on Test Case 5 </p>
<ul>
<li>The floor is a non adiabatic wall.<br></li>
</ul>
<p>Reference: Room air temperature </p>
<p>Variable path: <code>reducedModel.airload.T</code></p>
<p>Maximum deviation: 0.4 K. This is caused in the calculaton of the parameters as the used parameterization tool could not reflect the given conditions.</p>
<p>All values are given in the VDI 6007-1. </p>
<p>Same Test Case exists in VDI 6020. </p>
<p>A script to run this test case can be found in AixLib\\Resources\\Scripts\\Dymola\\Building\\LowOrder\\Examples\\Validation\\Linear.</p>
</html>"));
end TestCase10;
