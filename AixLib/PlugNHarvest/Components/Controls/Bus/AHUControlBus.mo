within AixLib.PlugNHarvest.Components.Controls.Bus;
expandable connector AHUControlBus "Standard data bus for AirHandlingUnit"
  extends Modelica.Icons.SignalBus;

 Real coolingValveOpening(min=0,max=1)
   "Relative opening of the cooling valve (0..100%)";

 Real heatingValveOpening(min=0,max=1)
   "Relative opening of the cooling valve (0..100%)";

 Real fanExhaustAirPower(min=0,max=1)
   "Relative speed of the exhaust air fan (0..100%)";

 Real fanSupplyAirPower(min=0,max=1)
   "Relative speed of the supply air fan (0..100%)";

  Boolean coolerPump_active
   "True, if pump of the cooler should be switched on";

  Boolean heaterPump_active
  "True, if pump of the heater should be switched on";

 Modelica.SIunits.ThermodynamicTemperature roomTemperature
   "Room air temperature measurement";

 Modelica.SIunits.ThermodynamicTemperature outdoorTemperature
   "Outdoor air temperature measurement";

 Modelica.SIunits.ThermodynamicTemperature supplyTemperature
   "Room air temperature measurement";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Definition of a standard bus for an air handling unit</p>
</html>", revisions="<html>
<p>November 2017, by Ana Constantini:</p>
<p>First implementation. </p>
</html>"));

end AHUControlBus;
