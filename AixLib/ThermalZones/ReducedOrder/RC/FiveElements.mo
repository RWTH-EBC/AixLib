within AixLib.ThermalZones.ReducedOrder.RC;
model FiveElements
  "Thermal Zone with five elements for exterior walls, interior walls, floor plate, roof, and neighboured zone borders\""
  extends FourElements(AArray=cat(1, {ATotExt,ATotWin,AInt,AFloor,ARoof}, ANZ));

  parameter Integer nNZs(min = 1)
    "Number of neighboured zone borders to consider"
    annotation (Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.Area ANZ[nNZs] "Area of neighboured zone borders"
    annotation (Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConNZ[nNZs]
    "Convective coefficient of heat transfer of neighboured zone borders (indoor)"
    annotation (Dialog(group="Zone borders"));
  parameter Integer nNZ(min = 1) "Number of RC-elements of neighboured zone borders"
    annotation(Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.ThermalResistance RNZ[nNZs, nNZ](each min=Modelica.Constants.small)
    "Vector of resistances of neighboured zone borders, from inside to outside"
    annotation (Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.ThermalResistance RNZRem[nNZs](each min=Modelica.Constants.small)
    "Vector of resistances of remaining resistor RNZRem between capacity n and outside"
    annotation (Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.HeatCapacity CNZ[nNZs, nNZ](each min=Modelica.Constants.small)
    "Vector of heat capacities of neighboured zone borders, from inside to outside"
    annotation (Dialog(group="Zone borders"));
  parameter Boolean indoorPortNZ = false
    "Additional heat port at indoor surface of neighboured zone borders"
    annotation(Dialog(group="Zone borders"),choices(checkBox = true));
  parameter Integer otherNZIndex[nNZs]
    "index of the zone each neighboured zone border is adjacent to"
    annotation (Dialog(group="Zone borders"));
  parameter Integer thisZoneIndex "index of this zone"
    annotation (Dialog(group="Zone borders"));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a nz[nNZs] if ATotNZ > 0
    "Ambient port for neighboured zone borders" annotation (Placement(
        transformation(extent={{205,168},{225,188}}), iconTransformation(extent={{175,170},
            {195,190}})));
  BaseClasses.ExteriorWallContainer nzRC[nNZs](
    final RExt=RNZ,
    final RExtRem=RNZRem,
    final CExt=CNZ,
    final pass_through={thisZoneIndex > otherNZIndex[i] for i in 1:nNZs},
    each final n=nNZ,
    each final T_start=T_start) if ATotNZ > 0 "RC-element for NZ borders"
    annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=90,
        origin={102,155})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a nzIndoorSurface[nNZs] if
     indoorPortNZ "Auxiliary port at indoor surface of NZ borders"
    annotation (Placement(transformation(extent={{124,-190},{144,-170}}),
        iconTransformation(extent={{-50,-190},{-30,-170}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor[nNZs] if
    ATotNZ > 0
    "measures radiative heat flow to NZ border surfaces" annotation (Placement(
        transformation(
        extent={{8,8},{-8,-8}},
        rotation=0,
        origin={138,148})));
  Modelica.Blocks.Interfaces.RealOutput qRad[nNZs](each final quantity="RadiantEnergyFluenceRate",
      each final unit="W/m2") if ATotNZ > 0
    "specific radiation to neighboured zone border surfaces"
    annotation (Placement(transformation(extent={{240,50},{260,70}})));

protected
  parameter Modelica.Units.SI.Area ATotNZ=sum(ANZ)
    "Sum of neighboured zone border areas";
  Modelica.Thermal.HeatTransfer.Components.Convection convNZ[nNZs] if
     ATotNZ > 0 "Convective heat transfer of neighboured zone borders" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={102,124})));
  Modelica.Blocks.Sources.Constant hConNZ_const[nNZs](final k=ANZ .* hConNZ) if
       ATotNZ > 0 "Coefficient of convective heat transfer for neighbourd zone borders"
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={134,124})));
  Modelica.Blocks.Math.Gain specificRadFlow[nNZs](
    final k(each unit="1/m2") = fill(1,nNZs)./{if A > 0 then A else 1 for A in ANZ},
    u(each final unit="W"),
    y(each final unit="W/m2")) if ATotNZ > 0
    "calculates specific radiative heat flow to  neighboured zone borders"
    annotation (Placement(transformation(extent={{166,116},{176,126}})));

  // connections
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resNZNZ[sum({i for
    i in 1:(nNZs - 1)})](final G=BaseClasses.GSurfSurf(ANZ, hRad)) if
       ATotNZ > 0 and nNZs > 1
    "Resistor between different neighboured zone border surfaces" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={170,148},
        rotation=-90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resExtWallNZ[
    nNZs](final G={min(ATotExt, ANZ[j])*hRad for j in 1:nNZs}, each dT(start=0)) if
      ATotExt > 0 and ATotNZ > 0
    "Resistor between exterior walls and neighboured zone borders" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,66},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resWinNZ[nNZs](
     final G={min(ATotWin, ANZ[j])*hRad for j in 1:nNZs}, each dT(start=0)) if
       ATotNZ > 0 and ATotWin > 0 "Resistor between neighboured zone borders and windows"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={106,66},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resIntNZ[nNZs](
      final G={min(AInt, ANZ[i])*hRad for i in 1:nNZs}, each dT(start=0)) if
       AInt > 0 and ATotNZ > 0
    "Resistor between interior walls and neighboured zone borders" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={132,66})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resFloorNZ[nNZs](
      final G={min(ANZ[i], AFloor)*hRad for i in 1:nNZs}, each dT(start=0)) if
       ATotNZ > 0 and AFloor > 0
    "Resistor between floor plate and neighboured zone borders" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={158,66})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resRoofNZ[nNZs](
      final G={min(ARoof, ANZ[j])*hRad for j in 1:nNZs}, each dT(start=0)) if
      ARoof > 0 and ATotNZ > 0 "Resistor between roofs and neighboured zone borders"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={60,168},
        rotation=0)));

equation
  // connect NZ borders
  if ATotNZ > 0 then
    for i in 1:nNZs loop
      if ANZ[i] > 0 then
        connect(nz[i], nzRC[i].port_b) annotation (Line(points={{215,178},{216,178},
                {216,174},{102,174},{102,165},{103,165}},
                                             color={191,0,0}));
        connect(convNZ[i].solid, nzRC[i].port_a) annotation (Line(points={{102,134},{102,140},
          {102,145},{103,145}}, color={191,0,0}));
        connect(convNZ[i].Gc, hConNZ_const[i].y)
          annotation (Line(points={{112,124},{128.5,124}}, color={0,0,127}));
        connect(convNZ[i].fluid, senTAir.port) annotation (Line(points={{102,114},
                {102,98},{66,98},{66,0},{80,0}},
                                            color={191,0,0}));
        connect(heatFlowSensor[i].port_b, convNZ[i].solid) annotation (Line(points={{130,
                148},{120,148},{120,140},{102,140},{102,134}}, color={191,0,0}));
        connect(nzIndoorSurface[i], heatFlowSensor[i].port_a) annotation (Line(points={{134,
            -180},{134,-166},{114,-166},{114,44},{118,44},{118,100},{154,100},{154,
            148},{146,148}}, color={191,0,0}));
      end if;
    end for;
    for i in 2:nNZs loop
      for j in 1:(i-1) loop
        if ANZ[i] > 0 and ANZ[j] > 0 then
          if i==2 then
            connect(resNZNZ[1].port_a, heatFlowSensor[i].port_a) annotation (Line(points={{170,158},
                    {170,162},{152,162},{152,148},{146,148}},           color={191,0,0}));
            connect(resNZNZ[1].port_b, heatFlowSensor[j].port_a) annotation (Line(points={{170,138},
                    {170,134},{152,134},{152,148},{146,148}},           color={191,0,0}));
          else
            connect(resNZNZ[sum({k for k in 1:(i-2)}) + j].port_a, heatFlowSensor[i].port_a) annotation (Line(points={{170,158},
                    {170,162},{152,162},{152,148},{146,148}},           color={191,0,0}));
            connect(resNZNZ[sum({k for k in 1:(i-2)}) + j].port_b, heatFlowSensor[j].port_a) annotation (Line(points={{170,138},
                    {170,134},{152,134},{152,148},{146,148}},           color={191,0,0}));
          end if;
        end if;
      end for;
    end for;
  end if;

  if ATotExt > 0 then
    for j in 1:nNZs loop
      if ANZ[j] > 0 then
        connect(heatFlowSensor[j].port_a, resExtWallNZ[j].port_b) annotation (Line(
              points={{146,148},{154,148},{154,88},{80,88},{80,76}}, color={191,0,0}));
        connect(resExtWallNZ[j].port_a, convExtWall.solid) annotation (Line(points={{80,56},
                {80,44},{-62,44},{-62,-16},{-118,-16},{-118,-40},{-114,-40}},
              color={191,0,0}));
      end if;
    end for;
  end if;

  if ATotWin > 0 then
    for j in 1:nNZs loop
      if ANZ[j] > 0 then
        connect(resWinNZ[j].port_b, heatFlowSensor[j].port_a) annotation (Line(points={{106,76},
                {106,88},{154,88},{154,148},{146,148}},          color={191,0,0}));
        connect(resWinNZ[j].port_a, convWin.solid) annotation (Line(points={{106,56},
                {106,52},{60,52},{60,84},{-120,84},{-120,40},{-116,40}}, color={191,0,
                0}));
      end if;
    end for;
  end if;

  if AInt > 0 then
    for i in 1:nNZs loop
      if ANZ[i] > 0 then
        connect(resIntNZ[i].port_b, heatFlowSensor[i].port_a) annotation (Line(points={{132,76},
                {132,88},{154,88},{154,148},{146,148}},     color={191,0,0}));
        connect(resIntNZ[i].port_a, convIntWall.solid) annotation (Line(points={{132,56},
                {132,-2},{152,-2},{152,-40},{148,-40}}, color={191,0,0}));
      end if;
    end for;
  end if;

  if AFloor > 0 then
    for i in 1:nNZs loop
      if ANZ[i] > 0 then
        connect(resFloorNZ[i].port_b, heatFlowSensor[i].port_a) annotation (Line(points={{158,76},
                {158,88},{154,88},{154,148},{146,148}},     color={191,0,0}));
        connect(resFloorNZ[i].port_a, convFloor.solid) annotation (Line(points={{158,56},
                {158,26},{234,26},{234,-150},{26,-150},{26,-136},{-12,-136},{
                -12,-124}},
              color={191,0,0}));
      end if;
    end for;
  end if;

  if ARoof > 0 then
    for j in 1:nNZs loop
      if ANZ[j] > 0 then
        connect(resRoofNZ[j].port_b, heatFlowSensor[j].port_a) annotation (Line(
              points={{70,168},{72,168},{72,170},{154,170},{154,148},{146,148}},
              color={191,0,0}));
        connect(resRoofNZ[j].port_a, convRoof.solid) annotation (Line(points={{50,168},
                {8,168},{8,136},{-12,136},{-12,130}}, color={191,0,0}));
      end if;
    end for;
  end if;

  // internal gains splitter connections
  for i in 6:size(AArray, 1) loop
    if AArray[i] > 0 then
      connect(thermSplitterIntGains.portOut[sum({if A > 0 then 1 else 0 for A in AArray[1:i]})], heatFlowSensor[i-5].port_a)
        annotation (Line(points={{190,86},{178,86},{178,108},{154,108},{154,148},
              {146,148}},
                    color={191,0,0}));
      connect(thermSplitterSolRad.portOut[sum({if A > 0 then 1 else 0 for A in AArray[1:i]})], heatFlowSensor[i-5].port_a) annotation (
         Line(points={{-122,146},{-116,146},{-116,88},{154,88},{154,148},{146,148}},
            color={191,0,0}));
    end if;
  end for;

  connect(heatFlowSensor.Q_flow, specificRadFlow.u) annotation (Line(points={{138,
          156.8},{138,160},{150,160},{150,121},{165,121}},
                                                         color={0,0,127}));
  connect(specificRadFlow.y, qRad) annotation (Line(points={{176.5,121},{196,121},
          {196,60},{250,60}}, color={0,0,127}));
  annotation (defaultComponentName="theZon",
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-240,
  -180},{240,180}}), graphics={
  Polygon(
    points={{74,168},{188,168},{188,106},{98,106},{96,106},{74,106},{74,168}},
    lineColor={0,0,255},
    smooth=Smooth.None,
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{108,118},{146,104}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="NZ borders")}),
    Icon(coordinateSystem(preserveAspectRatio=false,
    extent={{-240,-180},{240,180}}),
  graphics={Rectangle(
  extent={{-40,50},{28,-44}},
  pattern=LinePattern.None,
  fillColor={230,230,230},
  fillPattern=FillPattern.Solid), Text(
  extent={{-60,60},{64,-64}},
  textColor={0,0,0},
  textString="5")}),
  Documentation(revisions="<html>
 <ul>
 <li>
 April 20, 2023, by Philip Groesdonk:<br/>
 First Implementation. This is for AixLib issue
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1080\">#1080</a>.
 </li>
 </ul>
 </html>",  info="<html>
   <p>
   This model adds another element for borders to neighborded zones. These
   elements are not represented in the reduced-order models with less components.
   For each neighboured zone border, one extra element is produced, which makes
   this model, in fact, be able to have a much higher number of elements (4 for
   the other elements plus the number of zone borders <code>nNZs</code>), but the
   elements bordering zones with a lower index in 
   <code>otherNZIndex[nNZs]</code> than this zone's index <code>thisZoneIndex</code> 
   are ignored here and calculated in the other zone's ROM.
   Ths implementation increases calculation times and calculation complexity -
   also because the neighboured zones are directly connected via heat flow 
   ports to ensure no energy is produced out of or lost to nowhere.
   The neighboured zone borders are parameterized via the length of the RC-chain
   <code>nNZ</code>,
   the vector of capacities <code>CNZ[nNZs, nNZ]</code>, the vector of resistances
   <code>RNZ[nNZs, nNZ]</code> and the remaining resistances <code>RNZRem[nNZs]</code>.
   </p>
   <p>
   The image below shows the RC-network of this model. In the image, dashed 
   lines represent the possibly multiple borders to neighboured zones (= array 
   of borders). Dotted lines represent the radiation resistances between each 
   pair of surfaces facing the indoor, which are not explicitly shown here due 
   to the high amount of resistances. See the documentation of 
   <code>FourElement</code> for a better visualisation.
   </p>
   <p align=\"center\">
   <img src=\"modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/RC/FiveElements.png\" alt=\"image\"/>
   </p>
   </html>"));
end FiveElements;
