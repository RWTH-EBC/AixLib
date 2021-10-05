within AixLib.Fluid.FMI.ExportContainers.Validation.FMUs;
block ThermalZoneSimpleAir2 "Validation of simple thermal zone"
  extends AixLib.Fluid.FMI.ExportContainers.Validation.FMUs.ThermalZoneAir1(
    redeclare package Medium = Modelica.Media.Air.SimpleAir(extraPropertiesNames={"CO2"}));
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
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/FMI/ExportContainers/Validation/FMUs/ThermalZoneSimpleAir2.mos"
        "Export FMU"));
end ThermalZoneSimpleAir2;
