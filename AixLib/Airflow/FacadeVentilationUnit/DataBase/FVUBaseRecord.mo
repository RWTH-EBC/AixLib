within AixLib.Airflow.FacadeVentilationUnit.DataBase;
record FVUBaseRecord
  "Base record for the facade ventilation unit model"
  extends Modelica.Icons.Record;

  parameter Integer noUnits=1 "Number of identical FVUs";
  parameter Modelica.Units.SI.ThermalConductance UA_heater=120 "Thermal conductance of heater at nominal flow, used to compute heat 
    capacity";
  parameter Modelica.Units.SI.ThermalConductance UA_cooler=65 "Thermal conductance of cooler at nominal flow, used to compute heat 
    capacity";
  parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal_heater=0.1
    "Nominal mass flow rate on water side of heater";
  parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal_heater=0.1
    "Nominal mass flow rate on air side of heater";
  parameter Modelica.Units.SI.MassFlowRate m1_flow_nominal_cooler=0.1
    "Nominal mass flow rate on water side of cooler";
  parameter Modelica.Units.SI.MassFlowRate m2_flow_nominal_cooler=0.05
    "Nominal mass flow rate on air side of cooler";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_damper=0.1
    "Nominal mass flow rate of damper";
  parameter Modelica.Units.SI.Pressure dp1_nominal_heater=1000
    "Nominal pressure loss on water side of heater";
  parameter Modelica.Units.SI.Pressure dp2_nominal_heater=100
    "Nominal pressure loss on air side of heater";
  parameter Modelica.Units.SI.Pressure dp1_nominal_cooler=1000
    "Nominal pressure loss on water side of cooler";
  parameter Modelica.Units.SI.Pressure dp2_nominal_cooler=100
    "Nominal pressure loss on air side of cooler";
  parameter Modelica.Units.SI.Pressure p_default=101300
    "Default static pressure at outlet";
  parameter Modelica.Units.SI.Pressure dp_nominal_damper=500
    "Nominal pressure loss in dampers";
  parameter Modelica.Units.SI.Time damperRiseTimeLong=90 "Rising time of the 
   slowly moving dampers";
  parameter Modelica.Units.SI.Time damperRiseTimeShort=20 "Rising time of the 
   slowly moving dampers";

  annotation (Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  This is the base definition of the paramter record that can be used
  for the <a href=
  \"AixLib.Airflow.FacadeVentilationUnit.FacadeVentilationUnit\">AixLib.Airflow.FacadeVentilationUnit.FacadeVentilationUnit</a>.
</p>
<ul>
  <li>July, 2017 by Marc Baranski and Roozbeh Sangi:<br/>
    First implementation.
  </li>
</ul>
</html>"));

end FVUBaseRecord;
