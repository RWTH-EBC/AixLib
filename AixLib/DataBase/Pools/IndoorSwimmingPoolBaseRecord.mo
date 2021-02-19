within AixLib.DataBase.Pools;
record IndoorSwimmingPoolBaseRecord
  extends Modelica.Icons.Record;


  parameter String name "Name of Pool";
  parameter String poolType "Type of Pool";

  parameter Modelica.SIunits.Length d_pool "Depth of Swimming Pool";
  parameter Modelica.SIunits.Area A_pool "Surface Area of Swimming Pool";
  parameter Modelica.SIunits.Length u_pool "Circumference of Swimming Pool";

  parameter Modelica.SIunits.Temperature T_pool "Temperature of pool";

  parameter Boolean NextToSoil "Does the pool border to soil?";
  parameter Boolean PoolCover "Is the pool covered during non-opening hours?";

  parameter Modelica.SIunits.ThermalConductivity lambda_poolCover "Thermal Conductivity of the pool cover";
  parameter Modelica.SIunits.Length t_poolCover "Thickness of the pool cover";

  parameter Real k "Belastungsfaktor";
  parameter Real N "Nennbelastung";
  parameter Real beta_inUse "Wasserübergangskoeffizient in use";
  parameter Real beta_nonUse "Wasserübergangskoeffizient non-use";

  parameter Modelica.SIunits.Velocity v_Filter "Velocity of Filtering";
  parameter Modelica.SIunits.VolumeFlowRate Q_hygenic "Hygenic motivated Volume Flow Rate";
  parameter Modelica.SIunits.VolumeFlowRate Q_hydraulic "Hydraulic motivated Volume Flow Rate";

  //Wall

   parameter Integer nExt(min = 1) "Number of RC-elements of exterior walls"
    annotation(Dialog(group="Exterior walls"));
  parameter Modelica.SIunits.ThermalResistance RExt[nExt](
    each min=Modelica.Constants.small) "Vector of resistors, from port_a to port_b"
    annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.ThermalResistance RExtRem(
    min=Modelica.Constants.small)
                                 "Resistance of remaining resistor RExtRem between capacitor n and port_b"
     annotation(Dialog(group="Thermal mass"));
  parameter Modelica.SIunits.HeatCapacity CExt[nExt](
    each min=Modelica.Constants.small) "Vector of heat capacities, from port_a to port_b"
    annotation(Dialog(group="Thermal mass"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IndoorSwimmingPoolBaseRecord;
