within AixLib.DataBase.Walls;
package Dummys

  record FloorForFloorHeating2Layers
    "Floor dummy with 2 layers for floor heating"
   extends WallBaseDataDefinition(
    n(min = 1) = 2 "Number of wall layers",
    d = {0.00001, 0.00001} "Thickness of wall layers",
    rho = {1800, 300}  "Density of wall layers",
    lambda = {1, 0.1} "Thermal conductivity of wall layers",
    c = {1000, 1700}  "Specific heat capacity of wall layers",
    eps = 0.95  "Emissivity of inner wall surface");

    /*
   extends WallBaseDataDefinition(
  n(min = 1) = 4 "Number of wall layers",
  d = {0.00001, 0.00001, 0.00001, 0.00001} "Thickness of wall layers",
  rho = {1800, 300, 172, 1018.2}  "Density of wall layers",
  lambda = {1, 0.1, 0.056, 0.346} "Thermal conductivity of wall layers",
  c = {1000, 1700, 1337, 1000}  "Specific heat capacity of wall layers",
  eps = 0.95  "Emissivity of inner wall surface");
  */
  end FloorForFloorHeating2Layers;

  record CeilingForFloorHeating3Layers
    "Ceiling dummy with 3 layers for floor heating"
  extends WallBaseDataDefinition(
    n(min = 1) = 3 "Number of wall layers",
    d = {0.00001, 0.00001, 0.00001} "Thickness of wall layers",
    rho = {1800, 300, 1018.2}  "Density of wall layers",
    lambda = {1, 0.1, 0.346} "Thermal conductivity of wall layers",
    c = {1000, 1700, 1000}  "Specific heat capacity of wall layers",
    eps = 0.95  "Emissivity of inner wall surface");
  end CeilingForFloorHeating3Layers;

  record FloorForFloorHeating4Layers
    "Floor dummy with 4 layers for floor heating"

   extends WallBaseDataDefinition(
    n(min = 1) = 4 "Number of wall layers",
    d = {0.00001, 0.00001, 0.00001, 0.00001} "Thickness of wall layers",
    rho = {1800, 300, 172, 1018.2}  "Density of wall layers",
    lambda = {1, 0.1, 0.056, 0.346} "Thermal conductivity of wall layers",
    c = {1000, 1700, 1337, 1000}  "Specific heat capacity of wall layers",
    eps = 0.95  "Emissivity of inner wall surface");

  end FloorForFloorHeating4Layers;
end Dummys;
