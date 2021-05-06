within AixLib.Fluid.HeatPumps.BaseClasses;
model ControlMflowManufacturer2


    parameter Modelica.SIunits.Temperature THotMax=333.15 "Max. value of THot before shutdown"
  annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.HeatFlowRate QNom=150000
                                                     "Nominal heat flow"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Real PLRMin=0.4 "Limit of PLR; less =0"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Boolean HighTemp=false "true: THot > 60°C"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));



  Modelica.Blocks.Sources.RealExpression mFlowConNominal(y=QNom/MediumCon.cp_const
        /DeltaTCon) "nominal massflow condenser"
    annotation (Placement(transformation(extent={{4,68},{-30,88}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,-6})));
  Modelica.Blocks.Continuous.LimPID PI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=10,
    yMax=1,
    yMin=0) annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={44,-10})));
  Modelica.Blocks.Sources.RealExpression tHotNom1(y=THotNom)
    annotation (Placement(transformation(extent={{84,-24},{66,4}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{56,32},{40,48}})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{84,62},{68,78}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-80})));
  Modelica.Blocks.Sources.RealExpression zero(y=0)
    annotation (Placement(transformation(extent={{80,-82},{66,-62}})));
  Modelica.Blocks.Continuous.Derivative derivative(k=15, T=15)
    annotation (Placement(transformation(extent={{22,-90},{2,-70}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-6,-88},{-22,-72}})));
  Modelica.Blocks.Math.Product mflowCondenser2
                                              "Product QExhaustLosses"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-86,0})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-16,20})));
  Modelica.Blocks.Math.Product mflowCondenser1
    "Max. massflow of setpoint (PLR)"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-50,72})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,90})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{56,-48},{40,-32}})));
  Modelica.Blocks.Sources.RealExpression tHotNom2(y=THotNom)
    annotation (Placement(transformation(extent={{10,-12},{-10,12}},
        rotation=0,
        origin={146,-66})));
  Modelica.Blocks.Sources.RealExpression one1(y=1)
    annotation (Placement(transformation(extent={{78,-100},{64,-78}})));
  Modelica.Blocks.Sources.RealExpression one2(y=1)
    annotation (Placement(transformation(extent={{24,38},{10,60}})));
  Modelica.Blocks.Interfaces.RealInput THot annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-40})));
  Modelica.Blocks.Interfaces.RealOutput mFlowCon
    annotation (Placement(transformation(extent={{-100,-12},{-124,12}})));
  Modelica.Blocks.Interfaces.RealInput PLR annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));
  Modelica.Blocks.Interfaces.BooleanInput Shutdown annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,0})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{156,28},{136,48}})));
  Modelica.Blocks.Sources.RealExpression tHotNom3(y=DeltaTCon)
    annotation (Placement(transformation(extent={{10,-12},{-10,12}},
        rotation=0,
        origin={202,42})));
  Modelica.Blocks.Interfaces.RealInput TCold
                                            annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-90})));
  Modelica.Blocks.Math.Add add(k1=+1, k2=-1)
    annotation (Placement(transformation(extent={{148,-34},{168,-14}})));
  Modelica.Blocks.Sources.RealExpression tHotNom4(y=THotNom)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-24})));
  Modelica.Blocks.Sources.RealExpression TMin(y=THotNom)     "MinimalStartTemp"
    annotation (Placement(transformation(extent={{32,168},{64,190}})));
  Modelica.Blocks.Continuous.LimPID PID3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=4,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{78,152},{98,172}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=1)
    annotation (Placement(transformation(extent={{84,172},{94,192}})));
  Modelica.Blocks.Math.Add add2(k1=-1)
    annotation (Placement(transformation(extent={{118,170},{134,186}})));
  Modelica.Blocks.Math.Abs abs2
    annotation (Placement(transformation(extent={{110,118},{130,138}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{138,120},{150,132}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{166,120},{178,132}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=10,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{198,136},{218,156}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=THotMax)
    annotation (Placement(transformation(extent={{156,138},{182,156}})));
  Modelica.Blocks.Logical.Greater greater1
    annotation (Placement(transformation(extent={{186,-34},{210,-14}})));
  Modelica.Blocks.Sources.RealExpression tHotNom5(y=DeltaTCon)
    annotation (Placement(transformation(extent={{-9,-11},{9,11}},
        rotation=0,
        origin={163,-51})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=THotNom - 293.15 - DeltaTCon,
      uMin=7)
    annotation (Placement(transformation(extent={{200,4},{212,16}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-62,114})));
  Modelica.Blocks.Logical.Greater greater2
    annotation (Placement(transformation(extent={{40,120},{20,140}})));
  Modelica.Blocks.Sources.RealExpression tHotNom6(y=THotNom - DeltaTCon)
    annotation (Placement(transformation(extent={{10,-12},{-10,12}},
        rotation=0,
        origin={64,112})));
  Modelica.Blocks.Math.Product mflowCondenser3
    "Max. massflow of setpoint (PLR)"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={44,14})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{0,40},{-20,60}})));
protected
   replaceable package MediumCon = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat sink";





equation
  connect(tHotNom1.y, PI.u_s)
    annotation (Line(points={{65.1,-10},{53.6,-10}}, color={0,0,127}));
  connect(or1.y,switch1. u2) annotation (Line(points={{39.2,40},{18,40},{18,-6},
          {-38,-6}},
                color={255,0,255}));
  connect(or1.y,switch2. u2) annotation (Line(points={{39.2,40},{18,40},{18,-54},
          {60,-54},{60,-80},{52,-80}},
                                 color={255,0,255}));
  connect(zero.y,switch2. u1) annotation (Line(points={{65.3,-72},{52,-72}},
                 color={0,0,127}));
  connect(switch2.y,derivative. u) annotation (Line(points={{29,-80},{24,-80}},
                                       color={0,0,127}));
  connect(derivative.y,abs1. u)
    annotation (Line(points={{1,-80},{-4.4,-80}},  color={0,0,127}));
  connect(switch3.y,switch1. u3) annotation (Line(points={{-27,20},{-32,20},{
          -32,2},{-38,2}},               color={0,0,127}));
  connect(abs1.y,switch1. u1)
    annotation (Line(points={{-22.8,-80},{-28,-80},{-28,-14},{-38,-14}},
                                                            color={0,0,127}));
  connect(mFlowConNominal.y,mflowCondenser1. u1) annotation (Line(points={{-31.7,
          78},{-38,78}},                           color={0,0,127}));
  connect(limiter.y,mflowCondenser1. u2) annotation (Line(points={{19,90},{12,
          90},{12,66},{-38,66}},             color={0,0,127}));
  connect(greater.u2,tHotNom2. y)
    annotation (Line(points={{57.6,-46.4},{84,-46.4},{84,-66},{135,-66}},
                                                      color={0,0,127}));
  connect(THot, PI.u_m) annotation (Line(points={{120,-40},{94,-40},{94,-22},{
          44,-22},{44,-19.6}}, color={0,0,127}));
  connect(PLR,limiter. u) annotation (Line(points={{120,60},{90,60},{90,90},{42,
          90}}, color={0,0,127}));
  connect(PLR,pLRMin. u)
    annotation (Line(points={{120,60},{90,60},{90,70},{85.6,70}},
                                                  color={0,0,127}));
  connect(THot,greater. u1) annotation (Line(points={{120,-40},{57.6,-40}},
                       color={0,0,127}));
  connect(mflowCondenser2.y,mFlowCon)
    annotation (Line(points={{-97,0},{-112,0}}, color={0,0,127}));
  connect(one1.y,switch2. u3)
    annotation (Line(points={{63.3,-89},{52,-89},{52,-88}}, color={0,0,127}));
  connect(Shutdown,or1. u2) annotation (Line(points={{120,0},{92,0},{92,33.6},{
          57.6,33.6}},                color={255,0,255}));
  connect(pLRMin.y,or1. u1) annotation (Line(points={{67.2,70},{64,70},{64,40},
          {57.6,40}},color={255,0,255}));
  connect(greater.y, switch3.u2) annotation (Line(points={{39.2,-40},{24,-40},{
          24,20},{-4,20}}, color={255,0,255}));
  connect(switch1.y, mflowCondenser2.u2)
    annotation (Line(points={{-61,-6},{-74,-6}}, color={0,0,127}));
  connect(TCold, add.u2) annotation (Line(points={{120,-90},{96,-90},{96,-60},{
          130,-60},{130,-30},{146,-30}}, color={0,0,127}));
  connect(tHotNom4.y, add.u1) annotation (Line(points={{121,-24},{136,-24},{136,
          -18},{146,-18}}, color={0,0,127}));
  connect(TMin.y, PID3.u_s) annotation (Line(points={{65.6,179},{65.6,162},{76,
          162}}, color={0,0,127}));
  connect(THot, PID3.u_m) annotation (Line(points={{120,-40},{98,-40},{98,-36},
          {88,-36},{88,150}}, color={0,0,127}));
  connect(realExpression4.y, add2.u1) annotation (Line(points={{94.5,182},{106,
          182},{106,182.8},{116.4,182.8}}, color={0,0,127}));
  connect(PID3.y, add2.u2) annotation (Line(points={{99,162},{112,162},{112,
          173.2},{116.4,173.2}}, color={0,0,127}));
  connect(add2.y, abs2.u) annotation (Line(points={{134.8,178},{142,178},{142,
          174},{146,174},{146,144},{96,144},{96,128},{108,128}}, color={0,0,127}));
  connect(abs2.y, limiter2.u) annotation (Line(points={{131,128},{132.5,128},{
          132.5,126},{136.8,126}}, color={0,0,127}));
  connect(limiter2.y, product2.u1) annotation (Line(points={{150.6,126},{154,
          126},{154,134},{164.8,134},{164.8,129.6}}, color={0,0,127}));
  connect(realExpression1.y, PID.u_s) annotation (Line(points={{183.3,147},{190,
          147},{190,146},{196,146}}, color={0,0,127}));
  connect(PID.y, product2.u2) annotation (Line(points={{219,146},{226,146},{226,
          144},{236,144},{236,104},{162,104},{162,122.4},{164.8,122.4}}, color=
          {0,0,127}));
  connect(add.y, greater1.u1)
    annotation (Line(points={{169,-24},{183.6,-24}}, color={0,0,127}));
  connect(tHotNom5.y, greater1.u2) annotation (Line(points={{172.9,-51},{178,
          -51},{178,-32},{183.6,-32}}, color={0,0,127}));
  connect(add.y, limiter1.u) annotation (Line(points={{169,-24},{176,-24},{176,
          10},{198.8,10}}, color={0,0,127}));
  connect(tHotNom3.y, division.u1)
    annotation (Line(points={{191,42},{158,42},{158,44}}, color={0,0,127}));
  connect(limiter1.y, division.u2) annotation (Line(points={{212.6,10},{234,10},
          {234,32},{158,32}}, color={0,0,127}));
  connect(THot, PID.u_m) annotation (Line(points={{120,-40},{100,-40},{100,-34},
          {208,-34},{208,134}}, color={0,0,127}));
  connect(mflowCondenser1.y, switch4.u3) annotation (Line(points={{-61,72},{-68,
          72},{-68,80},{-72,80},{-72,96},{-46,96},{-46,106},{-50,106}}, color={
          0,0,127}));
  connect(TCold, greater2.u1) annotation (Line(points={{120,-90},{82,-90},{82,
          130},{42,130}}, color={0,0,127}));
  connect(greater2.y, switch4.u2) annotation (Line(points={{19,130},{-2,130},{
          -2,114},{-50,114}}, color={255,0,255}));
  connect(greater2.u2, tHotNom6.y) annotation (Line(points={{42,122},{48,122},{
          48,112},{53,112}}, color={0,0,127}));
  connect(PI.y, mflowCondenser3.u2) annotation (Line(points={{35.2,-10},{30,-10},
          {30,2},{72,2},{72,8},{56,8}}, color={0,0,127}));
  connect(PLR, mflowCondenser3.u1) annotation (Line(points={{120,60},{110,60},{
          110,56},{100,56},{100,20},{56,20}}, color={0,0,127}));
  connect(mflowCondenser3.y, switch3.u3) annotation (Line(points={{33,14},{14,
          14},{14,12},{-4,12}}, color={0,0,127}));
  connect(one2.y, division1.u1)
    annotation (Line(points={{9.3,49},{8,49},{8,56},{2,56}}, color={0,0,127}));
  connect(PLR, division1.u2) annotation (Line(points={{120,60},{94,60},{94,44},
          {2,44}}, color={0,0,127}));
  connect(division1.y, switch3.u1) annotation (Line(points={{-21,50},{-30,50},{
          -30,36},{8,36},{8,28},{-4,28}}, color={0,0,127}));
  connect(mflowCondenser1.y, mflowCondenser2.u1) annotation (Line(points={{-61,
          72},{-62,72},{-62,10},{-74,10},{-74,6}}, color={0,0,127}));
  connect(mFlowConNominal.y, switch4.u1) annotation (Line(points={{-31.7,78},{
          -32,78},{-32,92},{-26,92},{-26,122},{-50,122}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ControlMflowManufacturer2;
