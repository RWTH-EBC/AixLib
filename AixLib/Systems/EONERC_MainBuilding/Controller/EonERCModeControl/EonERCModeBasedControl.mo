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
  Modelica.Blocks.Math.Gain gain1(k=1/100)
    annotation (Placement(transformation(extent={{-2,46},{4,52}})));
  Modelica.Blocks.Math.Gain gain2(k=1/100)
    annotation (Placement(transformation(extent={{-2,34},{4,40}})));
  Modelica.Blocks.Math.Gain gain3(k=1/100)
    annotation (Placement(transformation(extent={{-2,24},{4,30}})));
  Modelica.Blocks.Math.Gain gain4(k=1/100)
    annotation (Placement(transformation(extent={{-2,14},{4,20}})));
  Modelica.Blocks.Sources.Constant ice(k=1)
    annotation (Placement(transformation(extent={{78,-52},{86,-44}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2
    annotation (Placement(transformation(extent={{20,-4},{34,10}})));
  Modelica.Blocks.Sources.Constant one(k=1)
    annotation (Placement(transformation(extent={{-176,88},{-162,102}})));
  Modelica.Blocks.Sources.Constant valveOpening(k=100)
    annotation (Placement(transformation(extent={{-56,40},{-42,54}})));
  Modelica.Blocks.Sources.Constant valveOpeningClosed(k=0)
    annotation (Placement(transformation(extent={{-56,16},{-42,30}})));
  Modelica.Blocks.Sources.Constant TcoldIn(k=17)
    annotation (Placement(transformation(extent={{-98,0},{-84,14}})));
  BaseClasses.HeatPumpSystemBus heatPumpSystemBus1 annotation (Placement(
        transformation(extent={{86,66},{114,92}}),iconTransformation(extent={{78,-22},
            {122,24}})));
  CtrHeatingCoolingMode ctrHeatingCoolingMode
    annotation (Placement(transformation(extent={{-140,100},{-100,140}})));
  CtrHP ctrHP annotation (Placement(transformation(extent={{0,100},{40,140}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{6,144},{14,152}})));
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
  connect(gain1.y,heatPumpSystemBus1. busThrottleHS.valSet) annotation (Line(
        points={{4.3,49},{100.07,49},{100.07,79.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain2.y,heatPumpSystemBus1. busThrottleCS.valSet) annotation (Line(
        points={{4.3,37},{100.07,37},{100.07,79.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain3.y,heatPumpSystemBus1. busThrottleFreecool.valSet) annotation (
      Line(points={{4.3,27},{100.07,27},{100.07,79.065}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain4.y,heatPumpSystemBus1. busThrottleRecool.valSet) annotation (
      Line(points={{4.3,17},{100.07,17},{100.07,79.065}}, color={0,0,127}),
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
  connect(gain4.u,greaterThreshold2. u) annotation (Line(points={{-2.6,17},{
          -4.3,17},{-4.3,3},{18.6,3}}, color={0,0,127}));
  connect(greaterThreshold2.y,heatPumpSystemBus1. AirCoolerOnSet) annotation (Line(
        points={{34.7,3},{100.07,3},{100.07,79.065}},   color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valveOpening.y,gain1. u) annotation (Line(points={{-41.3,47},{-2.6,47},
          {-2.6,49}},       color={0,0,127}));
  connect(valveOpening.y,gain2. u) annotation (Line(points={{-41.3,47},{-32,47},
          {-32,37},{-2.6,37}},        color={0,0,127}));
  connect(valveOpeningClosed.y,gain3. u) annotation (Line(points={{-41.3,23},{
          -19.65,23},{-19.65,27},{-2.6,27}},     color={0,0,127}));
  connect(valveOpeningClosed.y,gain4. u) annotation (Line(points={{-41.3,23},{
          -19.65,23},{-19.65,17},{-2.6,17}},     color={0,0,127}));
  connect(ctrHP.N_rel, heatPumpSystemBus1.busHP.N) annotation (Line(points={{42,
          120},{100.07,120},{100.07,79.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.On, heatPumpSystemBus1.busPumpHot.pumpBus.onOff_Input)
    annotation (Line(points={{42,128},{100.07,128},{100.07,79.065}}, color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.On, heatPumpSystemBus1.busPumpCold.pumpBus.onOff_Input)
    annotation (Line(points={{42,128},{100.07,128},{100.07,79.065}}, color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrHP.On, ctrHeatingCoolingMode.hp_on) annotation (Line(points={{42,
          128},{42,78},{-120,78},{-120,96}}, color={255,0,255}));
  connect(ctrHeatingCoolingMode.heatingActive, ctrHP.heatingModeActive)
    annotation (Line(points={{-98,128},{-52,128},{-52,120},{-3.6,120}}, color={
          255,0,255}));
  connect(ctrHeatingCoolingMode.T_HS[1], heatPumpSystemBus1.TTopHSMea)
    annotation (Line(points={{-144,130},{-148,130},{-148,158},{100,158},{100,
          118},{100.07,118},{100.07,79.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHeatingCoolingMode.T_HS[2], heatPumpSystemBus1.TBottomHSMea)
    annotation (Line(points={{-144,134},{-144,158},{100,158},{100,118},{100.07,
          118},{100.07,79.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHeatingCoolingMode.T_CS[1], heatPumpSystemBus1.TTopCSMea)
    annotation (Line(points={{-144,106},{-170,106},{-170,158},{100,158},{100,
          118},{100.07,118},{100.07,79.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctrHeatingCoolingMode.T_CS[2], heatPumpSystemBus1.TBottomCSMea)
    annotation (Line(points={{-144,110},{-170,110},{-170,158},{100,158},{100,
          118},{100.07,118},{100.07,79.065}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
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
  connect(booleanConstant1.y, ctrHP.allowOperation) annotation (Line(points={{
          14.4,148},{20,148},{20,146},{20,146},{20,144}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -100},{100,160}}),                                  graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-100,100},{98,2},{-100,-100}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{100,
            160}})));
end EonERCModeBasedControl;
