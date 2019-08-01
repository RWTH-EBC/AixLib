within AixLib.Systems.Benchmark.Model.BusSystems;
expandable connector InternalBus
  "Control bus that is adapted to the signals connected to it"
  extends Modelica.Icons.SignalBus;
  import SI = Modelica.SIunits;

  //InternalLoads
  SI.HeatFlowRate InternalLoads_QFlow_Workshop;
  SI.MassFlowRate InternalLoads_MFlow_Openplanoffice;
  SI.MassFlowRate InternalLoads_MFlow_Conferenceroom;
  SI.MassFlowRate InternalLoads_MFlow_Multipersonoffice;
  SI.MassFlowRate InternalLoads_MFlow_Canteen;
  SI.MassFlowRate InternalLoads_MFlow_Workshop;

  //Weather
  Real InternalLoads_Wind_Speed_Hor;
  Real InternalLoads_Wind_Speed_North;
  Real InternalLoads_Wind_Speed_East;
  Real InternalLoads_Wind_Speed_South;
  Real InternalLoads_Wind_Speed_West;

end InternalBus;
