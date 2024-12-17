within AixLib.Utilities.KPIs.Examples;
model IntegralErrorDualBounds "Test integral error dual bounds"
  extends Modelica.Icons.Example;
  extends Modelica.Icons.UnderConstruction;
  Modelica.Blocks.Sources.Ramp ramUppBou(
    height=4,
    duration=8,
    offset=1,
    startTime=1) "Ramp upper bound"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Ramp ramLowBou(
    height=-2,
    duration=8,
    offset=-1,
    startTime=1) "Ramp lower bound"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.Pulse pulSou(
    amplitude=8,
    period=2,
    offset=-4) "Pulse source"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  AixLib.Utilities.KPIs.IntegralErrorDualBounds intErrDua
    "Intergral error dual bounds"
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  AixLib.Utilities.KPIs.IntegralErrorDualBounds intErrDuaRes(resInBou=true)
    "Intergral error dual bounds with reset"
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
equation
  connect(ramUppBou.y, intErrDua.uppLim) annotation (Line(points={{-79,50},{-60,
          50},{-60,52},{-24,52}}, color={0,0,127}));
  connect(ramUppBou.y, intErrDuaRes.uppLim) annotation (Line(points={{-79,50},{-60,
          50},{-60,-28},{-24,-28}}, color={0,0,127}));
  connect(pulSou.y, intErrDua.u) annotation (Line(points={{-79,0},{-50,0},{-50,40},
          {-24,40}}, color={0,0,127}));
  connect(pulSou.y, intErrDuaRes.u) annotation (Line(points={{-79,0},{-50,0},{-50,
          -40},{-24,-40}}, color={0,0,127}));
  connect(ramLowBou.y, intErrDua.lowLim) annotation (Line(points={{-79,-50},{-40,
          -50},{-40,28},{-24,28}}, color={0,0,127}));
  connect(ramLowBou.y, intErrDuaRes.lowLim) annotation (Line(points={{-79,-50},{
          -40,-50},{-40,-52},{-24,-52}}, color={0,0,127}));
end IntegralErrorDualBounds;
