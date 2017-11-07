within AixLib.Airflow.AirHandlingUnit.BaseClasses;
expandable connector BusActors
  "Bus Connector for actors between the physical model and the controller"
  extends Modelica.Icons.SignalBus;

  Real openingY01(min=0, max=1)
    "opening of damper Y01, inlet recuperator supply air";
  Real openingY02(min=0, max=1)
    "opening of damper Y02, bypass recuperator supply air";
  Real openingY03(min=0, max=1)
    "opening of damper Y03, bypass recuperator exhaust air";
  Real openingY04(min=0, max=1) "opening of damper Y04, exit air recuperator";
  Real openingY05(min=0, max=1)
    "opening of damper Y05, outside air on supply side";
  Real openingY06(min=0, max=1)
    "opening of damper Y06, bypass absorber outside air";
  Real openingY07(min=0, max=1)
    "opening of damper Y07, outside air on regeneration side";
  Real openingY08(min=0, max=1)
    "opening of damper Y08, exit air on regeneration side";
  Real openingY09(min=0, max=1)
    "opening of three-way-valve Y09, heating coil after recuperator";
  Real openingY10(min=0, max=1)
    "opening of three-way-valve Y10, heating coil for regeneration";
  Real openingY11(min=0, max=1)
    "input for the humidifier to imitate the evaporation at the recuperator";

  Real outsideFan "real input m_flow for outsideAirFan in kg/s";
  Real exhaustFan "real input m_flow for exhaustAirFan in kg/s";
  Real regenerationFan "real input m_flow for regenerationAirFan in kg/s";
  //eigentlich müsste eine Drehzahl vorgegeben werden!

  Real pumpN04(min=0, max=1) "pump signal for heating coil pump for supply";
  Real pumpN05(min=0, max=1)
    "pump signal for heating coil pump for regeneration";
  Boolean pumpN06 "adiabaticOn signal to activate adiabatic cooling";
  Boolean pumpN07 "absorption On";
  Boolean pumpN08 "desorption/ regeneration On";

  //Real mWatSteamHumid( min=0, max=0.02)
  //                    "setpoint for absolute humidity
  //                      for steam humidifier between 0 and 0.02";
  //Real mWatAbsorber( min=0, max=1)
  //                    "input for dehumidification in absorber";
  //Real mWatDesorber( min=0, max=1)
  //                    "input for humidification in desorber";

end BusActors;
