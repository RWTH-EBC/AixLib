within AixLib.Building.Benchmark.Test;
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
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table=[-1,0.19/3600/1000;
        6,0.19/3600/1000; 6.01,0.27/3600/1000; 21.99,0.27/3600/1000; 22,0.19/
        3600/1000; 25,0.19/3600/1000])
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Blocks.Math.Gain gain
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
equation
  der(Total_Cost)= fuel_in/3600/1000 + power_in/3600/1000;

  connect(combiTable1Ds.y[1], product.u1) annotation (Line(points={{11,90},{20,
          90},{20,-24},{38,-24}}, color={0,0,127}));
  connect(product.u2, power_in) annotation (Line(points={{38,-36},{20,-36},{20,
          -50},{-100,-50}}, color={0,0,127}));
  connect(calTim.hour, integerToReal.u) annotation (Line(points={{-79,96.2},{
          -54,96.2},{-54,90},{-42,90}}, color={255,127,0}));
  connect(integerToReal.y, combiTable1Ds.u)
    annotation (Line(points={{-19,90},{-12,90}}, color={0,0,127}));
  connect(gain.u, fuel_in)
    annotation (Line(points={{-42,50},{-100,50}}, color={0,0,127}));
end Costs;
