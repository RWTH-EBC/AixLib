within AixLib.ThermalZones.HighOrder.Rooms.BaseClasses;
partial model PartialRoom "Partial model with base component that are necessary for all HOM rooms"

  extends PartialRoomParams;

  // Air volume of room
  parameter Modelica.Units.SI.Volume room_V
    annotation (Dialog(group="Air volume of room"));

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
  Components.DryAir.Airload airload(
    final initDynamics=initDynamicsAir,
    final T0=T0_air,
    final rho=denAir,
    final c=cAir,
    final V=room_V)
    annotation (Placement(transformation(extent={{0,-18},{20,2}})));
  Components.DryAir.VarAirExchange
    NaturalVentilation(final V=room_V)
    annotation (Placement(transformation(extent={{-30,-24},{-18,-12}})));
  Components.DryAir.DynamicVentilation
    dynamicVentilation(
    final HeatingLimit=HeatingLimit,
    final Max_VR=Max_VR,
    final Diff_toTempset=Diff_toTempset,
    final Tset=Tset) if withDynamicVentilation
    annotation (Placement(transformation(extent={{-30,-38},{-18,-26}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Tair
    annotation (Placement(transformation(extent={{22,-20},{36,-6}})));

equation
  connect(airload.port,Tair.port) annotation (Line(points={{10,-18},{22,-18},{22,-13}},
                                   color={191,0,0}));
  connect(thermRoom,thermStar_Demux.portConv) annotation (Line(points={{-10,22},{-10,6},{-10.125,6},{-10.125,4}}, color={191,0,0}));
  connect(starRoom,thermStar_Demux.portRad) annotation (Line(
      points={{12,22},{12,4},{-3.875,4},{-3.875,4}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(thermStar_Demux.portConv,airload.port) annotation (Line(points={{-10.125,4},{-10.125,4},{-14,4},{-14,-18},{10,-18}},
                                                                                                               color={191,0,0}));
  connect(infiltrationRate.port_b,airload.port) annotation (Line(
      points={{-18,-4},{-16,-4},{-16,-18},{10,-18}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(infiltrationRate.port_a,thermOutside)  annotation (Line(
      points={{-30,-4},{-66,-4},{-66,100},{-100,100}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(NaturalVentilation.port_a,thermOutside)  annotation (Line(points={{-30,-18},{-68,-18},{-68,100},{-100,100}},
                                             color={191,0,0}));
  connect(NaturalVentilation.port_b,airload.port) annotation (Line(points={{-18,-18},{10,-18}},
                                                               color={191,0,0}));
  connect(dynamicVentilation.port_inside,airload.port) annotation (Line(
      points={{-18.12,-32},{10,-32},{10,-18}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(dynamicVentilation.port_outside,thermOutside)  annotation (Line(
      points={{-30,-32},{-72,-32},{-72,100},{-100,100}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(AirExchangePort, NaturalVentilation.ventRate) annotation (Line(points={{-112,80},{-70,80},{-70,-20},{-50,-20},{-50,-21.84},{-29.4,-21.84}},
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
