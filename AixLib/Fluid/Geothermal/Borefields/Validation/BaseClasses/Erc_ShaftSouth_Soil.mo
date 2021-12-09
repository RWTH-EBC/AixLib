within AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses;
record Erc_ShaftSouth_Soil "Soil Data of the ERC field"
  extends Data.Soil.SandStone(
    kSoi=2.3,
    cSoi=2300,
    dSoi=1000);
  annotation (Documentation(info="<html>
<p>Soil data of the southern Shaft of the ERC field</p>
</html>", revisions="<html>
<p>December  9, 2021, by Phillip Stoffel:</p>
<p>First implementation. </p>
</html>"));
end Erc_ShaftSouth_Soil;
