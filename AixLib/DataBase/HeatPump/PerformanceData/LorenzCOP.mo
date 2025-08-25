within AixLib.DataBase.HeatPump.PerformanceData;
model LorenzCOP


   extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

  Modelica.Blocks.Sources.RealExpression tSourceNom(y=TSourceNom)
    annotation (Placement(transformation(extent={{-204,68},{-140,102}})));
  Modelica.Blocks.Sources.RealExpression tHotNom(y=THotNom)
    annotation (Placement(transformation(extent={{-178,124},{-116,158}})));
  Modelica.Blocks.Sources.RealExpression qNom(y=QNom)
    annotation (Placement(transformation(extent={{-150,-6},{-94,18}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-48,0},{-28,20}})));
  Modelica.Blocks.Sources.RealExpression etaCarnot(y=0.5) "Guetegrad"
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
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=20, uMin=0)
    annotation (Placement(transformation(extent={{84,40},{104,60}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{60,100},{80,120}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{108,92},{128,112}})));
  Modelica.Blocks.Sources.RealExpression etaCarnot1(y=0)  "Guetegrad"
    annotation (Placement(transformation(extent={{10,70},{46,90}})));
  BaseClasses.LorenzCOP lorenzCOP
    annotation (Placement(transformation(extent={{-76,86},{-56,106}})));
  Modelica.Blocks.Sources.RealExpression tHotNom1(y=THotNom - 5)
    annotation (Placement(transformation(extent={{-198,96},{-136,130}})));
  Modelica.Blocks.Sources.RealExpression tSourceNom1(y=TSourceNom - 3)
    annotation (Placement(transformation(extent={{-204,42},{-140,76}})));
  BaseClasses.LorenzCOP lorenzCOP1
    annotation (Placement(transformation(extent={{26,46},{46,66}})));
equation
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
  connect(etaCarnot.y, copOffDesign.u2) annotation (Line(points={{-80.2,28},{42,
          28},{42,-8},{56,-8},{56,-6},{60,-6}}, color={0,0,127}));
  connect(division1.y, productPel.u2)
    annotation (Line(points={{-27,10},{-6,10},{-6,-18}}, color={0,0,127}));
  connect(productPel.y, Pel) annotation (Line(points={{-1.9984e-15,-41},{-1.9984e-15,
          -110},{0,-110}}, color={0,0,127}));
  connect(productPel.y, qConOffDesign.u1) annotation (Line(points={{-1.9984e-15,
          -41},{-1.9984e-15,-44},{-38,-44}}, color={0,0,127}));
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
  connect(copOffDesign.y, qConOffDesign.u2) annotation (Line(points={{83,0},{
          126,0},{126,-56},{-38,-56}}, color={0,0,127}));
  connect(limiter.y, copOffDesign.u1) annotation (Line(points={{105,50},{114,50},
          {114,22},{60,22},{60,6}}, color={0,0,127}));
  connect(sigBus.TConOutMea, greater.u1) annotation (Line(
      points={{-0.925,100.07},{14,100.07},{14,98},{26,98},{26,110},{58,110}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TEvaInMea, greater.u2) annotation (Line(
      points={{-0.925,100.07},{24,100.07},{24,102},{58,102}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(greater.y, switch1.u2) annotation (Line(points={{81,110},{86,110},{86,
          108},{90,108},{90,102},{106,102}}, color={255,0,255}));
  connect(switch1.y, limiter.u) annotation (Line(points={{129,102},{146,102},{
          146,70},{82,70},{82,50}}, color={0,0,127}));
  connect(etaCarnot1.y, switch1.u3) annotation (Line(points={{47.8,80},{52,80},
          {52,82},{58,82},{58,90},{106,90},{106,94}}, color={0,0,127}));
  connect(tHotNom.y, lorenzCOP.tHot_out) annotation (Line(points={{-112.9,141},
          {-100,141},{-100,105},{-78,105}}, color={0,0,127}));
  connect(tHotNom1.y, lorenzCOP.tHot_in) annotation (Line(points={{-132.9,113},
          {-122,113},{-122,100},{-78,100}}, color={0,0,127}));
  connect(tSourceNom.y, lorenzCOP.tCold_in) annotation (Line(points={{-136.8,85},
          {-112,85},{-112,92},{-78,92}}, color={0,0,127}));
  connect(tSourceNom1.y, lorenzCOP.tCold_out) annotation (Line(points={{-136.8,
          59},{-96,59},{-96,87},{-78,87}}, color={0,0,127}));
  connect(lorenzCOP.COP, copDesign.u1) annotation (Line(points={{-54.85,95.95},
          {-50,95.95},{-50,76}}, color={0,0,127}));

  connect(lorenzCOP1.COP, switch1.u1) annotation (Line(points={{47.15,55.95},{
          66,55.95},{66,78},{96,78},{96,110},{106,110}}, color={0,0,127}));
  connect(sigBus.TConOutMea, lorenzCOP1.tHot_out) annotation (Line(
      points={{-0.925,100.07},{2,100.07},{2,65},{24,65}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConInMea, lorenzCOP1.tHot_in) annotation (Line(
      points={{-0.925,100.07},{2,100.07},{2,58},{24,58},{24,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TEvaInMea, lorenzCOP1.tCold_in) annotation (Line(
      points={{-0.925,100.07},{2,100.07},{2,52},{24,52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TEvaOutMea, lorenzCOP1.tCold_out) annotation (Line(
      points={{-0.925,100.07},{0,100.07},{0,47},{24,47}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LorenzCOP;
