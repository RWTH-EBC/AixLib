within AixLib.ThermalZones.HighOrder.Rooms.BaseClasses;
partial model PartialRoom "Partial model with base component that are necessary for all HOM rooms"

  extends PartialRoomParams;

  // Air volume of room
  parameter Modelica.SIunits.Volume room_V annotation (Dialog(group="Air volume of room"));
  parameter Integer nPorts=0 "Number of fluid ports"
    annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (
      Placement(transformation(extent={{-20,12},{0,32}}),   iconTransformation(
          extent={{-24,-10},{-4,10}})));
  Utilities.Interfaces.RadPort        starRoom annotation (Placement(transformation(
          extent={{2,12},{22,32}}),  iconTransformation(extent={{6,-10},{26,10}})));
  Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate(
    final room_V=room_V,
    final n50=n50,
    final e=e,
    final eps=eps,
    final c=cAir,
    final rho = denAir) if use_infiltEN12831
             annotation (Placement(transformation(extent={{-30,-10},{-18,2}})));
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
        origin={-7,-2})));
  Components.DryAir.VarAirExchange
    NaturalVentilation(final V=room_V)
    annotation (Placement(transformation(extent={{-34,-24},{-22,-12}})));
  Components.DryAir.DynamicVentilation
    dynamicVentilation(
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset) if withDynamicVentilation
    annotation (Placement(transformation(extent={{-30,-38},{-18,-26}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
    annotation (Placement(transformation(extent={{24,-6},{38,8}})));

  Fluid.MixingVolumes.MixingVolume airload(
    redeclare final package Medium = Medium,
    final mSenFac=1,
    final nPorts=nPorts,
    m_flow_nominal=room_V*6/3600*1.2,
    final V=room_V,
    final energyDynamics=initDynamicsAir,
    final massDynamics=initDynamicsAir,
    final T_start=T0_air)
    "Indoor air volume"
    annotation (Placement(transformation(extent={{18,-22},{-2,-2}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
      redeclare each final package Medium = Medium)
    "Auxiliary fluid inlets and outlets to indoor air volume"
    annotation (
    Placement(transformation(
    extent={{-45,-12},{45,12}},
    origin={-3,-100}),iconTransformation(
    extent={{-30.5,-8},{30.5,8}},
    origin={150,-179.5})));
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation (
      __Dymola_choicesAllMatching=true);
equation
  connect(thermRoom,thermStar_Demux.portConv) annotation (Line(points={{-10,22},{-10,6},{-10.125,6},{-10.125,4}}, color={191,0,0}));
  connect(starRoom,thermStar_Demux.portRad) annotation (Line(
      points={{12,22},{12,4},{-3.875,4},{-3.875,4}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(infiltrationRate.port_a,thermOutside)  annotation (Line(
      points={{-30,-4},{-66,-4},{-66,100},{-100,100}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(NaturalVentilation.port_a,thermOutside)  annotation (Line(points={{-34,-18},
          {-68,-18},{-68,100},{-100,100}},   color={191,0,0}));
  connect(dynamicVentilation.port_outside,thermOutside)  annotation (Line(
      points={{-30,-32},{-72,-32},{-72,100},{-100,100}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(AirExchangePort, NaturalVentilation.ventRate) annotation (Line(points={{-112,80},
          {-70,80},{-70,-20},{-50,-20},{-50,-21.84},{-33.4,-21.84}},                                                                            color={0,0,127}));
  connect(airload.ports, ports) annotation (Line(
      points={{8,-22},{8,-82},{0,-82},{0,-100},{-3,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(thermRoom, thermRoom) annotation (Line(points={{-10,22},{-6,22},{-6,22},
          {-10,22}}, color={191,0,0}));
  connect(Tair.port, airload.heatPort)
    annotation (Line(points={{24,1},{24,-12},{18,-12}}, color={191,0,0}));
  connect(dynamicVentilation.port_inside, airload.heatPort) annotation (Line(
      points={{-18.12,-32},{24,-32},{24,-12},{18,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(NaturalVentilation.port_b, airload.heatPort) annotation (Line(points={
          {-22,-18},{-20,-18},{-20,-24},{24,-24},{24,-12},{18,-12}}, color={191,
          0,0}));
  connect(thermStar_Demux.portConv, airload.heatPort) annotation (Line(points={{
          -10.125,4},{-12,4},{-12,-24},{24,-24},{24,-12},{18,-12}}, color={191,0,
          0}));
  connect(infiltrationRate.port_b, airload.heatPort) annotation (Line(
      points={{-18,-4},{-14,-4},{-14,-24},{24,-24},{24,-12},{18,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (building airtightness"),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>January 9, 2020 by Philipp Mehrfeld:<br/>
    Model added to the AixLib library.
  </li>
</ul>
</html>"));
end PartialRoom;
