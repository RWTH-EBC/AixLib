within AixLib.Utilities.KPIs.Examples;
model IntegralTimer "Test integral timer"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.BooleanConstant booCon "Boolean constant"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.BooleanPulse booPul(period=2) "Boolean pulse"
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  AixLib.Utilities.KPIs.IntegralTimer intlTim1 "Integral timer 1"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  AixLib.Utilities.KPIs.IntegralTimer intlTim2 "Integral timer 2"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  AixLib.Utilities.KPIs.IntegralTimer intlTimRes(use_reset=true)
    "Integral timer with reset"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Logical.Not not1 "Not"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
equation
  connect(booCon.y, intlTim1.u)
    annotation (Line(points={{-79,70},{-2,70}}, color={255,0,255}));
  connect(booPul.y, intlTim2.u)
    annotation (Line(points={{-79,10},{-2,10}}, color={255,0,255}));
  connect(booPul.y, intlTimRes.u) annotation (Line(points={{-79,10},{-60,10},{
          -60,-50},{-2,-50}}, color={255,0,255}));
  connect(booPul.y, not1.u) annotation (Line(points={{-79,10},{-60,10},{-60,-70},
          {-42,-70}}, color={255,0,255}));
  connect(not1.y, intlTimRes.reset)
    annotation (Line(points={{-19,-70},{10,-70},{10,-62}}, color={255,0,255}));
end IntegralTimer;
