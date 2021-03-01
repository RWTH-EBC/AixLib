within AixLib.DataBase.Pools;
record IndoorSwimmingPoolBaseRecord
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Temperature T_pool "Water temperature of swimming pool";
  parameter Modelica.SIunits.Volume V_storage "Usable Volume of water storage";
  parameter Modelica.SIunits.Area A_pool "Area of water surface of swimming pool";
  parameter Modelica.SIunits.Length d_pool "Depth of swimming pool";
  parameter Modelica.SIunits.VolumeFlowRate Q(min= 0.0001) "Volume Flow Rate";

  parameter Real beta_inUse "Water transfer coefficient during opening hours";
  parameter Real beta_nonUse "Water transfer coefficient during non opening hours";

  parameter Boolean partialLoad  "Partial load operation implemented for the non opening hours?";
  parameter Real x_partialLoad "In case of partial load: percentage of mass flow rate of opening hours, which is active during non-opening hours";
  parameter Boolean poolCover "Pool cover installed for non opening hours?";
  parameter Boolean waterRecycling "Recycled water used for refilling pool water?";
  parameter Real x_recycling "Percentage of fill water which comes from the recycling unit";
  parameter Boolean nextToSoil "Pool bedded into the soil? (or does it abut a room?)";

  parameter Modelica.SIunits.MassFlowRate m_flow_sewer "Waterexchange due to people in the pool";

    //Pool Wall
  parameter Integer nExt(min=1) "Number of RC-elements of exterior walls"
    annotation (Dialog(group="Exterior walls"));
  parameter Modelica.SIunits.ThermalResistance RExt[nExt](each min=Modelica.Constants.small)
    "Vector of resistors, from port_a to port_b"
    annotation (Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.ThermalResistance RExtRem(min=Modelica.Constants.small)
    "Resistance of remaining resistor RExtRem between capacitor n and port_b"
    annotation (Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.HeatCapacity CExt[nExt](each min=Modelica.Constants.small)
    "Vector of heat capacities, from port_a to port_b"
    annotation (Dialog(group="Thermal mass"));

 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IndoorSwimmingPoolBaseRecord;
