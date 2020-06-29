within AixLib.Systems.EONERC_MainBuilding_old.Controller;
model CtrSWU "Mode based controller for switching unit 
Mode 1: GTF for heating mode
Mode 2: GTF and Consumer for heating mode
Mode 3: free cooling of consumers with GTF
Mode 4: No GTF, cooling of consumers with HP
Mode 5: Cooling with GTF and HP"

  parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the pump";
  BaseClasses.SwitchingUnitBus sWUBus annotation (Placement(transformation(
          extent={{80,-18},{120,18}}), iconTransformation(extent={{84,-16},{
            116,16}})));
  Modelica.Blocks.Interfaces.IntegerInput mode "Modes 1 to 5"
                                               annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-120,-20},{-80,20}})));
  Real K1 "Opening for flap K1";
  Real K2 "Opening for flap K2";
  Real K3 "Opening for flap K3";
  Real K4 "Opening for flap K4";
  Real Y2 "Opening for valve Y1";
  Real Y3 "Opening for valve Y2";
  Boolean pumpOn "Pump on signal";

  Modelica.Blocks.Sources.RealExpression realExpression1(y=K1)
    annotation (Placement(transformation(extent={{-20,34},{0,54}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=K2)
    annotation (Placement(transformation(extent={{-20,14},{0,34}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=K3)
    annotation (Placement(transformation(extent={{-20,-6},{0,14}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=K4)
    annotation (Placement(transformation(extent={{-20,-28},{0,-8}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=Y2)
    annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=Y3)
    annotation (Placement(transformation(extent={{-20,-66},{0,-46}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=pumpOn)
    annotation (Placement(transformation(extent={{-20,54},{0,74}})));
  Modelica.Blocks.Sources.Constant const(k=rpm_pump)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
equation
  if mode == 1 then
    K1=0;
    K2=0;
    K3=1;
    K4=1;
    Y2=0;
    Y3=0;
    pumpOn=true;
  elseif mode == 2 then
    K1=1;
    K2=0;
    K3=1;
    K4=1;
    Y2=0;
    Y3=1;
    pumpOn=true;
  elseif mode == 3 then
    K1=0;
    K2=1;
    K3=0;
    K4=0;
    Y2=1;
    Y3=0;
    pumpOn=false;
  elseif mode == 4 then
    K1=1;
    K2=0;
    K3=0;
    K4=0;
    Y2=0;
    Y3=1;
    pumpOn=false;
  elseif mode == 5 then
    K1=1;
    K2=1;
    K3=0;
    K4=0;
    Y2=1;
    Y3=1;
    pumpOn=false;
  else
    K1=0;
    K2=0;
    K3=0;
    K4=0;
    Y2=0;
    Y3=0;
    pumpOn=false;
  end if;

  connect(realExpression1.y, sWUBus.K1valSet) annotation (Line(points={{1,44},{50,
          44},{50,0.09},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression2.y, sWUBus.K2valSet) annotation (Line(points={{1,24},{48,
          24},{48,0.09},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression3.y, sWUBus.K3valSet) annotation (Line(points={{1,4},{50,
          4},{50,0.09},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression4.y, sWUBus.K4valSet) annotation (Line(points={{1,-18},{
          100.1,-18},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression5.y, sWUBus.Y2valSet) annotation (Line(points={{1,-36},{
          100.1,-36},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression6.y, sWUBus.Y3valSet) annotation (Line(points={{1,-56},
          {100.1,-56},{100.1,0.09}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanExpression.y, sWUBus.pumpBus.onSet) annotation (Line(points={{
          1,64},{44,64},{44,60},{100.1,60},{100.1,0.09}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, sWUBus.pumpBus.rpmSet) annotation (Line(points={{1,90},{
          100.1,90},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-80,20},{66,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{-100,100},{-34,2},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,24},{98,-16}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Controller for switchung unit: routing between consumer, geothermal field (gtf) and heatpump (HP)</p>
<p><br>Mode 1: GTF for heating mode</p>
<p>Mode 2: GTF and Consumer for heating mode</p>
<p>Mode 3: free cooling of consumers with GTF</p>
<p>Mode 4: No GTF, cooling of consumers with HP</p>
<p>Mode 5: Cooling with GTF and HP</p>
</html>"));
end CtrSWU;
