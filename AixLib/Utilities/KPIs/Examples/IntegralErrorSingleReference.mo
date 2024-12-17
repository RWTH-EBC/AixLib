within AixLib.Utilities.KPIs.Examples;
model IntegralErrorSingleReference
  "Comparison of different models for integral errors with single reference"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Pulse pul(
    amplitude=1.5,
    period=2,
    offset=-0.5)
    "Pulse as input value"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant conZeroRef(k=0)
    "Constant zero as reference value"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.BooleanStep booSteItgAct(startTime=4)
    "Boolean source to activate integrators"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.BooleanStep booSteItgRes(startTime=8)
    "Boolean source to reset integrators"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralAbsoluteError iae "IAE simple"
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralAbsoluteError iaeAct(use_itgAct_in=true)
    "IAE with activation connector"
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralAbsoluteError iaeActRes(
    use_itgAct_in=true, use_itgRes_in=true) "IAE with activation and reset connectors"
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralSquareError ise "ISE smiple"
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralTimer itgTim(
    use_itgRes_in=false)
    "Integral timer simple"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralTimer itgTimRes(
    use_itgRes_in=true)
    "Integral timer with reset connector"
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itgErrPos
    "Integral positive errors simple"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itgErrNeg(
    posItg=false)
    "Integral negative errors simple"
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itgErrPosAct(
    use_itgAct_in=true)
    "Integral positive errors with activation connector"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itgErrPosActRes(
      use_itgAct_in=true, use_itgRes_in=true)
    "Integral positive errors with activation and reset connectors"
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Logical.Not not1 "Not logic"
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
equation
  connect(pul.y, iae.u)
    annotation (Line(points={{-79,90},{-22,90}}, color={0,0,127}));
  connect(conZeroRef.y, iae.ref) annotation (Line(points={{-79,0},{-60,0},{-60,84},
          {-22,84}},     color={0,0,127}));
  connect(pul.y, iaeAct.u) annotation (Line(points={{-79,90},{-40,90},{-40,70},{
          10,70},{10,90},{18,90}}, color={0,0,127}));
  connect(conZeroRef.y, iaeAct.ref) annotation (Line(points={{-79,0},{-60,0},{-60,
          84},{-38,84},{-38,68},{12,68},{12,84},{18,84}},     color={0,0,127}));
  connect(booSteItgAct.y, iaeAct.itgAct_in) annotation (Line(points={{-79,-50},{
          10,-50},{10,66},{30,66},{30,78}}, color={255,0,255}));
  connect(pul.y, iaeActRes.u) annotation (Line(points={{-79,90},{-40,90},{-40,70},
          {50,70},{50,90},{58,90}}, color={0,0,127}));
  connect(conZeroRef.y, iaeActRes.ref) annotation (Line(points={{-79,0},{-60,0},
          {-60,84},{-38,84},{-38,68},{52,68},{52,84},{58,84}}, color={0,0,127}));
  connect(booSteItgAct.y, iaeActRes.itgAct_in) annotation (Line(points={{-79,-50},
          {10,-50},{10,66},{70,66},{70,78}}, color={255,0,255}));
  connect(booSteItgRes.y, iaeActRes.itgRes_in) annotation (Line(points={{-79,-90},
          {50,-90},{50,64},{76,64},{76,78}}, color={255,0,255}));
  connect(pul.y, ise.u) annotation (Line(points={{-79,90},{-70,90},{-70,50},{-22,
          50}}, color={0,0,127}));
  connect(conZeroRef.y, ise.ref) annotation (Line(points={{-79,0},{-60,0},{-60,44},
          {-22,44}}, color={0,0,127}));
  connect(booSteItgAct.y, itgTim.itgAct_in) annotation (Line(points={{-79,-50},{
          10,-50},{10,28},{30,28},{30,38}}, color={255,0,255}));
  connect(booSteItgAct.y, itgTimRes.itgAct_in) annotation (Line(points={{-79,-50},
          {10,-50},{10,28},{70,28},{70,38}}, color={255,0,255}));
  connect(booSteItgRes.y, itgTimRes.itgRes_in) annotation (Line(points={{-79,-90},
          {50,-90},{50,26},{76,26},{76,38}}, color={255,0,255}));
  connect(pul.y, itgErrPos.u) annotation (Line(points={{-79,90},{-70,90},{-70,10},
          {-22,10}}, color={0,0,127}));
  connect(conZeroRef.y, itgErrPos.ref) annotation (Line(points={{-79,0},{-60,0},
          {-60,4},{-22,4}}, color={0,0,127}));
  connect(pul.y, itgErrNeg.u) annotation (Line(points={{-79,90},{-70,90},{-70,10},
          {-40,10},{-40,-10},{12,-10},{12,10},{18,10}}, color={0,0,127}));
  connect(conZeroRef.y, itgErrNeg.ref) annotation (Line(points={{-79,0},{-60,0},
          {-60,4},{-38,4},{-38,-12},{14,-12},{14,4},{18,4}}, color={0,0,127}));
  connect(pul.y, itgErrPosAct.u) annotation (Line(points={{-79,90},{-70,90},{-70,
          -30},{-22,-30}}, color={0,0,127}));
  connect(conZeroRef.y, itgErrPosAct.ref) annotation (Line(points={{-79,0},{-60,
          0},{-60,-36},{-22,-36}}, color={0,0,127}));
  connect(booSteItgAct.y, itgErrPosAct.itgAct_in) annotation (Line(points={{-79,
          -50},{-10,-50},{-10,-42}}, color={255,0,255}));
  connect(pul.y, itgErrPosActRes.u) annotation (Line(points={{-79,90},{-70,90},{
          -70,-30},{-40,-30},{-40,-44},{12,-44},{12,-30},{18,-30}}, color={0,0,127}));
  connect(conZeroRef.y, itgErrPosActRes.ref) annotation (Line(points={{-79,0},{-60,
          0},{-60,-36},{-38,-36},{-38,-46},{14,-46},{14,-36},{18,-36}}, color={0,
          0,127}));
  connect(booSteItgAct.y, itgErrPosActRes.itgAct_in)
    annotation (Line(points={{-79,-50},{30,-50},{30,-42}}, color={255,0,255}));
  connect(itgErrPosActRes.isItgAct, not1.u) annotation (Line(points={{41,-24},{52,
          -24},{52,-30},{58,-30}}, color={255,0,255}));
  connect(not1.y, itgErrPosActRes.itgRes_in) annotation (Line(points={{81,-30},{
          90,-30},{90,-50},{36,-50},{36,-42}}, color={255,0,255}));
  annotation (experiment(
      StopTime=10,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"));
end IntegralErrorSingleReference;
