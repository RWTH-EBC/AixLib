within AixLib.Systems.ModularEnergySystems.Controls;
model ControlMflowNotManufacturer

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

 parameter Boolean dTConFix=false
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

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
        origin={120,70})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-24,-20})));
  Modelica.Blocks.Continuous.LimPID PI(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.008,
    Ti=10,
    yMax=1,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.1)
            annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={38,16})));
  Modelica.Blocks.Sources.RealExpression tHotNom1(y=THotNom)
    annotation (Placement(transformation(extent={{118,16},{100,44}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{40,52},{24,68}})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{78,62},{62,78}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-78})));
  Modelica.Blocks.Sources.RealExpression zero(y=0)
    annotation (Placement(transformation(extent={{80,-80},{66,-60}})));
  Modelica.Blocks.Continuous.Derivative derivative(k=15, T=15)
    annotation (Placement(transformation(extent={{20,-88},{0,-68}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-10,-86},{-26,-70}})));
  Modelica.Blocks.Interfaces.BooleanInput Shutdown annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,0})));
  Modelica.Blocks.Sources.RealExpression one1(y=1)
    annotation (Placement(transformation(extent={{80,-98},{66,-76}})));

  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{64,-30},{46,-12}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{80,8},{64,24}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-82,0})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=dTConFix)
    annotation (Placement(transformation(extent={{-16,-10},{-34,8}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0.01)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-44,-78})));
  Modelica.Blocks.Continuous.LimPID PI1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.02,
    Ti=5,
    yMax=1,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.1)
            annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=0,
        origin={-72,98})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-10,74},{-28,92}})));
  Modelica.Blocks.Math.Gain gain3(k=-1)
    annotation (Placement(transformation(extent={{-28,90},{-46,108}})));
  Modelica.Blocks.Interfaces.RealInput TCold
                                            annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-90})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=0,
        origin={1,99})));
  Modelica.Blocks.Sources.RealExpression tHotNom3(y=DeltaTCon)
    annotation (Placement(transformation(extent={{94,90},{78,116}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-108,84})));
protected
   replaceable package MediumCon = AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat sink";

equation
  connect(or1.y,switch1. u2) annotation (Line(points={{23.2,60},{18,60},{18,-20},
          {-12,-20}},
                color={255,0,255}));
  connect(or1.y,switch2. u2) annotation (Line(points={{23.2,60},{18,60},{18,-52},
          {60,-52},{60,-78},{52,-78}},
                                 color={255,0,255}));
  connect(zero.y,switch2. u1) annotation (Line(points={{65.3,-70},{52,-70}},
                 color={0,0,127}));
  connect(switch2.y,derivative. u) annotation (Line(points={{29,-78},{22,-78}},
                                       color={0,0,127}));
  connect(derivative.y,abs1. u)
    annotation (Line(points={{-1,-78},{-8.4,-78}}, color={0,0,127}));
  connect(PLR, pLRMin.u)
    annotation (Line(points={{120,70},{79.6,70}}, color={0,0,127}));
  connect(one1.y, switch2.u3)
    annotation (Line(points={{65.3,-87},{52,-87},{52,-86}}, color={0,0,127}));
  connect(Shutdown, or1.u2) annotation (Line(points={{120,-8.88178e-16},{106,
          -8.88178e-16},{106,0},{92,0},{92,34},{46,34},{46,53.6},{41.6,53.6}},
                                      color={255,0,255}));
  connect(pLRMin.y, or1.u1) annotation (Line(points={{61.2,70},{54,70},{54,60},
          {41.6,60}},color={255,0,255}));
  connect(tHotNom1.y, gain1.u) annotation (Line(points={{99.1,30},{90,30},{90,
          16},{81.6,16}},      color={0,0,127}));
  connect(THot, gain.u) annotation (Line(points={{120,-40},{90,-40},{90,-21},{
          65.8,-21}},                 color={0,0,127}));
  connect(gain.y, PI.u_m) annotation (Line(points={{45.1,-21},{38,-21},{38,6.4}},
                        color={0,0,127}));
  connect(gain1.y, PI.u_s) annotation (Line(points={{63.2,16},{47.6,16}},
                                  color={0,0,127}));
  connect(switch4.u2, booleanExpression1.y) annotation (Line(points={{-70,0},{
          -70,-1},{-34.9,-1}},      color={255,0,255}));
  connect(PI.y, switch1.u3) annotation (Line(points={{29.2,16},{-2,16},{-2,-12},
          {-12,-12}}, color={0,0,127}));
  connect(limiter1.u, abs1.y)
    annotation (Line(points={{-32,-78},{-26.8,-78}}, color={0,0,127}));
  connect(limiter1.y, switch1.u1) annotation (Line(points={{-55,-78},{-60,-78},
          {-60,-48},{0,-48},{0,-28},{-12,-28}}, color={0,0,127}));
  connect(switch1.y, switch4.u3) annotation (Line(points={{-35,-20},{-42,-20},{
          -42,-8},{-70,-8}}, color={0,0,127}));
  connect(switch4.y, mFlowCon)
    annotation (Line(points={{-93,0},{-112,0}}, color={0,0,127}));
  connect(add.y, gain3.u)
    annotation (Line(points={{-6.7,99},{-26.2,99}}, color={0,0,127}));
  connect(tHotNom3.y, add.u1) annotation (Line(points={{77.2,103},{48,103},{48,
          103.2},{9.4,103.2}}, color={0,0,127}));
  connect(TCold, add.u2) annotation (Line(points={{120,-90},{94,-90},{94,94.8},
          {9.4,94.8}}, color={0,0,127}));
  connect(THot, gain2.u) annotation (Line(points={{120,-40},{90,-40},{90,83},{
          -8.2,83}},  color={0,0,127}));
  connect(gain2.y, PI1.u_m) annotation (Line(points={{-28.9,83},{-72,83},{-72,
          88.4}}, color={0,0,127}));
  connect(gain3.y, PI1.u_s) annotation (Line(points={{-46.9,99},{-54,99},{-54,
          98},{-62.4,98}}, color={0,0,127}));
  connect(limiter1.y, switch3.u1) annotation (Line(points={{-55,-78},{-60,-78},
          {-60,56},{-82,56},{-82,76},{-96,76}}, color={0,0,127}));
  connect(PI1.y, switch3.u3) annotation (Line(points={{-80.8,98},{-88,98},{-88,
          92},{-96,92}}, color={0,0,127}));
  connect(switch3.y, switch4.u1) annotation (Line(points={{-119,84},{-122,84},{
          -122,62},{-54,62},{-54,8},{-70,8}}, color={0,0,127}));
  connect(or1.y, switch3.u2) annotation (Line(points={{23.2,60},{-40,60},{-40,
          68},{-76,68},{-76,84},{-96,84}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Control unit of the relativ condenser water mass flow [0,1] for two
  different operation methods:
</p>
<ul>
  <li>constant THot
  </li>
  <li>constant temperature difference between THot and TCold
  </li>
</ul>
<p>
  <br/>
  A Shutdown is controlled with a degressiv decrease of warter mass
  flow to avoid non physical behaviour.
</p>
</html>"));
end ControlMflowNotManufacturer;
