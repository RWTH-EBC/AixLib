within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating;
model UnderfloorHeatingSystem "Model for an underfloor heating system"
  extends
    AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PartialUnderFloorHeating;

  parameter Integer nZones(min=1)
    "Number of zones / rooms heated with panel heating"
    annotation (Dialog(group="General"));

  parameter Modelica.Units.SI.Power Q_flow_nominal[nZones]
    "Nominal heat Load for zone with panel heating" annotation (Dialog(group=
          "Room Specifications"));
  parameter Modelica.Units.SI.Area A[nZones] "Floor Area" annotation(Dialog(group = "Room Specifications"));
  //# TODO Record, move to norm, rename
  parameter Modelica.Units.SI.Length maxLength = 120 "Maximum Length for one Circuit" annotation(Dialog(group = "Panel Heating"));
  parameter Modelica.Units.SI.Temperature T_Fmax[nZones]=fill(302.15,nZones)  "Maximum surface temperature" annotation (Dialog(group="Room Specifications"));
  parameter Modelica.Units.SI.Temperature T_Room[nZones]=fill(293.15,nZones)  "Nominal room temperature" annotation (Dialog(group="Room Specifications"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor[nZones] "Wall type for floor" annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);
  parameter Boolean Ceiling[nZones] "false if ground plate is under panel heating" annotation (Dialog(group = "Room Specifications"));
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling[nZones] "Wall type for ceiling" annotation (Dialog(group="Room Specifications", enable = Ceiling), choicesAllMatching=true);

  parameter Modelica.Units.SI.Temperature T_U[nZones]=293.15                                                      "Set value for Room Temperature lying under panel heating" annotation (Dialog(group="Room Specifications"));

  parameter Modelica.Units.SI.Distance Spacing[nZones] "Spacing between tubes" annotation (Dialog( group = "Panel Heating"));
  final parameter Modelica.Units.SI.Length PipeLength[nZones] = A ./ Spacing "Pipe Length in every room";
  parameter Modelica.Units.SI.Thickness PipeThickness[nZones] "Thickness of pipe wall" annotation (Dialog( group = "Panel Heating"));
  parameter Modelica.Units.SI.Diameter d_a[nZones] "Outer diameter of pipe" annotation (Dialog( group = "Panel Heating"));
  parameter Modelica.Units.SI.Diameter d[nZones](min = d_a) = d_a "Outer diameter of pipe including Sheathing" annotation (Dialog( group = "Panel Heating", enable = withSheathing));

  final parameter Modelica.Units.SI.HeatFlux qMax_flow_nominal=max(ufhRoom.q_flow_nominal)
    "highest specific heat flux in system";
  parameter Modelica.Units.SI.TemperatureDifference sigma_des(max = 5) = 5  "Temperature Spread for room with highest heat load (max = 5)";

  final parameter Modelica.Units.SI.TemperatureDifference dT_Hdes=qMax_flow_nominal/K_H[1]
    "Temperature difference between medium and room for room with highest heat flux";
  final parameter Modelica.Units.SI.TemperatureDifference dT_Vdes = dT_Hdes + sigma_des / 2 + sigma_des^(2) / (12 * dT_Hdes) "Temperature difference at flow temperature";
  final parameter Modelica.Units.SI.Temperature T_Vdes = (T_Roomdes - ((sigma_des + T_Roomdes) * e^(sigma_des / dT_Hdes))) / (1 - e^(sigma_des / dT_Hdes)) "Flow Temperature according to EN 1264";
  final parameter Modelica.Units.SI.Temperature T_Roomdes = T_Room[1] "Room temperature in room with highest heat flux";
  final parameter Modelica.Units.SI.TemperatureDifference sigma_i[nZones] = cat(1, {sigma_des}, {(3 * dT_Hi[n] * (( 1 + 4 * ( dT_Vdes - dT_Hi[n])  / ( 3 * dT_Hi[n])) ^ (0.5) - 1)) for n in 2:nZones}) "Nominal temperature spread in rooms";
  final parameter Modelica.Units.SI.Temperature T_Return[nZones] = fill(T_Vdes,nZones)  .- sigma_i "Nominal return temperature in each room";

  final parameter Modelica.Units.SI.PressureDifference dpDis_nominal=if sum(
      ufhRoom.nCircuits) == 1 then 0 else
      UnderfloorHeating.BaseClasses.PressureLoss.GetPressureLossOfUFHDistributor(
       VTot_flow_nominal/nDistributors, nHeaCirPerDis)
    "Nominal pressure drop of control equipment";
  final parameter Integer nDistributors(min=1) = integer(ceil(sum(ufhRoom.nCircuits)
    /14)) "Number of Distributors needed in the underfloor heating system";
  final parameter Modelica.Units.SI.VolumeFlowRate VTot_flow_nominal=
      m_flow_nominal/rho_default "Nominal system volume flow rate";
  final parameter Integer nHeaCirPerDis(min=1) = integer(ceil(sum(ufhRoom.nCircuits)
    /nDistributors)) "Average number of heating circuits in distributor";

  BaseClasses.Distributor distributor(
    redeclare package Medium = Medium,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start,
    final C_nominal=C_nominal,
    final mSenFac=mSenFac,
    final m_flow_nominal=m_flow_nominal,
    final n=integer(sum(ufhRoom.nCircuits))) "Distributes the water into the rooms"
                               annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-20,-20})));
  UnderfloorHeatingRoom ufhRoom[nZones](
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
    final Q_flow_nominal=Q_flow_nominal,
    final A=A,
    final dpPipe_nominal=dp_Pipe,
    final dpValve_nominal=dp_Valve,
    each final dpFixed_nominal=dpDis_nominal,
    final Ceiling=Ceiling,
    final TZoneBel_nominal=T_U,
    final TSurMax=T_Fmax,
    final TZone_nominal=T_Room,
    each final PipeMaterial=PipeMaterial,
    final PipeThickness=PipeThickness,
    final d_a=d_a,
    each final withSheathing=withSheathing,
    each final SheathingMaterial=SheathingMaterial,
    final d=d,
    each use_vmax=use_vmax,
    each TSup_nominal=T_Vdes,
    TRet_nominal=T_Return,
    each calculateVol=calculateVol,
    each final dis=dis,
    final spacing=Spacing,
    each lengthMax=maxLength,
    final wallTypeFloor=wallTypeFloor,
    final wallTypeCeiling=wallTypeCeiling,
    final dT_Hi=dT_Hi) "Underfloor heating instance for all rooms"
    annotation (Placement(transformation(extent={{0,0},{40,40}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort TFlow(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort TReturn(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Modelica.Blocks.Interfaces.RealInput uVal[nZones]
    "Control value for valve (0: closed, 1: open)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,60})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portConFloor[nZones]
    "Convective heat port of floor"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portRadFloor[nZones]
    "Radiative heat port of floor"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portRadCei[nZones]
    "Radiative heat port of ceiling"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a portConCei[nZones]
    "Convective heat port of ceiling"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";

initial equation
  // Check validity of data
  assert(
    ufhRoom.q_flow_nominal[1] == qMax_flow_nominal,
    "The room with the highest specific heat load needs to be the first element of the vector. Ignore if highest heat load appears in bathroom",
    AssertionLevel.warning);

equation


 // OUTER FLUID CONNECTIONS
  connect(port_a, TFlow.port_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(TFlow.port_b, distributor.portMaiSup) annotation (Line(points={{-60,0},
          {-46,0},{-46,-20},{-40,-20}}, color={0,127,255}));
  connect(TReturn.port_a,distributor.portMaiRet)
    annotation (Line(points={{60,0},{44,0},{44,-20},{-1.77636e-15,-20}},
                                              color={0,127,255}));
  connect(TReturn.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));

  // HEATING CIRCUITS FLUID CONNECTIONS

     for m in 1:ufhRoom.nCircuits[1] loop
    connect(distributor.portsCirSup[m], ufhRoom[1].ports_a[m]);
    connect(ufhRoom[1].ports_b[m], distributor.portsCirRet[m]);
  end for;

  if nZones > 1 then
    for x in 2:nZones loop
      for u in 1:ufhRoom.nCircuits[x] loop
        connect(distributor.portsCirSup[(sum(CircuitNo[v] for v in 1:(x - 1)) +
          u)], ufhRoom[x].ports_a[u]) annotation (Line(points={{-22.6667,0},{
                -22.6667,20},{0,20}},  color={0,127,255}));
        connect(ufhRoom[x].ports_b[u], distributor.portsCirRet[(sum(CircuitNo[v]
          for v in 1:(x - 1)) + u)]) annotation (Line(points={{40,20},{40,20},{
                46,20},{46,-46},{-17.3333,-46},{-17.3333,-40.6667}},  color={0,127,
                255}));
      end for;
          end for;
  end if;

  // OTHER CONNECTIONS

  connect(uVal, ufhRoom.uVal) annotation (Line(points={{-120,60},{-14,60},{-14,32},
          {-4,32}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(extent={{-100,-80},{100,100}},initialScale=0.1),
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
            -100},{100,100}},
                            initialScale=0.1)));
end UnderfloorHeatingSystem;
