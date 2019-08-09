within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model ReducedOrder "Test of reduced order modeling"

   extends Modelica.Icons.Example;
  replaceable package Medium = AixLib.Media.Air;
 AixLib.ThermalZones.ReducedOrder.RC.FourElements [5]   fourElements(
    VAir={1800,2700,150,300,4050},
    each RExt={0.05,2.857,0.48,0.0294},
    each CExt={1000,1030,1000,1000},
    each RInt={0.175,0.0294},
    each CInt={1000,1000},
    each RWin=0.01642857143,
    AWin={{40,0,40,0},{60,0,60,60},{20,0,0,0},{0,0,40,0},{80,60,60,0}},
    ATransparent={{32,0,32,0},{48,0,48,48},{16,0,0,0},{0,0,32,0},{64,48,48,0}},
    each hRad=5,
    each nOrientations=4,
    each hConvWin=1.3,
    each gWin=1,
    each ratioWinConRad=0.9,
    each hConvExt=2.5,
    each nExt=4,
    each RExtRem=0,
    each hConvInt=2.5,
    each nInt=2,
    AFloor={600,900,50,100,1500},
    each hConvFloor=2.5,
    each nFloor=4,
   each  RFloor={1.5,0.1087,1.1429,0.0429},
    each RFloorRem=0,
    each CFloor={8400,575000,4944,120000},
    ARoof={600,900,50,100,1500},
    each hConvRoof=2.5,
    redeclare package Medium = Media.Air)
    annotation (Placement(transformation(extent={{-21,-21},{33,25}})));

  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow [5] HeatFlowGround(Q_flow={-3867,
        -4576,-480,-897,-7557}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={6,-56})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow [5] HeatFlowRoof(Q_flow={3700,
        4735,308,617,8326}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={4,68})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow [5] IntConvGains(Q_flow={42894,
        14474,3842,1473,20512}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={78,6})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow [5] HeatFlowWindows(Q_flow={-3536,
        -6786,-884,-1768,-8840})
    annotation (Placement(transformation(extent={{-82,4},{-62,24}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow [5] HeatFlowExtWalls(Q_flow={-398,
        -764,-100,-199,-995})
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Sources.Constant SolarRadiationWindows
    annotation (Placement(transformation(extent={{-82,34},{-62,54}})));
equation
  connect(HeatFlowGround[5].port, fourElements[5].floor)
    annotation (Line(points={{6,-46},{6,-21}}, color={191,0,0}));
  connect(fourElements[5].intGainsConv, IntConvGains[5].port) annotation (Line(
        points={{33,7.11111},{68,7.11111},{68,6}}, color={191,0,0}));
  connect(HeatFlowRoof[5].port, fourElements[5].roof)
    annotation (Line(points={{4,58},{4,25},{4.7625,25}}, color={191,0,0}));
  connect(HeatFlowWindows[5].port, fourElements[5].window) annotation (Line(points=
         {{-62,14},{-38,14},{-38,7.11111},{-21,7.11111}}, color={191,0,0}));
  connect(fourElements[5].extWall, HeatFlowExtWalls[5].port) annotation (Line(
        points={{-21,-3.11111},{-38,-3.11111},{-38,-10},{-60,-10}}, color={191,0,
          0}));
  connect(SolarRadiationWindows.y, fourElements[5].solRad[1]) annotation (Line(
        points={{-61,44},{-42,44},{-42,20.2083},{-22.125,20.2083}}, color={0,0,
          127}));
end ReducedOrder;
