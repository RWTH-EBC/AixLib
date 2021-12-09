within AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses;
record Erc_ShaftSouth_Filling "Filling Data of the ERC Field"
  extends Data.Filling.Bentonite(
    kFil=2,
    cFil=1000,
    dFil=1000);
  annotation (Documentation(info="<html>
<p>Filling data of the southern Shaft of the ERC field</p>
</html>", revisions="<html>
<p>December  9, 2021, by Phillip Stoffel:</p>
<p>First implementation. </p>
</html>"));
end Erc_ShaftSouth_Filling;
