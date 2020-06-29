within AixLib.Systems.Benchmark.Model.Evaluation;
model CostsFuelPower

  AixLib.Utilities.Time.CalendarTime calTim(
    zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2018,
    yearRef=2018,
    year(start=2018))
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput fuel_in annotation(Placement(transformation(extent={{-120,30},
            {-80,70}})));
  Modelica.Blocks.Interfaces.RealInput power_in
                                               annotation(Placement(transformation(extent={{-120,
            -70},{-80,-30}})));
  Modelica.Blocks.Interfaces.RealOutput Total_Cost
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Math.Product Power_Cost
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Blocks.Math.Gain fuel_cost(k=0.0609/(1000*3600))
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Tables.CombiTable2D combiTable2D(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[
        0.0,-1,0,0.0001,1; -1,0.105,0.105,0.19,0.19; 6,0.105,0.105,0.19,0.19;
        6.0001,0.105,0.105,0.27,0.27; 21.9999,0.105,0.105,0.27,0.27; 22,0.105,
        0.105,0.19,0.19; 25,0.105,0.105,0.19,0.19])
    annotation (Placement(transformation(extent={{4,74},{24,94}})));
  Modelica.Blocks.Interfaces.RealOutput minute "Minute of the hour"
    annotation (Placement(transformation(extent={{90,60},{110,80}})));
  Modelica.Blocks.Interfaces.IntegerOutput hour "Hour of the day"
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
  Modelica.Blocks.Interfaces.IntegerOutput weekDay
    "Integer output representing week day (monday = 1, sunday = 7)"
    annotation (Placement(transformation(extent={{90,22},{110,42}})));
  Modelica.Blocks.Math.Gain gain1(k=1/(1000*3600))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={28,44})));
  Modelica.Blocks.Interfaces.RealOutput Total_Power
    annotation (Placement(transformation(extent={{80,-60},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput Total_Fuel
    annotation (Placement(transformation(extent={{80,-100},{120,-60}})));
equation
  der(Total_Cost)=fuel_cost.y + Power_Cost.y;
  der(Total_Power)=power_in/(1000*3600);
  der(Total_Fuel)=fuel_in/(1000*3600);

  connect(Power_Cost.u2, power_in) annotation (Line(points={{38,-36},{20,-36},{20,
          -50},{-100,-50}}, color={0,0,127}));
  connect(calTim.hour, integerToReal.u) annotation (Line(points={{-79,96.2},{
          -54,96.2},{-54,90},{-42,90}}, color={255,127,0}));
  connect(fuel_cost.u, fuel_in)
    annotation (Line(points={{-42,50},{-100,50}}, color={0,0,127}));
  connect(integerToReal.y, combiTable2D.u1)
    annotation (Line(points={{-19,90},{2,90}}, color={0,0,127}));
  connect(combiTable2D.u2, power_in) annotation (Line(points={{2,78},{-10,78},{
          -10,-50},{-100,-50}}, color={0,0,127}));
  connect(calTim.minute, minute) annotation (Line(points={{-79,99},{-60,99},{
          -60,70},{100,70}}, color={0,0,127}));
  connect(calTim.hour, hour) annotation (Line(points={{-79,96.2},{-60,96.2},{
          -60,70},{76,70},{76,50},{100,50}}, color={255,127,0}));
  connect(calTim.weekDay, weekDay) annotation (Line(points={{-79,85},{-60,85},{
          -60,70},{76,70},{76,32},{100,32}}, color={255,127,0}));
  connect(combiTable2D.y, gain1.u)
    annotation (Line(points={{25,84},{28,84},{28,56}}, color={0,0,127}));
  connect(gain1.y, Power_Cost.u1)
    annotation (Line(points={{28,33},{28,-24},{38,-24}}, color={0,0,127}));
end CostsFuelPower;
