within AixLib.Systems.TABS.BaseClasses;
expandable connector TabsBus "Data bus for tabs"
  extends Modelica.Icons.SignalBus;
  import      Modelica.Units.SI;
  HydraulicModules.BaseClasses.HydraulicBus pumpBus  "Hydraulic circuit of concrete core activation";
  HydraulicModules.BaseClasses.HydraulicBus hotThrottleBus  "Hydraulic circuit of hot supply";
  HydraulicModules.BaseClasses.HydraulicBus coldThrottleBus "Hydraulic circuit of cold supply";
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(graphics,
            coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a bus connector for the Tabs Module.</p>
</html>", revisions="<html>
<ul>
<li>December 09, 2021, by Alexander K&uuml;mpel:<br>First implementation.</li>
</ul>
</html>"));
end TabsBus;
