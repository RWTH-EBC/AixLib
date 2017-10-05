within AixLib.Building.BatteryModel;
model ExampleBatteryRoom "Example for a battery room with the thermal loss
  of two dummy batteries as input"
  Modelica.Blocks.Sources.Ramp ThermalLoss1(
    offset=0,
    startTime=2,
    height=1000000,
    duration=500)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Ramp ThermalLoss2(
    offset=0,
    startTime=2,
    height=1000000,
    duration=500)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  BatteryRoom BatRoom(
    batType3=false,
    batType4=false,
    nBatTypes=2,
    nBatRacks=10,
    rackParameters={AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=5,
        nSeries=2,
        nStacked=2,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=6,
        nSeries=3,
        nStacked=1,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=10,
        nSeries=3,
        nStacked=3,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=4,
        nSeries=5,
        nStacked=1,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=3,
        nSeries=2,
        nStacked=2,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=10,
        nSeries=5,
        nStacked=8,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=7,
        nSeries=5,
        nStacked=1,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=12,
        nSeries=4,
        nStacked=1,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=5,
        nSeries=4,
        nStacked=2,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0),AixLib.DataBase.Batteries.RackBaseDataDefinition(
        batType=AixLib.DataBase.Batteries.LeadBattery1(),
        nParallels=30,
        nSeries=2,
        nStacked=1,
        airBetweenStacks=false,
        batArrangement=true,
        areaStandingAtWall=0)})
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

equation
  connect(ThermalLoss1.y, BatRoom.ThermalLossBat1)
    annotation (Line(points={{-59,0},{-40,0},{-40,8},{-16,8}},
                color={0,0,127}));
  connect(ThermalLoss2.y, BatRoom.ThermalLossBat2)
    annotation (Line(points={{-59,-30},{-40,-30},{-40,-8},{-16,-8}},
                color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This example shall show the behavior of the battery room model to
the thermal loss of two dummy batteries.</p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>In this example, the two ramps give a signal to the battery room model
which shall simulate the batteries' thermal loss.
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>The example uses the 
<a href=\"AixLib.Building.BatteryModel.BatteryRack\"> BatteryRack </a> and
the <a href=\"AixLib.Building.BatteryModel.BatteryRoom\"> BatteryRoom </a>.
</p>
</html>",  revisions="<html>
<ul>
<li><i>July 26, 2017&nbsp;</i> by Paul Thiele:<br/>Implemented. </li>
</ul>
</html>"),
    experiment(StopTime=1000));
end ExampleBatteryRoom;
