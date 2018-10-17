within AixLib.Fluid.FMI.ExportContainers.Validation.FMUs;
block ThermalZoneAir3 "Validation of simple thermal zone"
  extends AixLib.Fluid.FMI.ExportContainers.Validation.FMUs.ThermalZoneAir1(
    redeclare package Medium = AixLib.Media.Air(extraPropertiesNames={"CO2", "VOC", "CH2O"}));
  annotation (Documentation(info="<html>
<p>
This example validates that
<a href=\"modelica://AixLib.Fluid.FMI.ExportContainers.ThermalZone\">
AixLib.Fluid.FMI.ExportContainers.ThermalZone
</a>
exports correctly as an FMU.
</p>
</html>", revisions="<html>
<ul>
<li>
May 03, 2016, by Thierry S. Nouidui:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/FMI/ExportContainers/Validation/FMUs/ThermalZoneAir3.mos"
        "Export FMU"));
end ThermalZoneAir3;
