within AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls;
model FirRatMinCheck
  "Check to prevent firing rate going below minimal firing rate"
  parameter Real FirRatMin=0.15 "Minimal firing rate";

  Modelica.Blocks.Interfaces.RealInput yFirRatSet "Setvalue of PLR "
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greEquThr(final threshold=
        FirRatMin)
    annotation (Placement(transformation(extent={{-66,-8},{-50,8}})));
  Modelica.Blocks.Interfaces.RealOutput FirRat
                                            annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.RealExpression FirRatMinExp(y=FirRatMin)
    annotation (Placement(transformation(extent={{2,12},{22,32}})));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{40,26},{60,46}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    "Set value for boiler on/off status"
    annotation (Placement(transformation(extent={{-120,22},{-80,62}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-30,-2},{-10,18}})));
equation
  connect(yFirRatSet, greEquThr.u)
    annotation (Line(points={{-100,0},{-67.6,0}}, color={0,0,127}));
  connect(switch.y, FirRat) annotation (Line(points={{61,36},{72,36},{72,0},{
          110,0}}, color={0,0,127}));
  connect(isOn, and1.u1)
    annotation (Line(points={{-100,42},{-32,42},{-32,8}}, color={255,0,255}));
  connect(greEquThr.y, and1.u2)
    annotation (Line(points={{-49.2,0},{-32,0}}, color={255,0,255}));
  connect(FirRatMinExp.y, switch.u3) annotation (Line(points={{23,22},{30,22},{
          30,28},{38,28}}, color={0,0,127}));
  connect(yFirRatSet, switch.u1) annotation (Line(points={{-100,0},{-74,0},{-74,
          44},{38,44}}, color={0,0,127}));
  connect(and1.y, switch.u2) annotation (Line(points={{-9,8},{-6,8},{-6,36},{38,
          36}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
                            Text(
          extent={{-102,26},{98,-18}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Makes sure that the firing rate stays above minimal firing rate.</p>
</html>", revisions="<html>
<ul>
<li>
<i>June, 2023</i> by Moritz Zuschlag; David Jansen<br/>
    First Implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1147\">#1147</a>)
</li>
</ul>
</html>"));
end FirRatMinCheck;
