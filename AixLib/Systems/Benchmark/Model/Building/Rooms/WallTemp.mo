within AixLib.Systems.Benchmark.Model.Building.Rooms;
model WallTemp

  parameter Real AngeFactor=0 annotation(Dialog(tab = "General"));
  AixLib.Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation=0,    origin={-46,0})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-6,-4},{14,16}})));
 AixLib.Utilities.Interfaces.ConvRadComb thermStarComb1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Math.Gain gain(k=AngeFactor)
    annotation (Placement(transformation(extent={{34,-2},{50,14}})));
  Modelica.Blocks.Interfaces.RealOutput WallTempWithFactor
    "Output signal connector"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(thermStar_Demux.portConv, temperatureSensor.port)
    annotation (Line(points={{-35.9,5.1},{-6,5.1},{-6,6}}, color={191,0,0}));
  connect(thermStar_Demux.portConvRadComb, thermStarComb1) annotation (Line(
        points={{-55.8,-1.3},{-100,-1.3},{-100,0}},
                                                  color={191,0,0}));
  connect(temperatureSensor.T, gain.u)
    annotation (Line(points={{14,6},{32.4,6}}, color={0,0,127}));
  connect(gain.y, WallTempWithFactor) annotation (Line(points={{50.8,6},{74,6},
          {74,0},{100,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WallTemp;
