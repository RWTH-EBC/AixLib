within AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses;
record Erc_ShaftSouth_Filling "Filling Data of the ERC Field"
  extends AixLib.Fluid.Geothermal.Borefields.Data.Filling.Template(
    kFil=2,
    cFil=1000,
    dFil=1000);
  annotation (Documentation(
info="<html>
 <p>
 This record contains the filling data of the ERC field.
 </p>
 </html>",
revisions="<html>
 <ul>
 <li>
 December 9, 2021, by Phillip Stoffel:<br/>
 Revised implementation, added <code>defaultComponentPrefixes</code> and
 <code>defaultComponentName</code>.
 </li>
 </ul>
 </html>"));
end Erc_ShaftSouth_Filling;
