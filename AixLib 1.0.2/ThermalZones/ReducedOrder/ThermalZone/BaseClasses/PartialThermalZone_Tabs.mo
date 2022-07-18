within AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses;
partial model PartialThermalZone_Tabs
  "Partial model for thermal zone models"
  extends
    AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.BaseThermalZone;

  RC.FourElements_TABS ROM(
    redeclare final package Medium = Medium,
    final use_moisture_balance=use_moisture_balance,
    final use_C_flow=use_C_flow,
    final nPorts=nPorts,
    final VAir=if zoneParam.withAirCap then zoneParam.VAir else 0.0,
    final hRad=zoneParam.hRad,
    final nOrientations=zoneParam.nOrientations,
    final AWin=zoneParam.AWin,
    final ATransparent=zoneParam.ATransparent,
    final hConWin=zoneParam.hConWin,
    final RWin=zoneParam.RWin,
    final gWin=zoneParam.gWin,
    final ratioWinConRad=zoneParam.ratioWinConRad,
    final AExt=zoneParam.AExt,
    final hConExt=zoneParam.hConExt,
    final nExt=zoneParam.nExt,
    final RExt=zoneParam.RExt,
    final RExtRem=zoneParam.RExtRem,
    final CExt=zoneParam.CExt,
    final AInt=zoneParam.AInt,
    final hConInt=zoneParam.hConInt,
    final nInt=zoneParam.nInt,
    final RInt=zoneParam.RInt,
    final CInt=zoneParam.CInt,
    final AFloor=zoneParam.AFloor,
    final hConFloor=zoneParam.hConFloor,
    final nFloor=zoneParam.nFloor,
    final RFloor=zoneParam.RFloor,
    final RFloorRem=zoneParam.RFloorRem,
    final CFloor=zoneParam.CFloor,
    final ARoof=zoneParam.ARoof,
    final hConRoof=zoneParam.hConRoof,
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
    final mSenFac=mSenFac,
    final ATabs=zoneParam.ATabs,
    final TABS_up=zoneParam.TABS_up,
    final TABS_lo=zoneParam.TABS_lo,
    final ATabs_int=zoneParam.ATabs_int,
    final TABS_int_up=zoneParam.TABS_int_up,
    final TABS_int_lo=zoneParam.TABS_int_lo,
    final RExt_tabs=zoneParam.RExt_tabs,
    final RExtRem_tabs=zoneParam.RExtRem_tabs,
    final CExt_tabs=zoneParam.CExt_tabs,
    final RInt_tabs=zoneParam.RInt_tabs,
    final RIntRem_tabs=zoneParam.RIntRem_tabs,
    final CInt_tabs=zoneParam.CInt_tabs,
    final OrientationTabs=zoneParam.OrientationTabs,
    final OrientationTabsInt=zoneParam.OrientationTabsInt) "RC calculation core"
    annotation (Placement(transformation(extent={{38,56},{86,92}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a tabs if zoneParam.ATabs>0
    "Radiative internal gains" annotation (Placement(transformation(extent={{-106,54},
            {-94,66}}),      iconTransformation(extent={{-76,-84},{-56,-64}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a tabs_int if
                                                              zoneParam.ATabs_int>0
    "Radiative internal gains" annotation (Placement(transformation(extent={{-106,44},
            {-94,56}}),     iconTransformation(extent={{-76,-84},{-56,-64}})));
equation
  connect(ROM.TAir, TAir) annotation (Line(points={{87,90},{98,90},{98,80},{110,
          80}}, color={0,0,127}));
  connect(ROM.ports, ports) annotation (Line(points={{77,56.05},{78,56.05},{78,
          52},{58,52},{58,4},{0,4},{0,-96}},    color={0,127,255}));
  connect(ROM.intGainsConv, intGainsConv) annotation (Line(points={{86,78},{92,
          78},{92,20},{104,20}},
                               color={191,0,0}));
  connect(ROM.TRad, TRad) annotation (Line(points={{87,86},{96,86},{96,60},{110,
          60}},      color={0,0,127}));
  connect(ROM.intGainsRad, intGainsRad) annotation (Line(points={{86,82},{94,82},
          {94,40},{104,40}},
                           color={191,0,0}));

  if zoneParam.ATabs > 0 then
    connect(tabs, ROM.tabs) annotation (Line(points={{-100,60},{28,60},{28,75.4},
            {38,75.4}},
                      color={191,0,0}));
  end if;
  if zoneParam.ATabs_int > 0 then
    connect(tabs_int, ROM.tabs_int) annotation (Line(points={{-100,50},{-94,50},
            {-94,60},{28,60},{28,72.6},{38,72.6}},
                      color={191,0,0}));
  end if;
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
          Documentation(info="<html><p>
  Partial for <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  models. It defines connectors and a <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>
  model. Most connectors are conditional to allow conditional
  modifications according to parameters or to pass-through conditional
  removements in <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  All parameters are collected in one <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  record. Further parameters for medium, initialization and dynamics
  originate from <a href=
  \"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
</p>
<ul>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation based on Annex60 and MSL models.
  </li>
  <li>March, 2012, by Moritz Lauster:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
  Rectangle(
    extent={{32,100},{90,52}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid)}));
end PartialThermalZone_Tabs;
