within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Dynamic_T_SUP_Control_Cooling "AHU T_Sup control"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";

  parameter Boolean dynamicSetTempControlAHU=false
    "Status of dynamic set Temperature control in AHU control depending on temperature in AHU after HRS";

  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Cool_Max = 5
    "max temperature difference of T_SUP for further cooling power";


  Modelica.Blocks.Interfaces.RealOutput Tset_AHU_Out(
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0)
    annotation (Placement(transformation(extent={{-100,-20},{-140,20}}),
        iconTransformation(extent={{-100,-20},{-140,20}})));
  Modelica.Blocks.Interfaces.RealInput Tset_AHU_In(
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0)
    annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=0,
        origin={100,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roomHeatPort[numZones]
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Cool(
    k=0.25,
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=2*60,
    Td=0.1) annotation (Placement(transformation(extent={{40,-40},{20,-60}})));
  Modelica.Blocks.Interfaces.RealInput TSetCool[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0)                                     annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={-30,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-40,-120})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-70,10},{-90,-10}})));
  Modelica.Blocks.Math.Add dTZoneCool[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{72,-60},{60,-48}})));
  Modelica.Blocks.Logical.Switch switchHysteresis
    annotation (Placement(transformation(extent={{30,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{-6,-18},{6,-6}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TZone[numZones]
    "Air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Math.MinMax minMax(nu=numZones)
    annotation (Placement(transformation(extent={{68,-40},{56,-28}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T(displayUnit="s") = 2*60)
    annotation (Placement(transformation(extent={{-8,2},{-20,14}})));
  Modelica.Blocks.Logical.Switch switchOnOff
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=
        dynamicSetTempControlAHU)
    annotation (Placement(transformation(extent={{20,20},{8,32}})));
  Modelica.Blocks.Math.Gain gain_dT_max(k=-dT_SUP_Cool_Max)
    annotation (Placement(transformation(extent={{0,-54},{-8,-46}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2(k=true)
    annotation (Placement(transformation(extent={{56,18},{44,30}})));
equation

  connect(Tset_AHU_In, add.u2) annotation (Line(points={{100,100},{-60,100},{-60,
          6},{-68,6}}, color={0,0,127}));
  connect(add.y, Tset_AHU_Out)
    annotation (Line(points={{-91,0},{-120,0}}, color={0,0,127}));
  connect(roomHeatPort, TZone.port)
    annotation (Line(points={{100,0},{80,0}}, color={191,0,0}));
  connect(const4.y, PI_AHU_Cool.u_s) annotation (Line(points={{59.4,-54},{52,-54},
          {52,-50},{42,-50}}, color={0,0,127}));
  connect(const6.y, switchHysteresis.u3) annotation (Line(points={{6.6,-12},{36,
          -12},{36,-8},{32,-8}}, color={0,0,127}));
  connect(dTZoneCool.y, minMax.u) annotation (Line(points={{79,-50},{78,-50},{78,
          -34},{68,-34}}, color={0,0,127}));
  connect(minMax.yMin, PI_AHU_Cool.u_m) annotation (Line(points={{55.4,-37.6},{
          48,-37.6},{48,-32},{30,-32},{30,-38}},
                                              color={0,0,127}));
  connect(TZone.T, dTZoneCool.u1) annotation (Line(points={{59,0},{50,0},{50,-22},
          {110,-22},{110,-44},{102,-44}}, color={0,0,127}));
  connect(TSetCool, dTZoneCool.u2) annotation (Line(points={{-30,-120},{-30,-96},
          {110,-96},{110,-56},{102,-56}}, color={0,0,127}));
  connect(const6.y, switchOnOff.u3) annotation (Line(points={{6.6,-12},{20,-12},
          {20,-22},{-20,-22},{-20,-8},{-28,-8}}, color={0,0,127}));
  connect(booleanConstant.y, switchOnOff.u2) annotation (Line(points={{7.4,26},
          {2,26},{2,-2},{-20,-2},{-20,0},{-28,0}}, color={255,0,255}));
  connect(firstOrder.y, switchOnOff.u1)
    annotation (Line(points={{-20.6,8},{-28,8}}, color={0,0,127}));
  connect(switchHysteresis.y, firstOrder.u)
    annotation (Line(points={{9,0},{-2,0},{-2,8},{-6.8,8}}, color={0,0,127}));
  connect(switchOnOff.y, add.u1) annotation (Line(points={{-51,0},{-60,0},{-60,
          -6},{-68,-6}}, color={0,0,127}));
  connect(PI_AHU_Cool.y, gain_dT_max.u)
    annotation (Line(points={{19,-50},{0.8,-50}}, color={0,0,127}));
  connect(gain_dT_max.y, switchHysteresis.u1) annotation (Line(points={{-8.4,
          -50},{-12,-50},{-12,-26},{44,-26},{44,8},{32,8}}, color={0,0,127}));
  connect(booleanConstant2.y, switchHysteresis.u2) annotation (Line(points={{
          43.4,24},{38,24},{38,0},{32,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

</html>"));
end Dynamic_T_SUP_Control_Cooling;
