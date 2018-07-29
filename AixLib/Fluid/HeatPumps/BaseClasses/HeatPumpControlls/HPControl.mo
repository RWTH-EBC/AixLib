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
  BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-122,12},{-82,52}}), iconTransformation(extent=
            {{-102,-28},{-82,-8}})));
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
  connect(heatingCurve.u, weaBus.T) annotation (Line(points={{-86.8,2},{-86.8,
          31},{-102,31},{-102,32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HPControl;
