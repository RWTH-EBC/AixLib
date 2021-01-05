within AixLib.Systems.EONERC_MainBuilding.Controller;
model HeatPumpSystemVolumeFlowControl
  "Constant intput connected with heatPUmpSystemBus"

  BaseClasses.HeatPumpSystemBus heatPumpSystemBus1 annotation (Placement(
        transformation(extent={{154,40},{174,60}}),
                                                  iconTransformation(extent={{78,-22},
            {122,24}})));
  parameter Real rpmC=1750 "RPM for pump on cold side";
  Modelica.Blocks.Sources.Constant rpmPumpHot(k=rpmH)
    annotation (Placement(transformation(extent={{28,140},{42,154}})));
  parameter Real rpmH=2820 "RPM for pump hot side";
  Modelica.Blocks.Sources.Constant const(k=51)
    annotation (Placement(transformation(extent={{10,184},{18,192}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{46,198},{58,210}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{84,180},{96,192}})));
  Modelica.Blocks.Sources.Constant ice(k=1)
    annotation (Placement(transformation(extent={{110,164},{124,178}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2
    annotation (Placement(transformation(extent={{38,-110},{52,-96}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr(
    useExternalVset=true,
    k=100,
    Ti=30,
    Td=0,
    rpm_pump=rpmH)
          annotation (Placement(transformation(extent={{2,86},{22,106}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{70,-122},{84,-108}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr2(
    useExternalVset=true,
    k=100,
    Ti=30,
    Td=0) annotation (Placement(transformation(extent={{0,-94},{20,-74}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr3(
      useExternalVset=true,
    k=100,
    Ti=30,
    Td=0)
    annotation (Placement(transformation(extent={{-2,-154},{18,-134}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold3
    annotation (Placement(transformation(extent={{38,-130},{52,-116}})));
  Modelica.Blocks.Interfaces.RealInput vSetHS
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-116,80},{-96,100}}),iconTransformation(extent={{-119,80},
            {-99,100}})));
  Modelica.Blocks.Interfaces.RealInput vSetCold
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-116,-40},{-96,-20}}), iconTransformation(
          extent={{-119,-40},{-99,-20}})));
  Modelica.Blocks.Interfaces.RealInput vSetRecool
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-116,-100},{-96,-80}}),iconTransformation(
          extent={{-119,-100},{-99,-80}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec1(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-46,-36},{-34,-24}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec2(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-46,-96},{-34,-84}})));
  Modelica.Blocks.Interfaces.RealInput vSetFreeCool
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-116,-160},{-96,-140}}), iconTransformation(
          extent={{-119,-160},{-99,-140}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec3(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-46,-156},{-34,-144}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{100,118},{114,132}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold4
    annotation (Placement(transformation(extent={{62,112},{72,122}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold5
    annotation (Placement(transformation(extent={{62,126},{72,136}})));
  Modelica.Blocks.Interfaces.RealInput pElHP "Connector of Real input signal 1"
    annotation (Placement(transformation(extent={{-119,139},{-97,161}}),
        iconTransformation(extent={{-119,139},{-97,161}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr4(
    useExternalVset=true,
    k=100,
    Ti=30,
    Td=0,
    rpm_pump=rpmH)
          annotation (Placement(transformation(extent={{2,26},{22,46}})));
  Modelica.Blocks.Interfaces.RealInput vSetCS
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-119,19},{-97,41}}), iconTransformation(extent=
            {{-119,19},{-97,41}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec4(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec5(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-46,84},{-34,96}})));
  HydraulicModules.Controller.CtrPumpVflowCtr ctrPumpVflowCtr(
    useExternalVset=true,
    k=150000,
    Ti=30,
    Td=0,
    rpm_pump=rpmC)
    annotation (Placement(transformation(extent={{4,-34},{24,-14}})));
equation
  connect(rpmPumpHot.y, heatPumpSystemBus1.busPumpHot.pumpBus.rpmSet)
    annotation (Line(points={{42.7,147},{164.05,147},{164.05,50.05}},
                                                                    color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(division.u2, const.y) annotation (Line(points={{44.8,200.4},{30,200.4},
          {30,188},{18.4,188}}, color={0,0,127}));
  connect(division.y, heatPumpSystemBus1.busHP.N) annotation (Line(points={{58.6,
          204},{164.05,204},{164.05,50.05}},
                                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, heatPumpSystemBus1.busHP.mode) annotation (Line(
        points={{96.6,186},{164.35,186},{164.35,50.05},{164.05,50.05}},
                                                                color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ice.y, heatPumpSystemBus1.busHP.iceFac) annotation (Line(points={{124.7,
          171},{144,171},{144,170},{164,170},{164,50.05},{164.05,50.05}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr.hydraulicBus, heatPumpSystemBus1.busThrottleHS)
    annotation (Line(
      points={{23.4,96.2},{164.7,96.2},{164.7,50.05},{164.05,50.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(or1.y, heatPumpSystemBus1.AirCoolerOnSet) annotation (Line(points={{84.7,
          -115},{124,-115},{124,-116},{164,-116},{164,50.05},{164.05,50.05}},
                                                                 color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr2.hydraulicBus, heatPumpSystemBus1.busThrottleRecool)
    annotation (Line(
      points={{21.4,-83.8},{92,-83.8},{92,-84},{164,-84},{164,50.05},{164.05,
          50.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr3.hydraulicBus, heatPumpSystemBus1.busThrottleFreecool)
    annotation (Line(
      points={{19.4,-143.8},{20,-143.8},{20,-144},{164.05,-144},{164.05,50.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(greaterThreshold2.y, or1.u1) annotation (Line(points={{52.7,-103},{
          58.35,-103},{58.35,-115},{68.6,-115}}, color={255,0,255}));
  connect(greaterThreshold3.y, or1.u2) annotation (Line(points={{52.7,-123},{
          60.35,-123},{60.35,-120.6},{68.6,-120.6}}, color={255,0,255}));
  connect(ctrThrottleVflowCtr.Vact, heatPumpSystemBus1.busThrottleHS.VFlowInMea)
    annotation (Line(points={{0,102},{-8,102},{-8,66},{164.05,66},{164.05,50.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(toCubicMetersPerSec1.u, vSetCold)
    annotation (Line(points={{-47.2,-30},{-106,-30}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr2.Vset, toCubicMetersPerSec2.y)
    annotation (Line(points={{-2,-90},{-33.4,-90}},  color={0,0,127}));
  connect(toCubicMetersPerSec2.u, vSetRecool)
    annotation (Line(points={{-47.2,-90},{-106,-90}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr3.Vset, toCubicMetersPerSec3.y)
    annotation (Line(points={{-4,-150},{-33.4,-150}},  color={0,0,127}));
  connect(toCubicMetersPerSec3.u, vSetFreeCool)
    annotation (Line(points={{-47.2,-150},{-106,-150}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr2.Vact, heatPumpSystemBus1.busThrottleRecool.VFlowInMea)
    annotation (Line(points={{-2,-78},{-14,-78},{-14,-58},{164,-58},{164,50.05},
          {164.05,50.05}},
                         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr3.Vact, heatPumpSystemBus1.busThrottleFreecool.VFlowInMea)
    annotation (Line(points={{-4,-138},{-80,-138},{-80,-54},{164,-54},{164,34},
          {164.05,34},{164.05,50.05}},
                                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold4.y, or2.u2) annotation (Line(points={{72.5,117},{
          72.5,116},{98.6,116},{98.6,119.4}},
                                          color={255,0,255}));
  connect(greaterThreshold5.y, or2.u1) annotation (Line(points={{72.5,131},{94,
          131},{94,126},{98.6,126},{98.6,125}},
                                        color={255,0,255}));
  connect(division.u1, pElHP) annotation (Line(points={{44.8,207.6},{-14,207.6},
          {-14,150},{-108,150}},
                      color={0,0,127}));
  connect(or2.y, heatPumpSystemBus1.busPumpHot.pumpBus.onSet) annotation (Line(
        points={{114.7,125},{164.35,125},{164.35,50.05},{164.05,50.05}},
                                                                  color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold4.u, vSetRecool) annotation (Line(points={{61,117},{
          61,114},{-88,114},{-88,-90},{-106,-90}},
                                         color={0,0,127}));
  connect(ctrThrottleVflowCtr4.hydraulicBus, heatPumpSystemBus1.busThrottleCS)
    annotation (Line(
      points={{23.4,36.2},{94,36.2},{94,36},{164,36},{164,50.05},{164.05,50.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(ctrThrottleVflowCtr4.Vact, heatPumpSystemBus1.busThrottleCS.VFlowInMea)
    annotation (Line(points={{0,42},{-8,42},{-8,50},{162,50},{162,50.05},{
          164.05,50.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold3.u, vSetFreeCool) annotation (Line(points={{36.6,
          -123},{-26,-123},{-26,-122},{-68,-122},{-68,-150},{-106,-150}}, color=
         {0,0,127}));
  connect(vSetRecool, greaterThreshold2.u) annotation (Line(points={{-106,-90},
          {-62,-90},{-62,-103},{36.6,-103}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr4.Vset, toCubicMetersPerSec4.y)
    annotation (Line(points={{0,30},{-33.4,30}}, color={0,0,127}));
  connect(toCubicMetersPerSec4.u, vSetCS)
    annotation (Line(points={{-47.2,30},{-108,30}}, color={0,0,127}));
  connect(toCubicMetersPerSec5.u, vSetHS)
    annotation (Line(points={{-47.2,90},{-106,90}}, color={0,0,127}));
  connect(toCubicMetersPerSec5.y, ctrThrottleVflowCtr.Vset)
    annotation (Line(points={{-33.4,90},{0,90}}, color={0,0,127}));
  connect(greaterThreshold5.u, vSetHS) annotation (Line(points={{61,131},{-74,
          131},{-74,90},{-106,90}}, color={0,0,127}));
  connect(ctrPumpVflowCtr.Vset, toCubicMetersPerSec1.y)
    annotation (Line(points={{2,-30},{-33.4,-30}}, color={0,0,127}));
  connect(ctrPumpVflowCtr.hydraulicBus, heatPumpSystemBus1.busPumpCold)
    annotation (Line(
      points={{25.4,-23.8},{163.7,-23.8},{163.7,50.05},{164.05,50.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrPumpVflowCtr.Vact, heatPumpSystemBus1.busPumpCold.VFlowInMea)
    annotation (Line(points={{2,-18},{-8,-18},{-8,0},{164,0},{164,50.05},{
          164.05,50.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -160},{100,160}}),                                  graphics={
          Rectangle(
          extent={{-100,160},{100,-160}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-100,100},{98,2},{-100,-100}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{100,
            160}})));
end HeatPumpSystemVolumeFlowControl;
