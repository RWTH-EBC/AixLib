within AixLib.Systems.EONERC_MainBuilding.Controller;
block CtrGTFSimpleFlowCtrl "Controller for geothermal field"
  //Boolean choice;
  parameter Real rpmPump(min=0, unit="1") = 2100 "Rpm of the pump";
  parameter Real k(min=0, unit="1") = 0.025 "Gain of controller" annotation(Dialog(group="PID"));
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=60 annotation(Dialog(group="PID"));
   parameter Modelica.SIunits.Time Td(min=Modelica.Constants.small)=60 annotation(Dialog(group="PID"));
  BaseClasses.TwoCircuitBus gtfBus annotation (Placement(transformation(extent=
            {{80,-18},{120,18}}), iconTransformation(extent={{96,-18},{130,18}})));
  Controls.Continuous.LimPID conPID(
    k=k,
    Ti=Ti,
    Td=Td,
    yMax=rpmPump)
    annotation (Placement(transformation(extent={{-42,-34},{-22,-14}})));
  Modelica.Blocks.Math.Gain cubicmeters2kgpersec(k=1000)
    annotation (Placement(transformation(extent={{46,-64},{32,-50}})));
  Modelica.Blocks.Interfaces.RealInput mflow_gtf
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-112,-8},{-94,10}}), iconTransformation(extent={{-112,-8},{-94,
            10}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{26,48},{46,68}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold4
    annotation (Placement(transformation(extent={{-2,-4},{8,6}})));
equation
  connect(conPID.y, gtfBus.primBus.pumpBus.rpmSet) annotation (Line(points={{-21,
          -24},{40,-24},{40,0.09},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(cubicmeters2kgpersec.u, gtfBus.primBus.VFlowInMea) annotation (Line(
        points={{47.4,-57},{98.7,-57},{98.7,0.09},{100.1,0.09}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(cubicmeters2kgpersec.y, conPID.u_m) annotation (Line(points={{31.3,-57},
          {-32.35,-57},{-32.35,-36},{-32,-36}}, color={0,0,127}));
  connect(conPID.u_s, mflow_gtf) annotation (Line(points={{-44,-24},{-72,-24},{-72,
          1},{-103,1}}, color={0,0,127}));
  connect(booleanToReal.y, gtfBus.secBus.valveSet) annotation (Line(points={{47,
          58},{100,58},{100,0.09},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID.y, greaterThreshold4.u)
    annotation (Line(points={{-21,-24},{-21,1},{-3,1}}, color={0,0,127}));
  connect(greaterThreshold4.y, gtfBus.primBus.pumpBus.onSet) annotation (Line(
        points={{8.5,1},{52.25,1},{52.25,0.09},{100.1,0.09}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold4.y, booleanToReal.u) annotation (Line(points={{8.5,1},
          {20,1},{20,2},{24,2},{24,58}}, color={255,0,255}));
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
end CtrGTFSimpleFlowCtrl;
