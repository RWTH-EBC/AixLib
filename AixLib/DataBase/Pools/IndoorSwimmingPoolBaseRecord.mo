within AixLib.DataBase.Pools;
record IndoorSwimmingPoolBaseRecord
  extends Modelica.Icons.Record;

  parameter Modelica.SIunits.Temperature T_pool "Water temperature of swimming pool";
  parameter Modelica.SIunits.Volume V_storage "Usable Volume of water storage";
  parameter Modelica.SIunits.Area A_pool( min=0)
                                                "Area of water surface of swimming pool";
  parameter Modelica.SIunits.Length d_pool( min=0)
                                                  "Depth of swimming pool";
  parameter Modelica.SIunits.VolumeFlowRate Q(min= 0.001) "Volume Flow Rate";

  parameter Real beta_inUse( min=28) "Water transfer coefficient during opening hours";
  parameter Real beta_nonUse( min=0.7)
                                      "Water transfer coefficient during non opening hours";

  parameter Boolean partialLoad=false  "Partial load operation implemented for the non opening hours?";
  parameter Real x_partialLoad( min=0) "In case of partial load: percentage of mass flow rate of opening hours, which is active during non-opening hours";
  parameter Boolean poolCover= false "Pool cover installed for non opening hours?";
  parameter Boolean waterRecycling= false
                                         "Recycled water used for refilling pool water?";
  parameter Real x_recycling( min=0)
                                    "Percentage of fill water which comes from the recycling unit";

  parameter Boolean nextToSoil= false
                                     "Pool bedded into the soil? (or does it abut a room?)";

  parameter Modelica.SIunits.MassFlowRate m_flow_sewer( min=0.0001)
                                                              "Waterexchange due to people in the pool";

    //Pool Wall
  parameter Integer nPool(min=1) "Number of RC-elements of exterior walls"
    annotation (Dialog(group="Exterior walls"));
  parameter Modelica.SIunits.ThermalResistance RPool[nPool](each min=Modelica.Constants.small)
    "Vector of resistors, from port_a to port_b"
    annotation (Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.ThermalResistance RPoolRem(min=Modelica.Constants.small)
    "Resistance of remaining resistor RExtRem between capacitor n and port_b"
    annotation (Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.HeatCapacity CPool[nPool](each min=Modelica.Constants.small)
    "Vector of heat capacities, from port_a to port_b"
    annotation (Dialog(group="Thermal mass"));


end IndoorSwimmingPoolBaseRecord;
