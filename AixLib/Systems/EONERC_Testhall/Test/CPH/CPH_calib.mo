within AixLib.Systems.EONERC_Testhall.BaseClasses.CPH;
model CPH_calib

    replaceable package MediumWater =
      AixLib.Media.Water
    "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);
  Modelica.Units.SI.VolumeFlowRate VolFlowBypass=(hydraulicBus.VFlowOutMea*
      hydraulicBus.TFwrdOutMea - hydraulicBus.VFlowInMea*hydraulicBus.TFwrdInMea)
      /hydraulicBus.TRtrnInMea
    "Volumenstrom des Bypass nach der Richmannschen Mischungsregel für inkompressible Fluide";
  Real meaError(unit="") = ((hydraulicBus.VFlowOutMea-combiTimeTable.y[9])/combiTimeTable.y[9])*100 "Prozentuale Abweichung des Modelergebnis zum Sensorwert";
  Real modmeaError(unit="") = abs(meaError);
  AixLib.Fluid.Sources.Boundary_ph RetPrim(
    redeclare package Medium = AixLib.Media.Water,
    p=100000,
    nPorts=1) "fCPHTempRetPrimADS "
    annotation (Placement(transformation(extent={{66,-188},{46,-168}})));
  AixLib.Fluid.Sources.Boundary_pT SupPrim(
    redeclare package Medium = AixLib.Media.Water,
    p=113000,
    use_T_in=true,
    nPorts=1) "fCPHTempSupPrimADS "
    annotation (Placement(transformation(extent={{-80,-186},{-60,-166}})));
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-94,-110},{-74,-90}}),
        iconTransformation(extent={{0,0},{0,0}})));
  AixLib.Systems.HydraulicModules.Injection2WayValve cph_Valve(redeclare
      package Medium =
        MediumWater,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    Kv=12,
    m_flow_nominal=2.3,
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    pipe1(length=0.4),
    pipe2(length=0.1),
    pipe3(length=1),
    pipe5(length=0.15),
    pipe4(length=1),
    pipe6(length=0.15),
    pipe7(length=0.3),
    T_amb=273.15 + 10,
    T_start=343.15) annotation (Placement(transformation(
        extent={{-50,-50},{49.9999,49.9999}},
        rotation=90,
        origin={-4,-94})));

  AixLib.Systems.HydraulicModules.Throttle cph_Throttle(
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    Kv=8,
    m_flow_nominal=2.3,
    redeclare package Medium = MediumWater,
    pipe1(length=1),
    pipe2(length=30, fac=13),
    pipe3(length=30),
    T_amb=273.15 + 10,
    T_start=343.15) annotation (Placement(transformation(
        extent={{-31,-31},{31,31}},
        rotation=90,
        origin={-7,3})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-112,-86},{-92,-66}})));
  Components.RadiantCeilingPanelHeater radiantCeilingPanelHeater(
    genericPipe(diameter=0.020, length=17.2),
    redeclare package Medium = MediumWater,
    nNodes=3,
    each Gr=27)
    annotation (Placement(transformation(extent={{-34,38},{22,100}})));

  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="measurement",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns=2:9)  "1-TempOut, 2-TempRet, 3-TempRetPrim, 4-TempSup, 5-TempSupPrim, 6-PumpSpeed,7-VolFlow, 8-ValveSet"
    annotation (Placement(transformation(extent={{-158,-110},{-138,-90}})));
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus1
    annotation (Placement(transformation(extent={{-86,-8},{-66,12}}),
        iconTransformation(extent={{0,0},{0,0}})));
equation
  connect(hydraulicBus, cph_Valve.hydraulicBus) annotation (Line(
      points={{-84,-100},{-68,-100},{-68,-94.0001},{-53.9999,-94.0001}},
      color={255,204,51},
      thickness=0.5));
  connect(cph_Valve.port_b2, RetPrim.ports[1]) annotation (Line(points={{26,-144},
          {26,-178},{46,-178}},       color={0,127,255}));
  connect(cph_Throttle.port_a1, cph_Valve.port_b1) annotation (Line(points={{-25.6,
          -28},{-32,-28},{-32,-44.0001},{-33.9999,-44.0001}},       color={0,
          127,255}));
  connect(cph_Throttle.port_b2, cph_Valve.port_a2) annotation (Line(points={{11.6,
          -28},{20,-28},{20,-44.0001},{26,-44.0001}},      color={0,127,255}));
  connect(SupPrim.ports[1], cph_Valve.port_a1) annotation (Line(points={{-60,
          -176},{-34,-176},{-34,-144},{-33.9999,-144}}, color={0,127,255}));
  connect(booleanExpression.y, hydraulicBus.pumpBus.onSet) annotation (Line(
        points={{-91,-76},{-83.95,-76},{-83.95,-99.95}},            color={255,
          0,255}));
  connect(cph_Throttle.port_b1, radiantCeilingPanelHeater.radiantcph_sup)
    annotation (Line(points={{-25.6,34},{-26,34},{-26,69},{-34,69}}, color={0,
          127,255}));
  connect(cph_Throttle.port_a2, radiantCeilingPanelHeater.radiantcph_ret)
    annotation (Line(points={{11.6,34},{16,34},{16,69},{22,69}}, color={0,127,
          255}));
  connect(combiTimeTable.y[6], hydraulicBus.pumpBus.rpmSet) annotation (Line(
        points={{-137,-100},{-110,-100},{-110,-99.95},{-83.95,-99.95}}, color={
          0,0,127}));
  connect(combiTimeTable.y[8], hydraulicBus.valveSet) annotation (Line(points={
          {-137,-100},{-110,-100},{-110,-99.95},{-83.95,-99.95}}, color={0,0,
          127}));
  connect(combiTimeTable.y[5], SupPrim.T_in) annotation (Line(points={{-137,
          -100},{-98,-100},{-98,-172},{-82,-172}}, color={0,0,127}));
  connect(cph_Throttle.hydraulicBus, hydraulicBus1) annotation (Line(
      points={{-38,3},{-38,2},{-76,2}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -200},{100,80}}), graphics={
        Rectangle(
          extent={{-160,82},{102,-200}},
          lineColor={0,0,0},
          fillColor={212,212,212},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-94,-76},{36,-108}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-68,-110},{-68,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-48,-110},{-48,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-28,-110},{-28,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{-8,-110},{-8,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{12,-110},{12,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{32,-110},{32,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Text(
          extent={{-80,32},{18,-48}},
          textColor={0,0,0},
          textString="CPH"),
        Line(
          points={{-90,-110},{-90,-130}},
          color={255,128,0},
          pattern=LinePattern.Dash,
          thickness=1)}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-200},{100,80}})),
    experiment(StopTime=7200, __Dymola_Algorithm="Dassl"));
end CPH_calib;
