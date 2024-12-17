within AixLib.Utilities.KPIs.Examples;
model IntegralErrorDualReference "Test integral error with dual references"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp ramUppBou(
    height=4,
    duration=8,
    offset=1,
    startTime=1) "Ramp upper bound"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Ramp ramLowBou(
    height=-2,
    duration=8,
    offset=-1,
    startTime=1) "Ramp lower bound"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Pulse pulSou(
    amplitude=8,
    period=2,
    offset=-4) "Pulse source"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.BooleanStep booSteItgAct(startTime=4)
    "Boolean source to activate integrators"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.BooleanStep booSteItgRes(startTime=8)
    "Boolean source to reset integrators"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  AixLib.Utilities.KPIs.IntegralErrorDualReference.IntegralErrorDualBounds ied
    "Integral error dual bounds normal"
    annotation (Placement(transformation(extent={{-20,60},{20,100}})));
  AixLib.Utilities.KPIs.IntegralErrorDualReference.IntegralErrorDualBounds iedAct(
      use_itgAct_in=true)
    "Integral error dual bounds with activation connector"
    annotation (Placement(transformation(extent={{-20,0},{20,40}})));
  AixLib.Utilities.KPIs.IntegralErrorDualReference.IntegralErrorDualBounds iedActRes(
      use_itgAct_in=true, use_itgRes_in=true)
    "Integral error dual bounds with activation and reset connectors"
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
equation
  connect(ramUppBou.y, ied.refUpp) annotation (Line(points={{-79,90},{-60,90},{
          -60,92},{-24,92}}, color={0,0,127}));
  connect(ramUppBou.y, iedAct.refUpp) annotation (Line(points={{-79,90},{-60,90},
          {-60,32},{-24,32}}, color={0,0,127}));
  connect(ramUppBou.y, iedActRes.refUpp) annotation (Line(points={{-79,90},{-60,
          90},{-60,-28},{-24,-28}}, color={0,0,127}));
  connect(pulSou.y, ied.u) annotation (Line(points={{-79,50},{-50,50},{-50,80},
          {-24,80}}, color={0,0,127}));
  connect(pulSou.y, iedAct.u) annotation (Line(points={{-79,50},{-50,50},{-50,
          20},{-24,20}}, color={0,0,127}));
  connect(pulSou.y, iedActRes.u) annotation (Line(points={{-79,50},{-50,50},{
          -50,-40},{-24,-40}}, color={0,0,127}));
  connect(ramLowBou.y, ied.refLow) annotation (Line(points={{-79,10},{-40,10},{
          -40,68},{-24,68}}, color={0,0,127}));
  connect(ramLowBou.y, iedAct.refLow) annotation (Line(points={{-79,10},{-40,10},
          {-40,8},{-24,8}}, color={0,0,127}));
  connect(ramLowBou.y, iedActRes.refLow) annotation (Line(points={{-79,10},{-40,
          10},{-40,-52},{-24,-52}}, color={0,0,127}));
  connect(booSteItgAct.y, iedAct.itgAct_in) annotation (Line(points={{-79,-50},
          {-68,-50},{-68,-10},{0,-10},{0,-4}}, color={255,0,255}));
  connect(booSteItgAct.y, iedActRes.itgAct_in) annotation (Line(points={{-79,
          -50},{-68,-50},{-68,-80},{0,-80},{0,-64}}, color={255,0,255}));
  connect(booSteItgRes.y, iedActRes.itgRes_in)
    annotation (Line(points={{-79,-90},{12,-90},{12,-64}}, color={255,0,255}));
end IntegralErrorDualReference;
