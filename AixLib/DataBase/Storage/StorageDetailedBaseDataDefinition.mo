within AixLib.DataBase.Storage;
record StorageDetailedBaseDataDefinition
  "Base data definition for Buffer storage records"
  extends Modelica.Icons.Record;
///////////input parameters////////////

  parameter Modelica.Units.SI.Height hTank "Height of storage";
  parameter Modelica.Units.SI.Height hLowerPortDemand "Height of lower demand port";
  parameter Modelica.Units.SI.Height hUpperPortDemand "Height of upper demand port";
  parameter Modelica.Units.SI.Height hLowerPortSupply "Height of lower supply port";
  parameter Modelica.Units.SI.Height hUpperPortSupply "Height of upper supply port";
  parameter Modelica.Units.SI.Height hHC1Up "Height of heating Coil";
  parameter Modelica.Units.SI.Height hHC1Low "Height of heating Coil";
  parameter Modelica.Units.SI.Height hHC2Up "Height of heating Coil";
  parameter Modelica.Units.SI.Height hHC2Low "Height of heating Coil";
  parameter Modelica.Units.SI.Height hHR "Height of heating Rod";
  parameter Modelica.Units.SI.Diameter dTank "Inner diameter of storage";
  parameter Modelica.Units.SI.Length sWall "Thickness of storage Wall";
  parameter Modelica.Units.SI.Length sIns "Thickness of storage insulation";
  parameter Modelica.Units.SI.ThermalConductivity lambdaWall
    "thermal conductivity of storage wall";
  parameter Modelica.Units.SI.ThermalConductivity lambdaIns
    "thermal conductivity of storage insulation";
  parameter Modelica.Units.SI.Length hTS1 "Height of lower temperature sensor";
  parameter Modelica.Units.SI.Length hTS2 "Height of upper temperature sensor";
  parameter Modelica.Units.SI.Density rhoIns "Density of insulation";
  parameter Modelica.Units.SI.SpecificHeatCapacity cIns "Heat capacity of insulation";
  parameter Modelica.Units.SI.Density rhoWall "Density of wall";
  parameter Modelica.Units.SI.SpecificHeatCapacity cWall "Heat capacity of wall";
  parameter Modelica.Units.SI.Length roughness "Inner roughness of storage wall";

  // Heat exchanger Pipes

  parameter DataBase.Pipes.PipeBaseDataDefinition pipeHC1
    "Type of Pipe for HR1";
  parameter DataBase.Pipes.PipeBaseDataDefinition pipeHC2
    "Type of Pipe for HR2";

  parameter Modelica.Units.SI.Length lengthHC1 "Length of Pipe for HR1";
  parameter Modelica.Units.SI.Length lengthHC2 "Length of Pipe for HR2";

  annotation (Icon(graphics),Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Base data definition for detailed storage records
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record used with <a href=
  \"modelica://AixLib.Fluid.Storage.StorageDetailed\">AixLib.Fluid.Storage.StorageDetailed</a>
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>November 17, 2022</i> by Laura Maier:<br/>
    Refactor and fix documentation
  </li>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add comments and fix documentation
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Sebastian Stinner:<br/>
    Transferred to AixLib
  </li>
  <li>
    <i>July 4, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end StorageDetailedBaseDataDefinition;
