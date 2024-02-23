within AixLib.Utilities.MassTransfer;
model PrescribedPartialPressure
  "Variable partial pressure boundary condition in Pa"

  MassPort port
    annotation (Placement(transformation(extent={{84,-14},{114,16}})));
  Modelica.Blocks.Interfaces.RealInput p(unit="Pa") annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}})));
equation
  port.p = p;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          pattern=LinePattern.None,
          fillColor={159,159,223},
          fillPattern=FillPattern.Backward),
        Line(
          points={{-102,0},{64,0}},
          color={0,140,72},
          thickness=0.5),
        Text(
          extent={{0,0},{-100,-100}},
          textString="kg/kg",
          lineColor={0,0,0}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          lineColor={0,0,255}),
        Polygon(
          points={{50,-20},{50,20},{90,0},{50,-20}},
          lineColor={0,140,72},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html><p>
  This model represents a variable partial pressure boundary condition.
  The partial pressure in [Pa] is given as input signal
  <strong>p</strong> to the model. The effect is that an instance of
  this model acts as an infinite reservoir able to absorb or generate
  as much mass as required to keep the partial pressure at the
  specified value.
</p>
</html>", revisions="<html>
<ul>
  <li>November 20, 2019, by Martin Kremer:<br/>
    First Implementation.
  </li>
</ul>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          pattern=LinePattern.None,
          fillColor={159,159,223},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{0,0},{-100,-100}},
          textString="kg/kg",
          lineColor={0,0,0}),
        Line(
          points={{-102,0},{64,0}},
          color={0,140,72},
          thickness=0.5),
        Polygon(
          points={{52,-20},{52,20},{90,0},{52,-20}},
          lineColor={0,140,72},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid)}));
end PrescribedPartialPressure;
