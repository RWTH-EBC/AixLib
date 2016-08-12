within AixLib.ThermalZones.ReducedOrder.Multizone;
model Multizone
  "Multizone model"
  extends AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone;
  Modelica.Blocks.Interfaces.RealInput ventTemp[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Ventilation and infiltration temperature" annotation (Placement(
        transformation(extent={{-128,-8},{-88,32}}), iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-98,26})));
  Modelica.Blocks.Interfaces.RealInput ventRate[numZones](final
      quantity="VolumeFlowRate", final unit="1/h")
    "Ventilation and infiltration rate" annotation (Placement(transformation(
          extent={{-132,-34},{-92,6}}),  iconTransformation(extent={{-104,-6},{
            -92,6}})));
equation
  connect(zone.ventRate, ventRate) annotation (Line(points={{50.6,43.2},{50.6,
          43.2},{50.6,-14},{-112,-14}},
                                color={0,0,127}));
  connect(ventTemp, zone.ventTemp) annotation (Line(points={{-108,12},{-34,12},
          {-34,47.505},{43.25,47.505}},       color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html>
<ul>
<li><i>June 22, 2015&nbsp;</i> by Moritz Lauster:<br/>Implemented</li>
</ul>
</html>",
        info="<html>
<p>This is a multizone model with a variable number of thermal zones. It adds no further functionalities. The<a href=\"AixLib.Building.LowOrder.Multizone.partialMultizone\"> partial class</a> has a replaceable<a href=\"AixLib.Building.LowOrder.ThermalZone\"> thermal zone</a> model, due to the functionalities, <a href=\"AixLib.Building.LowOrder.ThermalZone.ThermalZone\">ThermalZone</a> is the most suitable recommendation.</p>
</html>"));
end Multizone;
