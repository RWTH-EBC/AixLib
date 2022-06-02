within AixLib.ThermalZones.HighOrder.Rooms.BaseClasses;
partial model PartialRoomParams "Partial model with base parameters that are necessary for all HOM rooms and for building propagation"

  // Air volume of room
  parameter Modelica.SIunits.Density denAir=1.19 "Density of air" annotation (Dialog(group="Air volume of room"));
  parameter Modelica.SIunits.SpecificHeatCapacity cAir=1007 "Specific heat capacity of air" annotation (Dialog(group="Air volume of room"));

  parameter Boolean use_UFH = false "If underfloor heating, conductive wall layers in floor and ceiling are disabled" annotation(Dialog(group = "Structure of wall layers"));
  replaceable parameter AixLib.DataBase.Walls.Collections.BaseDataMultiWalls
    wallTypes constrainedby
    AixLib.DataBase.Walls.Collections.BaseDataMultiWalls
    "Types of walls (contains multiple records)"
    annotation(Dialog(group = "Structure of wall layers"), choicesAllMatching = true, Placement(transformation(extent={{-8,82},{8,98}})));

  parameter Modelica.Fluid.Types.Dynamics energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance for wall capacities: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics"));
  parameter Modelica.SIunits.Temperature T0_air=295.11 "Air"
    annotation (Dialog(tab="Initialization", group="Air volume of room"));
  parameter Modelica.SIunits.Temperature TWalls_start=Modelica.SIunits.Conversions.from_degC(16) "Initial temperature of all walls"
    annotation(Dialog(tab="Initialization", group="Walls"));

  //// Inner / Interior wall parameters
  // Heat convection
  parameter Integer calcMethodIn=1
    "Calculation method of convective heat transfer coefficient at inside surface"
    annotation (Dialog(
      tab="Inner walls",
      group="Heat convection",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
      choice=2 "By Bernd Glueck",
      choice=3 "Custom hCon (constant)",
      choice=4 "ASHRAE140-2017",
      radioButtons=true));

  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConIn_const=2.5
    "Custom convective heat transfer coefficient (just for manual selection, not recommended)"
    annotation(Dialog(tab="Inner walls", group="Heat convection", enable=(calcMethodIn==3)));

  parameter Integer radLongCalcMethod=1 "Calculation method for longwave radiation heat transfer"
    annotation (
    Evaluate=true,
    Dialog(tab="Inner walls", group="Longwave radiation",   compact=true),
    choices(
      choice=1 "No approx",
      choice=2 "Linear approx at wall temp",
      choice=3 "Linear approx at rad temp",
      choice=4 "Linear approx at constant T_ref",
      radioButtons=true));
  parameter Modelica.SIunits.Temperature T_ref=Modelica.SIunits.Conversions.from_degC(16) "Reference temperature for optional linearization of longwave radiation"
    annotation (Dialog(tab="Inner walls", group = "Longwave radiation", enable=radLongCalcMethod == 4));

  //// Outer / Exterior wall parameters
  //Window type

  replaceable model WindowModel =
      AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow
    constrainedby
    AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.PartialWindow               annotation (Dialog(tab="Outer walls", group="Windows"), choicesAllMatching = true);
  replaceable parameter DataBase.WindowsDoors.Simple.OWBaseDataDefinition_Simple Type_Win "Window parametrization" annotation (Dialog(tab="Outer walls", group="Windows"), choicesAllMatching = true);
  replaceable model CorrSolarGainWin =
      AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG
    constrainedby
    AixLib.ThermalZones.HighOrder.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.PartialCorG               "Correction model for solar irradiance as transmitted radiation" annotation (choicesAllMatching=true, Dialog(tab="Outer walls", group="Windows", enable = withWindow and outside));

  // Solar absorptance
  parameter Real solar_absorptance_OW(min=0, max=1)=0.6 "Solar absoptance outer walls "
    annotation (Dialog(tab="Outer walls", group="Solar absorptance", descriptionLabel=true));
  // Heat convection
  parameter Integer calcMethodOut=1 "Calculation method for convective heat transfer coefficient"
                                                                                               annotation (Dialog(
      tab="Outer walls",
      group="Heat convection",
      compact=true,
      descriptionLabel=true), choices(
      choice=1 "DIN 6946",
      choice=2 "ASHRAE Fundamentals",
      choice=3 "Custom hCon (constant)",
      radioButtons=true));
  replaceable parameter DataBase.Surfaces.RoughnessForHT.PolynomialCoefficients_ASHRAEHandbook surfaceType=DataBase.Surfaces.RoughnessForHT.Brick_RoughPlaster() "Surface type of outside wall" annotation (Dialog(tab="Outer walls", group="Heat convection", enable=(calcMethodOut == 2)));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hConOut_const=25 "Custom convective heat transfer coefficient (just for manual selection, not recommended)" annotation (Dialog(tab="Outer walls", group="Heat convection", enable=(calcMethodOut == 3)));
  // Sunblind
  parameter Boolean use_sunblind = false
    "Will sunblind become active automatically?"
    annotation(Dialog(tab="Outer walls", group = "Sunblind"));
  parameter Real ratioSunblind(min=0.0, max=1.0) = 0.8
    "Sunblind factor. 1 means total blocking of irradiation, 0 no sunblind"
    annotation(Dialog(tab="Outer walls", group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Irradiance solIrrThreshold(min=0.0) = 350
    "Threshold for global solar irradiation on this surface to enable sunblinding (see also TOutAirLimit)"
    annotation(Dialog(tab="Outer walls", group = "Sunblind", enable=use_sunblind));
  parameter Modelica.SIunits.Temperature TOutAirLimit = 293.15
    "Temperature at which sunblind closes (see also solIrrThreshold)"
    annotation(Dialog(tab="Outer walls", group = "Sunblind", enable=use_sunblind));

  // Infiltration rate (building airtightness) according to (DIN) EN 12831-1 (2017-07)
  parameter Boolean use_infiltEN12831=false "Use model to exchange room air with outdoor air acc. to standard"
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (airtightness)"));
  parameter Real n50(unit="1/h") = 4 "Air exchange rate at 50 Pa pressure difference"
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (airtightness)", enable=use_infiltEN12831));
  parameter Real e=0.03 "Coefficient of windshield"
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (airtightness)", enable=use_infiltEN12831));
  parameter Real eps=1.0 "Coefficient of height"
    annotation (Dialog(tab="Infiltration acc. to EN 12831 (airtightness)", enable=use_infiltEN12831));

  // Dynamic Ventilation
  parameter Boolean withDynamicVentilation=false "Dynamic ventilation"
    annotation (Dialog(tab="Dynamic ventilation", descriptionLabel=true),
      choices(checkBox=true));
  parameter Modelica.SIunits.Temperature HeatingLimit=288.15
    "Outside temperature at which the heating activates" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Real Max_VR=10 "Maximal ventilation rate" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.TemperatureDifference Diff_toTempset=2
    "Difference to set temperature" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));
  parameter Modelica.SIunits.Temperature Tset=295.15 "Tset" annotation (Dialog(
      tab="Dynamic ventilation",
      descriptionLabel=true,
      enable=if withDynamicVentilation then true else false));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside
    annotation (Placement(transformation(extent={{-110,90},{-90,110}}), iconTransformation(extent={{-110,88},{-90,108}})));

    annotation (Dialog(tab="Infiltration acc. to EN 12831 (building airtightness"),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>January 9, 2020 by Philipp Mehrfeld:<br/>
    Model added to the AixLib library.
  </li>
</ul>
</html>"));
end PartialRoomParams;
