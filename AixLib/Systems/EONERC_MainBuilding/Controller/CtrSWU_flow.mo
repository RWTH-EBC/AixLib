within AixLib.Systems.EONERC_MainBuilding.Controller;
model CtrSWU_flow "Mode based controller for switching unit 
Mode 1: GTF for heating mode
Mode 2: GTF and Consumer for heating mode
Mode 3: free cooling of consumers with GTF
Mode 4: No GTF, cooling of consumers with HP
Mode 5: Cooling with GTF and HP"

  parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the pump";
  parameter Real k = 1 "Proportional Constant of Pump";
  parameter Real Ti = 60 "Time Constant of Pump";
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(group="PID"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation(Dialog(group="PID"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(group="PID"));
  BaseClasses.SwitchingUnitBus sWUBus annotation (Placement(transformation(
          extent={{80,-18},{120,18}}), iconTransformation(extent={{84,-16},{
            116,16}})));
  Modelica.Blocks.Interfaces.IntegerInput mode "Modes 1 to 5"
                                               annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}),iconTransformation(
          extent={{-120,-74},{-80,-34}})));
  Real K1 "Opening for flap K1";
  Real K2 "Opening for flap K2";
  Real K3 "Opening for flap K3";
  Real K4 "Opening for flap K4";
  Real Y2 "Opening for valve Y1";
  Real Y3 "Opening for valve Y2";
  Boolean pumpOn "Pump on signal";

  Modelica.Blocks.Sources.RealExpression realExpression1(y=K1)
    annotation (Placement(transformation(extent={{-18,-8},{2,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=K2)
    annotation (Placement(transformation(extent={{-18,-28},{2,-8}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=K3)
    annotation (Placement(transformation(extent={{-18,-48},{2,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=K4)
    annotation (Placement(transformation(extent={{-18,-70},{2,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=Y2)
    annotation (Placement(transformation(extent={{-18,-88},{2,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=Y3)
    annotation (Placement(transformation(extent={{-18,-108},{2,-88}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=pumpOn)
    annotation (Placement(transformation(extent={{-18,12},{2,32}})));
  Modelica.Blocks.Sources.Constant const(k=rpm_pump)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  Controls.Continuous.LimPID        PID1(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k,
    final Ti=Ti,
    final xi_start=0,
    final xd_start=xd_start,
    final y_start=y_start,
    final reverseAction=false)
            annotation (Placement(transformation(extent={{-20,44},{0,64}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{38,64},{58,84}})));
  Modelica.Blocks.Interfaces.RealInput mFlowHxGtf
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-140,20},{-100,60}}), iconTransformation(extent={{-120,34},{-80,
            74}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{28,-24},{48,-4}})));
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

  connect(realExpression1.y, sWUBus.K1valSet) annotation (Line(points={{3,2},{52,
          2},{52,0.09},{100.1,0.09}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression3.y, sWUBus.K3valSet) annotation (Line(points={{3,-38},{
          100,-38},{100,0.09},{100.1,0.09}},
                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression4.y, sWUBus.K4valSet) annotation (Line(points={{3,-60},{
          100.1,-60},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression5.y, sWUBus.Y2valSet) annotation (Line(points={{3,-78},{
          100.1,-78},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression6.y, sWUBus.Y3valSet) annotation (Line(points={{3,-98},{
          100.1,-98},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanExpression.y, sWUBus.pumpBus.onSet) annotation (Line(points={{3,22},{
          46,22},{46,18},{100.1,18},{100.1,0.09}},        color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const.y, product1.u1) annotation (Line(points={{1,90},{18,90},{18,80},
          {36,80}}, color={0,0,127}));
  connect(PID1.u_s, mFlowHxGtf) annotation (Line(points={{-22,54},{-64,54},{-64,
          40},{-120,40}}, color={0,0,127}));
  connect(product1.y, sWUBus.pumpBus.rpmSet) annotation (Line(points={{59,74},{100,
          74},{100,0.09},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID1.y, product1.u2) annotation (Line(points={{1,54},{18,54},{18,68},{
          36,68}}, color={0,0,127}));
  connect(PID1.u_m, sWUBus.mFlowHxGtf) annotation (Line(points={{-10,42},{100,42},
          {100,0.09},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression2.y, product2.u2) annotation (Line(points={{3,-18},{16,-18},
          {16,-20},{26,-20}}, color={0,0,127}));
  connect(product2.y, sWUBus.K2valSet) annotation (Line(points={{49,-14},{72,-14},
          {72,0.09},{100.1,0.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(product2.u1, product1.u2) annotation (Line(points={{26,-8},{22,-8},{22,
          54},{18,54},{18,68},{36,68}}, color={0,0,127}));
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
end CtrSWU_flow;
