within AixLib.Building.LowOrder.BaseClasses.BuildingPhysics;
model BuildingPhysicsVDI "Building physics according to VDI 6007"
  extends partialBuildingPhysics;
  parameter Boolean withInnerwalls = true "If inner walls are existent" annotation(Dialog(tab = "Inner walls"));
  parameter Modelica.SIunits.ThermalResistance R1i "Resistor 1 inner wall" annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.HeatCapacity C1i "Capacity 1 inner wall" annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Area Ai "Inner wall area" annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Temp_K T0all
    "Initial temperature for all components";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi
    "Coefficient of heat transfer for inner walls" annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Boolean withOuterwalls = true
    "If outer walls (including windows) are existent" annotation(Dialog(tab = "Outer walls"));
  parameter Modelica.SIunits.ThermalResistance RRest "Resistor Rest outer wall"
                                annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.ThermalResistance R1o "Resistor 1 outer wall" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.HeatCapacity C1o "Capacity 1 outer wall" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Area Ao "Outer wall area" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi
    "Outer wall's coefficient of heat transfer (inner side)" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowo
    "Outer wall's coefficient of heat transfer (outer side)" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Emissivity epsi "Emissivity of the inner walls"
                                    annotation(Dialog(tab = "Inner walls", enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Emissivity epso "Emissivity of the outer walls"
                                    annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Emissivity aowo
    "Coefficient of absorption of the outer walls" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Boolean withWindows = true "If windows are existent" annotation(Dialog(tab = "Windows", enable = if withOuterwalls then true else false));
  parameter Real splitfac "Factor for conv. part of rad. through windows" annotation(Dialog(tab = "Windows", enable = if withOuterwalls then true else false));
  parameter Real weightfactorswall[n] "Weight factors of the walls" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Real weightfactorswindow[n] "Weight factors of the windows" annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Real weightfactorground
    "Weight factor of the earth (0 if not considered)" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Temp_K temperatureground
    "Temperature of the earth" annotation(Dialog(tab = "Outer walls", enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Emissivity epsw "Emissivity of the windows" annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.TransmissionCoefficient g
    "Total energy transmittance" annotation(Dialog(tab = "Windows", enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.Volume Vair "Volume of the air in the zone" annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.Density rhoair "Density of the air" annotation(Dialog(tab = "Room air"));
  parameter Modelica.SIunits.SpecificHeatCapacity cair
    "Heat capacity of the air" annotation(Dialog(tab = "Room air"));
  EqAirTemp.EqAirTempSimple eqAirTemp(
    alphaowo=alphaowo,
    aowo=aowo,
    wf_wall=weightfactorswall,
    wf_win=weightfactorswindow,
    wf_ground=weightfactorground,
    T_ground=temperatureground,
    n=n) if                                                                                                     withOuterwalls
    "Equivalent air temperature"
    annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
  ReducedOrderModel.ReducedOrderModelStar reducedOrderModel(
    epsw=epsw,
    g=g,
    RRest=RRest,
    R1o=R1o,
    C1o=C1o,
    Ao=Ao,
    R1i=R1i,
    C1i=C1i,
    Ai=Ai,
    T0all=T0all,
    Vair=Vair,
    alphaiwi=alphaiwi,
    alphaowi=alphaowi,
    rhoair=rhoair,
    cair=cair,
    epsi=epsi,
    epso=epso,
    withInnerwalls=withInnerwalls,
    withOuterwalls=withOuterwalls,
    splitfac=splitfac,
    Aw=sum(AWin),
    withWindows=true) "ROM"
    annotation (Placement(transformation(extent={{18,-10},{76,46}})));

equation
  if withOuterwalls then
    connect(eqAirTemp.equalAirTemp, reducedOrderModel.equalAirTemp) annotation(Line(points={{-26.2,
            4.4},{-2,4.4},{-2,19.12},{23.8,19.12}},                                                                                             color = {191, 0, 0}));
  end if;
  connect(solarRadAdapter.solarRad_out, eqAirTemp.solarRad_in) annotation (Line(
        points={{-54,38},{-52,38},{-52,36},{-52,15.6},{-44.5,15.6}}, color={0,0,
          127}));
  connect(sunblind.sunblindonoff, eqAirTemp.sunblindsig) annotation (Line(
        points={{-40,60},{-40,60},{-40,26},{-36,26},{-36,18}}, color={0,0,127}));
  connect(weather, eqAirTemp.weatherData)
    annotation (Line(points={{-100,10},{-44,10}},          color={0,0,127}));
  connect(ventilationTemperature, reducedOrderModel.ventilationTemperature)
    annotation (Line(points={{-100,-50},{-46,-50},{8,-50},{8,4.56},{23.8,4.56}},
        color={0,0,127}));
  connect(ventilationRate, reducedOrderModel.ventilationRate) annotation (Line(
        points={{-28,-90},{-28,-90},{-28,-64},{35.98,-64},{35.98,-7.2}}, color={
          0,0,127}));
  connect(internalGainsConv, reducedOrderModel.internalGainsConv) annotation (
      Line(points={{40,-90},{46,-90},{46,-70},{52.8,-70},{52.8,-7.2}}, color={191,
          0,0}));
  connect(internalGainsRad, reducedOrderModel.internalGainsRad) annotation (
      Line(points={{80,-90},{82,-90},{82,-40},{82,-36},{68.75,-36},{68.75,-7.2}},
        color={95,95,95}));
  connect(solRadWeightedSum.solarRad_out, reducedOrderModel.solarRad_in)
    annotation (Line(points={{32.6,71},{33.66,71},{33.66,44.32}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>This model connects <a href=\"AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel\">ReducedOrderModel</a> with <a href=\"AixLib.Building.Components.Weather.Sunblinds\">Sunblind</a> and <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>. All this models have been developed in the context of the Guideline VDI 6007 to have the whole VDI 6007 in Modelica. ThermalZonePhysics reflects all components described in the guideline</p>
<p><br><b>References</b> </p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
</html>",  revisions = "<html>
 <ul>
 <li><i>January 2012,&nbsp;</i> by Moritz Lauster:<br/>Implemented.</li>
 </ul>
 </html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end BuildingPhysicsVDI;
