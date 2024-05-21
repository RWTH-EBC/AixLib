within AixLib.DataBase.HeatPump.PerformanceData;
model Wamak_R410A "Wamak WaterWater R410A"
 extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

  Modelica.Blocks.Math.Product productQCon annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,-70})));

  LookUpTable2D lookUpTable2D(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      dataTable=AixLib.DataBase.HeatPump.EN14511.Wamak_R410A())
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Controls.Interfaces.VapourCompressionMachineControlBus        sigBus1
    "Bus-connector used in a heat pump" annotation (Placement(
        transformation(
        extent={{-15,-14},{15,14}},
        rotation=0,
        origin={-51,100})));
  Modelica.Blocks.Sources.RealExpression zero2(y=THotNom)
    annotation (Placement(transformation(extent={{-128,122},{-100,140}})));
  Modelica.Blocks.Sources.RealExpression zero4(y=TSourceNom)
    annotation (Placement(transformation(extent={{-128,106},{-100,124}})));
  LookUpTable2D lookUpTable2D1(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      dataTable=AixLib.DataBase.HeatPump.EN14511.Wamak_R410A())
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Modelica.Blocks.Sources.RealExpression zero5(y=QNom)
    annotation (Placement(transformation(extent={{-128,30},{-100,48}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-68,22},{-48,42}})));
  Modelica.Blocks.Math.Product productQCon1
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-70})));
  Modelica.Blocks.Math.Product productQCon2
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-70})));
  Modelica.Blocks.Math.Product productQCon3
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-6,34})));
  LookUpTable2D lookUpTable2D2(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      dataTable=AixLib.DataBase.HeatPump.EN14511.Wamak_R410A())
    annotation (Placement(transformation(extent={{120,20},{140,40}})));
  Modelica.Blocks.Sources.RealExpression zero3(y=273.15 + 40)
    annotation (Placement(transformation(extent={{130,62},{158,80}})));
  Modelica.Blocks.Sources.RealExpression zero6(y=THotNom - DeltaTCon)
    annotation (Placement(transformation(extent={{130,78},{158,96}})));
  Controls.Interfaces.VapourCompressionMachineControlBus        sigBus2
    "Bus-connector used in a heat pump" annotation (Placement(
        transformation(
        extent={{-15,-14},{15,14}},
        rotation=0,
        origin={201,54})));
  Modelica.Blocks.Sources.RealExpression zero1(y=1)
    annotation (Placement(transformation(extent={{-126,92},{-98,110}})));
  Modelica.Blocks.Sources.RealExpression zero7(y=1)
    annotation (Placement(transformation(extent={{128,108},{156,126}})));
  Modelica.Blocks.Sources.RealExpression zero8(y=1)
    annotation (Placement(transformation(extent={{42,136},{70,154}})));
  Modelica.Blocks.Math.Product productQCon4
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={56,60})));
equation

  connect(QEva, QEva)
    annotation (Line(points={{80,-110},{80,-110}}, color={0,0,127}));

  connect(productQCon.y, QCon)
    annotation (Line(points={{-80,-81},{-80,-110}}, color={0,0,127}));

  connect(sigBus1, lookUpTable2D.sigBus) annotation (Line(
      points={{-51,100},{-51,85},{-50.1,85},{-50.1,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(zero2.y, sigBus1.TConOutMea) annotation (Line(points={{-98.6,131},{
          -50.925,131},{-50.925,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(zero4.y, sigBus1.TEvaInMea) annotation (Line(points={{-98.6,115},{
          -50.925,115},{-50.925,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBus, lookUpTable2D1.sigBus) annotation (Line(
      points={{-1,100},{89.9,100},{89.9,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(zero5.y, division.u1) annotation (Line(points={{-98.6,39},{-82,39},{
          -82,38},{-70,38}}, color={0,0,127}));
  connect(lookUpTable2D.QCon, division.u2) annotation (Line(points={{-58,59},{
          -58,52},{-84,52},{-84,26},{-70,26}}, color={0,0,127}));
  connect(lookUpTable2D1.Pel, productQCon1.u1) annotation (Line(points={{90,59},
          {90,-14},{6,-14},{6,-58}}, color={0,0,127}));
  connect(productQCon1.y, Pel) annotation (Line(points={{-2.22045e-15,-81},{
          -2.22045e-15,-96},{0,-96},{0,-110}}, color={0,0,127}));
  connect(lookUpTable2D1.QCon, productQCon.u1) annotation (Line(points={{82,59},
          {82,-8},{-36,-8},{-36,-26},{-74,-26},{-74,-58}}, color={0,0,127}));
  connect(lookUpTable2D1.QEva, productQCon2.u2) annotation (Line(points={{98,59},
          {98,-20},{74,-20},{74,-58}}, color={0,0,127}));
  connect(division.y, productQCon3.u2) annotation (Line(points={{-47,32},{-36,
          32},{-36,26},{-18,26},{-18,28}}, color={0,0,127}));
  connect(sigBus.nSet, productQCon3.u1) annotation (Line(
      points={{-0.925,100.07},{-0.925,62},{-24,62},{-24,40},{-18,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(productQCon3.y, productQCon1.u2) annotation (Line(points={{5,34},{22,
          34},{22,0},{-6,0},{-6,-58}}, color={0,0,127}));
  connect(productQCon3.y, productQCon.u2) annotation (Line(points={{5,34},{14,
          34},{14,6},{-86,6},{-86,-58}}, color={0,0,127}));
  connect(productQCon3.y, productQCon2.u1)
    annotation (Line(points={{5,34},{86,34},{86,-58}}, color={0,0,127}));
  connect(productQCon2.y, QEva)
    annotation (Line(points={{80,-81},{80,-110}}, color={0,0,127}));
  connect(zero6.y, sigBus2.TConOutMea) annotation (Line(points={{159.4,87},{
          201.075,87},{201.075,54.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(zero3.y, sigBus2.TEvaInMea) annotation (Line(points={{159.4,71},{
          201.075,71},{201.075,54.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sigBus2, lookUpTable2D2.sigBus) annotation (Line(
      points={{201,54},{202,54},{202,48},{129.9,48},{129.9,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(zero1.y, sigBus1.nSet) annotation (Line(points={{-96.6,101},{-84,101},
          {-84,102},{-50.925,102},{-50.925,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(zero7.y, sigBus2.nSet) annotation (Line(points={{157.4,117},{201.075,
          117},{201.075,54.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(zero8.y, sigBus2.iceFacMea) annotation (Line(points={{71.4,145},{
          201.075,145},{201.075,54.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(zero8.y, sigBus1.iceFacMea) annotation (Line(points={{71.4,145},{71.4,
          136},{72,136},{72,126},{-46,126},{-46,100.07},{-50.925,100.07}},
                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(lookUpTable2D2.QEva, productQCon4.u2) annotation (Line(points={{138,
          19},{138,2},{34,2},{34,54},{44,54}}, color={0,0,127}));
  connect(productQCon4.y, sigBus.QEvapNom) annotation (Line(points={{67,60},{72,
          60},{72,100.07},{-0.925,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(division.y, productQCon4.u1) annotation (Line(points={{-47,32},{-32,
          32},{-32,66},{44,66}}, color={0,0,127}));
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
end Wamak_R410A;
