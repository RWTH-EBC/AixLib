within AixLib.Fluid.Actuators.ExpansionValves.ModularExpansionValves;
model ModularExpansionValves
  "Model of modular expansion valves, i.g. each valves is in front 
  of an evaporator"
  extends BaseClasses.PartialModularExpansionVavles;

equation
  // Connect ports_b with outlet ports of expansion valves
  //
  for i in 1:nVal loop
    connect(expansionValves[i].port_b,ports_b[i]);
  end for;

end ModularExpansionValves;
