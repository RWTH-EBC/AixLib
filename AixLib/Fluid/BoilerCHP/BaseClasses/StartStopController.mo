within AixLib.Fluid.BoilerCHP.BaseClasses;
model StartStopController
  Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(extent={{-36,22},{-16,42}})));
  Modelica.Blocks.Logical.Timer timer1 annotation (Placement(transformation(extent={{-36,-36},{-16,-16}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=StartTime)
    annotation (Placement(transformation(extent={{0,42},{20,62}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold=StopTime)
    annotation (Placement(transformation(extent={{0,-28},{20,-8}})));
  Modelica.Blocks.Logical.And and1 annotation (Placement(transformation(extent={{40,22},{60,42}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
    annotation (Placement(transformation(extent={{0,8},{20,28}})));
  Modelica.Blocks.Logical.And and2 annotation (Placement(transformation(extent={{40,-36},{60,-16}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=0)
    annotation (Placement(transformation(extent={{0,-54},{20,-34}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(extent={{-72,-36},{-52,-16}})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput Start
    annotation (Placement(transformation(extent={{96,34},{128,62}}), iconTransformation(extent={{96,34},{128,62}})));
  Modelica.Blocks.Interfaces.BooleanOutput Stop
    annotation (Placement(transformation(extent={{98,-56},{126,-28}}), iconTransformation(extent={{98,-56},{126,-28}})));
  parameter Modelica.SIunits.Time StartTime = 500;
  parameter Modelica.SIunits.Time StopTime = 500;
equation
  connect(timer.y, lessThreshold.u) annotation (Line(points={{-15,32},{-12,32},
          {-12,52},{-2,52}},                                                                      color={0,0,127}));
  connect(lessThreshold.y, and1.u1) annotation (Line(points={{21,52},{28,52},{
          28,32},{38,32}},                                                                     color={255,0,255}));
  connect(timer.y, greaterThreshold.u) annotation (Line(points={{-15,32},{-10,32},{-10,18},{-2,18}}, color={0,0,127}));
  connect(greaterThreshold.y, and1.u2)
    annotation (Line(points={{21,18},{24,18},{24,20},{38,20},{38,24}}, color={255,0,255}));
  connect(timer1.y, greaterThreshold1.u) annotation (Line(points={{-15,-26},{-8,-26},{-8,-44},{-2,-44}}, color={0,0,127}));
  connect(timer1.y, lessThreshold1.u) annotation (Line(points={{-15,-26},{-8,-26},{-8,-18},{-2,-18}}, color={0,0,127}));
  connect(lessThreshold1.y, and2.u1)
    annotation (Line(points={{21,-18},{36,-18},{36,-26},{38,-26}}, color={255,0,255}));
  connect(greaterThreshold1.y, and2.u2)
    annotation (Line(points={{21,-44},{35.5,-44},{35.5,-34},{38,-34}}, color={255,0,255}));
  connect(not1.y, timer1.u) annotation (Line(points={{-51,-26},{-38,-26}}, color={255,0,255}));
  connect(OnOff, timer.u) annotation (Line(points={{-100,0},{-82,0},{-82,32},{-38,32}}, color={255,0,255}));
  connect(OnOff, not1.u) annotation (Line(points={{-100,0},{-82,0},{-82,-26},{-74,-26}}, color={255,0,255}));
  connect(and2.y, Stop) annotation (Line(points={{61,-26},{86,-26},{86,-42},{112,-42}}, color={255,0,255}));
  connect(and1.y, Start) annotation (Line(points={{61,32},{86,32},{86,48},{112,48}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid), Text(
          extent={{-56,14},{50,-6}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="Start Stop Controller")}),
                Diagram(coordinateSystem(preserveAspectRatio=false)));
end StartStopController;
