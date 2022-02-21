within AixLib.ThermalZones.HighOrder.Rooms.BaseClasses;
partial model PartialRoom "Partial model with base component that are necessary for all HOM rooms"

  extends PartialRoomParams;
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations(redeclare package
      Medium = Media.Air,                                  final T_start=T0_air);

  // Air volume of room
  parameter Modelica.SIunits.Volume room_V annotation (Dialog(group="Air volume of room"));
  parameter Integer nPorts=0 "Number of fluid ports"
    annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));
  parameter Boolean use_C_flow=false
    "Set to true to enable trace substances in the rooms air"
    annotation (Dialog(group="Trace Substances"));
  parameter Boolean use_C_flow_input=true "Set to true to use an input connector for the trace substances. False indicates internal calculation" annotation(Dialog(enable=use_C_flow, group="Trace Substances"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
      Placement(transformation(extent={{-30,22},{-10,42}}), iconTransformation(
          extent={{-24,-10},{-4,10}})));
  Utilities.Interfaces.RadPort        starRoom annotation (Placement(transformation(
          extent={{-2,20},{18,40}}), iconTransformation(extent={{6,-10},{26,10}})));
  Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    final room_V=room_V,
    final n50=n50,
    final e=e,
    final eps=eps,
    final c=cAir,
    final rho = denAir) if use_infiltEN12831
             annotation (Placement(transformation(extent={{-60,-12},{-48,0}})));
  Modelica.Blocks.Interfaces.RealInput AirExchangePort annotation (Placement(
        transformation(
        extent={{-13,-13},{13,13}},
        rotation=0,
        origin={-112,80}), iconTransformation(
        extent={{-10,-9.5},{10,9.5}},
        rotation=0,
        origin={-110,69.5})));

  Utilities.Interfaces.Adaptors.ConvRadToCombPort        thermStar_Demux annotation (Placement(transformation(
        extent={{-6,5},{6,-5}},
        rotation=90,
        origin={-7,8})));
  Components.DryAir.VarAirExchange
    NaturalVentilation(final V=room_V)
    annotation (Placement(transformation(extent={{-60,-24},{-48,-12}})));
  Components.DryAir.DynamicVentilation
    dynamicVentilation(
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset) if withDynamicVentilation
    annotation (Placement(transformation(extent={{-60,-38},{-48,-26}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
    annotation (Placement(transformation(extent={{36,-6},{50,8}})));

  Fluid.MixingVolumes.MixingVolume airload(
    redeclare final package Medium = Medium,
    final p_start=p_start,
    final X_start=X_start,
    final C_start=C_start,
    final C_nominal=C_nominal,
    final mSenFac=mSenFac,
    final use_C_flow=use_C_flow,
    final nPorts=nPorts,
    final m_flow_nominal=room_V*6/3600*1.2,
    final V=room_V,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final T_start=T_start)
    "Indoor air volume"
    annotation (Placement(transformation(extent={{26,-22},{6,-2}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
      redeclare each final package Medium = Medium)
    "Auxiliary fluid inlets and outlets to indoor air volume"
    annotation (
    Placement(transformation(
    extent={{-45,-12},{45,12}},
    origin={-3,-100}),iconTransformation(
    extent={{-30.5,-8},{30.5,8}},
    origin={0,-101.5})));

  Modelica.Blocks.Interfaces.RealInput C_flow[Medium.nC] if use_C_flow and use_C_flow_input
    "Trace substance mass flow rate added to the medium" annotation (Placement(
        transformation(extent={{-124,6},{-100,30}}), iconTransformation(extent={
            {-120,10},{-100,30}})));
equation
  connect(thermRoom,thermStar_Demux.portConv) annotation (Line(points={{-20,32},
          {-20,14},{-10.125,14}},                                                                                 color={191,0,0}));
  connect(starRoom,thermStar_Demux.portRad) annotation (Line(
      points={{8,30},{8,14},{-3.875,14}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(infiltrationRate.port_a,thermOutside)  annotation (Line(
      points={{-60,-6},{-66,-6},{-66,100},{-100,100}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(NaturalVentilation.port_a,thermOutside)  annotation (Line(points={{-60,-18},
          {-68,-18},{-68,100},{-100,100}},   color={191,0,0}));
  connect(dynamicVentilation.port_outside,thermOutside)  annotation (Line(
      points={{-60,-32},{-72,-32},{-72,100},{-100,100}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(AirExchangePort, NaturalVentilation.ventRate) annotation (Line(points={{-112,80},
          {-70,80},{-70,-20},{-64,-20},{-64,-21.84},{-59.4,-21.84}},                                                                            color={0,0,127}));
  connect(airload.ports, ports) annotation (Line(
      points={{16,-22},{16,-82},{0,-82},{0,-100},{-3,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  //connect(thermRoom, thermRoom) annotation (Line(points={{-10,22},{-6,22},{-6,22},
   //       {-10,22}}, color={191,0,0}));
  connect(Tair.port, airload.heatPort)
    annotation (Line(points={{36,1},{36,-12},{26,-12}}, color={191,0,0}));
  connect(dynamicVentilation.port_inside, airload.heatPort) annotation (Line(
      points={{-48.12,-32},{30,-32},{30,-12},{26,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(NaturalVentilation.port_b, airload.heatPort) annotation (Line(points={{-48,-18},
          {-42,-18},{-42,-24},{30,-24},{30,-12},{26,-12}},           color={191,
          0,0}));
  connect(thermStar_Demux.portConv, airload.heatPort) annotation (Line(points={{-10.125,
          14},{-12,14},{-12,-24},{30,-24},{30,-12},{26,-12}},       color={191,0,
          0}));
  connect(infiltrationRate.port_b, airload.heatPort) annotation (Line(
      points={{-48,-6},{-38,-6},{-38,-24},{30,-24},{30,-12},{26,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(airload.C_flow, C_flow) annotation (Line(points={{28,-18},{34,-18},{
          34,-42},{-80,-42},{-80,18},{-112,18}},
                                              color={0,0,127}));
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (building airtightness"),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>January 9, 2020 by Philipp Mehrfeld:<br/>
    Model added to the AixLib library.
  </li>
</ul>
</html>"));
end PartialRoom;
