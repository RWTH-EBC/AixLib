within AixLib.DataBase.HeatPump.PerformanceData;
model ASHP_AlphaInnotec_LWD_90A "ASHP_AlphaInnotec_LWD_90A"
 extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

  Modelica.Blocks.Math.Product productQCon annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,-82})));

  LookUpTable2D lookUpTable2D(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      dataTable=AixLib.DataBase.HeatPump.EN14511.AlphaInnotec_LWD_90A())
    annotation (Placement(transformation(extent={{100,64},{120,84}})));
  Controls.Interfaces.VapourCompressionMachineControlBus        sigBus1
    "Bus-connector used in a heat pump" annotation (Placement(
        transformation(
        extent={{-18,-18},{18,18}},
        rotation=0,
        origin={110,100}), iconTransformation(extent={{-18,-18},{18,18}},
          origin={110,100})));
  Modelica.Blocks.Sources.RealExpression NomSupplyTemp(y=THotNom)
    annotation (Placement(transformation(extent={{178,158},{150,176}})));
  Modelica.Blocks.Sources.RealExpression NomSourceTemp(y=TSourceNom)
    annotation (Placement(transformation(extent={{178,142},{150,160}})));
  LookUpTable2D lookUpTable2D1(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      dataTable=AixLib.DataBase.HeatPump.EN14511.AlphaInnotec_LWD_90A())
    annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
  Modelica.Blocks.Sources.RealExpression NominalPower(y=QNom)
    annotation (Placement(transformation(extent={{86,28},{62,48}})));
  Modelica.Blocks.Math.Division scalingFactor
    annotation (Placement(transformation(extent={{48,22},{28,42}})));
  Modelica.Blocks.Math.Product productQCon1
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-80})));
  Modelica.Blocks.Math.Product productQCon2
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-80})));
  Modelica.Blocks.Math.Product productQCon3
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-32,10})));
  LookUpTable2D lookUpTable2D2(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      dataTable=AixLib.DataBase.HeatPump.EN14511.AlphaInnotec_LWD_90A())
    annotation (Placement(transformation(extent={{60,64},{80,84}})));
  Modelica.Blocks.Sources.RealExpression TSourceMax(y=273.15 + 25)
    annotation (Placement(transformation(extent={{8,122},{52,146}})));
  Modelica.Blocks.Sources.RealExpression TSupplyMin(y=273.15 + 35) annotation (
      Placement(transformation(
        extent={{-22,-14},{22,14}},
        rotation=0,
        origin={30,154})));
  Controls.Interfaces.VapourCompressionMachineControlBus        sigBus2
    "Bus-connector used in a heat pump" annotation (Placement(
        transformation(
        extent={{-15,-14},{15,14}},
        rotation=0,
        origin={71,100})));
  Modelica.Blocks.Sources.RealExpression NomRelPower(y=1)
    annotation (Placement(transformation(extent={{178,124},{150,144}})));
  Modelica.Blocks.Sources.RealExpression zero7(y=1)
    annotation (Placement(transformation(extent={{24,164},{52,182}})));
  Modelica.Blocks.Math.Product productQCon4
                                           annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-4,52})));
  Modelica.Blocks.Sources.RealExpression IceFactor(y=1)
    annotation (Placement(transformation(extent={{26,180},{54,200}})));
  Modelica.Blocks.Sources.RealExpression one(y=1)
    annotation (Placement(transformation(extent={{54,-10},{30,10}})));
equation

  connect(QEva, QEva)
    annotation (Line(points={{80,-110},{80,-110}}, color={0,0,127}));

  connect(productQCon.y, QCon)
    annotation (Line(points={{-80,-93},{-80,-110}}, color={0,0,127}));

  connect(sigBus1, lookUpTable2D.sigBus) annotation (Line(
      points={{110,100},{110,85},{109.9,85},{109.9,84}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(NomSupplyTemp.y, sigBus1.TConOutMea) annotation (Line(points={{148.6,
          167},{110.09,167},{110.09,100.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(NomSourceTemp.y, sigBus1.TEvaInMea) annotation (Line(points={{148.6,
          151},{110.09,151},{110.09,100.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBus, lookUpTable2D1.sigBus) annotation (Line(
      points={{-1,100},{-78.1,100},{-78.1,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(NominalPower.y, scalingFactor.u1)
    annotation (Line(points={{60.8,38},{50,38}}, color={0,0,127}));
  connect(lookUpTable2D.QCon, scalingFactor.u2)
    annotation (Line(points={{102,63},{102,26},{50,26}}, color={0,0,127}));
  connect(productQCon1.y, Pel) annotation (Line(points={{-2.22045e-15,-91},{
          -2.22045e-15,-96},{0,-96},{0,-110}}, color={0,0,127}));
  connect(lookUpTable2D1.QEva, productQCon2.u2) annotation (Line(points={{-70,19},
          {-70,-20},{74,-20},{74,-68}},color={0,0,127}));
  connect(scalingFactor.y, productQCon3.u2)
    annotation (Line(points={{27,32},{-38,32},{-38,22}}, color={0,0,127}));
  connect(productQCon3.y, productQCon2.u1)
    annotation (Line(points={{-32,-1},{-32,-32},{86,-32},{86,-68}},
                                                       color={0,0,127}));
  connect(productQCon2.y, QEva)
    annotation (Line(points={{80,-91},{80,-110}}, color={0,0,127}));
  connect(TSupplyMin.y, sigBus2.TConOutMea) annotation (Line(points={{54.2,154},
          {71.075,154},{71.075,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TSourceMax.y, sigBus2.TEvaInMea) annotation (Line(points={{54.2,134},
          {71.075,134},{71.075,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBus2, lookUpTable2D2.sigBus) annotation (Line(
      points={{71,100},{70,100},{70,84},{69.9,84}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(NomRelPower.y, sigBus1.nSet) annotation (Line(points={{148.6,134},{
          110.09,134},{110.09,100.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(zero7.y, sigBus2.nSet) annotation (Line(points={{53.4,173},{71.075,
          173},{71.075,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(productQCon4.y, sigBus.QEvapNom) annotation (Line(points={{-15,52},{
          -46,52},{-46,100.07},{-0.925,100.07}},
                                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(IceFactor.y, sigBus1.iceFacMea) annotation (Line(points={{55.4,190},{
          110.09,190},{110.09,100.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(IceFactor.y, sigBus2.iceFacMea) annotation (Line(points={{55.4,190},{
          71.075,190},{71.075,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(lookUpTable2D1.QCon, productQCon.u2)
    annotation (Line(points={{-86,19},{-86,-70},{-86,-70}}, color={0,0,127}));
  connect(productQCon3.y, productQCon.u1) annotation (Line(points={{-32,-1},{
          -32,-32},{-74,-32},{-74,-70}}, color={0,0,127}));
  connect(lookUpTable2D1.Pel, productQCon1.u2) annotation (Line(points={{-78,19},
          {-78,-50},{-6,-50},{-6,-68}}, color={0,0,127}));
  connect(productQCon3.y, productQCon1.u1) annotation (Line(points={{-32,-1},{
          -32,-42},{6,-42},{6,-68}}, color={0,0,127}));
  connect(scalingFactor.y, productQCon4.u2) annotation (Line(points={{27,32},{
          18,32},{18,46},{8,46}}, color={0,0,127}));
  connect(lookUpTable2D2.QEva, productQCon4.u1)
    annotation (Line(points={{78,63},{78,58},{8,58}}, color={0,0,127}));
  connect(one.y, productQCon3.u1) annotation (Line(points={{28.8,0},{14,0},{14,
          12},{-2,12},{-2,28},{-26,28},{-26,22}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,100}}),                                  graphics={
    Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},
              {-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},
              {60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
    Line(points={{0,40},{0,-40}}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-60,0},{-30,20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60,-40},{-30,-20}}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-60,-20},{-30,0}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-60,-40},{-30,-20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-30,-40},{0,-20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{0,-40},{30,-20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{30,-40},{60,-20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{30,-20},{60,0}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{0,-20},{30,0}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{0,0},{30,20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{30,0},{60,20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{0,20},{30,40}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{30,20},{60,40}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-60,20},{-30,40}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-30,20},{0,40}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-30,0},{0,20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-30,-20},{0,0}},
          lineColor={0,0,0})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{140,
            100}})),
    Documentation(info="<html><p>
  This model uses 4-dimensional table data, wich are calculated for a
  simplyfied refrigerant circuit with the use of isentropic compressor
  efficienciecs as a function of pressure gradient and frequency,
  superheating and calibration of minimal temperature differencees in
  condeser and evaporater. The table data ist a function of THot,
  TSource, deltaTCon and relative power, which represents compressor
  frequency.
</p>
<p>
  <br/>
  <img src=
  \"modelica://AixLib/../../../Diagramme%20AixLib/WP/KennfeldScroll_Prel.png\">
</p>
<p>
  <img src=
  \"modelica://AixLib/../../../Diagramme%20AixLib/WP/KennfeldScroll_DeltaT_HK.png\">
</p>
</html>"));
end ASHP_AlphaInnotec_LWD_90A;
