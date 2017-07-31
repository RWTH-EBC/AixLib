within AixLib.Controls.Interfaces;
model TestSwitchVectorBus
  "Switches between several signalBus outputs"

  parameter Integer n=5 "number of switchable ports";

  BasicPriorityControllerBus
                           signalBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}})));
  BasicPriorityControllerBus signalBusVector[n]
    annotation (Placement(transformation(extent={{-20,76},{20,116}})));

  Modelica.Blocks.Routing.RealPassThrough Bus_priority[n+1];
  Modelica.Blocks.Routing.RealPassThrough Bus_Tout;
  Modelica.Blocks.Routing.BooleanPassThrough Bus_OnOff[n+1];


  Modelica.Blocks.Interfaces.IntegerInput u annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-76,100})));

equation
  //connections of signalBus and passthrough
  connect(signalBus.priority,Bus_priority[n+1].y);
  connect(signalBus.OnOff,Bus_OnOff[n+1].y);
  connect(signalBus.Tout,Bus_Tout.u);

  //connections of signalBusVector and passthrough
  for i in 1:n loop
  //connections passthrough and signalBusVector outputs
  connect(signalBusVector[i].Tout, Bus_Tout.y);
  //connections passthrough and signalBusVector inputs
  connect(signalBusVector[i].priority,Bus_priority[i].u);
  connect(signalBusVector[i].OnOff,Bus_OnOff[i].u);
  end for;


  //switchable outputs for sinlge bus
    if u<=n then
      Bus_priority[n+1].u = Bus_priority[u].y;
//      Bus_OnOff[n+1].u = Bus_OnOff[u].y;
    else
      Bus_priority[n+1].u = Bus_priority[n].y;
//      Bus_OnOff[n+1].u = Bus_OnOff[n].y;
    end if;

//all booleans and integer variables
   if u==1 then
      Bus_OnOff[n+1].u = Bus_OnOff[1].y;
   elseif u==2 then
      Bus_OnOff[n+1].u = Bus_OnOff[2].y;
   elseif u==3 then if n>2 then
      Bus_OnOff[n+1].u = Bus_OnOff[3].y; end if;
//    elseif u==4 then
//    Bus_OnOff[n+1].u = Bus_OnOff[4].y;
//   elseif u<=n then
//     Bus_OnOff[n+1].u = Bus_OnOff[u].y;
   else
      Bus_OnOff[n+1].u = Bus_OnOff[n].y;
    end if;



end TestSwitchVectorBus;
