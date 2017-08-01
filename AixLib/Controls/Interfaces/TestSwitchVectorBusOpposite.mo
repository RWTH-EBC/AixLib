within AixLib.Controls.Interfaces;
model TestSwitchVectorBusOpposite
  "Switches between several signalBus outputs, signal between component and controller"

  parameter Integer n=5 "number of switchable ports";

  BasicPriorityControllerBus
                           signalBus
    annotation (Placement(transformation(extent={{-20,78},{20,118}})));
  BasicPriorityControllerBus signalBusVector[n]
    annotation (Placement(transformation(extent={{-18,-120},{22,-80}})));

  Modelica.Blocks.Routing.RealPassThrough Bus_priority;  //signalBus input
  Modelica.Blocks.Routing.RealPassThrough Bus_Tout[n+1]; //signalBus output
  Modelica.Blocks.Routing.BooleanPassThrough Bus_OnOff;  //signalBus input

  Modelica.Blocks.Interfaces.IntegerInput u annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-76,100})));
equation
  //connections of signalBus and passthrough
  connect(signalBus.priority,Bus_priority.u);
  connect(signalBus.OnOff,Bus_OnOff.u);
  connect(signalBus.Tout,Bus_Tout[n+1].y);

  //connections of signalBusVector and passthrough
  for i in 1:n loop
  //connections passthrough and signalBusVector outputs
  connect(signalBusVector[i].priority, Bus_priority.y);
  connect(signalBusVector[i].OnOff, Bus_OnOff.y);
  //connections passthrough and signalBusVector inputs
  connect(signalBusVector[i].Tout,Bus_Tout[i].u);
  end for;


  //switchable outputs for signalBus
    if u<=n then
      Bus_Tout[n+1].u = Bus_Tout[u].y;
    else
      Bus_Tout[n+1].u = Bus_Tout[n].y;
    end if;

end TestSwitchVectorBusOpposite;
