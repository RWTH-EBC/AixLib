within AixLib.Systems.EONERC_Testhall.Controller;
model HeatCurve

  parameter Real u_lower = 15 "lower heating limit" annotation(Dialog(tab = "General", group = "Limits"));
  parameter Real t_sup_upper = 80 "upper supply temperature limit" annotation(Dialog(tab = "General", group = "Limits"));
  parameter Real x = -1 "slope" annotation(Dialog(tab = "General", group = "Heat Curve"));
  parameter Real b = 10 "offset" annotation(Dialog(tab = "General", group = "Heat Curve"));

  Real t_ambient;
  Real y;


  Modelica.Blocks.Interfaces.RealInput T_amb
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput T_sup
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  Modelica.Blocks.Math.Add t_amb(k1=-1)
    annotation (Placement(transformation(extent={{-86,-2},{-78,6}})));
  Modelica.Blocks.Sources.Constant KelvinConstant(k=273.15) annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-104,40})));
  Modelica.Blocks.Math.Add t_sup
    annotation (Placement(transformation(extent={{80,-4},{88,4}})));
  Modelica.Blocks.Sources.RealExpression t_supply(y=y)
    annotation (Placement(transformation(extent={{32,-12},{52,8}})));
equation

  t_ambient = min(t_amb.y, u_lower);


  y = min(((x * t_ambient) + b), t_sup_upper);




  connect(KelvinConstant.y, t_amb.u1) annotation (Line(points={{-99.6,40},{-90,40},
          {-90,4.4},{-86.8,4.4}},                   color={0,0,127}));
  connect(T_amb, t_amb.u2) annotation (Line(points={{-120,0},{-103.4,0},{-103.4,
          -0.4},{-86.8,-0.4}}, color={0,0,127}));
  connect(t_supply.y, t_sup.u2) annotation (Line(points={{53,-2},{66.1,-2},{66.1,
          -2.4},{79.2,-2.4}}, color={0,0,127}));
  connect(t_sup.u1, KelvinConstant.y) annotation (Line(points={{79.2,2.4},{58,2.4},
          {58,32},{-88,32},{-88,40},{-99.6,40}}, color={0,0,127}));
  connect(t_sup.y, T_sup)
    annotation (Line(points={{88.4,0},{108,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatCurve;
