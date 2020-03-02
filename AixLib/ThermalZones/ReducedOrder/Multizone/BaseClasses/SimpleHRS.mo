within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model SimpleHRS

  parameter Real pinchT=2;
  parameter Real etaHRS= 0.9;
  parameter Integer nZones=2;
  Modelica.Blocks.Interfaces.RealInput Tair[nZones]
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.RealInput Tzone[nZones]
    annotation (Placement(transformation(extent={{-120,-30},{-80,10}})));
  Modelica.Blocks.Interfaces.RealOutput Tinlet[nZones]
    annotation (Placement(transformation(extent={{100,-16},{130,14}})));

equation

  Tinlet =(Tzone - (Tair+pinchT*ones(nZones)))*etaHRS + Tair
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

end SimpleHRS;
