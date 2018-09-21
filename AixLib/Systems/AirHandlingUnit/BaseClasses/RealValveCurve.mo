within AixLib.Systems.AirHandlingUnit.BaseClasses;
block RealValveCurve
  "Adjustable characteristic curve for correlation between set and actual position of valves"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real a = 16.43 "Parameter a for real valve characteristic" annotation(Evaluate=false);
  parameter Real b(min=0.43, max=0.65) = 0.4976 "Parameter b for real valve characteristic (min=0.44; max=0.65)" annotation(Evaluate=false);
equation
  y = 1/(1+Modelica.Math.exp(-a*(u-b))*(1/0.5 - 1));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Polygon(
          points={{0,90},{-8,68},{8,68},{0,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,68}}, color={192,192,192}),
        Line(
          points={{-80,-80},{-52.7,-75.2},{-37.4,-69.7},{-26.9,-63},{-19.7,-55.2},
              {-14.1,-45.8},{-10.1,-36.4},{-6.03,-23.9},{-1.21,-5.06},{5.23,
              21},{9.25,34.1},{13.3,44.2},{18.1,52.9},{24.5,60.8},{33.4,67.6},
              {47,73.6},{69.5,78.6},{80,80}},
          smooth=Smooth.Bezier),
        Line(points={{-86,-80},{72,-80}},
                                      color={192,192,192}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-84,68},{-12,20}},
          lineColor={192,192,192},
          textString="valve characterisitic"),
        Text(
          extent={{48,-82},{68,-94}},
          lineColor={0,0,0},
          fillColor={85,255,85},
          fillPattern=FillPattern.Solid,
          textString="u"),
        Text(
          extent={{-22,88},{-6,76}},
          lineColor={0,0,0},
          fillColor={85,255,85},
          fillPattern=FillPattern.Solid,
          textString="y")}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(points={{0,80},{-8,80}}, color={192,
          192,192}),Line(points={{0,-80},{-8,-80}}, color={192,192,192}),Line(
          points={{0,-90},{0,84}}, color={192,192,192}),Text(
            extent={{13,102},{42,82}},
            lineColor={160,160,164},
            textString="y"),Polygon(
            points={{0,100},{-6,84},{6,84},{0,100}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),Line(points={{-100,0},{84,0}},
          color={192,192,192}),Polygon(
            points={{100,0},{84,6},{84,-6},{100,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),Line(points={{-80,-80},{-52.7,-75.2},
          {-37.4,-69.7},{-26.9,-63},{-19.7,-55.2},{-14.1,-45.8},{-10.1,-36.4},
          {-6.03,-23.9},{-1.21,-5.06},{5.23,21},{9.25,34.1},{13.3,44.2},{18.1,
          52.9},{24.5,60.8},{33.4,67.6},{47,73.6},{69.5,78.6},{80,80}})}),
    Documentation(info="<html>
<p>
This blocks computes the output <b>y</b> as the
<i>tangent-inverse</i> of the input <b>u</b>:
</p>
<pre>
    y= <b>atan</b>( u );
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/atan.png\"
     alt=\"atan.png\">
</p>

</html>"));
end RealValveCurve;
