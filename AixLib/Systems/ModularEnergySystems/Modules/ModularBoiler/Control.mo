within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model Control

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
    annotation (Placement(transformation(extent={{166,94},{186,114}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=273.15 + 15)
    "check if bivalent operating"
    annotation (Placement(transformation(extent={{118,120},{138,140}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=TSupDes, uMin=TRetDes + (
        TSupDes - TRetDes)*0.15)
    annotation (Placement(transformation(extent={{14,76},{34,96}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold=273.15 + 20)
    "check if bivalent operating"
    annotation (Placement(transformation(extent={{-36,-116},{-16,-96}})));
  Modelica.Blocks.Math.Add add2
    annotation (Placement(transformation(extent={{-126,34},{-106,54}})));
  AixLib.Controls.Continuous.LimPID conPID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1/20,
    Ti=190/(18000/20/4180),
    Td=1,
    yMin=0.01)
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{138,-50},{158,-30}})));
  Modelica.Blocks.Sources.RealExpression number1(y=293.15)
                                                     "one"
    annotation (Placement(transformation(extent={{0,-92},{26,-68}})));
  AixLib.Controls.Continuous.LimPID conPID4(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1/20,
    Ti=190/(18000/20/4180),
    Td=1,
    yMax=1,
    yMin=0.15)
    annotation (Placement(transformation(extent={{148,12},{168,32}})));
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
  connect(add.y, onOffController1.reference)
    annotation (Line(points={{-47,72},{-36,72}}, color={0,0,127}));
  connect(tColdDes.y, add.u2) annotation (Line(points={{-91.9,12},{-80,12},{-80,
          66},{-70,66}}, color={0,0,127}));
  connect(add.u1, bandwithHalf.y)
    annotation (Line(points={{-70,78},{-70,79},{-86.8,79}}, color={0,0,127}));
  connect(onOffController2.y, switch4.u2) annotation (Line(points={{101,102},{106,
          102},{106,56},{112,56}}, color={255,0,255}));
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
  connect(lessThreshold.y, switch5.u2) annotation (Line(points={{139,130},{164,
          130},{164,104}},color={255,0,255}));
  connect(boilerControlBus.TOut, lessThreshold.u) annotation (Line(
      points={{100,0},{98,0},{98,130},{116,130}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
  connect(boilerControlBus.TReturnMea, lessThreshold1.u) annotation (Line(
      points={{100,0},{-10,0},{-10,-16},{-92,-16},{-92,-106},{-38,-106},{-38,
          -106}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(add2.y, onOffController.reference) annotation (Line(points={{-105,44},
          {-86,44},{-86,42},{-62,42},{-62,34},{-36,34},{-36,36}}, color={0,0,
          127}));
  connect(bandwithHalf.y, add2.u1) annotation (Line(points={{-86.8,79},{-86.8,
          64},{-128,64},{-128,50}}, color={0,0,127}));
  connect(tColdDes.y, add2.u2) annotation (Line(points={{-91.9,12},{-91.9,26},{
          -128,26},{-128,38}}, color={0,0,127}));
  connect(lessThreshold.y, switch7.u2) annotation (Line(points={{139,130},{139,
          44},{136,44},{136,-40}}, color={255,0,255}));
  connect(switch7.y, boilerControlBus.m_flowSet) annotation (Line(points={{159,
          -40},{166,-40},{166,-16},{100,-16},{100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID3.y, switch7.u3) annotation (Line(points={{101,-90},{124,-90},{
          124,-48},{136,-48}}, color={0,0,127}));
  connect(boilerControlBus.TReturnMea, conPID3.u_m) annotation (Line(
      points={{100,0},{100,-64},{116,-64},{116,-122},{90,-122},{90,-102}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(number1.y, conPID3.u_s) annotation (Line(points={{27.3,-80},{64,-80},
          {64,-90},{78,-90}}, color={0,0,127}));
  connect(boilerControlBus.TSupplyMea, conPID4.u_m) annotation (Line(
      points={{100,0},{128,0},{128,-2},{158,-2},{158,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(tColdDes.y, conPID4.u_s) annotation (Line(points={{-91.9,12},{18,12},
          {18,16},{120,16},{120,22},{146,22}}, color={0,0,127}));
  connect(conPID4.y, switch5.u3) annotation (Line(points={{169,22},{174,22},{
          174,96},{164,96}}, color={0,0,127}));
  connect(conPID1.y, switch7.u1) annotation (Line(points={{-11,-60},{70,-60},{
          70,-32},{136,-32}}, color={0,0,127}));
  connect(switch2.y, switch5.u1) annotation (Line(points={{97,30},{120,30},{120,
          32},{148,32},{148,84},{152,84},{152,112},{164,112}}, color={0,0,127}));
  connect(switch5.y, switch4.u1) annotation (Line(points={{187,104},{194,104},{
          194,98},{198,98},{198,64},{112,64}}, color={0,0,127}));
  connect(switch4.y, boilerControlBus.FirRatSet) annotation (Line(points={{135,
          56},{162,56},{162,54},{192,54},{192,0},{100,0}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Control;
