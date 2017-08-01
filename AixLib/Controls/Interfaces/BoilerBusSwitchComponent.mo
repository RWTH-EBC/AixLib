within AixLib.Controls.Interfaces;
model BoilerBusSwitchComponent
  "Switches between several signalBus outputs, signal between component and controller"

  parameter Integer n=5 "number of switchable ports";

  Boiler.BaseClasses.BoilerControllerBus
                           signalBus
    annotation (Placement(transformation(extent={{-20,-118},{20,-78}})));
  Boiler.BaseClasses.BoilerControllerBus
                             signalBusVector[n]
    annotation (Placement(transformation(extent={{-20,78},{20,118}})));

  // Passthroughs are needed between the Busses for the definition of in- and outputs
  //signals from controller to component, routing can switch between the controllers
  Modelica.Blocks.Routing.RealPassThrough Bus_PLR[n+1];
  Modelica.Blocks.Routing.RealPassThrough Bus_Tambient[n+1];
  Modelica.Blocks.Routing.RealPassThrough Bus_Tset[n+1];

  // signals from component to controller (no switching needed)
  Modelica.Blocks.Routing.RealPassThrough Bus_Pgas;
  Modelica.Blocks.Routing.RealPassThrough Bus_Qflow;
  Modelica.Blocks.Routing.RealPassThrough Bus_m_flow;
  Modelica.Blocks.Routing.RealPassThrough Bus_Tin;
  Modelica.Blocks.Routing.RealPassThrough Bus_Tout;

  Modelica.Blocks.Interfaces.IntegerInput u annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-76,100})));
equation
  //connections of signalBus (connection to component) and passthroughs
  connect(signalBus.PLR,Bus_PLR[n+1].y);
  connect(signalBus.Tambient,Bus_Tambient[n+1].y);
  connect(signalBus.Tset,Bus_Tset[n+1].y);

  connect(signalBus.Pgas,Bus_Pgas.u);
  connect(signalBus.Qflow,Bus_Qflow.u);
  connect(signalBus.m_flow,Bus_m_flow.u);
  connect(signalBus.Tin,Bus_Tin.u);
  connect(signalBus.Tout,Bus_Tout.u);



  //connections between signalBusVector and passthroughs
  for i in 1:n loop
    //connections passthrough and signalBusVector inputs
  connect(signalBusVector[i].PLR, Bus_PLR[i].u);
  connect(signalBusVector[i].Tambient, Bus_Tambient[i].u);
  connect(signalBusVector[i].Tset, Bus_Tset[i].u);
    //connections passthrough and signalBusVector outputs
  connect(signalBusVector[i].Pgas,Bus_Pgas.y);
  connect(signalBusVector[i].Qflow,Bus_Qflow.y);
  connect(signalBusVector[i].m_flow,Bus_m_flow.y);
  connect(signalBusVector[i].Tin,Bus_Tin.y);
  connect(signalBusVector[i].Tout,Bus_Tout.y);
  end for;

  //switchable outputs for sinlge bus
    if u<=n then
      Bus_PLR[n+1].u = Bus_PLR[u].y;
      Bus_Tambient[n+1].u = Bus_Tambient[u].y;
      Bus_Tset[n+1].u = Bus_Tset[u].y;
    else
      Bus_PLR[n+1].u = Bus_PLR[n].y;
      Bus_Tambient[n+1].u = Bus_Tambient[n].y;
      Bus_Tset[n+1].u = Bus_Tset[n].y;
    end if;

  //all booleans and integer variables

end BoilerBusSwitchComponent;
