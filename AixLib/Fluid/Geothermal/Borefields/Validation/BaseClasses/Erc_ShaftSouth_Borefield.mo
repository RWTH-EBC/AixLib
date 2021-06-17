within AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses;
record Erc_ShaftSouth_Borefield "Data of the ERC Field"
  extends Data.Borefield.Template(
    final filDat=
        AixLib.Fluid.Geothermal.Borefields.BaseClasses.Erc_ShaftSouth_Filling(),

    final soiDat=
        AixLib.Fluid.Geothermal.Borefields.BaseClasses.Erc_ShaftSouth_Soil(),
    final conDat=
        AixLib.Fluid.Geothermal.Borefields.BaseClasses.Erc_ShaftSouth_Configuration());
end Erc_ShaftSouth_Borefield;
