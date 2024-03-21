within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
model COP_calc
  Modelica.Blocks.Interfaces.RealOutput COP
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput P_el_mea(
    final quantity="Power",
    final unit="W",
    final displayUnit="kW")
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-48,24},{-28,44}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
    annotation (Placement(transformation(extent={{-48,52},{-28,72}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{10,52},{30,72}})));
  Modelica.Blocks.Interfaces.RealInput Q_con(
    final quantity="Power",
    final unit="W",
    final displayUnit="kW")
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{56,-10},{76,10}})));
equation
  connect(P_el_mea, greaterThreshold.u) annotation (Line(points={{-120,40},{-90,
          40},{-90,62},{-50,62}}, color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2)
    annotation (Line(points={{-27,62},{8,62}}, color={255,0,255}));
  connect(P_el_mea, switch1.u1) annotation (Line(points={{-120,40},{-80,40},{
          -80,88},{0,88},{0,70},{8,70}}, color={0,0,127}));
  connect(Q_con, division.u1) annotation (Line(points={{-120,-40},{-80,-40},{
          -80,6},{54,6}}, color={0,0,127}));
  connect(realExpression.y, switch1.u3) annotation (Line(points={{-27,34},{-8,
          34},{-8,54},{8,54}}, color={0,0,127}));
  connect(switch1.y, division.u2) annotation (Line(points={{31,62},{42,62},{42,
          -6},{54,-6}}, color={0,0,127}));
  connect(division.y, COP)
    annotation (Line(points={{77,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end COP_calc;
