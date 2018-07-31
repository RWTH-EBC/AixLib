within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControlls;
block HPControl
  "Control block which makes sure the desired temperature is supplied by the HP"
  AntiLegionella antiLegionella
    annotation (Placement(transformation(extent={{-16,-12},{20,20}})));
  HeatingCurve heatingCurve
    annotation (Placement(transformation(extent={{-84,-12},{-56,16}})));
  Controls.Interfaces.HeatPumpControlBus heaPumControlBus
    annotation (Placement(transformation(extent={{-116,-72},{-88,-44}})));
  TSetToNSet tSetToNSet
    annotation (Placement(transformation(extent={{52,-18},{90,16}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    annotation (Placement(transformation(extent={{100,-14},{128,14}})));
  Modelica.Blocks.Interfaces.RealInput T_amb "ambient temperature"
    annotation (Placement(transformation(extent={{-142,0},{-102,40}})));
equation
  connect(heatingCurve.y, antiLegionella.TSet_in) annotation (Line(points={{
          -54.6,2},{-44,2},{-44,16},{-19.96,16},{-19.96,16.8}}, color={0,0,127}));
  connect(antiLegionella.TSet_out, tSetToNSet.TSet) annotation (Line(points={{
          22.52,15.84},{45.26,15.84},{45.26,5.97},{49.15,5.97}}, color={0,0,127}));
  connect(tSetToNSet.heatPumpControlBus, heaPumControlBus) annotation (Line(
      points={{49.91,-5.25},{38,-5.25},{38,-40},{-36,-40},{-36,-58},{-102,-58}},
      color={255,204,51},
      thickness=0.5));

  connect(antiLegionella.heatPumpControlBus_in, heaPumControlBus) annotation (
      Line(
      points={{-18.7,4},{-36,4},{-36,-58},{-102,-58}},
      color={255,204,51},
      thickness=0.5));
  connect(tSetToNSet.nOut, nOut) annotation (Line(points={{91.9,-1},{102,-1},{
          102,1.77636e-015},{114,1.77636e-015}}, color={0,0,127}));
  connect(heatingCurve.u, T_amb) annotation (Line(points={{-86.8,2},{-97.4,2},{
          -97.4,20},{-122,20}}, color={0,0,127}));
  connect(T_amb, heaPumControlBus.T_amb) annotation (Line(points={{-122,20},{
          -98,20},{-98,-28},{-98,-57.93},{-100,-57.93},{-101.93,-57.93}}, color
        ={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HPControl;
