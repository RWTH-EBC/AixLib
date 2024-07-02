within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model ControlledTABS
  "Example for underfloor heating system with two rooms for ideal upward and downward heat flow"
  package MediumAir = AixLib.Media.Air;
  package MediumWater = AixLib.Media.Water;

  parameter Integer dis= if not Reduced then 100 else 20  "Number of discretization layers for panel heating pipe (use_ROM)";
  parameter Integer RoomNo(min=1)=1 "Number of rooms heated with panel heating" annotation (Dialog(group="General"));
  parameter Modelica.Units.SI.Area Area[RoomNo] "Floor Area"
    annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Power HeatLoad[RoomNo]
    "Calculated Heat Load for room with panel heating"
    annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Distance Spacing[RoomNo] "Spacing between tubes"
    annotation (Dialog(group="Panel Heating"));
  parameter DataBase.Walls.WallBaseDataDefinition WallTypeFloor[RoomNo]
    "Wall type for floor"                                                                            annotation (Dialog(group=
          "Room Specifications"),                                                                                                                     choicesAllMatching=true);
  parameter DataBase.Walls.WallBaseDataDefinition WallTypeCeiling[RoomNo]
    "Wall type for floor"                                                                              annotation (Dialog(group=
          "Room Specifications"),                                                                                                                       choicesAllMatching=true);
  parameter AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Piping.PipeBaseDataDefinition PipeRecord[RoomNo] "Pipe type for TABS" annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  parameter Boolean Controlled=true annotation (Dialog(group="General"));
  parameter Boolean Reduced=true;
  final parameter Modelica.Units.SI.Volume V_Water=tABSSystem.V_Water;
  final parameter Modelica.Units.SI.MassFlowRate m_flow_total=tABSSystem.m_flow_total;
  final parameter Modelica.Units.SI.PressureDifference dp_total=tABSSystem.dp_total;
  final parameter Modelica.Units.SI.VolumeFlowRate V_flow_total=tABSSystem.V_flow_total;

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
  Modelica.Blocks.Interfaces.RealInput T_Soll[RoomNo]  if Controlled annotation (Placement(
        transformation(extent={{-116,48},{-92,72}}), iconTransformation(extent={{-116,48},
            {-92,72}})));
  Modelica.Blocks.Interfaces.RealInput T_Room[RoomNo]  if Controlled annotation (Placement(
        transformation(extent={{-116,28},{-92,52}}), iconTransformation(extent={{-116,18},
            {-92,42}})));
  Modelica.Blocks.Sources.Constant const[RoomNo](each k=1)
    annotation (Placement(transformation(extent={{-52,20},{-38,34}})));
  AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced.TABSSystem
    tABSSystem(
     redeclare package Medium = MediumWater,
    final RoomNo=RoomNo,
    final dis=dis,
    final Q_Nf=HeatLoad,
    final A=Area,
    final wallTypeFloor=WallTypeFloor,
    final wallTypeCeiling=WallTypeCeiling,
    final Spacing=Spacing,
    final PipeRecord=PipeRecord,
    final Reduced=Reduced)
    annotation (Placement(transformation(extent={{-24,-16},{30,16}})));

  BaseClasses.PumpCircuit tABS_CCircuit(
    redeclare package Medium = MediumWater,
    m_flow_total=m_flow_total,
    dp_nom=dp_total,
    V_Water=V_Water) annotation (Placement(transformation(
        extent={{-26,-11},{26,11}},
        rotation=180,
        origin={4,-89})));
  Sources.Boundary_pT              bou(redeclare package Medium = MediumWater,
      nPorts=1)  annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,0})));
  Modelica.Blocks.Sources.Constant const1(each k=1)
    annotation (Placement(transformation(extent={{-26,-112},{-14,-100}})));
equation

  for i in 1:RoomNo loop
    connect(heatFloor[i], tABSSystem.heatTABS[i]) annotation (Line(
        points={{0,80},{0.35,80},{0.35,16},{3,16}},
        color={191,0,0}));

    if Controlled then
      connect(PID[i].y, tABSSystem.valveInput[i]) annotation (Line(
        points={{-32.8,60},{-15.65,60},{-15.65,18.1333},{-14.28,18.1333}},
        color={0,0,127}));
      connect(T_Soll[i], PID[i].u_s)  annotation (Line(points={{-104,60},{-60.4,
              60}},                                                                   color={0,0,127}));
      connect(T_Room[i], PID[i].u_m)  annotation (Line(points={{-104,40},{-46,40},
              {-46,45.6}},                                                                     color={0,0,127}));
    else
        connect(const[i].y, tABSSystem.valveInput[i]) annotation (Line(
        points={{-37.3,27},{-15.65,27},{-15.65,18.1333},{-14.28,18.1333}},
        color={0,0,127}));
    end if;
  end for;

  connect(tABSSystem.port_a, bou.ports[1]) annotation (Line(points={{-24,0},{-100,
          0},{-100,-4.44089e-16}}, color={0,127,255}));
  connect(tABS_CCircuit.port_b, tABSSystem.port_a) annotation (Line(points={{-22,
          -89},{-54,-89},{-54,0},{-24,0}}, color={0,127,255}));
  connect(tABS_CCircuit.T, tABSSystem.T_FlowNominal) annotation (Line(points={{9.2,
          -99.45},{9.2,-116},{-46,-116},{-46,-14.4},{-24,-14.4}}, color={0,0,127}));
  connect(tABS_CCircuit.port_a, tABSSystem.port_b) annotation (Line(points={{30,
          -89},{60,-89},{60,0},{30,0}}, color={0,127,255}));
  connect(const1.y, tABS_CCircuit.y) annotation (Line(points={{-13.4,-106},{4,
          -106},{4,-99.45}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},
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
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,80}})),
    experiment(StopTime=8640000),
    Documentation(info="<html><p>
  Based on the following table, the optimal number of discretization
  for the reduced cased of controlled TABS, is 20 discretizations.
</p>
<p>
  That is why 20 discretizations were in the model selected as default
  for the reduced case, whereas 100 discretizations were selected as
  default for the HOM case (tested in previous cases).
</p>
<p>
  <img src=\"modelica://AixLib/../../../internal_dis.svg\" alt=\"1\">
</p>
</html>"));
end ControlledTABS;
