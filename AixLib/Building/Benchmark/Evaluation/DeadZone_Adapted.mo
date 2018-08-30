within AixLib.Building.Benchmark.Evaluation;
block DeadZone_Adapted "Provide a region of zero output"
  parameter Real uMax(start=1) "Upper limits of dead zones";
  parameter Real uMin=-uMax "Lower limits of dead zones";
  parameter Boolean deadZoneAtInit = true
"Has no longer an effect and is only kept for backwards compatibility (the implementation uses now the homotopy operator)"
    annotation (Dialog(tab="Dummy"),Evaluate=true, choices(checkBox=true));

  extends Modelica.Blocks.Interfaces.SISO;

equation
  assert(uMax >= uMin, "DeadZone: Limits must be consistent. However, uMax (=" + String(uMax) +
                       ") < uMin (=" + String(uMin) + ")");

  y = homotopy(actual=smooth(0,if u > uMax then u else if u < uMin then u else 0), simplified=u);

  annotation (
    Documentation(info="<html>
<p>
The DeadZone block defines a region of zero output.
</p>
<p>
If the input is within uMin ... uMax, the output
is zero. Outside of this zone, the output is a linear
function of the input with a slope of 1.
</p>
</html>"), Icon(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
    Line(points={{0,-90},{0,68}}, color={192,192,192}),
    Polygon(
      points={{0,90},{-8,68},{8,68},{0,90}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-90,0},{68,0}}, color={192,192,192}),
    Polygon(
      points={{90,0},{68,-8},{68,8},{90,0}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-80,-60},{-20,-14},{-20,0},{20,0},{20,14},{80,60}}),
    Text(
      extent={{-150,-150},{150,-110}},
      lineColor={160,160,164},
      textString="uMax=%uMax"),
    Text(
      extent={{-150,150},{150,110}},
      textString="%name",
      lineColor={0,0,255})}),
    Diagram(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
    Line(points={{0,-60},{0,50}}, color={192,192,192}),
    Polygon(
      points={{0,60},{-5,50},{5,50},{0,60}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-76,0},{74,0}}, color={192,192,192}),
    Polygon(
      points={{84,0},{74,-5},{74,5},{84,0}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-81,-40},{-40,-20},{-40,0},{40,0},{40,20},{80,40}}),
    Text(
      extent={{62,-7},{88,-25}},
      lineColor={128,128,128},
      textString="u"),
    Text(
      extent={{-36,72},{-5,50}},
      lineColor={128,128,128},
      textString="y"),
    Text(
      extent={{-51,1},{-28,19}},
      lineColor={128,128,128},
      textString="uMin"),
    Text(
      extent={{27,-1},{52,-17}},
      lineColor={128,128,128},
      textString="uMax")}));
end DeadZone_Adapted;
