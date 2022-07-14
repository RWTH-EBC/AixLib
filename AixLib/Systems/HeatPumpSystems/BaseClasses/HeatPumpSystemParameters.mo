within AixLib.Systems.HeatPumpSystems.BaseClasses;
record HeatPumpSystemParameters
  "Parameters for design point of a heat pump system"
  parameter Modelica.Units.SI.HeatFlowRate QCon_nominal
    "Nominal heating power of heat pump" annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.Power P_el_nominal
    "Nominal electrical power, used for calculating nominal evaporator heat flow"
    annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.ThermodynamicTemperature TCon_nominal=308.15
    "Nominal supply temperatur of the condenser"
    annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.ThermodynamicTemperature TEva_nominal=283.15
    "Nominal supply temperatur of the evaporator"
    annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.TemperatureDifference dTEva=3
    "Temperature difference at the evaporator"
    annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.TemperatureDifference dTCon=5
    "Temperature difference at the condenser"
    annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cpEva
    "Specific heat capacity of evaportor medium"
    annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure cpCon
    "Specific heat capacity of condenser medium"
    annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.TemperatureDifference dTPinchEva=8
    "Pinch temperature in the evaporator" annotation (Dialog(group="Design"));
  parameter Modelica.Units.SI.TemperatureDifference dTPinchCon=8
    "Pinch temperature in the condenser" annotation (Dialog(group="Design"));
  parameter Real percHeatLoss=0.1
    "Percentage of heat losses in the heat exchangers to the nominal heating power" annotation (Dialog(group="Design"));
  final parameter Modelica.Units.SI.HeatFlowRate QEva_nominal=QCon_nominal -
      P_el_nominal "Nominal thermal power at the evaporator of heat pump"
    annotation (Dialog(group="Design"));
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>October 25, 2018&#160;</i> by Philipp Mehrfeld:<br/>
    Change QEva_nominal from protected to final (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/791\">#791</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Base record used to define standard heat pump system parameters. Used
  in <a href=
  \"modelica://AixLib.Systems.HeatPumpSystems.HeatPumpSystem\">AixLib.Systems.HeatPumpSystems.HeatPumpSystem</a>,
  the parameters of this record are used to estimation the values of
  central heat pump parameters such as heat loss, mass flow rate etc.
</p>
</html>"));
end HeatPumpSystemParameters;
