within AixLib.Systems.Benchmark.Controller;
model CtrHTSSystem "Controller of high termperature system"
  BaseClasses.HighTempSystemBus htsBus annotation (Placement(transformation(
          extent={{82,-16},{118,18}}), iconTransformation(extent={{84,-14},{116,
            16}})));
  Modelica.Blocks.Sources.Constant rpmPumps(k=3000)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Sources.Constant TChpSet(final k=T_chp_set)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Controls.Continuous.LimPID PIDadmix(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    final reverseAction=true) annotation (Dialog(enable=true, group=
          "PID Controllers"), Placement(transformation(extent={{-40,80},{-20,
            100}})));
  Controls.Continuous.LimPID PIDBoiler(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    final reverseAction=false) annotation (Dialog(enable=true, group="PID Controllers"),
      Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Constant TBoilerSet_in(final k=T_set_in)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant TBoilerSet_out(final k=T_set)
    annotation (Placement(transformation(extent={{-102,-20},{-82,0}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-20,-42},{0,-22}})));
  Modelica.Blocks.Sources.Constant One(k=1)
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  parameter Real T_set_in=273.15 + 50 "Admixed temperature of boiler inflow ";
  parameter Real T_set=273.15 + 80 "Set point temperature of boiler";
  parameter Real T_chp_set=333.15 "Set point temperature of chp";
equation

  connect(TChpSet.y, htsBus.TChpSet) annotation (Line(points={{41,-50},{100,-50},
          {100,-36},{100.09,-36},{100.09,1.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TBoilerSet_in.y, PIDadmix.u_s)
    annotation (Line(points={{-79,90},{-42,90}}, color={0,0,127}));
  connect(PIDadmix.y, htsBus.admixBus1.valSet) annotation (Line(points={{-19,90},
          {10,90},{10,1},{100,1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDadmix.u_m, htsBus.admixBus1.TFwrd_out) annotation (Line(points={{-30,
          78},{-10,78},{-10,2},{10,2},{10,1},{100,1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TBoilerSet_out.y, PIDBoiler.u_s) annotation (Line(points={{-81,-10},
          {-74,-10},{-74,50},{-42,50}}, color={0,0,127}));
  connect(PIDBoiler.y, htsBus.uRelBoilerSet) annotation (Line(points={{-19,50},
          {-18,50},{-18,1.085},{100.09,1.085}},
                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDBoiler.u_m, htsBus.admixBus1.TRtrn_in) annotation (Line(points={{-30,
          38},{-30,1},{100,1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(booleanConstant1.y, htsBus.onOffChpSet) annotation (Line(points={{1,-32},
          {100.09,-32},{100.09,1.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(One.y, htsBus.throttlePumpBus.valSet) annotation (Line(points={{81,-70},
          {100,-70},{100,1},{100,1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(rpmPumps.y, htsBus.pumpBoilerBus.pumpBus.rpm_Input) annotation (Line(
        points={{61,90},{82,90},{82,92},{100.09,92},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumps.y, htsBus.pumpChpBus.pumpBus.rpm_Input) annotation (Line(
        points={{61,90},{100.09,90},{100.09,1.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, htsBus.pumpBoilerBus.pumpBus.onOff_Input)
    annotation (Line(points={{61,50},{76,50},{76,52},{100.09,52},{100.09,1.085}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, htsBus.pumpChpBus.pumpBus.onOff_Input) annotation
    (Line(points={{61,50},{100.09,50},{100.09,1.085}}, color={255,0,255}), Text(
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
          extent={{-48,24},{98,-16}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                            Diagram(coordinateSystem(preserveAspectRatio=false)));
end CtrHTSSystem;
