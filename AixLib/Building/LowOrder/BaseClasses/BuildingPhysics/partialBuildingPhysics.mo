within AixLib.Building.LowOrder.BaseClasses.BuildingPhysics;
partial model partialBuildingPhysics
  "partial model for building physics (windows and walls)"
  parameter Modelica.SIunits.Area AWin[n] "Area of the windows" annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.TransmissionCoefficient gsunblind[n]
    "Total energy transmittances if sunblind is closed" annotation(Dialog(tab = "Windows", group = "Shading", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.RadiantEnergyFluenceRate Imax
    "Intensity at which the sunblind closes" annotation(Dialog(tab = "Windows", group = "Shading", enable = if withWindows and withOuterwalls then true else false));
  parameter Integer n = 5 "Number of orientations (without ground)" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer UWin
    "Thermal transmission coefficient of windows" annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  SolarRadWeightedSum solRadWeightedSum(n=n, weightfactors=AWin)
    "Aggregates solar radiation through windows" annotation (Placement(transformation(extent={{6,56},{
            34,86}})));
  Components.Weather.Sunblinds.Sunblind sunblind(
    Imax=Imax,
    n=n,
    gsunblind=gsunblind) "Sunblind model" annotation (Placement(transformation(extent={{-50,59},{-30,79}})));
  Utilities.Interfaces.SolarRad_in solarRad_in[n] "Solar radiation"  annotation(Placement(transformation(extent={{-108,60},
            {-88,80}}),                                                                                                    iconTransformation(extent={{-122,50},
            {-88,80}})));
  Modelica.Blocks.Interfaces.RealInput weather[3]
    "Weather Input Vector [1]: Air Temperature [2]: Sky Radiation [3]: Terrestrial Radiation"
  annotation(Placement(transformation(extent = {{-120, -10}, {-80, 30}}), iconTransformation(extent={{-116,4},
            {-86,34}})));
  Modelica.Blocks.Interfaces.RealInput ventilationRate(
  final quantity="VolumeFlowRate",
  final unit="1/h") "Ventilation and infiltration rate"  annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-28, -90}), iconTransformation(extent = {{-14, -14}, {14, 14}}, rotation = 90, origin = {-40, -86})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv
    "Convective internal gains" annotation(Placement(transformation(extent = {{30, -100}, {50, -80}}), iconTransformation(extent = {{30, -100}, {50, -80}})));
  Utilities.Interfaces.Star internalGainsRad "Radiative internal gains"  annotation(Placement(transformation(extent = {{70, -100}, {90, -80}}), iconTransformation(extent = {{70, -100}, {90, -80}})));
  Modelica.Blocks.Interfaces.RealInput ventilationTemperature(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Ventilation and infiltration temperature" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, origin = {-100, -50}), iconTransformation(extent = {{-15, -15}, {15, 15}}, origin={-98,-40})));
  SolarRadAdapter solarRadAdapter[n] "Converts solar radiation in real"  annotation (Placement(transformation(extent={{-74,28},{-54,48}})));
  replaceable
    AixLib.Building.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorG_VDI6007
    corG(n=n, Uw=UWin) constrainedby
    Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
    "G-value dependent on angles"
    annotation (Placement(transformation(extent={{-24,60},{-4,80}})),choicesAllMatching=true);
equation
  connect(solarRad_in, sunblind.Rad_In) annotation(Line(points={{-98,70},{-49,70}},                            color = {255, 128, 0}));
  connect(solarRadAdapter.solarRad_in, solarRad_in) annotation (Line(
      points={{-73,38},{-76,38},{-76,70},{-98,70}},
      color={255,128,0}));
  connect(sunblind.Rad_Out, corG.SR_input) annotation (Line(
      points={{-31,70},{-28,70},{-28,69.9},{-23.8,69.9}},
      color={255,128,0}));
  connect(corG.solarRadWinTrans, solRadWeightedSum.solarRad_in)
    annotation (Line(
      points={{-5,70},{0,70},{0,71},{7.4,71}},
      color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}},
        grid={2,2}),
         graphics={
        Text(
          extent={{-62,114},{84,74}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={236,99,92},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Rectangle(
          extent={{-88,-80},{100,80}},
          lineColor={95,95,95},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-66,56},{76,-56}},
          lineColor={135,135,135},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Rectangle(
         extent={{-48,22},{-10,-10}},
         lineColor={0,0,0},
         fillColor={255,255,255},
         fillPattern=FillPattern.Solid),
        Line(
          points={{-10,6},{8,6},{72,6}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{32,6},{32,-30}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{8,-30},{60,-30}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{14,-44},{54,-44}},
          color={0,0,0},
          smooth=Smooth.None)}),                                                                                     experiment(StopTime = 864000, Interval = 3599),Documentation(info="<html>
<p>This is a partial model for building physics based on the Guideline VDI 6007. It defines all conncetors and the handling of solar radiation.</p>
</html>",  revisions = "<html>
 <ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul>
 </html>"));
end partialBuildingPhysics;
