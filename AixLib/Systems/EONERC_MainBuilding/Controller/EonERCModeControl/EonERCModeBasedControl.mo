within AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl;
model EonERCModeBasedControl "Mode based control for HP system, and GTF"
  parameter Real rpmC=1750 "RPM for pump on cold side";
  parameter Real rpmH=2820 "RPM for pump hot side";
  Modelica.Blocks.Sources.Constant rpmPumpCold(k=rpmC)
    annotation (Placement(transformation(extent={{78,-24},{86,-16}})));
  Modelica.Blocks.Sources.Constant rpmPumpHot(k=rpmH)
    annotation (Placement(transformation(extent={{78,-38},{86,-30}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{78,-10},{86,-2}})));
  Modelica.Blocks.Sources.Constant ice(k=1)
    annotation (Placement(transformation(extent={{78,-52},{86,-44}})));
  Modelica.Blocks.Sources.Constant one(k=1)
    annotation (Placement(transformation(extent={{-176,88},{-162,102}})));
  Modelica.Blocks.Sources.Constant valveOpening(k=100)
    annotation (Placement(transformation(extent={{130,50},{144,64}})));
  Modelica.Blocks.Sources.Constant valveOpeningClosed(k=0)
    annotation (Placement(transformation(extent={{130,26},{144,40}})));
  Modelica.Blocks.Sources.Constant TcoldIn(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-114,-40},{-100,-26}})));
  BaseClasses.HeatPumpSystemBus heatPumpSystemBus1 annotation (Placement(
        transformation(extent={{86,66},{114,92}}),iconTransformation(extent={{80,100},
            {120,142}})));
  CtrHP ctrHP(N_rel_min=0.3)
              annotation (Placement(transformation(extent={{0,100},{40,140}})));
  CtrSWU            ctrSWU
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={8,-70})));
  BaseClasses.SwitchingUnitBus sWUBus annotation (Placement(transformation(
          extent={{90,-80},{110,-60}}), iconTransformation(extent={{84,18},{120,
            60}})));
  AixLib.Systems.EONERC_MainBuilding.Controller.EonERCModeControl.modeStateSelector
    modeStateSelector
    annotation (Placement(transformation(extent={{-150,8},{-106,50}})));
  CtrGTFSimple            ctrGTFSimple
    annotation (Placement(transformation(extent={{-4,-116},{16,-96}})));
  HydraulicModules.BaseClasses.HydraulicBus busThrottle
    "Hydraulic bus Throttle" annotation (Placement(transformation(extent={{86,-110},
            {106,-90}}), iconTransformation(extent={{82,-42},{120,-2}})));
  HydraulicModules.BaseClasses.HydraulicBus busPump "Hydraulic bus Throttle"
    annotation (Placement(transformation(extent={{86,-126},{106,-106}}),
        iconTransformation(extent={{82,-102},{120,-62}})));
  Modelica.Blocks.Math.BooleanToReal flapRecooler
    annotation (Placement(transformation(extent={{0,24},{20,44}})));
  Modelica.Blocks.Math.BooleanToReal flapFreeCooler
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Math.BooleanToReal flapHP
    annotation (Placement(transformation(extent={{0,52},{20,72}})));
  Modelica.Blocks.Logical.Or securityOn annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={7,-15})));
equation
  connect(rpmPumpCold.y,heatPumpSystemBus1. busPumpCold.pumpBus.rpm_Input)
    annotation (Line(points={{86.4,-20},{100.07,-20},{100.07,79.065}},
                                                                    color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumpHot.y,heatPumpSystemBus1. busPumpHot.pumpBus.rpm_Input)
    annotation (Line(points={{86.4,-34},{100.07,-34},{100.07,79.065}},
                                                                    color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y,heatPumpSystemBus1. busHP.mode) annotation (Line(
        points={{86.4,-6},{100.35,-6},{100.35,79.065},{100.07,79.065}},
                                                                color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ice.y,heatPumpSystemBus1. busHP.iceFac) annotation (Line(points={{86.4,
          -48},{100,-48},{100,79.065},{100.07,79.065}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.N_rel, heatPumpSystemBus1.busHP.N) annotation (Line(points={{42,
          120},{100.07,120},{100.07,79.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.T_HS, heatPumpSystemBus1.TTopHSMea) annotation (Line(points={{
          -3.6,140},{-46,140},{-46,158},{100.07,158},{100.07,79.065}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_con, heatPumpSystemBus1.busHP.T_ret_co) annotation (Line(
        points={{-3.6,130},{-46,130},{-46,158},{100.07,158},{100.07,79.065}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_CS, heatPumpSystemBus1.TBottomCSMea) annotation (Line(points=
          {{-3.4,109.8},{-46,109.8},{-46,158},{100,158},{100,80},{100.07,80},{
          100.07,79.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.T_ev, heatPumpSystemBus1.busHP.T_ret_ev) annotation (Line(
        points={{-3.6,100},{-46,100},{-46,158},{100.07,158},{100.07,79.065}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.pumpsOn, heatPumpSystemBus1.busPumpHot.pumpBus.onOff_Input)
    annotation (Line(points={{42,136},{100.07,136},{100.07,79.065}}, color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.pumpsOn, heatPumpSystemBus1.busPumpCold.pumpBus.onOff_Input)
    annotation (Line(points={{42,136},{100.07,136},{100.07,79.065}}, color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrSWU.sWUBus, sWUBus) annotation (Line(
      points={{18,-70},{100,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(TcoldIn.y, modeStateSelector.T_air) annotation (Line(points={{-99.3,
          -33},{-119.2,-33},{-119.2,4.22}},
                                  color={0,0,127}));
  connect(modeStateSelector.modeSWU, ctrSWU.mode) annotation (Line(points={{-103.8,
          12.2},{-82,12.2},{-82,-70},{-2,-70}},
                                            color={255,127,0}));
  connect(ctrGTFSimple.busThrottle, busThrottle) annotation (Line(
      points={{16.1,-101.6},{56.05,-101.6},{56.05,-100},{96,-100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrGTFSimple.busPump, busPump) annotation (Line(
      points={{16.3,-110.4},{96,-110.4},{96,-116}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeStateSelector.useGTF, ctrGTFSimple.on) annotation (Line(points={{-103.8,
          20.6},{-90,20.6},{-90,-106},{-4,-106}},
                                              color={255,0,255}));
  connect(modeStateSelector.useHP, ctrHP.allowOperation) annotation (Line(
        points={{-103.8,45.8},{-82,45.8},{-82,152},{18,152},{18,144},{20,144}},
                                                                          color=
         {255,0,255}));
  connect(modeStateSelector.reCoolingGC, flapRecooler.u) annotation (Line(
        points={{-103.8,37.4},{-54,37.4},{-54,34},{-2,34}},
                                                      color={255,0,255}));
  connect(modeStateSelector.freeCoolingGC, flapFreeCooler.u) annotation (Line(
        points={{-103.8,29},{-68,29},{-68,10},{-2,10}},
                                                      color={255,0,255}));
  connect(flapFreeCooler.y, heatPumpSystemBus1.busThrottleFreecool.valSet)
    annotation (Line(points={{21,10},{68,10},{68,6},{100.07,6},{100.07,79.065}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapRecooler.y, heatPumpSystemBus1.busThrottleRecool.valSet)
    annotation (Line(points={{21,34},{100,34},{100,79.065},{100.07,79.065}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapHP.y, heatPumpSystemBus1.busThrottleHS.valSet) annotation (Line(
        points={{21,62},{56,62},{56,60},{100.07,60},{100.07,79.065}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flapHP.y, heatPumpSystemBus1.busThrottleCS.valSet) annotation (Line(
        points={{21,62},{64,62},{64,56},{100.07,56},{100.07,79.065}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeStateSelector.freeCoolingGC, securityOn.u2) annotation (Line(
        points={{-103.8,29},{-68,29},{-68,-20},{-50,-20},{-50,-20.6},{-1.4,
          -20.6}},
        color={255,0,255}));
  connect(securityOn.u1, flapRecooler.u) annotation (Line(points={{-1.4,-15},{-28,
          -15},{-28,-16},{-54,-16},{-54,34},{-2,34}}, color={255,0,255}));
  connect(securityOn.y, heatPumpSystemBus1.AirCoolerOnSet) annotation (Line(
        points={{14.7,-15},{100.07,-15},{100.07,79.065}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modeStateSelector.useHP, flapHP.u) annotation (Line(points={{-103.8,
          45.8},{-40,45.8},{-40,62},{-2,62}},
                                      color={255,0,255}));
  connect(modeStateSelector.heatingMode, ctrHP.heatingModeActive) annotation (
      Line(points={{-128,52.1},{-114,52.1},{-114,70},{-62,70},{-62,120},{-3.6,
          120}},
        color={255,0,255}));
  connect(modeStateSelector.T_HS[1], heatPumpSystemBus1.TTopHSMea) annotation (
      Line(points={{-153.96,39.71},{-128,39.71},{-128,162},{124,162},{124,
          79.065},{100.07,79.065}},
                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(modeStateSelector.T_HS[2], heatPumpSystemBus1.TBottomHSMea)
    annotation (Line(points={{-153.96,43.49},{-134,43.49},{-134,62},{-140,62},{
          -140,156},{116,156},{116,79.065},{100.07,79.065}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(modeStateSelector.T_CS[1], heatPumpSystemBus1.TTopCSMea) annotation (
      Line(points={{-153.96,14.51},{-146,14.51},{-146,38},{-182,38},{-182,152},
          {100.07,152},{100.07,79.065}},
                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(modeStateSelector.T_CS[2], heatPumpSystemBus1.TBottomCSMea)
    annotation (Line(points={{-153.96,18.29},{-164,18.29},{-164,44},{-192,44},{
          -192,152},{100.07,152},{100.07,79.065}},
                                              color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHP.On, modeStateSelector.hpOn) annotation (Line(points={{42,128},{
          56,128},{56,102},{-154,102},{-154,29},{-153.96,29}},
                                                           color={255,0,255}));
  connect(modeStateSelector.T_geo, busThrottle.TRtrn_in) annotation (Line(
        points={{-136.8,4.22},{-136.8,-99.95},{96.05,-99.95}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -100},{100,160}}),                                  graphics={
          Rectangle(
          extent={{-180,160},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-180,160},{100,40},{-100,-100}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{100,
            160}})));
end EonERCModeBasedControl;
