within AixLib.Systems.EONERC_MainBuilding.Controller;
model EON_ERC_FlowControl
  BaseClasses.MainBus mainBus
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  HeatPumpSystemVolumeFlowControl heatPumpSystemVolumeFlowControl
    annotation (Placement(transformation(extent={{-46,50},{-4,100}})));
  CtrGTFSimpleFlowCtrl ctrGTFSimpleFlowCtrl
    annotation (Placement(transformation(extent={{-46,8},{-4,46}})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve
    annotation (Placement(transformation(extent={{-46,-22},{-4,4}})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve1
    annotation (Placement(transformation(extent={{-46,-52},{-4,-26}})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve2
    annotation (Placement(transformation(extent={{-46,-82},{-4,-56}})));
equation
  connect(heatPumpSystemVolumeFlowControl.heatPumpSystemBus1, mainBus.hpSystemBus)
    annotation (Line(
      points={{-4,75.1563},{48,75.1563},{48,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrGTFSimpleFlowCtrl.gtfBus, mainBus.gtfBus) annotation (Line(
      points={{-1.27,27},{48.365,27},{48.365,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMixVflowConstValve.hydraulicBus, mainBus.consLtcBus) annotation (
      Line(
      points={{-1.06,-8.74},{47.47,-8.74},{47.47,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMixVflowConstValve1.hydraulicBus, mainBus.consCold1Bus)
    annotation (Line(
      points={{-1.06,-38.74},{49.47,-38.74},{49.47,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMixVflowConstValve2.hydraulicBus, mainBus.consCold2Bus)
    annotation (Line(
      points={{-1.06,-68.74},{46.47,-68.74},{46.47,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          extent={{-50,22},{96,-18}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}), Diagram(coordinateSystem(preserveAspectRatio=
           false)));
end EON_ERC_FlowControl;
