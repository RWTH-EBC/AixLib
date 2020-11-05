within AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses;
block VariableLimiter
  "Limit the range of a signal with variable limits"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
    annotation (Evaluate=true, choices(checkBox=true));
  parameter Boolean limitsAtInit=true
    "Has no longer an effect and is only kept for backwards compatibility (the implementation uses now the homotopy operator)"
    annotation (
    Dialog(tab="Dummy"),
    Evaluate=true,
    choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput limit1
    "Connector of Real input signal used as maximum of input u"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput limit2
    "Connector of Real input signal used as minimum of input u"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
algorithm
  assert(limit1 >= limit2, "Input signals are not consistent: limit1 < limit2");

  if strict then
    y := smooth(0, noEvent(if u > limit1 then limit1 else if u < limit2 then
      limit2 else u));
  else
    y := smooth(0, if u > limit1 then limit1 else if u < limit2 then limit2
       else u);
  end if;

  annotation (
    Documentation(info="<html><p>
  The original variable Limiter
  Modelica.Blocks.Nonlinear.VariableLimiter showed problems with the
  pump model. The output variable y would often stay at the minimum
  (limit2) although u was larger than this value. The homotropy and
  smooth functions were not the problem as can be shown. Even removing
  both of them did not solve the problem that occured in special (?)
  hydraulic setups. See for example
  Zugabe.Fluid.Movers.Examples.test_nset.
</p>
<p>
  Dymola seemed to transform the equations in the wrong way. Changing
  the equation section into an algorithm, thus forcing the ordered
  calculation, brought a solution.
</p>
<ul>
  <li>2017-11-17 by Peter Matthes<br/>
    Implemented. Changed equation block into an algorithm block.
    Otherwise y could end up staying at limit2 all the time even though
    u would be higher than limit2 (and smaller than limit1).
  </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
        Line(points={{0,-90},{0,68}}, color={192,192,192}),
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,-8},{68,8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{-50,-70},{50,70},{80,70}}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          lineColor={0,0,255}),
        Line(points={{-100,80},{66,80},{66,70}}, color={0,0,127}),
        Line(points={{-100,-80},{-64,-80},{-64,-70}}, color={0,0,127}),
        Polygon(points={{-64,-70},{-66,-74},{-62,-74},{-64,-70}}, lineColor={0,0,
              127}),
        Polygon(points={{66,70},{64,74},{68,74},{66,70}}, lineColor={0,0,127}),
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          visible=strict,
          points={{50,70},{80,70}},
          color={255,0,0}),
        Line(
          visible=strict,
          points={{-80,-70},{-50,-70}},
          color={255,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(points={{0,-60},{0,50}}, color={192,192,192}),
        Polygon(
          points={{0,60},{-5,50},{5,50},{0,60}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,0},{50,0}}, color={192,192,192}),
        Polygon(
          points={{60,0},{50,-5},{50,5},{60,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}),
        Text(
          extent={{46,-6},{68,-18}},
          lineColor={128,128,128},
          textString="input"),
        Text(
          extent={{-30,70},{-5,50}},
          lineColor={128,128,128},
          textString="output"),
        Text(
          extent={{-66,-40},{-26,-20}},
          lineColor={128,128,128},
          textString="uMin"),
        Text(
          extent={{30,20},{70,40}},
          lineColor={128,128,128},
          textString="uMax"),
        Line(points={{-100,80},{40,80},{40,40}}, color={0,0,127}),
        Line(points={{-100,-80},{-40,-80},{-40,-40}}, color={0,0,127}),
        Polygon(points={{40,40},{35,50},{45,50},{40,40}}, lineColor={0,0,127}),
        Polygon(points={{-40,-40},{-45,-50},{-35,-50},{-40,-40}}, lineColor={0,0,
              127})}));
end VariableLimiter;
