within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model ReducedOrderModel_OneRoom
  "Single instance of reduced order room with input paramaters"
   extends Modelica.Icons.Example;

  AixLib.ThermalZones.ReducedOrder.RC.FourElements reducedOrderRoom(  redeclare
      package Medium =
        AixLib.Media.Air,
    hRad=5,
    hConvWin=1.3,
    gWin=1,
    ratioWinConRad=0.09,
    hConvExt=2.5,
    nExt=4,
    RExt={0.05,2.857,0.48,0.0294},
    RExtRem=0,
    CExt={1000,1030,1000,1000},
    hConvInt=2.5,
    nInt=2,
    RInt={0.175,0.0294},
    CInt={1000,1000},
    hConvFloor=2.5,
    nFloor=4,
    RFloor={1.5,0.1087,1.1429,0.0429},
    RFloorRem=0,
    CFloor={8400,575000,4944,120000},
    hConvRoof=2.5,
    RRoofRem=0,
    VAir=2700,
    nOrientations=3,
    AWin={60,60,60},
    ATransparent={48,48,48},
    RWin=0.01282,
    AExt={30,30,30},
    AInt=90,
    AFloor=900,
    ARoof=900,
    nRoof=4,
    RRoof={0.4444,0.06957,0.02941,0.0001},
    CRoof={2472,368000,18000,1})
    annotation (Placement(transformation(extent={{-24,-18},{24,18}})));
  Modelica.Blocks.Sources.Constant constantSolarRadiationThroughWindow1(k=10)
    annotation (Placement(transformation(extent={{-96,72},{-76,92}})));
  Modelica.Blocks.Sources.Constant constantSolarRadiationThroughWindow2(k=10)
    annotation (Placement(transformation(extent={{-94,38},{-74,58}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughRoof(Q_flow=-3700)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,64})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughFloorPlate(Q_flow=-3867)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-38})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughWindow(Q_flow=-3536)
    annotation (Placement(transformation(extent={{-56,-6},{-36,14}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughExteriorWalls(Q_flow=-398)
    annotation (Placement(transformation(extent={{-56,-30},{-36,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowForInternalConvectiveGains
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={48,-10})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowForInternalRadiativeGains
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={48,8})));
  Modelica.Blocks.Sources.Sine InternalRadiativeGains(
    amplitude=10500,
    offset=10500,
    freqHz=1/3600)
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,8})));
  Modelica.Blocks.Sources.Sine InternalConvectiveGains(
    amplitude=10500,
    offset=10500,
    freqHz=1/3600)
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-24})));
  Modelica.Blocks.Sources.Constant constantSolarRadiationThroughWindow3(k=10)
    annotation (Placement(transformation(extent={{-94,6},{-74,26}})));
equation
  connect(constantSolarRadiationThroughWindow1.y, reducedOrderRoom.solRad[1])
    annotation (Line(points={{-75,82},{-24,82},{-24,14.3333},{-25,14.3333}},
                                                                       color={0,
          0,127}));
  connect(constantSolarRadiationThroughWindow2.y, reducedOrderRoom.solRad[2])
    annotation (Line(points={{-73,48},{-24,48},{-24,15},{-25,15}},     color={0,
          0,127}));
  connect(fixedHeatFlowThroughRoof.port, reducedOrderRoom.roof) annotation (Line(
        points={{-1.77636e-15,54},{0,54},{0,18},{-1.1,18}}, color={191,0,0}));
  connect(fixedHeatFlowThroughFloorPlate.port, reducedOrderRoom.floor) annotation (
      Line(points={{4.44089e-16,-28},{0,-28},{0,-18}}, color={191,0,0}));
  connect(fixedHeatFlowThroughWindow.port, reducedOrderRoom.window)
    annotation (Line(points={{-36,4},{-24,4}}, color={191,0,0}));
  connect(fixedHeatFlowThroughExteriorWalls.port, reducedOrderRoom.extWall)
    annotation (Line(points={{-36,-20},{-24,-20},{-24,-4}}, color={191,0,0}));
  connect(prescribedHeatFlowForInternalRadiativeGains.port, reducedOrderRoom.intGainsRad)
    annotation (Line(points={{38,8},{24,8}}, color={191,0,0}));
  connect(prescribedHeatFlowForInternalConvectiveGains.port, reducedOrderRoom.intGainsConv)
    annotation (Line(points={{38,-10},{32,-10},{32,4},{24,4}}, color={191,0,0}));
  connect(InternalRadiativeGains.y, prescribedHeatFlowForInternalRadiativeGains.Q_flow)
    annotation (Line(points={{77,8},{58,8}}, color={0,0,127}));
  connect(InternalConvectiveGains.y,
    prescribedHeatFlowForInternalConvectiveGains.Q_flow) annotation (Line(
        points={{79,-24},{70,-24},{70,-10},{58,-10}}, color={0,0,127}));
  connect(constantSolarRadiationThroughWindow3.y, reducedOrderRoom.solRad[3])
    annotation (Line(points={{-73,16},{-50,16},{-50,15.6667},{-25,15.6667}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ReducedOrderModel_OneRoom;
