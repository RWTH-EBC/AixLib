within AixLib.Building.Benchmark.Evaluation;
model Costs

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
  Modelica.Blocks.Math.Gain gain(k=0.00609)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Tables.CombiTable2D combiTable2D(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      table=[0.0,-1,0,0.0001,1; -1,0.11,0.11,0.19,0.19; 6,0.11,0.11,0.19,0.19;
        6.0001,0.11,0.11,0.27,0.27; 21.9999,0.11,0.11,0.27,0.27; 22,0.11,0.11,
        0.19,0.19; 25,0.11,0.11,0.19,0.19])
    annotation (Placement(transformation(extent={{4,74},{24,94}})));
equation
  der(Total_Cost)=fuel_in/3600/1000 + Power_Cost.y/3600/1000;

  connect(Power_Cost.u2, power_in) annotation (Line(points={{38,-36},{20,-36},{20,
          -50},{-100,-50}}, color={0,0,127}));
  connect(calTim.hour, integerToReal.u) annotation (Line(points={{-79,96.2},{
          -54,96.2},{-54,90},{-42,90}}, color={255,127,0}));
  connect(gain.u, fuel_in)
    annotation (Line(points={{-42,50},{-100,50}}, color={0,0,127}));
  connect(integerToReal.y, combiTable2D.u1)
    annotation (Line(points={{-19,90},{2,90}}, color={0,0,127}));
  connect(combiTable2D.u2, power_in) annotation (Line(points={{2,78},{-10,78},{
          -10,-50},{-100,-50}}, color={0,0,127}));
  connect(combiTable2D.y, Power_Cost.u1) annotation (Line(points={{25,84},{28,
          84},{28,-24},{38,-24}}, color={0,0,127}));
end Costs;
