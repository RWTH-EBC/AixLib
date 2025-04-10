within AixLib.ThermalZones.ReducedOrder.RC;
model FiveElements "Thermal Zone with five elements for exterior walls, interior walls, floor plate, roof, and interzonal elements\""
  extends FourElements(AArray=cat(
        1,
        {ATotExt,ATotWin,AInt,AFloor,ARoof},
        AIze));
  parameter Integer nIze(min=1)
    "Number of interzonal elements to consider"                               annotation (
    Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.Area AIze[nIze]
    "Area of interzonal elements"                                          annotation (
    Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIze[nIze]
    "Convective coefficient of heat transfer of interzonal elements (indoor)"                                                                       annotation (
    Dialog(group="Zone borders"));
  parameter Integer nIzeRC(min=1)
    "Number of RC-elements of interzonal elements"                              annotation (
    Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.ThermalResistance RIze[nIze,nIzeRC](each min=
        Modelica.Constants.small)
    "Vector of resistances of interzonal elements, from inside to outside"
    annotation (Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.ThermalResistance RIzeRem[nIze](each min=Modelica.Constants.small)
    "Vector of resistances of remaining resistor RIzeRem between capacity n and outside"                                                                                              annotation (
    Dialog(group="Zone borders"));
  parameter Modelica.Units.SI.HeatCapacity CIze[nIze,nIzeRC](each min=Modelica.Constants.small)
    "Vector of heat capacities of interzonal elements, from inside to outside"
    annotation (Dialog(group="Zone borders"));
  parameter Boolean indPorIze=false
    "Additional heat port at indoor surface of interzonal elements"                                      annotation (
    Dialog(group="Zone borders"),
    choices(checkBox=true));
  parameter Integer othZoneInd[nIze]
    "index of the zone each interzonal element is adjacent to"                                         annotation (
    Dialog(group="Zone borders"));
  parameter Integer zoneInd "index of this zone"       annotation (
    Dialog(group="Zone borders"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ize[nIze] if ATotIze > 0
    "Ambient port for interzonal elements"   annotation (Placement(
        transformation(extent={{205,168},{225,188}}), iconTransformation(extent={{175,170},
            {195,190}})));
  AixLib.ThermalZones.ReducedOrder.RC.BaseClasses.ExteriorWallContainer izeRC[
    nIze](
    final RExt=RIze,
    final RExtRem=RIzeRem,
    final CExt=CIze,
    final pasThr={zoneInd > othZoneInd[i] for i in 1:nIze},
    each final n=nIzeRC,
    each final T_start=T_start) if ATotIze > 0
    "RC-element for interzonal elements"     annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=90,
        origin={102,155})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a izeIntSur[nIze]
    if indPorIze     "Auxiliary port at indoor surface of interzonal elements"
          annotation (Placement(transformation(extent={{124,-190},{144,-170}}),
        iconTransformation(extent={{-50,-190},{-30,-170}})));
protected
  parameter Modelica.Units.SI.Area ATotIze=sum(AIze)
    "Sum of interzonal element areas";
  Modelica.Thermal.HeatTransfer.Components.Convection conIze[nIze]
    if ATotIze > 0 "Convective heat transfer of interzonal elements"
    annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={102,124})));
  Modelica.Blocks.Sources.Constant hConIze_const[nIze](final k=AIze .* hConIze)
    if ATotIze > 0
    "Coefficient of convective heat transfer for interzonal elements"
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={134,124})));

  // connections
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resIzeIze[sum({i
    for i in 1:(nIze - 1)})](final G=BaseClasses.GSurfSurf(AIze, hRad))
    if ATotIze > 0 and nIze > 1
    "Resistor between different interzonal element surfaces"      annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={170,148},
        rotation=-90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resExtWalIze[nIze](
      final G={min(ATotExt, AIze[j])*hRad for j in 1:nIze}, each dT(start=0))
    if ATotExt > 0 and ATotIze > 0
    "Resistor between exterior wall and interzonal element surfaces"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,66},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resWinIze[nIze](
      final G={min(ATotWin, AIze[j])*hRad for j in 1:nIze}, each dT(start=0))
    if ATotIze > 0 and ATotWin > 0
    "Resistor between interzonal element and window surfaces"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={106,66},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resIntIze[nIze](
      final G={min(AInt, AIze[i])*hRad for i in 1:nIze}, each dT(start=0))
    if AInt > 0 and ATotIze > 0
    "Resistor between interior wall and interzonal element surfaces"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={132,66})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resFloIze[nIze](
      final G={min(AIze[i], AFloor)*hRad for i in 1:nIze}, each dT(start=0))
    if ATotIze > 0 and AFloor > 0
    "Resistor between floor plate and interzonal element surfaces"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={158,66})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor resRooIze[nIze](
      final G={min(ARoof, AIze[j])*hRad for j in 1:nIze}, each dT(start=0))
    if ARoof > 0 and ATotIze > 0
    "Resistor between roof and interzonal element surfaces"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={60,168},
        rotation=0)));
equation
  // connect interzonal elements
  if ATotIze > 0 then
    for i in 1:nIze loop
      if AIze[i] > 0 then
        connect(ize[i], izeRC[i].port_b) annotation (Line(points={{215,178},{
                216,178},{216,174},{102,174},{102,165},{103,165}},
                                                           color={191,0,0}));
        connect(conIze[i].solid, izeRC[i].port_a) annotation (Line(points={{102,134},
                {102,140},{102,145},{103,145}},
                                          color={191,0,0}));
        connect(conIze[i].Gc, hConIze_const[i].y) annotation (Line(points={{112,124},
                {70,124},{70,124},{128.5,124}},
                                         color={0,0,127}));
        connect(conIze[i].fluid, senTAir.port) annotation (Line(points={{102,114},
                {102,98},{66,98},{66,0},{80,0}},
                                               color={191,0,0}));
        connect(izeIntSur[i], conIze[i].solid) annotation (Line(points={{134,
                -180},{134,-166},{114,-166},{114,44},{118,44},{118,100},{85,100},
                {85,140},{102,140},{102,134}},
                                 color={191,0,0}));
      end if;
    end for;
    for i in 2:nIze loop
      for j in 1:(i-1) loop
        if AIze[i] > 0 and AIze[j] > 0 then
          if i==2 then
            connect(resIzeIze[1].port_a, conIze[i].solid) annotation (Line(
                  points={{170,158},{170,162},{152,162},{152,140},{102,140},{
                    102,134}},
                  color={191,0,0}));
            connect(resIzeIze[1].port_b, conIze[j].solid) annotation (Line(
                  points={{170,138},{170,134},{152,134},{152,140},{102,140},{
                    102,134}},
                  color={191,0,0}));
          else
            connect(resIzeIze[sum({k for k in 1:(i - 2)}) + j].port_a, conIze[i].solid)
              annotation (Line(points={{170,158},{170,162},{152,162},{152,140},
                    {102,140},{102,134}},
                             color={191,0,0}));
            connect(resIzeIze[sum({k for k in 1:(i - 2)}) + j].port_b, conIze[j].solid)
              annotation (Line(points={{170,138},{170,134},{152,134},{152,140},
                    {102,140},{102,134}},
                             color={191,0,0}));
          end if;
        end if;
      end for;
    end for;
  end if;
  if ATotExt > 0 then
    for j in 1:nIze loop
      if AIze[j] > 0 then
        connect(conIze[j].solid, resExtWalIze[j].port_b) annotation (Line(
              points={{102,134},{102,140},{85,140},{85,88},{80,88},{80,76}},
                                                                      color={191,
                0,0}));
        connect(resExtWalIze[j].port_a, convExtWall.solid) annotation (Line(
              points={{80,56},{80,44},{-62,44},{-62,-16},{-118,-16},{-118,-40},
                {-114,-40}},
                       color={191,0,0}));
      end if;
    end for;
  end if;
  if ATotWin > 0 then
    for j in 1:nIze loop
      if AIze[j] > 0 then
        connect(resWinIze[j].port_b, conIze[j].solid) annotation (Line(points={{106,76},
                {106,88},{85,88},{85,140},{102,140},{102,134}},color={191,0,0}));
        connect(resWinIze[j].port_a, convWin.solid) annotation (Line(points={{106,56},
                {106,52},{60,52},{60,84},{-120,84},{-120,40},{-116,40}},
              color={191,0,0}));
      end if;
    end for;
  end if;
  if AInt > 0 then
    for i in 1:nIze loop
      if AIze[i] > 0 then
        connect(resIntIze[i].port_b, conIze[i].solid) annotation (Line(points={{132,76},
                {132,88},{85,88},{85,140},{102,140},{102,134}},color={191,0,0}));
        connect(resIntIze[i].port_a, convIntWall.solid) annotation (Line(points={{132,56},
                {132,-2},{152,-2},{152,-40},{148,-40}},       color={191,0,0}));
      end if;
    end for;
  end if;
  if AFloor > 0 then
    for i in 1:nIze loop
      if AIze[i] > 0 then
        connect(resFloIze[i].port_b, conIze[i].solid) annotation (Line(points={{158,76},
                {158,88},{85,88},{85,140},{102,140},{102,134}},color={191,0,0}));
        connect(resFloIze[i].port_a, convFloor.solid) annotation (Line(points={{158,56},
                {158,26},{234,26},{234,-150},{26,-150},{26,-136},{-12,-136},{
                -12,-124}},  color={191,0,0}));
      end if;
    end for;
  end if;
  if ARoof > 0 then
    for j in 1:nIze loop
      if AIze[j] > 0 then
        connect(resRooIze[j].port_b, conIze[j].solid) annotation (Line(points={{70,168},
                {72,168},{72,170},{85,170},{85,140},{102,140},{102,134}},color={
                191,0,0}));
        connect(resRooIze[j].port_a, convRoof.solid) annotation (Line(points={{50,168},
                {8,168},{8,136},{-12,136},{-12,130}},  color={191,0,0}));
      end if;
    end for;
  end if;
// internal gains splitter connections
  for i in 1:nIze loop
    connect(thermSplitterIntGains.portOut[end - nIze + i], conIze[i].solid)
      annotation (Line(points={{190,86},{178,86},{178,108},{85,108},{85,140},{
            102,140},{102,134}},
                          color={191,0,0}));
    connect(thermSplitterSolRad.portOut[end - nIze + i], conIze[i].solid)
      annotation (Line(points={{-122,146},{-116,146},{-116,88},{85,88},{85,140},
            {102,140},{102,134}},
                             color={191,0,0}));
  end for;

  annotation (
    defaultComponentName = "theZon",
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-240, -180}, {240, 180}}), graphics={  Polygon(points = {{74, 168}, {188, 168}, {188, 106}, {98, 106}, {96, 106}, {74, 106}, {74, 168}}, lineColor = {0, 0, 255}, smooth = Smooth.None, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Text(extent = {{108, 118}, {146, 104}}, lineColor = {0, 0, 255}, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid, textString = "interzonal elements")}),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-240, -180}, {240, 180}}), graphics={  Rectangle(extent = {{-40, 50}, {28, -44}}, pattern = LinePattern.None, fillColor = {230, 230, 230}, fillPattern = FillPattern.Solid), Text(extent = {{-60, 60}, {64, -64}}, textColor = {0, 0, 0}, textString = "5")}),
    Documentation(revisions = "<html>
 <ul>
 <li>
 April 20, 2023, by Philip Groesdonk:<br/>
 First Implementation. This is for AixLib issue
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1080\">#1080</a>.
 </li>
 </ul>
 </html>", info = "<html>
   <p>
   This model adds another element for interzonal elements modelling heat
   transfer to adjacent zones. These
   elements are not represented in the reduced-order models with less components.
   For each interzonal element, one extra element is produced, which makes
   this model, in fact, be able to have a much higher number of elements (4 for
   the other elements plus the number of zone borders <code>nIze</code>), but the
   elements bordering zones with a lower index in 
   <code>othZoneInd[nIze]</code> than this zone's index <code>zoneInd</code> 
   are ignored here and calculated in the other zone's ROM.
   Ths implementation increases calculation times and calculation complexity -
   also because the interzonal elements are directly connected via heat flow 
   ports to ensure no energy is produced out of or lost to nowhere.
   The interzonal elements are parameterized via the length of the RC-chain
   <code>nIzeRC</code>,
   the vector of capacities <code>CIze[nIze, nIzeRC]</code>, the vector of resistances
   <code>RIze[nIze, nIzeRC]</code> and the remaining resistances <code>RIzeRem[nIze]</code>.
   </p>
   <p>
   The image below shows the RC-network of this model. In the image, dashed 
   lines represent the possibly multiple interzonal elements (= array 
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
