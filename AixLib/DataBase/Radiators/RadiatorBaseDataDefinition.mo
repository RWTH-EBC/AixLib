within AixLib.DataBase.Radiators;
record RadiatorBaseDataDefinition "Base Data Definition for Radiators"
    extends Modelica.Icons.Record;
  parameter Real NominalPower=1000
    "Nominal power of radiator per m at nominal temperatures in W/m "
    annotation (Dialog(group="Geometry"));
  parameter Modelica.SIunits.Temp_C RT_nom[3]={75,65,20}
    "nominal temperatures (Tin, Tout, Tair) according to DIN-EN 442." annotation (Dialog(group="Geometry"));
  parameter Real PressureDrop = 548208
    "Pressure drop coefficient, delta_p[Pa] = PD*m_flow[kg/s]^2";
  parameter Real Exponent=1.29 annotation (Dialog(group="Geometry"));
  parameter Real VolumeWater(unit="l/m")=20
    "Water volume inside radiator per m, in l/m"
    annotation (Dialog(group="Geometry"));
 parameter Real MassSteel(unit="kg/m")=30
    "Material mass of radiator per m, in kg/m"
    annotation (Dialog(group="Geometry"));
parameter Modelica.SIunits.Density DensitySteel=7900
    "Specific density of steel, in kg/m3"
    annotation (Dialog(group="Material"));
  parameter Modelica.SIunits.SpecificHeatCapacity CapacitySteel=551
    "Specific heat capacity of steel, in J/kgK"
    annotation (Dialog(group="Material"));
  parameter Modelica.SIunits.ThermalConductivity LambdaSteel=60
    "Thermal conductivity of steel, in W/mK"
    annotation (Dialog(group="Material"));
  parameter
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.RadiatorType
                                                                     Type=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator10
    "Type of radiator"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.SIunits.Length length=1 "length of radiator";
  parameter Modelica.SIunits.Height height=0.6 "height of radiator";
  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Basic data set for the definition of various radiator models. Values are described in the given table below. </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Base data definition for record used with <a href=\"HVAC.Components.HeatExchanger.Radiator_ML\">HVAC.Components.HeatExchanger.Radiator_ML</a></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>April, 2016&nbsp;</i> by Peter Remmen:<br/>Moved from SVN to AixLib</li>
<li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>"));
end RadiatorBaseDataDefinition;
