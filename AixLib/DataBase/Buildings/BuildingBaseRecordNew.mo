within AixLib.DataBase.Buildings;
record BuildingBaseRecordNew
  "Base record definition for building records"
  extends Modelica.Icons.Record;

  parameter Integer buildingID "Unique identifier of the building";
  parameter Integer numZones(min = 1) "Number of zones in the building";
  parameter AixLib.DataBase.Buildings.ZoneBaseRecordNew zoneSetup[numZones]
    "Vector of zone records";
  parameter Modelica.SIunits.Volume VAir = sum(zoneSetup.VAir) "Indoor air volume of building";
  parameter Modelica.SIunits.Area ABuilding = sum(zoneSetup.AZone) "Net floor area of building";

  annotation (Documentation(revisions="<html>
<ul>
  <li><i>January 4, 2016&nbsp;</i> by Moritz Lauster:<br/>Clean up of record</li>
  <li><i>February 7, 2014&nbsp;</i> by Ole Odendahl:<br/>Added two more parameters, buildingID and usage for an easier identification of the building</li>
  <li><i>January 28, 2014&nbsp;</i>by Ole Odendahl:<br/>Implemented first version of record</li>
</ul>
</html>", info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This is the base definition of zone records used in <a href=\"AixLib.Building.LowOrder.Multizone\">AixLib.Building.LowOrder.Multizone</a>. All necessary parameters are defined here. Most values should be overwritten for a specific building, some are default values that might be appropriate in most cases. However, fell free to overwrite them in your own records. </span></p>
</html>"));
end BuildingBaseRecordNew;
