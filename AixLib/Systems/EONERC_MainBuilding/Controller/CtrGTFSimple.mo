within AixLib.Systems.EONERC_MainBuilding.Controller;
block CtrGTFSimple "Controller for geothermal field"
  //Boolean choice;
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  HydraulicModules.BaseClasses.HydraulicBus busThrottle
    "Hydraulic bus Throttle" annotation (Placement(transformation(extent={{74,52},
            {128,108}}), iconTransformation(extent={{74,18},{128,70}})));
  HydraulicModules.BaseClasses.HydraulicBus busPump "Hydraulic bus Throttle"
    annotation (Placement(transformation(extent={{74,-28},{128,28}}),
        iconTransformation(extent={{76,-70},{130,-18}})));
  Modelica.Blocks.Interfaces.BooleanInput on
                                   "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Sources.Constant rpm(k=rpmPump)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  parameter Real rpmPump(min=0, unit="1") = 3000 "Rpm of the pump";
equation
  connect(booleanToReal.y, busThrottle.valSet) annotation (Line(points={{61,80},
          {82,80},{82,80.14},{101.135,80.14}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanToReal.u, on) annotation (Line(points={{38,80},{-6,80},{-6,78},
          {-50,78},{-50,0},{-120,0}}, color={255,0,255}));
  connect(on, busPump.pumpBus.onOff_Input) annotation (Line(points={{-120,0},{-16,
          0},{-16,0.14},{101.135,0.14}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpm.y, busPump.pumpBus.rpm_Input) annotation (Line(points={{21,-30},{62,
          -30},{62,-34},{101.135,-34},{101.135,0.14}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
          Rectangle(
          extent={{-90,80},{70,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{10,80},{70,0},{30,-80}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-90,20},{56,-20}},
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
