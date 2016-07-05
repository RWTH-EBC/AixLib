within AixLib.Building.LowOrder.ThermalZone;
partial model PartialThermalZone
  "Partial for ready-to-use reduced order building model"
  parameter DataBase.Buildings.ZoneBaseRecord zoneParam
    "choose setup for this zone" annotation(choicesAllMatching = true);
  Modelica.Blocks.Interfaces.RealInput ventilationRate(
  final quantity="VolumeFlowRate",
  final unit="1/h") "Ventilation and infiltration rate" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-100}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-40,-60})));
  Modelica.Blocks.Interfaces.RealInput weather[3] if zoneParam.withOuterwalls
    "[1]: Air temperature [2]: Horizontal radiation of sky [3]: Horizontal radiation of earth"
    annotation(Placement(transformation(extent = {{-120, 0}, {-80, 40}}), iconTransformation(extent = {{-86, -12}, {-62, 12}})));
  Utilities.Interfaces.SolarRad_in solarRad_in[zoneParam.n] if zoneParam.withOuterwalls
    "Solar radiation"                                                                                     annotation(Placement(transformation(extent = {{-100, 70}, {-80, 90}}), iconTransformation(extent={{-100,26},
            {-60,66}})));
  Modelica.Blocks.Interfaces.RealInput internalGains[3]
    "Input profiles for internal gains persons, machines, light" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {80, -100}), iconTransformation(extent = {{-12, -12}, {12, 12}}, rotation = 90, origin={80,-60})));
  replaceable BaseClasses.BuildingPhysics.BuildingPhysics buildingPhysics constrainedby
    AixLib.Building.LowOrder.BaseClasses.BuildingPhysics.PartialBuildingPhysics(
    RRest=zoneParam.RRest,
    R1o=zoneParam.R1o,
    C1o=zoneParam.C1o,
    Ao=zoneParam.Ao,
    T0all=zoneParam.T0all,
    alphaowi=zoneParam.alphaowi,
    alphaowo=zoneParam.alphaowo,
    epso=zoneParam.epso,
    R1i=zoneParam.R1i,
    C1i=zoneParam.C1i,
    Ai=zoneParam.Ai,
    Vair=zoneParam.Vair,
    alphaiwi=zoneParam.alphaiwi,
    rhoair=zoneParam.rhoair,
    cair=zoneParam.cair,
    epsi=zoneParam.epsi,
    aowo=zoneParam.aowo,
    epsw=zoneParam.epsw,
    g=zoneParam.g,
    Imax=zoneParam.Imax,
    n=zoneParam.n,
    weightfactorswall=zoneParam.weightfactorswall,
    weightfactorswindow=zoneParam.weightfactorswindow,
    weightfactorground=zoneParam.weightfactorground,
    temperatureground=zoneParam.temperatureground,
    AWin=zoneParam.Aw,
    UWin=zoneParam.UWin,
    gsunblind=zoneParam.gsunblind,
    withInnerwalls=zoneParam.withInnerwalls,
    withWindows=zoneParam.withWindows,
    withOuterwalls=zoneParam.withOuterwalls,
    splitfac=zoneParam.splitfac,
    RWin=zoneParam.RWin,
    alphaConvWinInner=zoneParam.alphaConvWinInner,
    alphaConvWinOuter=zoneParam.alphaConvWinOuter,
    awin=zoneParam.awin,
    orientationswallshorizontal=zoneParam.orientationswallshorizontal)
    "Building physics"  annotation (Placement(transformation(extent={{-20,0},{20,40}})),
      choicesAllMatching=true);
public
  Modelica.Blocks.Interfaces.RealInput ventilationTemperature(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Ventilation and infiltration temperature" annotation (
      Placement(transformation(extent={{-120,-60},{-80,-20}}),
        iconTransformation(extent={{-88,-52},{-62,-26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv
    "Convective internal gains"                                                                     annotation(Placement(transformation(extent={{-10,-68},
            {10,-48}}),                                                                                                    iconTransformation(extent={{-10,-68},
            {10,-48}})));
  Utilities.Interfaces.Star internalGainsRad "Radiative internal gains" annotation(Placement(transformation(extent={{30,-68},
            {50,-48}}), iconTransformation(extent={{30,-68},{50,-48}})));
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
