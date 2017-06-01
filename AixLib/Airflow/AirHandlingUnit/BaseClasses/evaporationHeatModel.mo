within AixLib.Airflow.AirHandlingUnit.BaseClasses;
model evaporationHeatModel
  "calculates the heat exchange through evaporation in the recuperator"


  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{88,-10},{108,10}})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
equation
  port_a.Q_flow=2000;





end evaporationHeatModel;
