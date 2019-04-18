within AixLib.PlugNHarvest.Components.InternalGains.BaseClasses;
model PartialElectricalEquipment
  Modelica.Blocks.Interfaces.RealInput Schedule "from 0 to 1"
                                                annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}}), iconTransformation(extent = {{-100, -10}, {-80, 10}})));
  Modelica.Blocks.Interfaces.RealOutput Pel "electrical load in W" annotation (
      Placement(transformation(extent={{80,-70},{120,-30}}), iconTransformation(
          extent={{80,-60},{100,-40}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>September, 2072&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>"));
end PartialElectricalEquipment;
