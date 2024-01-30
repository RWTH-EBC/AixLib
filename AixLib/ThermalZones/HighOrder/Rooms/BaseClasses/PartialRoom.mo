within AixLib.ThermalZones.HighOrder.Rooms.BaseClasses;
partial model PartialRoom "Partial model with base component that are necessary for all HOM rooms"

  extends PartialRoomParams;
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations(redeclare package
      Medium = Media.Air,
      final T_start=T0_air);

  // Air volume of room
  parameter Modelica.Units.SI.Volume room_V
    annotation (Dialog(group="Air volume of room"));
  parameter Integer nPorts=0 "Number of fluid ports"
    annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));
  parameter Boolean use_C_flow=false
    "Set to true to enable trace substances in the rooms air"
    annotation (Dialog(group="Trace Substances"));
  parameter Boolean use_moisture_balance=false
    "Set to true to enable moisture gain balance in the rooms air"
    annotation (Dialog(group="Moist Air"));
  parameter Boolean use_C_flow_input=true "Set to true to use an input connector for the trace substances. False indicates internal calculation" annotation(Dialog(enable=use_C_flow, group="Trace Substances"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermRoom annotation (Placement(
        transformation(extent={{-20,12},{0,32}}), iconTransformation(extent={{-24,
            -10},{-4,10}})));
  Utilities.Interfaces.RadPort starRoom annotation (Placement(transformation(
          extent={{2,12},{22,32}}), iconTransformation(extent={{6,-10},{26,10}})));
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

  Utilities.Interfaces.Adaptors.ConvRadToCombPort thermStar_Demux annotation (Placement(
        transformation(
        extent={{-6,5},{6,-5}},
        rotation=90,
        origin={-7,-2})));
  Components.MoistAir.VarMoistAirExchange
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

  Fluid.MixingVolumes.MixingVolumeMoistAir airload(
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
    annotation (Placement(transformation(extent={{18,-22},{-2,-2}})));
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
  Modelica.Blocks.Interfaces.RealInput ventHum if use_moisture_balance
    "absolute humidity of ventilation air" annotation (Placement(transformation(
          extent={{-122,-48},{-100,-26}}), iconTransformation(extent={{-120,-46},
            {-100,-26}})));
  Modelica.Blocks.Interfaces.RealInput QLat_flow(final unit="W")
 if use_moisture_balance
    "Latent heat gains for the room"
    annotation (Placement(transformation(extent={{-124,-68},{-100,-44}}),
        iconTransformation(extent={{-120,-80},{-100,-60}})));
protected
  constant Modelica.Units.SI.SpecificEnergy h_fg=
      AixLib.Media.Air.enthalpyOfCondensingGas(273.15 + 37)
    "Latent heat of water vapor";
  Modelica.Blocks.Math.MultiSum sumQLat_flow(nu=2)
                                             if use_moisture_balance
    "sum of latent heat flows"
    annotation (Placement(transformation(extent={{76,-40},{70,-34}})));
  Modelica.Blocks.Math.Gain mWat_flow(
    final k(unit="kg/J") = 1/h_fg,
    u(final unit="W"),
    y(final unit="kg/s")) if use_moisture_balance
    "Water flow rate due to latent heat gain"
    annotation (Placement(transformation(extent={{56,-32},{48,-24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow conQLat_flow
 if use_moisture_balance
    "Converter for latent heat flow rate"
    annotation (Placement(transformation(extent={{58,-52},{46,-40}})));
  Modelica.Blocks.Interfaces.RealOutput hum_internal
    "internal humidity (used for case with no moisture balance";
  Modelica.Blocks.Interfaces.RealOutput mWat_flow_internal
    "internal mass flow rate of water vapor (used for case with no moisture balance)";
equation
  hum_internal = 0;
  mWat_flow_internal = 0;

  connect(QLat_flow, sumQLat_flow.u[2]) annotation (Line(
      points={{-112,-56},{80,-56},{80,-38.05},{76,-38.05}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(NaturalVentilation.QLat_flow, sumQLat_flow.u[1]) annotation (Line(
      points={{-21.76,-21.72},{-16,-21.72},{-16,-50},{80,-50},{80,-35.95},{76,-35.95}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(airload.X_w, NaturalVentilation.HumOut) annotation (Line(
      points={{-4,-16},{-14,-16},{-14,-14.88},{-22.6,-14.88}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(NaturalVentilation.HumIn, ventHum) annotation (Line(
      points={{-33.4,-21},{-62,-21},{-62,-22},{-74,-22},{-74,-37},{-111,-37}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(conQLat_flow.port, airload.heatPort) annotation (Line(
      points={{46,-46},{24,-46},{24,-12},{18,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(thermRoom,thermStar_Demux.portConv) annotation (Line(points={{-10,22},
          {-10,4},{-10.125,4}},                                                                                   color={191,0,0}));
  connect(starRoom,thermStar_Demux.portRad) annotation (Line(
      points={{12,22},{12,4},{-3.875,4}},
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
          {-70,80},{-70,-20},{-64,-20},{-64,-21.84},{-33.4,-21.84}},                                                                            color={0,0,127}));
  connect(airload.ports, ports) annotation (Line(
      points={{8,-22},{8,-82},{0,-82},{0,-100},{-3,-100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Tair.port, airload.heatPort)
    annotation (Line(points={{24,1},{24,-12},{18,-12}}, color={191,0,0}));
  connect(dynamicVentilation.port_inside, airload.heatPort) annotation (Line(
      points={{-18.12,-32},{24,-32},{24,-12},{18,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(NaturalVentilation.port_b, airload.heatPort) annotation (Line(points={
          {-22,-18},{-20,-18},{-20,-24},{24,-24},{24,-12},{18,-12}}, color={191,
          0,0}));
  connect(thermStar_Demux.portConv, airload.heatPort) annotation (Line(points={{-10.125,
          4},{-12,4},{-12,-24},{24,-24},{24,-12},{18,-12}},         color={191,0,
          0}));
  connect(infiltrationRate.port_b, airload.heatPort) annotation (Line(
      points={{-18,-4},{-14,-4},{-14,-24},{24,-24},{24,-12},{18,-12}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(airload.C_flow, C_flow) annotation (Line(points={{20,-18},{34,-18},{34,
          -42},{-80,-42},{-80,18},{-112,18}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sumQLat_flow.y, mWat_flow.u) annotation (Line(
      points={{69.49,-37},{64,-37},{64,-28},{56.8,-28}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sumQLat_flow.y, conQLat_flow.Q_flow) annotation (Line(
      points={{69.49,-37},{64,-37},{64,-46},{58,-46}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(mWat_flow.y, airload.mWat_flow) annotation (Line(
      points={{47.6,-28},{36,-28},{36,-10},{26,-10},{26,-4},{20,-4}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(NaturalVentilation.HumIn, hum_internal);
  connect(airload.mWat_flow, mWat_flow_internal);
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (building airtightness"),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>January 9, 2020 by Philipp Mehrfeld:<br/>
    Model added to the AixLib library.
  </li>
  <li>February, 2022 by Fabian Wüllhorst and Martin Kremer:<br/>
    Changed airLoad-model to mxing volume to use media model. Added
    possibility to analyse substance and water vapor balance (see issue
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1123\">#1123</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This model provides a basic configuration of an air load, a
  replaceable parameter set for wall paramters and air exchange models
  that can be used to build up individual High-Order-Models for rooms.
</p>
<p>
  The air load is modelled with a mixing volume providing a media model
  for the air inside the room and the energy and mass balances. It is
  possible to consider the water vapor balance for the indoor air
  humidity such as a substance balance to consider e.g.
  CO2-concentration in the room. For the default configuration
  substance and water vapor balance will not be considered.
</p>
<p>
  <b>Note:</b> While the air exchange model for ventilated air provides
  also the water vapor exchange rate, the infiltration model and
  dynamic ventilation model only provide the thermal balance. Hence, no
  water vapor will be exchanged due to the infiltration or the dynamic
  ventilation model.
</p>
<p>
  <b>Note 2:</b> The dynamic ventilation model provides a control
  algorithm defining an air exchange due to natural ventilation
  depending on the room and outdoor air temperature. <b>It does not
  provide any physical background, but assumes an air exchange rate
  that can be set by the user.</b> This model should be used with
  caution. The setting of its parameters may have high influence on the
  simulation results.
</p>
</html>"));
end PartialRoom;
