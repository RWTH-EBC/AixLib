within AixLib.ThermalZones.ReducedOrder.Validation.VDI6007.VDI6007AnhangC1;
model TestCase14 "VDI 6007 Anhang C1 Test case 3.1 model"
  extends Modelica.Icons.Example;
  ThermalZone.ThermalZone thermalZone
    annotation (Placement(transformation(extent={{-310,22},{-290,42}})));
  RC.TwoElements theZon(indoorPortWin=true, indoorPortExtWalls=true)
    annotation (Placement(transformation(extent={{22,16},{70,52}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -100},{160,100}})),                                  Diagram(
        coordinateSystem(                           extent={{-160,-100},{160,
            100}})));
end TestCase14;
