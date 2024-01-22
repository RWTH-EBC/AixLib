within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model Control_Backup

  parameter Modelica.Units.SI.Temperature TRetDes=273.15 + 35
    "Return temperature"
   annotation (Dialog(group="Nominal condition"));

     parameter Modelica.Units.SI.Temperature TSupDes=273.15 + 55
    "Return temperature"
   annotation (Dialog(group="Nominal condition"));

    parameter Modelica.Units.SI.Temperature THotMax=363.15
    "Nominal flow temperature" annotation(Evaluate=false);

  AixLib.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1/20,
    Ti=190/(18000/20/4180),
    Td=1,
    yMin=0.01)
    annotation (Placement(transformation(extent={{-32,-70},{-12,-50}})));
  Modelica.Blocks.Sources.RealExpression tColdDes(y=TRetDes)
    "Design return temperature"
    annotation (Placement(transformation(extent={{-136,0},{-94,24}})));
  AixLib.Controls.Continuous.LimPID conPID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1/20,
    Ti=190/(18000/20/4180),
    Td=1,
    yMax=1,
    yMin=0.15)
    annotation (Placement(transformation(extent={{56,56},{76,76}})));
  Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=5,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-34,20},{-14,40}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{76,20},{96,40}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) "off"
    annotation (Placement(transformation(extent={{10,-2},{28,18}})));
  Modelica.Blocks.Logical.OnOffController onOffController1(bandwidth=5,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-34,56},{-14,76}})));
  Modelica.Blocks.Sources.RealExpression tSupMax(y=TSupDes)
    "Supply Set point for Full-Load"
    annotation (Placement(transformation(extent={{-64,104},{-14,136}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{42,-62},{62,-42}})));
  Modelica.Blocks.Sources.RealExpression number(y=1) "one"
    annotation (Placement(transformation(extent={{0,-56},{26,-32}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-68,62},{-48,82}})));
  Modelica.Blocks.Sources.RealExpression bandwithHalf(y=2.5)
    "half of OnOff-Controller Bandwith"
    annotation (Placement(transformation(extent={{-112,64},{-88,94}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{114,46},{134,66}})));
  Modelica.Blocks.Logical.OnOffController onOffController2(bandwidth=10,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{80,92},{100,112}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{6,114},{26,134}})));
  Modelica.Blocks.Sources.RealExpression bandwithHalf1(y=5)
    "half of OnOff-Controller Bandwith"
    annotation (Placement(transformation(extent={{-148,114},{-68,144}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{156,84},{176,104}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=273.15 - 2)
    "check if bivalent operating"
    annotation (Placement(transformation(extent={{120,112},{140,132}})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{198,40},{218,60}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression
    annotation (Placement(transformation(extent={{-70,96},{-50,116}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=TSupDes, uMin=TRetDes + (
        TSupDes - TRetDes)*0.15)
    annotation (Placement(transformation(extent={{14,76},{34,96}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold=273.15 + 15)
    "check if bivalent operating"
    annotation (Placement(transformation(extent={{-36,-116},{-16,-96}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{8,-118},{28,-98}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-126,34},{-106,54}})));
equation

  connect(tColdDes.y, conPID1.u_s) annotation (Line(points={{-91.9,12},{-80,12},
          {-80,-60},{-34,-60}}, color={0,0,127}));
  connect(boilerControlBus.TSupplyMea,conPID2. u_m) annotation (Line(
      points={{100,0},{66,0},{66,54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(conPID2.y, switch2.u1) annotation (Line(points={{77,66},{82,66},{82,
          46},{74,46},{74,38}},
                        color={0,0,127}));
  connect(onOffController.y, switch2.u2) annotation (Line(points={{-13,30},{74,
          30}},                  color={255,0,255}));
  connect(zero.y, switch2.u3)
    annotation (Line(points={{28.9,8},{58,8},{58,22},{74,22}},
                                                 color={0,0,127}));
  connect(boilerControlBus.TReturnMea, onOffController.u) annotation (Line(
      points={{100,0},{-44,0},{-44,24},{-36,24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TReturnMea, onOffController1.u) annotation (Line(
      points={{100,0},{-44,0},{-44,60},{-36,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch3.y, boilerControlBus.m_flowSet) annotation (Line(points={{63,-52},
          {84,-52},{84,0},{100,0}},                  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID1.y, switch3.u3) annotation (Line(points={{-11,-60},{40,-60}},
                         color={0,0,127}));
  connect(number.y, switch3.u1)
    annotation (Line(points={{27.3,-44},{40,-44}}, color={0,0,127}));
  connect(add.y, onOffController1.reference)
    annotation (Line(points={{-47,72},{-36,72}}, color={0,0,127}));
  connect(tColdDes.y, add.u2) annotation (Line(points={{-91.9,12},{-80,12},{-80,
          66},{-70,66}}, color={0,0,127}));
  connect(add.u1, bandwithHalf.y)
    annotation (Line(points={{-70,78},{-70,79},{-86.8,79}}, color={0,0,127}));
  connect(onOffController2.y, switch4.u2) annotation (Line(points={{101,102},{106,
          102},{106,56},{112,56}}, color={255,0,255}));
  connect(switch2.y, switch4.u1) annotation (Line(points={{97,30},{102,30},{102,
          64},{112,64}}, color={0,0,127}));
  connect(zero.y, switch4.u3) annotation (Line(points={{28.9,8},{52,8},{52,24},
          {54,24},{54,48},{112,48}}, color={0,0,127}));
  connect(boilerControlBus.TSupplyMea, onOffController2.u) annotation (Line(
      points={{100,0},{50,0},{50,96},{78,96}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add1.y, onOffController2.reference) annotation (Line(points={{27,124},
          {46,124},{46,108},{78,108}}, color={0,0,127}));
  connect(bandwithHalf1.y, add1.u1) annotation (Line(points={{-64,129},{-64,130},
          {4,130}},           color={0,0,127}));
  connect(boilerControlBus.TReturnMea, conPID1.u_m) annotation (Line(
      points={{100,0},{-44,0},{-44,-84},{-22,-84},{-22,-72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch4.y, switch5.u1) annotation (Line(points={{135,56},{138,56},{
          138,102},{154,102}}, color={0,0,127}));
  connect(zero.y, switch5.u3) annotation (Line(points={{28.9,8},{146,8},{146,86},
          {154,86}},                   color={0,0,127}));
  connect(lessThreshold.y, switch5.u2) annotation (Line(points={{141,122},{154,
          122},{154,94}}, color={255,0,255}));
  connect(boilerControlBus.TOut, lessThreshold.u) annotation (Line(
      points={{100,0},{98,0},{98,122},{118,122}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch5.y, switch6.u1) annotation (Line(points={{177,94},{184,94},{
          184,92},{190,92},{190,58},{196,58}}, color={0,0,127}));
  connect(switch4.y, switch6.u3) annotation (Line(points={{135,56},{166,56},{
          166,42},{196,42}}, color={0,0,127}));
  connect(switch6.y, boilerControlBus.FirRatSet) annotation (Line(points={{219,
          50},{236,50},{236,46},{252,46},{252,0},{100,0}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanExpression.y, switch6.u2) annotation (Line(points={{-49,106},{
          152,106},{152,50},{196,50}}, color={255,0,255}));
  connect(tSupMax.y, add1.u2) annotation (Line(points={{-11.5,120},{6,120},{6,
          118},{4,118}}, color={0,0,127}));
  connect(boilerControlBus.TSupplySet, limiter.u) annotation (Line(
      points={{100,0},{62,0},{62,20},{12,20},{12,86}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(limiter.y, conPID2.u_s) annotation (Line(points={{35,86},{38,86},{38,
          84},{42,84},{42,68},{54,68},{54,66}}, color={0,0,127}));
  connect(lessThreshold1.y, or1.u1) annotation (Line(points={{-15,-106},{-6,
          -106},{-6,-108},{6,-108}}, color={255,0,255}));
  connect(onOffController1.y, or1.u2) annotation (Line(points={{-13,66},{-2,66},
          {-2,-116},{6,-116}}, color={255,0,255}));
  connect(boilerControlBus.TReturnMea, lessThreshold1.u) annotation (Line(
      points={{100,0},{-10,0},{-10,-16},{-92,-16},{-92,-106},{-38,-106},{-38,
          -106}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(or1.y, switch3.u2) annotation (Line(points={{29,-108},{40,-108},{40,
          -52}}, color={255,0,255}));
  connect(add2.y, onOffController.reference) annotation (Line(points={{-105,44},
          {-86,44},{-86,42},{-62,42},{-62,34},{-36,34},{-36,36}}, color={0,0,
          127}));
  connect(bandwithHalf.y, add2.u1) annotation (Line(points={{-86.8,79},{-86.8,
          64},{-128,64},{-128,50}}, color={0,0,127}));
  connect(tColdDes.y, add2.u2) annotation (Line(points={{-91.9,12},{-91.9,26},{
          -128,26},{-128,38}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Control_Backup;
