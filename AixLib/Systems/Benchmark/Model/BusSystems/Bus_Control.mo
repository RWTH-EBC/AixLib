within AixLib.Systems.Benchmark.Model.BusSystems;
expandable connector Bus_Control
  "Control bus that is adapted to the signals connected to it"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;

  // Pump y
  // Generator
  Real Pump_Hotwater_y "Normalized speed of hotwaterpump" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_Warmwater_y "Normalized speed of warmwaterpump" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_Coldwater_y "Normalized speed of coldwaterpump" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_Coldwater_heatpump_y "Normalized speed of coldwaterpump on heatpumpside" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_Warmwater_heatpump_1_y "Normalized speed of warmwaterpump on heatpumpside" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_Warmwater_heatpump_2_y "Normalized speed of warmwaterpump on heatpumpside" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_Aircooler_y "Normalized speed of aircoolerpump" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_Hotwater_CHP_y "Normalized speed of aircoolerpump" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_Hotwater_Boiler_y "Normalized speed of aircoolerpump" annotation (__Dymola_Tag={"ControlBus"});

  //RLT
  Real Pump_RLT_Central_hot_y "Normalized speed of hotwaterpump of the central RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_OpenPlanOffice_hot_y "Normalized speed of hotwaterpump of the openplanoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_ConferenceRoom_hot_y "Normalized speed of hotwaterpump of the conferenceroom RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_MultiPersonOffice_hot_y "Normalized speed of hotwaterpump of the multipersonoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_Canteen_hot_y "Normalized speed of hotwaterpump of the canteen RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_Workshop_hot_y "Normalized speed of hotwaterpump of the workshop RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_Central_cold_y "Normalized speed of coldwaterpump of the central RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_OpenPlanOffice_cold_y "Normalized speed of coldwaterpump of the openplanoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_ConferenceRoom_cold_y "Normalized speed of coldwaterpump of the conferenceroom RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_MultiPersonOffice_cold_y "Normalized speed of coldwaterpump of the multipersonoffice RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_Canteen_cold_y "Normalized speed of coldwaterpump of the canteen RLT" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_RLT_Workshop_cold_y "Normalized speed of coldwaterpump of the workshop RLT" annotation (__Dymola_Tag={"ControlBus"});

  // TBA
  Real Pump_TBA_OpenPlanOffice_y "Normalized speed of waterpump of the openplanoffice TBA" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_TBA_ConferenceRoom_y "Normalized speed of waterpump of the conferenceroom TBA" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_TBA_MultiPersonOffice_y "Normalized speed of waterpump of the multipersonoffice TBA" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_TBA_Canteen_y "Normalized speed of waterpump of the canteen TBA" annotation (__Dymola_Tag={"ControlBus"});
  Real Pump_TBA_Workshop_y "Normalized speed of waterpump of the workshop TBA" annotation (__Dymola_Tag={"ControlBus"});

  // Fan m_flow
  Boolean OnOff_RLT "On/Off Signal for the RLT fan" annotation (__Dymola_Tag={"ControlBus"});
  Boolean OnOff_Aircooler_small "On/Off Signal for the aircooler fan" annotation (__Dymola_Tag={"ControlBus"});
  Boolean OnOff_Aircooler_big "On/Off Signal for the aircooler fan" annotation (__Dymola_Tag={"ControlBus"});
  Real Fan_Aircooler_small "Normalized Massflow of Aircooler" annotation (__Dymola_Tag={"ControlBus"});
  Real Fan_Aircooler_big "Normalized Massflow of Aircooler" annotation (__Dymola_Tag={"ControlBus"});
  Real Fan_RLT "Normalized Massflow of the RLT-fan" annotation (__Dymola_Tag={"ControlBus"});

  // Valvepositions
  Real Valve1 "Valveposition of Valve1 (Coldwater geothermalprobe)" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve2 "Valveposition of Valve2 (Coldwater coldwater bufferstorage)" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve3 "Valveposition of Valve3 (Coldwater heatexchanger)" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve4 "Valveposition of Valve4 (Warmwater heatexchanger)" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve5 "Valveposition of Valve5 (Warmwater warmwater bufferstorage)" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve6 "Valveposition of Valve6 (Hotwater boiler)" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve7 "Valveposition of Valve7 (Hotwater warmwater bufferstorage)" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve8 "Valveposition of Valve8 (Aircooler)" annotation (__Dymola_Tag={"ControlBus"});

  Real Valve_RLT_Hot_Central "Valveposition to control the hotwater-temperatur to the Central" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Hot_OpenPlanOffice "Valveposition to control the hotwater-temperatur to the OpenPlanOffice" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Hot_ConferenceRoom "Valveposition to control the hotwater-temperatur to the ConferenceRoom" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Hot_MultiPersonOffice "Valveposition to control the hotwater-temperatur to the MultiPersonOffice" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Hot_Canteen "Valveposition to control the hotwater-temperatur to the canteen" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Hot_Workshop "Valveposition to control the hotwater-temperatur to the workshop" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Cold_Central "Valveposition to control the coldwater-temperatur to the Central" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Cold_OpenPlanOffice "Valveposition to control the coldwater-temperatur to the OpenPlanOffice" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Cold_ConferenceRoom "Valveposition to control the coldwater-temperatur to the ConferenceRoom" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Cold_MultiPersonOffice "Valveposition to control the coldwater-temperatur to the MultiPersonOffice" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Cold_Canteen "Valveposition to control the coldwater-temperatur to the canteen" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_RLT_Cold_Workshop "Valveposition to control the coldwater-temperatur to the workshop" annotation (__Dymola_Tag={"ControlBus"});

  Real Valve_TBA_Warm_OpenPlanOffice "Valveposition of Valve 1 for warm or cold of the openplanoffice" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_TBA_Warm_conferenceroom "Valveposition of Valve 1 for warm or cold of the conferenceroom" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_TBA_Warm_multipersonoffice "Valveposition of Valve 1 for warm or cold of the multipersonoffice" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_TBA_Warm_canteen "Valveposition of Valve 1 for warm or cold of the canteen" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_TBA_Warm_workshop "Valveposition of Valve 1 for warm or cold of the workshop" annotation (__Dymola_Tag={"ControlBus"});

  Real Valve_TBA_OpenPlanOffice_Temp "Valveposition to control the temperatur to the OpenPlanOffice" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_TBA_ConferenceRoom_Temp "Valveposition to control the temperatur to the ConferenceRoom" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_TBA_MultiPersonOffice_Temp "Valveposition to control the temperatur to the MultiPersonOffice" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_TBA_Canteen_Temp "Valveposition to control the temperatur to the canteen" annotation (__Dymola_Tag={"ControlBus"});
  Real Valve_TBA_Workshop_Temp "Valveposition to control the temperatur to the workshop" annotation (__Dymola_Tag={"ControlBus"});

  // On/Off components
  Boolean OnOff_heatpump_1 "On/Off Signal for the first heatpump" annotation (__Dymola_Tag={"ControlBus"});
  Boolean OnOff_heatpump_2 "On/Off Signal for the second heatpump" annotation (__Dymola_Tag={"ControlBus"});
  Boolean OnOff_CHP   "On/Off Signal for the CHP" annotation (__Dymola_Tag={"ControlBus"});
  Boolean OnOff_boiler "On/Off Signal for the boiler" annotation (__Dymola_Tag={"ControlBus"});

  // Setpoints for components
  Real ElSet_CHP "Electrical Power Setpoint CHP" annotation (__Dymola_Tag={"ControlBus"});
  Real TSet_CHP "Temperatur Setpoint CHP" annotation (__Dymola_Tag={"ControlBus"});
  Real TSet_boiler "Temperatur Setpoint boiler" annotation (__Dymola_Tag={"ControlBus"});

  // Moisterlevel
  Real X_Central "Moisterlevel for the central RLT" annotation (__Dymola_Tag={"ControlBus"});
end Bus_Control;
