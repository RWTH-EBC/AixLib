within AixLib.Systems.EONERC_MainBuilding.Controller;
model CtrHighTemperatureSystem
  "Controller of high termperature system"
  BaseClasses.HighTempSystemBus highTemperatureSystemBus annotation (Placement(
        transformation(extent={{82,-16},{118,18}}), iconTransformation(extent={
            {84,-14},{116,16}})));
  Modelica.Blocks.Sources.Constant rpmPumps(k=3000)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Sources.Constant TChpSet(final k=T_chp_set)
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Controls.Continuous.LimPID PIDadmix1(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    reverseActing=false)      annotation (Dialog(enable=true, group=
          "PID Controllers"), Placement(transformation(extent={{-40,80},{-20,
            100}})));
  Controls.Continuous.LimPID PIDadmix2(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    reverseActing=false)      annotation (Dialog(enable=true, group=
          "PID Controllers"), Placement(transformation(extent={{-60,-20},{-40,0}})));
  Controls.Continuous.LimPID PIDBoiler1(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    reverseActing=true)        annotation (Dialog(enable=true, group=
          "PID Controllers"), Placement(transformation(extent={{-40,40},{-20,60}})));
  Controls.Continuous.LimPID PIDBoiler2(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    reverseActing=true)        annotation (Dialog(enable=true, group=
          "PID Controllers"), Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.Constant TBoiler1Set_in(final k=T_set_in)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant TBoilerSet_out(final k=T_set)
    annotation (Placement(transformation(extent={{-102,-20},{-82,0}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
  Modelica.Blocks.Sources.Constant One(k=1)
    annotation (Placement(transformation(extent={{62,-100},{82,-80}})));
  parameter Real T_set_in=273.15 + 50 "Admixed temperature of boiler inflow ";
  parameter Real T_set=273.15 + 80 "Set point temperature of boiler";
  parameter Real T_chp_set=333.15 "Set point temperature of chp";
  Controls.Continuous.LimPID PIDBoiler3(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    reverseActing=not (false)) annotation (Dialog(enable=true, group=
          "PID Controllers"), Placement(transformation(extent={{20,-100},{40,-80}})));
equation
  connect(rpmPumps.y, highTemperatureSystemBus.admixBus1.pumpBus.rpmSet)
    annotation (Line(points={{61,90},{100.09,90},{100.09,1.085}},color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumps.y, highTemperatureSystemBus.admixBus2.pumpBus.rpmSet)
    annotation (Line(points={{61,90},{100.09,90},{100.09,1.085}},color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumps.y, highTemperatureSystemBus.throttlePumpBus.pumpBus.rpmSet)
    annotation (Line(points={{61,90},{100.09,90},{100.09,1.085}},color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, highTemperatureSystemBus.admixBus2.pumpBus.onSet)
    annotation (Line(points={{61,50},{100.09,50},{100.09,1.085}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, highTemperatureSystemBus.admixBus1.pumpBus.onSet)
    annotation (Line(points={{61,50},{100.09,50},{100.09,1.085}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, highTemperatureSystemBus.throttlePumpBus.pumpBus.onSet)
    annotation (Line(points={{61,50},{100.09,50},{100.09,1.085}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(TBoiler1Set_in.y, PIDadmix1.u_s) annotation (Line(points={{-79,90},{
          -42,90}},                        color={0,0,127}));
  connect(PIDadmix1.y, highTemperatureSystemBus.admixBus1.valveSet) annotation (
     Line(points={{-19,90},{10,90},{10,1.085},{100.09,1.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TBoiler1Set_in.y, PIDadmix2.u_s) annotation (Line(points={{-79,90},{
          -66,90},{-66,-10},{-62,-10}},  color={0,0,127}));
  connect(PIDadmix2.y, highTemperatureSystemBus.admixBus2.valveSet) annotation (
     Line(points={{-39,-10},{100,-10},{100,1.085},{100.09,1.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDadmix1.u_m, highTemperatureSystemBus.admixBus1.TFwrdOutMea)
    annotation (Line(points={{-30,78},{-10,78},{-10,2},{10,2},{10,1.085},{100.09,
          1.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDadmix2.u_m, highTemperatureSystemBus.admixBus2.TFwrdOutMea)
    annotation (Line(points={{-50,-22},{100.09,-22},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TBoilerSet_out.y, PIDBoiler1.u_s) annotation (Line(points={{-81,-10},
          {-74,-10},{-74,50},{-42,50}}, color={0,0,127}));
  connect(TBoilerSet_out.y, PIDBoiler2.u_s) annotation (Line(points={{-81,-10},
          {-74,-10},{-74,-50},{-22,-50}}, color={0,0,127}));
  connect(PIDBoiler1.y, highTemperatureSystemBus.uRelBoiler1Set) annotation (
      Line(points={{-19,50},{-18,50},{-18,1.085},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDBoiler2.y, highTemperatureSystemBus.uRelBoiler2Set) annotation (
      Line(points={{1,-50},{100.09,-50},{100.09,1.085}},   color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDBoiler2.u_m, highTemperatureSystemBus.admixBus2.TRtrnInMea)
    annotation (Line(points={{-10,-62},{100.09,-62},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDBoiler1.u_m, highTemperatureSystemBus.admixBus1.TRtrnInMea)
    annotation (Line(points={{-30,38},{-30,1.085},{100.09,1.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(booleanConstant1.y, highTemperatureSystemBus.onOffChpSet)
    annotation (Line(points={{-59,-90},{-48,-90},{-48,-70},{100.09,-70},{100.09,
          1.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(One.y, highTemperatureSystemBus.throttlePumpBus.valveSet) annotation (
     Line(points={{83,-90},{100,-90},{100,1.085},{100.09,1.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TChpSet.y, PIDBoiler3.u_s)
    annotation (Line(points={{1,-90},{18,-90}}, color={0,0,127}));
  connect(PIDBoiler3.y, highTemperatureSystemBus.uRelChpSet) annotation (Line(
        points={{41,-90},{100.09,-90},{100.09,1.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDBoiler3.u_m, highTemperatureSystemBus.throttlePumpBus.TRtrnInMea)
    annotation (Line(points={{30,-102},{30,-120},{100.09,-120},{100.09,1.085}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
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
