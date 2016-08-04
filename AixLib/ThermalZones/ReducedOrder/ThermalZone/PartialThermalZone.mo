within AixLib.ThermalZones.ReducedOrder.ThermalZone;
partial model PartialThermalZone
  "Partial for ready-to-use reduced order building model"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;
  parameter DataBase.Buildings.ZoneBaseRecordNew zoneParam
    "choose setup for this zone" annotation(choicesAllMatching = true);
  parameter Integer nPorts=0 "Number of fluid ports"
    annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));
protected
  parameter Real ATot = sum(zoneParam.AExt)+sum(zoneParam.AWin)+zoneParam.AInt+zoneParam.ARoof+zoneParam.AFloor;
public
  Modelica.Blocks.Interfaces.RealInput ventRate(final quantity="VolumeFlowRate",
      final unit="1/h") "Ventilation and infiltration rate" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-100}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-40,-60})));
  Modelica.Blocks.Interfaces.RealInput intGains[3]
    "Input profiles for internal gains persons, machines, light" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={80,-100}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={80,-60})));
  Modelica.Blocks.Interfaces.RealInput ventTemp(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Ventilation and infiltration temperature" annotation (Placement(
        transformation(extent={{-120,-60},{-80,-20}}), iconTransformation(
          extent={{-88,-52},{-62,-26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv if ATot > 0 or zoneParam.VAir > 0
    "Convective internal gains" annotation (Placement(transformation(extent={{90,
            -42},{110,-22}}), iconTransformation(extent={{90,-42},{110,-22}})));
  RC.FourElements ROM(nPorts=nPorts, redeclare package Medium =
        Modelica.Media.Air.SimpleAir,
    VAir=zoneParam.VAir,
    alphaRad=zoneParam.alphaRad,
    nOrientations=zoneParam.nOrientations,
    AWin=zoneParam.AWin,
    ATransparent=zoneParam.ATransparent,
    alphaWin=zoneParam.alphaWin,
    RWin=zoneParam.RWin,
    gWin=zoneParam.gWin,
    ratioWinConRad=zoneParam.ratioWinConRad,
    AExt=zoneParam.AExt,
    alphaExt=zoneParam.alphaExt,
    nExt=zoneParam.nExt,
    RExt=zoneParam.RExt,
    RExtRem=zoneParam.RExtRem,
    CExt=zoneParam.CExt,
    AInt=zoneParam.AInt,
    alphaInt=zoneParam.alphaInt,
    nInt=zoneParam.nInt,
    RInt=zoneParam.RInt,
    CInt=zoneParam.CInt,
    AFloor=zoneParam.AFloor,
    alphaFloor=zoneParam.alphaFloor,
    nFloor=zoneParam.nFloor,
    RFloor=zoneParam.RFloor,
    RFloorRem=zoneParam.RFloorRem,
    CFloor=zoneParam.CFloor,
    ARoof=zoneParam.ARoof,
    alphaRoof=zoneParam.alphaRoof,
    nRoof=zoneParam.nRoof,
    RRoof=zoneParam.RRoof,
    RRoofRem=zoneParam.RRoofRem,
    CRoof=zoneParam.CRoof,
    T_start=zoneParam.T_start)
    annotation (Placement(transformation(extent={{38,28},{86,64}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts](
    redeclare package Medium = Medium)
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (
    Placement(transformation(
    extent={{-45,-12},{45,12}},
    origin={17,-94}), iconTransformation(
    extent={{-30.5,-8},{30.5,8}},
    origin={150,-171.5})));
  Modelica.Blocks.Interfaces.RealOutput TAir if ATot > 0 or zoneParam.VAir > 0 "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,46},{120,66}}),
        iconTransformation(extent={{100,46},{120,66}})));
  Modelica.Blocks.Interfaces.RealOutput TRad if ATot > 0
    "Mean indoor radiation temperature" annotation (Placement(transformation(
          extent={{100,18},{120,38}}), iconTransformation(extent={{100,18},{120,
            38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad if ATot > 0
    "Convective internal gains" annotation (Placement(transformation(extent={{90,
            -8},{110,12}}), iconTransformation(extent={{90,-10},{110,10}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(
    transformation(extent={{-117,18},{-83,50}}), iconTransformation(
    extent={{-70,-12},{-50,8}})));
equation
  connect(ROM.TAir, TAir) annotation (Line(points={{87,62},{98,62},{98,56},{110,
          56}}, color={0,0,127}));
  connect(ROM.ports, ports) annotation (Line(points={{77,28.85},{77,-2},{48,-2},
          {48,-44},{17,-44},{17,-72},{17,-94}}, color={0,127,255}));
  connect(ROM.intGainsConv, intGainsConv) annotation (Line(points={{86,50},{92,50},
          {92,-32},{100,-32}}, color={191,0,0}));
  connect(ROM.TRad, TRad) annotation (Line(points={{87,58},{96,58},{96,40},{96,28},
          {110,28}}, color={0,0,127}));
  connect(TRad, TRad)
    annotation (Line(points={{110,28},{110,28}}, color={0,0,127}));
  connect(ROM.intGainsRad, intGainsRad) annotation (Line(points={{86.2,54},{94,54},
          {94,2},{100,2}}, color={191,0,0}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false,  extent={{-100,-100},
            {100,100}}),                                                                                                    graphics={                                Text(extent = {{-90, 134}, {98, 76}}, lineColor=
              {0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-60,-48},{90,66}},
          lineColor={95,95,95},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-28,30},{2,-6}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,30},{60,-6}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-32,30},{6,34}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{26,30},{64,34}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),                                                       Documentation(info="<html>
<p>Partial for thermal zone models. It defines connectors and a replaceable <a href=\"AixLib.Building.LowOrder.BaseClasses.BuildingPhysics\">buildingPhysics</a> model.</p>
<h4>Limitation</h4>
<p>All parameters are collected in one record. This record supports all different <span style=\"font-family: MS Shell Dlg 2;\"><a href=\"AixLib.Building.LowOrder.BaseClasses.BuildingPhysics\">buildingPhysics</a> models (the largest parameter set of all models defines the record) . This means that using a <a href=\"AixLib.Building.LowOrder.BaseClasses.BuildingPhysics\">buildingPhysics</a> model variant 1 is possible with a parameter set defined for variant 2. The user should check that the cominbation of model and parameter set is meaningful.</span></p>
</html>",  revisions = "<html>
 <ul>
   <li><i>March, 2012&nbsp;</i>
          by Moritz Lauster:<br/>
          Implemented</li>
 </ul>
 </html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end PartialThermalZone;
