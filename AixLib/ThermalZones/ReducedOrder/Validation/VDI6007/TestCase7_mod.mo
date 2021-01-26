within AixLib.ThermalZones.ReducedOrder.Validation.VDI6007;
model TestCase7_mod "VDI 6007 Test Case 7 model"
  extends Modelica.Icons.Example;

  RC.TwoElements thermalZoneTwoElements(
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    hConExt=2.7,
    hConWin=2.7,
    gWin=1,
    nExt=1,
    nInt=1,
    ratioWinConRad=0,
    AInt=75.5,
    hConInt=2.24,
    RWin=0.00000001,
    hRad=5,
    RExt={0.00436791293674},
    RExtRem=0.03895919557,
    CExt={1600848.94},
    RInt={0.000595693407511},
    CInt={14836354.6282},
    VAir=0,
    nOrientations=1,
    AWin={0},
    ATransparent={0},
    AExt={10.5},
    extWallRC(thermCapExt(each der_T(fixed=true))),
    intWallRC(thermCapInt(each der_T(fixed=true))),
    T_start=295.15)
    "Thermal zone"
    annotation (Placement(transformation(extent={{44,-2},{92,34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature preTem(
    T=295.15)
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{8,-6},{20,6}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall(Q_flow(start=0))
    "Outdoor convective heat transfer"
    annotation (Placement(transformation(extent={{36,6},{26,-4}})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 21600,1000;
        25200,1000; 28800,1000; 32400,1000; 36000,1000; 39600,1000; 43200,1000;
        46800,1000; 50400,1000; 54000,1000; 57600,1000; 61200,1000; 64800,1000;
        64800,0; 68400,0; 72000,0; 75600,0; 79200,0; 82800,0; 86400,0],
    columns={2}) "Table with internal gains"
    annotation (Placement(transformation(extent={{6,-94},{22,-78}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow machinesRad
    "Radiative heat flow machines"
    annotation (Placement(transformation(extent={{48,-98},{68,-78}})));
  Modelica.Blocks.Sources.Constant hConWall(k=25*10.5)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={30,-12})));
  Modelica.Blocks.Sources.Constant const(k=0)
    "Solar radiation"
    annotation (Placement(transformation(extent={{20,26},{30,36}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow tabsExt_fixedHeatFlow(Q_flow=0,
      alpha=0.1)  "tabsExt"
    annotation (Placement(transformation(extent={{-42,-30},{-30,-18}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow HKradExt_fixedHeatFlow(Q_flow=1,
      alpha=1)
    annotation (Placement(transformation(extent={{-42,-46},{-30,-34}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow HKradInt_fixedHeatFlow(Q_flow=0,
      alpha=0.1)
    annotation (Placement(transformation(extent={{-42,-62},{-30,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow tabsInt_fixedHeatFlow(Q_flow=0,
      alpha=0.1)
    annotation (Placement(transformation(extent={{-42,-78},{-30,-66}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow FHKExt_fixedHeatFlow(Q_flow=
        200, alpha=1)
    annotation (Placement(transformation(extent={{-68,-38},{-56,-26}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow HKConv_fixedHeatFlow(Q_flow=0,
      alpha=0.1)
    annotation (Placement(transformation(extent={{-68,-54},{-56,-42}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow FHKInt_fixedHeatFlow(Q_flow=0,
      alpha=0.1)
    annotation (Placement(transformation(extent={{-68,-70},{-56,-58}})));
  Modelica.Blocks.Sources.CombiTimeTable setTemp(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    table=[0,22; 3600,22; 7200,22; 10800,22; 14400,22; 18000,22; 21600,22;
        21600.1,27; 28800,27; 32400,27; 36000,27; 39600,27; 43200,27; 46800,27;
        50400,27; 54000,27; 57600,27; 61200,27; 64800,27; 64800.1,22; 72000,22;
        75600,22; 79200,22; 82800,22; 86400,22])
    "Set temperature for ideal heater/cooler"
    annotation (Placement(transformation(extent={{-52,60},{-36,76}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    "Convert set temperature from degC to Kelvin"
    annotation (Placement(transformation(extent={{-22,62},{-10,74}})));
  Modelica.Blocks.Math.Gain gainHeaCoo(k=500)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{24,62},{36,74}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heaCoo
    "Ideal heater/cooler with limit"
    annotation (Placement(transformation(extent={{60,58},{80,78}})));
  Controls.Continuous.LimPID conHeaCoo(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=-1,
    k=0.1,
    Ti=4)
    "Heating and cooling controller"
    annotation (Placement(transformation(extent={{-2,60},{14,76}})));
  Modelica.Blocks.Sources.CombiTimeTable reference(
    tableOnFile=false,
    columns={2},
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 25200,500;
        28800,500; 32400,500; 36000,500; 39600,500; 43200,481; 46800,426; 50400,
        374; 54000,324; 57600,276; 61200,230; 64800,186; 68400,-500; 72000,-500;
        75600,-500; 79200,-500; 82800,-500; 86400,-500; 781200,-500; 784800,-500;
        788400,-500; 792000,-500; 795600,-500; 799200,-500; 802800,-142; 806400,
        -172; 810000,-201; 813600,-228; 817200,-254; 820800,-278; 824400,-302;
        828000,-324; 831600,-345; 835200,-366; 838800,-385; 842400,-404; 846000,
        -500; 849600,-500; 853200,-500; 856800,-500; 860400,-500; 864000,-500;
        5101200,-500; 5104800,-500; 5108400,-500; 5112000,-500; 5115600,-500;
        5119200,-500; 5122800,-149; 5126400,-179; 5130000,-207; 5133600,-234;
        5137200,-259; 5140800,-284; 5144400,-307; 5148000,-329; 5151600,-350;
        5155200,-371; 5158800,-390; 5162400,-408; 5166000,-500; 5169600,-500;
        5173200,-500; 5176800,-500; 5180400,-500; 5184000,-500])
    "Reference results"
    annotation (Placement(transformation(extent={{-52,20},{-32,40}})));
  BaseClasses.VerifyDifferenceThreePeriods assEqu(
    startTime=3600,
    endTime=86400,
    startTime2=781200,
    endTime2=864000,
    startTime3=5101200,
    endTime3=5184000,
    threShold=1.5)
    "Checks validation criteria"
    annotation (Placement(transformation(extent={{-44,-6},{-34,4}})));
  Modelica.Blocks.Math.Mean mean(f=1/3600)
    "Hourly mean of indoor air temperature"
    annotation (Placement(transformation(extent={{-66,-6},{-56,4}})));
  Modelica.Blocks.Math.Gain gainMea(k=-1)
    "Gain for mean block"
    annotation (Placement(transformation(extent={{-84,-6},{-74,4}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    "Sensor for ideal heater/cooler"
    annotation (Placement(transformation(extent={{106,62},{94,74}})));
equation
  connect(theConWall.fluid, preTem.port)
    annotation (Line(points={{26,1},{24,1},{24,0},{20,0}}, color={191,0,0}));
  connect(thermalZoneTwoElements.extWall, theConWall.solid)
    annotation (Line(points={{44,12},{40,12},{40,1},{36,1}}, color={191,0,0}));
  connect(hConWall.y, theConWall.Gc)
    annotation (Line(points={{30,-7.6},{31,-7.6},{31,-4}},   color={0,0,127}));
  connect(intGai.y[1], machinesRad.Q_flow)
    annotation (Line(points={{22.8,-86},{22.8,-88},{48,-88}},
                                    color={0,0,127}));
  connect(machinesRad.port, thermalZoneTwoElements.intGainsRad)
    annotation (
    Line(points={{68,-88},{110,-88},{110,24},{92,24}},
    color={191,0,0}));
  connect(const.y, thermalZoneTwoElements.solRad[1])
    annotation (Line(points={{30.5,31},{36.25,31},{43,31}}, color={0,0,127}));
  connect(tabsExt_fixedHeatFlow.port, thermalZoneTwoElements.tabsExtWalls)
    annotation (Line(points={{-30,-24},{86.8,-24},{86.8,-2}},
                                                          color={191,0,0}));
  connect(HKradExt_fixedHeatFlow.port, thermalZoneTwoElements.HKradExtWalls)
    annotation (Line(points={{-30,-40},{92,-40},{92,-2}}, color={191,0,0}));
  connect(FHKExt_fixedHeatFlow.port, thermalZoneTwoElements.FHKExtWalls)
    annotation (Line(points={{-56,-32},{94,-32},{94,0.6},{92,0.6}}, color={191,
          0,0}));
  connect(HKConv_fixedHeatFlow.port, thermalZoneTwoElements.HKConv) annotation (
     Line(points={{-56,-48},{96,-48},{96,3},{92,3}}, color={191,0,0}));
  connect(FHKInt_fixedHeatFlow.port, thermalZoneTwoElements.FHKIntWalls)
    annotation (Line(points={{-56,-64},{98,-64},{98,5.4},{92,5.4}}, color={191,
          0,0}));
  connect(HKradInt_fixedHeatFlow.port, thermalZoneTwoElements.HKradIntWalls)
    annotation (Line(points={{-30,-56},{100,-56},{100,7.8},{92,7.8}}, color={
          191,0,0}));
  connect(tabsInt_fixedHeatFlow.port, thermalZoneTwoElements.tabsIntWalls)
    annotation (Line(points={{-30,-72},{102,-72},{102,14},{92,14}}, color={191,
          0,0}));
  connect(gainHeaCoo.y,heaCoo. Q_flow) annotation (Line(points={{36.6,68},{60,
          68}},                    color={0,0,127}));
  connect(conHeaCoo.y,gainHeaCoo. u)
    annotation (Line(points={{14.8,68},{22.8,68}},  color={0,0,127}));
  connect(setTemp.y[1],from_degC. u) annotation (Line(points={{-35.2,68},{-23.2,
          68}},                    color={0,0,127}));
  connect(from_degC.y,conHeaCoo. u_s)
    annotation (Line(points={{-9.4,68},{-3.6,68}},     color={0,0,127}));
  connect(mean.y,assEqu. u2) annotation (Line(points={{-55.5,-1},{-50,-1},{-50,
          -4},{-45,-4}},
                    color={0,0,127}));
  connect(reference.y[1],assEqu. u1) annotation (Line(points={{-31,30},{-28,30},
          {-28,10},{-50,10},{-50,2},{-45,2}},color={0,0,127}));
  connect(mean.u,gainMea. y)
    annotation (Line(points={{-67,-1},{-73.5,-1}},
                                                 color={0,0,127}));
  connect(heaCoo.port, heatFlowSensor.port_b)
    annotation (Line(points={{80,68},{94,68}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, gainMea.u) annotation (Line(points={{100,62},{
          84,62},{84,50},{-92,50},{-92,-1},{-85,-1}}, color={0,0,127}));
  connect(heatFlowSensor.port_a, thermalZoneTwoElements.intGainsConv)
    annotation (Line(points={{106,68},{106,20},{92,20}}, color={191,0,0}));
  connect(conHeaCoo.u_m, thermalZoneTwoElements.TAir) annotation (Line(points={
          {6,58.4},{98,58.4},{98,32},{93,32}}, color={0,0,127}));
  annotation ( Documentation(info="<html>
  <p>Test Case 7 of the VDI 6007 Part 1: Calculation of heat load excited with a
  given radiative heat source and a setpoint profile for room version S. Is
  similar with Test Case 6, but with a maximum heating/cooling power.</p>
  <h4>Boundary conditions</h4>
  <ul>
  <li>constant outdoor air temperature 22&deg;C</li>
  <li>no solar or short-wave radiation on the exterior wall</li>
  <li>no solar or short-wave radiation through the windows</li>
  <li>no long-wave radiation exchange between exterior wall, windows
  and ambient environment</li>
  </ul>
  <p>This test validates heat load calculation with
  maximum heating power.</p>
  </html>", revisions="<html>
  <ul>
  <li>
  July 11, 2019, by Katharina Brinkmann:<br/>
  Renamed <code>alphaWall</code> to <code>hConWall</code>
  </li>
  <li>
  January 25, 2019, by Michael Wetter:<br/>
  Added start value to avoid warning in JModelica.
  </li>
  <li>
  July 7, 2016, by Moritz Lauster:<br/>
  Added automatic check against validation thresholds.
  </li>
  <li>
  January 11, 2016, by Moritz Lauster:<br/>
  Implemented.
  </li>
  </ul>
  </html>"),experiment(
      StopTime=2529000,
      Interval=900,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
  __Dymola_Commands(file=
  "modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Validation/VDI6007/TestCase7.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(extent={{-100,-100},{120,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
end TestCase7_mod;
