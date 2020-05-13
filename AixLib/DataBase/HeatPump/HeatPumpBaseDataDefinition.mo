within AixLib.DataBase.HeatPump;
record HeatPumpBaseDataDefinition "Basic heat pump data"
    extends Modelica.Icons.Record;
  parameter Real tableQdot_con[:,:] "Heating power table; T in degC; Q_flow in W";
  parameter Real tableP_ele[:,:] "Electrical power table; T in degC; Q_flow in W";
  parameter Modelica.SIunits.MassFlowRate mFlow_conNom
    "Nominal mass flow rate in condenser";
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNom
    "Nominal mass flow rate in evaporator";
  parameter Real tableUppBou[:,2] "Points to define upper boundary for sink temperature";

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Base data definition used in the heat pump model. It defines the table <span style=\"font-family: Courier New;\">table_Qdot_Co</span> which gives the condenser heat flow rate and <span style=\"font-family: Courier New;\">table_Pel</span> which gives the electric power consumption of the heat pump. Both tables define the power values depending on the evaporator inlet temperature (defined in first row) and the condenser outlet temperature (defined in first column) in W. The nominal mass flow rate in the condenser and evaporator are also defined as parameters. </p>
<p><h4><span style=\"color: #008000\">Calculation of nominal mass flow rates</span></h4> 
<ul>
<li>General calculation m&#775; = Q&#775;<sub>nominal</sub> / c<sub>p</sub> / &Delta;T</li>
</ul>
<b>Condenser</b> <span style=\"font-family: Courier New;\">mFlow_conNom </span></p>
<ul>
<li>According to <b>EN 14511</b> on <b>water</b> bound condenser side <span style=\"font-family: Courier New;\">&Delta;T = 5 K</span> </li>
<li>According to EN 255 (deprecated) on <b>water</b> bound condenser side <span style=\"font-family: Courier New;\">&Delta;T = 10 K</span> </li>
</ul>
<b>Evaporator</b> <span style=\"font-family: Courier New;\"> mFlow_evaNom:</span></p>
<ul>
<li>According to <b>EN 14511</b> on <b>water/glycol</b> bound evaporator side <span style=\"font-family: Courier New;\">&Delta;T = 3 K</span> </li>
<li>Possible calculation for <b>air</b> bound evaporator side <span>m&#775;<sub>eva,nominal</sub>  = (Q&#775;<sub>con,nominal</sub> - P&#775;<sub>el,nominal</sub>) / c<sub>p</sub> / &Delta;T</span> under the assumption (no literature source so far) of <span>&Delta;T = 5 K</span></li>
</ul>
</html>",
        revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>
"),Icon,     preferedView="info");
end HeatPumpBaseDataDefinition;
