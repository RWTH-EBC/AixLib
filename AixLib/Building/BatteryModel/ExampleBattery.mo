within AixLib.Building.BatteryModel;
model ExampleBattery "Example Battery"
  Modelica.Blocks.Sources.Ramp ramp(
    offset=0,
    startTime=2,
    height=1000000,
    duration=500)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Battery_Room battery_Room(
    nBatRacks=6,
    nRacksFirstType=6,
    nBatTypes=1,
    RackType1=M5Bat.DatabaseM5Bat.Batteries.BatteryRacks.Lead1_Rack78(),
    RackType2=M5Bat.DatabaseM5Bat.Batteries.BatteryRacks.Lead1_Rack78(),
    RackType3=M5Bat.DatabaseM5Bat.Batteries.BatteryRacks.Lead1_Rack74(),
    RackType4=M5Bat.DatabaseM5Bat.Batteries.BatteryRacks.Lead1_Rack74(),
    RackType5=M5Bat.DatabaseM5Bat.Batteries.BatteryRacks.Lead1_Rack74(),
    RackType6=M5Bat.DatabaseM5Bat.Batteries.BatteryRacks.Lead1_Rack74())
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
equation
  connect(ramp.y, battery_Room.Battery1_Loss) annotation (Line(points={{-59,0},
          {-38,0},{-38,8},{-16,8}}, color={0,0,127}));
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
        coordinateSystem(preserveAspectRatio=false)));
end ExampleBattery;
