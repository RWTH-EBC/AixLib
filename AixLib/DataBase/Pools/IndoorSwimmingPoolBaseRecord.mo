within AixLib.DataBase.Pools;
record IndoorSwimmingPoolBaseRecord
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Temperature T_pool "Water temperature of swimming pool";
  parameter Modelica.SIunits.Volume V_storage "Usable Volume of water storage, DIN 19643-1";
  parameter Modelica.SIunits.Volume V_pool "Volume of pool water";
  parameter Modelica.SIunits.Area A_pool( min=0)
                                                "Area of water surface of swimming pool";
  parameter Modelica.SIunits.Length d_pool( min=0)
                                             "Average depth of swimming pool";
  parameter Modelica.SIunits.VolumeFlowRate Q(min= 0.001) "Volume Flow Rate";

  parameter Real beta_inUse( final unit="m/s") "Water transfer coefficient during opening hours, VDI 2089";


  parameter Boolean use_poolCover=false "Pool covered during non opening hours";
  parameter Boolean use_partialLoad=false  "Partial load operation implemented for the non opening hours?";
  parameter Modelica.SIunits.VolumeFlowRate Q_night( min=0) "In case of partial load: mass flow rate during non-opening hours, DIN 19643-1";
  parameter Boolean use_waterRecycling= false
                                         "Recycled water used for refilling pool water?";
  parameter Real x_recycling( min=0)   "Percentage of fill water which comes from the recycling unit, DIN 19643-1: <= 0,8";


  parameter Modelica.SIunits.MassFlowRate m_flow_out( min=0.0001)
                                                              "Waterexchange due to people in the pool, DIN 19643-1";

 // Wave mode
  parameter Boolean use_wavePool=false "Is there a wave machine installed?";
  parameter Modelica.SIunits.Length h_wave=0 "Height of generatedwave";
  parameter Modelica.SIunits.Length w_wave=0 "Width of generated wave/ width of wave machine outlet";

 // Exterior Pool Wall - with earth contact - only vertical
  parameter Integer nExt(min = 1) "Number of RC-elements of exterior walls with earth contact";
  parameter Modelica.SIunits.ThermalResistance RExt[nExt](
    each min=Modelica.Constants.small) "Vector of resistors, from port_a to port_b exterior wall with earth contact";
  parameter Modelica.SIunits.ThermalResistance RExtRem(
    min=Modelica.Constants.small) "Resistance of remaining resistor RExtRem between capacitor n and port_b, exterior wall with earth contact";
  parameter Modelica.SIunits.HeatCapacity CExt[nExt](
    each min=Modelica.Constants.small) "Vector of heat capacities, from port_a to port_b, exterior wall with earth contact";
  parameter Modelica.SIunits.Area AExt "Area of exterior pool wall with earth contact";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConExt "Coefficient of heat transfer between the water and exterior pool walls";

  // Interior Pool Walls - vertical and horizontal combined
  parameter Integer nInt(min=1) "Number of RC elements of interior walls";
  parameter Modelica.SIunits.ThermalResistance RInt[nInt](
    each min=Modelica.Constants.small) "Vector of resistors, from port_a to port_b, interior wall";
  parameter Modelica.SIunits.HeatCapacity CInt[nInt](
    each min=Modelica.Constants.small) "Vector of heat capacities, from port_a to port_b, interior wall";
  parameter Modelica.SIunits.Area AInt "Area of interior pool walls ";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConInt "Coefficient of heat transfer between the water and interior pool walls";

  // Pool Floor with earth contact
  parameter Integer nFloor(min = 1) "Number of RC-elements of pool floor with earth contact";
  parameter Modelica.SIunits.ThermalResistance RFloor [nFloor](
    each min=Modelica.Constants.small) "Vector of resistors, from port_a to port_b, pool floor with earth contact";
  parameter Modelica.SIunits.ThermalResistance RFloorRem(
    min=Modelica.Constants.small) "Resistance of remaining resistor RFloorRem between capacitor n and port_b, pool floor with earth contact";
  parameter Modelica.SIunits.HeatCapacity CFloor[nFloor](
    each min=Modelica.Constants.small) "Vector of heat capacities, from port_a to port_b, pool floor, pool floor with earth contact";
  parameter Modelica.SIunits.Area AFloor "Area of pool floor with earth contact";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConFloor "Coefficient of heat transfer between the water and pool floor";



  annotation (Documentation(info="<html>

  This is the base definition of indoor swimming pool records used in <a href=
  \"AixLib.Fluid.Pools.IndoorSwimmingPool\">AixLib.Fluid.Pools.IndoorSwimmingPool</a>.
  It aggregates all parameters at one record to enhance usability,
  exchanging entire datasets and automatic generation of these
  datasets.
<h4>References </h4>
<ul>
<li>German Association of Engineers: Guideline VDI 2089-1, January 2010: Building Services in swimming baths - Indoor Pools</li>
<li>German Institute for Standardization DIN 19643-1, November 2012: Treatment of water of swimming pools and baths - Part 1 General Requirements</li>
<li>Chroistoph Saunus, 2005: Schwimmb&auml;der Planung - Ausf&uuml;hrung - Betrieb</li>
</ul>
</html>"));
end IndoorSwimmingPoolBaseRecord;
