within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Reduced;
model TABSSystem "Model for an underfloor heating system"
extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(allowFlowReversal=
        false, final m_flow_nominal = m_flow_total);
  import Modelica.Constants.e;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium in the component"  annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter Boolean Reduced=true;
  parameter Integer RoomNo(min=1) "Number of rooms heated with panel heating" annotation (Dialog(group="General"));
  final parameter Integer CircuitNo[RoomNo]=tABSRoom.CircuitNo
    "Number of circuits in a certain room";
  parameter Integer dis  "Number of discretization layers for panel heating pipe";
  parameter Modelica.Units.SI.Power Q_Nf[RoomNo]
    "Calculated Heat Load for room with panel heating"
    annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Area A[RoomNo] "Floor Area"
    annotation (Dialog(group="Room Specifications"));
  parameter Integer calculateVol = 1 annotation (Dialog(group="Panel Heating",
        descriptionLabel=true), choices(
      choice=1 "Calculate Water Volume with inner diameter",
      choice=2 "Calculate Water Volume with time constant",
      radioButtons=true));
  parameter Integer use_vmax(min = 1, max = 2) = 1 "Output if v > v_max (0.5 m/s)" annotation(choices(choice = 1 "Warning", choice = 2 "Error"));
  parameter Modelica.Units.SI.Length maxLength=120
    "Maximum Length for one Circuit" annotation (Dialog(group="Panel Heating"));
  parameter Modelica.Units.SI.Temperature T_Fmax[RoomNo]=fill(29 + 273.15,
      RoomNo) "Maximum surface temperature"
    annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Temperature T_Room[RoomNo]=fill(20 + 273.15,
      RoomNo) "Nominal room temperature"
    annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Temperature T_U[RoomNo]=fill(
      Modelica.Units.Conversions.from_degC(20), RoomNo)
    "Set value for Room Temperature lying under panel heating"
    annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Distance Spacing[RoomNo] "Spacing between tubes"
    annotation (Dialog(group="Panel Heating"));
  final parameter Modelica.Units.SI.Length PipeLength[RoomNo]=A ./ Spacing
    "Pipe Length in every room";

  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor[RoomNo] "Wall type for floor" annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
   parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling[RoomNo] "Wall type for Ceiling" annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  parameter AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Piping.PipeBaseDataDefinition PipeRecord[RoomNo]  "Pipe layers"    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);

  final parameter Modelica.Units.SI.ThermalResistance R_x[RoomNo]=tABSRoom.R_add;
  final parameter Modelica.Units.SI.MassFlowRate m_flow_total=sum(tABSRoom.m_flow_PanelHeating)
    "Total mass flow in the panel heating system";
  Real m_flow_out = sum(tABSRoom.m_flow_PanelHeating .* valveInput);
  final parameter Modelica.Units.SI.HeatFlux q_max=max(tABSRoom.q)
    "highest specific heat flux in system";
  parameter Modelica.Units.SI.TemperatureDifference sigma_des(max=5) = 5
    "Temperature Spread for room with highest heat load (max = 5)";
  final parameter Modelica.Units.SI.TemperatureDifference dT_Hdes=q_max/K_H[1]
    "Temperature difference between medium and room for room with highest heat flux";
  final parameter Modelica.Units.SI.TemperatureDifference dT_Vdes=dT_Hdes +
      sigma_des/2 + sigma_des^(2)/(12*dT_Hdes)
    "Temperature difference at flow temperature";
  final parameter Modelica.Units.SI.Temperature T_Vdes=(T_Roomdes - ((sigma_des
       + T_Roomdes)*e^(sigma_des/dT_Hdes)))/(1 - e^(sigma_des/dT_Hdes))
    "Flow Temperature according to EN 1264";
  final parameter Modelica.Units.SI.Temperature T_Roomdes=T_Room[1]
    "Room temperature in room with highest heat flux";
  final parameter Modelica.Units.SI.TemperatureDifference sigma_i[RoomNo]=cat(
      1,
      {sigma_des},
      {(3*dT_Hi[n]*((1 + 4*(dT_Vdes - dT_Hi[n])/(3*dT_Hi[n]))^(0.5) - 1)) for n in
            2:RoomNo}) "Nominal temperature spread in rooms";
  final parameter Modelica.Units.SI.Temperature T_Return[RoomNo]=fill(T_Vdes,
      RoomNo) .- sigma_i "Nominal return temperature in each room";

  final parameter Real K_H[RoomNo]=tABSRoom.K_H
    "Specific parameter for dimensioning according to EN 1264 that shows the relation between temperature difference and heat flux";
  final parameter Real q[RoomNo]=tABSRoom.q "needed heat flux from underfloor heating";
  final parameter Modelica.Units.SI.TemperatureDifference dT_Hi[RoomNo]=q ./
      K_H
    "Nominal temperature difference between heating medium and room for each room";

  parameter Modelica.Units.SI.PressureDifference dp_Pipe[RoomNo]=100*PipeLength
       ./ CircuitNo "Pressure Difference in each pipe for every room";
  final parameter Modelica.Units.SI.PressureDifference dp_Valve[RoomNo]=max(
      dp_Pipe) .- dp_Pipe
    "Pressure Difference set in regulating valve for pressure equalization";
  final parameter Modelica.Units.SI.PressureDifference dp_Distributor=if sum(
      CircuitNo) == 1 then 0 else
      UnderfloorHeating.BaseClasses.PressureLoss.GetPressureLossOfUFHDistributor(
      V_flow_total/n_Distributors, n_HC)
    "Nominal pressure drop of control equipment";
  final parameter Modelica.Units.SI.PressureDifference dp_total=max(dp_Pipe) +
      max(dp_Valve) + dp_Distributor;
  final parameter Integer n_Distributors(min = 1) = integer(ceil(sum(CircuitNo)/14)) "Number of Distributors needed in the underfloor heating system";
  final parameter Modelica.Units.SI.VolumeFlowRate V_flow_total=m_flow_total/
      rho_default "Nominal system volume flow rate";
  final parameter Integer n_HC(min=1) = integer(ceil(sum(CircuitNo) / n_Distributors)) "Average number of heating circuits in distributor";
  final parameter Modelica.Units.SI.Volume V_Water=sum(tABSRoom.V_Water);


  BaseClasses.Distributor distributor(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_start=p_start,
    T_start=T_start,
    X_start=X_start,
    C_start=C_start,
    C_nominal=C_nominal,
    mSenFac=mSenFac,
    m_flow_nominal=m_flow_total,
    n=integer(sum(CircuitNo))) annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-28,0})));
  TABSRoom              tABSRoom             [RoomNo](
    redeclare each final package Medium = Medium,
    each allowFlowReversal=false,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final C_start=C_start,
    each final C_nominal=C_nominal,
    each final mSenFac=mSenFac,
    each final Reduced=Reduced,
    final Q_Nf=Q_Nf,
    final A=A,
    final dp_Pipe=dp_Pipe,
    final dp_Valve=dp_Valve,
    each final dpFixed_nominal=dp_Distributor,
    final T_U=T_U,
    final T_Fmax=T_Fmax,
    final T_Room=T_Room,
    each use_vmax=use_vmax,
    each T_Flow=T_Vdes,
    T_Return=T_Return,
    each calculateVol=calculateVol,
    each final dis=dis,
    final Spacing=Spacing,
    each maxLength=maxLength,
    final wallTypeFloor=wallTypeFloor,
    final wallTypeCeiling=wallTypeCeiling,
    final PipeRecord=PipeRecord,
    final dT_Hi=dT_Hi)
    annotation (Placement(transformation(extent={{-16,16},{16,36}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort TFlow(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_total,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-74,-8},{-58,8}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort TReturn(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_total,
    T_start=T_start)
    annotation (Placement(transformation(extent={{34,-8},{50,8}})));

  Modelica.Blocks.Sources.RealExpression m_flowNom(y=m_flow_out)
    annotation (Placement(transformation(extent={{-60,-46},{-80,-26}})));
  Modelica.Blocks.Interfaces.RealOutput m_flowNominal
    annotation (Placement(transformation(extent={{-90,-46},{-110,-26}})));
  Modelica.Blocks.Sources.RealExpression T_FlowNom(y=if T_Vdes > 272.15 then
        T_Vdes else 278.15)
    annotation (Placement(transformation(extent={{-60,-64},{-80,-44}})));
  Modelica.Blocks.Interfaces.RealOutput T_FlowNominal
    annotation (Placement(transformation(extent={{-90,-64},{-110,-44}})));
  Modelica.Blocks.Interfaces.RealInput valveInput[RoomNo] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-64,68})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatTABS[RoomNo]
    annotation (Placement(transformation(extent={{-10,50},{10,70}}),
        iconTransformation(extent={{-10,50},{10,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatCeiling[RoomNo] if not Reduced
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}}),
        iconTransformation(extent={{-10,-70},{10,-50}})));
protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";

initial equation
  // Check validity of data
  assert(q[1] == q_max, "The room with the highest specific heat load needs to be the first element of the vector. Ignore if highest heat load appears in bathroom", AssertionLevel.warning);

equation

  // HEAT CONNECTIONS
  connect(port_a, TFlow.port_a)
    annotation (Line(points={{-100,0},{-74,0}}, color={0,127,255}));

 // OUTER FLUID CONNECTIONS
  connect(TFlow.port_b, distributor.mainFlow)
    annotation (Line(points={{-58,0},{-40,0}}, color={0,127,255}));
  connect(TReturn.port_a, distributor.mainReturn)
    annotation (Line(points={{34,0},{-16,0}}, color={0,127,255}));
  connect(TReturn.port_b, port_b)
    annotation (Line(points={{50,0},{100,0}}, color={0,127,255}));

  // HEATING CIRCUITS FLUID CONNECTIONS

  for m in 1:CircuitNo[1] loop
    connect(distributor.flowPorts[m], tABSRoom[1].ports_a[m]);
    connect(tABSRoom[1].ports_b[m], distributor.returnPorts[m]);
  end for;

  if RoomNo > 1 then
    for x in 2:RoomNo loop
      for u in 1:CircuitNo[x] loop
        connect(distributor.flowPorts[(sum(CircuitNo[v] for v in 1:(x - 1)) + u)], tABSRoom[
          x].ports_a[u]) annotation (Line(points={{-29.6,12},{-29.6,27.4286},{
                -16,27.4286}},
              color={0,127,255}));
        connect(tABSRoom[x].ports_b[u], distributor.returnPorts[(sum(CircuitNo[v] for v in 1
          :(x - 1)) + u)]) annotation (Line(points={{16,27.4286},{24,27.4286},{
                24,-22},{-26.4,-22},{-26.4,-12.4}},
                                     color={0,127,255}));
      end for;
          end for;
  end if;

  // OTHER CONNECTIONS

  connect(m_flowNom.y, m_flowNominal)
    annotation (Line(points={{-81,-36},{-100,-36}}, color={0,0,127}));
  connect(T_FlowNom.y, T_FlowNominal)
    annotation (Line(points={{-81,-54},{-100,-54}}, color={0,0,127}));
  connect(tABSRoom.heatTABS, heatTABS)    annotation (Line(points={{0,36},{0,60}}, color={191,0,0}));
  for m in 1:RoomNo loop
    connect(valveInput[m], tABSRoom[m].valveInput)   annotation (Line(points={{-64,68},{-64,38},{-9.92,38}}, color={0,0,127}));
  end for;
  // HOM CONNECTIONS
  if not Reduced then
      connect(tABSRoom.heatCeiling, heatCeiling)    annotation (Line(points={{0,16},{
            0,-60}},                                                                         color={191,0,0}));
  end if;
    annotation (Icon(coordinateSystem(extent={{-100,-60},{100,60}}, initialScale=0.1),
        graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,40},{100,-16}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-88,42},{-64,-38}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,40},{-72,32}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,26},{-72,18}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,12},{-72,4}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,0},{-72,-8}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,-28},{-72,-36}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-80,-14},{-72,-22}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,-40},{100,-50}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent={{-40,-32},{100,-40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-40,-16},{100,-32}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-40,50},{100,40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.CrossDiag),
        Line(points={{-74,8},{-60,8},{-50,8},{-50,-8},{-28,-8}},
            color={255,0,0}),
        Line(points={{-78,-4},{-64,-4},{-54,-4},{-54,-14},{-28,-14}},
            color={28,108,200}),
        Line(points={{-74,-18},{-50,-18},{-50,-8}},     color={238,46,47}),
        Line(points={{-78,-32},{-54,-32},{-54,-14}},    color={28,108,200}),
        Line(points={{-76,36},{-62,36},{-50,36},{-50,8}},      color={238,46,47}),
        Line(points={{-76,22},{-54,22},{-54,-4}},     color={28,108,200}),
        Text(
          extent={{-36,38},{82,24}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="1 ... RoomNo"),
        Ellipse(
          extent={{-34,-6},{-26,-14}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-6},{-12,-14}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,-6},{2,-14}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{8,-6},{16,-14}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,-6},{30,-14}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{36,-6},{44,-14}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,-6},{58,-14}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{64,-6},{72,-14}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{78,-6},{86,-14}},
          lineColor={200,200,200},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-88,0}}, color={238,46,47}),
        Line(points={{82,0},{94,0}}, color={28,108,200}),
        Line(points={{82,-6},{82,0}}, color={28,108,200})}), Documentation(
   info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model for heat transfer of an underfloor heating system for heating
  of multiple rooms. It can be directly used with the High Order Model.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  This model represents an underfloor heating system for several rooms.
  It calculates the number of heating circuits for each room and merges
  them in a distributor.
</p>
<p>
  Every heating circuit has an equal percentage valve that has to be
  regulated from outside.
</p>
<p>
  For the determination of the nominal mass flow and the flow
  temperature the regulations by prEN 1264 are implemented.
</p><b><span style=\"color: #008000;\">Heat Flow</span></b>
<p>
  For correct dimensioning, the room with the highest heat load needs
  to be the first one that is connected!
</p>
<p>
  Every room needs to have <i>dis</i> heat connections to the
  underfloor heating system to determine the right surface
  temperatures.
</p><b><span style=\"color: #008000;\">Layer Structure</span></b>
<p>
  For dimensioning it is important that the layer structure of the
  floor is set right!
</p>
<p>
  The wall layers above the heating circuits have to be in the
  following order:
</p>
<p>
  1. Cover / Screed
</p>
<p>
  2. Floor
</p>
<p>
  The wall layers below the heating circuits need to be in the record
  with the following order:
</p>
<p>
  1. Isolation
</p>
<p>
  2. Load-bearing substrate
</p>
<p>
  3. Plaster
</p>
<p>
  If there is a floor plate underneath the heating circuits, the wall
  record needs to consist of 4 layers, whereas the first layer needs to
  be the isolation!
</p><b><span style=\"color: #008000;\">Isolation</span></b>
<p>
  The thermal resistance of the isolation needs to fulfill the
  following requirements:
</p>
<p>
  Room underneath the underfloor heating is heated:
  R<sub>lambda,Ins</sub> <code>&gt;= 0,75 W/m²K</code>
</p>
<p>
  Room underneath the underfloor heating is not heated / floor plate:
  R<sub>lambda,Ins</sub> <code>&gt;= 1,25 W/m²K</code>
</p><b><span style=\"color: #008000;\">Water Volume</span></b>
<p>
  The water volume in the pipe element can be calculated by the inner
  diameter of the pipe or by time constant and the mass flow.
</p>
<p>
  The maximum velocity in the pipe is set for 0.5 m/s. If the Water
  Volume is calculated by time constant, a nominal inner diameter is
  calculated with the maximum velocity for easier parametrization.
</p>
</html>"),                                  Diagram(coordinateSystem(extent={{-100,
            -60},{100,60}}, initialScale=0.1)));
end TABSSystem;
