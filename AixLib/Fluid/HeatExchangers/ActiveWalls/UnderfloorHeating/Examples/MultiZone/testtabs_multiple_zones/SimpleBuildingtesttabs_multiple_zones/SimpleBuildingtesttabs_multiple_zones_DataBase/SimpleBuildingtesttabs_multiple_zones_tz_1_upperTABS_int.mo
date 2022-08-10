within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Examples.MultiZone.testtabs_multiple_zones.SimpleBuildingtesttabs_multiple_zones.SimpleBuildingtesttabs_multiple_zones_DataBase;
record SimpleBuildingtesttabs_multiple_zones_tz_1_upperTABS_int "SimpleBuildingtesttabs_multiple_zones_tz_1_upperTABS_int"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 2,
    d = {0.06, 0.0045},
    rho = {2000.0, 150.0},
    lambda = {1.21, 0.045},
    c = {1000.0, 840.0},
    eps = 0.95);
end SimpleBuildingtesttabs_multiple_zones_tz_1_upperTABS_int;
