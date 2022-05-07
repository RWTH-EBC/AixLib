within AixLib.DataBase.Storage;
record BufferStorageBaseDataDefinition
  "Base data definition for Buffer storage records"
  extends Modelica.Icons.Record;
///////////input parameters////////////
  import SI = Modelica.SIunits;
  parameter SI.Height hTank "Height of storage";
  parameter SI.Height hLowerPortDemand "Height of lower demand port";
  parameter SI.Height hUpperPortDemand "Height of upper demand port";
  parameter SI.Height hLowerPortSupply "Height of lower supply port";
  parameter SI.Height hUpperPortSupply "Height of upper supply port";
  parameter SI.Height hHC1Up "Height of heating Coil";
  parameter SI.Height hHC1Low "Height of heating Coil";
  parameter SI.Height hHC2Up "Height of heating Coil";
  parameter SI.Height hHC2Low "Height of heating Coil";
  parameter SI.Height hHR "Height of heating Rod";
  parameter SI.Diameter dTank "Inner diameter of storage";
  parameter SI.Length sWall "Thickness of storage Wall";
  parameter SI.Length sIns "Thickness of storage insulation";
  parameter Modelica.SIunits.ThermalConductivity lambdaWall
    "thermal conductivity of storage wall";
  parameter Modelica.SIunits.ThermalConductivity lambdaIns
    "thermal conductivity of storage insulation";
  //parameter SI.CoefficientOfHeatTransfer alpha
    //"Coefficient of heat transfer air <-> insulation of tank";
  parameter SI.Length hTS1 "Height of lower temperature sensor";
  parameter SI.Length hTS2 "Height of upper temperature sensor";
  parameter SI.Density rhoIns "Density of insulation";
  parameter SI.SpecificHeatCapacity cIns "Heat capacity of insulation";
  parameter SI.Density rhoWall "Density of wall";
  parameter SI.SpecificHeatCapacity cWall "Heat capacity of wall";
  parameter SI.Length roughness "Inner roughness of storage wall";

  // Heat exchanger Pipes

  parameter DataBase.Pipes.PipeBaseDataDefinition pipeHC1
    "Type of Pipe for HR1";
  parameter DataBase.Pipes.PipeBaseDataDefinition pipeHC2
    "Type of Pipe for HR2";

  parameter Modelica.SIunits.Length lengthHC1 "Length of Pipe for HR1";
  parameter Modelica.SIunits.Length lengthHC2 "Length of Pipe for HR2";

  annotation (Icon(graphics),               Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Base data definition for buffer storage records
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record used with <a href=
  \"AixLib.Fluid.Storage.Storage\">AixLib.Fluid.Storage.Storage</a> and
  <a href=
  \"AixLib.Fluid.Storage.BufferStorage\">AixLib.Fluid.Storage.BufferStorage</a>
</p>
</html>",
        revisions="<html><ul>
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
end BufferStorageBaseDataDefinition;
