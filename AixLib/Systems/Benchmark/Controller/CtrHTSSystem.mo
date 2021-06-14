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
  Controls.Continuous.LimPID PIDBoiler(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=60,
    Td=0,
    reverseActing=not (false)) annotation (Dialog(enable=true, group=
          "PID Controllers"), Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Sources.Constant TBoilerSet_out(final k=T_boi_set)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-20,-42},{0,-22}})));
  parameter Real T_boi_set=273.15 + 80 "Set point temperature of boiler";
  parameter Real T_chp_set=333.15 "Set point temperature of chp";
equation

  connect(TChpSet.y, htsBus.TChpSet) annotation (Line(points={{41,-50},{100,-50},
          {100,-36},{100.09,-36},{100.09,1.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TBoilerSet_out.y, PIDBoiler.u_s) annotation (Line(points={{-79,20},{-42,
          20}},                         color={0,0,127}));
  connect(PIDBoiler.y, htsBus.uRelBoilerSet) annotation (Line(points={{-19,20},{
          100,20},{100,1.085},{100.09,1.085}},
                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant1.y, htsBus.onOffChpSet) annotation (Line(points={{1,-32},
          {100.09,-32},{100.09,1.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumps.y, htsBus.pumpBoilerBus.pumpBus.rpmSet) annotation (Line(
        points={{61,90},{82,90},{82,92},{100.09,92},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumps.y, htsBus.pumpChpBus.pumpBus.rpmSet) annotation (Line(
        points={{61,90},{100.09,90},{100.09,1.085}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, htsBus.pumpBoilerBus.pumpBus.onSet)
    annotation (Line(points={{61,50},{76,50},{76,52},{100.09,52},{100.09,1.085}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, htsBus.pumpChpBus.pumpBus.onSet) annotation (
     Line(points={{61,50},{100.09,50},{100.09,1.085}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PIDBoiler.u_m, htsBus.pumpBoilerBus.TRtrnInMea) annotation (Line(
        points={{-30,8},{-30,1.085},{100.09,1.085}}, color={0,0,127}), Text(
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
end CtrHTSSystem;
