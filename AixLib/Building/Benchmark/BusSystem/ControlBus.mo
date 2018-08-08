within AixLib.Building.Benchmark.BusSystem;
expandable connector ControlBus
  "Control bus that is adapted to the signals connected to it"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;

  // Pump y
  // Generator
  Real Pump_Hotwater_y "Normalized speed of hotwaterpump";
  Real Pump_Warmwater_y "Normalized speed of warmwaterpump";
  Real Pump_Coldwater_y "Normalized speed of coldwaterpump";
  Real Pump_Coldwater_heatpump_y "Normalized speed of coldwaterpump on heatpumpside";
  Real Pump_Warmwater_heatpump_y "Normalized speed of warmwaterpump on heatpumpside";
  Real Pump_Aircooler_y "Normalized speed of aircoolerpump";
  Real Pump_Hotwater_CHP_y "Normalized speed of aircoolerpump";
  //RLT
  Real Pump_RLT_Central_hot_y "Normalized speed of hotwaterpump of the central RLT";
  Real Pump_RLT_OpenPlanOffice_hot_y "Normalized speed of hotwaterpump of the openplanoffice RLT";
  Real Pump_RLT_ConferenceRoom_hot_y "Normalized speed of hotwaterpump of the conferenceroom RLT";
  Real Pump_RLT_MultiPersonOffice_hot_y "Normalized speed of hotwaterpump of the multipersonoffice RLT";
  Real Pump_RLT_Canteen_hot_y "Normalized speed of hotwaterpump of the canteen RLT";
  Real Pump_RLT_Workshop_hot_y "Normalized speed of hotwaterpump of the workshop RLT";
  Real Pump_RLT_Central_cold_y "Normalized speed of coldwaterpump of the central RLT";
  Real Pump_RLT_OpenPlanOffice_cold_y "Normalized speed of coldwaterpump of the openplanoffice RLT";
  Real Pump_RLT_ConferenceRoom_cold_y "Normalized speed of coldwaterpump of the conferenceroom RLT";
  Real Pump_RLT_MultiPersonOffice_cold_y "Normalized speed of coldwaterpump of the multipersonoffice RLT";
  Real Pump_RLT_Canteen_cold_y "Normalized speed of coldwaterpump of the canteen RLT";
  Real Pump_RLT_Workshop_cold_y "Normalized speed of coldwaterpump of the workshop RLT";
  // TBA
  Real Pump_TBA_OpenPlanOffice_y "Normalized speed of waterpump of the openplanoffice TBA";
  Real Pump_TBA_ConferenceRoom_y "Normalized speed of waterpump of the conferenceroom TBA";
  Real Pump_TBA_MultiPersonOffice_y "Normalized speed of waterpump of the multipersonoffice TBA";
  Real Pump_TBA_Canteen_y "Normalized speed of waterpump of the canteen TBA";
  Real Pump_TBA_Workshop_y "Normalized speed of waterpump of the workshop TBA";

  // Fan m_flow
  Real Fan_Aircooler "Massflow of the Aircoolerfan";
  Real Fan_RLT "Massflow of the RLT-fan";

  // Valvepositions
  Real Valve1 "Valveposition of Valve1 (Coldwater geothermalprobe)";
  Real Valve2 "Valveposition of Valve2 (Coldwater coldwater bufferstorage)";
  Real Valve3 "Valveposition of Valve3 (Coldwater heatexchanger)";
  Real Valve4 "Valveposition of Valve4 (Warmwater heatexchanger)";
  Real Valve5 "Valveposition of Valve5 (Warmwater warmwater bufferstorage)";
  Real Valve6 "Valveposition of Valve6 (Hotwater boiler)";
  Real Valve7 "Valveposition of Valve7 (Hotwater warmwater bufferstorage)";
  Real Valve8 "Valveposition of Valve8 (Aircooler)";

  Real Valve_RLT_Hot_Central "Valveposition to control the hotwater-temperatur to the Central";
  Real Valve_RLT_Hot_OpenPlanOffice "Valveposition to control the hotwater-temperatur to the OpenPlanOffice";
  Real Valve_RLT_Hot_ConferenceRoom "Valveposition to control the hotwater-temperatur to the ConferenceRoom";
  Real Valve_RLT_Hot_MultiPersonOffice "Valveposition to control the hotwater-temperatur to the MultiPersonOffice";
  Real Valve_RLT_Hot_Canteen "Valveposition to control the hotwater-temperatur to the canteen";
  Real Valve_RLT_Hot_Workshop "Valveposition to control the hotwater-temperatur to the workshop";
  Real Valve_RLT_Cold_Central "Valveposition to control the coldwater-temperatur to the Central";
  Real Valve_RLT_Cold_OpenPlanOffice "Valveposition to control the coldwater-temperatur to the OpenPlanOffice";
  Real Valve_RLT_Cold_ConferenceRoom "Valveposition to control the coldwater-temperatur to the ConferenceRoom";
  Real Valve_RLT_Cold_MultiPersonOffice "Valveposition to control the coldwater-temperatur to the MultiPersonOffice";
  Real Valve_RLT_Cold_Canteen "Valveposition to control the coldwater-temperatur to the canteen";
  Real Valve_RLT_Cold_Workshop "Valveposition to control the coldwater-temperatur to the workshop";

  Real Valve_TBA_WarmCold_OpenPlanOffice_1 "Valveposition of Valve 1 for warm or cold of the openplanoffice";
  Real Valve_TBA_WarmCold_OpenPlanOffice_2 "Valveposition of Valve 2 for warm or cold of the openplanoffice";
  Real Valve_TBA_WarmCold_conferenceroom_1 "Valveposition of Valve 1 for warm or cold of the conferenceroom";
  Real Valve_TBA_WarmCold_conferenceroom_2 "Valveposition of Valve 2 for warm or cold of the conferenceroom";
  Real Valve_TBA_WarmCold_multipersonoffice_1 "Valveposition of Valve 1 for warm or cold of the multipersonoffice";
  Real Valve_TBA_WarmCold_multipersonoffice_2 "Valveposition of Valve 2 for warm or cold of the multipersonoffice";
  Real Valve_TBA_WarmCold_canteen_1 "Valveposition of Valve 1 for warm or cold of the canteen";
  Real Valve_TBA_WarmCold_canteen_2 "Valveposition of Valve 2 for warm or cold of the canteen";
  Real Valve_TBA_WarmCold_workshop_1 "Valveposition of Valve 1 for warm or cold of the workshop";
  Real Valve_TBA_WarmCold_workshop_2 "Valveposition of Valve 2 for warm or cold of the workshop";

  Real Valve_TBA_Cold_OpenPlanOffice_Temp "Valveposition to control the temperatur to the OpenPlanOffice";
  Real Valve_TBA_Cold_ConferenceRoom_Temp "Valveposition to control the temperatur to the ConferenceRoom";
  Real Valve_TBA_Cold_MultiPersonOffice_Temp "Valveposition to control the temperatur to the MultiPersonOffice";
  Real Valve_TBA_Cold_Canteen_Temp "Valveposition to control the temperatur to the canteen";
  Real Valve_TBA_Cold_Workshop_Temp "Valveposition to control the temperatur to the workshop";

  // On/Off components
  Boolean OnOff_heatpump_small "On/Off Signal for the small heatpump";
  Boolean OnOff_heatpump_big "On/Off Signal for the big heatpump";
  Boolean OnOff_CHP   "On/Off Signal for the CHP";
  Boolean OnOff_boiler "On/Off Signal for the boiler";

  // Setpoints for components
  Real ElSet_CHP "Electrical Power Setpoint CHP";
  Real TSet_CHP "Temperatur Setpoint CHP";
  Real TSet_boiler "Temperatur Setpoint boiler";

  // Moisterlevel
  Real X_OpenPlanOffice "Moisterlevel for the RLT of the openplanoffice";
  Real X_ConfernceRoom "Moisterlevel for the RLT of the conferenceroom";
  Real X_MultiPersonRoom "Moisterlevel for the RLT of the multipersonoffice";
  Real X_Canteen "Moisterlevel for the RLT of the canteen";
  Real X_Workshop "Moisterlevel for the RLT of the workshop";
  Real X_Central "Moisterlevel for the central RLT";
end ControlBus;
