within AixLib.Utilities.KPIs;
model IntegralErrorDualBounds
  "Integral error with dual bounds for positive and negative errors"

  parameter Boolean resInBou = false
    "If true, reset integrators if value within bounds"
    annotation(choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput u "Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput uppLim "Upper limit"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput lowLim "Lower limit"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  AixLib.Utilities.KPIs.IntegralErrorWithFilter intErrPos(use_reset=resInBou)
    "Intergral of positive errors"
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  AixLib.Utilities.KPIs.IntegralErrorWithFilter intErrNeg(use_reset=resInBou,
    posFil=false)
    "Intergral of negative errors"
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Math.Add add(k2=-1) "Add"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Logical.Or or1 "Or logic of both integrators"
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Modelica.Blocks.Logical.Not notUpp "Not logic for upper bound"
    annotation (Placement(transformation(extent={{-20,20},{-40,40}})));
  Modelica.Blocks.Interfaces.RealOutput yUpp
    "Integral positive errors greater than upper limit"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput yLow
    "Integral negative errors less than lower limit"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput yAbsTot "Total absolute integral error"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput yOutUppBou "Out of upper bound"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.BooleanOutput yOutLowBou "Out of lower bound"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.BooleanOutput yOutBou "Out of bound"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Logical.Not notLow "Not logic for lower bound"
    annotation (Placement(transformation(extent={{-20,-100},{-40,-80}})));
equation
  assert(uppLim > lowLim, "Dual bounds limit wrong (uppLim<=LowLim)");
  connect(u, intErrPos.u) annotation (Line(points={{-120,0},{-90,0},{-90,66},{-62,
          66}}, color={0,0,127}));
  connect(u, intErrNeg.u) annotation (Line(points={{-120,0},{-90,0},{-90,-54},{-62,
          -54}}, color={0,0,127}));
  connect(uppLim, intErrPos.ref) annotation (Line(points={{-120,60},{-80,60},{-80,
          54},{-62,54}}, color={0,0,127}));
  connect(lowLim, intErrNeg.ref) annotation (Line(points={{-120,-60},{-80,-60},{
          -80,-66},{-62,-66}}, color={0,0,127}));
  connect(intErrPos.y, yUpp)
    annotation (Line(points={{-39,60},{110,60},{110,60}}, color={0,0,127}));
  connect(intErrNeg.y, yLow)
    annotation (Line(points={{-39,-60},{110,-60}}, color={0,0,127}));
  connect(add.y, yAbsTot)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(intErrPos.y, add.u1) annotation (Line(points={{-39,60},{50,60},{50,6},
          {58,6}}, color={0,0,127}));
  connect(intErrNeg.y, add.u2) annotation (Line(points={{-39,-60},{50,-60},{50,-6},
          {58,-6}}, color={0,0,127}));
  connect(intErrPos.yFil, or1.u1) annotation (Line(points={{-39,66},{10,66},{10,
          20},{18,20}},
                      color={255,0,255}));
  connect(intErrNeg.yFil, or1.u2) annotation (Line(points={{-39,-54},{10,-54},{10,
          12},{18,12}}, color={255,0,255}));
  connect(notUpp.y, intErrPos.reset) annotation (Line(
      points={{-41,30},{-50,30},{-50,48}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash, if resInBou then LinePattern.Solid
           else LinePattern.Dash)));
  connect(intErrPos.yFil, yOutUppBou) annotation (Line(points={{-39,66},{60,66},
          {60,80},{110,80}}, color={255,0,255}));
  connect(intErrNeg.yFil, yOutLowBou) annotation (Line(points={{-39,-54},{60,-54},
          {60,-40},{110,-40}}, color={255,0,255}));
  connect(or1.y, yOutBou) annotation (Line(points={{41,20},{110,20}},
        color={255,0,255}));
  connect(intErrPos.yFil, notUpp.u) annotation (Line(points={{-39,66},{10,66},{10,
          30},{-18,30}}, color={255,0,255}));
  connect(intErrNeg.yFil, notLow.u) annotation (Line(points={{-39,-54},{10,-54},
          {10,-90},{-18,-90}}, color={255,0,255}));
  connect(notLow.y, intErrNeg.reset) annotation (Line(
      points={{-41,-90},{-50,-90},{-50,-72}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash, if resInBou then LinePattern.Solid
           else LinePattern.Dash)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IntegralErrorDualBounds;
