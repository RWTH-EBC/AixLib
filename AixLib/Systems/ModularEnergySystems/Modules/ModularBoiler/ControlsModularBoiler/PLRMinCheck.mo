within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ControlsModularBoiler;
model PLRMinCheck

    parameter Real PLRMin=0.15 "Minimal Part Load Ratio";
    parameter Modelica.Units.SI.MassFlowRate m_flowRelMin=0.05 "Minimal relative 
    massflowrate for pump control";
  Modelica.Blocks.Interfaces.RealInput PLRSet "Setvalue of PLR "
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}}),
        iconTransformation(extent={{-120,-26},{-80,14}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold
                                        greaterEqualThreshold(
                                                       final threshold=PLRMin)
    annotation (Placement(transformation(extent={{-66,-8},{-50,8}})));
  Modelica.Blocks.Interfaces.RealOutput mFlowRel "relative mass flow [0, 1]"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput PLR annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={
            {92,30},{112,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1
    annotation (Placement(transformation(extent={{2,12},{22,32}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{40,26},{60,46}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    "Set value for boiler on/off status"
    annotation (Placement(transformation(extent={{-120,22},{-80,62}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-30,-2},{-10,18}})));
  Modelica.Blocks.Sources.Constant constPump(k=1)
    annotation (Placement(transformation(extent={{66,-50},{86,-30}})));
equation
  connect(PLRSet, greaterEqualThreshold.u)
    annotation (Line(points={{-100,0},{-67.6,0}}, color={0,0,127}));
  connect(switch4.y, PLR) annotation (Line(points={{61,36},{72,36},{72,0},{110,0}},
        color={0,0,127}));
  connect(isOn, and1.u1)
    annotation (Line(points={{-100,42},{-32,42},{-32,8}}, color={255,0,255}));
  connect(greaterEqualThreshold.y, and1.u2)
    annotation (Line(points={{-49.2,0},{-32,0}}, color={255,0,255}));
  connect(realExpression1.y, switch4.u3) annotation (Line(points={{23,22},{30,22},
          {30,28},{38,28}}, color={0,0,127}));
  connect(PLRSet, switch4.u1) annotation (Line(points={{-100,0},{-74,0},{-74,
          44},{38,44}},
                    color={0,0,127}));
  connect(and1.y, switch4.u2) annotation (Line(points={{-9,8},{-6,8},{-6,36},{38,
          36}}, color={255,0,255}));
  connect(constPump.y, mFlowRel) annotation (Line(points={{87,-40},{100,-40},
          {100,-40},{110,-40}}, color={0,0,127}));
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
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PLRMinCheck;
