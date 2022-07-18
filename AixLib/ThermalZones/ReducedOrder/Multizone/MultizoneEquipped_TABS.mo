within AixLib.ThermalZones.ReducedOrder.Multizone;
model MultizoneEquipped_TABS
  extends MultizoneEquipped;
  // TABS
  parameter Integer numTabs = 1;
  parameter Modelica.Units.SI.Area ATabs[numTabs]=fill(0, numTabs)
    "Areas of exterior walls by orientations";
  parameter Boolean ExtTabs[numTabs] = fill(false, numTabs) "Areas of exterior walls by orientations";
  parameter Integer TabsConnection[numTabs] = fill(1, numTabs)  "";
  parameter Modelica.Units.SI.Power TabsHeatLoad[numTabs]=fill(0, numTabs)
    "Calculated Heat Load for room with panel heating";
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition TabswallTypeFloor[numTabs]=
  fill(AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(), numTabs) "Wall type for floor";
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition TabswallTypeCeiling[numTabs]=
  fill(AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers.Ceiling_Dummy(), numTabs) "Wall type for ceiling";
  parameter Modelica.Units.SI.Distance TabsSpacing[numTabs]=fill(0.35, numTabs)
    "Spacing between tubes";
  parameter AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Piping.PipeBaseDataDefinition TabsPipes[numTabs]=
  fill(AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Piping.PBpipe(),numTabs) "Pipe type for TABS";


  Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.ControlledTABS TABS(
    RoomNo=numTabs,
    Area=ATabs,
    HeatLoad=TabsHeatLoad,
    Spacing=TabsSpacing,
    WallTypeFloor=TabswallTypeFloor,
    WallTypeCeiling=TabswallTypeCeiling,
    PipeRecord=TabsPipes,
    Controlled=true,
    Reduced=false)  if ATabs[1] > 0
    annotation (Placement(transformation(extent={{-14,-80},{20,-50}})));

equation
  //TABS
  if ATabs[1] > 0 then
    for i in 1:numTabs loop
      if zoneParam[TabsConnection[i]].ATabs > 0 or zoneParam[TabsConnection[i]].ATabs_int > 0 then
        connect(TSetHeat[TabsConnection[i]], TABS.T_Soll[i]) annotation (Line(
              points={{-40,-100},{-40,-53},{-14.68,-53}},       color={0,0,127}));
        if ExtTabs[i] then
          connect(TABS.heatFloor[i], zone[TabsConnection[i]].tabs) annotation (
            Line(points={{3,-50},{72,-50},{72,54.33},{45.14,54.33}}, color={191,
                0,0}));
        else
          connect(TABS.heatFloor[i], zone[TabsConnection[i]].tabs_int) annotation (
            Line(points={{3,-50},{72,-50},{72,54.33},{45.14,54.33}}, color={191,
                0,0}));
        end if;
        connect(TABS.T_Room[i], zone[TabsConnection[i]].TAir) annotation (Line(
              points={{-14.68,-57.5},{-30,-57.5},{-30,-82},{98,-82},{98,85.9},{
                82.1,85.9}},        color={0,0,127}));
      end if;
    end for;
  end if;


end MultizoneEquipped_TABS;
