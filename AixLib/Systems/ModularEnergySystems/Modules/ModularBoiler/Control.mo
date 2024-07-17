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
    yMin=0)
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  AixLib.Controls.Continuous.LimPID conPID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1/20,
    Ti=190/(18000/20/4180),
    Td=1,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{56,56},{76,76}})));
  Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) "off"
    annotation (Placement(transformation(extent={{-2,38},{16,58}})));
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
  Modelica.Blocks.Interfaces.RealInput tSupplySet
    annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
  Modelica.Blocks.Interfaces.RealInput tReturnSet
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput tReturn
    annotation (Placement(transformation(extent={{-140,-90},{-100,-50}})));
equation



  connect(boilerControlBus.TSupplyMea,conPID2. u_m) annotation (Line(
      points={{100,0},{66,0},{66,54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(onOffController2.y, switch4.u2) annotation (Line(points={{101,102},{106,
          102},{106,56},{112,56}}, color={255,0,255}));
  connect(zero.y, switch4.u3) annotation (Line(points={{16.9,48},{112,48}},
                                     color={0,0,127}));
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
  connect(tSupplySet, conPID2.u_s) annotation (Line(points={{-120,100},{18,100},
          {18,66},{54,66}},         color={0,0,127}));
  connect(tSupplySet, boilerControlBus.TSupplySet) annotation (Line(points={{-120,
          100},{-46,100},{-46,82},{-22,82},{-22,0},{100,0}},    color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID2.y, switch4.u1) annotation (Line(points={{77,66},{94,66},{94,
          64},{112,64}}, color={0,0,127}));
  connect(tSupplySet, add1.u2) annotation (Line(points={{-120,100},{-46,100},{
          -46,118},{4,118}}, color={0,0,127}));
  connect(switch4.y, boilerControlBus.FirRatSet) annotation (Line(points={{135,
          56},{186,56},{186,0},{100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID1.y, boilerControlBus.m_flowSet) annotation (Line(points={{-9,-40},
          {26,-40},{26,-62},{100,-62},{100,0}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tReturnSet, conPID1.u_s) annotation (Line(points={{-120,50},{-58,50},
          {-58,-40},{-32,-40}}, color={0,0,127}));
  connect(tReturn, conPID1.u_m) annotation (Line(points={{-120,-70},{-20,-70},{
          -20,-52}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Control;
