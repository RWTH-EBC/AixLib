within AixLib.Fluid.Movers;
package Compressors "Package that contains models of different compressor types"
  extends Modelica.Icons.Package;

annotation (Icon(graphics={
        Ellipse(
          extent={{80,80},{-80,-80}},
          lineColor={0,0,0},
          startAngle=0,
          endAngle=360,
          fillPattern=FillPattern.Sphere,
          fillColor={214,214,214}),
        Line(
          points={{-18,78},{-64,-48}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{18,78},{64,-48}},
          color={0,0,0},
          thickness=0.5)}), Documentation(revisions="<html><ul>
  <li>October 19, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains component models for simple and modular
  compressors. These compressors are used for, for example, simple or
  modular heat pumps that model the refrigerant circuit.
</p>
</html>"));
end Compressors;
