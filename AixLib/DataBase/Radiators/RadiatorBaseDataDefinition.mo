within AixLib.DataBase.Radiators;
record RadiatorBaseDataDefinition "Base Data Definition for Radiators"
    extends Modelica.Icons.Record;
  parameter Real NominalPower(unit="W/m")
    "Nominal power of radiator per m at nominal temperatures"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Temperature RT_nom[3]
    "Nominal temperatures (Tin, Tout, Tair) according to DIN-EN 442."
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Pressure PressureDrop
    "Pressure drop coefficient, delta_p[Pa] = PD*m_flow[kg/s]^2";
  parameter Real Exponent
    "Radiator exponent"
    annotation (Dialog(group="Geometry"));
  parameter Real VolumeWater(unit="l/m")
    "Water volume inside radiator per m"
    annotation (Dialog(group="Geometry"));
 parameter Real MassSteel(unit="kg/m")
    "Material mass of radiator per m"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Density DensitySteel=7900
    "Specific density of steel" annotation (Dialog(group="Material"));
  parameter Modelica.Units.SI.SpecificHeatCapacity CapacitySteel=551
    "Specific heat capacity of steel" annotation (Dialog(group="Material"));
  parameter Modelica.Units.SI.ThermalConductivity LambdaSteel=60
    "Thermal conductivity of steel" annotation (Dialog(group="Material"));
  parameter
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.RadiatorType
    Type
    "Type of radiator"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length length "Length of radiator";
  parameter Modelica.Units.SI.Height height "Height of radiator";
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Basic data set for the definition of various radiator models. Values
  are described in the given table below.
</p>
<p>
  Base data definition for record used with <a href=
  \"HVAC.Components.HeatExchanger.Radiator_ML\">HVAC.Components.HeatExchanger.Radiator_ML</a>
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>April, 2016&#160;</i> by Peter Remmen:<br/>
    Moved from SVN to AixLib
  </li>
  <li>
    <i>August 13, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end RadiatorBaseDataDefinition;
