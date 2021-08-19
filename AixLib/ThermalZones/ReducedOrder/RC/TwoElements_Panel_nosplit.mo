within AixLib.ThermalZones.ReducedOrder.RC;
model TwoElements_Panel_nosplit
  "Thermal Zone with two elements for exterior and interior walls"
  extends OneElement(AArray={ATotExt,ATotWin,AInt});

  parameter Modelica.SIunits.Area AInt "Area of interior walls"
    annotation(Dialog(group="Interior walls"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConIntHeat
    "Convective coefficient of heat transfer of interior walls (indoor)"
    annotation(Dialog(group="Interior walls"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConIntCool
    "Convective coefficient of heat transfer of interior walls (indoor)"
    annotation(Dialog(group="Interior walls"));
  parameter Integer nInt(min = 1) "Number of RC-elements of interior walls"
    annotation(Dialog(group="Interior walls"));
  parameter Modelica.SIunits.ThermalResistance RInt[nInt](
    each min=Modelica.Constants.small)
    "Vector of resistances of interior walls, from port to center"
    annotation(Dialog(group="Interior walls"));
  parameter Modelica.SIunits.HeatCapacity CInt[nInt](
    each min=Modelica.Constants.small)
    "Vector of heat capacities of interior walls, from port to center"
    annotation(Dialog(group="Interior walls"));
  parameter Boolean indoorPortIntWalls = false
    "Additional heat port at indoor surface of interior walls"
    annotation(Dialog(group="Interior walls"),choices(checkBox = true));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intWallIndoorSurface if
    indoorPortIntWalls "Auxiliary port at indoor surface of interior walls"
    annotation (Placement(transformation(extent={{-130,-190},{-110,-170}}),
    iconTransformation(extent={{-130,-190},{-110,-170}})));
  BaseClasses.InteriorWall intWallRC(
    final n=nInt,
    final RInt=RInt,
    final CInt=CInt,
    final T_start=T_start) if AInt > 0 "RC-element for interior walls"
    annotation (Placement(transformation(extent={{182,-50},{202,-28}})));

  // Integration of VDI 6007-1 Anhang C1 panel heating and tabs into Two Element

  // Booleans not currently used, future implementation similar to other auxiliary ports
  parameter Boolean corePortExtWalls = false
    "Additional heat port at core of exterior walls"
    annotation(Dialog(group="Exterior walls"),choices(checkBox = true));
  parameter Boolean corePortIntWalls = false
    "Additional heat port at core of interior walls"
    annotation(Dialog(group="Interior walls"),choices(checkBox = true));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a tabsExtWalls if ATotExt
     > 0 "Q_HK_BT_AW, Auxiliary port at core of exterior walls"
    annotation (Placement(transformation(extent={{178,-190},{198,-170}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a tabsIntWalls if AInt > 0
    "Q_HK_BT_IW, Auxiliary port at core of interior walls"
    annotation (Placement(transformation(extent={{230,-30},{250,-10}})));
  // Can be connected to intGainsRad in the future instead
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a hkRad if ATot > 0
    "Q_HK_str, Auxiliary port at indoor surface of windows, exterior and interior walls"
    annotation (Placement(transformation(extent={{230,-190},{250,-170}})));
  // Can be connected to intWallIndoorSurface in the future instead, !change conditional statements
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a fhkExtWalls if ATot > 0
    "Q_HK_FO_AW, Auxiliary port at indoor surface of exterior walls"
    annotation (Placement(transformation(extent={{230,-164},{250,-144}})));
  // Can be connected to intGainsConv in the future instead
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a hkConv if ATot > 0 or
    VAir > 0 "Q_HK_kon, Auxiliary port at indoor air volume"
    annotation (Placement(transformation(extent={{230,-140},{250,-120}})));
  // Can be connected to extWallIndoorSurface in the future instead, !change conditional statements
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a fhkIntWalls if AInt > 0
    "Q_HK_FO_IW, Auxiliary port at indoor surface of interior walls"
    annotation (Placement(transformation(extent={{230,-116},{250,-96}})));

  // Thermal splitter for radiative heat flow, is equal to thermal splitter for intgains
  // can be deleted if Q_HK_str is connected to intGainsRad

  BaseClasses.ThermSplitter thermSplitterHkRad(
    final splitFactor=splitFactor,
    final nOut=dimension,
    final nIn=1) if ATot > 0 "Splits incoming heat flow from radiative heating/cooling into separate flows for each wall element,
    weighted by their area"
    annotation (Placement(transformation(extent={{226,-190},{206,-170}})));

  // switch heat transfer coefficients for panel heating and cooling
  Modelica.Blocks.Logical.Switch switch_hConInt if AInt > 0
    "switches between of convective heat transfer coefficient for heating or cooling"
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={138,-58})));
protected
  Modelica.Thermal.HeatTransfer.Components.Convection convIntWall(dT(start=0)) if
                                                                     AInt > 0
    "Convective heat transfer of interior walls"
    annotation (Placement(transformation(extent={{148,-30},{128,-50}})));
  Modelica.Blocks.Sources.Constant hConIntWall_Heat(k=AInt*hConIntHeat) if
                                                                  AInt > 0
    "Coefficient of convective heat transfer for interior walls" annotation (
      Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=-90,
        origin={126,-75})));
  Modelica.Blocks.Sources.Constant hConIntWall_Cool(k=AInt*hConIntCool) if
                                                                  AInt > 0
    "Coefficient of convective heat transfer for interior walls" annotation (
      Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=-90,
        origin={150,-75})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resExtWallIntWall(
    final G=min(ATotExt, AInt)*hRad, dT(start=0)) if
                                             ATotExt > 0 and AInt > 0
    "Resistor between exterior walls and interior walls"
    annotation (Placement(transformation(extent={{138,-116},{158,-96}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resIntWallWin(
    final G=min(ATotWin, AInt)*hRad, dT(start=0)) if
                                             ATotWin > 0 and AInt > 0
    "Resistor between interior walls and windows"
    annotation (Placement(transformation(extent={{74,-118},{94,-98}})));
equation
  connect(resExtWallIntWall.port_a, convExtWall.solid)
    annotation (Line(
    points={{138,-106},{110,-106},{110,-86},{-144,-86},{-144,-40},{-114,-40}},
    color={191,0,0},
    smooth=Smooth.None));
  connect(convIntWall.solid, intWallRC.port_a)
    annotation (Line(
    points={{148,-40},{182,-40}},
    color={191,0,0},
    smooth=Smooth.None));
  connect(intWallRC.port_a, resExtWallIntWall.port_b)
    annotation (Line(
    points={{182,-40},{168,-40},{168,-106},{158,-106}},
    color={191,0,0},
    smooth=Smooth.None));
  if not ATotExt > 0 and not ATotWin > 0 and AInt > 0 then
    connect(thermSplitterIntGains.portOut[1], intWallRC.port_a);
    connect(thermSplitterSolRad.portOut[1], intWallRC.port_a);
  elseif ATotExt > 0 and not ATotWin > 0 and AInt > 0 or not ATotExt > 0 and ATotWin > 0
    and AInt > 0 then
    connect(thermSplitterIntGains.portOut[2], intWallRC.port_a);
    connect(thermSplitterSolRad.portOut[2], intWallRC.port_a);
  elseif ATotExt > 0 and ATotWin > 0 and AInt > 0 then
    connect(thermSplitterIntGains.portOut[3], intWallRC.port_a) annotation (Line(
      points={{190,86},{166,86},{166,-40},{182,-40}},
      color={191,0,0},
      smooth=Smooth.None));
    connect(thermSplitterSolRad.portOut[3], intWallRC.port_a) annotation (
      Line(
      points={{-122,146},{-58,146},{-58,96},{160,96},{160,-40},{182,-40}},
      color={191,0,0},
      smooth=Smooth.None));
  end if;
  connect(resIntWallWin.port_b, intWallRC.port_a)
    annotation (Line(
    points={{94,-108},{118,-108},{118,-88},{168,-88},{168,-40},{182,-40}},
    color={191,0,0},
    smooth=Smooth.None));
  connect(resIntWallWin.port_a, convWin.solid)
    annotation (Line(
    points={{74,-108},{68,-108},{68,-94},{-46,-94},{-46,20},{-146,20},{-146,40},
    {-116,40}},
    color={191,0,0},
    smooth=Smooth.None));
  connect(intWallRC.port_a, intWallIndoorSurface)
    annotation (Line(points={{182,-40},{168,-40},{168,-80},{-120,-80},{-120,
          -180}},
    color={191,0,0}));
  connect(convIntWall.fluid, senTAir.port)
    annotation (Line(points={{128,-40},{66,-40},{66,0},{80,0}},
    color={191,0,0}));
  connect(tabsExtWalls, extWallRC.port_a1) annotation (Line(points={{188,-180},{
          188,-170},{-106,-170},{-106,-76},{-138,-76},{-138,-28},{-168,-28}},
        color={191,0,0}));
  connect(hkConv, senTAir.port) annotation (Line(points={{240,-130},{116,-130},{
          116,-22},{68,-22},{68,0},{80,0}},  color={191,0,0}));
  connect(fhkIntWalls, convIntWall.solid) annotation (Line(points={{240,-106},{
          178,-106},{178,-40},{148,-40}}, color={191,0,0}));
  connect(fhkExtWalls, convExtWall.solid) annotation (Line(points={{240,-154},{54,
          -154},{54,-40},{-114,-40}}, color={191,0,0}));
  connect(tabsIntWalls, intWallRC.port_a1) annotation (Line(points={{240,-20},{
          240,-22},{192,-22},{192,-28}}, color={191,0,0}));
  connect(tabsExtWalls, tabsExtWalls) annotation (Line(points={{188,-180},{188,-180}},
                                  color={191,0,0}));
  connect(hkRad, thermSplitterHkRad.portIn[1])
    annotation (Line(points={{240,-180},{226,-180}}, color={191,0,0}));

  if ATotExt > 0 and ATotWin > 0 and AInt > 0 then
    connect(thermSplitterHkRad.portOut[1], convExtWall.solid) annotation (Line(
          points={{206,-180},{206,-162},{-76,-162},{-76,-40},{-114,-40}}, color=
           {191,0,0}));
    connect(thermSplitterHkRad.portOut[2], convWin.solid) annotation (Line(
          points={{206,-180},{206,-162},{-46,-162},{-46,40},{-116,40}}, color={191,
            0,0}));
    connect(thermSplitterHkRad.portOut[3], convIntWall.solid) annotation (Line(
        points={{206,-180},{206,-108},{178,-108},{178,-40},{148,-40}},
                                                             color={191,0,0}));
  elseif not ATotExt > 0 and ATotWin > 0 and AInt > 0 then
    connect(thermSplitterHkRad.portOut[1], convWin.solid);
    connect(thermSplitterHkRad.portOut[2], convIntWall.solid);
  elseif ATotExt > 0 and not ATotWin > 0 and AInt > 0 then
    connect(thermSplitterHkRad.portOut[1], convExtWall.solid);
    connect(thermSplitterHkRad.portOut[2], convIntWall.solid);
  elseif ATotExt > 0 and ATotWin > 0 and not AInt > 0 then
    connect(thermSplitterHkRad.portOut[1], convExtWall.solid);
    connect(thermSplitterHkRad.portOut[2], convWin.solid);
  elseif ATotExt > 0 and not ATotWin > 0 and not AInt > 0 then
    connect(thermSplitterHkRad.portOut[1], convExtWall.solid);
  elseif not ATotExt > 0 and ATotWin > 0 and not AInt > 0 then
    connect(thermSplitterHkRad.portOut[1], convWin.solid);
  elseif not ATotExt > 0 and not ATotWin > 0 and AInt > 0 then
    connect(thermSplitterHkRad.portOut[1], convIntWall.solid);
  end if;

  connect(heatingOrCooling, switch_hConInt.u2) annotation (Line(points={{-108,-200},
          {12,-200},{12,-62.8},{138,-62.8}}, color={255,0,255}));
  connect(hConIntWall_Heat.y, switch_hConInt.u1) annotation (Line(points={{126,-69.5},
          {128,-69.5},{128,-62.8},{134.8,-62.8}}, color={0,0,127}));
  connect(hConIntWall_Cool.y, switch_hConInt.u3) annotation (Line(points={{150,-69.5},
          {146,-69.5},{146,-70},{142,-70},{142,-62.8},{141.2,-62.8}}, color={0,0,
          127}));
  connect(switch_hConInt.y, convIntWall.Gc) annotation (Line(points={{138,-53.6},
          {137.5,-53.6},{137.5,-50},{138,-50}}, color={0,0,127}));
   annotation (defaultComponentName="theZon",Diagram(coordinateSystem(
  preserveAspectRatio=false, extent={{-240,-180},{240,180}}), graphics={
  Polygon(
    points={{116,-18},{230,-18},{230,-80},{140,-80},{138,-80},{116,-80},{116,
    -18}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{173,-65},{224,-82}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
    textString="Interior Walls")}), Documentation(revisions="<html>
  <ul>
  <li>
  July 11, 2019, by Katharina Brinkmann:<br/>
  Renamed <code>alphaInt</code> to <code>hConInt</code>,
  <code>alphaIntWall</code> to <code>hConIntWall</code>
  </li>
  <li>
  January 25, 2019, by Michael Wetter:<br/>
  Added start value to avoid warning in JModelica.
  </li>
  <li>
  April 18, 2015, by Moritz Lauster:<br/>
  First implementation.
  </li>
  </ul>
</html>",   info="<html>
  <p>This model distinguishes between internal
  thermal masses and exterior walls. While exterior walls contribute to heat
  transfer to the ambient, adiabatic conditions apply to internal masses.
  Parameters for the internal wall element are the length of the RC-chain
  <code>nInt</code>, the vector of the capacities
  <code>CInt[nInt]</code> and the vector of the resistances <code>RInt[nInt]</code>.
  This approach allows considering the dynamic behaviour induced by internal
  heat storage.
  </p>
  <p>
  The image below shows the RC-network of this model.
  </p>
  <p align=\"center\">
  <img src=\"modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/RC/TwoElements.png\" alt=\"image\"/>
  </p>
  </html>"),
  Icon(coordinateSystem(extent={{-240,-180},{240,180}},
  preserveAspectRatio=false),
  graphics={Rectangle(
  extent={{-36,40},{32,-54}},
  fillColor={230,230,230},
  fillPattern=FillPattern.Solid,
  pattern=LinePattern.None), Text(
  extent={{-60,60},{64,-64}},
  lineColor={0,0,0},
  textString="2")}));
end TwoElements_Panel_nosplit;
