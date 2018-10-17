within AixLib.Systems.HydraulicModules.Controller;
block CtrUnmixed "controller for unmixed circuit"
  //Boolean choice;

  parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the Pump";
  parameter Modelica.SIunits.Temperature T_amb = 293.15 "ambient temperature";

  Modelica.Blocks.Sources.RealExpression realExpression(y=rpm_pump)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  BaseClasses.HydraulicBus hydraulicBus annotation (Placement(
        transformation(extent={{78,-24},{124,24}}), iconTransformation(extent={{
            78,-24},{124,24}})));
  Modelica.Blocks.Sources.Constant const(k=T_amb)
    annotation (Placement(transformation(extent={{22,44},{42,64}})));
equation
  connect(realExpression.y, hydraulicBus.pumpBus.rpm_Input) annotation (Line(
        points={{11,0},{101.115,0},{101.115,0.12}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const.y, hydraulicBus.T_amb) annotation (Line(points={{43,54},{101,54},
          {101,0}},                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
          Rectangle(
          extent={{-90,80},{80,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{10,80},{78,0},{30,-80}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Unmixed")}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(revisions="<html>
<ul>
<li>October 25, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>Simple controller for unmixed circuit.</p>
</html>"));
end CtrUnmixed;
