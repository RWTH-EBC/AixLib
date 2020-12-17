within AixLib.Systems.EONERC_MainBuilding.Controller;
model HeatPumpSystemVolumeFlowControl
  "Constant intput connected with heatPUmpSystemBus"

  BaseClasses.HeatPumpSystemBus heatPumpSystemBus1 annotation (Placement(
        transformation(extent={{90,-10},{110,10}}),
                                                  iconTransformation(extent={{78,-22},
            {122,24}})));
  parameter Real rpmC=1750 "RPM for pump on cold side";
  Modelica.Blocks.Sources.Constant rpmPumpHot(k=rpmH)
    annotation (Placement(transformation(extent={{-38,52},{-24,66}})));
  parameter Real rpmH=2820 "RPM for pump hot side";
  Modelica.Blocks.Sources.Constant const(k=51)
    annotation (Placement(transformation(extent={{-54,134},{-46,142}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-18,148},{-6,160}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{20,142},{32,154}})));
  Modelica.Blocks.Sources.Constant ice(k=1)
    annotation (Placement(transformation(extent={{46,112},{60,126}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2
    annotation (Placement(transformation(extent={{32,-118},{46,-104}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr(
    useExternalVset=true,
    k=1000,
    Ti=30,
    Td=0) annotation (Placement(transformation(extent={{-62,-16},{-42,4}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr1(
    useExternalVset=true,
    k=1000,
    Ti=30,
    Td=0,
    rpm_pump=rpmC)
    annotation (Placement(transformation(extent={{-62,-42},{-42,-22}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{64,-130},{78,-116}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr2(
    useExternalVset=true,
    k=1000,
    Ti=30,
    Td=0) annotation (Placement(transformation(extent={{-62,-70},{-42,-50}})));
  HydraulicModules.Controller.CtrThrottleVflowCtr ctrThrottleVflowCtr3(
      useExternalVset=true)
    annotation (Placement(transformation(extent={{-64,-114},{-44,-94}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold3
    annotation (Placement(transformation(extent={{32,-140},{46,-126}})));
  Modelica.Blocks.Interfaces.RealInput vSetHS
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-110,60},{-90,80}}), iconTransformation(extent=
            {{-110,60},{-90,80}})));
  Modelica.Blocks.Interfaces.RealInput vSetCS
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-110,-48},{-90,-28}}), iconTransformation(
          extent={{-110,-48},{-90,-28}})));
  Modelica.Blocks.Interfaces.RealInput vSetRecool
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-110,-76},{-90,-56}}), iconTransformation(
          extent={{-110,-76},{-90,-56}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-84,-18},{-72,-6}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec1(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-84,-44},{-72,-32}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec2(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-84,-72},{-72,-60}})));
  Modelica.Blocks.Interfaces.RealInput vSetFreeCool
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-110,-120},{-90,-100}}), iconTransformation(
          extent={{-110,-120},{-90,-100}})));
  Modelica.Blocks.Math.Gain toCubicMetersPerSec3(k=0.001)
    "Converts Inputs from l/s to m³/s"
    annotation (Placement(transformation(extent={{-84,-116},{-72,-104}})));
  Modelica.Blocks.Logical.Or or2
    annotation (Placement(transformation(extent={{34,30},{48,44}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold4
    annotation (Placement(transformation(extent={{-4,24},{6,34}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold5
    annotation (Placement(transformation(extent={{-4,38},{6,48}})));
  Modelica.Blocks.Interfaces.RealInput pElHP "Connector of Real input signal 1"
    annotation (Placement(transformation(extent={{-110,100},{-88,122}}),
        iconTransformation(extent={{-110,100},{-88,122}})));
equation
  connect(rpmPumpHot.y, heatPumpSystemBus1.busPumpHot.pumpBus.rpmSet)
    annotation (Line(points={{-23.3,59},{100.05,59},{100.05,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(division.u2, const.y) annotation (Line(points={{-19.2,150.4},{-34,
          150.4},{-34,138},{-45.6,138}},
                                color={0,0,127}));
  connect(division.y, heatPumpSystemBus1.busHP.N) annotation (Line(points={{-5.4,
          154},{100.05,154},{100.05,0.05}},
                                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, heatPumpSystemBus1.busHP.mode) annotation (Line(
        points={{32.6,148},{98.35,148},{98.35,0.05},{100.05,0.05}},
                                                                color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ice.y, heatPumpSystemBus1.busHP.iceFac) annotation (Line(points={{60.7,
          119},{98.35,119},{98.35,0.05},{100.05,0.05}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr.hydraulicBus, heatPumpSystemBus1.busThrottleHS)
    annotation (Line(
      points={{-40.6,-5.8},{100.7,-5.8},{100.7,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(or1.y, heatPumpSystemBus1.AirCoolerOnSet) annotation (Line(points={{
          78.7,-123},{101.35,-123},{101.35,0.05},{100.05,0.05}}, color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr2.hydraulicBus, heatPumpSystemBus1.busThrottleRecool)
    annotation (Line(
      points={{-40.6,-59.8},{99.7,-59.8},{99.7,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr3.hydraulicBus, heatPumpSystemBus1.busThrottleFreecool)
    annotation (Line(
      points={{-42.6,-103.8},{-42.6,-88.9},{100.05,-88.9},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(greaterThreshold2.y, or1.u1) annotation (Line(points={{46.7,-111},{
          52.35,-111},{52.35,-123},{62.6,-123}}, color={255,0,255}));
  connect(greaterThreshold3.y, or1.u2) annotation (Line(points={{46.7,-133},{
          54.35,-133},{54.35,-128.6},{62.6,-128.6}}, color={255,0,255}));
  connect(ctrThrottleVflowCtr.Vact, heatPumpSystemBus1.busThrottleHS.VFlowInMea)
    annotation (Line(points={{-64,0},{-78,0},{-78,14},{100.05,14},{100.05,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr.Vset, toCubicMetersPerSec.y)
    annotation (Line(points={{-64,-12},{-71.4,-12}}, color={0,0,127}));
  connect(toCubicMetersPerSec.u, vSetHS) annotation (Line(points={{-85.2,-12},{
          -100,-12},{-100,70}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr1.Vset, toCubicMetersPerSec1.y)
    annotation (Line(points={{-64,-38},{-71.4,-38}}, color={0,0,127}));
  connect(toCubicMetersPerSec1.u, vSetCS)
    annotation (Line(points={{-85.2,-38},{-100,-38}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr2.Vset, toCubicMetersPerSec2.y)
    annotation (Line(points={{-64,-66},{-71.4,-66}}, color={0,0,127}));
  connect(toCubicMetersPerSec2.u, vSetRecool)
    annotation (Line(points={{-85.2,-66},{-100,-66}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr3.Vset, toCubicMetersPerSec3.y)
    annotation (Line(points={{-66,-110},{-71.4,-110}}, color={0,0,127}));
  connect(toCubicMetersPerSec3.u, vSetFreeCool)
    annotation (Line(points={{-85.2,-110},{-100,-110}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr2.Vact, heatPumpSystemBus1.busThrottleRecool.VFlowInMea)
    annotation (Line(points={{-64,-54},{-68,-54},{-68,-48},{99,-48},{99,0.05},{
          100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr3.Vact, heatPumpSystemBus1.busThrottleFreecool.VFlowInMea)
    annotation (Line(points={{-66,-98},{-100,-98},{-100,-86},{80,-86},{80,0},{
          100.05,0},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold4.y, or2.u2) annotation (Line(points={{6.5,29},{6.5,
          33.5},{32.6,33.5},{32.6,31.4}}, color={255,0,255}));
  connect(greaterThreshold5.y, or2.u1) annotation (Line(points={{6.5,43},{28,43},
          {28,38},{32.6,38},{32.6,37}}, color={255,0,255}));
  connect(division.u1, pElHP) annotation (Line(points={{-19.2,157.6},{-99,157.6},
          {-99,111}}, color={0,0,127}));
  connect(vSetFreeCool, greaterThreshold2.u) annotation (Line(points={{-100,
          -110},{-36,-110},{-36,-111},{30.6,-111}}, color={0,0,127}));
  connect(greaterThreshold3.u, vSetRecool) annotation (Line(points={{30.6,-133},
          {-31.7,-133},{-31.7,-66},{-100,-66}}, color={0,0,127}));
  connect(or2.y, heatPumpSystemBus1.busPumpHot.pumpBus.onSet) annotation (Line(
        points={{48.7,37},{74.35,37},{74.35,0.05},{100.05,0.05}}, color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold5.u, vSetHS) annotation (Line(points={{-5,43},{-50.5,
          43},{-50.5,70},{-100,70}}, color={0,0,127}));
  connect(greaterThreshold4.u, vSetRecool) annotation (Line(points={{-5,29},{-5,
          25.5},{-100,25.5},{-100,-66}}, color={0,0,127}));
  connect(ctrThrottleVflowCtr1.Vact, heatPumpSystemBus1.busPumpCold.VFlowInMea)
    annotation (Line(points={{-64,-26},{-74,-26},{-74,0.05},{100.05,0.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrThrottleVflowCtr1.hydraulicBus, heatPumpSystemBus1.busPumpCold)
    annotation (Line(
      points={{-40.6,-31.8},{99.7,-31.8},{99.7,0.05},{100.05,0.05}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -160},{100,160}}),                                  graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
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
