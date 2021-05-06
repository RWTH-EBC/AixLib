within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model Test_SDF
  StationaryBehaviour stationaryBehaviour(TColdDim=60, dTWaterDim=20)
    annotation (Placement(transformation(extent={{-12,-16},{8,4}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=20)
    annotation (Placement(transformation(extent={{-128,6},{-108,26}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=0)
    annotation (Placement(transformation(extent={{-76,-86},{-56,-66}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=0.25,
    freqHz=48/(3600*24),
    offset=0.75)
    annotation (Placement(transformation(extent={{-110,-26},{-90,-6}})));
equation
  connect(realExpression.y, stationaryBehaviour.dTWater) annotation (Line(
        points={{-107,16},{-96,16},{-96,14},{-66,14},{-66,0},{-14,0}}, color={0,
          0,127}));
  connect(realExpression2.y, stationaryBehaviour.Eta_losses) annotation (Line(
        points={{-55,-76},{-42,-76},{-42,-78},{-2,-78},{-2,-16}}, color={0,0,
          127}));
  connect(sine.y, stationaryBehaviour.PLR) annotation (Line(points={{-89,-16},{
          -74,-16},{-74,-18},{-36,-18},{-36,-4.8},{-14,-4.8}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, Interval=1));
end Test_SDF;
