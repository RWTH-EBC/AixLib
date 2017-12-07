within AixLib.Airflow.AirHandlingUnit.BaseClasses;
model steamHumidHeatModel
  "calculates the enthalpy change from steam humidifier"

  parameter Modelica.SIunits.Temperature T_wat = 20+273.15  "Temperature of steam added in K";
  parameter Modelica.SIunits.Temperature T_ref = 273.15 "reference temperature in K";
  parameter Modelica.SIunits.SpecificEnergy lambda = 2453700 "latent heat of evaporation in J/kg";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_w = 4182 "specific heat capacity of water in J/kgK";


  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{88,-10},{108,10}})));
  Modelica.Blocks.Interfaces.RealInput u "amount of steam in kg/s added"
    annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
equation
  port_a.Q_flow = - u * ((T_wat-T_ref) * cp_w + lambda);

end steamHumidHeatModel;
