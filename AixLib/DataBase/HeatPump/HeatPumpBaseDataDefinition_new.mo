within AixLib.DataBase.HeatPump;
record HeatPumpBaseDataDefinition_new "Basic heat pump dataheat pump data with look-up tables for calculating Pel, QflowUse"
  parameter String name "name of product";
  parameter String manufacturer "name of manufacturer";
  parameter String heatSource "heat source: water, air, brine";

   parameter Real TsourceMax "maximum source temperature";
   parameter Real TsourceMin "minimum source temperature";

   parameter Real TuseMax "maximum use temperature";
   parameter Real TuseMin "minimum use temperature";

   parameter Real Nmax "maximum revolution speed";
   parameter Real Nmin "minimum revolution speed";
   parameter Real Nnom "nominal revolution speed";

   parameter Real PelMax "maximum electrical power";
   parameter Real PelMin "minimum electrical power";

   parameter Real QflowUseMax "maximum thermal power use";
   parameter Real QflowUseMin "minimum thermal power use";

   parameter Real mFlowUseNom = QflowUseMax/4180/5 "nominal use mass flow for standard settings";
   parameter Real mFlowSourceNom = 1 "nominal source mass flow";

   parameter String charType "format of characteristics: table/polynom";

   parameter Real table_QflowUse[:,:]
    "Heating power lookup table: first column - Tuse in K (u1); first row - Tsource in K (u2) ; table values - Qflow in W (y)";
   parameter Real table_Pel[:,:]
    "Electrical power lookup table: first column - Tuse in K (u1); first row - Tsource in K (u2); table values - Pel in W (y)";

   parameter Real[:] Pel_fTuseTsourceN = {0}
    "coefficients to calculate the electrical power as a function of the use temperature, the source temperature and the revolution speed";
   parameter Real[:] QflowUse_fTuseTsourceN = {0}
    "coefficients to calculate heatflow as a function of the use temperature, the source temperature and the revolution speed";

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Base data definition used in the HeatPump model. It defines the table table_Qdot_Co which gives the condenser heat flow rate and table_Pel which gives the electric power consumption of the heat pump. Both tables define the power values depending on the evaporator inlet temperature (columns) and the evaporator outlet temperature (rows) in W. The nominal heat flow rate in the condenser and evaporator are also defined as parameters. </p>
</html>",
        revisions="<html>
<ul>
<li><i>May 26, 2017&nbsp;</i> by Ana Constantin:<br/>Initial implementation</li>
</ul>
</html>
"),Icon,     preferedView="info");
end HeatPumpBaseDataDefinition_new;
