within AixLib.Airflow.FacadeVentilationUnit.BaseClasses;
record FVUBaseRecord "Base record for the facade ventilation unit model"
  extends Modelica.Icons.Record;

  parameter Real noUnits=1 "Number of identical FVUs";
  parameter Modelica.SIunits.ThermalConductance UA_heater=120
    "Thermal conductance of heater at nominal flow, used to compute heat capacity";
  parameter Modelica.SIunits.ThermalConductance UA_cooler=65
    "Thermal conductance of cooler at nominal flow, used to compute heat capacity";
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal_heater=0.1
    "Nominal mass flow rate on water side of heater";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal_heater=0.1
    "Nominal mass flow rate on air side of heater";
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal_cooler=0.1
    "Nominal mass flow rate on water side of cooler";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal_cooler=0.1
    "Nominal mass flow rate on air side of cooler";
  parameter Modelica.SIunits.Pressure dp1_nominal_heater=1000
    "Nominal pressure loss on water side of heater";
  parameter Modelica.SIunits.Pressure dp2_nominal_heater=100
    "Nominal pressure loss on air side of heater";
  parameter Modelica.SIunits.Pressure dp1_nominal_cooler=1000
    "Nominal pressure loss on water side of cooler";
  parameter Modelica.SIunits.Pressure dp2_nominal_cooler=100
    "Nominal pressure loss on air side of cooler";
  parameter Modelica.SIunits.Pressure p_default=101300
    "Default static pressure at outlet";

  annotation (Documentation(info="<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This is the base definition is zone records used in <a href=\"AixLib.Building.LowOrder.ThermalZone\">AixLib.Building.LowOrder.ThermalZone</a>. All necessary parameters are defined here. Most values should be overwritten for a specific building, some are default values that might be appropriate in most cases. However, fell free to overwrite them in your own records.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>Remark: The design heating power Q_N of the building is the sum of net design power according to transmission and ventilation losses at a given outdoor temperature and an additional re-heating power for early morning heat up after night set-back. Net design power can be simulated with constant boundary conditions (e. g.: no internal or external gains, Touside=-12 degC, ACH=0.5). The additional re-heating power is computed by a factor [f_RH]=W/m2 and the heated zone floor area.</p>
 <p>The factor f_RH in W/m2 can be chosen form the following table:</p>
 <table summary=\"factor f_RH\" cellspacing=\"2\" cellpadding=\"0\" border=\"1\"><tr>
 <td></td>
 <td><h4 align=\"center\">1 K</h4></td>
 <td><h4 align=\"center\">2 K</h4></td>
 <td><h4 align=\"center\">3 K</h4></td>
 </tr>
 <tr>
 <td><h4 align=\"center\">re-heat time</h4></td>
 <td><h4 align=\"center\">light</h4></td>
 <td><h4 align=\"center\">medium</h4></td>
 <td><h4 align=\"center\">heavy</h4></td>
 </tr>
 <tr>
 <td><p>1 h</p></td>
 <td><p>11</p></td>
 <td><p>22</p></td>
 <td><p>45</p></td>
 </tr>
 <tr>
 <td><p>2 h</p></td>
 <td><p>6</p></td>
 <td><p>11</p></td>
 <td><p>22</p></td>
 </tr>
 <tr>
 <td><p>3 h</p></td>
 <td><p>4</p></td>
 <td><p>9</p></td>
 <td><p>16</p></td>
 </tr>
 <tr>
 <td><p>4 h</p></td>
 <td><p>2</p></td>
 <td><p>7</p></td>
 <td><p>13</p></td>
 </tr>
 </table>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Base data definition for record to be used in model <a href=\"AixLib.Building.LowOrder.ThermalZone\">AixLib.Building.LowOrder.ThermalZone</a></p>
 </html>", revisions="<html>
<ul>
<li><i>June, 2015 </i>by Moitz Lauster:
<br>Added new parameters to use further calculation cores.</li>
<li><i>February 4, 2014&nbsp;</i>by Ole Odendahl:<br>Added new parameters for the setup of the ACH. It is now possible to assign different values to the ACH for each zone based on this record. </li>
<li><i>January 27, 2014&nbsp;</i>by Ole Odendahl:<br>Added new parameter withAHU to choose whether the zone is connected to a central air handling unit. Default false </li>
<li><i>March, 2012&nbsp;</i> by Peter Matthes:<br>Implemented </li>
<li><i>November, 2012&nbsp;</i> by Moritz Lauster:<br>Restored links </li>
</ul>
</html>"));

end FVUBaseRecord;
