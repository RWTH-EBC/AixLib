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

  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Base data definition used in the heat pump model. It defines the
  table <span style=\"font-family: Courier New;\">table_Qdot_Co</span>
  which gives the condenser heat flow rate and <span style=
  \"font-family: Courier New;\">table_Pel</span> which gives the electric
  power consumption of the heat pump. Both tables define the power
  values depending on the evaporator inlet temperature (defined in
  first row) and the condenser outlet temperature (defined in first
  column) in W. The nominal mass flow rate in the condenser and
  evaporator are also defined as parameters.
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>December 10, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
</ul>
</html>
"),Icon,     preferedView="info");
end HeatPumpBaseDataDefinition;
