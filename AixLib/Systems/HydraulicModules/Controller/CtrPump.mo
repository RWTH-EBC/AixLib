within AixLib.Systems.HydraulicModules.Controller;
block CtrPump "controller for pump circuit"
  //Boolean choice;

  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm rpm_pump(min=0) = 2000 "Rpm of the Pump";

  Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  BaseClasses.HydraulicBus hydraulicBus annotation (Placement(
        transformation(extent={{76,-24},{124,24}}), iconTransformation(extent={{90,-22},
            {138,26}})));
equation
  connect(constRpmPump.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={
          {11,0},{56,0},{56,0.12},{100.12,0.12}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, hydraulicBus.pumpBus.onSet) annotation (Line(
        points={{81,30},{98,30},{98,0.12},{100.12,0.12}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{-100,100},{-36,-2},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,20},{98,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(revisions="<html><ul>
  <li>October 25, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Simple controller for unmixed circuit. Only the pump frequency has to
  be set. The pump is always on.
</p>
</html>"));
end CtrPump;
