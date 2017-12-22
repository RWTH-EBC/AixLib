within AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses;
partial model PartialThermalZone "Partial model for thermal zone modelsl"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter DataBase.ThermalZones.ZoneBaseRecord zoneParam
    "Choose setup for this zone" annotation (choicesAllMatching=true);
  parameter Integer nPorts=0
    "Number of fluid ports"
    annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));
  Modelica.Blocks.Interfaces.RealInput ventRate(
    final quantity="VolumeFlowRate",
    final unit="1/h") if ATot > 0 or zoneParam.VAir > 0
    "Ventilation and infiltration rate"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-100}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-70,-84})));
  Modelica.Blocks.Interfaces.RealInput ventTemp(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) if ATot > 0 or zoneParam.VAir > 0
    "Ventilation and infiltration temperature"
    annotation (Placement(
        transformation(extent={{-120,-60},{-80,-20}}), iconTransformation(
          extent={{-126,-52},{-100,-26}})));
  Modelica.Blocks.Interfaces.RealInput intGains[3]
    "Input profiles for internal gains persons, machines, light"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={80,-100}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={80,-84})));
  Modelica.Blocks.Interfaces.RealOutput TAir(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ATot > 0 or zoneParam.VAir > 0
    "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,46},{120,66}}),
        iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput TRad(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ATot > 0
    "Mean indoor radiation temperature"
    annotation (Placement(transformation(
          extent={{100,28},{120,48}}), iconTransformation(extent={{100,28},{120,
            48}})));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-117,18},{-83,50}}), iconTransformation(
    extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
    redeclare each final package Medium = Medium)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{-49,-106},{49,-82}}),
        iconTransformation(extent={{-47,-84},{47,-60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv if
    ATot > 0 or zoneParam.VAir > 0
    "Convective internal gains"
    annotation (Placement(transformation(extent={{94,-12},{114,8}}),
                              iconTransformation(extent={{90,-60},{110,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad if ATot > 0
    "Radiative internal gains"
    annotation (Placement(transformation(extent={{94,8},{114,28}}),
                            iconTransformation(extent={{90,-20},{110,0}})));
  RC.FourElements ROM(
    final nPorts=nPorts,
    redeclare final package Medium = Medium,
    final VAir=if zoneParam.withAirCap then zoneParam.VAir else 0.0,
    final alphaRad=zoneParam.alphaRad,
    final nOrientations=zoneParam.nOrientations,
    final AWin=zoneParam.AWin,
    final ATransparent=zoneParam.ATransparent,
    final alphaWin=zoneParam.alphaWin,
    final RWin=zoneParam.RWin,
    final gWin=zoneParam.gWin,
    final ratioWinConRad=zoneParam.ratioWinConRad,
    final AExt=zoneParam.AExt,
    final alphaExt=zoneParam.alphaExt,
    final nExt=zoneParam.nExt,
    final RExt=zoneParam.RExt,
    final RExtRem=zoneParam.RExtRem,
    final CExt=zoneParam.CExt,
    final AInt=zoneParam.AInt,
    final alphaInt=zoneParam.alphaInt,
    final nInt=zoneParam.nInt,
    final RInt=zoneParam.RInt,
    final CInt=zoneParam.CInt,
    final AFloor=zoneParam.AFloor,
    final alphaFloor=zoneParam.alphaFloor,
    final nFloor=zoneParam.nFloor,
    final RFloor=zoneParam.RFloor,
    final RFloorRem=zoneParam.RFloorRem,
    final CFloor=zoneParam.CFloor,
    final ARoof=zoneParam.ARoof,
    final alphaRoof=zoneParam.alphaRoof,
    final nRoof=zoneParam.nRoof,
    final RRoof=zoneParam.RRoof,
    final RRoofRem=zoneParam.RRoofRem,
    final CRoof=zoneParam.CRoof,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p_start,
    final X_start=X_start,
    final T_start=T_start,
    final C_start=C_start,
    final C_nominal=C_nominal,
    final mSenFac=mSenFac)
    "RC calculation core"
    annotation (Placement(transformation(extent={{38,28},{86,64}})));

protected
  parameter Real ATot = (sum(zoneParam.AExt) + sum(zoneParam.AWin) +
  zoneParam.AInt + zoneParam.ARoof+zoneParam.AFloor);

equation
  connect(ROM.TAir, TAir) annotation (Line(points={{87,62},{98,62},{98,56},{110,
          56}}, color={0,0,127}));
  connect(ROM.ports, ports) annotation (Line(points={{77,28.05},{77,-4},{48,-4},
          {48,-44},{0,-44},{0,-94}},            color={0,127,255}));
  connect(ROM.intGainsConv, intGainsConv) annotation (Line(points={{86,50},{92,50},
          {92,-2},{104,-2}},   color={191,0,0}));
  connect(ROM.TRad, TRad) annotation (Line(points={{87,58},{96,58},{96,40},{96,38},
          {110,38}}, color={0,0,127}));
  connect(TRad, TRad)
    annotation (Line(points={{110,38},{110,38}}, color={0,0,127}));
  connect(ROM.intGainsRad, intGainsRad) annotation (Line(points={{86,54},{94,54},
          {94,18},{104,18}},
                           color={191,0,0}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,  extent={{-100,-100},
            {100,100}}),graphics={Text(extent={{
              -80,114},{92,64}},lineColor=
              {0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-100,-72},{100,70}},
          lineColor={95,95,95},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,32},{-18,-26}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,32},{-10,38}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{18,32},{68,-26}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,32},{76,38}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p>Partial for <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a> models. It defines connectors and a <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a> model. Most connectors are conditional to allow conditional modifications according to parameters or to pass-through conditional removements in <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.</p>
<h4>Typical use and important parameters</h4>
<p>All parameters are collected in one <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> record. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.</p>
</html>",  revisions="<html>
 <ul>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation based on Annex60 and MSL models.
  </li>
  <li>
  March, 2012, by Moritz Lauster:<br/>
  First implementation.
  </li>
 </ul>
 </html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
  Rectangle(
    extent={{36,68},{88,28}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid)}));
end PartialThermalZone;
