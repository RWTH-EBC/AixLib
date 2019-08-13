within AixLib.Systems.Benchmark.Model.Evaluation;
model qexpt
  extends Modelica.Blocks.Icons.Block;

  parameter Real k1=+1 "Gain of upper input";

  parameter Real k3=+1 "Gain of lower input";
  Modelica.Interfaces.RealInput u1 "Connector 1 of Real input signals" annotation (
      Placement(transformation(extent={{-140,60},{-100,100}})));

  Modelica.Interfaces.RealInput u3 "Connector 3 of Real input signals" annotation (
      Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Interfaces.RealOutput y "Connector of Real output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

equation
  y = (k1*u1)^u3;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-100,50},{5,90}},
          lineColor={0,0,0},
          textString=""),
        Text(
          extent={{-100,-20},{5,20}},
          lineColor={0,0,0},
          textString=""),
        Text(
          extent={{-100,-50},{5,-90}},
          lineColor={0,0,0},
          textString=""),
        Text(
          extent={{2,36},{100,-44}},
          lineColor={0,0,0},
          textString="q^t")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),Text(
            extent={{-100,50},{5,90}},
            lineColor={0,0,0},
            textString="k1"),Text(
            extent={{-100,-20},{5,20}},
            lineColor={0,0,0},
            textString=""),Text(
            extent={{-100,-50},{5,-90}},
            lineColor={0,0,0},
            textString="t"),Text(
            extent={{2,46},{100,-34}},
            lineColor={0,0,0},
            textString="q^t")}));
end qexpt;
