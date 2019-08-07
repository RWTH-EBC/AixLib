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
    annotation (Placement(transformation(extent={{-21,-23},{33,23}})));

   annotation ();
end ReducedOrder;
