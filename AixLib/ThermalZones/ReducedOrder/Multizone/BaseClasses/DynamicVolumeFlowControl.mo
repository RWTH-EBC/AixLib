within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model DynamicVolumeFlowControl
  "V_flow control depending on indoor temperature"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones "Number of Zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roomHeatPort[numZones]
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput setAHU[numZones] annotation (Placement(transformation(extent={{-100,
            -20},{-140,20}}), iconTransformation(extent={{-100,-20},{-140,20}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Cool[numZones](
    k=0.1,
    yMax=0,
    yMin=-3,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    Td=0.1) annotation (Placement(transformation(extent={{40,-20},{20,-40}})));
  Modelica.Blocks.Math.Gain gainCool[numZones](k=-1)
    annotation (Placement(transformation(extent={{6,-36},{-6,-24}})));
  Modelica.Blocks.Math.Max max[numZones]
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Heat[numZones](
    k=0.1,
    yMax=3,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    Td=0.1) annotation (Placement(transformation(extent={{40,20},{20,40}})));
  Modelica.Blocks.Interfaces.RealInput TSetCool[numZones] annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={-30,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-40,-120})));
  Modelica.Blocks.Interfaces.RealInput TSetHeat[numZones] annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={50,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={40,-120})));
  Modelica.Blocks.Math.Gain gainHeat[numZones](k=1)
    annotation (Placement(transformation(extent={{6,24},{-6,36}})));
protected
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TAir[numZones]
    "Air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
equation
  connect(PI_AHU_Cool.y, gainCool.u)
    annotation (Line(points={{19,-30},{7.2,-30}}, color={0,0,127}));
  connect(gainCool.y, max.u2) annotation (Line(points={{-6.6,-30},{-12,-30},{-12,
          -6},{-18,-6}}, color={0,0,127}));
  connect(TAir.T, PI_AHU_Heat.u_m)
    annotation (Line(points={{59,0},{30,0},{30,18}}, color={0,0,127}));
  connect(TAir.T, PI_AHU_Cool.u_m)
    annotation (Line(points={{59,0},{30,0},{30,-18}}, color={0,0,127}));
  connect(TSetHeat, PI_AHU_Heat.u_s)
    annotation (Line(points={{50,-120},{50,30},{42,30}}, color={0,0,127}));
  connect(TSetCool, PI_AHU_Cool.u_s) annotation (Line(points={{-30,-120},{-30,-60},
          {46,-60},{46,-30},{42,-30}}, color={0,0,127}));
  connect(PI_AHU_Heat.y, gainHeat.u)
    annotation (Line(points={{19,30},{7.2,30}}, color={0,0,127}));
  connect(gainHeat.y, max.u1) annotation (Line(points={{-6.6,30},{-12,30},{-12,6},
          {-18,6}}, color={0,0,127}));
  connect(roomHeatPort, TAir.port)
    annotation (Line(points={{100,0},{80,0}}, color={191,0,0}));
  connect(max.y, setAHU)
    annotation (Line(points={{-41,0},{-120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DynamicVolumeFlowControl;
