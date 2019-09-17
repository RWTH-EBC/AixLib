within AixLib.Systems.EONERC_MainBuilding;
model HeatPumpSystemValidation "Validation of HeatpumpSystem"
  extends Modelica.Icons.Example;
    package Medium = AixLib.Media.Water
    annotation (choicesAllMatching=true);
    DataHPSystem Data;

  Fluid.Sources.Boundary_pT          boundary(
    redeclare package Medium = Medium,
    nPorts=1,
    T=303.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-116,20})));
  Fluid.Sources.MassFlowSource_T        boundary5(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    m_flow=1,
    T=300.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-116,-30})));
  Fluid.Sources.Boundary_pT          boundary2(
    redeclare package Medium = Medium,
    T=285.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={100,-28})));
  Fluid.Sources.MassFlowSource_T        boundary3(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    m_flow=4,
    use_T_in=true,
    T=291.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={104,10})));
  HeatpumpSystem heatpumpSystem(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-80,-48},{60,16}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=Data.August2016,
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  HydraulicModules.BaseClasses.HydraulicBus bus_throttle_HS1 annotation (
      Placement(transformation(extent={{-66,30},{-46,50}}), iconTransformation(
          extent={{-44,28},{-24,48}})));
  Controls.Interfaces.HeatPumpControlBus bus_HP1 annotation (Placement(
        transformation(extent={{-16,28},{4,50}}), iconTransformation(extent={{-18,
            18},{2,40}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    annotation (Placement(transformation(extent={{-20,86},{-6,100}})));
  Modelica.Blocks.Sources.Constant const(k=51)
    annotation (Placement(transformation(extent={{-70,56},{-62,64}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-50,60},{-42,68}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{6,86},{20,100}})));
  Modelica.Blocks.Sources.Constant one(k=1)
    annotation (Placement(transformation(extent={{-54,86},{-40,100}})));
  HydraulicModules.BaseClasses.HydraulicBus bus_throttle_recool1
    annotation (Placement(transformation(extent={{-32,38},{-12,58}})));
  HydraulicModules.BaseClasses.HydraulicBus bus_throttle_freecool1 annotation (
      Placement(transformation(extent={{22,34},{42,54}}), iconTransformation(
          extent={{28,40},{48,60}})));
  HydraulicModules.BaseClasses.HydraulicBus bus_throttle_CS1
    annotation (Placement(transformation(extent={{46,36},{66,56}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{-152,-32},{-140,-20}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1 annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={132,36})));
  HydraulicModules.BaseClasses.HydraulicBus bus_pump_hot1
    annotation (Placement(transformation(extent={{-48,28},{-28,48}})));
  Modelica.Blocks.Sources.Constant pumpHotSet(k=3000)
    annotation (Placement(transformation(extent={{-88,32},{-74,46}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-106,40},{-96,50}})));
  HydraulicModules.BaseClasses.HydraulicBus bus_pump_cold1
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1 - combiTimeTable.y[
        20]/combiTimeTable.y[14])
    annotation (Placement(transformation(extent={{-40,-106},{-20,-86}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=combiTimeTable.y[20]
        /combiTimeTable.y[14])
    annotation (Placement(transformation(extent={{-88,-106},{-68,-86}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-58,-72})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-14,-72})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,-70})));
equation
  connect(boundary5.ports[1], heatpumpSystem.fluidportBottom1) annotation (Line(
        points={{-106,-30},{-80,-30},{-80,-19.5556}},          color={0,127,255}));
  connect(boundary.ports[1], heatpumpSystem.fluidportTop1) annotation (Line(
        points={{-106,20},{-80,20},{-80,-5.33333}},        color={0,127,255}));
  connect(heatpumpSystem.port_a1, boundary3.ports[1]) annotation (Line(points={{60,
          -5.33333},{64,-5.33333},{64,10},{94,10}},
                                               color={0,127,255}));
  connect(boundary2.ports[1], heatpumpSystem.port_b1) annotation (Line(points={{90,-28},
          {76,-28},{76,-19.5556},{60,-19.5556}},        color={0,127,255}));
  connect(combiTimeTable.y[23], boundary3.m_flow_in) annotation (Line(points={{-79,70},
          {14,70},{14,68},{146,68},{146,2},{116,2}},     color={0,0,127}));
  connect(boundary5.m_flow_in, combiTimeTable.y[19]) annotation (Line(points={{-128,
          -22},{-134,-22},{-134,0},{-148,0},{-148,70},{-79,70}}, color={0,0,127}));
  connect(const.y,division. u2)
    annotation (Line(points={{-61.6,60},{-50.8,60},{-50.8,61.6}},
                                                             color={0,0,127}));
  connect(combiTimeTable.y[29],division. u1) annotation (Line(points={{-79,70},{
          -52,70},{-52,66.4},{-50.8,66.4}},
                                        color={0,0,127}));
  connect(division.y, bus_HP1.N) annotation (Line(points={{-41.6,64},{-5.95,64},
          {-5.95,39.055}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, bus_HP1.mode) annotation (Line(points={{20.7,93},{26,
          93},{26,39.055},{-5.95,39.055}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(zero.y, bus_throttle_freecool1.valSet) annotation (Line(points={{-5.3,
          93},{-5.3,44.05},{32.05,44.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(one.y, bus_throttle_CS1.valSet) annotation (Line(points={{-39.3,93},{9.35,
          93},{9.35,46.05},{56.05,46.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(one.y, bus_HP1.iceFac) annotation (Line(points={{-39.3,93},{-5.95,93},
          {-5.95,39.055}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatpumpSystem.bus_throttle_HS, bus_throttle_HS1) annotation (Line(
      points={{-54.5455,16.7111},{-56,16.7111},{-56,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heatpumpSystem.bus_throttle_recool, bus_throttle_recool1) annotation (
     Line(
      points={{-22.0909,16.7111},{-22,16.7111},{-22,48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus_throttle_freecool1, heatpumpSystem.bus_throttle_freecool)
    annotation (Line(
      points={{32,44},{30,44},{30,16.7111},{28.1818,16.7111}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus_throttle_CS1, heatpumpSystem.bus_throttle_CS) annotation (Line(
      points={{56,46},{52,46},{52,16.7111},{47.2727,16.7111}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus_HP1, heatpumpSystem.bus_HP) annotation (Line(
      points={{-6,39},{-6,28.5},{-9.68182,28.5},{-9.68182,16.3556}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(toKelvin.Kelvin, boundary5.T_in)
    annotation (Line(points={{-139.4,-26},{-128,-26}}, color={0,0,127}));
  connect(toKelvin1.Kelvin, boundary3.T_in) annotation (Line(points={{132,29.4},
          {126,29.4},{126,6},{116,6}}, color={0,0,127}));
  connect(toKelvin1.Celsius, combiTimeTable.y[21]) annotation (Line(points={{
          132,43.2},{28,43.2},{28,70},{-79,70}}, color={0,0,127}));
  connect(toKelvin.Celsius, combiTimeTable.y[15]) annotation (Line(points={{
          -153.2,-26},{-160,-26},{-160,74},{-79,74},{-79,70}}, color={0,0,127}));
  connect(heatpumpSystem.bus_pump_hot, bus_pump_hot1) annotation (Line(
      points={{-36.0909,16.7111},{-36,16.7111},{-36,38},{-38,38}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pumpHotSet.y, bus_pump_hot1.pumpBus.rpm_Input) annotation (Line(
        points={{-73.3,39},{-46,39},{-46,38.05},{-37.95,38.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(division.y, greaterThreshold.u) annotation (Line(points={{-41.6,64},{
          -74,64},{-74,45},{-107,45}}, color={0,0,127}));
  connect(greaterThreshold.y, bus_pump_hot1.pumpBus.onOff_Input) annotation (
      Line(points={{-95.5,45},{-65.75,45},{-65.75,38.05},{-37.95,38.05}}, color=
         {255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatpumpSystem.bus_pump_cold, bus_pump_cold1) annotation (Line(
      points={{9.09091,16},{9.09091,24.6},{10,24.6},{10,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(pumpHotSet.y, bus_pump_cold1.pumpBus.rpm_Input) annotation (Line(
        points={{-73.3,39},{-33.65,39},{-33.65,30.05},{10.05,30.05}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold.y, bus_pump_cold1.pumpBus.onOff_Input) annotation (
      Line(points={{-95.5,45},{-42.75,45},{-42.75,30.05},{10.05,30.05}}, color=
          {255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realExpression1.y, limiter.u) annotation (Line(points={{-67,-96},{-62,
          -96},{-62,-84},{-58,-84}}, color={0,0,127}));
  connect(limiter.y, bus_throttle_HS1.valSet) annotation (Line(points={{-58,-61},
          {-58,-10},{-58,40.05},{-55.95,40.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(realExpression.y, limiter1.u) annotation (Line(points={{-19,-96},{-16,
          -96},{-16,-84},{-14,-84}}, color={0,0,127}));
  connect(limiter1.y, bus_throttle_recool1.valSet) annotation (Line(points={{
          -14,-61},{-18,-61},{-18,48.05},{-21.95,48.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(fixedTemperature.port, heatpumpSystem.fluid1) annotation (Line(points
        ={{20,-70},{12,-70},{12,-44.4444},{-10,-44.4444}}, color={191,0,0}));
  annotation (experiment(StopTime=7200));
end HeatPumpSystemValidation;
