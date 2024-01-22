within AixLib.Controls.Interfaces;
expandable connector FVUControlBus
  "Standard data bus for facade ventilation units"
  extends Modelica.Icons.SignalBus;

 Real coolingValveOpening(min=0,max=1)
   "Relative opening of the cooling valve (0..1)";

 Real heatingValveOpening(min=0,max=1)
   "Relative opening of the cooling valve (0..1)";

 Real fanExhaustAirPower(min=0,max=1)
   "Relative speed of the exhaust air fan (0..1)";

 Real fanSupplyAirPower(min=0,max=1)
   "Relative speed of the supply air fan (0..1)";

 Real circulationDamperOpening(min=0,max=1)
   "Relative opening of the circulation damper (0..1)";

 Real hRCDamperOpening(min=0,max=1)
   "Relative opening of the heat recovery damper (0..1)";

 Real freshAirDamperOpening(min=0,max=1)
   "Relative opening of thefresh air damper (0..1)";

  Modelica.Units.SI.ThermodynamicTemperature roomTemperature
    "Room air temperature measurement";

  Modelica.Units.SI.ThermodynamicTemperature outdoorTemperature
    "Outdoor air temperature measurement";

  Modelica.Units.SI.ThermodynamicTemperature roomSetTemperature
    "Room air set temperature measurement";

 Real co2Concentration(min=0)
   "CO2 concentration measurement in ppm";

  Modelica.Units.SI.ThermodynamicTemperature mixTemperature
    "Temperature measurement of the mixed circulation and fresh air streams";

  Modelica.Units.SI.ThermodynamicTemperature supplyTemperature
    "Temperature measurement of the supply air streams";



  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Definition of a standard bus that contains basic data points that
  appear facade ventilation units.
</p>
<p>
  July 2017, by Marc Baranski:
</p>
<p>
  First implementation.
</p>
</html>"));


end FVUControlBus;
