within AixLib.Utilities.KPIs.Examples;
model IntegralErrors
  "Comparison of different models for integral errors"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Pulse pul(
    amplitude=1,
    period=2,
    offset=-0.5) "Pulse as input signal"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Constant conZero(k=0)
    "Constant zero as reference value"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  IntegralAbsoluteError iae "IAE"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  IntegralSquareError ise "ISE"
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  IntegralErrorWithFilter intErrPos(posFil=true) "Integral error positive"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  IntegralErrorWithFilter intErrNeg(posFil=false) "Integral error negative"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  IntegralErrorWithFilter intErrPosRes(use_reset=true, posFil=true)
    "Integral error positive with reset"
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Modelica.Blocks.Logical.Not not1 "Not"
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
equation
  connect(pul.y, iae.u) annotation (Line(points={{-79,50},{-40,50},{-40,96},{-2,
          96}}, color={0,0,127}));
  connect(pul.y, ise.u) annotation (Line(points={{-79,50},{-40,50},{-40,56},{-2,
          56}}, color={0,0,127}));
  connect(conZero.y, iae.ref) annotation (Line(points={{-79,-50},{-20,-50},{-20,
          84},{-2,84}}, color={0,0,127}));
  connect(conZero.y, ise.ref) annotation (Line(points={{-79,-50},{-20,-50},{-20,
          44},{-2,44}}, color={0,0,127}));
  connect(pul.y, intErrPos.u) annotation (Line(points={{-79,50},{-40,50},{-40,
          16},{-2,16}}, color={0,0,127}));
  connect(conZero.y, intErrPos.ref) annotation (Line(points={{-79,-50},{-20,-50},
          {-20,4},{-2,4}}, color={0,0,127}));
  connect(pul.y, intErrNeg.u) annotation (Line(points={{-79,50},{-40,50},{-40,
          -24},{-2,-24}}, color={0,0,127}));
  connect(conZero.y, intErrNeg.ref) annotation (Line(points={{-79,-50},{-20,-50},
          {-20,-36},{-2,-36}}, color={0,0,127}));
  connect(pul.y, intErrPosRes.u) annotation (Line(points={{-79,50},{-40,50},{
          -40,-64},{-2,-64}}, color={0,0,127}));
  connect(conZero.y, intErrPosRes.ref) annotation (Line(points={{-79,-50},{-20,
          -50},{-20,-76},{-2,-76}}, color={0,0,127}));
  connect(intErrPosRes.yFil, not1.u) annotation (Line(points={{21,-64},{30,-64},
          {30,-70},{38,-70}}, color={255,0,255}));
  connect(not1.y, intErrPosRes.reset) annotation (Line(points={{61,-70},{70,-70},
          {70,-90},{10,-90},{10,-82}}, color={255,0,255}));
  annotation (experiment(
      StopTime=10,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"));
end IntegralErrors;
