within AixLib.DataBase.HeatPump.PerformanceData;
model Carnot_COP_Reduced
   extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

  CarnotCOP carnotCOPDesign
    annotation (Placement(transformation(extent={{-78,62},{-58,82}})));
  Modelica.Blocks.Sources.RealExpression qNom(y=QNom)
    annotation (Placement(transformation(extent={{-150,-6},{-94,18}})));
  Modelica.Blocks.Sources.RealExpression etaCarnot(y=0.5) "Guetegrad"
    annotation (Placement(transformation(extent={{-118,18},{-82,38}})));
  Modelica.Blocks.Math.Product cop annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-32,60})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Modelica.Blocks.Math.Product productPel1
                                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,0})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{4,-2},{24,18}})));
  Modelica.Blocks.Sources.RealExpression qNom1(y=QNom)
    annotation (Placement(transformation(extent={{-80,144},{-24,168}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{20,134},{40,154}})));
  Modelica.Blocks.Sources.RealExpression tSourceNom(y=TSourceNom)
    annotation (Placement(transformation(extent={{42,66},{106,100}})));
  Modelica.Blocks.Sources.RealExpression tHotNom(y=THotNom)
    annotation (Placement(transformation(extent={{42,100},{104,134}})));
  CarnotCOP carnotCOPDesign1
    annotation (Placement(transformation(extent={{126,100},{146,120}})));
  Modelica.Blocks.Math.Product copDesign annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={168,90})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{158,20},{178,40}})));
equation
  connect(carnotCOPDesign.COP, cop.u1) annotation (Line(points={{-56.85,71.95},
          {-52,71.95},{-52,66},{-44,66}}, color={0,0,127}));
  connect(etaCarnot.y, cop.u2) annotation (Line(points={{-80.2,28},{-52,28},{-52,
          54},{-44,54}}, color={0,0,127}));
  connect(sigBus.TConOutMea, carnotCOPDesign.tHot) annotation (Line(
      points={{-0.925,100.07},{-40,100.07},{-40,92},{-94,92},{-94,76},{-80,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(sigBus.TEvaInMea, carnotCOPDesign.tCold) annotation (Line(
      points={{-0.925,100.07},{-44,100.07},{-44,112},{-102,112},{-102,68},{-80,
          68}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(qNom.y, productPel1.u1)
    annotation (Line(points={{-91.2,6},{-62,6}}, color={0,0,127}));
  connect(cop.y, division.u2) annotation (Line(points={{-21,60},{-12,60},{-12,2},
          {2,2}}, color={0,0,127}));
  connect(productPel1.y, division.u1) annotation (Line(points={{-39,0},{-26,0},
          {-26,14},{2,14}}, color={0,0,127}));
  connect(sigBus.nSet, productPel1.u2) annotation (Line(
      points={{-0.925,100.07},{0,100.07},{0,36},{-68,36},{-68,-6},{-62,-6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(productPel1.y, add1.u1) annotation (Line(points={{-39,0},{-26,0},{-26,
          -34},{58,-34}}, color={0,0,127}));
  connect(division.y, add1.u2) annotation (Line(points={{25,8},{42,8},{42,-46},
          {58,-46}}, color={0,0,127}));
  connect(add1.y, QEva)
    annotation (Line(points={{81,-40},{80,-40},{80,-110}}, color={0,0,127}));
  connect(division.y, Pel) annotation (Line(points={{25,8},{42,8},{42,-72},{0,
          -72},{0,-110}}, color={0,0,127}));
  connect(productPel1.y, QCon) annotation (Line(points={{-39,0},{-26,0},{-26,
          -48},{-80,-48},{-80,-110}}, color={0,0,127}));
  connect(qNom1.y, add2.u1) annotation (Line(points={{-21.2,156},{-12,156},{-12,
          154},{-4,154},{-4,150},{18,150}}, color={0,0,127}));
  connect(tSourceNom.y, carnotCOPDesign1.tCold) annotation (Line(points={{109.2,
          83},{109.2,106},{124,106}}, color={0,0,127}));
  connect(tHotNom.y, carnotCOPDesign1.tHot) annotation (Line(points={{107.1,117},
          {124,117},{124,114}}, color={0,0,127}));
  connect(etaCarnot.y, copDesign.u2) annotation (Line(points={{-80.2,28},{2,28},
          {2,26},{88,26},{88,32},{116,32},{116,84},{156,84}}, color={0,0,127}));
  connect(carnotCOPDesign1.COP, copDesign.u1) annotation (Line(points={{147.15,
          109.95},{156,109.95},{156,96}}, color={0,0,127}));
  connect(copDesign.y, division1.u1) annotation (Line(points={{179,90},{194,90},
          {194,52},{148,52},{148,36},{156,36}}, color={0,0,127}));
  connect(qNom.y, division1.u2) annotation (Line(points={{-91.2,6},{20,6},{20,
          20},{138,20},{138,24},{156,24}}, color={0,0,127}));
  connect(division1.y, add2.u2) annotation (Line(points={{179,30},{264,30},{264,
          138},{18,138}}, color={0,0,127}));
  connect(add2.y, sigBus.QEvapNom) annotation (Line(points={{41,144},{52,144},{
          52,46},{44,46},{44,100.07},{-0.925,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Carnot_COP_Reduced;
