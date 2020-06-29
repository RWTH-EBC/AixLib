within AixLib.Systems.Benchmark_old.Controller;
model BenchmarkBaseControl
  "Mode based control for HP system, and GTF"
  parameter Real rpmC=1750 "RPM for pump on cold side";
  parameter Real rpmH=2820 "RPM for pump hot side";
  Modelica.Blocks.Sources.Constant rpmPumpCold(k=rpmC)
    annotation (Placement(transformation(extent={{78,-22},{86,-14}})));
  Modelica.Blocks.Sources.Constant rpmPumpHot(k=rpmH)
    annotation (Placement(transformation(extent={{78,-36},{86,-28}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{78,-8},{86,0}})));
  Modelica.Blocks.Sources.Constant ice(k=1)
    annotation (Placement(transformation(extent={{78,-50},{86,-42}})));
  BaseClasses.MainBus bus annotation (Placement(transformation(extent={{86,-14},
            {114,12}}), iconTransformation(extent={{88,-20},{128,22}})));
  EONERC_MainBuilding_old.Controller.EonERCModeControl.CtrHP ctrHP(N_rel_min=
        0.3) annotation (Placement(transformation(extent={{-80,46},{-40,86}})));
  EONERC_MainBuilding_old.Controller.CtrSWU ctrSWU annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={30,-70})));
  AixLib.Systems.EONERC_MainBuilding_old.Controller.EonERCModeControl.modeStateSelector
    modeStateSelector
    annotation (Placement(transformation(extent={{-56,-22},{-12,20}})));
  EONERC_MainBuilding_old.Controller.CtrGTFSimple ctrGTFSimple
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Blocks.Math.BooleanToReal flapRecooler
    annotation (Placement(transformation(extent={{46,40},{62,56}})));
  Modelica.Blocks.Math.BooleanToReal flapFreeCooler
    annotation (Placement(transformation(extent={{46,20},{62,36}})));
  Modelica.Blocks.Math.BooleanToReal flapHP
    annotation (Placement(transformation(extent={{46,60},{62,76}})));
  Modelica.Blocks.Logical.Or gcOn annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={53,5})));
  EONERC_MainBuilding_old.Controller.CtrHXsimple ctrHXsimple(
    rpmPumpPrim=130,
    TflowSet=298.15,
    Ti(displayUnit="s") = 60)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  ModularAHU_old.Controller.CtrAHUBasic ctrAHUBasic(
    TFlowSet=293.15,
    dpMax=2000,
    useTwoFanCont=true,
    VFlowSet=15500/3600,
    ctrRh(k=0.01))
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  ModularAHU_old.Controller.CtrVentilationUnitTsetRoom
    ctrVentilationUnitTsetRoom(VFlowSet=1800/3600)
    annotation (Placement(transformation(extent={{-116,-80},{-96,-60}})));
  ModularAHU_old.Controller.CtrVentilationUnitTsetRoom
    ctrVentilationUnitTsetRoom2(VFlowSet=2700*2/3600)
    annotation (Placement(transformation(extent={{-116,-100},{-96,-80}})));
  ModularAHU_old.Controller.CtrVentilationUnitTsetRoom
    ctrVentilationUnitTsetRoom3(VFlowSet=150/3600)
    annotation (Placement(transformation(extent={{-116,-120},{-96,-100}})));
  ModularAHU_old.Controller.CtrVentilationUnitTsetRoom
    ctrVentilationUnitTsetRoom4(VFlowSet=300/3600)
    annotation (Placement(transformation(extent={{-116,-140},{-96,-120}})));
  ModularAHU_old.Controller.CtrVentilationUnitTsetRoom
    ctrVentilationUnitTsetRoom1(VFlowSet=4050*2/3600)
    annotation (Placement(transformation(extent={{-116,-160},{-96,-140}})));
  CtrTabs2 ctrTabs2_1(useExternalTset=false, TflowSet=292.15)
    annotation (Placement(transformation(extent={{-36,-80},{-16,-60}})));
  CtrTabs2 ctrTabs2_2(useExternalTset=false, TflowSet=292.15)
    annotation (Placement(transformation(extent={{-36,-100},{-16,-80}})));
  CtrTabs2 ctrTabs2(useExternalTset=false, TflowSet=292.15)
    annotation (Placement(transformation(extent={{-36,-120},{-16,-100}})));
  CtrTabs2 ctrTabs2_4(useExternalTset=false, TflowSet=292.15)
    annotation (Placement(transformation(extent={{-36,-140},{-16,-120}})));
  CtrTabs2 ctrTabs2_3(useExternalTset=false, TflowSet=292.15)
    annotation (Placement(transformation(extent={{-36,-160},{-16,-140}})));
  CtrHTSSystem ctrHTSSystem(T_boi_set=273.15 + 65)
    annotation (Placement(transformation(extent={{20,-140},{40,-120}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[270.15,303.15; 273.15,
        303.15; 278.15,298.15; 283.15,293.15; 293.15,291.15; 298.15,288.15;
        303.15,288.15])
    annotation (Placement(transformation(extent={{-74,-120},{-54,-100}})));
equation
  connect(rpmPumpCold.y, bus.hpSystemBus.busPumpCold.pumpBus.rpmSet) annotation (Line(
        points={{86.4,-18},{100.07,-18},{100.07,-0.935}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumpHot.y, bus.hpSystemBus.busPumpHot.pumpBus.rpmSet) annotation (Line(
        points={{86.4,-32},{100.07,-32},{100.07,-0.935}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, bus.hpSystemBus.busHP.mode) annotation (Line(points={{86.4,-4},
          {100.35,-4},{100.35,-0.935},{100.07,-0.935}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ice.y, bus.hpSystemBus.busHP.iceFac) annotation (Line(points={{86.4,
          -46},{100,-46},{100,-0.935},{100.07,-0.935}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.N_rel, bus.hpSystemBus.busHP.N) annotation (Line(points={{-38,66},
          {100.07,66},{100.07,-0.935}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.T_HS, bus.hpSystemBus.TTopHSMea) annotation (Line(points={{-83.6,
          86},{-98,86},{-98,104},{100,104},{100,52},{100.07,52},{100.07,-0.935}},
                                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_con, bus.hpSystemBus.busHP.T_ret_co) annotation (Line(points={{-83.6,
          76},{-96,76},{-96,108},{100.07,108},{100.07,-0.935}},
                                                            color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_CS, bus.hpSystemBus.TBottomCSMea) annotation (Line(points={{-83.4,
          55.8},{-92,55.8},{-92,70},{-100,70},{-100,106},{100,106},{100,-0.935},
          {100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_ev, bus.hpSystemBus.busHP.T_ret_ev) annotation (Line(points={{-83.6,
          46},{-98,46},{-98,108},{100.07,108},{100.07,-0.935}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.pumpsOn, bus.hpSystemBus.busPumpHot.pumpBus.onSet) annotation (Line(
        points={{-38,82},{100.07,82},{100.07,-0.935}},  color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.pumpsOn, bus.hpSystemBus.busPumpCold.pumpBus.onSet) annotation (Line(
        points={{-38,82},{100.07,82},{100.07,-0.935}},  color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeStateSelector.modeSWU, ctrSWU.mode) annotation (Line(points={{-9.8,
          -17.8},{4,-17.8},{4,-70},{20,-70}},
                                            color={255,127,0}));
  connect(modeStateSelector.useGTF, ctrGTFSimple.on) annotation (Line(points={{-9.8,
          -9.4},{10,-9.4},{10,-90},{18,-90}}, color={255,0,255}));
  connect(modeStateSelector.useHP, ctrHP.allowOperation) annotation (Line(
        points={{-9.8,15.8},{14,15.8},{14,132},{-60,132},{-60,90}},       color=
         {255,0,255}));
  connect(modeStateSelector.reCoolingGC, flapRecooler.u) annotation (Line(
        points={{-9.8,7.4},{26,7.4},{26,48},{44.4,48}},
                                                      color={255,0,255}));
  connect(modeStateSelector.freeCoolingGC, flapFreeCooler.u) annotation (Line(
        points={{-9.8,-1},{30,-1},{30,28},{44.4,28}}, color={255,0,255}));
  connect(flapFreeCooler.y, bus.hpSystemBus.busThrottleFreecool.valveSet)
    annotation (Line(points={{62.8,28},{100,28},{100,24},{100.07,24},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapRecooler.y, bus.hpSystemBus.busThrottleRecool.valveSet)
    annotation (Line(points={{62.8,48},{100,48},{100,-0.935},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapHP.y, bus.hpSystemBus.busThrottleHS.valveSet) annotation (Line(
        points={{62.8,68},{100.07,68},{100.07,-0.935}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapHP.y, bus.hpSystemBus.busThrottleCS.valveSet) annotation (Line(
        points={{62.8,68},{100,68},{100,74},{100.07,74},{100.07,-0.935}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gcOn.u1, flapRecooler.u) annotation (Line(points={{44.6,5},{36,5},{36,
          6},{26,6},{26,48},{44.4,48}}, color={255,0,255}));
  connect(gcOn.y, bus.hpSystemBus.AirCoolerOnSet) annotation (Line(points={{
          60.7,5},{100.07,5},{100.07,-0.935}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeStateSelector.useHP, flapHP.u) annotation (Line(points={{-9.8,
          15.8},{14,15.8},{14,68},{44.4,68}},
                                      color={255,0,255}));
  connect(modeStateSelector.heatingMode, ctrHP.heatingModeActive) annotation (
      Line(points={{-34,22.1},{-100,22.1},{-100,66},{-83.6,66}},
        color={255,0,255}));
  connect(modeStateSelector.T_HS[1], bus.hpSystemBus.TTopHSMea) annotation (Line(points={{-59.96,
          9.71},{-96,9.71},{-96,106},{100,106},{100,-0.935},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(modeStateSelector.T_HS[2], bus.hpSystemBus.TBottomHSMea) annotation (Line(points={{-59.96,
          13.49},{-96,13.49},{-96,106},{100,106},{100,-0.935},{100.07,-0.935}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(modeStateSelector.T_CS[1], bus.hpSystemBus.TTopCSMea) annotation (Line(points={{-59.96,
          -15.49},{-98,-15.49},{-98,104},{100.07,104},{100.07,-0.935}},
                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(modeStateSelector.T_CS[2], bus.hpSystemBus.TBottomCSMea) annotation (Line(points={{-59.96,
          -11.71},{-82,-11.71},{-82,-12},{-98,-12},{-98,104},{100.07,104},{
          100.07,-0.935}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.On, modeStateSelector.hpOn) annotation (Line(points={{-38,74},{
          -20,74},{-20,38},{-76,38},{-76,-1},{-59.96,-1}}, color={255,0,255}));
  connect(ctrSWU.sWUBus, bus.swuBus) annotation (Line(
      points={{40,-70},{100.07,-70},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrGTFSimple.gtfBus, bus.gtfBus) annotation (Line(
      points={{41.3,-90},{100.07,-90},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeStateSelector.T_geo, bus.gtfBus.secBus.TRtrnInMea) annotation (
      Line(points={{-42.8,-25.78},{-42.8,-40},{-140,-40},{-140,-160},{100,-160},
          {100,-0.935},{100.07,-0.935}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHXsimple.hxBus, bus.hxBus) annotation (Line(
      points={{41.1,-49.9},{100.07,-49.9},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeStateSelector.freeCoolingGC, gcOn.u2) annotation (Line(points={{
          -9.8,-1},{18.1,-1},{18.1,-0.6},{44.6,-0.6}}, color={255,0,255}));
  connect(modeStateSelector.T_air, bus.hpSystemBus.TOutsideMea) annotation (
      Line(points={{-25.2,-25.78},{-25.2,-40},{-140,-40},{-140,-158},{100.07,
          -158},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrAHUBasic.genericAHUBus, bus.ahuBus) annotation (Line(
      points={{40,-109.9},{72,-109.9},{72,-110},{100.07,-110},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(ctrVentilationUnitTsetRoom.genericAHUBus, bus.vu1Bus) annotation (
      Line(
      points={{-95.8,-70.1},{-92,-70.1},{-92,-70},{-84,-70},{-84,-160},{100.07,
          -160},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrVentilationUnitTsetRoom2.genericAHUBus, bus.vu2Bus) annotation (
      Line(
      points={{-95.8,-90.1},{-94,-90.1},{-94,-90},{-84,-90},{-84,-158},{100.07,
          -158},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrVentilationUnitTsetRoom3.genericAHUBus, bus.vu3Bus) annotation (
      Line(
      points={{-95.8,-110.1},{-98,-110.1},{-98,-110},{-84,-110},{-84,-160},{
          100.07,-160},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrVentilationUnitTsetRoom4.genericAHUBus, bus.vu4Bus) annotation (
      Line(
      points={{-95.8,-130.1},{-95.8,-130},{-84,-130},{-84,-160},{100.07,-160},{
          100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrVentilationUnitTsetRoom1.genericAHUBus, bus.vu5Bus) annotation (
      Line(
      points={{-95.8,-150.1},{-94,-150.1},{-94,-150},{-84,-150},{-84,-160},{
          100.07,-160},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabs2_1.tabsBus, bus.tabs1Bus) annotation (Line(
      points={{-16,-70},{-8,-70},{-8,-158},{100.07,-158},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(ctrTabs2_2.tabsBus, bus.tabs2Bus) annotation (Line(
      points={{-16,-90},{-8,-90},{-8,-160},{100,-160},{100,-80},{100.07,-80},{
          100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabs2.tabsBus, bus.tabs3Bus) annotation (Line(
      points={{-16,-110},{-8,-110},{-8,-160},{100,-160},{100,-80},{100.07,-80},
          {100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabs2_4.tabsBus, bus.tabs4Bus) annotation (Line(
      points={{-16,-130},{-8,-130},{-8,-158},{100,-158},{100,-80},{100.07,-80},
          {100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabs2_3.tabsBus, bus.tabs5Bus) annotation (Line(
      points={{-16,-150},{-8,-150},{-8,-160},{100,-160},{100,-80},{100.07,-80},
          {100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHTSSystem.htsBus, bus.htsBus) annotation (Line(
      points={{40,-129.9},{76,-129.9},{76,-130},{100.07,-130},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(combiTable1D.u[1], modeStateSelector.T_air) annotation (Line(points={
          {-76,-110},{-80,-110},{-80,-50},{-25.2,-50},{-25.2,-25.78}}, color={0,
          0,127}));
  connect(ctrVentilationUnitTsetRoom.T_act, bus.TRoom1Mea) annotation (Line(
        points={{-118,-70},{-148,-70},{-148,-170},{100.07,-170},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrVentilationUnitTsetRoom2.T_act, bus.TRoom2Mea) annotation (Line(
        points={{-118,-90},{-164,-90},{-164,-178},{100.07,-178},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrVentilationUnitTsetRoom3.T_act, bus.TRoom3Mea) annotation (Line(
        points={{-118,-110},{-134,-110},{-134,-186},{100.07,-186},{100.07,
          -0.935}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrVentilationUnitTsetRoom4.T_act, bus.TRoom4Mea) annotation (Line(
        points={{-118,-130},{-132,-130},{-132,-132},{-152,-132},{-152,-192},{
          100.07,-192},{100.07,-0.935}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrVentilationUnitTsetRoom1.T_act, bus.TRoom5Mea) annotation (Line(
        points={{-118,-150},{-158,-150},{-158,-200},{100.07,-200},{100.07,
          -0.935}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
            -160},{100,100}}), graphics={Line(
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
          textString="Control")}),                               Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-160},{100,
            100}})));
end BenchmarkBaseControl;
