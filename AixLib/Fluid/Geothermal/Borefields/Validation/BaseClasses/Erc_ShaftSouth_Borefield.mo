within AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses;
record Erc_ShaftSouth_Borefield "Data of the ERC Field"
  extends Data.Borefield.Template(
    final filDat=
        AixLib.Fluid.Geothermal.Borefields.BaseClasses.Erc_ShaftSouth_Filling(),
    final soiDat=
        AixLib.Fluid.Geothermal.Borefields.BaseClasses.Erc_ShaftSouth_Soil(),
    final conDat=
        AixLib.Fluid.Geothermal.Borefields.BaseClasses.Erc_ShaftSouth_Configuration());

  annotation (Documentation(info="<html>
<p>Borefield data of the southern shaft of the ERC field</p>
</html>", revisions="<html>
<p>December  9, 2021, by Phillip Stoffel:</p>
<p>First implementation. </p>
</html>"));
end Erc_ShaftSouth_Borefield;
