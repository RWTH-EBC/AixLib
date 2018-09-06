﻿within AixLib.Building.Components.Weather.Sunblinds.BaseClasses;
partial model PartialSunblind "A Base Class for Sunblindes"

  parameter Integer n=4
    "Size of solar vector (orientations)";
  parameter Modelica.SIunits.TransmissionCoefficient gsunblind[n](each min=0.0,
    each max=1.0) = {1,1,1,1}
    "Total energy transmittances if sunblind is closed";
  parameter Modelica.SIunits.RadiantEnergyFluenceRate Imax
    "Intensity at which the sunblind closes (see also TOutAirLimit)";

  Utilities.Interfaces.SolarRad_in
                                 Rad_In[n]
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput sunblindonoff[n] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={8,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-90})));
  Utilities.Interfaces.SolarRad_out
                                  Rad_Out[n]
    annotation (Placement(transformation(extent={{80,0},{100,20}})));

initial equation
  assert(n==size(gsunblind,1),"gsunblind has to have n elements");

end PartialSunblind;
