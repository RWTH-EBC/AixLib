within AixLib.ThermalZones.HighOrder.Components.Sunblinds.BaseClasses;
partial model PartialSunblind "A Base Class for Sunblindes"

  parameter Integer n=4
    "Size of solar vector (orientations)";
  parameter Modelica.Units.SI.TransmissionCoefficient gsunblind[n](
    each min=0.0,
    each max=1.0) = {1,1,1,1}
    "Total energy transmittances if sunblind is closed";
  parameter Modelica.Units.SI.RadiantEnergyFluenceRate Imax
    "Intensity at which the sunblind closes (see also TOutAirLimit)";

  Utilities.Interfaces.SolarRad_in
                                 Rad_In[n]
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput sunblindonoff[n] annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-90}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-90})));
  Utilities.Interfaces.SolarRad_out
                                  Rad_Out[n]
    annotation (Placement(transformation(extent={{80,0},{100,20}})));

initial equation
  assert(n==size(gsunblind,1),"gsunblind has to have n elements");

  annotation (Diagram(coordinateSystem(extent={{-80,-80},{80,80}})), Icon(coordinateSystem(extent={{-80,-80},{80,80}})));
end PartialSunblind;
