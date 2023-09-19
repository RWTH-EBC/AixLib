within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model Control

  parameter Modelica.Units.SI.Temperature TRetDes=273.15 + 35
    "Return temperature"
   annotation (Dialog(group="Nominal condition"));

  AixLib.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=5,
    Td=1,
    yMin=0.01)
    annotation (Placement(transformation(extent={{-32,-70},{-12,-50}})));
  Modelica.Blocks.Sources.RealExpression tColdDes(y=TRetDes)
    "Design return temperature"
    annotation (Placement(transformation(extent={{-136,0},{-94,24}})));
  AixLib.Controls.Continuous.LimPID conPID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=5,
    Td=1,
    yMax=1,
    yMin=0.15)
    annotation (Placement(transformation(extent={{56,56},{76,76}})));
  Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=4,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-34,20},{-14,40}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{76,20},{96,40}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) "off"
    annotation (Placement(transformation(extent={{28,12},{46,32}})));
  Modelica.Blocks.Logical.OnOffController onOffController1(bandwidth=5,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-34,56},{-14,76}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{22,56},{42,76}})));
  Modelica.Blocks.Sources.RealExpression tSupMax(y=TRetDes + 20)
    "Supply Set point for Full-Load"
    annotation (Placement(transformation(extent={{-44,74},{6,106}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{42,-62},{62,-42}})));
  Modelica.Blocks.Sources.RealExpression number(y=1) "one"
    annotation (Placement(transformation(extent={{0,-56},{26,-32}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-68,62},{-48,82}})));
  Modelica.Blocks.Sources.RealExpression bandwithHalf(y=2.5)
    "half of OnOff-Controller Bandwith"
    annotation (Placement(transformation(extent={{-112,64},{-88,94}})));
equation
  connect(tColdDes.y, conPID1.u_s) annotation (Line(points={{-91.9,12},{-80,12},
          {-80,-60},{-34,-60}}, color={0,0,127}));
  connect(boilerControlBus.TReturnMea,conPID1. u_m) annotation (Line(
      points={{100,0},{-94,0},{-94,-80},{-22,-80},{-22,-72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
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
  connect(switch2.y, boilerControlBus.FirRatSet) annotation (Line(points={{97,30},
          {102,30},{102,14},{86,14},{86,0},{100,0}},
                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(onOffController.y, switch2.u2) annotation (Line(points={{-13,30},{74,
          30}},                  color={255,0,255}));
  connect(zero.y, switch2.u3)
    annotation (Line(points={{46.9,22},{74,22}}, color={0,0,127}));
  connect(boilerControlBus.TReturnMea, onOffController.u) annotation (Line(
      points={{100,0},{-44,0},{-44,24},{-36,24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(tColdDes.y, onOffController.reference) annotation (Line(points={{
          -91.9,12},{-80,12},{-80,36},{-36,36}}, color={0,0,127}));
  connect(onOffController1.y, switch1.u2)
    annotation (Line(points={{-13,66},{20,66}},  color={255,0,255}));
  connect(boilerControlBus.TSupplySet, switch1.u3) annotation (Line(
      points={{100,0},{20,0},{20,58}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(tSupMax.y, switch1.u1)
    annotation (Line(points={{8.5,90},{20,90},{20,74}}, color={0,0,127}));
  connect(switch1.y, conPID2.u_s) annotation (Line(points={{43,66},{54,66}},
                                              color={0,0,127}));
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
  connect(onOffController1.y, switch3.u2) annotation (Line(points={{-13,66},{-6,
          66},{-6,-52},{40,-52}},                       color={255,0,255}));
  connect(number.y, switch3.u1)
    annotation (Line(points={{27.3,-44},{40,-44}}, color={0,0,127}));
  connect(add.y, onOffController1.reference)
    annotation (Line(points={{-47,72},{-36,72}}, color={0,0,127}));
  connect(tColdDes.y, add.u2) annotation (Line(points={{-91.9,12},{-80,12},{-80,
          66},{-70,66}}, color={0,0,127}));
  connect(add.u1, bandwithHalf.y)
    annotation (Line(points={{-70,78},{-70,79},{-86.8,79}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Control;
