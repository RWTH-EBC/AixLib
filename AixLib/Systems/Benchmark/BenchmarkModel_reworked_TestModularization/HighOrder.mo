within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrder "Test of high order modeling"
  extends Modelica.Icons.Example;
  ThermalZones.ReducedOrder.RC.FourElements theZon
    annotation (Placement(transformation(extent={{-26,40},{22,76}})));
  ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows
    southFacingWindows(Room_Lenght=1)
    annotation (Placement(transformation(extent={{-26,-40},{28,6}})));
end HighOrder;
