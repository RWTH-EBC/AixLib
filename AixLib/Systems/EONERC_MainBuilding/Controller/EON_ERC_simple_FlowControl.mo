within AixLib.Systems.EONERC_MainBuilding.Controller;
model EON_ERC_simple_FlowControl
  BaseClasses.MainBus mainBus
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve2(
    k_pump=1000,
    Ti_pump=30,
    Td_pump=0)
    annotation (Placement(transformation(extent={{-14,-36},{4,-16}})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve1(k_pump=
        1000, Ti_pump=30)
    annotation (Placement(transformation(extent={{-14,-12},{4,8}})));
  HydraulicModules.Controller.CtrMixVflowConstValve ctrMixVflowConstValve3(
    k_pump=1000,
    Ti_pump=30,
    Td_pump=0)
    annotation (Placement(transformation(extent={{-14,16},{4,36}})));
  HeatPumpSystemVolumeFlowControl heatPumpSystemVolumeFlowControl1
    annotation (Placement(transformation(extent={{-14,48},{28,98}})));
  CtrGTFSimpleFlowCtrl            ctrGTFSimpleFlowCtrl(
    k=500,
    Ti=30,
    Td=0) annotation (Placement(transformation(extent={{-14,-66},{4,-46}})));
  CtrSWU_flow ctrSWU_flow
    annotation (Placement(transformation(extent={{-14,-94},{4,-76}})));
  BaseClasses.SimpleERCBus simpleERCBus
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(heatPumpSystemVolumeFlowControl1.heatPumpSystemBus1, mainBus.hpSystemBus)
    annotation (Line(
      points={{28,73.1563},{28,72.5782},{100.05,72.5782},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMixVflowConstValve3.hydraulicBus, mainBus.consLtcBus) annotation (
      Line(
      points={{5.26,26.2},{99.63,26.2},{99.63,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMixVflowConstValve1.hydraulicBus, mainBus.consCold1Bus)
    annotation (Line(
      points={{5.26,-1.8},{100.63,-1.8},{100.63,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrMixVflowConstValve2.hydraulicBus, mainBus.consCold2Bus)
    annotation (Line(
      points={{5.26,-25.8},{99.63,-25.8},{99.63,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrGTFSimpleFlowCtrl.gtfBus, mainBus.gtfBus) annotation (Line(
      points={{5.17,-56},{100,-56},{100,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrSWU_flow.sWUBus, mainBus.swuBus) annotation (Line(
      points={{4,-85},{100,-85},{100,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatPumpSystemVolumeFlowControl1.pElHP, simpleERCBus.pElHp)
    annotation (Line(points={{-15.68,96.4375},{-15.68,97.2188},{-99.95,97.2188},
          {-99.95,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetHS, simpleERCBus.mfSetHpCon)
    annotation (Line(points={{-15.89,87.0625},{-15.89,87.5313},{-99.95,87.5313},
          {-99.95,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetCS, simpleERCBus.mfSetCsIn)
    annotation (Line(points={{-15.68,77.6875},{-100.84,77.6875},{-100.84,0.05},
          {-99.95,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetCold, simpleERCBus.mfSetHpEva)
    annotation (Line(points={{-15.89,68.3125},{-100.945,68.3125},{-100.945,0.05},
          {-99.95,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetRecool, simpleERCBus.mfSetReCool)
    annotation (Line(points={{-15.89,58.9375},{-100.945,58.9375},{-100.945,0.05},
          {-99.95,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatPumpSystemVolumeFlowControl1.vSetFreeCool, simpleERCBus.mfSetFreeCool)
    annotation (Line(points={{-15.89,49.5625},{-100.945,49.5625},{-100.945,0.05},
          {-99.95,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMixVflowConstValve3.Mflowset, simpleERCBus.mfSetLTC) annotation (
      Line(points={{-15.8,31.8},{-99.9,31.8},{-99.9,0.05},{-99.95,0.05}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMixVflowConstValve1.Mflowset, simpleERCBus.mfSetCold1) annotation (
     Line(points={{-15.8,3.8},{-100.9,3.8},{-100.9,0.05},{-99.95,0.05}}, color=
          {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrMixVflowConstValve2.Mflowset, simpleERCBus.mfSetCold2) annotation (
     Line(points={{-15.8,-20.2},{-99.9,-20.2},{-99.9,0.05},{-99.95,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrGTFSimpleFlowCtrl.mflow_gtf, simpleERCBus.mfSetGtf) annotation (
      Line(points={{-14.27,-55.9},{-100.135,-55.9},{-100.135,0.05},{-99.95,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrSWU_flow.mFlowHxGtf, simpleERCBus.mfSetGtfHx) annotation (Line(
        points={{-14,-80.14},{-100,-80.14},{-100,0.05},{-99.95,0.05}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrSWU_flow.mode, simpleERCBus.modeSwu) annotation (Line(points={{-14,
          -89.86},{-100,-89.86},{-100,0.05},{-99.95,0.05}}, color={255,127,0}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
end EON_ERC_simple_FlowControl;
