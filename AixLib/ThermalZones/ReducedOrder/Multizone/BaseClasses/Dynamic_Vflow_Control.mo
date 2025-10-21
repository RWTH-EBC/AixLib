within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Dynamic_Vflow_Control "AHU T_Sup control"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";

  parameter Boolean dynamicVolumeFlowControlAHU=false
    "Status of dynamic AHU control depending on room temperature";

  parameter Real gain_Vflow_Heat_Max = 2
    "max volume flow gain for further heating power";
  parameter Real gain_Vflow_Cool_Max = 2
    "max volume flow gain for further cooling power";

  Boolean OnOff[numZones];

  Modelica.Blocks.Interfaces.RealOutput Vflow_AHU_set[numZones] annotation (
      Placement(transformation(extent={{-100,-20},{-140,20}}),
        iconTransformation(extent={{-100,-20},{-140,20}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_AHU_In annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=0,
        origin={120,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roomHeatPort[numZones]
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Cool[numZones](
    k=0.25*gain_Vflow_Cool_Max,
    yMax=gain_Vflow_Cool_Max,
    yMin=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=2*60,
    Td=0.1) annotation (Placement(transformation(extent={{40,-40},{20,-60}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Heat[numZones](
    k=0.25*gain_Vflow_Heat_Max,
    yMax=gain_Vflow_Heat_Max,
    yMin=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    Td=0.1) annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Modelica.Blocks.Math.Gain gainHeat[numZones](k=1)
    annotation (Placement(transformation(extent={{12,44},{0,56}})));
  Modelica.Blocks.Logical.Switch switchCool[numZones] annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-30})));
  Modelica.Blocks.Logical.Switch switchHeat[numZones] annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-20,30})));
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
  Modelica.Blocks.Interfaces.RealInput TSetHeat[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0)                                     annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={30,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={40,-120})));
  Modelica.Blocks.Sources.Constant const[numZones](k=1)
    annotation (Placement(transformation(extent={{-48,-52},{-40,-44}})));
  Modelica.Blocks.Math.Add dTZoneHeat[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{100,40},{80,60}})));
  Modelica.Blocks.Math.Add dTZoneCool[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  Modelica.Blocks.Sources.Constant const1[numZones](k=0)
    annotation (Placement(transformation(extent={{72,48},{60,60}})));
  Modelica.Blocks.Sources.Constant const2[numZones](k=1)
    annotation (Placement(transformation(extent={{-52,44},{-40,56}})));
  Modelica.Blocks.Sources.Constant const4[numZones](k=0)
    annotation (Placement(transformation(extent={{72,-60},{60,-48}})));
  Modelica.Blocks.Logical.Switch switchOff[numZones]
    annotation (Placement(transformation(extent={{-18,-6},{-30,6}})));
  Modelica.Blocks.Sources.Constant const6[numZones](k=1)
    annotation (Placement(transformation(extent={{-48,-30},{-40,-22}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionOnOff[numZones](y=
        OnOff) annotation (Placement(transformation(extent={{2,-4},{-6,6}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TZone[numZones]
    "Air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{86,-8},{74,8}})));
  Modelica.Blocks.Math.Product product[numZones]
    annotation (Placement(transformation(extent={{-74,10},{-94,-10}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=numZones)
    annotation (Placement(transformation(extent={{-30,80},{-50,100}})));
  Modelica.Blocks.Logical.Switch switchHeatingCooling[numZones]
    annotation (Placement(transformation(extent={{20,-6},{8,6}})));
  Modelica.Blocks.Math.Add TSetAvg[numZones](k1=0.5, k2=0.5)
    annotation (Placement(transformation(extent={{80,-16},{68,-28}})));
  Utilities.Logical.DynamicHysteresis HysteresisHeatinCooling[numZones]
    annotation (Placement(transformation(extent={{56,10},{36,-10}})));
  Modelica.Blocks.Math.Add add[numZones](k1=+1, k2=+1)
    annotation (Placement(transformation(extent={{60,24},{56,28}})));
  Modelica.Blocks.Math.Add add1[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{60,16},{56,20}})));
  Modelica.Blocks.Sources.Constant const3[numZones](k=0.5)
    annotation (Placement(transformation(extent={{50,20},{54,24}})));
  Modelica.Blocks.Logical.Switch switchOnOff[numZones]
    annotation (Placement(transformation(extent={{-52,-12},{-64,0}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant[numZones](k=
        dynamicVolumeFlowControlAHU)
    annotation (Placement(transformation(extent={{-70,-34},{-58,-22}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder[numZones](T(displayUnit="s")
       = 2*60) annotation (Placement(transformation(extent={{-36,-4},{-44,4}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
                                                         [numZones](k=true)
    annotation (Placement(transformation(extent={{-40,-78},{-28,-66}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2
                                                         [numZones](k=true)
    annotation (Placement(transformation(extent={{-42,64},{-30,76}})));
equation

  for i in 1:numZones loop
    OnOff[i] = dynamicVolumeFlowControlAHU;
  end for;

  /*
    if hysteresisHeating[i].y and hysteresisCooling[i].y then
      OnOff[i] = false;
    else
      OnOff[i] = true;
    end if;
  end for;
  */
  connect(gainHeat.y,switchHeat.u1)
    annotation (Line(points={{-0.6,50},{-12,50},{-12,42}},
                                                  color={0,0,127}));
  connect(PI_AHU_Heat.y,gainHeat.u)
    annotation (Line(points={{19,50},{13.2,50}},color={0,0,127}));
  connect(const.y, switchCool.u3) annotation (Line(points={{-39.6,-48},{-28,-48},
          {-28,-42}},    color={0,0,127}));
  connect(roomHeatPort, TZone.port)
    annotation (Line(points={{100,0},{86,0}}, color={191,0,0}));
  connect(TZone.T, dTZoneHeat.u2) annotation (Line(points={{73.4,0},{68,0},{68,
          24},{110,24},{110,44},{102,44}},             color={0,0,127}));
  connect(TSetHeat, dTZoneHeat.u1) annotation (Line(points={{30,-120},{30,-98},{
          116,-98},{116,56},{102,56}},                   color={0,0,127}));
  connect(const1.y, PI_AHU_Heat.u_s) annotation (Line(points={{59.4,54},{52,54},
          {52,50},{42,50}}, color={0,0,127}));
  connect(const2.y, switchHeat.u3)
    annotation (Line(points={{-39.4,50},{-28,50},{-28,42}}, color={0,0,127}));
  connect(const4.y, PI_AHU_Cool.u_s) annotation (Line(points={{59.4,-54},{52,-54},
          {52,-50},{42,-50}}, color={0,0,127}));
  connect(const6.y, switchOff.u3)
    annotation (Line(points={{-39.6,-26},{-34,-26},{-34,-14},{-14,-14},{-14,-8},
          {-12,-8},{-12,-4.8},{-16.8,-4.8}},       color={0,0,127}));
  connect(booleanExpressionOnOff.y, switchOff.u2)
    annotation (Line(points={{-6.4,1},{-6.4,0},{-16.8,0}},
                                                 color={255,0,255}));
  connect(PI_AHU_Cool.y, switchCool.u1)
    annotation (Line(points={{19,-50},{-12,-50},{-12,-42}}, color={0,0,127}));
  connect(replicator.y, product.u2) annotation (Line(points={{-51,90},{-60,90},
          {-60,6},{-72,6}},   color={0,0,127}));
  connect(V_flow_AHU_In, replicator.u) annotation (Line(points={{120,100},{-20,100},
          {-20,90},{-28,90}}, color={0,0,127}));
  connect(dTZoneHeat.y, PI_AHU_Heat.u_m) annotation (Line(points={{79,50},{76,50},
          {76,32},{30,32},{30,38}}, color={0,0,127}));
  connect(dTZoneCool.y, PI_AHU_Cool.u_m) annotation (Line(points={{79,-50},{76,-50},
          {76,-32},{30,-32},{30,-38}}, color={0,0,127}));
  connect(switchHeatingCooling.y, switchOff.u1) annotation (Line(points={{7.4,0},
          {8,0},{8,6},{-12,6},{-12,4.8},{-16.8,4.8}},
                                    color={0,0,127}));
  connect(switchHeat.y, switchHeatingCooling.u1) annotation (Line(points={{-20,19},
          {-20,16},{20,16},{20,4.8},{21.2,4.8}},    color={0,0,127}));
  connect(switchCool.y, switchHeatingCooling.u3) annotation (Line(points={{-20,-19},
          {-20,-10},{16,-10},{16,-4},{18,-4},{18,-4.8},{21.2,-4.8}},
                                                                   color={0,0,127}));
  connect(TZone.T, dTZoneCool.u1) annotation (Line(points={{73.4,0},{68,0},{68,
          -12},{108,-12},{108,-44},{102,-44}},
                                          color={0,0,127}));
  connect(TSetCool, dTZoneCool.u2) annotation (Line(points={{-30,-120},{-30,-94},
          {110,-94},{110,-56},{102,-56}}, color={0,0,127}));
  connect(TSetHeat, TSetAvg.u2) annotation (Line(points={{30,-120},{30,-98},{116,
          -98},{116,-18},{82,-18},{82,-18.4},{81.2,-18.4}}, color={0,0,127}));
  connect(TSetCool, TSetAvg.u1) annotation (Line(points={{-30,-120},{-30,-94},{110,
          -94},{110,-26},{96,-26},{96,-25.6},{81.2,-25.6}}, color={0,0,127}));
  connect(const3.y, add.u2) annotation (Line(points={{54.2,22},{62,22},{62,24.8},
          {60.4,24.8}},           color={0,0,127}));
  connect(const3.y, add1.u1) annotation (Line(points={{54.2,22},{62,22},{62,19.2},
          {60.4,19.2}},       color={0,0,127}));
  connect(TZone.T, add1.u2) annotation (Line(points={{73.4,0},{68,0},{68,16.8},{
          60.4,16.8}},  color={0,0,127}));
  connect(TZone.T, add.u1) annotation (Line(points={{73.4,0},{68,0},{68,27.2},{60.4,
          27.2}},      color={0,0,127}));
  connect(HysteresisHeatinCooling.y, switchHeatingCooling.u2)
    annotation (Line(points={{35,0},{21.2,0}},
                                             color={255,0,255}));
  connect(TSetAvg.y, HysteresisHeatinCooling.u) annotation (Line(points={{67.4,-22},
          {60,-22},{60,0},{58,0}},      color={0,0,127}));
  connect(add1.y, HysteresisHeatinCooling.uLow)
    annotation (Line(points={{55.8,18},{51,18},{51,12}}, color={0,0,127}));
  connect(add.y, HysteresisHeatinCooling.uHigh)
    annotation (Line(points={{55.8,26},{43,26},{43,12}}, color={0,0,127}));
  connect(const6.y, switchOnOff.u3) annotation (Line(points={{-39.6,-26},{-34,-26},
          {-34,-10.8},{-50.8,-10.8}},      color={0,0,127}));
  connect(booleanConstant.y, switchOnOff.u2) annotation (Line(points={{-57.4,-28},
          {-58,-28},{-58,-16},{-46,-16},{-46,-6},{-50.8,-6}},
        color={255,0,255}));
  connect(switchOnOff.y, product.u1) annotation (Line(points={{-64.6,-6},{-72,-6}},
                         color={0,0,127}));
  connect(product.y, Vflow_AHU_set)
    annotation (Line(points={{-95,0},{-120,0}}, color={0,0,127}));
  connect(firstOrder.y, switchOnOff.u1) annotation (Line(points={{-44.4,0},{-44,
          -1.2},{-50.8,-1.2}}, color={0,0,127}));
  connect(switchOff.y, firstOrder.u)
    annotation (Line(points={{-30.6,0},{-35.2,0}}, color={0,0,127}));
  connect(booleanConstant1.y, switchCool.u2) annotation (Line(points={{-27.4,-72},
          {-20,-72},{-20,-42}}, color={255,0,255}));
  connect(booleanConstant2.y, switchHeat.u2) annotation (Line(points={{-29.4,70},
          {-20,70},{-20,42}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model that may dynamically control the volume flow per thermal zone through the air handling unit to support heating or cooling in thermal zones in the <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped\">AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped</a>.</p>
<p>Control paramaters need to be adjusted accordingly.</p>
</html>"));
end Dynamic_Vflow_Control;
