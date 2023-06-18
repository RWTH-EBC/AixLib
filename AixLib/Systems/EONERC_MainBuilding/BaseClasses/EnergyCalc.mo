within AixLib.Systems.EONERC_MainBuilding.BaseClasses;
model EnergyCalc
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Math.Gain gain(k=4.18*1000)
    annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Interfaces.RealInput Tin2 annotation (Placement(
        transformation(rotation=0, extent={{-120,-42},{-100,-20}}),
        iconTransformation(extent={{-120,-40},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput Tout2 annotation (Placement(
        transformation(rotation=0, extent={{-120,-80},{-100,-60}}),
        iconTransformation(extent={{-120,-80},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput Tin1 annotation (Placement(
        transformation(rotation=0, extent={{-120,58},{-100,80}}),
        iconTransformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput Tout1 annotation (Placement(
        transformation(rotation=0, extent={{-120,23},{-100,40}}),
        iconTransformation(extent={{-120,20},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput vFlow2 annotation (Placement(
        transformation(
        rotation=90,
        extent={{-10,-10},{10,10}},
        origin={-50,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-110})));
  Modelica.Blocks.Interfaces.RealInput vFlow1 annotation (Placement(
        transformation(
        rotation=270,
        extent={{-9.75,-10.25},{9.75,10.25}},
        origin={-49.75,110.25}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,110})));
  Modelica.Blocks.Interfaces.RealOutput y1
                          "Output signal connector"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput y2
               "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput y3
               "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
equation
  connect(add.y, gain.u)
    annotation (Line(points={{41,0},{56,0}}, color={0,0,127}));
  connect(product1.y, add.u2) annotation (Line(points={{1,-50},{12,-50},{12,-6},
          {18,-6}}, color={0,0,127}));
  connect(product2.y, add.u1)
    annotation (Line(points={{1,50},{12,50},{12,6},{18,6}}, color={0,0,127}));
  connect(add2.y, product2.u2) annotation (Line(points={{-59,30},{-28,30},{-28,
          44},{-22,44}}, color={0,0,127}));
  connect(Tin2, add1.u1) annotation (Line(points={{-110,-31},{-88,-31},{-88,-24},
          {-82,-24}}, color={0,0,127}));
  connect(Tout2, add1.u2) annotation (Line(points={{-110,-70},{-88,-70},{-88,
          -36},{-82,-36}}, color={0,0,127}));
  connect(Tin1, add2.u1) annotation (Line(points={{-110,69},{-88,69},{-88,36},{
          -82,36}}, color={0,0,127}));
  connect(Tout1, add2.u2) annotation (Line(points={{-110,31.5},{-90,31.5},{-90,
          24},{-82,24}}, color={0,0,127}));
  connect(vFlow1, product2.u1) annotation (Line(points={{-49.75,110.25},{-50,
          110.25},{-50,56},{-22,56}}, color={0,0,127}));
  connect(gain.y, y1)
    annotation (Line(points={{79,0},{110,0}}, color={0,0,127}));
  connect(add1.y, product1.u1) annotation (Line(points={{-59,-30},{-28,-30},{
          -28,-44},{-22,-44}}, color={0,0,127}));
  connect(vFlow2, product1.u2) annotation (Line(points={{-50,-110},{-50,-56},{
          -22,-56}}, color={0,0,127}));
  connect(product2.y, y2) annotation (Line(points={{1,50},{96,50},{96,90},{110,
          90}}, color={0,0,127}));
  connect(product1.y, y3) annotation (Line(points={{1,-50},{52,-50},{52,-90},{
          110,-90}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}})), Icon(
        coordinateSystem(extent={{-100,-100},{100,100}})));
end EnergyCalc;
