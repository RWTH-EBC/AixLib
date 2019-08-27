within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model ReducedOrderModel_MultipleRooms  "Multiple instances of reduced order room with input paramaters"
  extends Modelica.Icons.Example;


  AixLib.ThermalZones.ReducedOrder.RC.FourElements reducedOrderModel [5]( redeclare
      package                                                                                         Medium =
        AixLib.Media.Air,
    each hRad=5,
    each hConvWin=1.3,
    each gWin=1,
    each ratioWinConRad=0.09,
    each hConvExt=2.5,
    each nExt=4,
    each RExtRem=0,
    each hConvInt=2.5,
    each nInt=2,
    each hConvFloor=2.5,
    each nFloor=4,
    each RFloorRem=0,
    each hConvRoof=2.5,
    each RRoofRem=0,
    each nRoof=4,
    RExt={{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294},{0.05,2.857,0.48,0.0294}},
    CExt={{1000,1030,1000,1000},{1000,1030,1000,1000},{1000,1030,1000,1000},{1000,1030,1000,1000},{1000,1030,1000,1000}},
    CInt={{1000,1000},{1000,1000},{1000,1000},{1000,1000},{1000,1000}},
    RFloor={{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429},{1.5,0.1087,1.1429,0.0429}},
    CFloor={{8400,575000,4944,120000},{8400,575000,4944,120000},{8400,575000,4944,120000},{8400,575000,4944,120000},{8400,575000,4944,120000}},
    CRoof={{2472,368000,18000,1},{2472,368000,18000,1},{2472,368000,18000,1},{2472,368000,18000,1},{2472,368000,18000,1}},
    each indoorPortWin=false,
    each indoorPortExtWalls=false,
    each indoorPortIntWalls=false,
    each indoorPortFloor=false,
    each indoorPortRoof=false,
    VAir={2700,1800,150,300,4050},
    AInt={90,180,60,90,90},
    AFloor={900,600,50,100,1350},
    ARoof={900,600,50,100,1350},
    RRoof={{0.4444,0.06957,0.02941,0.0001},{0.4444,0.06957,0.02941,0.0001},{0.4444,
        0.06957,0.02941,0.0001},{0.4444,0.06957,0.02941,0.0001},{0.4444,0.06957,
        0.02941,0.0001}},
    RInt={{0.175,0.0294},{0.175,0.0294},{0.175,0.0294},{0.175,0.029},{0.175,0.0294}},
    nOrientations={4,4,4,4,4},
    AWin={{60,0,60,60},{40,0,40,0},{20,0,0,0},{0,0,40,0},{80,60,60,0}},
    ATransparent={{48,0,48,48},{32,0,32,0},{16,0,0,0},{0,32,0,0},{64,48,48,0}},
    AExt={{30,0,30,30},{20,0,20,0},{10,0,0,0},{0,0,20,0},{40,30,30,0}},
    RWin={0.01923,0.0128,0.03846,0.01923,0.01282})
    annotation (Placement(transformation(extent={{-24,-18},{24,18}})));

  Modelica.Blocks.Sources.Constant constsantSolarRadiationThroughWindow2 [20](each k=
        2.2)
    annotation (Placement(transformation(extent={{-54,26},{-34,46}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughRoof[5](Q_flow=
       {-4735,-3700,-308,-617,-8326}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,64})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughFloorPlate[5](Q_flow={-4576,-3867,
        480,-897,-7557}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-38})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatThroughWindow[5](Q_flow={-6786,-3536,
        -884,-1768,-8840})
    annotation (Placement(transformation(extent={{-56,-6},{-36,14}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughExteriorWalls[5](Q_flow={-764,-398,
        -100,-199,-995})
    annotation (Placement(transformation(extent={{-56,-30},{-36,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowInternalConvectiveGains [5]
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={48,-10})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowInternalRadiativeGains [5]
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={48,8})));
  Modelica.Blocks.Sources.Sine InternalRadiativeGains[5](
    each freqHz=1/3600,
    amplitude={360,1050,95,36,510},
    offset={360,1050,95,36,510})       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,8})));
  Modelica.Blocks.Sources.Sine InternalConvectiveGains[5](
    each freqHz=1/3600,
    amplitude={360,1050,90,36,510},
    offset={360,1050,90,360,510})      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-24})));
equation
  connect(fixedHeatFlowThroughRoof.port, reducedOrderModel.roof) annotation (
      Line(points={{-1.77636e-15,54},{0,54},{0,18},{-1.1,18}}, color={191,0,0}));
  connect(fixedHeatFlowThroughFloorPlate.port, reducedOrderModel.floor) annotation (
      Line(points={{4.44089e-16,-28},{0,-28},{0,-18}}, color={191,0,0}));
  connect(fixedHeatThroughWindow.port, reducedOrderModel.window)
    annotation (Line(points={{-36,4},{-24,4}}, color={191,0,0}));
  connect(fixedHeatFlowThroughExteriorWalls.port, reducedOrderModel.extWall)
    annotation (Line(points={{-36,-20},{-24,-20},{-24,-4}}, color={191,0,0}));
  connect(prescribedHeatFlowInternalRadiativeGains.port, reducedOrderModel.intGainsRad)
    annotation (Line(points={{38,8},{24,8}}, color={191,0,0}));
  connect(prescribedHeatFlowInternalConvectiveGains.port, reducedOrderModel.intGainsConv)
    annotation (Line(points={{38,-10},{32,-10},{32,4},{24,4}}, color={191,0,0}));
  connect(InternalRadiativeGains.y, prescribedHeatFlowInternalRadiativeGains.Q_flow)
    annotation (Line(points={{77,8},{58,8}}, color={0,0,127}));
  connect(InternalConvectiveGains.y, prescribedHeatFlowInternalConvectiveGains.Q_flow)
    annotation (Line(points={{79,-24},{70,-24},{70,-10},{58,-10}}, color={0,0,127}));
  connect(constsantSolarRadiationThroughWindow2[1].y, reducedOrderModel[1].solRad[
    1]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[2].y, reducedOrderModel[1].solRad[
    2]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[3].y, reducedOrderModel[1].solRad[
    3]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[4].y, reducedOrderModel[2].solRad[
    1]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[5].y, reducedOrderModel[2].solRad[
    2]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[6].y, reducedOrderModel[2].solRad[
    3]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[7].y, reducedOrderModel[3].solRad[
    1]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));

           connect(constsantSolarRadiationThroughWindow2[8].y, reducedOrderModel[3].solRad[
    2]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));

           connect(constsantSolarRadiationThroughWindow2[9].y, reducedOrderModel[3].solRad[
    3]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));

  connect(constsantSolarRadiationThroughWindow2[10].y, reducedOrderModel[4].solRad[
    1]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[11].y, reducedOrderModel[4].solRad[
    2]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[12].y, reducedOrderModel[4].solRad[
    3]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[13].y, reducedOrderModel[5].solRad[
    1]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[14].y, reducedOrderModel[5].solRad[
    2]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  connect(constsantSolarRadiationThroughWindow2[15].y, reducedOrderModel[5].solRad[
    3]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
     connect(constsantSolarRadiationThroughWindow2[16].y, reducedOrderModel[1].solRad[
    4]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
     connect(constsantSolarRadiationThroughWindow2[17].y, reducedOrderModel[2].solRad[
    4]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));

       connect(constsantSolarRadiationThroughWindow2[18].y, reducedOrderModel[3].solRad[
    4]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
           connect(constsantSolarRadiationThroughWindow2[19].y, reducedOrderModel[4].solRad[
    4]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
           connect(constsantSolarRadiationThroughWindow2[20].y, reducedOrderModel[5].solRad[
    4]) annotation (Line(points={{-33,36},{-28,36},{-28,15},{-25,15}}, color={0,
          0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ReducedOrderModel_MultipleRooms;
