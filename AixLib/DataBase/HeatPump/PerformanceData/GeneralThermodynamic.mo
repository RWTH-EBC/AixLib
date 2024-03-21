within AixLib.DataBase.HeatPump.PerformanceData;
model GeneralThermodynamic

   extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;





  CarnotCOP carnotCOPDesign
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  CarnotCOP carnotCOPOffDesign
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Sources.RealExpression tSourceNom(y=TSourceNom)
    annotation (Placement(transformation(extent={{-128,72},{-102,96}})));
  Modelica.Blocks.Sources.RealExpression tHotNom(y=THotNom)
    annotation (Placement(transformation(extent={{-124,90},{-102,114}})));
  Modelica.Blocks.Sources.RealExpression qNom(y=QNom)
    annotation (Placement(transformation(extent={{-150,-6},{-94,18}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
  Modelica.Blocks.Sources.RealExpression etaCarnot(y=eta_carnot)
                                                          "Guetegrad"
    annotation (Placement(transformation(extent={{-118,18},{-82,38}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{0,-2},{20,18}})));
  Modelica.Blocks.Math.Product copDesign annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-38,70})));
  Modelica.Blocks.Math.Product copOffDesign annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={72,0})));
  Modelica.Blocks.Math.Product productPel annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-30})));
  Modelica.Blocks.Math.Product qConOffDesign annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-50,-50})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation
  connect(tSourceNom.y, carnotCOPDesign.tCold)
    annotation (Line(points={{-100.7,84},{-92,84},{-92,86},{-82,86}},
                                                    color={0,0,127}));
  connect(tHotNom.y, carnotCOPDesign.tHot) annotation (Line(points={{-100.9,102},
          {-90,102},{-90,94},{-82,94}},color={0,0,127}));
  connect(sigBus.TConOutMea, carnotCOPOffDesign.tHot) annotation (Line(
      points={{-0.925,100.07},{0,100.07},{0,54},{38,54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TEvaInMea, carnotCOPOffDesign.tCold) annotation (Line(
      points={{-0.925,100.07},{-2,100.07},{-2,46},{38,46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(carnotCOPDesign.COP, copDesign.u1) annotation (Line(points={{-58.85,
          89.95},{-54.425,89.95},{-54.425,76},{-50,76}},
                                                  color={0,0,127}));
  connect(etaCarnot.y, copDesign.u2) annotation (Line(points={{-80.2,28},{-56,
          28},{-56,64},{-50,64}},
                              color={0,0,127}));
  connect(copDesign.y, division1.u2) annotation (Line(points={{-27,70},{-16,70},
          {-16,24},{-64,24},{-64,4},{-50,4}}, color={0,0,127}));
  connect(qNom.y, division1.u1) annotation (Line(points={{-91.2,6},{-78,6},{-78,
          16},{-50,16}}, color={0,0,127}));
  connect(qNom.y, add.u1) annotation (Line(points={{-91.2,6},{-84,6},{-84,8},{-80,
          8},{-80,-6},{-14,-6},{-14,14},{-2,14}}, color={0,0,127}));
  connect(division1.y, add.u2) annotation (Line(points={{-27,10},{-20,10},{-20,2},
          {-2,2}}, color={0,0,127}));
  connect(add.y, sigBus.QEvapNom) annotation (Line(points={{21,8},{32,8},{32,32},
          {-4,32},{-4,76},{-0.925,76},{-0.925,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(carnotCOPOffDesign.COP, copOffDesign.u1) annotation (Line(points={{61.15,
          49.95},{72,49.95},{72,26},{54,26},{54,6},{60,6}}, color={0,0,127}));
  connect(etaCarnot.y, copOffDesign.u2) annotation (Line(points={{-80.2,28},{42,
          28},{42,-8},{56,-8},{56,-6},{60,-6}}, color={0,0,127}));
  connect(division1.y, productPel.u2)
    annotation (Line(points={{-27,10},{-6,10},{-6,-18}}, color={0,0,127}));
  connect(productPel.y, Pel) annotation (Line(points={{-1.9984e-15,-41},{-1.9984e-15,
          -110},{0,-110}}, color={0,0,127}));
  connect(productPel.y, qConOffDesign.u1) annotation (Line(points={{-1.9984e-15,
          -41},{-1.9984e-15,-44},{-38,-44}}, color={0,0,127}));
  connect(copOffDesign.y, qConOffDesign.u2) annotation (Line(points={{83,0},{88,
          0},{88,-56},{-38,-56}}, color={0,0,127}));
  connect(qConOffDesign.y, QCon) annotation (Line(points={{-61,-50},{-80,-50},{-80,
          -110}}, color={0,0,127}));
  connect(qConOffDesign.y, add1.u1) annotation (Line(points={{-61,-50},{-60,-50},
          {-60,-78},{20,-78},{20,-34},{38,-34}}, color={0,0,127}));
  connect(productPel.y, add1.u2)
    annotation (Line(points={{0,-41},{0,-46},{38,-46}}, color={0,0,127}));
  connect(add1.y, QEva)
    annotation (Line(points={{61,-40},{80,-40},{80,-110}}, color={0,0,127}));
  connect(sigBus.nSet, productPel.u1) annotation (Line(
      points={{-0.925,100.07},{-0.925,-12},{6,-12},{6,-18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GeneralThermodynamic;
