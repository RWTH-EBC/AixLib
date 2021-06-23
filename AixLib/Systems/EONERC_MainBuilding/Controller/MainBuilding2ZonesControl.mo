within AixLib.Systems.EONERC_MainBuilding.Controller;
model MainBuilding2ZonesControl "Mode based control for HP system, and GTF"
  import AixLib;
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
  AixLib.Systems.EONERC_MainBuilding.BaseClasses.MainBus2Zones bus annotation (
      Placement(transformation(extent={{86,-14},{114,12}}), iconTransformation(
          extent={{88,-20},{128,22}})));
  EONERC_MainBuilding.Controller.EonERCModeControl.CtrHP ctrHP(N_rel_min=0.3)
    annotation (Placement(transformation(extent={{-80,40},{-40,80}})));
  EONERC_MainBuilding.Controller.CtrSWU ctrSWU annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={30,-70})));
  AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl.modeStateSelector
    modeStateSelector
    annotation (Placement(transformation(extent={{-56,-22},{-12,20}})));
  EONERC_MainBuilding.Controller.CtrGTFSimple ctrGTFSimple
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Blocks.Math.BooleanToReal flapRecooler
    annotation (Placement(transformation(extent={{40,40},{56,56}})));
  Modelica.Blocks.Math.BooleanToReal flapFreeCooler
    annotation (Placement(transformation(extent={{40,20},{56,36}})));
  Modelica.Blocks.Math.BooleanToReal flapHP
    annotation (Placement(transformation(extent={{40,60},{56,76}})));
  Modelica.Blocks.Logical.Or gcOn annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={47,5})));
  EONERC_MainBuilding.Controller.CtrHXsimple ctrHXsimple(
    rpmPumpPrim=130,
    TflowSet=298.15,
    Ti(displayUnit="s") = 60)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  ModularAHU.Controller.CtrAHUTsetRoom ctrAHU1Basic(useExternalTset=false,
      VFlowSet=15500/3600)
    annotation (Placement(transformation(extent={{-60,-140},{-40,-120}})));
  CtrTabs ctrTabs2_1(useExternalTset=false, TflowSet=292.15)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  CtrHighTemperatureSystem ctrHighTemperatureSystem
    annotation (Placement(transformation(extent={{20,-120},{40,-100}})));
  Modelica.Blocks.Tables.CombiTable1D ccaHeatCurve(table=[270.15,303.15; 273.15,
        303.15; 278.15,298.15; 283.15,293.15; 293.15,291.15; 298.15,288.15;
        303.15,288.15])
    annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
  ModularAHU.Controller.CtrAHUTsetRoom ctrAHU1Basic1(VFlowSet=15500/3600)
    annotation (Placement(transformation(extent={{-60,-160},{-40,-140}})));
  CtrTabs ctrTabs2_2(useExternalTset=false, TflowSet=292.15)
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{40,80},{54,94}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{26,76},{34,84}})));
  Modelica.Blocks.Math.BooleanToReal flapHP1
    annotation (Placement(transformation(extent={{60,80},{74,94}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{4,64},{12,72}})));
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
  connect(booleanConstant.y, bus.hpSystemBus.busHP.modeSet) annotation (Line(points={{86.4,-4},
          {100.35,-4},{100.35,-0.935},{100.07,-0.935}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ice.y, bus.hpSystemBus.busHP.iceFacMea) annotation (Line(points={{86.4,
          -46},{100,-46},{100,-0.935},{100.07,-0.935}},
                                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.N_rel, bus.hpSystemBus.busHP.nSet) annotation (Line(points={{-38,60},
          {100.07,60},{100.07,-0.935}},
                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.T_HS, bus.hpSystemBus.TTopHSMea) annotation (Line(points={{-83.6,
          80},{-98,80},{-98,104},{100,104},{100,52},{100.07,52},{100.07,-0.935}},
                                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_con, bus.hpSystemBus.busHP.TConOutMea) annotation (Line(points={{-83.6,
          70},{-96,70},{-96,108},{100.07,108},{100.07,-0.935}},
                                                            color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_CS, bus.hpSystemBus.TBottomCSMea) annotation (Line(points={{-83.4,
          49.8},{-92,49.8},{-92,70},{-100,70},{-100,106},{100,106},{100,-0.935},
          {100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_ev, bus.hpSystemBus.busHP.TEvaOutMea) annotation (Line(points={{-83.6,
          40},{-98,40},{-98,108},{100.07,108},{100.07,-0.935}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.pumpsOn, bus.hpSystemBus.busPumpHot.pumpBus.onSet) annotation (Line(
        points={{-38,76},{100.07,76},{100.07,-0.935}},  color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.pumpsOn, bus.hpSystemBus.busPumpCold.pumpBus.onSet) annotation (Line(
        points={{-38,76},{100.07,76},{100.07,-0.935}},  color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeStateSelector.modeSWU, ctrSWU.mode) annotation (Line(points={{-9.8,
          -17.8},{4,-17.8},{4,-70},{20,-70}},
                                            color={255,127,0}));
  connect(modeStateSelector.useGTF, ctrGTFSimple.on) annotation (Line(points={{-9.8,
          -9.4},{10,-9.4},{10,-90.2},{19,-90.2}},
                                              color={255,0,255}));
  connect(modeStateSelector.useHP, ctrHP.allowOperation) annotation (Line(
        points={{-9.8,15.8},{14,15.8},{14,100},{-60,100},{-60,84}},       color=
         {255,0,255}));
  connect(modeStateSelector.reCoolingGC, flapRecooler.u) annotation (Line(
        points={{-9.8,7.4},{26,7.4},{26,48},{38.4,48}},
                                                      color={255,0,255}));
  connect(modeStateSelector.freeCoolingGC, flapFreeCooler.u) annotation (Line(
        points={{-9.8,-1},{30,-1},{30,28},{38.4,28}}, color={255,0,255}));
  connect(flapFreeCooler.y, bus.hpSystemBus.busThrottleFreecool.valveSet)
    annotation (Line(points={{56.8,28},{100,28},{100,24},{100.07,24},{100.07,
          -0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapRecooler.y, bus.hpSystemBus.busThrottleRecool.valveSet)
    annotation (Line(points={{56.8,48},{100,48},{100,-0.935},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapHP.y, bus.hpSystemBus.busThrottleCS.valveSet) annotation (Line(
        points={{56.8,68},{100,68},{100,32},{100.07,32},{100.07,-0.935}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gcOn.u1, flapRecooler.u) annotation (Line(points={{38.6,5},{36,5},{36,
          6},{26,6},{26,48},{38.4,48}}, color={255,0,255}));
  connect(gcOn.y, bus.hpSystemBus.AirCoolerOnSet) annotation (Line(points={{54.7,5},
          {100.07,5},{100.07,-0.935}},         color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeStateSelector.heatingMode, ctrHP.heatingModeActive) annotation (
      Line(points={{-34,22.1},{-100,22.1},{-100,60},{-83.6,60}},
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
  connect(ctrHP.On, modeStateSelector.hpOn) annotation (Line(points={{-38,68},{
          -20,68},{-20,38},{-76,38},{-76,-1},{-59.96,-1}}, color={255,0,255}));
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
  connect(modeStateSelector.freeCoolingGC, gcOn.u2) annotation (Line(points={{-9.8,-1},
          {18.1,-1},{18.1,-0.6},{38.6,-0.6}},          color={255,0,255}));
  connect(modeStateSelector.T_air, bus.hpSystemBus.TOutsideMea) annotation (
      Line(points={{-25.2,-25.78},{-25.2,-40},{-140,-40},{-140,-158},{100.07,
          -158},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));

  connect(ccaHeatCurve.u[1], modeStateSelector.T_air) annotation (Line(points={{-72,-80},
          {-78,-80},{-78,-40},{-25.2,-40},{-25.2,-25.78}},             color={0,
          0,127}));
  connect(ctrTabs2_2.tabsBus, bus.tabs2Bus) annotation (Line(
      points={{-20,-90},{0,-90},{0,-168},{100.07,-168},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrAHU1Basic.genericAHUBus, bus.ahu1Bus) annotation (Line(
      points={{-39.8,-130.1},{-20,-130.1},{-20,-184},{150,-184},{150,-0.935},{
          100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrAHU1Basic1.genericAHUBus, bus.ahu2Bus) annotation (Line(
      points={{-39.8,-150.1},{-26,-150.1},{-26,-150},{-10,-150},{-10,-192},{
          100.07,-192},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrAHU1Basic.T_act, bus.TRoom1Mea) annotation (Line(points={{-62,-130},
          {-118,-130},{-118,-192},{126,-192},{126,-0.935},{100.07,-0.935}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrAHU1Basic1.T_act, bus.TRoom2Mea) annotation (Line(points={{-62,
          -150},{-110,-150},{-110,-178},{100.07,-178},{100.07,-0.935}}, color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHighTemperatureSystem.highTemperatureSystemBus, bus.htsBus)
    annotation (Line(
      points={{40,-109.9},{100.07,-109.9},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabs2_1.tabsBus, bus.tabs1Bus) annotation (Line(
      points={{-20,-70},{-4,-70},{-4,-138},{100.07,-138},{100.07,-0.935}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(not1.y, and1.u2) annotation (Line(points={{34.4,80},{36,80},{36,81.4},
          {38.6,81.4}}, color={255,0,255}));
  connect(not1.u, flapRecooler.u) annotation (Line(points={{25.2,80},{25.2,48},
          {38.4,48}}, color={255,0,255}));
  connect(and1.y, flapHP1.u) annotation (Line(points={{54.7,87},{56.35,87},{
          56.35,87},{58.6,87}}, color={255,0,255}));
  connect(flapHP1.y, bus.hpSystemBus.busThrottleHS.valveSet) annotation (Line(
        points={{74.7,87},{100.07,87},{100.07,-0.935}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(and1.u1, ctrHP.On) annotation (Line(points={{38.6,87},{-10,87},{-10,
          68},{-38,68}}, color={255,0,255}));
  connect(flapHP.u, not2.y)
    annotation (Line(points={{38.4,68},{12.4,68}}, color={255,0,255}));
  connect(modeStateSelector.freeCoolingGC, not2.u) annotation (Line(points={{
          -9.8,-1},{-2,-1},{-2,68},{3.2,68}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -180},{100,100}}), graphics={Line(
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
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-180},{100,
            100}})));
end MainBuilding2ZonesControl;
