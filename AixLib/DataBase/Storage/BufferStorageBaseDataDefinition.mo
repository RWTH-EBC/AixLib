within AixLib.DataBase.Storage;
record BufferStorageBaseDataDefinition
  "Base data definition for Buffer storage records"
  extends Modelica.Icons.Record;
///////////input parameters////////////
  import SI = Modelica.SIunits;
  parameter SI.Height h_Tank "Height of storage";
  parameter SI.Height h_lower_ports "Height of lower ports";
  parameter SI.Height h_upper_ports "Height of upper ports";
  parameter SI.Height h_HC1_up "Height of heating Coil";
  parameter SI.Height h_HC1_low "Height of heating Coil";
  parameter SI.Height h_HC2_up "Height of heating Coil";
  parameter SI.Height h_HC2_low "Height of heating Coil";
  parameter SI.Height h_HR "Height of heating Rod";
  parameter SI.Diameter d_Tank "Inner diameter of storage";
  parameter SI.Length s_wall "Thickness of storage Wall";
  parameter SI.Length s_ins "Thickness of storage insulation";
  parameter Modelica.SIunits.ThermalConductivity lambda_wall
    "thermal conductivity of storage wall";
  parameter Modelica.SIunits.ThermalConductivity lambda_ins
    "thermal conductivity of storage insulation";
  //parameter SI.CoefficientOfHeatTransfer alpha
    //"Coefficient of heat transfer air <-> insulation of tank";
  parameter SI.Length h_TS1 "Height of lower temperature sensor";
  parameter SI.Length h_TS2 "Height of upper temperature sensor";
  parameter SI.Density rho_ins "Density of insulation";
  parameter SI.SpecificHeatCapacity c_ins "Heat capacity of insulation";
  parameter SI.Density rho_wall "Density of wall";
  parameter SI.SpecificHeatCapacity c_wall "Heat capacity of wall";
  parameter SI.Length roughness "Inner roughness of storage wall";

  // Heat exchanger Pipes

  parameter DataBase.Pipes.PipeBaseDataDefinition Pipe_HC1
    "Type of Pipe for HR1";
  parameter DataBase.Pipes.PipeBaseDataDefinition Pipe_HC2
    "Type of Pipe for HR2";

  parameter Modelica.SIunits.Length Length_HC1 "Length of Pipe for HR1";
  parameter Modelica.SIunits.Length Length_HC2 "Length of Pipe for HR2";

  annotation (Icon(graphics),               Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base data definition for buffer storage records
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definition for record used with <a href=\"HVAC.Components.BufferStorage.BufferStorageHeatingcoils\">HVAC.Components.BufferStorage.BufferStorageHeatingcoils</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end BufferStorageBaseDataDefinition;
