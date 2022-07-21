within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Examples.MultiZone.testtabs_multiple_zones.SimpleBuildingtesttabs_multiple_zones.SimpleBuildingtesttabs_multiple_zones_DataBase;
record SimpleBuildingtesttabs_multiple_zones_tz_2_upperTABS "SimpleBuildingtesttabs_multiple_zones_tz_2_upperTABS"
  extends AixLib.DataBase.Walls.WallBaseDataDefinition(
    n(min=1) = 2,
    d = {0.06, 0.007},
    rho = {2000.0, 860.0},
    lambda = {1.2, 0.13},
    c = {1000.0, 1000.0},
    eps = 0.95);
end SimpleBuildingtesttabs_multiple_zones_tz_2_upperTABS;
