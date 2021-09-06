within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model Controlled_UnderfloorHeating_ROM
  "Example for underfloor heating system with two rooms for ideal upward and downward heat flow"
  package MediumAir = AixLib.Media.Air;
  package MediumWater = AixLib.Media.Water;

  parameter Integer dis=100  "Number of discretization layers for panel heating pipe";
  parameter Integer RoomNo(min=1) "Number of rooms heated with panel heating" annotation (Dialog(group="General"));
  parameter Modelica.SIunits.Area area[RoomNo] "Floor Area" annotation(Dialog(group = "Room Specifications"));
  parameter Modelica.SIunits.Power HeatLoad[RoomNo] "Calculated Heat Load for room with panel heating" annotation (Dialog(group="Room Specifications"));
  parameter UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition PipeMaterial=UnderfloorHeating.BaseClasses.PipeMaterials.PERTpipe()
    "Pipe Material"
     annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
  parameter Modelica.SIunits.Distance Spacing[RoomNo] "Spacing between tubes" annotation (Dialog( group = "Panel Heating"));
  parameter Modelica.SIunits.Thickness PipeThickness[RoomNo] "thickness of pipe wall" annotation (Dialog( group = "Panel Heating"));
  parameter Modelica.SIunits.Diameter d_out[RoomNo] "outer diameter of pipe" annotation (Dialog( group = "Panel Heating"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor[RoomNo] "Wall type for floor" annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  parameter Boolean Controlled=true annotation (Dialog(group="General"));
  parameter Boolean Ceiling[RoomNo]=fill(false, RoomNo);

  UnderfloorHeating.UnderfloorHeatingSystem underfloorHeatingSystem(
    redeclare package Medium = MediumWater,
    final RoomNo=RoomNo,
    final dis=dis,
    final Q_Nf=HeatLoad,
    final A=area,
    final wallTypeFloor=wallTypeFloor,
    final wallTypeCeiling=fill(BaseClasses.FloorLayers.Ceiling_Dummy(), RoomNo),
    final Ceiling=Ceiling,
    final Spacing=Spacing,
    final PipeMaterial=PipeMaterial,
    final PipeThickness=PipeThickness,
    final d_a=d_out,
    final withSheathing=false)
    annotation (Placement(transformation(extent={{-26,-16},{28,16}})));

  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{94,-10},{74,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatFloor[RoomNo]
    annotation (Placement(transformation(extent={{-10,70},{10,90}}),
        iconTransformation(extent={{-10,70},{10,90}})));
  Modelica.Blocks.Continuous.LimPID PID[RoomNo](
    each controllerType=Modelica.Blocks.Types.SimpleController.PI,
    each k=0.004,
    each Ti=225,
    each yMax=1,
    each yMin=0) if Controlled
    annotation (Placement(transformation(extent={{-58,48},{-34,72}})));
  Modelica.Blocks.Interfaces.RealInput T_Soll[RoomNo] if  Controlled annotation (Placement(
        transformation(extent={{-116,48},{-92,72}}), iconTransformation(extent={{-116,48},
            {-92,72}})));
  Modelica.Blocks.Interfaces.RealInput T_Room[RoomNo] if  Controlled annotation (Placement(
        transformation(extent={{-116,28},{-92,52}}), iconTransformation(extent={{-116,18},
            {-92,42}})));
  Modelica.Blocks.Sources.Constant const[RoomNo](each k=1)
    annotation (Placement(transformation(extent={{-52,20},{-38,34}})));
equation

  for i in 1:RoomNo loop
    connect(heatFloor[i], underfloorHeatingSystem.heatFloor[i])
      annotation (Line(points={{0,80},{0,16},{1,16}},         color={191,0,0}));
    if Controlled then
      connect(PID[i].y, underfloorHeatingSystem.valveInput[i]) annotation (Line(
        points={{-32.8,60},{-16,60},{-16,18.1333},{-16.28,18.1333}}, color={0,0,
          127}));
      connect(T_Soll[i], PID[i].u_s)  annotation (Line(points={{-104,60},{-82,60},
              {-82,60},{-60.4,60}},                                                   color={0,0,127}));
      connect(T_Room[i], PID[i].u_m)  annotation (Line(points={{-104,40},{-46,40},{-46,45.6}}, color={0,0,127}));
    else
      connect(const[i].y, underfloorHeatingSystem.valveInput[i]) annotation (Line(
        points={{-37.3,27},{-15.65,27},{-15.65,18.1333},{-16.28,18.1333}},
        color={0,0,127}));
    end if;
  end for;

  connect(boundary.ports[1], underfloorHeatingSystem.port_a) annotation (Line(
        points={{-58,0},{-26,0}},                         color={0,127,255}));
  connect(underfloorHeatingSystem.port_b, bou.ports[1]) annotation (Line(points={{28,0},{
          74,0}},                               color={0,127,255}));
  connect(underfloorHeatingSystem.m_flowNominal, boundary.m_flow_in)
    annotation (Line(points={{-26,-9.6},{-48,-9.6},{-48,-14},{-86,-14},{-86,8},{
          -80,8}},                          color={0,0,127}));
  connect(underfloorHeatingSystem.T_FlowNominal, boundary.T_in) annotation (
      Line(points={{-26,-14.4},{-42,-14.4},{-42,-22},{-94,-22},{-94,4},{-80,4}},
                 color={0,0,127}));


  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
            {100,80}}), graphics={
        Polygon(
          points={{20,-60},{60,-75},{20,-90},{20,-60}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=not allowFlowReversal),
        Line(
          points={{55,-75},{-60,-75}},
          color={0,128,255},
          visible=not allowFlowReversal),
        Text(
          extent={{-149,-104},{151,-144}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-100,70},{100,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,50},{100,-6}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-88,52},{-64,-28}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,50},{-72,42}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,36},{-72,28}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,22},{-72,14}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,10},{-72,2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,-18},{-72,-26}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,-4},{-72,-12}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,-30},{100,-40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-40,-22},{100,-30}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-40,-6},{100,-22}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-40,60},{100,50}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag),
        Line(points={{-74,18},{-60,18},{-50,18},{-50,2},{-28,2}},
            color={255,0,0}),
        Line(points={{-78,6},{-64,6},{-54,6},{-54,-4},{-28,-4}},
            color={28,108,200}),
        Line(points={{-74,-8},{-50,-8},{-50,2}},        color={238,46,47}),
        Line(points={{-78,-22},{-54,-22},{-54,-4}},     color={28,108,200}),
        Line(points={{-76,46},{-62,46},{-50,46},{-50,18}},     color={238,46,47}),
        Line(points={{-76,32},{-54,32},{-54,6}},      color={28,108,200}),
        Text(
          extent={{-36,48},{82,34}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="1 ... RoomNo"),
        Ellipse(
          extent={{-34,4},{-26,-4}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,4},{-12,-4}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,4},{2,-4}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{8,4},{16,-4}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,4},{30,-4}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{36,4},{44,-4}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,4},{58,-4}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{64,4},{72,-4}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{78,4},{86,-4}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(points={{82,10},{94,10}},
                                     color={28,108,200}),
        Line(points={{82,4},{82,10}}, color={28,108,200})}),     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,80}})),
    experiment(StopTime=8640000));
end Controlled_UnderfloorHeating_ROM;
