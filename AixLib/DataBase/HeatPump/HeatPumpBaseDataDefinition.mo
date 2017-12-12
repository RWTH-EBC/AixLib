within AixLib.DataBase.HeatPump;
record HeatPumpBaseDataDefinition "Basic heat pump data"
    extends Modelica.Icons.Record;
  import SI = Modelica.SIunits;
  parameter Real tableQdot_con[:,:] "Heating power lookup table";
  parameter Real tableP_ele[:,:] "Electrical power lookup table";
  parameter SI.MassFlowRate mFlow_conNom
    "Nominal mass flow rate in condenser";
  parameter SI.MassFlowRate mFlow_evaNom
    "Nominal mass flow rate in evaporator";

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Base data definition used in the heat pump model. It defines the table <code>table_Qdot_Co</code> which gives the condenser heat flow rate and <code>table_Pel</code> which gives the electric power consumption of the heat pump. Both tables define the power values depending on the evaporator inlet temperature (defined in first row) and the condenser outlet temperature (defined in first column) in W. The nominal heat flow rate in the condenser and evaporator are also defined as parameters. </p>
</html>",
        revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>
"),Icon,     preferedView="info");
end HeatPumpBaseDataDefinition;
