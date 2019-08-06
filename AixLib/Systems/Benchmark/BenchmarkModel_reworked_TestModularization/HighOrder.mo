within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrder "Test of high order modeling"
  extends Modelica.Icons.Example;
  ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows
    southFacingWindows(
    Room_Lenght={30,30,5,5,30},
    Room_Height={3,3,3,3,3},
    Room_Width={20,30,10,20,50},
    Win_Area={80,180,20,40,200},
    solar_absorptance_OW={0.48,0.48,0.48,0.48,0.48},
    eps_out={25,25,25,25,25},
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2002(),
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf,
    TypFL=AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML)
    annotation (Placement(transformation(extent={{-26,-40},{28,6}})));
end HighOrder;
