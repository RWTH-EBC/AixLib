within AixLib.Building.Benchmark.BusSystem;
expandable connector measureBus
  "Control bus that is adapted to the signals connected to it"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;
  // Weather
  SI.Temp_K AirTemp;
  Real WaterInAir;

  //Storage
  SI.Temp_K HotWater_TTop "Temperatur at the top of the hotwater-bufferstorage";
  SI.Temp_K HotWater_TBottom "Temperatur at the bottom of the hotwater-bufferstorage";
  SI.Temp_K WarmWater_TTop "Temperatur at the top of the warmwater-bufferstorage";
  SI.Temp_K WarmWater_TBottom "Temperatur at the bottom of the warmwater-bufferstorage";
  SI.Temp_K ColdWater_TTop "Temperatur at the top of the coldwater-bufferstorage";
  SI.Temp_K ColdWater_TBottom "Temperatur at the bottom of the coldwater-bufferstorage";

  //Measured Temperatures
  SI.Temp_K Heatpump_cold_big_in;
  SI.Temp_K Heatpump_cold_small_out;
  SI.Temp_K Heatpump_warm_big_out;
  SI.Temp_K Heatpump_warm_small_in;
  SI.Temp_K Aircooler_in;
  SI.Temp_K Aircooler_out;
  SI.Temp_K GeothermalProbe_in;
  SI.Temp_K GeothermalProbe_out;
  SI.Temp_K generation_hot_in;
  SI.Temp_K generation_hot_out;

  //MassflowRates
  SI.MassFlowRate heatpump_cold_massflow;
  SI.MassFlowRate heatpump_warm_massflow;
  SI.MassFlowRate Aircooler_massflow;
  SI.MassFlowRate generation_hot_massflow;

  //Power
  SI.Power Pump_Warmwater_heatpump_power "Power of warmwater heatpump pump";
  SI.Power Heatpump_small_power "Power of small heatpump";
  SI.Power Heatpump_big_power "Power of big heatpump";
  SI.Power Pump_generation_hot_power;
  SI.Power Pump_Coldwater_heatpump_power;
  SI.Power Pump_Coldwater_power;
  SI.Power Pump_Warmwater_power;
  SI.Power Pump_Hotwater_power;
  Real Electrical_power_CHP;

  //COP
  Real Heatpump_small_COP;
  Real Heatpump_big_COP;
end measureBus;
