within AixLib.Building.LowOrder.Validation.VDI6007;
model TestCase_6
  extends Modelica.Icons.Example;

  output Real referenceLoad[1];
  output Real simulationLoad;

  Modelica.Blocks.Sources.Constant infiltrationRate(k=0)
    annotation (Placement(transformation(extent={{30,-4},{40,6}})));
  Modelica.Blocks.Sources.Constant infiltrationTemp(k=22)
    annotation (Placement(transformation(extent={{6,-4},{16,6}})));
  Utilities.HeatTransfer.HeatToStar HeatToStar(A=2)
    annotation (Placement(transformation(extent={{40,-98},{60,-78}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRadiative
    annotation (Placement(transformation(extent={{-4,-100},{22,-78}})));
  Modelica.Blocks.Sources.CombiTimeTable innerLoads(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=false,
    table=[0,0,0; 3600,0,0; 7200,0,0; 10800,0,0; 14400,0,0; 18000,0,0;
        21600,0,0; 25200,0,1000; 28800,0,1000; 32400,0,1000; 36000,0,1000;
        39600,0,1000; 43200,0,1000; 46800,0,1000; 50400,0,1000; 54000,0,
        1000; 57600,0,1000; 61200,0,1000; 64800,0,1000; 68400,0,0; 72000,
        0,0; 75600,0,0; 79200,0,0; 82800,0,0; 86400,0,0])
    annotation (Placement(transformation(extent={{-48,-98},{-28,-78}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature outdoorTemp(T=295.15)
    annotation (Placement(transformation(extent={{-24,39},{-4,59}})));
  Building.LowOrder.BaseClasses.ReducedOrderModel reducedModel(
    C1i=1.48216e+007,
    Aw=7,
    g=0.15,
    C1o=1.60085e+006,
    alphaiwi=2.2,
    epsi=1,
    epso=1,
    T0all(displayUnit="K") = 295.15,
    R1i=0.000595515,
    Ai=75.5,
    RRest=0.042748777,
    R1o=0.004366222,
    Ao=10.5,
    withWindows=false)
    annotation (Placement(transformation(extent={{54,26},{88,66}})));
  Modelica.Blocks.Sources.CombiTimeTable setTemp(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    columns={2},
    table=[0,295.1; 3600,295.1; 7200,295.1; 10800,295.1; 14400,295.1;
        18000,295.1; 21600,295.1; 25200,300.1; 28800,300.1; 32400,300.1;
        36000,300.1; 39600,300.1; 43200,300.1; 46800,300.1; 50400,300.1;
        54000,300.1; 57600,300.1; 61200,300.1; 64800,300.1; 68400,295.1;
        72000,295.1; 75600,295.1; 79200,295.1; 82800,295.1; 86400,295.1])
    annotation (Placement(transformation(extent={{-62,-38},{-42,-18}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(
    tableName="UserProfilesOffice",
    fileName="./Tables/J1615/UserProfilesOffice.txt",
    tableOnFile=false,
    columns={2,3},
    table=[3600,22,0; 7200,22,0; 10800,22,0; 14400,22,0; 18000,22,0; 21600,22,
        0; 25200,27,-764; 28800,27,-696; 32400,27,-632; 36000,27,-570; 39600,
        27,-511; 43200,27,-455; 46800,27,-402; 50400,27,-351; 54000,27,-302;
        57600,27,-255; 61200,27,-210; 64800,27,-167; 68400,22,638; 72000,22,
        610; 75600,22,583; 79200,22,557; 82800,22,533; 86400,22,511; 781200,
        22,774; 784800,22,742; 788400,22,711; 792000,22,682; 795600,22,654;
        799200,22,627; 802800,27,-163; 806400,27,-120; 810000,27,-79; 813600,
        27,-40; 817200,27,-2; 820800,27,33; 824400,27,67; 828000,27,99;
        831600,27,130; 835200,27,159; 838800,27,187; 842400,27,214; 846000,22,
        1004; 849600,22,960; 853200,22,919; 856800,22,880; 860400,22,843;
        864000,22,808; 5101200,22,774; 5104800,22,742; 5108400,22,711;
        5112000,22,682; 5115600,22,654; 5119200,22,627; 5122800,27,-163;
        5126400,27,-120; 5130000,27,-78; 5133600,27,-39; 5137200,27,-2;
        5140800,27,33; 5144400,27,67; 5148000,27,99; 5151600,27,130; 5155200,
        27,159; 5158800,27,187; 5162400,27,214; 5166000,22,1004; 5169600,22,
        960; 5173200,22,919; 5176800,22,880; 5180400,22,843; 5184000,22,808],
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{80,78},{100,97}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{24,-38},{44,-18}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp
    annotation (Placement(transformation(extent={{-6,-38},{14,-18}})));
equation

  referenceLoad[1]=-reference.y[2];
  simulationLoad=heatFlowSensor.Q_flow;

  connect(machinesRadiative.port, HeatToStar.Therm) annotation (Line(
      points={{22,-89},{28,-89},{28,-88},{40.8,-88}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(innerLoads.y[2], machinesRadiative.Q_flow) annotation (Line(
      points={{-27,-88},{-16,-88},{-16,-89},{-4,-89}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(infiltrationTemp.y, reducedModel.ventilationTemperature)
    annotation (Line(
      points={{16.5,1},{21.25,1},{21.25,36.4},{57.4,36.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(infiltrationRate.y, reducedModel.ventilationRate) annotation (
      Line(
      points={{40.5,1},{40.5,13.5},{64.2,13.5},{64.2,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HeatToStar.Star, reducedModel.internalGainsRad) annotation (
      Line(
      points={{59.1,-88},{84.09,-88},{84.09,30}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(outdoorTemp.port, reducedModel.equalAirTemp) annotation (Line(
      points={{-4,49},{26.5,49},{26.5,46.8},{57.4,46.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatFlowSensor.port_a, varTemp.port) annotation (Line(
      points={{24,-28},{14,-28}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(setTemp.y[1], varTemp.T) annotation (Line(
      points={{-41,-28},{-8,-28}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatFlowSensor.port_b, reducedModel.internalGainsConv)
    annotation (Line(
      points={{44,-28},{74.4,-28},{74.4,30}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (                  Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}),
                                        graphics),
    experiment(
      StopTime=5.184e+006,
      Interval=3600,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(revisions="<html>
<p><i>February 2014</i>, by Peter Remmen:</p><p>Implemented</p>
</html>",
        info="<html>
<p>Test Case 6 of the VDI6007: <a name=\"result_box\">L</a>oad calculation in compliance with the desired values of the indoor temperature and a setpoint for the type space S:</p>
<ul>
<li>constant outdoor temperature </li>
<li>no shortwave radiation on the outer wall</li>
<li>no shortwave radiation through the window</li>
<li>no longwave radiation exchange between outer wall, window and ambience</li>
</ul>
<p><br>Reference: Heating/Cooling load</p>
<p>Variable path: <code>heatFlowSensor.Q_flow</code></p>
<p><br><br><br>All values are given in the VDI 6007-1.</p>
<p>Same Test Case exists in VDI 6020.</p>
</html>"),
    Icon(graphics));
end TestCase_6;
