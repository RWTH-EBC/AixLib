within AixLib.Controls.Interfaces;
model BoilerBusSwitchBMS
  "Switches between several signalBus outputs, sognal between BMS and controller"

  parameter Integer n=5 "number of switchable ports";

  Boiler.BaseClasses.BoilerControllerBus
                           signalBus
    annotation (Placement(transformation(extent={{-20,78},{20,118}})));
  Boiler.BaseClasses.BoilerControllerBus
                             signalBusVector[n]
    annotation (Placement(transformation(extent={{-20,-118},{20,-78}})));

  // Passthroughs are needed between the Busses for the definition of in- and outputs
  //signals from controller to BMS, routing can switch between the controllers
  Modelica.Blocks.Routing.RealPassThrough Bus_Pgas[n+1];
  Modelica.Blocks.Routing.RealPassThrough Bus_Qflow[n+1];
  Modelica.Blocks.Routing.RealPassThrough Bus_m_flow[n+1];
  Modelica.Blocks.Routing.RealPassThrough Bus_Tin[n+1];
  Modelica.Blocks.Routing.RealPassThrough Bus_Tout[n+1];

  // signals from BMS to controller (no switching needed)
  Modelica.Blocks.Routing.RealPassThrough Bus_PLR;
  Modelica.Blocks.Routing.RealPassThrough Bus_Tambient;
  Modelica.Blocks.Routing.RealPassThrough Bus_Tset;

  Modelica.Blocks.Interfaces.IntegerInput u annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-76,100})));

equation
  //connections of signalBus (connection to BMS) and passthroughs
  connect(signalBus.Pgas,Bus_Pgas[n+1].y);
  connect(signalBus.Qflow,Bus_Qflow[n+1].y);
  connect(signalBus.m_flow,Bus_m_flow[n+1].y);
  connect(signalBus.Tin,Bus_Tin[n+1].y);
  connect(signalBus.Tout,Bus_Tout[n+1].y);

  connect(signalBus.PLR,Bus_PLR.u);
  connect(signalBus.Tambient,Bus_Tambient.u);
  connect(signalBus.Tset,Bus_Tset.u);



  //connections between signalBusVector and passthroughs
  for i in 1:n loop
    //connections passthrough and signalBusVector inputs
  connect(signalBusVector[i].Pgas,Bus_Pgas[i].u);
  connect(signalBusVector[i].Qflow,Bus_Qflow[i].u);
  connect(signalBusVector[i].m_flow,Bus_m_flow[i].u);
  connect(signalBusVector[i].Tin,Bus_Tin[i].u);
  connect(signalBusVector[i].Tout,Bus_Tout[i].u);

    //connections passthrough and signalBusVector outputs
  connect(signalBusVector[i].PLR, Bus_PLR.y);
  connect(signalBusVector[i].Tambient, Bus_Tambient.y);
  connect(signalBusVector[i].Tset, Bus_Tset.y);
  end for;


  //switchable outputs for sinlge bus
    if u<=n then
      Bus_Pgas[n+1].u = Bus_Pgas[u].y;
      Bus_Qflow[n+1].u = Bus_Qflow[u].y;
      Bus_m_flow[n+1].u = Bus_m_flow[u].y;
      Bus_Tin[n+1].u = Bus_Tin[u].y;
      Bus_Tout[n+1].u = Bus_Tout[u].y;
    else
      Bus_Pgas[n+1].u = Bus_Pgas[n].y;
      Bus_Qflow[n+1].u = Bus_Qflow[n].y;
      Bus_m_flow[n+1].u = Bus_m_flow[n].y;
      Bus_Tin[n+1].u = Bus_Tin[n].y;
      Bus_Tout[n+1].u = Bus_Tout[n].y;
    end if;

//all booleans and integer variables
//   if u==1 then
//      Bus_OnOff[n+1].u = Bus_OnOff[1].y;
//   elseif u==2 then
//      Bus_OnOff[n+1].u = Bus_OnOff[2].y;
//   else
//      Bus_OnOff[n+1].u = Bus_OnOff[n].y;
//    end if;

end BoilerBusSwitchBMS;
