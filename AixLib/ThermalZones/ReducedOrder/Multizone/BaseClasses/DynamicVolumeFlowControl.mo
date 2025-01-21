within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model DynamicVolumeFlowControl
  "V_flow control depending on indoor temperature"
  extends Modelica.Blocks.Icons.Block;


  parameter Integer numZones "Number of Zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";
  parameter Boolean heatAHU
    "Status of heating of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean coolAHU
    "Status of cooling of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roomHeatPort[numZones]
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput setAHU[numZones] annotation (Placement(transformation(extent={{-100,
            -20},{-140,20}}), iconTransformation(extent={{-100,-20},{-140,20}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Cool[numZones](
    k=0.5,
    yMax=0,
    yMin=-5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    Td=0.1) annotation (Placement(transformation(extent={{40,-20},{20,-40}})));
  Modelica.Blocks.Math.Gain gainCool[numZones](k=-1)
    annotation (Placement(transformation(extent={{6,-36},{-6,-24}})));
  Modelica.Blocks.Math.Max max[numZones]
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Heat[numZones](
    k=0.5,
    yMax=5,
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
  Modelica.Blocks.Logical.Switch switchCool[numZones]
    annotation (Placement(transformation(extent={{-20,-48},{-40,-28}})));
  Modelica.Blocks.Interfaces.RealInput AHUProfile annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-120,-70}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-80})));
  Modelica.Blocks.Routing.Replicator replicator(nout=numZones)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Logical.Switch switchHeat[numZones]
    annotation (Placement(transformation(extent={{-20,48},{-40,28}})));
  Modelica.Blocks.Sources.BooleanExpression heatAHUExpression[numZones](y=
        heatAHU) annotation (Placement(transformation(extent={{20,54},{0,74}})));
  Modelica.Blocks.Sources.BooleanExpression coolAHUExpression1[numZones](y=
        coolAHU)
    annotation (Placement(transformation(extent={{20,-74},{0,-54}})));
protected
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TAir[numZones]
    "Air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
equation
  connect(PI_AHU_Cool.y, gainCool.u)
    annotation (Line(points={{19,-30},{7.2,-30}}, color={0,0,127}));
  connect(TAir.T, PI_AHU_Heat.u_m)
    annotation (Line(points={{59,0},{30,0},{30,18}}, color={0,0,127}));
  connect(TAir.T, PI_AHU_Cool.u_m)
    annotation (Line(points={{59,0},{30,0},{30,-18}}, color={0,0,127}));
  connect(TSetHeat, PI_AHU_Heat.u_s)
    annotation (Line(points={{50,-120},{50,30},{42,30}}, color={0,0,127}));
  connect(TSetCool, PI_AHU_Cool.u_s) annotation (Line(points={{-30,-120},{-30,-82},
          {46,-82},{46,-30},{42,-30}}, color={0,0,127}));
  connect(roomHeatPort, TAir.port)
    annotation (Line(points={{100,0},{80,0}}, color={191,0,0}));
  connect(gainCool.y, switchCool.u1)
    annotation (Line(points={{-6.6,-30},{-18,-30}}, color={0,0,127}));
  connect(AHUProfile, replicator.u)
    annotation (Line(points={{-120,-70},{-82,-70}}, color={0,0,127}));
  connect(replicator.y, switchCool.u3) annotation (Line(points={{-59,-70},{-10,-70},
          {-10,-46},{-18,-46}}, color={0,0,127}));
  connect(gainHeat.y, switchHeat.u1)
    annotation (Line(points={{-6.6,30},{-18,30}}, color={0,0,127}));
  connect(switchHeat.y, max.u1) annotation (Line(points={{-41,38},{-50,38},{-50,
          6},{-58,6}}, color={0,0,127}));
  connect(switchCool.y, max.u2) annotation (Line(points={{-41,-38},{-50,-38},{-50,
          -6},{-58,-6}}, color={0,0,127}));
  connect(replicator.y, switchHeat.u3) annotation (Line(points={{-59,-70},{-10,-70},
          {-10,46},{-18,46}}, color={0,0,127}));
  connect(heatAHUExpression.y, switchHeat.u2) annotation (Line(points={{-1,64},{
          -12,64},{-12,38},{-18,38}}, color={255,0,255}));
  connect(coolAHUExpression1.y, switchCool.u2) annotation (Line(points={{-1,-64},
          {-12,-64},{-12,-38},{-18,-38}}, color={255,0,255}));
  connect(max.y, setAHU)
    annotation (Line(points={{-81,0},{-120,0}}, color={0,0,127}));
  connect(PI_AHU_Heat.y, gainHeat.u)
    annotation (Line(points={{19,30},{7.2,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DynamicVolumeFlowControl;
