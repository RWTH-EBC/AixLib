within AixLib.Systems.Benchmark.Examples.RoomModels;
model SimpleRoomWithSetPointControl
  extends RoomModels.SimpleRoom
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));

  AixLib.Systems.ModularAHU.Controller.CtrVentilationUnitBasic
                                                ctrVentilationUnitBasic(
    useExternalTset=true,
    useExternalVset=false,
    k=0.3,
    Ti=200,
    VFlowSet=3*1800/3600)
    annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
  AixLib.Systems.Benchmark.Controller.CtrTabs2
           ctrTabs2_1(useExternalTset=true, TflowSet=295.15)
    annotation (Placement(transformation(extent={{-100,122},{-80,142}})));
  Modelica.Blocks.Interfaces.RealInput TsetCca
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-160,120},{-120,160}}), iconTransformation(
          extent={{-148,108},{-108,148}})));
  Modelica.Blocks.Interfaces.RealInput TsetFvu
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-160,80},{-120,120}}), iconTransformation(
          extent={{-158,82},{-118,122}})));
equation
  connect(ctrVentilationUnitBasic.genericAHUBus, bus.vu1Bus) annotation (Line(
      points={{-80,110.1},{-19.9,110.1},{-19.9,108.11},{-1.91,108.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabs2_1.tabsBus, bus.tabs1Bus) annotation (Line(
      points={{-80,132},{-1.91,132},{-1.91,108.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctrTabs2_1.Tset, TsetCca) annotation (Line(points={{-102,132},{-112,
          132},{-112,140},{-140,140}}, color={0,0,127}));
  connect(ctrVentilationUnitBasic.Tset, TsetFvu) annotation (Line(points={{-102,
          110},{-112,110},{-112,100},{-140,100}}, color={0,0,127}));
  annotation (experiment(StopTime=10));
end SimpleRoomWithSetPointControl;
