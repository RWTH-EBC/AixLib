within AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses;
record Erc_ShaftSouth_Soil "Soil Data of the ERC field"
  extends AixLib.Fluid.Geothermal.Borefields.Data.Soil.Template(
    kSoi=2.3,
    cSoi=2300,
    dSoi=1000);
  annotation (Documentation(info="<html><p>
  This record contains the soil data of the ERC field.
</p>
</html>",
revisions="<html><ul>
  <li>December 9, 2021, by Phillip Stoffel:<br/>
    Revised implementation, added <code>defaultComponentPrefixes</code>
    and <code>defaultComponentName</code>.
  </li>
</ul>
</html>"));
end Erc_ShaftSouth_Soil;
