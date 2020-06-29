within AixLib.Systems.EONERC_MainBuilding_old.Controller;
block CtrGTFSimple "Controller for geothermal field"
  //Boolean choice;
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Interfaces.BooleanInput on
                                   "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.Constant rpm(k=rpmPump)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  parameter Real rpmPump(min=0, unit="1") = 2100 "Rpm of the pump";
  BaseClasses.TwoCircuitBus gtfBus annotation (Placement(transformation(extent=
            {{80,-18},{120,18}}), iconTransformation(extent={{96,-18},{130,18}})));
equation
  connect(on, gtfBus.primBus.pumpBus.onSet) annotation (Line(points = {{-120, 0}, {-26, 0}, {-26, 0.09}, {100.1, 0.09}}, color = {255, 0, 255}));
  connect(booleanToReal.u, on) annotation (Line(points={{38,80},{-50,80},{-50,0},
          {-120,0}},                  color={255,0,255}));
  connect(booleanToReal.y, gtfBus.secBus.valveSet) annotation (Line(points={{61,
          80},{78,80},{78,82},{100.1,82},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpm.y, gtfBus.primBus.pumpBus.rpmSet) annotation (Line(points={{21,
          -30},{100.1,-30},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                         Line(
          points={{20,80},{80,0},{40,-80}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-80,20},{66,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control"),
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,100},{-38,0},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,22},{98,-18}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(revisions="<html>
<ul>
<li>January 22, 2019, by Alexander K&uuml;mpel:<br/>External T_set added.</li>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>Simple controller for admix and injection circuit. The controlled variable is the outflow temperature T_fwrd_out.</p>
</html>"));
end CtrGTFSimple;
