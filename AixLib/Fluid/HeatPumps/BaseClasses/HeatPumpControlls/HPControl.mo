within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControlls;
block HPControl
  "Control block which makes sure the desired temperature is supplied by the HP"
  AntiLegionella antiLegionella if useAntilegionella
    annotation (Placement(transformation(extent={{-22,-36},{18,4}})));
  HeatingCurve heatingCurve
    annotation (Placement(transformation(extent={{-84,-20},{-44,20}})));
  Controls.Interfaces.HeatPumpControlBus heaPumControlBus
    annotation (Placement(transformation(extent={{-116,-72},{-88,-44}})));
  TSetToNSet tSetToNSet
    annotation (Placement(transformation(extent={{52,-24},{90,10}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    annotation (Placement(transformation(extent={{100,-14},{128,14}})));
  Modelica.Blocks.Interfaces.RealInput T_amb "ambient temperature"
    annotation (Placement(transformation(extent={{-142,0},{-102,40}})));
  parameter Boolean useAntilegionella
    "True if Legionella Control is of relevance";
equation
  connect(tSetToNSet.heatPumpControlBus, heaPumControlBus) annotation (Line(
      points={{49.91,-11.25},{40,-11.25},{40,-58},{-102,-58}},
      color={255,204,51},
      thickness=0.5));

  connect(antiLegionella.heatPumpControlBus_in, heaPumControlBus) annotation (
      Line(
      points={{-25,-16},{-36,-16},{-36,-58},{-102,-58}},
      color={255,204,51},
      thickness=0.5));
  connect(tSetToNSet.nOut, nOut) annotation (Line(points={{91.9,-7},{96,-7},{96,
          -6},{96,-6},{96,1.77636e-015},{114,1.77636e-015}},
                                                 color={0,0,127}));
  connect(heatingCurve.u, T_amb) annotation (Line(points={{-88,0},{-97.4,0},{-97.4,
          20},{-122,20}},       color={0,0,127}));
  connect(T_amb, heaPumControlBus.T_amb) annotation (Line(points={{-122,20},{
          -98,20},{-98,-28},{-98,-57.93},{-100,-57.93},{-101.93,-57.93}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatingCurve.y, tSetToNSet.TSet) annotation (Line(
      points={{-42,0},{-36,0},{-36,14},{38,14},{38,-0.03},{49.15,-0.03}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(heatingCurve.y, antiLegionella.TSet_in)
    annotation (Line(points={{-42,0},{-26.4,0}}, color={0,0,127}));
  connect(antiLegionella.TSet_out, tSetToNSet.TSet) annotation (Line(points={{20.8,
          0},{26,0},{26,0},{30,0},{30,-0.03},{49.15,-0.03}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HPControl;
