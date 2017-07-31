within AixLib.Controls;
package Interfaces "Contains interfaces for connection to physical and automation system"
extends Modelica.Icons.InterfacesPackage;

  model TestSwitch "Switches between several signalBus outputs"

    parameter Real n=2 "number of switchable ports";

    BasicPriorityControllerBus
                             signalBus
      annotation (Placement(transformation(extent={{-20,78},{20,118}})));
    BasicPriorityControllerBus
                             signalBus1
      annotation (Placement(transformation(extent={{-112,-120},{-72,-80}})));
    BasicPriorityControllerBus
                             signalBus2
      annotation (Placement(transformation(extent={{-70,-120},{-30,-80}})));

    Modelica.Blocks.Routing.RealPassThrough Bus_priority;
    Modelica.Blocks.Routing.RealPassThrough Bus_Tout;
    Modelica.Blocks.Routing.BooleanPassThrough Bus_OnOff;


    Modelica.Blocks.Interfaces.IntegerInput u annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-76,100})));
  equation
    //connections from passtrough to single output
    connect(signalBus.priority,Bus_priority.y);
    connect(signalBus.OnOff,Bus_OnOff.y);
    connect(signalBus.Tout,Bus_Tout.u);

    //connections from passthrough to multiple bus outputs (only signals from single bus to multi bus)
    connect(signalBus1.Tout,Bus_Tout.y);
    connect(signalBus2.Tout,Bus_Tout.y);


    //switchable outputs for sinlge bus
    if u==1 then
           Bus_OnOff.u=signalBus1.OnOff;
    else Bus_OnOff.u=signalBus2.OnOff;
    end if;

    if u==1 then
           Bus_priority.u=signalBus1.priority;
    else Bus_priority.u=signalBus2.priority;
    end if;

  end TestSwitch;

annotation ();
end Interfaces;
