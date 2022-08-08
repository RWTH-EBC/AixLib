within AixLib.DataBase.ActiveWalls;
record ActiveWallBaseDataDefinition "Base data definition for active walls"
extends Modelica.Icons.Record;
  parameter Modelica.Units.SI.Temperature Temp_nom[3]
    "Nominal Temperatures T_flow, T_return, T_room / air ";
  parameter Modelica.Units.SI.HeatFlux q_dot_nom
    "nominal Power per square meter";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_isolation
    "k_isolation of whole FH Layer";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_top
    "Heat transfer coefficient for layers above tubes";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_down
    "Heat transfer coefficient for layers underneath tubes";
parameter Real VolumeWaterPerMeter(unit="l/m") "Water volume";
  parameter Modelica.Units.SI.Length Spacing "Spacing of Pipe";
  parameter Modelica.Units.SI.Emissivity eps "Emissivity of Floor";
parameter AixLib.Fluid.HeatExchangers.ActiveWalls.BaseClasses.HeatCapacityPerArea C_ActivatedElement = 50000;
parameter Real c_top_ratio;
parameter Real PressureDropExponent;
parameter Real PressureDropCoefficient;

annotation (Documentation(revisions="<html><ul>
  <li>
    <i>February 14, 2014&#160;</i> by Ana Constantin:<br/>
    Changed name of heat capacity per are to C_Activated Element, to be
    able to use it for both heating and cooling.
  </li>
  <li>
    <i>September 20, 2013&#160;</i> by Mark Wesseling:<br/>
    Implemented.
  </li>
</ul>
</html>",
        info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Base record for Active Walls (Ceiling and Floor) models.
</p>
<p>
  Defines heat exchange properties and storage capacity of the active
  part of the wall.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Base data definition for record used with <a href=
  \"EBC.HVAC.Components.ActiveWalls.Panelheating_1D_Dis\">EBC.HVAC.Components.ActiveWalls.Panelheating_1D_Dis</a>
</p>
</html>"));

end ActiveWallBaseDataDefinition;
