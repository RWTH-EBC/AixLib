within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels;
model SimpleRoomWithControl
  extends RoomModels.SimpleRoom
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));

  ModularAHU.Controller.CtrAHUTsetRoom          ctrVentilationUnitTsetRoom(
    TRoomSet=303.15,
    k=0.3,
    Ti=200,
    VFlowSet=3*1800/3600)
    annotation (Placement(transformation(extent={{-98,100},{-78,120}})));
  Controller.CtrTabs                                     ctrTabs2_1(
      useExternalTset=false, TflowSet=303.15)
    annotation (Placement(transformation(extent={{-98,120},{-78,140}})));
equation
  connect(ctrTabs2_1.tabsBus, bus.tabs1Bus) annotation (Line(
      points={{-78,130},{0.09,130},{0.09,94.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thermalZone1.TAir, ctrVentilationUnitTsetRoom.T_act) annotation (Line(
        points={{58.5,63.4},{58.5,144},{-100,144},{-100,110}}, color={0,0,127}));
  connect(ctrVentilationUnitTsetRoom.genericAHUBus, bus.ahu1Bus) annotation (
      Line(
      points={{-77.8,109.9},{-41.9,109.9},{-41.9,94.11},{0.09,94.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (experiment(StopTime=31536000, Interval=3600));
end SimpleRoomWithControl;
