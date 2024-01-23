within AixLib.Systems.EONERC_Testhall.Controller;
model HeatCurve

  parameter Real u_lower = 15 "heating limit" annotation(Dialog(tab = "General", group = "Limits"));
  parameter Real t_sup_upper = 80 "upper supply temperature limit" annotation(Dialog(tab = "General", group = "Limits"));
  parameter Real x = -1 "slope" annotation(Dialog(tab = "General", group = "Heat Curve"));
  parameter Real b = 10 "offset" annotation(Dialog(tab = "General", group = "Heat Curve"));

  Modelica.Real
       t_ambient;
  Real y;


  Modelica.Blocks.Interfaces.RealInput T_amb(unit="K")
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput T_sup(unit="K")
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{-19,-19},{19,19}},
        rotation=0,
        origin={121,1})));
  Modelica.Blocks.Sources.Constant KelvinConstant(k=273.15) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,50})));
  Modelica.Blocks.Math.Add t_sup
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.RealExpression t_supply(y=y)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.Add t_amb(k1=-1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation

  t_ambient = min(t_amb.y, u_lower);


  y = min(((x * t_ambient) + b), t_sup_upper);




  connect(t_supply.y, t_sup.u2) annotation (Line(points={{1,-30},{20,-30},{20,-6},
          {38,-6}},           color={0,0,127}));
  connect(t_sup.u1, KelvinConstant.y) annotation (Line(points={{38,6},{20,6},{20,
          50},{-19,50}},                         color={0,0,127}));
  connect(t_sup.y, T_sup)
    annotation (Line(points={{61,0},{120,0}},   color={0,0,127}));
  connect(t_amb.u2, T_amb) annotation (Line(points={{-62,-6},{-80,-6},{-80,0},{-120,
          0}},          color={0,0,127}));
  connect(t_amb.u1, KelvinConstant.y) annotation (Line(points={{-62,6},{-80,6},{
          -80,20},{0,20},{0,50},{-19,50}},             color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{102,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Line(
          points={{-48,-48}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-130,-60}},
          color={0,0,0},
          pattern=LinePattern.None),
        Line(
          points={{-94,-80},{86,-80}},
          color={215,215,215},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-80,-94},{-80,86}},
          color={215,215,215},
          thickness=1,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-80,58},{38,-66}},
          color={238,46,47},
          thickness=1),
        Line(
          points={{38,-66},{70,-66}},
          color={238,46,47},
          thickness=1),
        Line(
          points={{-98,58},{-80,58}},
          color={238,46,47},
          thickness=1),
        Polygon(
          points={{-80,96},{-88,74},{-72,74},{-80,96}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{0,11},{-8,-11},{8,-11},{0,11}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={84,-79},
          rotation=270,
          pattern=LinePattern.None)}),                           Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Input: T_amb in Kelvin</p>
<p>Output: T_Supply in Kelvin</p>
<p>Setting of Heat Curve Characteristic:</p>
<ul>
<li>u: Ambient temperature above which only the minimum supply temperature is required in &deg;C</li>
<li>t_supply_upper: Maximum supply temperature in &deg;C</li>
</ul>
</html>"));
end HeatCurve;
