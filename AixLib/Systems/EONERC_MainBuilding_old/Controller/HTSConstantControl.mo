within AixLib.Systems.EONERC_MainBuilding_old.Controller;
model HTSConstantControl
  "Constant input for test purposes of high termperature system"
  BaseClasses.HighTempSystemBus highTemperatureSystemBus annotation (Placement(
        transformation(extent={{82,-16},{118,18}}), iconTransformation(extent={
            {84,-14},{116,16}})));
  Modelica.Blocks.Sources.Constant rpmPumps(k=2000)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Sources.Constant valveOpening(k=0.5)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Sources.Constant TChpSet(k=333.15)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.Constant uRelBoilerSet(k=333.15)
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
equation
  connect(rpmPumps.y, highTemperatureSystemBus.admixBus1.pumpBus.rpmSet)
    annotation (Line(points={{1,70},{100.09,70},{100.09,1.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumps.y, highTemperatureSystemBus.admixBus2.pumpBus.rpmSet)
    annotation (Line(points={{1,70},{100.09,70},{100.09,1.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumps.y, highTemperatureSystemBus.throttlePumpBus.pumpBus.rpmSet)
    annotation (Line(points={{1,70},{100.09,70},{100.09,1.085}}, color={0,0,127}),
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
  connect(booleanConstant.y, highTemperatureSystemBus.onOffChpSet) annotation (
      Line(points={{61,50},{76,50},{76,44},{100.09,44},{100.09,1.085}},
                                                              color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valveOpening.y, highTemperatureSystemBus.admixBus1.valveSet)
    annotation (Line(points={{1,0},{46,0},{46,1.085},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valveOpening.y, highTemperatureSystemBus.admixBus2.valveSet)
    annotation (Line(points={{1,0},{46,0},{46,1.085},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valveOpening.y, highTemperatureSystemBus.throttlePumpBus.valveSet)
    annotation (Line(points={{1,0},{46,0},{46,1.085},{100.09,1.085}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TChpSet.y, highTemperatureSystemBus.TChpSet) annotation (Line(points={
          {1,-50},{44,-50},{44,-40},{100.09,-40},{100.09,1.085}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(uRelBoilerSet.y, highTemperatureSystemBus.uRelBoiler1Set) annotation (
     Line(points={{1,-90},{42,-90},{42,-88},{100.09,-88},{100.09,1.085}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(uRelBoilerSet.y, highTemperatureSystemBus.uRelBoiler2Set) annotation (
     Line(points={{1,-90},{42,-90},{42,-92},{100.09,-92},{100.09,1.085}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-100,100},{98,2},{-100,-100}},
          color={0,0,0},
          thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end HTSConstantControl;
