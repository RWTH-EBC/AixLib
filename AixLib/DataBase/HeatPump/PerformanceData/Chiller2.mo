within AixLib.DataBase.HeatPump.PerformanceData;
model Chiller2 "GenericChiller2"

 extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;


  parameter Real table_EER[:, :] =
    [0, 19.9, 22.4, 25.1, 27.5, 30.0, 32.5, 35.0, 37.5, 40.0, 42.5, 45.0;
     18, 5.7, 5.5, 5.2, 4.9, 4.6, 4.3, 4.0, 3.6, 3.2, 2.9, 2.7]
    "EER table; T in degC; EER";

  Utilities.Tables.CombiTable2DExtra EER_Table(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=false,
    final u1(unit="degC"),
    final u2(unit="degC"),
    final table=table_EER) "Energy Efficiency Ratio table"
    annotation (extent=[-60,-20; -40,0], Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={-2,0})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_ou annotation (extent=[-88,38;
        -76,50], Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={14,50})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-6,-6},
            {6,6}},
        rotation=270,
        origin={-14,50})));
  Modelica.Blocks.Sources.RealExpression NominalPower(y=QNom)
    annotation (Placement(transformation(extent={{86,-52},{62,-32}})));
  Modelica.Blocks.Math.Division scalingFactor1
    annotation (Placement(transformation(extent={{16,-50},{-4,-30}})));
  Modelica.Blocks.Math.Product productQCon3
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-48,-54})));
  Modelica.Blocks.Math.Product productQCon1
                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={120,-54})));
  Modelica.Blocks.Math.Add calcRedQCon
    "Based on redcued heat flow to the evaporator, the heat flow to the condenser is also reduced"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-92,-70})));
  Utilities.Tables.CombiTable2DExtra EER_Table1(
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=false,
    final u1(unit="degC"),
    final u2(unit="degC"),
    final table=table_EER) "Energy Efficiency Ratio table"
    annotation (extent=[-60,-20; -40,0], Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={174,56})));
  Modelica.Blocks.Sources.RealExpression NominalPower1(y=QNom)
    annotation (Placement(transformation(extent={{252,-6},{228,14}})));
  Modelica.Blocks.Math.Division scalingFactor2
    annotation (Placement(transformation(extent={{176,4},{156,24}})));
  Modelica.Blocks.Math.Add calcRedQCon1
    "Based on redcued heat flow to the evaporator, the heat flow to the condenser is also reduced"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={92,10})));
  Modelica.Blocks.Sources.RealExpression NominalPower2(y=35)
    annotation (Placement(transformation(extent={{218,86},{194,106}})));
  Modelica.Blocks.Sources.RealExpression NominalPower3(y=18)
    annotation (Placement(transformation(extent={{238,58},{214,78}})));
equation
  connect(sigBus.TConInMea, t_Co_in.u) annotation (Line(
      points={{-0.925,100.07},{2,100.07},{2,72},{-14,72},{-14,57.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(t_Co_in.y, EER_Table.u2) annotation (Line(points={{-14,43.4},{-14,26},
          {-10.4,26},{-10.4,16.8}}, color={0,0,127}));
  connect(t_Ev_ou.y, EER_Table.u1) annotation (Line(points={{14,43.4},{14,34},{6.4,
          34},{6.4,16.8}}, color={0,0,127}));
  connect(EER_Table.y, scalingFactor1.u2) annotation (Line(points={{-2,-15.4},{-4,
          -15.4},{-4,-24},{38,-24},{38,-46},{18,-46}}, color={0,0,127}));
  connect(scalingFactor1.u1, NominalPower.y) annotation (Line(points={{18,-34},{
          40,-34},{40,-42},{60.8,-42}}, color={0,0,127}));
  connect(scalingFactor1.y, productQCon3.u1) annotation (Line(points={{-5,-40},{
          -24,-40},{-24,-36},{-42,-36},{-42,-42}}, color={0,0,127}));
  connect(productQCon3.y, Pel) annotation (Line(points={{-48,-65},{-48,-82},{0,-82},
          {0,-110}}, color={0,0,127}));
  connect(sigBus.nSet, productQCon3.u2) annotation (Line(
      points={{-0.925,100.07},{-32,100.07},{-32,102},{-54,102},{-54,-42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.nSet, productQCon1.u1) annotation (Line(
      points={{-0.925,100.07},{48,100.07},{48,100},{126,100},{126,-42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(NominalPower.y, productQCon1.u2) annotation (Line(points={{60.8,-42},{
          56,-42},{56,-20},{114,-20},{114,-42}}, color={0,0,127}));
  connect(productQCon1.y, QEva) annotation (Line(points={{120,-65},{122,-65},{122,
          -80},{80,-80},{80,-110}}, color={0,0,127}));
  connect(productQCon1.y, calcRedQCon.u1) annotation (Line(points={{120,-65},{120,
          -54},{-88.4,-54},{-88.4,-62.8}}, color={0,0,127}));
  connect(productQCon3.y, calcRedQCon.u2) annotation (Line(points={{-48,-65},{-74,
          -65},{-74,-60},{-95.6,-60},{-95.6,-62.8}}, color={0,0,127}));
  connect(calcRedQCon.y, QCon) annotation (Line(points={{-92,-76.6},{-92,-100},{
          -82,-100},{-82,-110},{-80,-110}}, color={0,0,127}));
  connect(NominalPower1.y, scalingFactor2.u1) annotation (Line(points={{226.8,4},
          {188,4},{188,20},{178,20}}, color={0,0,127}));
  connect(EER_Table1.y, scalingFactor2.u2) annotation (Line(points={{174,40.6},{
          182,40.6},{182,34},{194,34},{194,0},{178,0},{178,8}}, color={0,0,127}));
  connect(NominalPower1.y, calcRedQCon1.u1) annotation (Line(points={{226.8,4},{
          182,4},{182,-6},{134,-6},{134,17.2},{95.6,17.2}}, color={0,0,127}));
  connect(NominalPower2.y, EER_Table1.u2) annotation (Line(points={{192.8,96},{
          165.6,96},{165.6,72.8}}, color={0,0,127}));
  connect(NominalPower3.y, EER_Table1.u1) annotation (Line(points={{212.8,68},{
          204,68},{204,82},{182.4,82},{182.4,72.8}}, color={0,0,127}));
  connect(scalingFactor2.y, calcRedQCon1.u2) annotation (Line(points={{155,14},
          {146,14},{146,34},{86,34},{86,17.2},{88.4,17.2}}, color={0,0,127}));
  connect(calcRedQCon1.y, sigBus.QEvapNom) annotation (Line(points={{92,3.4},{
          90,3.4},{90,-10},{54,-10},{54,100.07},{-0.925,100.07}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TEvaOutMea, t_Ev_ou.u) annotation (Line(
      points={{-0.925,100.07},{0,100.07},{0,76},{14,76},{14,57.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-190,64},{-136,44}},
          textColor={28,108,200},
          textString="18 °C (Heizkreis-Vorlauf)"), Text(
          textColor={28,108,200},
          textString="Außentemperatur"),                      Text(
          extent={{-112,58},{-62,38}},
          textColor={28,108,200},
          textString="Außentemperatur
")}));





end Chiller2;
