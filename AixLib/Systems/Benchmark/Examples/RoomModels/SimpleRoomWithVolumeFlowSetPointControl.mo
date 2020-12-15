within AixLib.Systems.Benchmark.Examples.RoomModels;
model SimpleRoomWithVolumeFlowSetPointControl
  extends RoomModels.SimpleRoom
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));

  Controller.CtrTabsVSet ctrTabsVSet
    annotation (Placement(transformation(extent={{-106,138},{-86,158}})));
  ModularAHU.Controller.CtrVentilationUnitVflowSet ctrVentilationUnitVflowSet(
      useExternalVset=true)
    annotation (Placement(transformation(extent={{-106,102},{-86,122}})));
  Modelica.Blocks.Interfaces.RealInput vFlowHotSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-171,142},{-153,160}})));
  Modelica.Blocks.Interfaces.RealInput vFlowColdSet
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-171,118},{-149,140}})));
  Modelica.Blocks.Interfaces.RealInput VsetCooler
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-171,102},{-153,120}})));
  Modelica.Blocks.Interfaces.RealInput VsetHeater
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-171,92},{-153,110}})));
  Modelica.Blocks.Interfaces.RealInput VFlowAir
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-173,72},{-149,96}})));
equation
  connect(ctrTabsVSet.tabsBus, bus.tabs1Bus) annotation (Line(
      points={{-86,148},{-40,148},{-40,108.11},{-1.91,108.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrVentilationUnitVflowSet.genericAHUBus, bus.vu1Bus) annotation (
      Line(
      points={{-86,112.1},{-48,112.1},{-48,108.11},{-1.91,108.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabsVSet.vFlowHotSet, vFlowHotSet) annotation (Line(points={{
          -106.3,150.7},{-162,150.7},{-162,151}}, color={0,0,127}));
  connect(ctrTabsVSet.vFlowColdSet, vFlowColdSet) annotation (Line(points={{
          -106,144.4},{-122,144.4},{-122,142},{-160,142},{-160,129}}, color={0,
          0,127}));
  connect(ctrVentilationUnitVflowSet.VsetCooler, VsetCooler) annotation (Line(
        points={{-106.2,120.6},{-127.1,120.6},{-127.1,111},{-162,111}}, color={
          0,0,127}));
  connect(ctrVentilationUnitVflowSet.VsetHeater, VsetHeater) annotation (Line(
        points={{-106.1,112.5},{-162,112.5},{-162,101}}, color={0,0,127}));
  connect(ctrVentilationUnitVflowSet.VFlowAir, VFlowAir) annotation (Line(
        points={{-106.8,105.6},{-161,105.6},{-161,84}}, color={0,0,127}));
  annotation (experiment(StopTime=10));
end SimpleRoomWithVolumeFlowSetPointControl;
