within AixLib.Building.Components.Ventilation;
model Infiltration "Simple infiltration"
  extends AixLib.Building.Components.Ventilation.BaseClasses.PartialVentilationSourceOutside;

  parameter Real q50(unit "m3/h/m2") = 1;
  parameter Modelica.SIunits.Length wall_length = 1;
  parameter Modelica.SIunits.Height wall_height = 1;

equation
  V_flow_eff = sign(dp_inPa)*(abs(dp_inPa/50))^(2/3)*q50*wall_height*wall_length;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-36,100},{36,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,26},{-20,46},{20,26},{60,46},{60,36},{20,16},{-20,36},{-60,
              16},{-60,26}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-34},{-20,-14},{20,-34},{60,-14},{60,-24},{20,-44},{-20,-24},
              {-60,-44},{-60,-34}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-4},{-20,16},{20,-4},{60,16},{60,6},{20,-14},{-20,6},{-60,
              -14},{-60,-4}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Infiltration;
