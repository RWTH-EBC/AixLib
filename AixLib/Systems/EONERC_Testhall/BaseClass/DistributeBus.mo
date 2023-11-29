within AixLib.Systems.EONERC_Testhall.BaseClass;
expandable connector DistributeBus "Distribute Data Bus"
  extends Modelica.Icons.SignalBus;
  import      Modelica.Units.SI;


  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cca;
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cph;
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus
    bus_cph_throttle;
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cid;
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_jn;
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_dhs;
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus
    bus_dhs_pump;

end DistributeBus;
