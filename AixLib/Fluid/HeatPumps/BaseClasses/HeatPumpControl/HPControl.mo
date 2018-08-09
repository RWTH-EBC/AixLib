within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl;
block HPControl
  "Control block which makes sure the desired temperature is supplied by the HP"
  AntiLegionella antiLegionella if useAntilegionella
    annotation (Placement(transformation(extent={{-22,-50},{18,-10}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-116,-72},{-88,-44}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    annotation (Placement(transformation(extent={{100,-14},{128,14}})));
  Modelica.Blocks.Interfaces.RealInput T_amb "ambient temperature"
    annotation (Placement(transformation(extent={{-142,0},{-102,40}})));
  parameter Boolean useAntilegionella
    "True if Legionella Control is of relevance";
  Modelica.Blocks.Sources.BooleanPulse modePulse(width=50, period=2000)
    "Just to check how bus systems work"
    annotation (Placement(transformation(extent={{-24,-94},{-44,-74}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=0.5,
    offset=0.5,
    freqHz=0.01) annotation (Placement(transformation(extent={{46,2},{66,22}})));
equation

  connect(antiLegionella.sigBusHP, sigBusHP) annotation (Line(
      points={{-25,-30},{-36,-30},{-36,-58},{-102,-58}},
      color={255,204,51},
      thickness=0.5));
  connect(T_amb, sigBusHP.T_amb) annotation (Line(points={{-122,20},{-98,20},{-98,
          -28},{-98,-57.93},{-100,-57.93},{-101.93,-57.93}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(modePulse.y, sigBusHP.mode) annotation (Line(points={{-45,-84},{-80,
          -84},{-80,-57.93},{-101.93,-57.93}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sine.y, nOut) annotation (Line(points={{67,12},{86,12},{86,
          1.77636e-15},{114,1.77636e-15}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HPControl;
