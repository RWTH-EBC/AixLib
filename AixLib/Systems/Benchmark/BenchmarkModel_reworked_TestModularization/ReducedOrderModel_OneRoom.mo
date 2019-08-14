within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model ReducedOrderModel_OneRoom
  "Single instance of reduced order room with input paramaters"
   extends Modelica.Icons.Example;

  AixLib.ThermalZones.ReducedOrder.RC.FourElements reducedOrderRoom(  redeclare
      package Medium =
        AixLib.Media.Air,
    VAir=1800,
    hRad=5,
    nOrientations=2,
    AWin={40,40},
    ATransparent={32,32},
    hConvWin=1.3,
    RWin=0.01923,
    gWin=1,
    ratioWinConRad=0.09,
    AExt={20,20},
    hConvExt=2.5,
    nExt=4,
    RExt={0.05,2.857,0.48,0.0294},
    RExtRem=0,
    CExt={1000,1030,1000,1000},
    hConvInt=2.5,
    nInt=2,
    RInt={0.175,0.0294},
    CInt={1000,1000},
    AFloor=600,
    hConvFloor=2.5,
    nFloor=4,
    RFloor={1.5,0.1087,1.1429,0.0429},
    RFloorRem=0,
    CFloor={8400,575000,4944,120000},
    ARoof=600,
    hConvRoof=2.5,
    RRoofRem=0,
    AInt=180,
    RRoof={0.4444,0.06957,0.02941,0.1},
    CRoof={2472,368000,18000,1},
    nRoof=4)
    annotation (Placement(transformation(extent={{-24,-18},{24,18}})));
  Modelica.Blocks.Sources.Constant constantSolarRadiationThroughWindow1(k=10)
    annotation (Placement(transformation(extent={{-54,60},{-34,80}})));
  Modelica.Blocks.Sources.Constant constantSolarRadiationThroughWindow2(k=10)
    annotation (Placement(transformation(extent={{-54,26},{-34,46}})));
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
    freqHz=1/1200,
    offset=10500) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,8})));
  Modelica.Blocks.Sources.Sine InternalConvectiveGains(
    amplitude=10500,
    freqHz=1/1200,
    offset=10500) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-24})));
equation
  connect(constantSolarRadiationThroughWindow1.y, reducedOrderRoom.solRad[1])
    annotation (Line(points={{-33,70},{-24,70},{-24,14.5},{-25,14.5}}, color={0,
          0,127}));
  connect(constantSolarRadiationThroughWindow2.y, reducedOrderRoom.solRad[2])
    annotation (Line(points={{-33,36},{-26,36},{-26,15.5},{-25,15.5}}, color={0,
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ReducedOrderModel_OneRoom;
