within AixLib.Airflow.AirHandlingUnit.BaseClasses;
expandable connector BusActors
  "Bus Connector for actors between the physical model and the controller"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;

  Real openingY01( min=0, max=1)
                                "opening of damper Y01";
  Real openingY02( min=0, max=1)
                                "opening of damper Y02";
  Real openingY03( min=0, max=1)
                                "opening of damper Y03";
  Real openingY04( min=0, max=1)
                                "opening of damper Y04";
  Real openingY05( min=0, max=1)
                                "opening of damper Y05";
  Real openingY06( min=0, max=1)
                                "opening of damper Y06";
  Real openingY07( min=0, max=1)
                                "opening of damper Y07";
  Real openingY08( min=0, max=1)
                                "opening of damper Y08";
  Real outsideFan     "real input m_flow for outsideAirFan in kg/s";
  Real regenerationFan
                      "real input m_flow for regenerationAirFan in kg/s";
  Real exhaustFan     "real input m_flow for exhaustAirFan in kg/s";
  Real mWatSteamHumid( min=0, max=1)
                      "input for steam humidifier between 0 and 1";
  Real mWatAbsorber( min=0, max=1)
                      "input for dehumidification in absorber";
  Real mWatDesorber( min=0, max=1)
                      "input for humidification in desorber";
  Real mWatEvaporator( min=0, max=1)
                      "input for the humidifier to 
                      imitate the evaporation at the recuperator";
  Real openValveHeatCoil( min=0, max=1)
                      "opening of the three way valve in the water
                      circuit at the heating coil";

end BusActors;
