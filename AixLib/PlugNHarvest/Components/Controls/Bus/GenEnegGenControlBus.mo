within AixLib.PlugNHarvest.Components.Controls.Bus;
expandable connector GenEnegGenControlBus
  "General control data bus for energy generator: (ideal) heater/cooler"
  extends Modelica.Icons.SignalBus;

 Modelica.SIunits.ThermodynamicTemperature setT_supply
   "Set supply temperature for the conditioning medium: water or air";

 Modelica.SIunits.ThermodynamicTemperature setT_room
   "Set room temperature";

 Modelica.SIunits.ThermodynamicTemperature Toutside "outside temperature";

 Boolean isOn
   "is heater on";

 Boolean isNightMode "true if night mode active";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a standard bus for a heater</p>
</html>", revisions="<html>
<p>November 2017, by Ana Constantini:</p>
<p>First implementation. </p>
</html>"));

end GenEnegGenControlBus;
