within AixLib.Systems.EONERC_Testhall.Controller;
model HeatCurve

  parameter Real u = 15 "heating limit" annotation(Dialog(tab = "General", group = "Limits"));
  parameter Real t_sup_upper = 80 "upper supply temperature limit" annotation(Dialog(tab = "General", group = "Limits"));
  parameter Real x = -1 "slope" annotation(Dialog(tab = "General", group = "Heat Curve"));
  parameter Real b = 10 "offset" annotation(Dialog(tab = "General", group = "Heat Curve"));

  Real t_ambient;
  Real y;


  Modelica.Blocks.Interfaces.RealInput T_amb
    annotation (Placement(transformation(extent={{-132,-20},{-92,20}}),
        iconTransformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput T_sup
    annotation (Placement(transformation(extent={{98,-10},{118,10}}),
        iconTransformation(extent={{-14,-14},{14,14}},
        rotation=90,
        origin={-80,114})));
  Modelica.Blocks.Sources.Constant KelvinConstant(k=273.15) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-104,40})));
  Modelica.Blocks.Math.Add t_sup
    annotation (Placement(transformation(extent={{80,-4},{88,4}})));
  Modelica.Blocks.Sources.RealExpression t_supply(y=y)
    annotation (Placement(transformation(extent={{32,-12},{52,8}})));
  Modelica.Blocks.Math.Add t_amb(k1=-1)
    annotation (Placement(transformation(extent={{-64,-2},{-56,6}})));
equation

  t_ambient = min(t_amb.y, u_lower);


  y = min(((x * t_ambient) + b), t_sup_upper);




  connect(t_supply.y, t_sup.u2) annotation (Line(points={{53,-2},{66.1,-2},{66.1,
          -2.4},{79.2,-2.4}}, color={0,0,127}));
  connect(t_sup.u1, KelvinConstant.y) annotation (Line(points={{79.2,2.4},{58,2.4},
          {58,32},{-88,32},{-88,40},{-99.6,40}}, color={0,0,127}));
  connect(t_sup.y, T_sup)
    annotation (Line(points={{88.4,0},{82,0},{82,0},{108,0}},
                                                color={0,0,127}));
  connect(t_amb.u2, T_amb) annotation (Line(points={{-64.8,-0.4},{-88.4,-0.4},{-88.4,
          0},{-112,0}}, color={0,0,127}));
  connect(t_amb.u1, KelvinConstant.y) annotation (Line(points={{-64.8,4.4},{-86,
          4.4},{-86,38},{-88,38},{-88,40},{-99.6,40}}, color={0,0,127}));
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
