within AixLib.Controls.Interfaces;
model BusSwitch "Switches between several signalBus outputs"

  Boolean u2=true;
  Modelica.Icons.SignalBus signalBus
    annotation (Placement(transformation(extent={{-20,78},{20,118}})));
  Modelica.Icons.SignalBus signalBus1
    annotation (Placement(transformation(extent={{-94,-120},{-54,-80}})));
  Modelica.Icons.SignalBus signalBus2
    annotation (Placement(transformation(extent={{-48,-120},{-8,-80}})));
  Modelica.Icons.SignalBus signalBus3
    annotation (Placement(transformation(extent={{4,-120},{44,-80}})));
  Modelica.Icons.SignalBus signalBus4
    annotation (Placement(transformation(extent={{50,-120},{90,-80}})));
  Modelica.Blocks.Interfaces.IntegerInput u annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-58,100})));


equation
  if u == 1 then
    signalBus = signalBus1;
  elseif u == 2 then
    signalBus = signalBus2;
  elseif u == 3 then
    signalBus = signalBus3;
  elseif u == 4 then
    signalBus = signalBus4;
  end if;

end BusSwitch;
