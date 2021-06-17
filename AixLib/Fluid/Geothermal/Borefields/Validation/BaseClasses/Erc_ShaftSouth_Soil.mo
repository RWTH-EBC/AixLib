within AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses;
record Erc_ShaftSouth_Soil "Soil Data of the ERC field"
  extends Data.Soil.SandStone(
    kSoi=2.3,
    cSoi=2300,
    dSoi=1000);
end Erc_ShaftSouth_Soil;
