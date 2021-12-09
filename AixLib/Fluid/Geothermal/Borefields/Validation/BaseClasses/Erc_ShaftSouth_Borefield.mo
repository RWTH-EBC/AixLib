within AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses;
record Erc_ShaftSouth_Borefield "Data of the ERC Field"
  extends AixLib.Fluid.Geothermal.Borefields.Data.Borefield.Template(
     filDat=AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses.Erc_ShaftSouth_Filling(),
     soiDat=AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses.Erc_ShaftSouth_Soil(),
     conDat=AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses.Erc_ShaftSouth_Configuration());

  annotation (Documentation(info="<html>
<p>Borefield data of the southern shaft of the ERC field</p>
</html>", revisions="<html>
<p>December  9, 2021, by Phillip Stoffel:</p>
<p>First implementation. </p>
</html>"));
end Erc_ShaftSouth_Borefield;
