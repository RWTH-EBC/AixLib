within AixLib.Fluid.Pools.Examples;
model IndoorSwimmingPool "Example of an indoor swimming pool"
    extends Modelica.Icons.Example;
  .AixLib.Fluid.Pools.IndoorSwimmingPool indoorSwimming(poolParam=
        AixLib.DataBase.Pools.SportPool(), redeclare package WaterMedium =
        WaterMedium)
    annotation (Placement(transformation(extent={{-20,-40},{30,16}})));

    replaceable package WaterMedium = AixLib.Media.Water annotation (choicesAllMatching=true);

  Modelica.Blocks.Sources.RealExpression TSoil(y=273.15 + 8)
    annotation (Placement(transformation(extent={{96,44},{80,60}})));
  Modelica.Blocks.Sources.RealExpression X_W(y=14.3/1000)
    annotation (Placement(transformation(extent={{-84,32},{-68,48}})));
  Modelica.Blocks.Sources.RealExpression T_Air(y=273.15 + 30)
    annotation (Placement(transformation(extent={{-84,56},{-68,72}})));
  Modelica.Blocks.Sources.Pulse timeOpe(
    amplitude=1,
    width=(13/15)*100,
    period=(24 - 7)*3600,
    offset=0,
    startTime=3600*7)
    annotation (Placement(transformation(extent={{-88,-48},{-74,-34}})));
  Modelica.Blocks.Sources.Trapezoid uRelPer(
    amplitude=0.5,
    rising=7*3600,
    width=1*3600,
    falling=7*3600,
    period=17*3600,
    offset=0.3,
    startTime=7*3600)
    annotation (Placement(transformation(extent={{-86,-6},{-72,8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-16,74},{-4,86}})));
equation
  connect(TSoil.y, indoorSwimming.TSoil) annotation (Line(points={{79.2,52},{38,
          52},{38,1.16},{30.75,1.16}},   color={0,0,127}));
  connect(indoorSwimming.X_w, X_W.y) annotation (Line(points={{-2.25,16.84},{
          -2.25,24},{-62,24},{-62,40},{-67.2,40}},
                                       color={0,0,127}));
  connect(indoorSwimming.TAir, T_Air.y) annotation (Line(points={{-11.75,16.84},
          {-10,16.84},{-10,64},{-67.2,64}},
                                   color={0,0,127}));
  connect(timeOpe.y, indoorSwimming.timeOpe) annotation (Line(points={{-73.3,
          -41},{-30,-41},{-30,-28.24},{-21.5,-28.24}}, color={0,0,127}));
  connect(uRelPer.y, indoorSwimming.uRelPer) annotation (Line(points={{-71.3,1},
          {-30,1},{-30,-19.56},{-21.75,-19.56}}, color={0,0,127}));
  connect(prescribedTemperature.T, T_Air.y)
    annotation (Line(points={{-17.2,80},{-58,80},{-58,64},{-67.2,64}},
                                                     color={0,0,127}));
  connect(prescribedTemperature.port, indoorSwimming.convPool) annotation (Line(
        points={{-4,80},{23.5,80},{23.5,17.12}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=172800, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Example model for an sport oriented indoor swimming pool with an integrated ideal heat exchanger. </p>
</html>"));
end IndoorSwimmingPool;
