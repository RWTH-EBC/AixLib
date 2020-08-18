within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model InfiltrationToMassflow
parameter Integer nZones=2;
parameter Real zoneVolume[nZones];
  Modelica.Blocks.Interfaces.RealInput infiltration[nZones]
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow[nZones]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation

  m_flow = infiltration ./ (3600*ones(nZones)) .* (1.2*ones(nZones)) .* zoneVolume
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));


end InfiltrationToMassflow;
