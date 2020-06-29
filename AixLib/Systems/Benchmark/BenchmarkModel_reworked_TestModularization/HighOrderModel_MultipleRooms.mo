within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrderModel_MultipleRooms  "Multiple instances of high order room with input paramaters"
  extends Modelica.Icons.Example;
   ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows southFacingWindows[5](
    Room_Length={30,30,5,5,30},
    Room_Height={3,3,3,3,3},
    Room_Width={30,20,10,20,50},
    Win_Area={180,80,20,40,200},
    each solar_absorptance_OW=0.48,
    each eps_out=25,
    each TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    each TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    each TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    each Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    each use_sunblind=false,
    each ratioSunblind=0,
    each solIrrThreshold=1000,
    each TOutAirLimit=1273.15)
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Blocks.Sources.Constant constantWindSpeed [5](each k=2.2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-48,-34})));
  Modelica.Blocks.Sources.Constant constantAirExchangeRate [5](each k=0.15) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,-34})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowInternal [5]
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,18})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowToOutside[5](Q_flow={-12285,-7634,-1292,-2584,-18161})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,44})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughFloorPlate[5](Q_flow={-4576,-3867,-480,-897,-7557})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,-12})));
  Modelica.Blocks.Sources.Sine InternalGains [5](
    amplitude={7200,21000,1900,700,10000},
    each freqHz=1/3600,
    offset={7200,21000,1900,700,10000}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={64,16})));
  Utilities.Sources.PrescribedSolarRad prescribedSolarRad [5](each n=5)
    annotation (Placement(transformation(extent={{-54,22},{-34,42}})));
  Modelica.Blocks.Sources.Constant const [25]( each k=2.2)
    annotation (Placement(transformation(extent={{-94,72},{-74,92}})));
  Modelica.Blocks.Sources.Constant const1[25]( each k=2.2)
    annotation (Placement(transformation(extent={{-94,38},{-74,58}})));
  Modelica.Blocks.Sources.Constant const2[25]( each k=2.2)
    annotation (Placement(transformation(extent={{-94,6},{-74,26}})));
  Modelica.Blocks.Sources.Constant const3[25]( each k=2.2)
    annotation (Placement(transformation(extent={{-94,-26},{-74,-6}})));
  Modelica.Blocks.Sources.Constant const4 [25]( each k=2.2)
    annotation (Placement(transformation(extent={{-94,-60},{-74,-40}})));
equation
  connect(constantWindSpeed.y, southFacingWindows.WindSpeedPort)
    annotation (Line(points={{-48,-23},{-48,1},{-11,1}}, color={0,0,127}));
  connect(constantAirExchangeRate.y, southFacingWindows.AER)
    annotation (Line(points={{-16,-23},{-16,-7},{-11,-7}}, color={0,0,127}));
  connect(fixedHeatFlowThroughFloorPlate.port, southFacingWindows.Therm_ground)
    annotation (Line(points={{20,-12},{20,-11.6},{-3.2,-11.6}}, color={191,0,0}));
  connect(fixedHeatFlowToOutside.port, southFacingWindows.Therm_outside)
    annotation (Line(points={{20,44},{-10.5,44},{-10.5,7.7}}, color={191,0,0}));
  connect(prescribedHeatFlowInternal.port, southFacingWindows.thermRoom)
    annotation (Line(points={{20,18},{-4,18},{-4,0.3},{-2.9,0.3}}, color={191,0,
          0}));
  connect(InternalGains.y, prescribedHeatFlowInternal.Q_flow) annotation (Line(
        points={{53,16},{48,16},{48,18},{40,18}}, color={0,0,127}));
  connect(prescribedSolarRad.solarRad_out, southFacingWindows.SolarRadiationPort)
    annotation (Line(points={{-35,32},{-26,32},{-26,4},{-11,4}}, color={255,128,
          0}));

  connect(const[1].y, prescribedSolarRad[1].I[1])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.02},{-52.9,40.02}}, color={0,0,127}));

  connect(const[2].y, prescribedSolarRad[1].I[2])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.46},{-52.9,40.46}},color={0,0,127}));

  connect(const[3].y, prescribedSolarRad[1].I[3])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.9},{-52.9,40.9}},  color={0,0,127}));

  connect(const[4].y, prescribedSolarRad[1].I[4])
   annotation (Line(points={{-73,82},{-66,82},{-66,41.34},{-52.9,41.34}}, color={0,0,127}));

  connect(const[5].y, prescribedSolarRad[1].I[5])
  annotation (Line(points={{-73,82},{-66,82},{-66,41.78},{-52.9,41.78}}, color={0,0,127}));

  connect(const[6].y, prescribedSolarRad[2].I[1])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.02},{-52.9,40.02}}, color={0,0,127}));

  connect(const[7].y, prescribedSolarRad[2].I[2])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.46},{-52.9,40.46}},color={0,0,127}));

  connect(const[8].y, prescribedSolarRad[2].I[3])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.9},{-52.9,40.9}}, color={0,0,127}));

  connect(const[9].y, prescribedSolarRad[2].I[4])
  annotation (Line(points={{-73,82},{-66,82},{-66,41.34},{-52.9,41.34}}, color={0,0,127}));

  connect(const[10].y, prescribedSolarRad[2].I[5])
  annotation (Line(points={{-73,82},{-66,82},{-66,41.78},{-52.9,41.78}}, color={0,0,127}));

  connect(const[11].y, prescribedSolarRad[3].I[1])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.02},{-52.9,40.02}}, color={0,0,127}));

  connect(const[12].y, prescribedSolarRad[3].I[2])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.46},{-52.9,40.46}},color={0,0,127}));

  connect(const[13].y, prescribedSolarRad[3].I[3])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.9},{-52.9,40.9}}, color={0,0,127}));

  connect(const[14].y, prescribedSolarRad[3].I[4])
  annotation (Line(points={{-73,82},{-66,82},{-66,41.34},{-52.9,41.34}}, color={0,0,127}));

  connect(const[15].y, prescribedSolarRad[3].I[5])
  annotation (Line(points={{-73,82},{-66,82},{-66,41.78},{-52.9,41.78}}, color={0,0,127}));

  connect(const[16].y, prescribedSolarRad[4].I[1])
   annotation (Line(points={{-73,82},{-66,82},{-66,40.02},{-52.9,40.02}}, color={0,0,127}));

  connect(const[17].y, prescribedSolarRad[4].I[2])
   annotation (Line(points={{-73,82},{-66,82},{-66,40.46},{-52.9,40.46}},color={0,0,127}));

  connect(const[18].y, prescribedSolarRad[4].I[3])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.9},{-52.9,40.9}}, color={0,0,127}));

  connect(const[19].y, prescribedSolarRad[4].I[4])
  annotation (Line(points={{-73,82},{-66,82},{-66,41.34},{-52.9,41.34}}, color={0,0,127}));

  connect(const[20].y, prescribedSolarRad[4].I[5])
  annotation (Line(points={{-73,82},{-66,82},{-66,41.78},{-52.9,41.78}}, color={0,0,127}));

   connect(const[21].y, prescribedSolarRad[5].I[1])
   annotation (Line(points={{-73,82},{-66,82},{-66,40.02},{-52.9,40.02}}, color={0,0,127}));

  connect(const[22].y, prescribedSolarRad[5].I[2])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.46},{-52.9,40.46}},color={0,0,127}));

  connect(const[23].y, prescribedSolarRad[5].I[3])
  annotation (Line(points={{-73,82},{-66,82},{-66,40.9},{-52.9,40.9}}, color={0,0,127}));

  connect(const[24].y, prescribedSolarRad[5].I[4])
  annotation (Line(points={{-73,82},{-66,82},{-66,41.34},{-52.9,41.34}}, color={0,0,127}));

  connect(const[25].y, prescribedSolarRad[5].I[5])
  annotation (Line(points={{-73,82},{-66,82},{-66,41.78},{-52.9,41.78}}, color={0,0,127}));



  connect(const1[1].y, prescribedSolarRad[1].I_dir[1])
  annotation (Line(points={{-73,48},{-70,48},{-70,36.2},{-53,36.2}},     color={0,0,127}));

  connect(const1[2].y, prescribedSolarRad[1].I_dir[2])
  annotation (Line(points={{-73,48},{-70,48},{-70,36.6},{-53,36.6}},    color={0,0,127}));

  connect(const1[3].y, prescribedSolarRad[1].I_dir[3])
  annotation (Line(points={{-73,48},{-70,48},{-70,37},{-53,37}},        color={0,0,127}));

  connect(const1[4].y, prescribedSolarRad[1].I_dir[4])
   annotation (Line(points={{-73,48},{-70,48},{-70,37.4},{-53,37.4}},     color={0,0,127}));

  connect(const1[5].y, prescribedSolarRad[1].I_dir[5])
  annotation (Line(points={{-73,48},{-70,48},{-70,37.8},{-53,37.8}},     color={0,0,127}));

  connect(const1[6].y, prescribedSolarRad[2].I_dir[1])
  annotation (Line(points={{-73,48},{-70,48},{-70,36.2},{-53,36.2}},     color={0,0,127}));

  connect(const1[7].y, prescribedSolarRad[2].I_dir[2])
  annotation (Line(points={{-73,48},{-70,48},{-70,36.6},{-53,36.6}},    color={0,0,127}));

  connect(const1[8].y, prescribedSolarRad[2].I_dir[3])
  annotation (Line(points={{-73,48},{-70,48},{-70,37},{-53,37}},       color={0,0,127}));

  connect(const1[9].y, prescribedSolarRad[2].I_dir[4])
  annotation (Line(points={{-73,48},{-70,48},{-70,37.4},{-53,37.4}},     color={0,0,127}));

  connect(const1[10].y, prescribedSolarRad[2].I_dir[5])
  annotation (Line(points={{-73,48},{-70,48},{-70,37.8},{-53,37.8}},     color={0,0,127}));

  connect(const1[11].y, prescribedSolarRad[3].I_dir[1])
  annotation (Line(points={{-73,48},{-70,48},{-70,36.2},{-53,36.2}},     color={0,0,127}));

  connect(const1[12].y, prescribedSolarRad[3].I_dir[2])
  annotation (Line(points={{-73,48},{-70,48},{-70,36.6},{-53,36.6}},    color={0,0,127}));

  connect(const1[13].y, prescribedSolarRad[3].I_dir[3])
  annotation (Line(points={{-73,48},{-70,48},{-70,37},{-53,37}},       color={0,0,127}));

  connect(const1[14].y, prescribedSolarRad[3].I_dir[4])
  annotation (Line(points={{-73,48},{-70,48},{-70,37.4},{-53,37.4}},     color={0,0,127}));

  connect(const1[15].y, prescribedSolarRad[3].I_dir[5])
  annotation (Line(points={{-73,48},{-70,48},{-70,37.8},{-53,37.8}},     color={0,0,127}));

  connect(const1[16].y, prescribedSolarRad[4].I_dir[1])
   annotation (Line(points={{-73,48},{-70,48},{-70,36.2},{-53,36.2}},     color={0,0,127}));

  connect(const1[17].y, prescribedSolarRad[4].I_dir[2])
   annotation (Line(points={{-73,48},{-70,48},{-70,36.6},{-53,36.6}},    color={0,0,127}));

  connect(const1[18].y, prescribedSolarRad[4].I_dir[3])
  annotation (Line(points={{-73,48},{-70,48},{-70,37},{-53,37}},       color={0,0,127}));

  connect(const1[19].y, prescribedSolarRad[4].I_dir[4])
  annotation (Line(points={{-73,48},{-70,48},{-70,37.4},{-53,37.4}},     color={0,0,127}));

  connect(const1[20].y, prescribedSolarRad[4].I_dir[5])
  annotation (Line(points={{-73,48},{-70,48},{-70,37.8},{-53,37.8}},     color={0,0,127}));

   connect(const1[21].y, prescribedSolarRad[5].I_dir[1])
   annotation (Line(points={{-73,48},{-70,48},{-70,36.2},{-53,36.2}},     color={0,0,127}));

  connect(const1[22].y, prescribedSolarRad[5].I_dir[2])
  annotation (Line(points={{-73,48},{-70,48},{-70,36.6},{-53,36.6}},    color={0,0,127}));

  connect(const1[23].y, prescribedSolarRad[5].I_dir[3])
  annotation (Line(points={{-73,48},{-70,48},{-70,37},{-53,37}},       color={0,0,127}));

  connect(const1[24].y, prescribedSolarRad[5].I_dir[4])
  annotation (Line(points={{-73,48},{-70,48},{-70,37.4},{-53,37.4}},     color={0,0,127}));

  connect(const2[25].y, prescribedSolarRad[5].I_dir[5])
   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));



connect(const2[1].y, prescribedSolarRad[1].I_diff[1])
  annotation (Line(points={{-73,16},{-70,16},{-70,32.2},{-53,32.2}},     color={0,0,127}));

  connect(const2[2].y, prescribedSolarRad[1].I_diff[2])
  annotation (Line(points={{-73,16},{-70,16},{-70,32.6},{-53,32.6}},    color={0,0,127}));

  connect(const2[3].y, prescribedSolarRad[1].I_diff[3])
  annotation (Line(points={{-73,16},{-70,16},{-70,33},{-53,33}},        color={0,0,127}));

  connect(const2[4].y, prescribedSolarRad[1].I_diff[4])
   annotation (Line(points={{-73,16},{-70,16},{-70,33.4},{-53,33.4}},     color={0,0,127}));

  connect(const2[5].y, prescribedSolarRad[1].I_diff[5])
  annotation (Line(points={{-73,16},{-70,16},{-70,33.8},{-53,33.8}},     color={0,0,127}));

  connect(const2[6].y, prescribedSolarRad[2].I_diff[1])
  annotation (Line(points={{-73,16},{-70,16},{-70,32.2},{-53,32.2}},     color={0,0,127}));

  connect(const2[7].y, prescribedSolarRad[2].I_diff[2])
  annotation (Line(points={{-73,16},{-70,16},{-70,32.6},{-53,32.6}},    color={0,0,127}));

  connect(const2[8].y, prescribedSolarRad[2].I_diff[3])
  annotation (Line(points={{-73,16},{-70,16},{-70,33},{-53,33}},       color={0,0,127}));

  connect(const2[9].y, prescribedSolarRad[2].I_diff[4])
  annotation (Line(points={{-73,16},{-70,16},{-70,33.4},{-53,33.4}},     color={0,0,127}));

  connect(const2[10].y, prescribedSolarRad[2].I_diff[5])
  annotation (Line(points={{-73,16},{-70,16},{-70,33.8},{-53,33.8}},     color={0,0,127}));

  connect(const2[11].y, prescribedSolarRad[3].I_diff[1])
  annotation (Line(points={{-73,16},{-70,16},{-70,32},{-58,32},{-58,32.2},{-53,
          32.2}},                                                        color={0,0,127}));

  connect(const2[12].y, prescribedSolarRad[3].I_diff[2])
  annotation (Line(points={{-73,16},{-70,16},{-70,32.6},{-53,32.6}},    color={0,0,127}));

  connect(const2[13].y, prescribedSolarRad[3].I_diff[3])
  annotation (Line(points={{-73,16},{-70,16},{-70,33},{-53,33}},       color={0,0,127}));

  connect(const2[14].y, prescribedSolarRad[3].I_diff[4])
  annotation (Line(points={{-73,16},{-70,16},{-70,33.4},{-53,33.4}},     color={0,0,127}));

  connect(const2[15].y, prescribedSolarRad[3].I_diff[5])
  annotation (Line(points={{-73,16},{-70,16},{-70,33.8},{-53,33.8}},     color={0,0,127}));

  connect(const2[16].y, prescribedSolarRad[4].I_diff[1])
   annotation (Line(points={{-73,16},{-70,16},{-70,32},{-60,32},{-60,32.2},{-53,
          32.2}},                                                         color={0,0,127}));

  connect(const2[17].y, prescribedSolarRad[4].I_diff[2])
   annotation (Line(points={{-73,16},{-70,16},{-70,32.6},{-53,32.6}},    color={0,0,127}));

  connect(const2[18].y, prescribedSolarRad[4].I_diff[3])
  annotation (Line(points={{-73,16},{-70,16},{-70,33},{-53,33}},       color={0,0,127}));

  connect(const2[19].y, prescribedSolarRad[4].I_diff[4])
  annotation (Line(points={{-73,16},{-70,16},{-70,33.4},{-53,33.4}},     color={0,0,127}));

  connect(const2[20].y, prescribedSolarRad[4].I_diff[5])
  annotation (Line(points={{-73,16},{-70,16},{-70,33.8},{-53,33.8}},     color={0,0,127}));

   connect(const2[21].y, prescribedSolarRad[5].I_diff[1])
   annotation (Line(points={{-73,16},{-70,16},{-70,32.2},{-53,32.2}},     color={0,0,127}));

  connect(const2[22].y, prescribedSolarRad[5].I_diff[2])
  annotation (Line(points={{-73,16},{-70,16},{-70,32.6},{-53,32.6}},    color={0,0,127}));

  connect(const2[23].y, prescribedSolarRad[5].I_diff[3])
  annotation (Line(points={{-73,16},{-70,16},{-70,34},{-62,34},{-62,33},{-53,33}},
                                                                       color={0,0,127}));

  connect(const2[24].y, prescribedSolarRad[5].I_diff[4])
  annotation (Line(points={{-73,16},{-70,16},{-70,33.4},{-53,33.4}},     color={0,0,127}));

  connect(const2[25].y, prescribedSolarRad[5].I_diff[5])
   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));



connect(const3[1].y, prescribedSolarRad[1].I_gr[1])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.02},{-52.9,28.02}},
                                                                         color={0,0,127}));

  connect(const3[2].y, prescribedSolarRad[1].I_gr[2])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.46},{-52.9,28.46}},
                                                                        color={0,0,127}));

  connect(const3[3].y, prescribedSolarRad[1].I_gr[3])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.9},{-52.9,28.9}},color={0,0,127}));

  connect(const3[4].y, prescribedSolarRad[1].I_gr[4])
   annotation (Line(points={{-73,-16},{-66,-16},{-66,29.34},{-52.9,29.34}},
                                                                          color={0,0,127}));

  connect(const3[5].y, prescribedSolarRad[1].I_gr[5])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,29.78},{-52.9,29.78}},
                                                                         color={0,0,127}));

  connect(const3[6].y, prescribedSolarRad[2].I_gr[1])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.02},{-52.9,28.02}},
                                                                         color={0,0,127}));

  connect(const3[7].y, prescribedSolarRad[2].I_gr[2])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.46},{-52.9,28.46}},
                                                                        color={0,0,127}));

  connect(const3[8].y, prescribedSolarRad[2].I_gr[3])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.9},{-52.9,28.9}},
                                                                       color={0,0,127}));

  connect(const3[9].y, prescribedSolarRad[2].I_gr[4])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,29.34},{-52.9,29.34}},
                                                                         color={0,0,127}));

  connect(const3[10].y, prescribedSolarRad[2].I_gr[5])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,29.78},{-52.9,29.78}},
                                                                         color={0,0,127}));

  connect(const3[11].y, prescribedSolarRad[3].I_gr[1])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.02},{-52.9,28.02}},
                                                                         color={0,0,127}));

  connect(const3[12].y, prescribedSolarRad[3].I_gr[2])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.46},{-52.9,28.46}},
                                                                        color={0,0,127}));

  connect(const3[13].y, prescribedSolarRad[3].I_gr[3])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.9},{-52.9,28.9}},
                                                                       color={0,0,127}));

  connect(const3[14].y, prescribedSolarRad[3].I_gr[4])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,29.34},{-52.9,29.34}},
                                                                         color={0,0,127}));

  connect(const3[15].y, prescribedSolarRad[3].I_gr[5])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,29.78},{-52.9,29.78}},
                                                                         color={0,0,127}));

  connect(const3[16].y, prescribedSolarRad[4].I_gr[1])
   annotation (Line(points={{-73,-16},{-66,-16},{-66,28.02},{-52.9,28.02}},
                                                                          color={0,0,127}));

  connect(const3[17].y, prescribedSolarRad[4].I_gr[2])
   annotation (Line(points={{-73,-16},{-66,-16},{-66,28.46},{-52.9,28.46}},
                                                                         color={0,0,127}));

  connect(const3[18].y, prescribedSolarRad[4].I_gr[3])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.9},{-52.9,28.9}},
                                                                       color={0,0,127}));

  connect(const3[19].y, prescribedSolarRad[4].I_gr[4])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,29.34},{-52.9,29.34}},
                                                                         color={0,0,127}));

  connect(const3[20].y, prescribedSolarRad[4].I_gr[5])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,29.78},{-52.9,29.78}},
                                                                         color={0,0,127}));

   connect(const3[21].y, prescribedSolarRad[5].I_gr[1])
   annotation (Line(points={{-73,-16},{-66,-16},{-66,28.02},{-52.9,28.02}},
                                                                          color={0,0,127}));

  connect(const3[22].y, prescribedSolarRad[5].I_gr[2])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.46},{-52.9,28.46}},
                                                                        color={0,0,127}));

  connect(const3[23].y, prescribedSolarRad[5].I_gr[3])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,28.9},{-52.9,28.9}},
                                                                       color={0,0,127}));

  connect(const3[24].y, prescribedSolarRad[5].I_gr[4])
  annotation (Line(points={{-73,-16},{-66,-16},{-66,30},{-56,30},{-56,29.34},{
          -52.9,29.34}},                                                 color={0,0,127}));

  connect(const3[25].y, prescribedSolarRad[5].I_gr[5])
   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));



connect(const4[1].y, prescribedSolarRad[1].AOI[1])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,24.2},{-53,24.2}},   color={0,0,127}));

  connect(const4[2].y, prescribedSolarRad[1].AOI[2])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,24.6},{-53,24.6}},  color={0,0,127}));

  connect(const4[3].y, prescribedSolarRad[1].AOI[3])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25},{-53,25}},      color={0,0,127}));

  connect(const4[4].y, prescribedSolarRad[1].AOI[4])
   annotation (Line(points={{-73,-50},{-64,-50},{-64,25.4},{-53,25.4}},   color={0,0,127}));

  connect(const4[5].y, prescribedSolarRad[1].AOI[5])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25.8},{-53,25.8}},   color={0,0,127}));

  connect(const4[6].y, prescribedSolarRad[2].AOI[1])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,24.2},{-53,24.2}},   color={0,0,127}));

  connect(const4[7].y, prescribedSolarRad[2].AOI[2])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,24.6},{-53,24.6}},  color={0,0,127}));

  connect(const4[8].y, prescribedSolarRad[2].AOI[3])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25},{-53,25}},     color={0,0,127}));

  connect(const4[9].y, prescribedSolarRad[2].AOI[4])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25.4},{-53,25.4}},   color={0,0,127}));

  connect(const4[10].y, prescribedSolarRad[2].AOI[5])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25.8},{-53,25.8}},   color={0,0,127}));

  connect(const4[11].y, prescribedSolarRad[3].AOI[1])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,24.2},{-53,24.2}},   color={0,0,127}));

  connect(const4[12].y, prescribedSolarRad[3].AOI[2])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,24.6},{-53,24.6}},  color={0,0,127}));

  connect(const4[13].y, prescribedSolarRad[3].AOI[3])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25},{-53,25}},     color={0,0,127}));

  connect(const4[14].y, prescribedSolarRad[3].AOI[4])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25.4},{-53,25.4}},   color={0,0,127}));

  connect(const4[15].y, prescribedSolarRad[3].AOI[5])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25.8},{-53,25.8}},   color={0,0,127}));

  connect(const4[16].y, prescribedSolarRad[4].AOI[1])
   annotation (Line(points={{-73,-50},{-64,-50},{-64,24.2},{-53,24.2}},   color={0,0,127}));

  connect(const4[17].y, prescribedSolarRad[4].AOI[2])
   annotation (Line(points={{-73,-50},{-64,-50},{-64,24.6},{-53,24.6}},  color={0,0,127}));

  connect(const4[18].y, prescribedSolarRad[4].AOI[3])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25},{-53,25}},     color={0,0,127}));

  connect(const4[19].y, prescribedSolarRad[4].AOI[4])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25.4},{-53,25.4}},   color={0,0,127}));

  connect(const4[20].y, prescribedSolarRad[4].AOI[5])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25.8},{-53,25.8}},   color={0,0,127}));

   connect(const4[21].y, prescribedSolarRad[5].AOI[1])
   annotation (Line(points={{-73,-50},{-64,-50},{-64,24.2},{-53,24.2}},   color={0,0,127}));

  connect(const4[22].y, prescribedSolarRad[5].AOI[2])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,24.6},{-53,24.6}},  color={0,0,127}));

  connect(const4[23].y, prescribedSolarRad[5].AOI[3])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25},{-53,25}},     color={0,0,127}));

  connect(const4[24].y, prescribedSolarRad[5].AOI[4])
  annotation (Line(points={{-73,-50},{-64,-50},{-64,25.4},{-53,25.4}},   color={0,0,127}));

  connect(const4[25].y, prescribedSolarRad[5].AOI[5])
   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));



end HighOrderModel_MultipleRooms;
