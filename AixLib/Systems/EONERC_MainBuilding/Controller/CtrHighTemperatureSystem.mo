within AixLib.Systems.EONERC_MainBuilding.Controller;
model CtrHighTemperatureSystem
  "Controller of high termperature system"
  BaseClasses.HighTemperatureSystemBus highTemperatureSystemBus annotation (
      Placement(transformation(extent={{82,-16},{118,18}}), iconTransformation(
          extent={{84,-14},{116,16}})));
  Modelica.Blocks.Sources.Constant rpmPumps(k=3000)
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Sources.Constant TChpSet(k=333.15)
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Controls.Continuous.LimPID PIDadmix1(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    final reverseAction=true)
    annotation (Dialog(enable=true, group="PID Controllers"),Placement(transformation(extent={{-60,80},
            {-40,100}})));
  Controls.Continuous.LimPID PIDadmix2(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    final reverseAction=true)
    annotation (Dialog(enable=true, group="PID Controllers"),Placement(transformation(extent={{-60,-20},
            {-40,0}})));
  Controls.Continuous.LimPID PIDBoiler1(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    final reverseAction=false) annotation (Dialog(enable=true, group="PID Controllers"),
      Placement(transformation(extent={{-60,40},{-40,60}})));
  Controls.Continuous.LimPID PIDBoiler2(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    final reverseAction=false) annotation (Dialog(enable=true, group="PID Controllers"),
      Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.Constant TBoiler1Set_in(k=273.15 + 50)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant TBoilerSet_out(k=273.15 + 80)
    annotation (Placement(transformation(extent={{-118,-20},{-98,0}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Blocks.Sources.Constant One(k=1)
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
equation
  connect(rpmPumps.y, highTemperatureSystemBus.admixBus1.pumpBus.rpm_Input)
    annotation (Line(points={{21,90},{100.09,90},{100.09,1.085}},color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumps.y, highTemperatureSystemBus.admixBus2.pumpBus.rpm_Input)
    annotation (Line(points={{21,90},{100.09,90},{100.09,1.085}},color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumps.y, highTemperatureSystemBus.throttlePumpBus.pumpBus.rpm_Input)
    annotation (Line(points={{21,90},{100.09,90},{100.09,1.085}},color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, highTemperatureSystemBus.admixBus2.pumpBus.onOff_Input)
    annotation (Line(points={{61,50},{100.09,50},{100.09,1.085}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, highTemperatureSystemBus.admixBus1.pumpBus.onOff_Input)
    annotation (Line(points={{61,50},{100.09,50},{100.09,1.085}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, highTemperatureSystemBus.throttlePumpBus.pumpBus.onOff_Input)
    annotation (Line(points={{61,50},{100.09,50},{100.09,1.085}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(TChpSet.y, highTemperatureSystemBus.TChpSet) annotation (Line(points={{81,-90},
          {100,-90},{100,-40},{100.09,-40},{100.09,1.085}},       color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TBoiler1Set_in.y, PIDadmix1.u_s) annotation (Line(points={{-79,90},
          {-70.5,90},{-70.5,90},{-62,90}}, color={0,0,127}));
  connect(PIDadmix1.y, highTemperatureSystemBus.admixBus1.valSet) annotation (
     Line(points={{-39,90},{-10,90},{-10,1.085},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TBoiler1Set_in.y, PIDadmix2.u_s) annotation (Line(points={{-79,90},
          {-78,90},{-78,-10},{-62,-10}}, color={0,0,127}));
  connect(PIDadmix2.y, highTemperatureSystemBus.admixBus2.valSet) annotation (
     Line(points={{-39,-10},{100,-10},{100,1.085},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDadmix1.u_m, highTemperatureSystemBus.admixBus1.TFwrd_out)
    annotation (Line(points={{-50,78},{-10,78},{-10,2},{10,2},{10,1.085},{
          100.09,1.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDadmix2.u_m, highTemperatureSystemBus.admixBus2.TFwrd_out)
    annotation (Line(points={{-50,-22},{100.09,-22},{100.09,1.085}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TBoilerSet_out.y, PIDBoiler1.u_s) annotation (Line(points={{-97,-10},
          {-92,-10},{-92,50},{-62,50}}, color={0,0,127}));
  connect(TBoilerSet_out.y, PIDBoiler2.u_s) annotation (Line(points={{-97,-10},
          {-92,-10},{-92,-50},{-62,-50}}, color={0,0,127}));
  connect(PIDBoiler1.y, highTemperatureSystemBus.uRelBoiler1Set) annotation (
      Line(points={{-39,50},{-18,50},{-18,1.085},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDBoiler2.y, highTemperatureSystemBus.uRelBoiler2Set) annotation (
      Line(points={{-39,-50},{100.09,-50},{100.09,1.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDBoiler2.u_m, highTemperatureSystemBus.admixBus2.TRtrn_in)
    annotation (Line(points={{-50,-62},{100.09,-62},{100.09,1.085}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDBoiler1.u_m, highTemperatureSystemBus.admixBus1.TRtrn_in)
    annotation (Line(points={{-50,38},{-50,1.085},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(booleanConstant1.y, highTemperatureSystemBus.onOffChpSet)
    annotation (Line(points={{41,-90},{42,-90},{42,-70},{100.09,-70},{100.09,
          1.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(One.y, highTemperatureSystemBus.throttlePumpBus.valSet) annotation (
     Line(points={{121,-90},{120,-90},{120,1.085},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
          extent={{-48,24},{98,-16}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                            Diagram(coordinateSystem(preserveAspectRatio=false)));
end CtrHighTemperatureSystem;
