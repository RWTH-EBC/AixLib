within AixLib.Systems.EONERC_MainBuilding.Controller;
block CtrHXSsystem
  "Controller for heat exchanger system of E.ON ERC main building"
  //Boolean choice;
  extends AixLib.Systems.HydraulicModules.Controller.CtrMix;
  parameter Real rpm_pump_htc(min=0, unit="1") = 2000 "Rpm of the pump on the high temperature side";

  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.01)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBusHTC
    "Hydraulic bus for HTC part of heat exchanger system" annotation (Placement(
        transformation(extent={{74,52},{128,108}}), iconTransformation(extent={{66,20},
            {120,72}})));
  Modelica.Blocks.Sources.Constant constRpmPump1(final k=rpm_pump_htc)
                                                                  annotation (Placement(transformation(extent={{0,80},{
            20,100}})));
equation
  connect(PID.y, greaterThreshold.u)
    annotation (Line(points={{5,-50},{-2,-50},{-2,50}}, color={0,0,127}));
  connect(greaterThreshold.y, booleanToReal.u) annotation (Line(points={{21,50},
          {30,50},{30,80},{38,80}}, color={255,0,255}));
  connect(booleanToReal.y, hydraulicBusHTC.valSet) annotation (Line(points={{61,
          80},{82,80},{82,80.14},{101.135,80.14}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold.y, hydraulicBusHTC.pumpBus.onOff_Input) annotation (
      Line(points={{21,50},{32,50},{32,52},{101.135,52},{101.135,80.14}}, color=
         {255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constRpmPump1.y, hydraulicBusHTC.pumpBus.rpm_Input) annotation (Line(
        points={{21,90},{79.5,90},{79.5,80.14},{101.135,80.14}}, color={0,0,127}),
      Text(
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
end CtrHXSsystem;
