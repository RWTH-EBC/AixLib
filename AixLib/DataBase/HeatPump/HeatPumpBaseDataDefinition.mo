within AixLib.DataBase.HeatPump;
record HeatPumpBaseDataDefinition "Basic heat pump data"
    extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;
  import SIconv = Modelica.SIunits.Conversions.NonSIunits;
  parameter Real tableQdot_con[:,:] "Heating power lookup table";
  parameter Real tableP_ele[:,:] "Electrical power lookup table";
  parameter SI.MassFlowRate mFlow_conNom
    "nominal mass flow rate in condenser";
  parameter SI.MassFlowRate mFlow_evaNom
    "nominal mass flow rate in evaporator";

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Base data definition used in the HeatPump model. It defines the table table_Qdot_Co which gives the condenser heat flow rate and table_Pel which gives the electric power consumption of the heat pump. Both tables define the power values depending on the evaporator inlet temperature (columns) and the evaporator outlet temperature (rows) in W. The nominal heat flow rate in the condenser and evaporator are also defined as parameters. </p>
</html>",
        revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>
"),Icon,     preferedView="info");
end HeatPumpBaseDataDefinition;
