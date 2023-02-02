within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels;
model SimpleRoomWithControl
  extends RoomModels.SimpleRoom(thermalZone1(energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial))
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));

  ModularAHU.Controller.CtrAHUTsetRoom          ctrVentilationUnitTsetRoom(
    TRoomSet=298.15,
    k=0.3,
    Ti=200,
    VFlowSet=3*1800/3600)
    annotation (Placement(transformation(extent={{-100,120},{-80,140}})));
  TABS.Controller.CtrTabs                                ctrTabs2_1(
      useExternalTset=false, TflowSet=295.15)
    annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
  Modelica.Blocks.Nonlinear.Limiter limiterCCAHot(uMax=0, uMin=-100000)
    annotation (Placement(transformation(extent={{-122,-18},{-114,-10}})));
  Modelica.Blocks.Sources.RealExpression Q_flow_AHU(y=-(-2*(Tair - 273.15) +
        42.1)*1000)
    annotation (Placement(transformation(extent={{-142,-32},{-126,-16}})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_hot(y=-(-1.7*(Tair - 273.15)
         + 29.4)*1000)
    annotation (Placement(transformation(extent={{-142,-22},{-126,-6}})));
  Modelica.Blocks.Math.Add heatDemand(k1=-0.001*0.5, k2=-0.001*0.5)
    annotation (Placement(transformation(extent={{-108,-24},{-100,-16}})));
  Modelica.Blocks.Nonlinear.Limiter limiterAHU(uMax=0, uMin=-100000)
    annotation (Placement(transformation(extent={{-122,-28},{-114,-20}})));
  Modelica.Blocks.Nonlinear.Limiter limiterFVUCold(uMax=100000, uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-126,-48})));
  Modelica.Blocks.Sources.RealExpression Q_flow_FVU_cold(y=-(-1.2*(Tair -
        273.15) + 11.6)*1000)
                    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-108,-48})));
  Modelica.Blocks.Sources.RealExpression Q_flow_CCA_cold(y=-(-2.42*(Tair -
        273.15) + 52.6)*1000)
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-106,-58})));
  Modelica.Blocks.Math.Add coldDemand(k1=-0.001*0.5, k2=-0.001*0.5) annotation (
     Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-138,-54})));
  Modelica.Blocks.Nonlinear.Limiter limiterCCACold(uMax=100000, uMin=0)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-126,-58})));
  Modelica.Blocks.Interfaces.RealOutput Tair
    annotation (Placement(transformation(extent={{-152,22},{-132,42}}),
        iconTransformation(extent={{-64,-140},{-44,-120}})));
  Modelica.Blocks.Tables.CombiTable1Ds ccaHeatCurve(
                                                   table=[270.15,301.15; 273.15,
        301.15; 278.15,298.15; 283.15,295.15; 293.15,293.15; 298.15,291.15;
        303.15,291.15])
    annotation (Placement(transformation(extent={{-140,100},{-120,120}})));
equation
  connect(ctrTabs2_1.tabsBus, bus.tabs1Bus) annotation (Line(
      points={{-80,110},{0.09,110},{0.09,94.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thermalZone1.TAir, ctrVentilationUnitTsetRoom.T_act) annotation (Line(
        points={{58.5,63.4},{58.5,144},{-102,144},{-102,130}}, color={0,0,127}));
  connect(ctrVentilationUnitTsetRoom.genericAHUBus, bus.ahu1Bus) annotation (
      Line(
      points={{-79.8,129.9},{-40,129.9},{-40,130},{0,130},{0,94.11},{0.09,94.11}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Q_flow_CCA_hot.y,limiterCCAHot. u)
    annotation (Line(points={{-125.2,-14},{-122.8,-14}}, color={0,0,127}));
  connect(Q_flow_AHU.y,limiterAHU. u)
    annotation (Line(points={{-125.2,-24},{-122.8,-24}},
                                                       color={0,0,127}));
  connect(limiterAHU.y, heatDemand.u2) annotation (Line(points={{-113.6,-24},{
          -112,-24},{-112,-22.4},{-108.8,-22.4}}, color={0,0,127}));
  connect(limiterCCAHot.y, heatDemand.u1) annotation (Line(points={{-113.6,-14},
          {-110,-14},{-110,-17.6},{-108.8,-17.6}}, color={0,0,127}));
  connect(Q_flow_FVU_cold.y,limiterFVUCold. u)
    annotation (Line(points={{-116.8,-48},{-121.2,-48}},
                                                     color={0,0,127}));
  connect(coldDemand.u2, limiterFVUCold.y) annotation (Line(points={{-133.2,
          -51.6},{-133.2,-49.8},{-130.4,-49.8},{-130.4,-48}}, color={0,0,127}));
  connect(coldDemand.u1, limiterCCACold.y) annotation (Line(points={{-133.2,
          -56.4},{-132,-56.4},{-132,-58},{-130.4,-58}}, color={0,0,127}));
  connect(Q_flow_CCA_cold.y,limiterCCACold. u)
    annotation (Line(points={{-114.8,-58},{-121.2,-58}},
                                                     color={0,0,127}));
  connect(Tair, weaBus.TDryBul) annotation (Line(points={{-142,32},{-142,60},{
          -71,60}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ccaHeatCurve.u, Tair) annotation (Line(points={{-142,110},{-144,110},
          {-144,32},{-142,32}}, color={0,0,127}));
  annotation (experiment(StopTime=432000, Interval=3600.00288));
end SimpleRoomWithControl;
